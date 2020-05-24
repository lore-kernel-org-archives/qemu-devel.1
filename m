Return-Path: <SRS0=Dt9u=7G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B1BC433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:55:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D205320776
	for <qemu-devel@archiver.kernel.org>; Sun, 24 May 2020 13:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jKV0KjLI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D205320776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcr6L-0001fe-1y
	for qemu-devel@archiver.kernel.org; Sun, 24 May 2020 09:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcr5k-00016g-BU; Sun, 24 May 2020 09:55:04 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33017)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jcr5j-0001LG-5z; Sun, 24 May 2020 09:55:04 -0400
Received: by mail-wr1-x444.google.com with SMTP id l11so14859473wru.0;
 Sun, 24 May 2020 06:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JUS3cCHpJpqYqc4UCWRawizAk5CJylaqWikvTc4pC0Y=;
 b=jKV0KjLI/6JvdRvlK04mNEydsCdwwpSdflFuTsFZPyU6LEfqJE7Enf51lqZLn1pY/5
 /BPcoGWcTg0oH99xgDLQZrCC7sQe7ZY8w9rLEiBgACDBuDJGDXHYg1pQaggKoxV/SRBZ
 gv20kSP5DmCFSq3ERVEIey6rx3zhIK6r1EdUleuF+glGAIYNeF8QT9zE2fmk0od82N33
 IGaRNdEfByJbLQCb8xS90aiDD6g2KmFbxeRUFb7F5Ym9/qa5BFNKpA1YmS1WAP+YgetR
 YtcTnzksNBYxS2AjKZOBIK8jn7je6AEPCcmJnlCta/xhQoGthJlyMU2ahsiW6MOW6xt9
 PEgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JUS3cCHpJpqYqc4UCWRawizAk5CJylaqWikvTc4pC0Y=;
 b=kvQOXFCEAkKdT6454DobYyKFB6i6LJVJ2aAkS4Gce6Xdq4M123AXzoM7jx97G1Bmcg
 G2MBl3wU2sj6MboHUfteSMbIvYSMWa1GF00dzFo9YROh9fogYPGIG4/Y8ewOh4oWxJir
 0ktQ9JM3C8nvh4xpj43hBnO7M0zI5DPnb/UI0vcxcWLczAHiWVNqAUIDYNlQuZaMs6eK
 BxIu3DgK9yD5fHnx5m5Rx+yKrq9gxIQ9xwbm/GWX3fpUdnZaFUt2zJwlN9vluQQUgRia
 09ZoR3xmcxOkG66xtZV+kFmwe5Y7nvhoKU8QmrOUHsseTpv23CdGB0LpNleFXQEvb6vU
 xTOA==
X-Gm-Message-State: AOAM530h4sQ43kbYp1s99OUEqIT7tbwgBghmPBSVfI072LzBFM1hqw66
 Yk5SzxnNQdNFm6MtiDhv/wZK08KR7Tg=
X-Google-Smtp-Source: ABdhPJwAWb4G3OSfkNCqBqKDRroIWVHqtepxMWXRB8JshWq2r7Qksjg7DGRWFKxk3zFdNlo9yCEK9Q==
X-Received: by 2002:adf:eec3:: with SMTP id a3mr11923084wrp.164.1590328501245; 
 Sun, 24 May 2020 06:55:01 -0700 (PDT)
Received: from [192.168.1.39] (17.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.17])
 by smtp.gmail.com with ESMTPSA id h196sm7656697wme.22.2020.05.24.06.55.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 May 2020 06:55:00 -0700 (PDT)
Subject: Re: [PATCH 0/4] hw/display/cirrus_vga: Convert debug printf() to
 qemu_log_mask & trace
To: qemu-devel@nongnu.org, no-reply@patchew.org
References: <159032319028.25024.16341819742251742761@45ef0f9c86ae>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <57d7ed92-03a2-023c-52c5-95ea77cba659@amsat.org>
Date: Sun, 24 May 2020 15:54:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <159032319028.25024.16341819742251742761@45ef0f9c86ae>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
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
Cc: qemu-trivial@nongnu.org, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/24/20 2:26 PM, no-reply@patchew.org wrote:
> 
> This series seems to have some coding style problems. See output below for
> more information:
> 
[...]
> 3/4 Checking commit 0b01a633fe92 (hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead of debug printf)
> ERROR: suspect code indent for conditional statements (16, 12)
> #31: FILE: hw/display/cirrus_vga.c:1038:
>                 if (s->cirrus_blt_pixelwidth > 2) {
> +            qemu_log_mask(LOG_GUEST_ERROR,

False positive. Checkpatch is confused by the mis-indented code previous
to this line.

> 
> total: 1 errors, 0 warnings, 156 lines checked
> 
> Patch 3/4 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
[...]

