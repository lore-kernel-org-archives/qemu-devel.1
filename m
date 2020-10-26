Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86556C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:24:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D871020874
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 18:24:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0SracGb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D871020874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7AD-0000yG-PO
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 14:24:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6zc-0000Cy-SV
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:13:16 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:44202)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kX6zb-0007OQ-9U
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 14:13:16 -0400
Received: by mail-ed1-x542.google.com with SMTP id t20so10399256edr.11
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 11:13:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PIE9DEg3zRFso+AOQRE8wxGu3eIjoDiB4Q/heeIrdv4=;
 b=I0SracGbwneeMUIFCZReLgk2+TKFkr1F0dzturhWy0cN8b0rBFaoW6VeOBSnSDRkTv
 OxvLUWWFaKCX9SeyQqJy/U4/igX3H7/qxQAamsni3/OySw4dbUEn+wkPMr8LeCx+Sw29
 7GQHlU6KyUzizstN3e70YNWbgtc97f9T+940udFYKDbe2DP3CS4Ar42OCSlRE83O6X81
 hc06U8zea1uAeU0xv1SgXueccF6l84x1iADxOIG3ycvQ+RZ34xMTAWZP6rNbc5KifcN8
 JNugnWP+YOrb0F1tjpIY6SylEp98yenfkLSvSTFJ3uuXxd42slx7540k8o3+CFEp0oLG
 LRTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PIE9DEg3zRFso+AOQRE8wxGu3eIjoDiB4Q/heeIrdv4=;
 b=ip/n764Auf6wQjZPX9SgH+mrEhSTYbDRXRraDUhLwXHAjAuynGE0XEwRbfsCGvptU9
 xEO+emEGuUdFlyy/nhYG+NEE1Bfsb9oZo71J6IhyORflC7N89q8tuelpbthuKH4XYSKA
 9QBgrnFGCGDgkzfKZIiXsuDt8g8yxwsnU/fzdT1zscpzyh1svA07LwQdOehbg0EfWOzc
 USAkTRGFrhuDEP+BppIfczmoV+mpEaT8wxO5d24Juzi88Rz5V+mg7xO38vJZROjKJdhM
 19yrFj1NnfQtPpdzhrdceXBjQ/HdM7J/ou1rZN1Z53fYfof4aKJZDaq88+FTEsAzDJKY
 xuAA==
X-Gm-Message-State: AOAM5326bnJos2wCraQZVDVeMmSa9g/u5LGsoSoKzRnGivDRp/trSrfZ
 cKqGX/iEzcpOU2vC6YTJ7p1tEmsRAUs=
X-Google-Smtp-Source: ABdhPJwiXD/1UcrpmLnfmzswdggsw881112tRQGIW/e+DTpaQceEnVamQ+AYE7ViNdXRuDEcfTDfWg==
X-Received: by 2002:aa7:c915:: with SMTP id b21mr16931568edt.25.1603735993903; 
 Mon, 26 Oct 2020 11:13:13 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n22sm5675161edr.11.2020.10.26.11.13.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2020 11:13:13 -0700 (PDT)
Subject: Re: [PATCH 07/15] m68k: remove bios_name
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201026143028.3034018-1-pbonzini@redhat.com>
 <20201026143028.3034018-8-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <5c123916-f622-2123-fc94-1889cce8badc@amsat.org>
Date: Mon, 26 Oct 2020 19:13:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201026143028.3034018-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/26/20 3:30 PM, Paolo Bonzini wrote:
> Cc: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/m68k/mcf5208.c   | 10 +++++-----
>   hw/m68k/next-cube.c |  4 +---
>   hw/m68k/q800.c      |  4 +---
>   3 files changed, 7 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


