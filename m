Received: from eggs.gnu.org ([2001:4830:134:3::10]:51527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGMw-00042q-2Q
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dIGMu-00089Z-TQ
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:05 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34387)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dIGMu-00089G-Le
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:26:04 -0400
Received: by mail-wr0-x22e.google.com with SMTP id g76so55816471wrd.1
	for <qemu-devel@nongnu.org>; Tue, 06 Jun 2017 08:26:04 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170606151919.772-1-pbonzini@redhat.com>
References: <20170606151919.772-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Jun 2017 16:25:42 +0100
Message-ID: <CAFEAcA-ZHmWeJ_a7seQ6OxcssVYZ1UEUe9Y6LtYu54PFGEEL7g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] qemu-doc: include version number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On 6 June 2017 at 16:19, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  qemu-doc.texi | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/qemu-doc.texi b/qemu-doc.texi
> index 965ba5929e..8e5c4a951f 100644
> --- a/qemu-doc.texi
> +++ b/qemu-doc.texi
> @@ -1,6 +1,7 @@
>  \input texinfo @c -*- texinfo -*-
>  @c %**start of header
>  @setfilename qemu-doc.info
> +@include version.texi
>
>  @documentlanguage en
>  @documentencoding UTF-8
> @@ -19,7 +20,7 @@
>  @iftex
>  @titlepage
>  @sp 7
> -@center @titlefont{QEMU Emulator}
> +@center @titlefont{QEMU version @value{VERSION}}
>  @sp 1
>  @center @titlefont{User Documentation}
>  @sp 3
> --
> 2.13.0

I think you also now need to make the qemu-doc.* files depend
on version.texi (as we do already for qemu-ga-ref.* and qemu-qmp-ref.*)
(If we plan to make the other docs also use version.texi, this
might be best done by reverting some of commit bd7f97479687.)

thanks
-- PMM
