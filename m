Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80484C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E7F2206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 16:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tsu/EkZZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E7F2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDFK-0006Jl-HV
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 12:48:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDEb-0005tm-Qt
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:47:49 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40967)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jtDEa-0000Vo-BT
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 12:47:49 -0400
Received: by mail-wr1-x443.google.com with SMTP id z15so38435175wrl.8
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 09:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=HXWBxb2lo8UYckhDJIb2cbmMTH7ZdneKGs+GmaZyiqM=;
 b=tsu/EkZZFsZB5uK97UrwNw3ExvTRWcUjRTAtRji7TZlz8bVN09l1CzIgyxOG/SBoCv
 GaBo6BW3GJq5onzhfUb3dG8FcVxK4hIqjHG/dB5Z6+hEUjFiY+ujbhq0YvT3Ryy+4OUt
 EWshsW3vs11dN/AKQ7i+Q27b+vbDmqEI50YYDQZ2D03K3ddjpYG9/og5ORAW37eoOn4f
 jl8xPlBtzay+jtGfRQ26PEuaE5KPkifUKSxebx4+he8u7G9xwl6HwkTindmHk6ynoVFe
 Ut77o+peiHar1alX8O0CtHzmBuidE1l+oBJirWSdjoQW1/Hn7RWOzMLoDyyCH6XbrfiC
 dfOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HXWBxb2lo8UYckhDJIb2cbmMTH7ZdneKGs+GmaZyiqM=;
 b=pnNqxLWmJ4Kceqi4DL2ETa4l9raBEexvaooxYA/IUUPC4UBCsIJ55j+tkP6g1cjWsd
 i3+oxGCdmopKCIufxTbfewBq58ucCXnnWbaSQ1to4UbefaqRwl2AvHNVZAVZlFyVTE2W
 Xw7d5+RsbG1MWJTV78zGkRiSGwHIvbsjW5LB2N2S9HBiFiOGvDqJSZBcTHidGdx5lkji
 nXL9T2OLfzoXizWnrdzFRko4tTOv4dPvz2qPTnTcOUJnFveXRqXszGGpcULk/gam44Ex
 zhhrIgtilxcScZKmOhg1pDb1nSoRID151adSpaC/R3nP583IE6uCicRuhhiaML9B30Z2
 yzag==
X-Gm-Message-State: AOAM530zDhJNGeKUliytn3o6Tqayp7VhwdoC6ifp9VkDJWWGMm9JofvR
 pnccgb27diwR4YcgMXpOxQhH8ESK
X-Google-Smtp-Source: ABdhPJzwwSerzqOeAJD9eIoIsLgpZFi2C+r2qEn1VCmsTX6yq8Qf4m+WJEnPpFXE0+Ttx0FlwhOY1Q==
X-Received: by 2002:adf:ecc8:: with SMTP id s8mr60306389wro.317.1594226866852; 
 Wed, 08 Jul 2020 09:47:46 -0700 (PDT)
Received: from [192.168.1.36] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 133sm499964wme.5.2020.07.08.09.47.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2020 09:47:45 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] linux-user: fix the errno value in
 print_syscall_err()
To: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200708152435.706070-1-laurent@vivier.eu>
 <20200708152435.706070-2-laurent@vivier.eu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <90e3b430-25a8-eaf9-c8b4-e9c1b4051b44@amsat.org>
Date: Wed, 8 Jul 2020 18:47:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200708152435.706070-2-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/8/20 5:24 PM, Laurent Vivier wrote:
> errno of the target is returned as a negative value by the syscall,
> not in the host errno variable.
> 
> The emulation of the target syscall can return an error while the
> host doesn't set an errno value. Target errnos and host errnos can
> also differ in some cases.
> 
> Fixes: c84be71f6854 ("linux-user: Extend strace support to enable argument printing after syscall execution")
> Cc: Filip.Bozuta@syrmia.com
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5235b2260cdd..b42664bbd180 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -731,7 +731,7 @@ print_syscall_err(abi_long ret)
>  
>      qemu_log(" = ");
>      if (ret < 0) {
> -        qemu_log("-1 errno=%d", errno);
> +        qemu_log("-1 errno=%d", (int)-ret);
>          errstr = target_strerror(-ret);
>          if (errstr) {
>              qemu_log(" (%s)", errstr);
> 

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

