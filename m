Received: from eggs.gnu.org ([2001:4830:134:3::10]:37217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcVzY-0008UA-VD
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fcVzY-0001Z2-2C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:12 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:34945)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fcVzX-0001Yr-RK
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 09:14:11 -0400
Received: by mail-oi0-x243.google.com with SMTP id i12-v6so35770775oik.2
	for <qemu-devel@nongnu.org>; Mon, 09 Jul 2018 06:14:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180706162155.8432-1-f4bug@amsat.org>
References: <20180706162155.8432-1-f4bug@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jul 2018 14:13:50 +0100
Message-ID: <CAFEAcA_ZyBRy9S2zg+P5VbYR5NDYacX5NCGO26MkdFfTeS4SZA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.0 0/1] Fix the Nokia N810 tablet MMC
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Andrzej Zaborowski <balrogg@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 6 July 2018 at 17:21, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrot=
e:
> Hi Peter,
>
> This bug was previously reported here:
> http://lists.nongnu.org/archive/html/qemu-devel/2018-06/msg01824.html
>
> Diff before/after ecd219f7abb using -append "console=3DttyS1 printk.time=
=3D0"
> option to boot http://people.linaro.org/~peter.maydell/n8x0-images.tgz
>
>  mmci-omap mmci-omap.0: command timeout (CMD5)
>  mmc0: host does not support reading read-only switch. assuming
> write-enable.
>  mmc0: new SDHC card at address 4567
> -Waiting for root device /dev/mmcblk0p1...
>  mmcblk0: mmc0:4567 QEMU! 1.81 GiB
>   mmcblk0: p1 p2
> -EXT3-fs: barriers not enabled
> -EXT3-fs (mmcblk0p1): mounted filesystem with writeback data mode
> -VFS: Mounted root (ext3 filesystem) readonly on device 179:1.
> -kjournald starting.  Commit interval 5 seconds
> -devtmpfs: mounted
> -Freeing init memory: 132K
> -mmci-omap mmci-omap.0: command timeout (CMD52)
> -mmci-omap mmci-omap.0: command timeout (CMD52)
> -mmci-omap mmci-omap.0: command timeout (CMD8)
> -mmci-omap mmci-omap.0: command timeout (CMD5)
> -mmci-omap mmci-omap.0: command timeout (CMD5)
> -mmci-omap mmci-omap.0: command timeout (CMD5)
> -mmci-omap mmci-omap.0: command timeout (CMD5)
> -mmci-omap mmci-omap.0: command timeout (CMD55)
> -mmci-omap mmci-omap.0: command timeout (CMD55)
> -mmci-omap mmci-omap.0: command timeout (CMD55)
> -mmci-omap mmci-omap.0: command timeout (CMD55)
> -mmci-omap mmci-omap.0: command timeout (CMD1)

FWIW my n8x0 image still produces these command timeout complaints
even with your patch (and it doesn't oops either way). Probably
just a different kernel version.

thanks
-- PMM
