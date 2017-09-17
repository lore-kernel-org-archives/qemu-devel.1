Received: from eggs.gnu.org ([2001:4830:134:3::10]:56903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtbJn-0000r3-9y
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dtbJj-0006lk-Bt
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:17:11 -0400
Received: from mail-oi0-x22b.google.com ([2607:f8b0:4003:c06::22b]:50947)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dtbJj-0006la-6B
	for qemu-devel@nongnu.org; Sun, 17 Sep 2017 11:17:07 -0400
Received: by mail-oi0-x22b.google.com with SMTP id w65so3695440oia.7
	for <qemu-devel@nongnu.org>; Sun, 17 Sep 2017 08:17:07 -0700 (PDT)
References: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b7fb3be8-f052-2b25-9289-9062aee1acb1@linaro.org>
Date: Sun, 17 Sep 2017 08:17:02 -0700
MIME-Version: 1.0
In-Reply-To: <150558614762.29770.16367876405044972592.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1717708] [NEW] QEMU aarch64 can't run Windows
 ARM64 iso's
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1717708 <1717708@bugs.launchpad.net>, qemu-devel@nongnu.org

On 09/16/2017 11:22 AM, oscarbg wrote:
> Public bug reported:
> 
> Hi,
> recently Windows ARM64 ISOs have been posted on the internet..
> just checked with latest QEMU 2.10 release from 
> https://qemu.weilnetz.de/w64/qemu-w64-setup-20170830.exe 
> "h:\qemu\qemu-system-aarch64.exe" -boot d -cdrom h:\iso\16353.1000.170825-1423.RS_PRERELEASE_CLIENTPRO_OEMRET_ARM64FRE_ES-ES.ISO -m 2048 -cpu cortex-a57 -smp 1 -machine virt
> seems no video output..

The first thing that I see missing here is a UEFI bios image.  While qemu
provides bios images for other targets, we do not ship one for arm64.

  https://wiki.linaro.org/LEG/UEFIforQEMU

provides instructions for building or downloading the bios.  Using that, you
should at least get to a prompt on the serial console.

>From there, whether windows can boot with a serial console, or whether it
requires a graphics device, I don't know.


r~
