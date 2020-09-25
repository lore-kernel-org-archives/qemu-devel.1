Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56ABC4727E
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDDC72087D
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 22:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycZtzxys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDDC72087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLwRd-0002Ty-Pf
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 18:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44300)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLwR5-00023r-Mw
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:43:27 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:55841)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLwR4-000339-25
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 18:43:27 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q4so224873pjh.5
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 15:43:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ypmuZZRQIP/OagQ0v6rAfFZPDtaCeI4EgKQfY3sv9Q4=;
 b=ycZtzxysQkGFKCUtHlxNr1GIXhq/kfNaSrqR1iK8CIC3sdVX2I+FKk8cbKGum67/gF
 UWhAW2lReHcFfoSYqxMdrOnGU1DTnUBSEY0+pt2szX7ikR7vJ+J16mmxGAEgR4enzN8V
 pWjzSv9E6TEokkTQOiBVPMZQi6JqBBUB5RvkYJ88MJ9WrTw25MTuSWC/v1pXTdyHC8tl
 KFarTBQmSZ3Hbum+lymslheB0NGOJsmS1tVIdUZDguW4WeSciGbjjgcsQ0XEHwTC4sgz
 yCBjUkEsXF1CHdlUmnQif+vcOL3LBFSn00vXaC3aEgRVVyu4IXMIUyuk85vdjdZHXkqb
 as0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ypmuZZRQIP/OagQ0v6rAfFZPDtaCeI4EgKQfY3sv9Q4=;
 b=lc2HX6Voty6xztXvOC3t0EzYo4dki8cSk7Bye8NSwSEHyHFGjbakjyTtx7VcImQv/0
 IpzRXALbF3ZgLvPwVHzkEp9mFG97yd7o1Pfs7dSRvAda8UeOvyPJtb/2n3rWK+QA6luL
 wOuArac+YCZZwX8z3pXaBzYHge2FXeAQKzo1IaxSJw/kqAlZqrBV/KSS27yjGeOS7ju/
 oIhhRGh64paL2QjGx65VlxOBj4wYNkyQpxqqDHwaF4B1HWR18+N8zkvpXsDkJXt1ehf/
 qYXoxxPUpS0e/vLVh00UPc9w5us5hu9ha8XgHTO5Raiwzs1bOUojoKL8tudSjj94/O8G
 kkeA==
X-Gm-Message-State: AOAM532ftyE7uHaoNOZ/Hg/AKUT2dDI2gFvT5uW5xVf5zXDQXsbRqUTZ
 ubZuTEy62JO9f4YNGXnERuVyFw==
X-Google-Smtp-Source: ABdhPJzXYlCxLKfoPIce90nOOP7Ehj5ETPa3BTg9ZDjK61NCO4u93nIclKJPui1gr0rjglhVaB4Jbw==
X-Received: by 2002:a17:90a:448a:: with SMTP id
 t10mr688278pjg.19.1601073804367; 
 Fri, 25 Sep 2020 15:43:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id e16sm3292103pgv.81.2020.09.25.15.43.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 15:43:23 -0700 (PDT)
Subject: Re: [PATCH v1 0/8] s390x/tcg: Implement some z14 facilities
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20200922103129.12824-1-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57838e84-d378-e71a-3844-60ed564d4f0e@linaro.org>
Date: Fri, 25 Sep 2020 15:43:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200922103129.12824-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.238,
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/22/20 3:31 AM, David Hildenbrand wrote:
> With this patchset, I can boot a kernel compiled for z14 (requiring
> Miscellaneous-Instruction-Extensions Facility 2) (using -cpu max).

Excellent.

Looks like it wouldn't take too much additional work for z15, if you're of a
mind while we're at it.

Message-Security-Assist 9:
	KDSA to ignore, like KMA.

Miscellaneous-Instruction-Extensions 3:
	A bunch of logical operations, all of which
	already have tcg primitives.

	SELECT, which can re-use op_loc with different inputs.

	MOVE RIGHT TO LEFT, which can't reuse do_helper_mvc
	directly, but could be a copy with trivial changes.

	Trivial changes to op_popcnt.

Vector-Enhancements 2:
	Mostly load/store byte-reversed.
	New vector shift insns.
	FP/Int conversions.
	Vector string search.


r~

