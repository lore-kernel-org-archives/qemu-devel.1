Received: from eggs.gnu.org ([2001:4830:134:3::10]:34030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhbP-0006u8-38
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQhbN-0000XR-Kc
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:38 -0500
Received: from mail-ua0-x232.google.com ([2607:f8b0:400c:c08::232]:34956)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQhbN-0000Vs-BI
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 16:35:37 -0500
Received: by mail-ua0-x232.google.com with SMTP id y9so142865833uae.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 13:35:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <148398903105.208.13573655327114962163@790289a7ca88>
References: <1483988759-14606-1-git-send-email-peter.maydell@linaro.org>
	<148398903105.208.13573655327114962163@790289a7ca88>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 21:35:16 +0000
Message-ID: <CAFEAcA-S6txZ79_N1PTzAGb0dQSV9zpQ-kKyjnYDyyZzsv_4Ug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] disas/cris.c: Fix Coverity warning about
 unchecked NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Fam Zheng <famz@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "patches@linaro.org" <patches@linaro.org>

On 9 January 2017 at 19:10,  <no-reply@patchew.org> wrote:
> Checking PATCH 1/1: disas/cris.c: Fix Coverity warning about unchecked NULL...
> ERROR: code indent should never use tabs
> #24: FILE: disas/cris.c:2493:
> +^Iif (sregp == NULL || sregp->name == NULL)$
>
> ERROR: suspect code indent for conditional statements (8, 10)
> #24: FILE: disas/cris.c:2493:
> +       if (sregp == NULL || sregp->name == NULL)
>           /* Should have been caught as a non-match earlier.  */
>
> ERROR: braces {} are necessary for all arms of this statement
> #24: FILE: disas/cris.c:2493:
> +       if (sregp == NULL || sregp->name == NULL)
> [...]
>
> total: 3 errors, 0 warnings, 8 lines checked

This is because the whole file is GNU coding standards
style, being a binutils import. Better to stick with it rather
than rework, I think.

thanks
-- PMM
