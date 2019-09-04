Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D335C3A5A7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:39:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6631122CF7
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 13:39:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="AqCDIFCa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6631122CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5VVQ-00051Q-Bg
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 09:39:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Uxq-00059g-FH
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i5Uxo-0001vJ-Jm
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 09:04:46 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:46398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i5Uxi-0001pc-7k; Wed, 04 Sep 2019 09:04:38 -0400
Received: from [172.16.11.102] (crumble.bar.greensocs.com [172.16.11.102])
 by beetle.greensocs.com (Postfix) with ESMTPSA id 56FD296F65;
 Wed,  4 Sep 2019 13:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1567602275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azQBI/68e6QFd1ohvuIkRp8dnRdTdZtTAqRXho1rwls=;
 b=AqCDIFCaPrZQy0thlJqLVz/iYL8I36kWr+t9smBFItX9xErfI6mc9A6g0kZi7VafwJIgXb
 t2TRE1HbQkJ+7p/CNCPqD7iak0GXQOyQo1Xsq1lrJTer7XoUkjN70syMLdAJTZ3EWiWUik
 G+6Xf/eEidzAwsOmLHoBJa/45KJ5D2U=
To: qemu-devel@nongnu.org
References: <20190904093843.8765-1-damien.hedde@greensocs.con>
From: Damien Hedde <damien.hedde@greensocs.com>
Message-ID: <6df157cb-cdb4-a019-3463-e1468d410f4e@greensocs.com>
Date: Wed, 4 Sep 2019 15:04:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190904093843.8765-1-damien.hedde@greensocs.con>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1567602275;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azQBI/68e6QFd1ohvuIkRp8dnRdTdZtTAqRXho1rwls=;
 b=RILxfyyRHtm/oYc8z7bKBYqlotwKPgNmL8U42Jbu38pEehlqvTw8mepuxgqfdGKpb2llV5
 yKdsbwPDx3YmqH7x8fc5oBAijB1BRAe2l+2dS+w0nppqHxrrqbrf/ecAc6WCz3WwHBmx60
 WwHyUoy1WoLgbMgktETzEXrdeSrWchE=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1567602275; a=rsa-sha256; cv=none;
 b=zchS1JlCEKvpsc/pEUO5mOED74Po1oumUD54rB2dMpyQeSUe5qfcI0e3RWgvZ0zUfsi9GB
 OutXzO58SAnKHMM0oilQe7s4ysveuqc08wmso93s1BVH9Tt/xTPeUckhjZMJy6rML8UI4b
 oT4yU2bZFJKbhbtCTES1reA2waFM1VY=
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=damien smtp.mailfrom=damien.hedde@greensocs.com
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: Re: [Qemu-devel] [PATCH v6 0/9] Clock framework API
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
Cc: peter.maydell@linaro.org, berrange@redhat.com, ehabkost@redhat.com,
 alistair@alistair23.me, mark.burton@greensocs.com, qemu-arm@nongnu.org,
 marcandre.lureau@redhat.com, pbonzini@redhat.com, philmd@redhat.com,
 edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I did a typo in the reply-to address. I just resent the series with the
proper one.

Sorry for that...
Damien

On 9/4/19 11:38 AM, damien.hedde@greensocs.con wrote:
> From: Damien Hedde <damien.hedde@greensocs.com>
> 
> This series aims to add a way to model clock distribution in qemu. This allows
> to model the clock tree of a platform allowing us to inspect clock
> configuration and detect problems such as disabled clock or bad configured
> pll.
> 
> The added clock api is very similar the the gpio api for devices. We can add
> input and output and connect them together.
> 
> Very few changes since v5 in the core patches: we were waiting for multi phase
> ability to allow proper initialization of the clock tree. So this is almost a
> simple rebase on top of the current "Multi-phase reset mechanism" series.
> Based-on: <20190821163341.16309-1-damien.hedde@greensocs.com>
> 
> Changes since v5:
>  - drop the "-port" in file names
>  - new patch 2, extracted from patch 1 (to fix some problem with linux-user builds)
>  - patch 3, minor modification to better match gpios api and allow non device-related clock
>    (I've dropped the reviewed-by, see the patch message for the details of what has changed).
>  - patch 6, Philippe's comments and various improvement
>  - patches 7/8/9, multi-phase reset addition and scope reduced to uart ref clocks
> 
> The patches are organised as follows:
> + Patches 1 to 5 adds the clock support in qemu (1, 4 and 5 are already reviewed and
>   also a big part of the 3)
> + Patch 6 add some documentation in docs/devel
> + Patches 7 to 9 adds the uart's clocks to the xilinx_zynq platform as an
> example for this framework. It updates the zynq's slcr clock controller, the 
> cadence_uart device, and the zynq toplevel platform.
> 
> I've tested this patchset on the xilinx-zynq-a9 machine with the buildroot's
> zynq_zc706_defconfig which package the Xilinx's Linux.
> Clocks are correctly updated and we ends up with a configured baudrate of 115601
> on the console uart (for a theoretical 115200) which is nice. "cadence_uart*" and
> "clock*" traces can be enabled to see what's going on in this platform.
> 
> Any comments and suggestion are welcomed.
> 
> Thanks to the Xilinx QEMU team who sponsored this development.
> 
> Damien Hedde (9):
>   hw/core/clock: introduce clock objects
>   hw/core/clock-vmstate: define a vmstate entry for clock state
>   qdev: add clock input&output support to devices.
>   qdev-monitor: print the device's clock with info qtree
>   qdev-clock: introduce an init array to ease the device construction
>   docs/clocks: add device's clock documentation
>   hw/misc/zynq_slcr: add clock generation for uarts
>   hw/char/cadence_uart: add clock support
>   hw/arm/xilinx_zynq: connect uart clocks to slcr
> 
>  Makefile.objs                  |   1 +
>  docs/devel/clock.txt           | 246 +++++++++++++++++++++++++++++++++
>  hw/arm/xilinx_zynq.c           |  64 +++++++--
>  hw/char/cadence_uart.c         |  85 ++++++++++--
>  hw/char/trace-events           |   3 +
>  hw/core/Makefile.objs          |   4 +-
>  hw/core/clock-vmstate.c        |  25 ++++
>  hw/core/clock.c                | 144 +++++++++++++++++++
>  hw/core/qdev-clock.c           | 181 ++++++++++++++++++++++++
>  hw/core/qdev.c                 |  32 +++++
>  hw/core/trace-events           |   6 +
>  hw/misc/zynq_slcr.c            | 145 ++++++++++++++++++-
>  include/hw/char/cadence_uart.h |   1 +
>  include/hw/clock.h             | 133 ++++++++++++++++++
>  include/hw/qdev-clock.h        | 134 ++++++++++++++++++
>  include/hw/qdev-core.h         |  14 ++
>  qdev-monitor.c                 |  13 ++
>  tests/Makefile.include         |   1 +
>  18 files changed, 1210 insertions(+), 22 deletions(-)
>  create mode 100644 docs/devel/clock.txt
>  create mode 100644 hw/core/clock-vmstate.c
>  create mode 100644 hw/core/clock.c
>  create mode 100644 hw/core/qdev-clock.c
>  create mode 100644 include/hw/clock.h
>  create mode 100644 include/hw/qdev-clock.h
> 

