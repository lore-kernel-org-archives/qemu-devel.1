Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED4D1C32771
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B032465A
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 23:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DyIaH8FG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B032465A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irrpg-0002ea-UY
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 18:12:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1irroj-0001Rs-Ju
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:11:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1irroi-0001Ly-MB
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:11:17 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:37971)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1irroi-0001L9-GJ
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 18:11:16 -0500
Received: by mail-pf1-x443.google.com with SMTP id x185so9236483pfc.5
 for <qemu-devel@nongnu.org>; Wed, 15 Jan 2020 15:11:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=I4mPk1xFiq8gQFU3P93Y8xgcA4rB7BYe5F5zsE7N3dU=;
 b=DyIaH8FGkhu/CA+uVCXwbRLim9Q7CjinkDB5ERikPasYG+H8tU0MDbESXRkyMY/Rd3
 23bMzEVcEQJO9+beSpJeHoN9EvFFLG0xiSWLvBmslcPK7RQlAc2KpvhMEJizEvV1KQFv
 x/0W6C5ivtyD0noIk+YyR/TPNaIlO1fYAhwkGY8QZV7YRcfFCR1Yk0V5Z8PM+huMsqJL
 HXHxlJ3s+w37RF0NeBFNPFa2CZluPByHCmHncKheGXvbFlKpRp4QQ5Pj2NAUJIC1C5qa
 z7KOVByKMxfosJFUIduNBaoouUovOYBWOHPRrkjvC/caDLsWbcZJFRfR8eCOhpaGYL2o
 +0sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=I4mPk1xFiq8gQFU3P93Y8xgcA4rB7BYe5F5zsE7N3dU=;
 b=OeoZBFkKilTG91IbMmPQYzhQXxriLNli9ooRFL0mUFtdU8OcpUVcn6v1/bTZ08jOFp
 lmg6SHJ9MdeNXilQ2M3+XpOkvLIw9asOG68rK/fbJxMwKz9I9G3RchPds1071arheEV0
 i9b6kJ/RPCfVXXJq2oUSog8uG7OrhWnoWvf0hWEU6Y7KtLcfE4IRcsm6myhWTjYeeSGo
 f/AoepngWyjY0MslPh0cwSRzaiCbTKI9VjsyErFBMN77dpxmxo2/iLD7ljBOjQtCyMj0
 PeE/C6+u6W4V7Zd9FFGQ2Uknf3yEsIQZeYR44yxEuGnhlRpE8AttrW9Yiyg3cmZaecYi
 Ip8A==
X-Gm-Message-State: APjAAAUim9IlyCqlA3LrUwfIcfygXq1ZBKcrwcreZGzCl5hWnWG+vtnD
 7FXxK6rkJUipKlCXKNEaW8nGNg==
X-Google-Smtp-Source: APXvYqw1qe3S943tSAygc0/NJUhfiBkgsW4BSLbxPyF78qmuGDE02G9dMz7Am6dJMo7ZRekVXFvzGQ==
X-Received: by 2002:aa7:95a9:: with SMTP id a9mr33392046pfk.15.1579129875682; 
 Wed, 15 Jan 2020 15:11:15 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id u11sm485199pjn.2.2020.01.15.15.11.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jan 2020 15:11:15 -0800 (PST)
Subject: Re: [PATCH v5 22/22] gdbstub: do not split gdb_monitor_write payload
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200114150953.27659-1-alex.bennee@linaro.org>
 <20200114150953.27659-23-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0905799a-eb0c-e64e-eccc-38d9d517b1f6@linaro.org>
Date: Wed, 15 Jan 2020 13:11:11 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114150953.27659-23-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/14/20 5:09 AM, Alex Bennée wrote:
> From: Damien Hedde <damien.hedde@greensocs.com>
> 
> Since we can now send packets of arbitrary length:
> simplify gdb_monitor_write() and send the whole payload
> in one packet.
> 
> Suggested-by: Luc Michel <luc.michel@greensocs.com>
> Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Message-Id: <20191211160514.58373-3-damien.hedde@greensocs.com>
> ---
>  gdbstub.c | 23 +++--------------------
>  1 file changed, 3 insertions(+), 20 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

