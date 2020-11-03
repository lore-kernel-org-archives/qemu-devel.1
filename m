Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AF6BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5BDA20735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 15:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yp8KiMl0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5BDA20735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZy6i-0007o5-MD
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 10:20:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35716)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxW9-0006Ka-1T
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:42:37 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:42111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZxW7-0000oT-3F
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:42:36 -0500
Received: by mail-wr1-x444.google.com with SMTP id w14so18806324wrs.9
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=16qbstMSW1ZJQ3461Qdt/24IGxiWT5eayRIBeTOOdzY=;
 b=Yp8KiMl0TeePDKIdcV/wSW0yDOjUeMeBsM5qKWwpW+Fvs0KK7cxpuBJyCS3gqYkIff
 7Fqu6lpL0ZI/OL1nPnBu5LP/SwcVIDi0oHopgORgZNpgBtBzQqsYA0G2ukPe/wc/yOV8
 Pf5BLHGvBWuT/WUfvkR0zwzOAzpuM6/CALO69tuznA+307JXT+gh0YguC8Fu9Do1RGs9
 vLoE+W5XRsZExgAZhlvItroyZSWvIrwjdzCmkc0OW5Y0rZO0YPS78gUk4kG/sOj34zGJ
 d2EK+aWAIulwqNX6X3dcUbMsKGFZ1wXr3PZ3nUn08wClPwt9/aOiNFgBXuSazIwVKROo
 TyEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16qbstMSW1ZJQ3461Qdt/24IGxiWT5eayRIBeTOOdzY=;
 b=TEHjFO7MOoik5AUeWv62iN+IyuTeysQ97rYF78JmrKybWDxX/Y3Fa0+b+rrHVa+lQf
 DNusxO5JMjkdOxh8PW4+NW5Pmmg6geezFg56fL1osXpd7MyxY77/3nNcMzkGOVwTHJbK
 PUUydrPJem/+TV4CfRhvPu0BpwWwqY62KSwd4jG48NmP10FxBXcyw6ruRUbYAxyvuKez
 7hvouduXvkoDzZ01K8w9ER9Yg3h2dN5poCZ3Y+Uzn6pkZ9RwxZRrMT3FaUib/XDlbTUi
 DPLx24yqFbX8LNu59t7qJNzcrIRXuzkqINYL8bryfG23FYePgWtYLMjiKfTR8pj2yeCP
 rEIA==
X-Gm-Message-State: AOAM533U7L5vMKWdoQqpSIVocRFjHjZ8h//iTEEfiBuyqY742BV26xtT
 FVDyiMTG772nghJbaZhIepg=
X-Google-Smtp-Source: ABdhPJynxfgmdioDaBFUU0ZuQlZEv1gKoax+HdHNsjYUbgNSzHpvIUztj42HptferozTMlmdPs1tuw==
X-Received: by 2002:adf:dc85:: with SMTP id r5mr28183752wrj.66.1604414553529; 
 Tue, 03 Nov 2020 06:42:33 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id l1sm27979948wrb.1.2020.11.03.06.42.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:42:32 -0800 (PST)
Subject: Re: [PATCH] linux-user: Use "!= 0" when checking if
 MAP_FIXED_NOREPLACE is non-zero
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201103142636.21125-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <669c1343-f2f4-c9fd-89fc-1d8567ec6595@amsat.org>
Date: Tue, 3 Nov 2020 15:42:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201103142636.21125-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 3:26 PM, Peter Maydell wrote:
> In pgd_find_hole_fallback(), Coverity doesn't like the use
> of "if (MAP_FIXED_NOREPLACE || ...)" because it's using a
> logical operator on a constant other than 0 or 1 and its
> heuristic thinks we might have intended a bitwise operator
> instead.
> 
> The logic is correct (we are checking whether the host really
> has a MAP_FIXED_NOREPLACE or whether we fell back to the
> "#define as 0 to ignore" from osdep.h); make Coverity
> happier by explicitly writing out the comparison with zero.
> 
> Fixes: Coverity CID 1431059
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  linux-user/elfload.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


