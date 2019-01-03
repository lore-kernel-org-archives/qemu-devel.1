Received: from eggs.gnu.org ([208.118.235.92]:51531)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1geuYZ-0001kh-7k
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:24:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1geuYX-0002QV-Kg
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:24:31 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:43721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1geuYX-0002HC-8U
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 23:24:29 -0500
Received: by mail-io1-xd43.google.com with SMTP id b23so5231459ios.10
	for <qemu-devel@nongnu.org>; Wed, 02 Jan 2019 20:24:21 -0800 (PST)
MIME-Version: 1.0
References: <20181215120353.82786-1-liq3ea@163.com>
	<20181215120353.82786-2-liq3ea@163.com>
	<96f02ace-df12-4788-bc03-336bf610898c@redhat.com>
In-Reply-To: <96f02ace-df12-4788-bc03-336bf610898c@redhat.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 3 Jan 2019 12:23:45 +0800
Message-ID: <CAKXe6SJG+iQVLbMBu8+5BB2857_7+6F_tBQMZG5Hj0dV2bpshg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] tests: vhost-user-test: initialize
 'fd' in chr_read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, mst@redhat.com, Peter Maydell <peter.maydell@linaro.org>, marcandre lureau <marcandre.lureau@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>

Thomas Huth <thuth@redhat.com> =E4=BA=8E2019=E5=B9=B41=E6=9C=882=E6=97=A5=
=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=889:50=E5=86=99=E9=81=93=EF=BC=9A

> On 2018-12-15 13:03, Li Qiang wrote:
> > Currently when processing VHOST_USER_SET_VRING_CALL
> > if 'qemu_chr_fe_get_msgfds' get no fd, the 'fd' will
> > be a stack uninitialized value.
> >
> > Signed-off-by: Li Qiang <liq3ea@163.com>
> > ---
> >  tests/vhost-user-test.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/tests/vhost-user-test.c b/tests/vhost-user-test.c
> > index 45d58d8ea2..86039e61e0 100644
> > --- a/tests/vhost-user-test.c
> > +++ b/tests/vhost-user-test.c
> > @@ -309,7 +309,7 @@ static void chr_read(void *opaque, const uint8_t
> *buf, int size)
> >      CharBackend *chr =3D &s->chr;
> >      VhostUserMsg msg;
> >      uint8_t *p =3D (uint8_t *) &msg;
> > -    int fd;
> > +    int fd =3D -1;
> >
> >      if (s->test_fail) {
> >          qemu_chr_fe_disconnect(chr);
> >
>
> Shouldn't we also rather check the return code of
> qemu_chr_fe_get_msgfds() ?


Agree, there are several places need to do this. I will send out a patch
later.

Thanks,
Li Qiang


> Anyway, initializing fd to -1 here sounds
> like a good idea, so:
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
>
