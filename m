Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 678A6C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:06:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12722531B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 17:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12722531B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSNlI-0005y5-JS
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 13:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32852)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNjp-0004uS-0r; Tue, 13 Oct 2020 13:05:26 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:35353)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1kSNjj-0007XX-Vc; Tue, 13 Oct 2020 13:05:24 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 0CAD3747601;
 Tue, 13 Oct 2020 19:05:16 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 3130B7475FE; Tue, 13 Oct 2020 19:05:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 2F7457475FA;
 Tue, 13 Oct 2020 19:05:15 +0200 (CEST)
Date: Tue, 13 Oct 2020 19:05:15 +0200 (CEST)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Subject: Re: [PATCH v2 2/3] grackle: use qdev gpios for PCI IRQs
In-Reply-To: <79df54b3-d9e5-145e-e277-24468b121ba0@ilande.co.uk>
Message-ID: <91a24667-5f72-d3d9-8e47-6453268d2b78@eik.bme.hu>
References: <20201013114922.2946-1-mark.cave-ayland@ilande.co.uk>
 <20201013114922.2946-3-mark.cave-ayland@ilande.co.uk>
 <c882279b-a561-2c3a-a6b5-b27446fddb02@amsat.org>
 <79df54b3-d9e5-145e-e277-24468b121ba0@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: BALATON Zoltan <balaton@eik.bme.hu>
From: BALATON Zoltan via <qemu-devel@nongnu.org>

Hello,

Not related to this patch but while you're at it could you please take 
those patches that are already reviewed by you from this series as well?

http://patchwork.ozlabs.org/project/qemu-devel/list/?series=186439

That would help cleaning up my tree and see which patches still need 
changes. Let me know if these need any rebasing and point me to the tree 
on which I should rebase them. Currently they apply to your screamer 
branch I think.

Regards,
BALATON Zoltan

