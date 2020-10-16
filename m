Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62283C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:29:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D7B620878
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:29:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="BgobDDtM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D7B620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWLz-0004ZG-23
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 16:29:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49614)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hpoussin@reactos.org>)
 id 1kTWE8-0000Ab-Oz; Fri, 16 Oct 2020 16:21:24 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:56436)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hpoussin@reactos.org>)
 id 1kTWE4-0007Gh-QA; Fri, 16 Oct 2020 16:21:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=keuqbp1RCgxaqFHNcOWXprRe7erFPJbcAMtzT5INgcI=; b=BgobDDtMklAnnDgVlQUuLkLc39
 QWrpS/cZMtjj2+FLHwwButtXj851n9tSX3MgZGSXz2N5rM+7W1h3ejC/774DHvIxsf2zUT5sTu0Hr
 UMBB5AGbQ6VcSJnBsyySMfcnM4lbMNBPdZZhyRlltFWH+7kpMh4OhVL54cVMYbvq9czw=;
Received: from [2a01:e35:2e3e:3c40:899a:1720:1cdf:ffca]
 by iserv.reactos.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <hpoussin@reactos.org>)
 id 1kTWDz-0007z1-13; Fri, 16 Oct 2020 20:21:15 +0000
Subject: Re: [PATCH 0/5] m48t59: remove legacy init functions
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 qemu-trivial@nongnu.org, f4bug@amsat.org, qemu-ppc@nongnu.org,
 atar4qemu@gmail.com, david@gibson.dropbear.id.au
References: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <49b1bc21-46b6-7836-8df9-f8300a6f3bb5@reactos.org>
Date: Fri, 16 Oct 2020 22:21:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20201016182739.22875-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a01:4f8:1c17:5ae1::1;
 envelope-from=hpoussin@reactos.org; helo=iserv.reactos.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/10/2020 à 20:27, Mark Cave-Ayland a écrit :
> This patchset is inspired by Philippe's "hw/rtc/m48t59: Simplify m48t59_init()"
> patchset at https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg04493.html
> but goes further: rather than tidy-up the legacy init functions, convert the
> callers to use qdev properties directly so they can simply be removed.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> 
> 
> Mark Cave-Ayland (5):
>    m48t59-isa: remove legacy m48t59_init_isa() function
>    sun4m: use qdev properties instead of legacy m48t59_init() function
>    sun4u: use qdev properties instead of legacy m48t59_init() function
>    ppc405_boards: use qdev properties instead of legacy m48t59_init()
>      function
>    m48t59: remove legacy m48t59_init() function
> 
>   hw/ppc/ppc405_boards.c  | 10 +++++++++-
>   hw/rtc/m48t59-isa.c     | 25 -------------------------
>   hw/rtc/m48t59.c         | 35 -----------------------------------
>   hw/sparc/sun4m.c        |  8 +++++++-
>   hw/sparc64/sun4u.c      |  7 +++++--
>   include/hw/rtc/m48t59.h |  6 ------
>   6 files changed, 21 insertions(+), 70 deletions(-)
> 

Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>

