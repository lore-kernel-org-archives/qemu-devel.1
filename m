Received: from eggs.gnu.org ([2001:4830:134:3::10]:58076)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejkt2-0002St-0y
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:01:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ejkt0-0002UO-Bc
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:01:07 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:36242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ejkt0-0002U5-6v
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 07:01:06 -0500
Received: by mail-ot0-x229.google.com with SMTP id m20so4081460otf.3
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 04:01:05 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
References: <20180207111729.15737-1-ard.biesheuvel@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Feb 2018 12:00:44 +0000
Message-ID: <CAFEAcA-8VDnCxd974nP8TkWnEOAp8JJ8zG96Mzq2hj2nDCA8mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v6 0/5] target-arm: add SHA-3,
 SM3 and SHA512 instruction support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 7 February 2018 at 11:17, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> Changes since v5:
> - fix use of same register for destination and source in SHA-512 code
> - use correct free() function in SHA-3 code
> - drop helper for sm3ss1 in SM3 code
> - include fixed version of SM4 (correct # of iterations)
> - enable SM4 in user mode emulator

Thanks -- this version passes all my tests and I've put it into
target-arm.next.

-- PMM
