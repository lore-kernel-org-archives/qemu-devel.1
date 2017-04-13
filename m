Received: from eggs.gnu.org ([2001:4830:134:3::10]:41601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cybJE-00048S-4X
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:45:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cybJD-0001Vw-CG
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:45:00 -0400
Received: from mail-wm0-x22c.google.com ([2a00:1450:400c:c09::22c]:38017)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cybJD-0001Vj-5K
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 05:44:59 -0400
Received: by mail-wm0-x22c.google.com with SMTP id t189so42764614wmt.1
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 02:44:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CALHRZurSfOAt53Sf=aGdGe7cHCxNggjUrt6pPDEQLRcvfX_cDA@mail.gmail.com>
References: <1491736758-19540-1-git-send-email-sundeep.lkml@gmail.com>
	<CALHRZurSfOAt53Sf=aGdGe7cHCxNggjUrt6pPDEQLRcvfX_cDA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Apr 2017 10:44:37 +0100
Message-ID: <CAFEAcA9V0A9XvjtXHkq4RKmPDwRPuUgqwncy_hXMzv_FyVrD_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [Qemu-devel RFC v2 0/4] Add support for
 Smartfusion2 SoC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: sundeep subbaraya <sundeep.lkml@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 13 April 2017 at 04:21, sundeep subbaraya <sundeep.lkml@gmail.com> wrote:
> Hi Qemu-devel,
>
> This is my first attempt in Qemu.
> Please let me know am doing correct or not.
> SoC is cortex M3 based so no bootrom stuff and unlike other
> SoCs Qemu need not load dtb and kernel in DDR. Hence am using
> u-boot (supplied with -kernel) as bootloader in eNVM and it loads
> kernel from SPI flash to DDR same like real hardware scenario.
> Also let me know any other Maintainers need to be CCed.

Hi -- thanks for the patchset. I've put it onto my queue of
patches to review, but it may be a little while until I
can get to it (especially since it's the Easter holiday
in the UK right now).

-- PMM
