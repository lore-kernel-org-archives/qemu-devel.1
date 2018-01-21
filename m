Received: from eggs.gnu.org ([2001:4830:134:3::10]:55825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1edLkF-0007hq-LX
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 14:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rob@landley.net>) id 1edLkC-00089Z-Kn
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 14:57:35 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:42648)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rob@landley.net>) id 1edLkC-00088u-Ed
	for qemu-devel@nongnu.org; Sun, 21 Jan 2018 14:57:32 -0500
Received: by mail-io0-x242.google.com with SMTP id 25so7333650ioj.9
	for <qemu-devel@nongnu.org>; Sun, 21 Jan 2018 11:57:31 -0800 (PST)
References: <20180118193846.24953-1-laurent@vivier.eu>
	<20180118193846.24953-3-laurent@vivier.eu>
From: Rob Landley <rob@landley.net>
Message-ID: <b2e8fffd-5afb-edcf-3f30-62064175a435@landley.net>
Date: Sun, 21 Jan 2018 13:57:07 -0600
MIME-Version: 1.0
In-Reply-To: <20180118193846.24953-3-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 2/7] target/m68k: add MC68040 MMU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

On 01/18/2018 01:38 PM, Laurent Vivier wrote:
> Only add MC68040 MMU page table processing and related
> registers (Special Status Word, Translation Control Register,
> User Root Pointer and Supervisor Root Pointer).
> 
> Transparent Translation Registers, DFC/SFC and pflush/ptest
> will be added later.

I built qemu from thursday's git and qemu-system-m68k -M ? doesn't have
an obvious board emulation I can aim a linux kernel at. Is there a qemu
tree I should test, or...?

(I want to help out and test this stuff, but don't have context...)

Rob

P.S. My current project for banging on this is
https://github.com/landley/mkroot
