Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B07C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C2532068D
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVBr3Bsr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C2532068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUJ2-0002be-Al
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUGc-0007F0-BY
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:44:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40335)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUGb-0000AD-Nr
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:44:54 -0400
Received: by mail-wm1-x342.google.com with SMTP id r15so1995271wmh.5
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jS61tJlHZiFmME9R10JS8InkHphE33vjnBCN0Mc2K70=;
 b=HVBr3Bsr/ZZ+KP/B1Y0tzyYtZj4KplaOuVWqI4/9BTUNgUkyqmsPPnGgxifQENodny
 Rdoa7xoAXdet8v4rt0G1mJeYqlDky5RIFGZQ1vAz8iRYBCO1wFtoR055vxbcYpS/I0kC
 e84EJAb2ZhqcNY3ywb8rtwW+FDs6aEkeSuOGeG3NqyLFWymMhahTTJe08B1wCTqjl96K
 6R5uVNIkC5h9xctZy6yfRLHW8HpoLOra40KBFNlNT5/J22POlDEdUtjSwzdAhR7UpOl8
 vu4uqsMtobGa8sOxDvwFsW5Jj4D4mga9ze7tAmqGaJuoXjS0PnIeUxzOqZSBjyjsmqRK
 Ziyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jS61tJlHZiFmME9R10JS8InkHphE33vjnBCN0Mc2K70=;
 b=iRyi9qiooIJXF0HkKlq52xRlK65DI/1TVi42nAThpuGEZ+xa7DHpz6DMRf31cWNE39
 aI86PxeYuBQUEPLr6mHBKDx+foATPyYw90jHiAPQQtBUsxQZQOJ8qv9LkkRTGdW8OQ+z
 ds2Cnys9bHd7QRmcdRrBVnWMapM5weiwxvgr5xSmPwRkcsUjiN5PQv3y3Lk+xqEycNoP
 tRW9AEv3vzRx1i49XjiquItbi+BzwsztDb1Bgwk8ThUNuJygSe85EwotxV9nFVGuLhzv
 1vAY8nFXL/wtGDiYJ2W5Si1KprXUVTlcg69w4SoO3iBZDTnA2xIqPC5UG2VjDGrapWTB
 Mo0g==
X-Gm-Message-State: AOAM533D+dV/QVdr/Y5lQJgqS4EDdzTwbUnjl8aUkuQDnbpT/7L6Q+l2
 oqT14e6yMbsSv9ula3nh20o=
X-Google-Smtp-Source: ABdhPJxRSf4zMou9sD/N3j/fD+ihMW00QSkEAsyyWYFP0K/FEwA5fcWrJkLkgQopaV8WH42n1TVDCQ==
X-Received: by 2002:a7b:c413:: with SMTP id k19mr139086wmi.124.1590479092466; 
 Tue, 26 May 2020 00:44:52 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id u3sm11742989wrw.89.2020.05.26.00.44.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:44:51 -0700 (PDT)
Subject: Re: [PATCH v6 17/21] MAINTAINERS: Change Aleksandar Rikalo's email
 address
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <20200518200920.17344-1-aleksandar.qemu.devel@gmail.com>
 <20200518200920.17344-18-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ed0ead1b-50a7-3595-d81d-ab3e5419562f@amsat.org>
Date: Tue, 26 May 2020 09:44:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200518200920.17344-18-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x342.google.com
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
Cc: aleksandar.rikalo@syrmia.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 10:09 PM, Aleksandar Markovic wrote:
> Aleksandar Rikalo wants to use a different email address from
> now on.
> 
> Reviewed-by: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>
> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>  .mailmap    |  3 ++-
>  MAINTAINERS | 12 ++++++------
>  2 files changed, 8 insertions(+), 7 deletions(-)

Thanks, queued to mips-next.

