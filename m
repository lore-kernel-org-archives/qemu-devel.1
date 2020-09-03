Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C9BEC43461
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:30:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB9BC2078E
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 23:30:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnN4IZVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB9BC2078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDygS-0007Dm-Uh
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 19:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDyfn-0006UG-0i
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:29:43 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDyfl-0000Li-93
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 19:29:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id 67so3326488pgd.12
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 16:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sWZrdOr+hyJlFaEX0DsuADiJp0wzUs+ahhr3CwYA0FM=;
 b=ZnN4IZVgpej1zkciRYDqGNiblWDjwj6YNqKga4c0KAL+NaPjlC4nW9gmlrju18GD0m
 9tPLD4iPG+aU18teNcLqkllZCipTy/d5ZoCyWCmWvY2DaE9kwC/21alym3DmVgqlykeD
 hHQHHcwfEBopXVJ5r1pkeYDxbkPcZadlIaGcHqSoBIRgcetEDo15pVJdVQbaiRmrSUYE
 Ot+VQOzVLPDKsw3VAz4uR6hYA/6kjY3IeqXp15fRzk/HIdTULNhEz4N+wvBoJYkl2rzf
 eDLwfuo3Jg5IETguPBPV0aKVGICrOA3QS7Aq2KQms+JEzW+8/wp+rIHWAsQPaCcjjDmS
 eAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sWZrdOr+hyJlFaEX0DsuADiJp0wzUs+ahhr3CwYA0FM=;
 b=E1xaRaHa1+FLPipcbCU8MJh2iz+YuZ9/kn39XQ3JiRmRGcRLpTBed6r3km8LHWBb+G
 V+C3aYf3eU6XLXcCA5KYxttNlbFe/bBS18QNybKKnAqvH7mcY4G7zPMai2o0mit6jQMf
 WH2kIn2RgO0GZvIihhLMbfKTZ3YNviPPA9X74JSL1NwOBFEMnIugRj0DDVXlNkLfaikJ
 zIEzW0sYryE2GPAOl3og8P5chmW4S5XEYI+3+aAb8T5H2lbI7PUle5u3Jw4QEwUxIOaj
 p2yZg0LW/9iDFywrhOdazRZXpEjKhoukgIa8zlBtRxQpKq21eN/zXa5LAV9hvqKFs+90
 gljw==
X-Gm-Message-State: AOAM532B3NNtCVSjQbG+ELEp5ky41Q9hSkgIOwNkwEVhIVIKAxCOOxRZ
 KYSrvXzynG0U962itZDJI9IVlQ==
X-Google-Smtp-Source: ABdhPJwDcyaXE0aZSv92888hbFV7yKKoco3TOQm0fdMmHEUaCfl/iUpy2cRq+Bj9PQF/31DrdpBePA==
X-Received: by 2002:a17:902:6b45:: with SMTP id
 g5mr6434988plt.163.1599175779513; 
 Thu, 03 Sep 2020 16:29:39 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gx5sm3430410pjb.57.2020.09.03.16.29.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2020 16:29:38 -0700 (PDT)
Subject: Re: [PATCH v4 03/12] tcg: Fixes dup_const link error
To: luoyonggang@gmail.com
References: <20200903083147.707-1-luoyonggang@gmail.com>
 <20200903083147.707-4-luoyonggang@gmail.com>
 <8c5dd495-abaf-7abc-2ba0-82f13bbd3d02@linaro.org>
 <CAE2XoE8w_H+_N9AMgssSheWsTWwvoiOTgYdgCZG9g5cyHLbdpw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bad12717-dbda-ee88-2fa7-e6eec4e3d6a4@linaro.org>
Date: Thu, 3 Sep 2020 16:29:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE2XoE8w_H+_N9AMgssSheWsTWwvoiOTgYdgCZG9g5cyHLbdpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.403,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/3/20 2:19 PM, 罗勇刚(Yonggang Luo) wrote:
>     No, really, as I asked before: what symbol is present in tcg-op-gvec.c.obj
>     without this patch?
> 
> The   tcg-op-gvec.c.obj are missing now, maybe skip this patch first?

Yes, please.


> Anyway have same name with function and macro is not that good

That is a valid point of view, but it is not a bug.  The standard C library is
full of symbols that are both macros and functions.


r~

