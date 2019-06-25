Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5D32C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 724A1215EA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 10:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="DO1c7aLU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 724A1215EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfiLT-0007Kz-PV
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 06:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59387)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hfiJi-0005su-8w
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1hfiJg-0003nQ-1T
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:04:46 -0400
Received: from nylar.uni-paderborn.de ([131.234.189.18]:49640)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1hfiJe-0003h0-11
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 06:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:Content-Type
 :In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UAwFGaojyixFOIIR4kx7XwzyfQGu/cA+28fe5P4lrrU=; b=DO1c7aLUpLEnzd/lwZPnwTYJfC
 y9ImZklH6Kpz3x/mZEP2uip3yz58NOvtNui0dibHGxXlIGc3MDBQz5uuecu/st9PF2ryHC5t5Go2s
 fwnl7lC+gW3jz/LMTA85+dWoXfgWHJhfl9mNObryxykOAFMOmBwgsaKCA0EcPWoTflQY=;
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
References: <20190624070339.4408-1-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <efda09cd-fa8d-32fc-96e6-9cdd755a6fce@mail.uni-paderborn.de>
Date: Tue, 25 Jun 2019 12:04:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190624070339.4408-1-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US-large
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.6.2792898, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.6.25.100016, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.6.18.5630002
X-IMT-Authenticated-Sender: kbastian@UNI-PADERBORN.DE
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.18
Subject: Re: [Qemu-devel] [PATCH v3 0/5] tricore: adding new instructions
 and fixing
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
Cc: David Brenken <david.brenken@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 6/24/19 9:03 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
>
>
> Hello everyone,
>
> as discussed here is the third version of the patchset.
> - We finalized the implementation of QSEED according to Bastians
> annotations.
> - We do only sync ctx.hflags with tb->flags.
>
> Best regards
>
> David
>
> Andreas Konopik (1):
>    tricore: add QSEED instruction
>
> David Brenken (3):
>    tricore: add FTOIZ instruction
>    tricore: add UTOF instruction
>    tricore: fix RRPW_INSERT instruction
>
> Georg Hofstetter (1):
>    tricore: sync ctx.hflags with tb->flags
>
>   target/tricore/fpu_helper.c | 125 ++++++++++++++++++++++++++++++++++++
>   target/tricore/helper.h     |   3 +
>   target/tricore/translate.c  |  13 +++-
>   3 files changed, 139 insertions(+), 2 deletions(-)
>
Applied to my tricore-next queue.

Cheers,

Bastian


