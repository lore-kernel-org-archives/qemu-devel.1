Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B42D1C4740C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 21:43:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E33021924
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 21:43:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=reactos.org header.i=@reactos.org header.b="u+X5zbao"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E33021924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=reactos.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7RRG-00060j-Vc
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 17:43:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43472)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hpoussin@reactos.org>) id 1i7RPl-0004yK-Hy
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:41:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hpoussin@reactos.org>) id 1i7RPk-0006bX-8Z
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:41:37 -0400
Received: from iserv.reactos.org ([2a01:4f8:1c17:5ae1::1]:37876)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <hpoussin@reactos.org>)
 id 1i7RPj-0006ZY-O4
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 17:41:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=reactos.org
 ; s=25047;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:
 Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=7JZ2ldntzNOc4SimjKqrOnai17pBIFRJ5vNNROwvwa0=; b=u+X5zbaoBLQs1wfhbytzPW35rM
 0UN7bbyu7RAR9GyTMonKb3lRQ9NoP0qAxkD562Q/tQHDpcLS8v9G+2b2GwGFFCdVAfd41HuPf4h0+
 LaIqbWET4bIM8FfVrJdDmQMCjdcpsYMB6baFBeBDiI83pFGKuhOQoF4g3ubvziQvaw2k=;
Received: from [2a01:e35:2e3e:3c40:45c0:4a4a:dd24:5f79]
 by iserv.reactos.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.89) (envelope-from <hpoussin@reactos.org>)
 id 1i7RPb-0001XF-DC; Mon, 09 Sep 2019 21:41:29 +0000
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20190802160458.25681-1-peter.maydell@linaro.org>
 <20190802160458.25681-2-peter.maydell@linaro.org>
From: =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
Message-ID: <861df7eb-797a-544a-66ce-5a870bb61c44@reactos.org>
Date: Mon, 9 Sep 2019 23:41:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802160458.25681-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:1c17:5ae1::1
Subject: Re: [Qemu-devel] [PATCH 1/3] hw/mips/mips_jazz: Override
 do_transaction_failed hook
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
> The MIPS Jazz ('magnum' and 'pica61') boards have some code which
> overrides the CPU's do_unassigned_access hook, so they can intercept
> it and not raise exceptions on data accesses to invalid addresses,
> only for instruction fetches.
> 
> We want to switch MIPS over to using the do_transaction_failed
> hook instead, so add an intercept for that as well, and make
> the board code install whichever hook the CPU is actually using.
> Once we've changed the CPU implementation we can remove the
> redundant code for the old hook.
> 
> Note: I am suspicious that the behaviour as implemented here may not
> be what the hardware really does.  It was added in commit
> 54e755588cf1e90f0b14 to restore the behaviour that was broken by
> commit c658b94f6e8c206c59d.  But prior to commit c658b94f6e8c206c59d
> every MIPS board generated exceptions for instruction access to
> invalid addresses but not for data accesses; and other boards,
> notably Malta, were fixed by making all invalid accesses behave as
> reads-as-zero (see the call to empty_slot_init() in
> mips_malta_init()).  Hardware that raises exceptions for instruction
> access and not data access seems to me to be an unlikely design, and
> it's possible that the right way to emulate this is to make the Jazz
> boards do what we did with Malta (or some variation of that).
> Nonetheless, since I don't have access to real hardware to test
> against I have taken the approach of "make QEMU continue to behave
> the same way it did before this commit".  I have updated the comment
> to correct the parts that are no longer accurate and note that
> the hardware might behave differently.
> 
> The test case for the need for the hook-hijacking is in
> https://bugs.launchpad.net/qemu/+bug/1245924 That BIOS will boot OK
> either with this overriding of both hooks, or with a simple "global
> memory region to ignore bad accesses of all types", so it doesn't
> provide evidence either way, unfortunately.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Tested-by: Hervé Poussineau <hpoussin@reactos.org>

