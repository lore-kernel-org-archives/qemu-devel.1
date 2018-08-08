Received: from eggs.gnu.org ([2001:4830:134:3::10]:45695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnPpB-00050t-06
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:52:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fnPpA-0004FG-5o
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:52:33 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:39523)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fnPp9-0004Ez-Tz
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 10:52:32 -0400
Received: by mail-oi0-x243.google.com with SMTP id d189-v6so4204630oib.6
	for <qemu-devel@nongnu.org>; Wed, 08 Aug 2018 07:52:31 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180808141700.21333-2-jthumshirn@suse.de>
References: <20180808141700.21333-1-jthumshirn@suse.de>
	<20180808141700.21333-2-jthumshirn@suse.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Aug 2018 15:52:05 +0100
Message-ID: <CAFEAcA80PvZzdeUALCWfRojSp6pT_s6ppnUC9TYLHgFCO-cNAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 1/4] Add MEN Chameleon Bus emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Johannes Thumshirn <jthumshirn@suse.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 8 August 2018 at 15:16, Johannes Thumshirn <jthumshirn@suse.de> wrote:
> The MEN Chameleon Bus (MCB) is an on-chip bus system exposing IP Cores of an
> FPGA to a outside bus system like PCIe.
>
> Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>


> --- /dev/null
> +++ b/hw/mcb/mcb.c
> @@ -0,0 +1,180 @@
> +/*
> + * QEMU MEN Chameleon Bus emulation
> + *
> + * Copyright (C) 2016 Johannes Thumshirn <morbidrsa@gmail.com>

Really 2016?

> + *
> + * This code is licensed under the GNU GPL v2 or (at your opinion) any

This should say "option" -- wording is important in license
statements :-)  You might prefer to copy-and-paste an
existing copyright header.


thanks
-- PMM
