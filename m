Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 207D8C433E7
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:13:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51A9020866
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 14:13:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YjbDaT5O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51A9020866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTQTg-0003CD-7g
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 10:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40980)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQT6-0002kR-Cm
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:12:28 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39594)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTQT4-0006jU-MM
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 10:12:28 -0400
Received: by mail-wr1-x444.google.com with SMTP id y12so3106790wrp.6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 07:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=cKbMwCtgrm2XBy69b+k+8gfixiclGXZj2ZI3VZNnh30=;
 b=YjbDaT5O77aENW9+4oXATvc89iC9bLG6Dw5gX6UZC3zyGmtptCVblpQGgcDAkCMJ+B
 9mKOe+97sE7ztxGR2uauSrb6rdfHKoTQo+ofZPI9iIoY1z/scr7LjEfzWHfYrQKUIRKg
 SW6gznX8FceGmaAtd731rzTfcY0UzbvvUZ/OcfvPl8iRWN5x65ImNtPiOvdfKtIO0UDe
 scqwJPPIY3hDz/zKSskLPocEqY1w2At0egTC22ov2x+JTUhQ8lb8qkAj1sJh/JV+84nB
 8/tr8Vtbv+va+6XW9nB1d5L6XryjpDvBRke+xOm2G/B7EQmdzA51++hJ+rO/A+BEjy86
 L3Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cKbMwCtgrm2XBy69b+k+8gfixiclGXZj2ZI3VZNnh30=;
 b=Rf62ZEYzVOgu1xykcUbWnt4SRQf0h4OpgahxobFqO9NJwHfKNoBcZ/gCBwMc7kZC8V
 0YYyOGW/CjBfXBvFXZWFC1KeDaUlDfDF3qQEpCxv0DgWDeRyFtpZGoKalrC6VhkNpih1
 S7YhItMVuyXsYCDURXhYPPJvu2Ag9Q84FlJdqxthoqShkLo2wZ0ZIbRONG5i8U3slxLf
 VUELiT5vSa4FmMd6eEOkBH8y0/cbzxEPsSbc8nAnuKqEmV9YxyC6n8Z774Sax8gbsUMo
 R6gwSpnbRPo0Jn6txpcoM2OtJXsCPQOjyYIHLs//FDd7oa7B87L9SrPz4pR7v8uXOq3/
 MmSQ==
X-Gm-Message-State: AOAM5339zsm7HSQwVGSIitidt1azlLBz9MHLok5EmIGJ0/HK4kEs1j+4
 1xeDUxc7pjmT7Wfs522YYJ8=
X-Google-Smtp-Source: ABdhPJw+Zk3/1omXngjqB47wZvyBcbSoOLYqGeDeHTjDyLHShKteaFNNes04Hm+5AzUHpWPg+wZlcw==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr4096027wrt.51.1602857545011;
 Fri, 16 Oct 2020 07:12:25 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t12sm3769088wrm.25.2020.10.16.07.12.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 07:12:24 -0700 (PDT)
Subject: Re: [PATCH V14 4/8] target/mips: Add loongson-ext lsdc2 group of
 instructions
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-5-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9342a700-74ad-6c34-e2eb-46875899a73d@amsat.org>
Date: Fri, 16 Oct 2020 16:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602831120-3377-5-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.253,
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/16/20 8:51 AM, Huacai Chen wrote:
> From: Jiaxun Yang <jiaxun.yang@flygoat.com>
> 
> LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
> group of instructions by loongson-ext ASE.
> 
> This patch add implementation of these instructions:
> gslbx: load 1 bytes to GPR
> gslhx: load 2 bytes to GPR
> gslwx: load 4 bytes to GPR
> gsldx: load 8 bytes to GPR
> gslwxc1: load 4 bytes to FPR
> gsldxc1: load 8 bytes to FPR
> gssbx: store 1 bytes from GPR
> gsshx: store 2 bytes from GPR
> gsswx: store 4 bytes from GPR
> gssdx: store 8 bytes from GPR
> gsswxc1: store 4 bytes from FPR
> gssdxc1: store 8 bytes from FPR
> 
> Details of Loongson-EXT is here:
> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   target/mips/translate.c | 179 ++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 179 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


