Received: from eggs.gnu.org ([2001:4830:134:3::10]:44454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFIhk-0006t7-Ma
	for qemu-devel@nongnu.org; Sun, 06 May 2018 08:23:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fFIhj-0003f1-Ov
	for qemu-devel@nongnu.org; Sun, 06 May 2018 08:23:52 -0400
Received: from mail-ot0-x230.google.com ([2607:f8b0:4003:c0f::230]:46064)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fFIhj-0003eB-Jc
	for qemu-devel@nongnu.org; Sun, 06 May 2018 08:23:51 -0400
Received: by mail-ot0-x230.google.com with SMTP id 15-v6so14329445otn.12
	for <qemu-devel@nongnu.org>; Sun, 06 May 2018 05:23:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
References: <1525396794-17042-1-git-send-email-mjc@sifive.com>
	<CAFEAcA-U8U6Q4KWEC7bNt9sUkr8jdPLKaGnFmvQbWaTbWT4qAw@mail.gmail.com>
	<20180505114812.GO13229@umbus.fritz.box>
	<CAHNT7Ns98LZzRK9AguCqrG+GQrSEm1+ZiPVLYnFKob8LgDdMKg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 6 May 2018 13:23:30 +0100
Message-ID: <CAFEAcA_fC6AmZBv4ovKunEm+2YPMdQJ0OWVVZXCuiLxGxAG=SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] device_tree: Add qemu_fdt_totalsize
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Michael Clark <mjc@sifive.com>
Cc: David Gibson <david@gibson.dropbear.id.au>, QEMU Developers <qemu-devel@nongnu.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Alexander Graf <agraf@suse.de>, Alistair Francis <alistair.francis@wdc.com>

On 5 May 2018 at 22:59, Michael Clark <mjc@sifive.com> wrote:
> Okay, so an alternative is to call fdt_pack() and then fdt_totalsize().
> Thanks!
>
> QEMU has its own wrapper around libfdt and neither the fdt_pack() nor
> fdt_totalsize() functions are exposed.
>
> Some architecture use only the wrapper functions provided by
> qemu/include/include/sysemu/device_tree.h
>
> It seems that target/ppc has #include <libfdt.h> and calls fdt_pack() and
> fdt_totalsize() directly.

Yeah, I find this combination of libfdt direct access and a
QEMU wrapper layer a bit confusing. I think it's grown more
than it's been actively designed. Your approach of doing
direct calls to pack/totalsize is fine. Maybe the wrapper
layer could be improved some day too.

thanks
-- PMM
