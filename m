Return-Path: <SRS0=EqPw=EE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8105C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:11:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EE24207DE
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2020 18:11:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BHzvOVp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EE24207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYCOS-0004aC-TE
	for qemu-devel@archiver.kernel.org; Thu, 29 Oct 2020 14:11:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYCMo-00040r-If
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:09:42 -0400
Received: from mail-ed1-x541.google.com ([2a00:1450:4864:20::541]:40766)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kYCMn-0002PB-6w
 for qemu-devel@nongnu.org; Thu, 29 Oct 2020 14:09:42 -0400
Received: by mail-ed1-x541.google.com with SMTP id p93so3992324edd.7
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2020 11:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=npm39rVCtRUuhuExQMVvmubeSQnasn/ifnbygZnPT2M=;
 b=BHzvOVp4CtRZs+upESHgmauHETe/lZ/knBD5JimC3u3bylvxbpwZSOtpI8R6W69kqj
 bOjxhTmNI0MjbdE278exJz7yGc9s3XmPp8Stm8YvC4MnnJknqAVY8+YeHZgaX5uxHXi1
 uSc3WR16cDOp2COm5wT5JDlJyl3gN9eEWNcqqj6j+PbWkOuPVujlBEB4UkS1DzRyzP9q
 1Jcq2Y59xM72zpqq8ipbNVxNGFAXr1J4w7F6VTCZyBjTAFGTunnDDyXDPgxWV++WnV0+
 6ZpnUvFNqyO7B8mlFci5phHBIQ3C8tBN+pGJYVS7Fxdv3IvhUjkCut92CzUpxnswaNmb
 F9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=npm39rVCtRUuhuExQMVvmubeSQnasn/ifnbygZnPT2M=;
 b=YoYqCc4F8U18t8Uk14wU8Kzi7ONi8krgkkgKt3BlWohXADRFg7J+7eIHRR72ccO/4P
 mw8NC2oxg0BBXLSGIgGu7YfKMc0Lf3Nph23BiCH3b7httq1RcOT0bji125axX1LPFpbr
 5nmsMTPe5yNqaie4mLcS0h3NytfwG/EXp8Z8NJTHJZ0+twGtd3Fv1Qqci5KOdflh8OKs
 mC9xBncqPZvRM7pDPIL8QgwNlaUjEmi2Yqesme/UGadj7WW6Ql6PbIHluPc3KVxCbGHH
 IAoItUZY04WSWx+lAqndCG/nGO5dKTj46Sr6UPdDSkgjqUlY3V2Jxyqdd1hCL544Lads
 wgPw==
X-Gm-Message-State: AOAM5302jSY8HfAVrxTFLW7CKBqvsYK4LimSm46a9xJKqWwbLyVihevj
 DIjSnvitjX1dNza0A9Hb0IQ=
X-Google-Smtp-Source: ABdhPJxVKGSHJXF2XltK3MBE+kkJ9RnWtbl7boNX4U21W3N53QQ9/qclBOg1AkTaexgpAXS1YxAIXQ==
X-Received: by 2002:a50:9e0b:: with SMTP id z11mr5493031ede.341.1603994978133; 
 Thu, 29 Oct 2020 11:09:38 -0700 (PDT)
Received: from [192.168.1.36] (234.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.234])
 by smtp.gmail.com with ESMTPSA id n10sm1905702edo.55.2020.10.29.11.09.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Oct 2020 11:09:37 -0700 (PDT)
Subject: Re: [RFC PATCH 01/15] qemu/int128: Add int128_or
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20201021045149.1582203-1-richard.henderson@linaro.org>
 <20201021045149.1582203-2-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e59fc7f6-c626-3b5c-6e8a-8d366950eb66@amsat.org>
Date: Thu, 29 Oct 2020 19:09:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201021045149.1582203-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::541;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.261,
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/21/20 6:51 AM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  include/qemu/int128.h | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

