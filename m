Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E56CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4576120776
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 07:53:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zw953In0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4576120776
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdUOR-0008Ei-Gk
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 03:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUNn-0007NM-Br
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:52:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39324)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jdUNm-0001zV-It
 for qemu-devel@nongnu.org; Tue, 26 May 2020 03:52:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id t18so5345122wru.6
 for <qemu-devel@nongnu.org>; Tue, 26 May 2020 00:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=wdev1s7KjvvIcNueXqW+t/a+tw1QrpmLymHbZ8n3ifU=;
 b=Zw953In0DkMt3Ad3P7yFI3tcFZVfWYWNoh2bnT+iwcG17BaRg/CER0fWa4Mre8b9JF
 ZAMa0jxRA+WEvHUINKfyv42uwaFoYwRwmwow9B+gUcdwgWqTo6orDPlQjZ5yaSlKpLMK
 8zZW/JnRFFkiLbCndmbs4+XVwTqRGWFqyJAylc9soaoMvjha8hvnm1agJBjaXqb1uGzp
 vQ2Rsm36jwQybPKJpKMr4IKT/oq8RRuGqc3IBQ5caPq9AHP+3lW8B6Pg9MQzJJo0NcK8
 ehdWfxsedo/AGdw6rFle6C0nhFzRhGBoVsgvk7dAoPlKezA9A89TwKDlvFp6vzcq8NF5
 q0Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=wdev1s7KjvvIcNueXqW+t/a+tw1QrpmLymHbZ8n3ifU=;
 b=PoMPqEIDPmX6GXiItPM4nm7AtkU3/i3tEepSOccS9O5QcAo3hL4SxL/Yv5+7xurwTv
 B9R+VoEY3CIAaxdmgbIttoY2TMZRVNPzI1LB7EIext3DPE/goG3/EbGZRwqSf23FVH0x
 /jZuOueca2ewhzaYi2acJsv2lnU3929qpEfJ/fD0EZu7+Z/UMwu1k9FIidosOzLZUfA6
 fl/4i0xtBuZIv+24kSsOzsj3NW3bbOr97VoLwJ7uiyKpN59ZitLj7l/iS2z9qI0ISMlh
 +ITfNBeSqwnoNRwDBmHlcvpR9Ds81PmsGVLRInD2Ih+naZiptHuPCpSxBt1xiBwdUE04
 Ciag==
X-Gm-Message-State: AOAM533DantL5LPxGmNmkPiWxS8KcVsVPB7zi7QBbae6RNrZaAC17DXx
 Y1UDKbl4fd8qdGg6DdSYHuQ=
X-Google-Smtp-Source: ABdhPJyOzsEDslJ3pAg9mHMwYwfARfng8HrIDXg3W9hB8hbwJ3Xd3dVZLVLlbJO0M+Mglj6JRN7cVA==
X-Received: by 2002:a05:6000:110b:: with SMTP id
 z11mr20038392wrw.16.1590479537112; 
 Tue, 26 May 2020 00:52:17 -0700 (PDT)
Received: from [192.168.1.36] (71.red-88-21-204.staticip.rima-tde.net.
 [88.21.204.71])
 by smtp.gmail.com with ESMTPSA id h15sm15658666wrt.73.2020.05.26.00.52.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 May 2020 00:52:16 -0700 (PDT)
Subject: Re: [PATCH 0/2] mips: Minor simplifications for KVM use
To: qemu-devel@nongnu.org
References: <20200429082916.10669-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <48bd89bd-f1b3-1a74-a29e-312275d09b9a@amsat.org>
Date: Tue, 26 May 2020 09:52:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200429082916.10669-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
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
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Huacai Chen <chenhc@lemote.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ping...

On 4/29/20 10:29 AM, Philippe Mathieu-Daudé wrote:
> A pair of trivial patches while reviewing Huacai's
> "KVM target support for MIPS64" series.
> 
> Philippe Mathieu-Daudé (2):
>   hw/mips/mips_int: De-duplicate KVM interrupt delivery
>   target/mips/kvm: Assert unreachable code is not used
> 
>  hw/mips/mips_int.c | 11 +++--------
>  target/mips/kvm.c  |  8 ++------
>  2 files changed, 5 insertions(+), 14 deletions(-)
> 

