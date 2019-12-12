Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B4DC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 21:13:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72947214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 21:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72947214D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifVmJ-0000XG-EN
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 16:13:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1ifVlg-0008W7-Ay
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 16:13:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1ifVle-00059x-F3
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 16:13:03 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:52974)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1ifVle-00053j-8B
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 16:13:02 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 937857456FE;
 Thu, 12 Dec 2019 22:12:57 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 75D9D7456F8; Thu, 12 Dec 2019 22:12:57 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 74CA774568D;
 Thu, 12 Dec 2019 22:12:57 +0100 (CET)
Date: Thu, 12 Dec 2019 22:12:57 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Laurent Vivier <laurent@vivier.eu>
Subject: Re: [PATCH 2/3] q800: add djMEMC memory controller
In-Reply-To: <20191212200142.15688-3-laurent@vivier.eu>
Message-ID: <alpine.BSF.2.21.99999.352.1912122211001.83036@zero.eik.bme.hu>
References: <20191212200142.15688-1-laurent@vivier.eu>
 <20191212200142.15688-3-laurent@vivier.eu>
User-Agent: Alpine 2.21.99999 (BSF 352 2019-06-22)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 12 Dec 2019, Laurent Vivier wrote:
> Current implementation is based on GLUE, an early implementation
> of the memory controller found in Macintosh II series.
>
> Quadra 800 uses in fact djMEMC:
>
> The djMEMC is an Apple custom integrated circuit chip that performs a
> variety of functions (RAM management, clock generation, ...).
> It receives interrupt requests from various devices, assign priority to
> each, and asserts one or more interrupt line to the CPU.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> MAINTAINERS              |   2 +
> hw/m68k/Kconfig          |   1 +
> hw/m68k/q800.c           |  61 ++++----------
> hw/misc/Kconfig          |   3 +
> hw/misc/Makefile.objs    |   1 +
> hw/misc/djmemc.c         | 176 +++++++++++++++++++++++++++++++++++++++
> hw/misc/trace-events     |   4 +
> include/hw/misc/djmemc.h |  34 ++++++++
> 8 files changed, 237 insertions(+), 45 deletions(-)
> create mode 100644 hw/misc/djmemc.c
> create mode 100644 include/hw/misc/djmemc.h
>
[...]
> diff --git a/hw/misc/djmemc.c b/hw/misc/djmemc.c
> new file mode 100644
> index 0000000000..b494e82a60
> --- /dev/null
> +++ b/hw/misc/djmemc.c
> @@ -0,0 +1,176 @@
> +/*
> + * djMEMC, macintosh memory and interrupt controller
> + * (Quadra 610/650/800 & Centris 610/650)
> + *
> + *    https://mac68k.info/wiki/display/mac68k/djMEMC+Information
> + *
> + * The djMEMC is an Apple custom integrated circuit chip that performs a
> + * variety of functions (RAM management, clock generation, ...).
> + * It receives interrupt requests from various devices, assign priority to
> + * each, and asserts one or more interrupt line to the CPU.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "migration/vmstate.h"
> +#include "hw/misc/djmemc.h"
> +#include "hw/qdev-properties.h"
> +#include "trace.h"
> +
> +#define DJMEMC_SIZE       0x2000
> +
> +#define InterleaveConf    0
> +#define Bank0Conf         1
> +#define Bank1Conf         2
> +#define Bank2Conf         3
> +#define Bank3Conf         4
> +#define Bank4Conf         5
> +#define Bank5Conf         6
> +#define Bank6Conf         7
> +#define Bank7Conf         8
> +#define Bank8Conf         9
> +#define Bank9Conf         10
> +#define MemTop            11
> +#define Config            12
> +#define Refresh           13

Should this be an enum so the compiler can better verify values and if all 
cases are handled?

Regards,
BALATON Zoltan

