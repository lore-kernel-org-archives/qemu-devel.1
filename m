Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C64C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A28120848
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 09:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tH9TcONF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A28120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNCAU-0006ws-N3
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 05:43:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNC9Q-0005pL-4R
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:42:24 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434]:33479)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kNC9O-0006iE-Ib
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 05:42:23 -0400
Received: by mail-wr1-x434.google.com with SMTP id m6so4631527wrn.0
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 02:42:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=dOzA/ubchZe7PsWAM4pH4k4+3NEeY6vyl2jglNRXqqE=;
 b=tH9TcONFxvbAhtjC43sF2COrH8cFSy6kau/ijWjoloWzWiPCNGSL+vngQ6+wZsUjny
 fdksrRC9TiCaHFuMagLtIByp4eUMhJ6M22LIELiydl66x3SUOvuOgAAL3QQg4DDWxcvU
 CaGeP7pjnia0VPnGHTNKHhlU2REZXUA0rmHs7zWeytQ4YBSCu2AwNjkWa6omd8jbysQP
 CBc4ajaNltqsNsDFbR5GgP0e1G2t0y15oKRGNY/S0THnGQuKU8iqGs3gyUMocfGph2E2
 ED5yFvs7PNu0CEFxxiIXxN7oHpoJpa2R3E1d8jI4V36Y4n/Df1gkMkqM59W6vW4npYiJ
 nBDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dOzA/ubchZe7PsWAM4pH4k4+3NEeY6vyl2jglNRXqqE=;
 b=HVHNi3bJzC298yOpbT1uio1y+SUflzq3vX88imqIAJxnCOf3j8kdSwLvuVe/zFBwdw
 C0LA7R9r7Mp+EN2b3XUSjAEsZMg+DLiU4bhMB8jV7uin6io3Es99+ZlSICgUrMEtw+i7
 y94yVL3Q8m3PtgFsD56SHYWvze/8l9jc6lPZHurUTdPqeiRKvKtL29FNtO2/K2cggznW
 kLncoume6PYIeNz/4qOyC4gqSqAbSfyBbRYM3OPdhiD1h1effhIGQEq6yLLnAz2LtNPZ
 wGRpWGSldU6GLZFwZ2Z5U+dqh0sS5qzvU3NeVa3Q1ZcYCj2C+KQXEPyvbyEjJxEgxWw7
 ZNQA==
X-Gm-Message-State: AOAM530fgiM/Dwa5UUj3NmG1yrAEWrOPQnCMZ9mpN1EVCHS8Jtqq+C8x
 Zk901/vPKFHSisdSo9Dsf+y61UZFfME=
X-Google-Smtp-Source: ABdhPJyI9E0mCY0xF7r4tbgoqq/Ud36M5xOQQNep7KCqZoUthNF9b/SpC4geNJjRZlBsSWoVSnu08g==
X-Received: by 2002:adf:e7ca:: with SMTP id e10mr3155524wrn.236.1601372540855; 
 Tue, 29 Sep 2020 02:42:20 -0700 (PDT)
Received: from [192.168.1.36] (74.red-83-53-161.dynamicip.rima-tde.net.
 [83.53.161.74])
 by smtp.gmail.com with ESMTPSA id c14sm5212957wrm.64.2020.09.29.02.42.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2020 02:42:20 -0700 (PDT)
Subject: Re: [Bug 1897680] [NEW] memory address over 0x2000_7ffc is not
 accessible in mps2-an505
To: Bug 1897680 <1897680@bugs.launchpad.net>, qemu-devel@nongnu.org
References: <160136265426.22784.9778102281742505477.malonedeb@gac.canonical.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <dccffac2-4cf4-c8b1-a253-baa257e6ced7@amsat.org>
Date: Tue, 29 Sep 2020 11:42:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <160136265426.22784.9778102281742505477.malonedeb@gac.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x434.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.199, NICE_REPLY_A=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/29/20 8:57 AM, Changho Choi wrote:
> Public bug reported:
> 
> I currently run qemu with the following options
> `qemu-system-aarch64 -machine mps2-an505 -cpu cortex-m33 -m 16`
> 
> For some reason, memory address over 0x2000_7ffc is not accessible.
> It can be tested in gdb as follow.
> 
> (gdb) x/x 0x20007ffc
> 0x20007ffc:	0x00000000
> (gdb) x/x 0x20007ffd
> 0x20007ffd:	Cannot access memory at address 0x20007ffd

Works for me:

(gdb) x/xg 0x20007ff8
0x20007ff8:	0x0000000000000000

(gdb) x/xw 0x20007ffc
0x20007ffc:	0x00000000

(gdb) x/xh 0x20007ffe
0x20007ffe:	0x0000

(gdb) x/xb 0x20007fff
0x20007fff:	0x00

I suppose GDB uses 32-bit access size by default,
so requesting 32-bit at 0x20007ffd would access
out of bound memory.

> (gdb) x/x 0x20008000
> 0x20008000:	Cannot access memory at address 0x20008000

For TYPE_IOTKIT there is only 1 SRAM bank (see armsse_variants[])
initialized to SRAM_ADDR_WIDTH bits, which is 15 by default:

    DEFINE_PROP_UINT32("SRAM_ADDR_WIDTH", ARMSSE, sram_addr_width, 15),

So this MPC downstream region is a 32KB SRAM. The size looks correct.

> 
> ** Affects: qemu
>      Importance: Undecided
>          Status: New
> 


