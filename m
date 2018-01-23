Received: from eggs.gnu.org ([2001:4830:134:3::10]:58166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee20m-0002X6-El
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mlureau@redhat.com>) id 1ee20i-0006ZQ-EX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:28 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1ee20i-0006ZE-AR
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 12:05:24 -0500
Received: by mail-qt0-f194.google.com with SMTP id g14so3110225qti.2
	for <qemu-devel@nongnu.org>; Tue, 23 Jan 2018 09:05:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180123164718.12714-3-berrange@redhat.com>
References: <20180123164718.12714-1-berrange@redhat.com>
	<20180123164718.12714-3-berrange@redhat.com>
From: Marc-Andre Lureau <mlureau@redhat.com>
Date: Tue, 23 Jan 2018 18:05:23 +0100
Message-ID: <CAMxuvaxLp7wXZj=90X=cwZHOSCyKp7qvM5ST48t4w1P9sNg0yQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 2/2] make: fix help message reference to
 bogus V=0 variable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Tue, Jan 23, 2018 at 5:47 PM, Daniel P. Berrange <berrange@redhat.com> w=
rote:
> The make rules for building QEMU are mostly silent by default. They can
> be made verbose by setting the variable V=3D1. The default state does not
> however correspond to a V=3D0 setting - $(V) must be undefined / empty to
> get the default quiet build.
>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>


(with that, qemu build-sys differs from automake & kernel at least)

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>


> ---
>  Makefile | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Makefile b/Makefile
> index c263190b8d..554ba69ced 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -940,4 +940,5 @@ ifdef QEMU_GA_MSI_ENABLED
>  endif
>         @echo  ''
>  endif
> -       @echo  '  $(MAKE) V=3D0|1 [targets] 0 =3D> quiet build (default),=
 1 =3D> verbose build'
> +       @echo  '  $(MAKE) [targets]      (quiet build, default)'
> +       @echo  '  $(MAKE) V=3D1 [targets]  (verbose build)'
> --
> 2.14.3
>
