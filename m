Received: from eggs.gnu.org ([208.118.235.92]:34366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gehve-0003tB-RH
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gehva-00041y-Jz
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:55:30 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gehva-00041V-Em
	for qemu-devel@nongnu.org; Wed, 02 Jan 2019 09:55:26 -0500
Date: Wed, 2 Jan 2019 09:55:17 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190102095505-mutt-send-email-mst@kernel.org>
References: <20181215120353.82786-1-liq3ea@163.com>
	<20181215120353.82786-2-liq3ea@163.com>
	<96f02ace-df12-4788-bc03-336bf610898c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96f02ace-df12-4788-bc03-336bf610898c@redhat.com>
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
Cc: Li Qiang <liq3ea@163.com>, lvivier@redhat.com, pbonzini@redhat.com, peter.maydell@linaro.org, marcandre.lureau@redhat.com, berrange@redhat.com, jasowang@redhat.com, liq3ea@gmail.com, qemu-devel@nongnu.org

On Wed, Jan 02, 2019 at 02:50:50PM +0100, Thomas Huth wrote:
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
> > @@ -309,7 +309,7 @@ static void chr_read(void *opaque, const uint8_t *buf, int size)
> >      CharBackend *chr = &s->chr;
> >      VhostUserMsg msg;
> >      uint8_t *p = (uint8_t *) &msg;
> > -    int fd;
> > +    int fd = -1;
> >  
> >      if (s->test_fail) {
> >          qemu_chr_fe_disconnect(chr);
> > 
> 
> Shouldn't we also rather check the return code of
> qemu_chr_fe_get_msgfds() ? Anyway, initializing fd to -1 here sounds
> like a good idea, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
