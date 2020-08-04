Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F72BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:42:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0331421744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 15:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oV0m3Gns"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0331421744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2z4j-0003vN-9k
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 11:42:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37950)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2z45-0003Mq-Ob
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:41:21 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:50889)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k2z44-0000js-9n
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 11:41:21 -0400
Received: by mail-pj1-x1043.google.com with SMTP id e4so2330294pjd.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 08:41:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=icwaD3ONbbys87ArRJGLhZ1dgH00TxYUTCKLqJ8UDdM=;
 b=oV0m3Gns00Sfsrcjpznbw2BdOte2gLe75Vasr7IkAZyafqzJFxE9oicvnZ6c4+92J1
 AVxj3lKRXxix+82Gldjgxvsd4u1tfGZ0SYg1lZAWF9KWWYKWDectjmvDHh8Ext6UWOYf
 RsPPoTEvrM3Px0HXY4/UCmLGZtrQw80pp/KVGLz7c7kD5y15LE2A3LKg6TLonq5bfvwh
 W1hjqzSpaI7I5Vh/gYhHYOuX2N28uEIeBfaqXPob7dZnnsOYh9MirUV4sLo5MlZNKIN6
 sybdDI7ka2NqcOG1cqEB5o/FBXNcfUI/SndCaXRkU46Fl8q7TPLKmCH0KE4kgR06Qa3u
 a4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=icwaD3ONbbys87ArRJGLhZ1dgH00TxYUTCKLqJ8UDdM=;
 b=Sor8WtMzt/DXryHO79i9Z3Ug9uMlNStrlWaMg18VGdCaTB2yOpfUYBQqnH03o81cBe
 foUO+iBhK0OUpPAHlfGF2AOjSTFIygh7GfMAnCj6y9YCVu8y2DaSFLRJAvmf/3RhpY0C
 nL5pnx+9//Jik4UXc++vxnUAVcUSJQ0y4nPFjL3tBcGoupMFua8uw10HdxMUr3gXc3Xi
 eIIk271IR4g2vNPhgEo7QMnT9U2L95Tz5EHGJzSs9OjUdX/pdQ+jNSUIknZeNN//pGk+
 LgUQ1hTHeekiXxPpZlhT/REmWRcm7wMLbqidA5gsHo1/PiyiwuL3WempYjYp3M/etVMX
 qQAg==
X-Gm-Message-State: AOAM531bb40FY9h8dfDbtgr4mjJt8kU2gu88sWYOlxHaVZP7Iga2/lZ6
 FYu5HR1EBl+QzMzY8orcTD5d6Q==
X-Google-Smtp-Source: ABdhPJxYCOeh/Cso1uqUDEKjWKvM5sKWaHvdtA4VN1oWTplCkn4wFb31GcIlE4uCSH35vzKCn5llSQ==
X-Received: by 2002:a17:902:e906:: with SMTP id
 k6mr20342458pld.333.1596555676240; 
 Tue, 04 Aug 2020 08:41:16 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id g9sm6760200pfr.172.2020.08.04.08.41.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2020 08:41:12 -0700 (PDT)
Subject: Re: [PATCH] target/arm: Fix decode of {LD,ST}RA[AB] instructions
To: Peter Collingbourne <pcc@google.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20200803222656.63936-1-pcc@google.com>
 <CAMn1gO75w=oaCp2TjhFzr2nrbKhHOP6Q20bnvuuAzgSVe+thMg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1c14ed0a-da1b-a265-d5bd-2dea42764032@linaro.org>
Date: Tue, 4 Aug 2020 08:41:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAMn1gO75w=oaCp2TjhFzr2nrbKhHOP6Q20bnvuuAzgSVe+thMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/3/20 5:21 PM, Peter Collingbourne wrote:
> On Mon, Aug 3, 2020 at 3:27 PM Peter Collingbourne <pcc@google.com> wrote:
>>
>> These instructions use zero as the discriminator, not SP.
> 
> Oh, there is no such thing as STRAA/STRAB. I must have been confused
> by the name of the function, disas_ldst_pac. I will send a v2 with a
> fixed commit message, and another patch to rename the function to
> disas_ld_pac.

It's called decode_ldst_pac because the Arm ARM section is called "Load/store
register (pac)".  Page C4-311 in the F.a revision.

But yes, there are only loads defined in the section.


r~

