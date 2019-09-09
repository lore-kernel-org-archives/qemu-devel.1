Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD9B1C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 21:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8422D218AF
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 21:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="vnyH2JWS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8422D218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7RSD-0006kl-Ko
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 17:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1i7RQ9-0005Rz-1y
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1i7RQ8-0006nV-1f
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:42:00 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:37900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1i7RQ7-0006mw-QK
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:41:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HuaNe2ljf13Z4SqfiAOdi/YX7JM4e/CKH4JGe0IpcHY=; b=vnyH2JWSFkc8yfsBEYBpUISpYc
 FOdXaYtGLUAIyxY1XoKqD53Qnv1aMjMD7XJYrwrsGyIqXqz/Ue163tO3EtmjMO4gMPpD1/Dj3dpxS
 PXCaFVlY8hFeMACpJ4PmbP5ttwlfa3iU20pDbeRA7+yHumxtjRQATZtOJm00KoTfKzWQ=;
Received: from [2a01:e35:2e3e:3c40:45c0:4a4a:dd24:5f79]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1i7RQ2-0001Y6-Tn; Mon, 09 Sep 2019 21:41:56 +0000
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <20190802160458.25681-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <aa23de51-9a7d-8736-b007-4aa834d306c8@reactos.org>
Date: Mon, 9 Sep 2019 23:41:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 2/3] target/mips: Switch to
 do_transaction_failed() hook
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
Cc: Aleksandar Rikalo <arikalo@wavecomp.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 02/08/2019 à 18:04, Peter Maydell a écrit :
> Switch the MIPS target from the old unassigned_access hook to the new
> do_transaction_failed hook.
> 
> Unlike the old hook, do_transaction_failed is only ever called from
> the TCG memory access paths, so there is no need for the "ignore this
> if we're using KVM" hack that we were previously using to work around
> the way unassigned_access was called for all kinds of memory accesses
> to unassigned physical addresses.
> 
> The MIPS target does not ever do direct memory reads by physical
> address (via either ldl_phys etc or address_space_ldl etc), so the
> only memory accesses this affects are the 'normal' guest loads and
> stores, which will be handled by the new hook; their behaviour is
> unchanged.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/mips/internal.h  |  8 +++++---
>   target/mips/cpu.c       |  2 +-
>   target/mips/op_helper.c | 24 ++++++++----------------
>   3 files changed, 14 insertions(+), 20 deletions(-)

Tested-by: Hervé Poussineau <hpoussin@reactos.org>


