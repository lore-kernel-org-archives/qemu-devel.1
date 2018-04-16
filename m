Received: from eggs.gnu.org ([2001:4830:134:3::10]:33922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f88rz-0002z8-3X
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:28:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f88ry-0002VH-4a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:28:51 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:39732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f88rx-0002Uv-VV
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 14:28:50 -0400
Received: by mail-oi0-x242.google.com with SMTP id n65-v6so2259922oig.6
	for <qemu-devel@nongnu.org>; Mon, 16 Apr 2018 11:28:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180416181844.7851-1-marcandre.lureau@redhat.com>
References: <20180416181844.7851-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Apr 2018 19:28:28 +0100
Message-ID: <CAFEAcA8sX8e9VHdOjhV9VabuVKW=HKiF-bHz3XhCEkRNEyjnDQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] mux: fix ctrl-a b again
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-stable <qemu-stable@nongnu.org>

On 16 April 2018 at 19:18, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> Commit fb5e19d2e1472e96d72d5e4d89c20033f8ab345c originally fixed the
> regression, but was inadvertently broken again in merge commit
> 2d6752d38d8acda.
>
> Fixes:
> https://bugs.launchpad.net/qemu/+bug/1654137
>
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  chardev/char-mux.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/chardev/char-mux.c b/chardev/char-mux.c
> index 1b925c8dec..6055e76293 100644
> --- a/chardev/char-mux.c
> +++ b/chardev/char-mux.c
> @@ -304,6 +304,7 @@ void mux_set_focus(Chardev *chr, int focus)
>      }
>
>      d->focus =3D focus;
> +    chr->be =3D d->backends[focus];
>      mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_IN);
>  }
>
> --
> 2.17.0.rc1.36.gcedb63ea2f

Opinions welcome on whether this is a regression fix worth
putting into rc4.

thanks
-- PMM
