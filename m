Return-Path: <SRS0=B5/Q=AS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AEFC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:56:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C13E6206CD
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2020 08:56:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="X2HdAvKN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C13E6206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsjPN-00032d-37
	for qemu-devel@archiver.kernel.org; Tue, 07 Jul 2020 04:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jsjOk-0002cc-BU
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:56:18 -0400
Received: from zuban.uni-paderborn.de ([2001:638:502:c003::17]:49504)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1jsjOh-0005KN-8b
 for qemu-devel@nongnu.org; Tue, 07 Jul 2020 04:56:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvPSKXkVRPfk76MyMX5gnM8YcmO+/pV/52PUujK3jys=; b=X2HdAvKNABxv8yS8Zv3e/NJW+
 VSL4AB2PkTYTWjVmS8aDRGS8i96S2YTzncxbXfEjneb57O2FzDV6p0XG8Gpz+y4J7wbqW4yjY6GuG
 MzEz6iTkt3c7rHZgzlk4lO2NZiV/SLhiaPxOtcRmLnDm9f+nvlIS0PO8QuzEUg9Wk0Vr8=;
Date: Tue, 7 Jul 2020 10:56:04 +0200
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: David Brenken <david.brenken@efs-auto.org>
Subject: Re: [PATCH v4 1/1] tricore: added triboard with tc27x_soc
Message-ID: <20200707085604.rf6e4eft4jrxx6kr@schnipp-desktop>
References: <20200706124030.7280-1-david.brenken@efs-auto.org>
 <20200706124030.7280-2-david.brenken@efs-auto.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200706124030.7280-2-david.brenken@efs-auto.org>
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.9.2830568, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2020.7.7.84817, AntiVirus-Engine: 5.74.0,
 AntiVirus-Data: 2020.7.7.5740001
X-Sophos-SenderHistory: ip=95.222.26.35, fs=146, da=81721230, mc=1, sc=0, hc=1,
 sp=0, fso=146, re=0, sd=0, hd=0
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
Received-SPF: pass client-ip=2001:638:502:c003::17;
 envelope-from=kbastian@mail.uni-paderborn.de; helo=zuban.uni-paderborn.de
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org, Lars Biermanski <lars.biermanski@efs-auto.de>,
 Georg Hofstetter <georg.hofstetter@efs-auto.de>,
 David Brenken <david.brenken@efs-auto.de>,
 Robert Rasche <robert.rasche@efs-auto.de>,
 Andreas Konopik <andreas.konopik@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 06, 2020 at 02:40:30PM +0200, David Brenken wrote:
> From: Andreas Konopik <andreas.konopik@efs-auto.de>
> 
> Signed-off-by: Andreas Konopik <andreas.konopik@efs-auto.de>
> Signed-off-by: David Brenken <david.brenken@efs-auto.de>
> Signed-off-by: Georg Hofstetter <georg.hofstetter@efs-auto.de>
> Signed-off-by: Robert Rasche <robert.rasche@efs-auto.de>
> Signed-off-by: Lars Biermanski <lars.biermanski@efs-auto.de>
> ---
>  hw/tricore/Kconfig             |   8 ++
>  hw/tricore/Makefile.objs       |   2 +
>  hw/tricore/tc27x_soc.c         | 247 +++++++++++++++++++++++++++++++++
>  hw/tricore/triboard.c          | 102 ++++++++++++++
>  include/hw/tricore/tc27x_soc.h | 139 +++++++++++++++++++
>  include/hw/tricore/triboard.h  |  53 +++++++
>  6 files changed, 551 insertions(+)
>  create mode 100644 hw/tricore/tc27x_soc.c
>  create mode 100644 hw/tricore/triboard.c
>  create mode 100644 include/hw/tricore/tc27x_soc.h
>  create mode 100644 include/hw/tricore/triboard.h

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>

I also applied it to my tricore-next queue.

Cheers,
Bastian

