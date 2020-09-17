Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7A3C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:06:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13C0A2075B
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 08:06:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZ3vWpcE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13C0A2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38540 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIow4-0007fk-3K
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 04:06:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52774)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIomo-0003Ew-Bp
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:57:02 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43028)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kIomm-0005uX-Lj
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 03:56:58 -0400
Received: by mail-wr1-x443.google.com with SMTP id k15so948954wrn.10
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 00:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HL3zRK0nuV3qNcHAHpU0fldw/pUl1Ru8nVonYr0YVZM=;
 b=RZ3vWpcEmpJ0UDZFie0YopmhFjEJZ8hNzMsKpUB8u/4EHsB8C8Zjv/RU+gnNELZhDP
 hF3pQMwRDM5TcL635z3hWV8m9o/Ru+noH0C9B1wptzdafcIbJDkHRMZszEeBOGoTwop6
 g23CJ/ps1ZRBIBhFQQhhahamqo+XbVtk7khMk9Bi4qka3zyDtAlZRD6H7EOsELBgQkLS
 fEYrKR/WE5dfzTYM1DtJ+KoDClj0K0q/jnODOYxV3OOIXwxn826wUtZwi+fT5H10xmYa
 pakBXzLtRIjvuARDgG/WveHOrlVL1eBsZ/QQqDJA/hSYoDAQGIap8/G7JI+4B132y0/9
 /Zbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HL3zRK0nuV3qNcHAHpU0fldw/pUl1Ru8nVonYr0YVZM=;
 b=TBIV2CZYAglYryWOAKRT9ZqbVJnOJcKeqCc60ADKoMxHkFt0a1pl9I2u9F2QkOvy4D
 kz+t5vHKY15nD2tEZMHaru8MUAFIDLmN/sniBWH3gifIdM+w6l07xIZkprZ/CMF1fRmx
 bFU1Z3N64l6bTrTwVv0e6dFLdyRP9vWgNZTaY5+atwimcbzvg/HO5CowE3PW3agaw3r+
 u0GXY7UY3j6nYFMs4YvRN/GHAkTEgF68Ppx6SozJgraOhNvR8PpYWQmaUMQZKLDf9Tfb
 eSubl4WL1V2V2+5i/jPsvrng9vu/Xx0iowQs6WguSLXmPIoEOVa2mcJnOAL5olEmer/m
 obfA==
X-Gm-Message-State: AOAM530TDxQcvOI0pseYm5DmvB0eNf9mWErOaGsS8aA3l784DK4z+ar8
 N9AMhN3zORobDRN8Oafemyo=
X-Google-Smtp-Source: ABdhPJyJTJtOnQIBEp/YJxcUOSVMejGylzWkj3l4DmUs7xaaTJuc4WuL3hey1vA7e7wlnw9/OO8RUQ==
X-Received: by 2002:adf:e488:: with SMTP id i8mr32670030wrm.116.1600329414267; 
 Thu, 17 Sep 2020 00:56:54 -0700 (PDT)
Received: from [192.168.1.36] (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id 63sm10910765wrc.63.2020.09.17.00.56.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Sep 2020 00:56:53 -0700 (PDT)
Subject: Re: [PATCH V9 0/6] mips: Add Loongson-3 machine support
To: Huacai Chen <zltjiangshi@gmail.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
References: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c38105a-831f-b306-9250-8d0c43fc4108@amsat.org>
Date: Thu, 17 Sep 2020 09:56:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <1600222344-16808-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.062,
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>, qemu-devel@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Huacai Chen <chenhc@lemote.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Huacai,

On 9/16/20 4:12 AM, Huacai Chen wrote:
> Loongson-3 CPU family include Loongson-3A R1/R2/R3/R4 and Loongson-3B
> R1/R2. Loongson-3A R1 is the oldest and its ISA is the smallest, while
> Loongson-3A R4 is the newest and its ISA is almost the superset of all
> others. To reduce complexity, in QEMU we just define two CPU types:
> 
> 1, "Loongson-3A1000" CPU which is corresponding to Loongson-3A R1. It is
>    suitable for TCG because Loongson-3A R1 has fewest ASE.
> 2, "Loongson-3A4000" CPU which is corresponding to Loongson-3A R4. It is
>    suitable for KVM because Loongson-3A R4 has the VZ ASE.
> 
[...]

> Of course the upstream kernel is also usable (though it is "unstable"
> now):
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> 
> How to use QEMU/Loongson-3?
> 1, Download kernel source from the above URL;
> 2, Build a kernel with arch/mips/configs/loongson3_{def,hpc}config;
> 3, Boot a Loongson-3A4000 host with this kernel (for KVM mode);
> 4, Build QEMU-master with this patchset;
> 5, modprobe kvm (only necessary for KVM mode);
> 6, Use QEMU with TCG:
>        qemu-system-mips64el -M loongson3-virt,accel=tcg -cpu Loongson-3A1000 -kernel <path_to_kernel> -append ...
>    Use QEMU with KVM:
>        qemu-system-mips64el -M loongson3-virt,accel=kvm -cpu Loongson-3A4000 -kernel <path_to_kernel> -append ...

Can you add a KVM-only build CI job?
Simply building, not running test, as there is no MIPS CI.

See for example commit 41e1f0e2256 (".travis.yml: Add a KVM-only
s390x job"), but add it to GitLab instead.

Thanks!

Phil.

