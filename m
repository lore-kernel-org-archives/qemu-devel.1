Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5302EC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACAE520709
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:41:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FXvA/geY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACAE520709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36200 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtaB-0002cW-Qf
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:41:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40248)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtYp-0001ej-Op
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:39:55 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:39451)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kQtYn-0007tW-52
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 10:39:55 -0400
Received: by mail-wr1-x442.google.com with SMTP id y12so5189358wrp.6
 for <qemu-devel@nongnu.org>; Fri, 09 Oct 2020 07:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zgfnGkPBA3qkybEVDjdheXx2JxGRwcxImG5qqCyNfAM=;
 b=FXvA/geYUG8yRgnoGAfV/n5prZHnERN7s/Ga5wgwGCqn5xpNRQ9FPGUdVY27dlfMaw
 24Ut4omrDt2rCDWYjcuZfY/Xmk72Mp9iTGRFe2/MLM8RmzJzMeTxdBaHXCVRTPzo0cY6
 bYO6DtMdycFuTJmkKWbu5xHAX6g2MToOkIK34Ls4SPMAV6hwYjIaLqMTN0wu8zCJxWHz
 /ytnQbtgDnJzveaAy6kSjyvOmSxGJ9fqwVlwRNNHV/lwMoLSRPOZFKNsiXUXZGs/9pan
 NKyC5ESZvFhrf0fEUzZfhIqnZPttdsPn/fcmQMDxF1gJPXRdFht0kRtGAR1KYYLpyh8A
 /sLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zgfnGkPBA3qkybEVDjdheXx2JxGRwcxImG5qqCyNfAM=;
 b=ipY9XlHy5SQ+2mJ1AW+SYNBsMOyXE7xPL8iyxnHrBJ9sjFvNYPwxHCz+QAcoQg7uqr
 ICuSHYVfzxf9EKWNv2KgS5DuE+Weo8GP3MdfGQn36VL6OStCP/AlfZlYJ5j5jWuvyR/d
 v6HIB/e6kUytfMkxG+2YKFanMfzkIpmFNGi6l4FEA/UJTe27Z91pfvwoqnK6uReTMQ7u
 c5QTwRP+zIkgowFOwC7PNvCwDpkolcN1b4VAcJ0UkOBS3kabawG/bs860BXaXObsYxqo
 cvV+c9Ofkmu9TxWhLWJ4oFndbTEA/EjVpa2/tGzaoxXgc8K0igEZYZQcy0ahqP6AZag3
 0eUg==
X-Gm-Message-State: AOAM533TCgqvHj36ynSnWwdACEGYpGboQoE6trS5HWNhuAWd3SNmu0iU
 BhfQP+s8THhoCPkK1EkUZSc=
X-Google-Smtp-Source: ABdhPJwa6sWOCEtXmChGdEAvrntvfmq0ZPNeBkuzAkDm8aradBsfGWYqxkVFdMCBRg7BsUaH6Pvnyg==
X-Received: by 2002:adf:9507:: with SMTP id 7mr2374602wrs.365.1602254391219;
 Fri, 09 Oct 2020 07:39:51 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id t12sm2899262wrm.25.2020.10.09.07.39.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Oct 2020 07:39:50 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] target/mips: Demacro helpers for <ABS|CHS>.<D|S|PS>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 qemu-devel@nongnu.org
References: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.com>
 <1602103041-32017-2-git-send-email-aleksandar.qemu.devel@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <74dec616-dcbc-28f8-6e3a-a5880de1f110@amsat.org>
Date: Fri, 9 Oct 2020 16:39:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <1602103041-32017-2-git-send-email-aleksandar.qemu.devel@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.208,
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
Cc: peter.maydell@linaro.org, aleksandar.rikalo@syrmia.com,
 hpoussin@reactos.org, chenhc@lemote.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/7/20 10:37 PM, Aleksandar Markovic wrote:
> Remove function definitions via macros to achieve better code clarity.
> 
> Signed-off-by: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
> ---
>   target/mips/fpu_helper.c | 61 +++++++++++++++++++++++++++++++-----------------
>   1 file changed, 40 insertions(+), 21 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

