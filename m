Received: from eggs.gnu.org ([2001:4830:134:3::10]:56007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuZR-0001Yw-Pg
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eQuZQ-0002MN-Tt
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:31:01 -0500
Received: from mail-oi0-x234.google.com ([2607:f8b0:4003:c06::234]:40630)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eQuZQ-0002Lv-Nl
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 07:31:00 -0500
Received: by mail-oi0-x234.google.com with SMTP id w125so10452642oie.7
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 04:31:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <0843d1d9-e015-f4bd-3a98-92c0e3db5b42@vivier.eu>
References: <20171121064106.13721-1-ybettan@redhat.com>
	<fe42e8d1-afde-f761-9780-b1a8f7d4030f@vivier.eu>
	<64af419e-b8b8-0a05-21f7-1029bc809079@redhat.com>
	<0843d1d9-e015-f4bd-3a98-92c0e3db5b42@vivier.eu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Dec 2017 12:30:39 +0000
Message-ID: <CAFEAcA93oFez4Fvz83vye3-JjWFLMNyLKA3UL+Pck8d6eNWRaw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] vl.c && linux-user/main.c : removed **envp
 from main() arguments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: Yoni Bettan <ybettan@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>

On 18 December 2017 at 07:52, Laurent Vivier <laurent@vivier.eu> wrote:
> I think we don't need it anymore as there is no difference betweent
> qemu_main() and main().

You need to be a bit cautious there to avoid breaking
the OSX code in ui/cocoa.m, which has its own version
of main() which kicks off the GUI code and then eventually
calls qemu_main() later.

thanks
-- PMM
