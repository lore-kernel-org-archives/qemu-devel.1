Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26109C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:56:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81AE8206DF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 12:56:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L2ckTC9z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81AE8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZvrR-0007wp-Br
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 07:56:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvqi-0007Wf-FQ
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:55:44 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35190)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kZvqg-0003RY-9y
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 07:55:44 -0500
Received: by mail-wr1-x441.google.com with SMTP id n15so18487675wrq.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 04:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=x7lMPQdoMp7EdD4ZNAzp7F7pjGjb3P7bcrxnBZBo2xI=;
 b=L2ckTC9z1gOZcI2WBLDzPYLP4TFF7g+qdfF0tmE6rJq9y0SkeKOrOvbzPqydDuVoGe
 V/RnykOrbMR5BtBKKePcUdedA2AGGGtuxAQPP0iJCLECpnDDSnL1JwXO/N8CdyEDOzpc
 3mrBm96RpxYtLVPbmK0rP2mPfUB3rMw6nFl5PVYJk7jBTsdwMCaHlGNeeYzEsRq9h37Q
 YQRgJ2r2ll9qwRMM4m65jWysYCAapkfA/2QIGJQDB4Mm8YbisourEAXwenvZEf18xHFb
 mWCXZeVjuFltE950J2Xanjruq2ij1u/GZLzX3Y4S5Q7B8S+ZPDS3qYw6Zwr8zXeYPRkJ
 XTjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=x7lMPQdoMp7EdD4ZNAzp7F7pjGjb3P7bcrxnBZBo2xI=;
 b=W33NiqYKPBLu27h29pvn/MFgsLoZNNHovJtV5g8GWQ+BmKxhD14cBAg7IfUkohF41I
 JJhfISDhRmnvwzh0NXBl6RVSCknfRpK881SfdW81wu7uHdOhZIkUhEN7RRcjTPHTyJVj
 yvujcWPcpBcGUpOtucMQ0n8CwJh5mFegejXnpkEHX+7dxi4tfv53reHc3YYzHt157dMb
 the3zOCZSbi/KGqaFW+RsRaV3aHyVXNSQhSyXaZkj1nlIaX9ApWb0tr22HXeEuUlMnYK
 9P5xZ18PGoF1DMLVUzSoTL2HhPHoh9SDMcf7oep8wFsha7pt/zpAvKSQOSl3AWJQL+E4
 6gAA==
X-Gm-Message-State: AOAM5324UCsNzlXvkrKt3y37Ubp9YJmqkZXE7hPyyCwL0wS6KQKtkRPL
 R+kdI1aCVDHpDg7jPvDTwSU=
X-Google-Smtp-Source: ABdhPJzjxYLCL2JNqlFtchn90S4YC2DxCJHtxxI0P0DlvGxzfoZkfIMaZL03JSMW3x1timbI2c3O7Q==
X-Received: by 2002:a5d:6acc:: with SMTP id u12mr25826156wrw.159.1604408140621; 
 Tue, 03 Nov 2020 04:55:40 -0800 (PST)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id s188sm2820274wmf.45.2020.11.03.04.55.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Nov 2020 04:55:39 -0800 (PST)
Subject: Re: [PATCH] hw/intc: Fix incorrect calculation of core in
 liointc_read() and liointc_write()
To: AlexChen <alex.chen@huawei.com>, chenhc@lemote.com, jiaxun.yang@flygoat.com
References: <5FA12391.8090400@huawei.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2d48c2b1-e70f-68b2-a785-fe3daca8d3d7@amsat.org>
Date: Tue, 3 Nov 2020 13:55:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <5FA12391.8090400@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x441.google.com
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

Thanks, applied to mips-next.

