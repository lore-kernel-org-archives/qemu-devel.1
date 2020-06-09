Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A19EC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC1F4206D5
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 04:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mymailcheap.com header.i=@mymailcheap.com header.b="xM0+Pkp0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=@flygoat.com header.b="YYMj8pkG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC1F4206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiVWt-0007Id-45
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 00:06:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jiVWA-0006sM-1h
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:05:42 -0400
Received: from relay2.mymailcheap.com ([217.182.66.162]:46725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jiVW8-0007t7-6Q
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 00:05:41 -0400
Received: from filter1.mymailcheap.com (filter1.mymailcheap.com
 [149.56.130.247])
 by relay2.mymailcheap.com (Postfix) with ESMTPS id C023E3E902;
 Tue,  9 Jun 2020 06:05:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by filter1.mymailcheap.com (Postfix) with ESMTP id 108392A3AF;
 Tue,  9 Jun 2020 00:05:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mymailcheap.com;
 s=default; t=1591675536;
 bh=npLpdUpeHJ3OBnNZgbyJ+X1cIfeuxrtA9N6dxWQPTw8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=xM0+Pkp0LK/5QWh3r3WAEs07jqvwxAoYFmUPkUT17abAGICVd9AzaVtVALHcFJxYJ
 HKnuNib1Xo/dBV2zFqMrxb7J1zZDwOAzC57aq1aCCPY6FF3S0EZz7eZzu8D3c4o3Cb
 CiYV3HsiqtyzxzU9g6Zjrid327z4hRhLEIuxHfq8=
X-Virus-Scanned: Debian amavisd-new at filter1.mymailcheap.com
Received: from filter1.mymailcheap.com ([127.0.0.1])
 by localhost (filter1.mymailcheap.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1if-C6YnKwI8; Tue,  9 Jun 2020 00:05:34 -0400 (EDT)
Received: from mail20.mymailcheap.com (mail20.mymailcheap.com [51.83.111.147])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by filter1.mymailcheap.com (Postfix) with ESMTPS;
 Tue,  9 Jun 2020 00:05:34 -0400 (EDT)
Received: from [213.133.102.83] (ml.mymailcheap.com [213.133.102.83])
 by mail20.mymailcheap.com (Postfix) with ESMTP id 3CB60403D9;
 Tue,  9 Jun 2020 04:05:31 +0000 (UTC)
Authentication-Results: mail20.mymailcheap.com; dkim=pass (1024-bit key;
 unprotected) header.d=flygoat.com header.i=@flygoat.com header.b="YYMj8pkG"; 
 dkim-atps=neutral
AI-Spam-Status: Not processed
Received: from [0.0.0.0] (1-36-183-115.static.netvigator.com [1.36.183.115])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by mail20.mymailcheap.com (Postfix) with ESMTPSA id 89E52403D9;
 Tue,  9 Jun 2020 04:05:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=flygoat.com;
 s=default; t=1591675528;
 bh=npLpdUpeHJ3OBnNZgbyJ+X1cIfeuxrtA9N6dxWQPTw8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=YYMj8pkGSlicv2orarENtIQDY9cD126laDgMJGIBYfH4Byy8CFO3oh7ocv6Mh52D5
 goftAKudV2v3d/WzEIMCuWx2d+OYAiI/bxMr6QcfdDNY2AgB2UV9VO5fExItB4eHFv
 O0Y9ZVtLDyWQSBi93OhJWfZdL6szj49J59tLilW0=
Subject: Re: [PATCH] target/mips: Fix PageMask with variable page size
To: qemu-devel@nongnu.org
References: <20200609024746.2498909-1-jiaxun.yang@flygoat.com>
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
Message-ID: <f9645882-a538-f989-9d1f-ba18ea266e40@flygoat.com>
Date: Tue, 9 Jun 2020 12:05:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200609024746.2498909-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3CB60403D9
X-Spamd-Result: default: False [1.40 / 10.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; R_DKIM_ALLOW(0.00)[flygoat.com:s=default];
 MID_RHS_MATCH_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[4]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TAGGED_RCPT(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; TO_DN_NONE(0.00)[];
 R_SPF_SOFTFAIL(0.00)[~all];
 HFILTER_HELO_BAREIP(3.00)[213.133.102.83,1];
 ML_SERVERS(-3.10)[213.133.102.83];
 DKIM_TRACE(0.00)[flygoat.com:+];
 DMARC_POLICY_ALLOW(0.00)[flygoat.com,none];
 RCVD_IN_DNSWL_NONE(0.00)[213.133.102.83:from];
 DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
 RCVD_NO_TLS_LAST(0.10)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+];
 ASN(0.00)[asn:24940, ipnet:213.133.96.0/19, country:DE];
 FREEMAIL_CC(0.00)[gmail.com,aurel32.net,lemote.com];
 SUSPICIOUS_RECIPS(1.50)[]; RCVD_COUNT_TWO(0.00)[2]
X-Rspamd-Server: mail20.mymailcheap.com
Received-SPF: pass client-ip=217.182.66.162;
 envelope-from=jiaxun.yang@flygoat.com; helo=relay2.mymailcheap.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 00:05:37
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, MIME_CHARSET_FARAWAY=2.45,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



ÔÚ 2020/6/9 10:47, Jiaxun Yang Ð´µÀ:
> Our current code assumed the target page size is always 4k
> when handling PageMask and VPN2, however, variable page size
> was just added to mips target and that's nolonger true.
> 
> So we refined this piece of code to handle any target page size.
> Also added Big Page support defined by MIPS64 Release2.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Sorry, this version may break MIPS32 build.

I'll send v2 very soon.

Thanks.

[...]

-- 
- Jiaxun

