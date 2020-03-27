Return-Path: <SRS0=t76e=5M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E051C43331
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:10:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93112071B
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2020 22:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HwBcxUbR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93112071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jHxB3-0001CV-5p
	for qemu-devel@archiver.kernel.org; Fri, 27 Mar 2020 18:10:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49854)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jHxAE-0000KY-9Z
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:09:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jHxAD-0002gj-8N
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:09:18 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:46208)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jHxAC-0002ee-V9
 for qemu-devel@nongnu.org; Fri, 27 Mar 2020 18:09:17 -0400
Received: by mail-pl1-x643.google.com with SMTP id s23so3942978plq.13
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2020 15:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=fpKTYRdPC59VS/tO81y54ASsJMqG0YJwBmkcDL7IWd4=;
 b=HwBcxUbR/MeBC1hcr+y+DGQLF4KoONMwADCltrjV2M8cFdpDhlpcy4TqCAeQMa+Iit
 egmbAEchjHe+78vnnggmcXrQfiokHM0MWVVilRv0nWvrHb8ramZvEXukm9abqIF8G/lq
 XbktSM7wClQJQ4xuq3TC0PXjv2WFm3kRacF/TlbO6TfmrK1JwoS8zdLp3cPK8C26CDSs
 nSmvuOH56+LCbxHr6F1MJZ7nnzivcPqx3O60cDPajvGBlz2UWptCW5bdsm6ygWXAUcJI
 m0hTcAaW9K9eL98QxS0wA2/7WS3Gl1Uxxt6VBwSVGCHjr9szKbQkOER2mlvHvUxxMqnd
 4CRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=fpKTYRdPC59VS/tO81y54ASsJMqG0YJwBmkcDL7IWd4=;
 b=OPDgVtfbfD4ALAlfEfYWUuRmk97w8DwOC7wVg7QU1LaT9tgro33WgADXAxc5Er/cO7
 TXNaKjUIsQtWNDwzZMCmWiWVTd0AMRvi2ccebspyEDYK0kiyUIaek9BCtJERsYC9ZCah
 RFfGgZrWkORIwC5qvaTnEPU1VU5hoF1K78NPx6fa66xoevr5glgwJKk6T2YbDEmn4O5C
 7LXysazbG5P98Zu8jSBmyQ7VQjA0xYHRdlTHcly2Cvwh+65gODGRq3PVMIXFirN2ZGH3
 q87lfLN1dicCI58ejF19wvAxfDK4W3Q55dHZxygBzcASnT3EVFLeuCJNMBh3QPGrwyGC
 rKyw==
X-Gm-Message-State: ANhLgQ1Cy8GPcVD7hmnNZYa56LfLcPwETomrQcV1HmhO+mLKnA8naxjP
 z9AaaHmmB2VIkP4Xr8+1vFMnNXK7wYo=
X-Google-Smtp-Source: ADFU+vuPiWNrMUgNasqa4yowH3BGHK1Oya9NbEAsPU/CsJhjD9PH7bbtGgv/mhw6+fbuGJxLjJ4sJA==
X-Received: by 2002:a17:90a:218b:: with SMTP id
 q11mr1599135pjc.163.1585346953920; 
 Fri, 27 Mar 2020 15:09:13 -0700 (PDT)
Received: from [192.168.1.11] (174-21-138-234.tukw.qwest.net. [174.21.138.234])
 by smtp.gmail.com with ESMTPSA id f129sm4885501pfb.190.2020.03.27.15.09.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 15:09:13 -0700 (PDT)
Subject: Re: [PATCH v1 1/7] elf-ops: bail out if we have no function symbols
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200327094945.23768-1-alex.bennee@linaro.org>
 <20200327094945.23768-2-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48f26426-f121-c0fa-030b-2f529192b474@linaro.org>
Date: Fri, 27 Mar 2020 15:09:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200327094945.23768-2-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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

On 3/27/20 2:49 AM, Alex Bennée wrote:
> It's perfectly possible to have no function symbols in your elf file
> and if we do the undefined behaviour sanitizer rightly complains about
> us passing NULL to qsort. Check nsyms before we go ahead.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  include/hw/elf_ops.h | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

