Received: from eggs.gnu.org ([209.51.188.92]:50214)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpcQr-0007cO-VI
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:16:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpcQq-0001xa-2Q
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:16:49 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:35795)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpcQk-0001lI-Ku
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:16:45 -0500
Received: by mail-oi1-x231.google.com with SMTP id v6so6428447oif.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:16:20 -0800 (PST)
MIME-Version: 1.0
References: <20190201145035.22739-1-peter.maydell@linaro.org>
	<20190201145035.22739-10-peter.maydell@linaro.org>
	<87r2crv5um.fsf@zen.linaroharston>
	<87a7jfv3fm.fsf@zen.linaroharston>
In-Reply-To: <87a7jfv3fm.fsf@zen.linaroharston>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Feb 2019 17:16:07 +0000
Message-ID: <CAFEAcA-SguyhGJQkngAjDJHfPyPkAaqGYFDT2CUrkmK1YdKcWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 09/11] Makefile,
 configure: Support building rST documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>

On Fri, 1 Feb 2019 at 17:11, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
> I did the following:
>
> modified   Makefile
> @@ -322,6 +322,7 @@ endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
>  DOCS+=3Dscripts/qemu-trace-stap.1
>  endif
> +DOCS+=3Dsphinxdocs
>  else
>  DOCS=3D
>  endif

This kind of works, but it's a bit odd, because DOCS is otherwise
a list of files and we assume it is in a couple of places. (For
instance we call "rm -f $(DOCS)" in the distclean target.)

thanks
-- PMM
