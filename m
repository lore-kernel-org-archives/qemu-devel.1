Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9AADC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 03:33:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2A522241
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 03:33:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="chV+f+c9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2A522241
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSu0j-0002Lf-L2
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 23:33:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kStzv-0001ta-6D
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 23:32:11 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35749)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kStzt-000848-GA
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 23:32:10 -0400
Received: by mail-pg1-x542.google.com with SMTP id g29so1003280pgl.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 20:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VZE+Uu40Uph8/7yVio/VxSpnRye4Vu54oyvUkYyjjNk=;
 b=chV+f+c9E1Y6OF+yI+Siohhk2YOrs6Rm7rvDPgHtzTuT0YNqm0xmDh+yQK08zoYPz6
 ZHtq22xfcKBCnJqak/c4FQw/8y5L0A0rfZTfrrHhFFJGO4vB35El0mcws0ennUJCXf/m
 yAV/7ULbnoZlvBMCHcZryfPlGMwCTUkTOBhRY0tbMguwfDW4+9/7IPvgkH3Dfz0cCjCE
 0S4PESg1yU1aoHrsI2BmPfsFNTW3ZZVKlTkIXctjCGO+VNhT1edQ6Blh2t1LdYYOaViU
 WK95EMS1PmOU4mbw1NqBKnzafdgaEe3rtpkqJBrI4Slt1ceshCgxxkLBsN7SW0WagTMp
 Eq1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VZE+Uu40Uph8/7yVio/VxSpnRye4Vu54oyvUkYyjjNk=;
 b=ofrJpSzXkW+S/ReubCsgtQfFKM1YTgXYgPUMjgxLiMSCfn2d8bzKaxaff89M6M8PyB
 go7JbA+8Tq1FJehYef/w19CyEzs7MUc5IpFPcZhlfD2MEjrfSp9Nlldc70Z0BcZKsFv9
 gUureU4IdxIj3Bvg7UJzcitEacR3wff1HDiNAVIOaIK8BwMwWPWYChgOv8oVkLPP2OTn
 31JMURvzDVuTU/qyraYP3V1ZsDJu57DLA6FL651FWif6ZCEz2uu94p3uXqd+o2MhQPPP
 7CKWs6AdT34HxXQl5DkD86DSE8OmoGVMqCT2pc+b03a0S4lx3qWFtLqnY/RFvYpOEh97
 ezBQ==
X-Gm-Message-State: AOAM533lkeMfOSKfB/aMKnX7QGnbd2QPRFBtb95ferz43dQurECTTbvo
 an3W4Odbj/QCc3lAyY5Qa+FPJ1FRIQEvLQ==
X-Google-Smtp-Source: ABdhPJyBgcyOLvT8cWybaZ76XESC4n3vQJYL8Jg/L82Rlai999grZBy3Z/Tbm1dXLLlVZ/xGcDZ+BA==
X-Received: by 2002:a63:2145:: with SMTP id s5mr1616427pgm.288.1602732726483; 
 Wed, 14 Oct 2020 20:32:06 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id m3sm1084398pjv.52.2020.10.14.20.32.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2020 20:32:05 -0700 (PDT)
Subject: Re: [PATCH] qemu-palcode: Changes to support booting NetBSD/alpha
To: Jason Thorpe <thorpej@me.com>
References: <20201007025229.7487-1-thorpej@me.com>
 <c35e151d-7b9c-849f-e4a0-a9c62d9a31a1@linaro.org>
 <6896C79F-8A9B-4EFC-BC68-EE8856EFD2B6@me.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <709cbaaf-afe8-820c-9dd5-217bce626101@linaro.org>
Date: Wed, 14 Oct 2020 20:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <6896C79F-8A9B-4EFC-BC68-EE8856EFD2B6@me.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/14/20 4:16 PM, Jason Thorpe wrote:
> 
>> On Oct 14, 2020, at 2:52 PM, Richard Henderson <richard.henderson@linaro.org> wrote:
>>
>> I'm certainly open to these changes.  But it'll need to be split up -- one
>> patch per bullet, basically.
> 
> That's fine.  What's the convention for patches that stack on top of one another?

git format-patch --cover-letter
git send-email --thread --no-chain-reply-to


r~

