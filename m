Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24117C388F7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7C120735
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:32:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oWKZAxyN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7C120735
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvUd-0006mD-JQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:32:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvQX-0001rg-NN
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:28:41 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37467)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvQV-0002Ym-OL
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:28:41 -0500
Received: by mail-wm1-x344.google.com with SMTP id c16so12596806wmd.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 04:28:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uhGC4Lj3O7Y3kXbKqJhAKXme8iI+ZV4oZWNulwIo7Co=;
 b=oWKZAxyN5AqFwDOo+4bn/xdrkY3D1IM3JpJp9T1WOuIpY7P5BJTbYRusZZZtsIv6w6
 5suzdkGN606JmM+aXCSOsEVyk9Odoj14KkFu5O15gsr8CstSiC5AtthmAyTgdblrAoUW
 IUc2Olwu5ihX+8wIMugN4LnnHPVuZ4hSltIPihu6POvMtKX93z/4VBvVybTlT7wIX6sj
 9s1mkibS/n8KXTjaMS0u9f7q37hz1iUQn8BWClWFv5222Cf5/jK7T5DS0WW62cegA2hb
 hTfGOAWAAOJoUlKqUL9YDNSvCpE30jlD2/Sdio3gTeiXA/6+MbjuSP9eOjIHLlQU0Ay9
 HHAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uhGC4Lj3O7Y3kXbKqJhAKXme8iI+ZV4oZWNulwIo7Co=;
 b=JdBWyUt5VxVxGVDSh55AZvT3kA21Nogglb3/D7fgDwo7OXVwas4zioBq0BzbpULjI4
 ecKvgeOKUytBOTDXLyYx+c3uabOd3rPFk40zrx0TTRjRxqBh2SIvz/Sw5w80Oj4wTpqh
 O1QhMrFTGhL85ZJLA4b0d65gZdjSguCaYpMbK2WbXHkcaGdSRdAevSrUs8dRNie2zTYh
 sNvd9o86rKoB7q+NgIAcCLy3AmBuBvZY+oEVcpOw37LCR5IBCRmiaqEQv0jaljzcmSg5
 DSzD+q7WZ2nQXV1zbKxBHNfCnzCPngzT1MCyBAkBnrQW4cLfGF5V28I2hzYVd1ejcPpd
 EVwA==
X-Gm-Message-State: AOAM5319tgsIruSRMLakhbkawYgKhYrEc/GeCBIRkIy2KI+WEm1eqpD3
 VGG2TCYM+j3IZFjdssT1fTn3sOcJO9Q=
X-Google-Smtp-Source: ABdhPJxECmHwIJ7TsKJg11F3W+yIsPidMpxZCtF+qM4IPBR3jd+Rql+ABL/AB8BA1ZDV/NVpqfpPgg==
X-Received: by 2002:a1c:b402:: with SMTP id d2mr3539355wmf.128.1604406509795; 
 Tue, 03 Nov 2020 04:28:29 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id m126sm1946534wmm.0.2020.11.03.04.28.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:28:28 -0800 (PST)
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: AlexChen <alex.chen@huawei.com>, chenhc@lemote.com, jiaxun.yang@flygoat.com
References: <5FA12391.8090400@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a4915556-bc78-a8c4-c887-f53ed14251b6@amsat.org>
Date: Tue, 3 Nov 2020 13:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5FA12391.8090400@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
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
Cc: zhengchuan@huawei.com, QEMU <qemu-devel@nongnu.org>,
 zhang.zhanghailiang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/3/20 10:32 AM, AlexChen wrote:
> According to the loongson spec
> (http://www.loongson.cn/uploadfile/cpu/3B1500/Loongson_3B1500_cpu_user_1.pdf)
> and the macro definition(#define R_PERCORE_ISR(x) (0x40 + 0x8 * x)), we know
> that the ISR size of per CORE is 8, so here we need to divide
> (addr - R_PERCORE_ISR(0)) by 8, not 4.
> 
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: Alex Chen <alex.chen@huawei.com>
> ---
>  hw/intc/loongson_liointc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

For a model added in 2020, its code style is a bit
disappointing (leading to that kind of hidden bugs).
I'm even surprised it passed the review process.

Thanks for the fix.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

