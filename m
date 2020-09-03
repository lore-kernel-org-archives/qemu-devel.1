Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CEEC433E9
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:04:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5806B206EF
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GxSAIS43"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5806B206EF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDouy-0000ns-E3
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 09:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34102)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDotz-0008KT-J1
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:03:43 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:54048)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kDotx-00040d-72
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 09:03:43 -0400
Received: by mail-wm1-x343.google.com with SMTP id u18so2800361wmc.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 06:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=DHFTQwOikxwnvnXXEmWXb0R317Ak4X66NgI6Lf3StRk=;
 b=GxSAIS43KhWGlxogYq9vCuPJ1NljRiZjlHHQJnCQvqhuyjS091N6AfhA3GfnHlxhDI
 0+SYTdggaHzwjVRhC9glzoE8hh1NOl9NDooKlVFbn6hYEpawl4gyGwiWUNm04keHq8Ud
 VJvsTsmN6fW1aWYMuBU6X7E0vSC9P43iT6uE9056u6hVikPE4WUsYGWs4EagAKkodq2m
 IE0fwagdetMlvzQ0xPHVmhLIvt62T9nMmOEyfUvCh8q+X0bw6KBc7TAowz/RGIY8l8Ok
 G1FWEA6U6EMH9m2uK2awkX2DkiQzQQTrXtG7HEz7OO5KNEyhfPib4LwI96tGuDPyFN8N
 PqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=DHFTQwOikxwnvnXXEmWXb0R317Ak4X66NgI6Lf3StRk=;
 b=aHg46s/EobWEm9lDcQOnBmrHSrVKZvfsxkDf1bBHrE0LK4iTp4sqlgtdgirX9VYyr2
 39zTxzMjVOTp3cHQuwMLkks2aP+KFuUE7INJXoxMsYiP2e2dB/EbLFqe2G2xK+unV9Ky
 vpeKDyqYLTKWfd/qNIUagCrilL/KdDbUpXK8DhGDfrv5jToN8XYBrjGnI1tQ/tHsyRzl
 0bFbaK9sJc7kmq9uUZzO18o51mVUC82rTfM68L8mZSqU0IWtsc39z79OqUEG7+PfPGTd
 sIbWTqurNCpHrJAS0HJdiHp8GecGZ6qgUrBmjKFlPfiDEZ/DFV09rzQTDDGXjM/CzlVk
 Ab6A==
X-Gm-Message-State: AOAM531NLtjNcLhlWgyHji0dQIeNEd7n19nS6hGm7VePHEBXRHAl2qTP
 uF8alN/ZDhbxl991Tu1HOKA=
X-Google-Smtp-Source: ABdhPJw1/8fTetqXNn3hqPd0yTj8KZW7Sahxzivp2sgt6XIQEgc8oPXHaW9lENIIh6wxOrNGgBmCqQ==
X-Received: by 2002:a7b:cb19:: with SMTP id u25mr2296191wmj.113.1599138217338; 
 Thu, 03 Sep 2020 06:03:37 -0700 (PDT)
Received: from [192.168.1.36] (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id g8sm4373756wmd.12.2020.09.03.06.03.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 06:03:36 -0700 (PDT)
Subject: Re: [PATCH 48/63] sabre: Rename SABRE_DEVICE to SABRE
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
References: <20200902224311.1321159-1-ehabkost@redhat.com>
 <20200902224311.1321159-49-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <eda4b708-4279-6605-456f-e4a89722b87a@amsat.org>
Date: Thu, 3 Sep 2020 15:03:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200902224311.1321159-49-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.001, NICE_REPLY_A=-2.403,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: berrange@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 12:42 AM, Eduardo Habkost wrote:
> Make the type checking macro name consistent with the TYPE_*
> constant.
> 
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
> Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Cc: Artyom Tarasenko <atar4qemu@gmail.com>
> Cc: qemu-devel@nongnu.org
> ---
>  include/hw/pci-host/sabre.h | 2 +-
>  hw/pci-host/sabre.c         | 8 ++++----
>  hw/sparc64/sun4u.c          | 2 +-
>  3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

