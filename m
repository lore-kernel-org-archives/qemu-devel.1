Return-Path: <SRS0=Iy1T=CA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822CCC433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:02:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CEA02072D
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Aug 2020 20:02:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FEj97eSM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CEA02072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9Zix-0004f4-Jg
	for qemu-devel@archiver.kernel.org; Sat, 22 Aug 2020 16:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zi7-0003hv-Ay; Sat, 22 Aug 2020 16:01:55 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1k9Zi5-0002UY-UJ; Sat, 22 Aug 2020 16:01:55 -0400
Received: by mail-wr1-x441.google.com with SMTP id r2so4962665wrs.8;
 Sat, 22 Aug 2020 13:01:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IPbzWS1Lf8WQ58PA0cE2M9IiJQnSkZctlSfQKGn0nxQ=;
 b=FEj97eSMC8VwZc6V4eeV/ZdtXckmGKG6DMmL8Wh/z8MHs9afkNmdH7hxp0bRB0vhr+
 pCZ6uUxNOpYziWhYiL+juHS1BjUNghXpft/5wx3KEUuXWSD/C3+qDc8Zzqbsom5FTGSh
 AJpztgdu1IEFJR/OKo4fxiZEIURHJqbTpENPFaIrqs851FoXZM33AP5Xp48Dg/EJKVyG
 YY0E9Ro7dGkxvAaQoye9x61awOew0jJ6kpyrfMg0giAgAcbs6YHQYeIVmUXRRVSXCbxJ
 oJprB9/0sG9wcD80vWT4bWTQcZrb/dNKet5WP3/CW+b4XkuGZw+XO09g4fCMJ4i4laHv
 guNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IPbzWS1Lf8WQ58PA0cE2M9IiJQnSkZctlSfQKGn0nxQ=;
 b=QLLTt4NHjFZzT4TdEvsFhW63Ztovw7WqoSS69fKUg9pvE1r0J8vom4raSTX8z0eiYp
 NWEkeC3CTStM2lrvK5EOcVn48WjqxVzDxe216nh48PjUZLfDmLJ6SB2UEHAMKCXzfs9p
 dbfytBBt8K+F5a2+32wugtxP1mxqUtE+/vtypkHpQf2bunIbtUgugvLAKbvIMbpNac/b
 DVP/QjCmuzgjtkIlWlXswIVaQxJaXPdMXrQNIeEUHq1UMgcSquoAuZTVW60cwbLV4vuo
 sbPcUU4KNyrGSWpWlIicxeqaohx0JHIRAa4ieHc50wI3WmdKGNgPDpYew0CiR6VG+ntR
 QjAQ==
X-Gm-Message-State: AOAM533s79F+Gf6GiP8FY4zyLLpgR750HLzHf6XQSfztmzrqD4B1G8fB
 GmJ8XI/wFkCqj61H+gQO1ZgX9wxIXdk=
X-Google-Smtp-Source: ABdhPJx93Oq12ViR6ZQ1t0JiLUSF5pu9uu4pDY7y1nW2QcP/Q/98Ivh1llJgc6U3Ch+PU1h1qq0wYw==
X-Received: by 2002:adf:c552:: with SMTP id s18mr7882642wrf.209.1598126511989; 
 Sat, 22 Aug 2020 13:01:51 -0700 (PDT)
Received: from [192.168.1.36] (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id 5sm1988039wmg.32.2020.08.22.13.01.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 22 Aug 2020 13:01:51 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 0/2] hw/core/sysbus: Trivial cleanup patches
To: qemu-devel@nongnu.org
References: <20200806130945.21629-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <11f9df38-3bd8-3360-a13d-b91fcc7cb86a@amsat.org>
Date: Sat, 22 Aug 2020 22:01:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200806130945.21629-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/6/20 3:09 PM, Philippe Mathieu-Daudé wrote:
> Fix a typo and assert sysbus_mmio_get_region() is called
> with correct index.
> 
> Philippe Mathieu-Daudé (2):
>   hw/core/sysbus: Fix a typo
>   hw/core/sysbus: Assert memory region index is in range
> 
>  hw/core/sysbus.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

ping?

