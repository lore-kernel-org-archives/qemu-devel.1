Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4CD2C43457
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:14:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 551D720874
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 15:14:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V6wETX5p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551D720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTRQi-0001Cd-9K
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 11:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRPK-0000Bp-Vv
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:12:39 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kTRPJ-0006oE-6M
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 11:12:38 -0400
Received: by mail-wr1-x444.google.com with SMTP id s9so3305215wro.8
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 08:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=d4bZubak1ofOaZlpm2w7ygmdu97LzIwqAS6EPxWe/NM=;
 b=V6wETX5p7CNu5Q6vAIJ5qGC4iRc1NLKTVPeP5C7Pb+rNk162O/OT+s3izMBY7RlrCL
 JQou3tdjgj1Z7Gp4pcBOgp+VMvFDg1PV6iXPQZ7wE9Ykejc81kvQAGtKPKw52n3u+EGh
 bG6bsM+pjnf7gnG+KU7CCzTrkqXRZKT9VX25XckklhladuSL5jMNRhx2Rz72C5u4Uay6
 eyi1Gb1Fp9MJEUv5Bdndu97sLCkQrCCUh2+8wUMvUyu00CNdDN7RsxwNODjc0r9Mc3eN
 cH8nOe7NoLV1BGPMM4N+Ff+oFG3L0qRq0OTvsfWJbCgw9UH3HvVXtLYWGr3R36wi0dQZ
 sLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=d4bZubak1ofOaZlpm2w7ygmdu97LzIwqAS6EPxWe/NM=;
 b=q/tBh8UGNcD/QtWxFKO99/o2TlKgdEFd5iW47mQBrPplA7vV+Vm4NpbUkBOb4Ch0Ay
 +7KCRHN7JWom9gniVz3YLnPXvEyfOeGGXk0eZKTZlRTMPI9ziGU1ICOFVJ8USp5CLdWP
 IPy99TR01WVS+0ECa6V2hLrsO3qGYZxo/VehM2WtNxlNDZe4fszBa5ST3yfKzES+sjjY
 7dffGXC+hf+sv9vNliBE6JzVuev+eq9ELAzYyN2rFECGVepnv14iyn8oz8HXRWhxn6rM
 JYtoJMcvzB5a4dqgo9bH28DYiYea82feOfXEtgkYf9aA/ssPYgXywbhtP1R1SeaRGQM0
 eOKg==
X-Gm-Message-State: AOAM530Z1zzDJZp4X4v9dp3QwVaif20h7ZYe8O6Yn9dBgAD5iILOsomX
 T6mwyYKsMICWCYofjPKtZkA=
X-Google-Smtp-Source: ABdhPJzImQ9o3O1d7jB5kkgWTxzn3kDhw/VUElj9tdoGUlO3gE1gBOyTMEm51syQOciSDzwHHCfNlQ==
X-Received: by 2002:a05:6000:1046:: with SMTP id
 c6mr4435827wrx.218.1602861154295; 
 Fri, 16 Oct 2020 08:12:34 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f8sm3864670wrw.85.2020.10.16.08.12.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2020 08:12:33 -0700 (PDT)
Subject: Re: [PATCH V14 2/8] target/mips: Add loongson-ext lswc2 group of
 instructions (Part 1)
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1602831120-3377-1-git-send-email-chenhc@lemote.com>
 <1602831120-3377-3-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e4d38f9-b661-6a92-feb4-904a614f4a31@amsat.org>
Date: Fri, 16 Oct 2020 17:12:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602831120-3377-3-git-send-email-chenhc@lemote.com>
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
> LWC2 & SWC2 have been rewritten by Loongson EXT vendor ASE
> as "load/store quad word" and "shifted load/store" groups of
> instructions.
> 
> This patch add implementation of these instructions:
> gslq: load 16 bytes to GPR
> gssq: store 16 bytes from GPR
> gslqc1: load 16 bytes to FPR
> gssqc1: store 16 bytes from FPR
> 
> Details of Loongson-EXT is here:
> https://github.com/FlyGoat/loongson-insn/blob/master/loongson-ext.md
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   target/mips/translate.c | 86 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 86 insertions(+)

Build failure:

target/mips/translate.c: In function ‘gen_loongson_lswc2’:
target/mips/translate.c:5928:14: error: unused variable ‘fp0’ 
[-Werror=unused-variable]
  5928 |     TCGv_i32 fp0;
       |              ^~~
target/mips/translate.c:5927:18: error: unused variable ‘t2’ 
[-Werror=unused-variable]
  5927 |     TCGv t0, t1, t2;
       |                  ^~
target/mips/translate.c:5927:14: error: unused variable ‘t1’ 
[-Werror=unused-variable]
  5927 |     TCGv t0, t1, t2;
       |              ^~

