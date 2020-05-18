Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F6BDC433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:02:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81BD20758
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 17:02:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XiuQ6+iM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81BD20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jaj9j-0000TQ-0A
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 13:02:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaiwq-0006uw-V7
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:49:05 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:55090)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jaiwp-0000TL-Vb
 for qemu-devel@nongnu.org; Mon, 18 May 2020 12:49:04 -0400
Received: by mail-pj1-x1041.google.com with SMTP id s69so84398pjb.4
 for <qemu-devel@nongnu.org>; Mon, 18 May 2020 09:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=QqBK5oy1pAJk0QemcoVabpeWlrIR/NHTj3mqqHilHSw=;
 b=XiuQ6+iMpWBqV/8RZ9Lj/o8vx+UC6c2QmssajhvmY6K1G9ph2uuwLmHiaTd0b329B0
 lN8cAIce3qULchch4uER/+ZWfJQnv+h2H3HIw9utrwR0SYuB1IkqYtEkHIcBTx3hcBPg
 Qre5IvpuL+7+jUI9jOv9zqe7t0Umd3lVdwhN8iTzCPmSFl8VsN7+n2vAxI8eLHhYuSEu
 jHjogieY859ZHl32Iew012kbqtBRAuI1qgjLwyzBqbbf29uzHCgmtl05HEmsqzlBYkCR
 3IUgYQ9dcc0k3fksh4hhHL4JzVq3ZHhXOKoxkqbfFtnpYFL32FTX31CWsKXSZ7WKZPsE
 5Agw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=QqBK5oy1pAJk0QemcoVabpeWlrIR/NHTj3mqqHilHSw=;
 b=AVgr+1Mj6ojs1G5APNJb1sSeGhIVn3PImOroe+VACSuxAGu+ZX4JgGULSQsh5gmUxu
 oF3M7/1ODnqT4eHCx4MBngZKA/DBx5601kc2cJJBM+ENwec8REDkFcu2k5J+zhunPs+E
 DVbZ3FIgsNOUFm9ehf9XPi35irVfnrlblLe9e6TC6XBfdE9K0mon2jbmoP9uOzbnqh9q
 I97gCeT/m4oqOLOtPJXoP93WGPwi5nD+8347ME5OtPaMNXIh6kzkofqdmTGAOkFp3DUA
 LmIIeoorlI2qDJrRNr/1La7BN2lhkMiFb4ywiNetBtm9guXib4QWRQX54kkXN+h80PaW
 8mRw==
X-Gm-Message-State: AOAM530cnDJPA+erIeJQMTWxc8OQfsOQ5/kSKhKNA2Ic/NFy8SiQg0F+
 Jl4wEWCjl8XHyLGPMrQ71liWcQ==
X-Google-Smtp-Source: ABdhPJzJmMHfiYhkiFhlhrOnalpOKD3UO7qTYQ0h8Duv5z4utpsJFvR68QrlzTQYViYyRNc+SFByhw==
X-Received: by 2002:a17:90a:bb81:: with SMTP id
 v1mr295357pjr.168.1589820542454; 
 Mon, 18 May 2020 09:49:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i10sm9212798pfa.166.2020.05.18.09.49.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2020 09:49:01 -0700 (PDT)
Subject: Re: [PATCH v3 00/10] tcg vector rotate operations
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200508151055.5832-1-richard.henderson@linaro.org>
Message-ID: <a830f904-c420-add3-e5cb-cd46baa9b147@linaro.org>
Date: Mon, 18 May 2020 09:48:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200508151055.5832-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

On 5/8/20 8:10 AM, Richard Henderson wrote:
> Split out from the v2 omnibus patch from 21 Apr.
> No real changes, just a rebase on master.

Ping for patches unreviewed patches 3, 5, 6, 7, 10.


r~


> Richard Henderson (10):
>   tcg: Implement gvec support for rotate by immediate
>   tcg: Implement gvec support for rotate by vector
>   tcg: Remove expansion to shift by vector from do_shifts
>   tcg: Implement gvec support for rotate by scalar
>   tcg/i386: Implement INDEX_op_rotl{i,s,v}_vec
>   tcg/aarch64: Implement INDEX_op_rotl{i,v}_vec
>   tcg/ppc: Implement INDEX_op_rot[lr]v_vec
>   target/ppc: Use tcg_gen_gvec_rotlv
>   target/s390x: Use tcg_gen_gvec_rotl{i,s,v}
>   tcg: Improve move ops in liveness_pass_2
> 
>  accel/tcg/tcg-runtime.h             |  15 ++
>  include/tcg/tcg-op-gvec.h           |  12 ++
>  include/tcg/tcg-op.h                |   5 +
>  include/tcg/tcg-opc.h               |   4 +
>  include/tcg/tcg.h                   |   3 +
>  target/ppc/helper.h                 |   4 -
>  target/s390x/helper.h               |   4 -
>  tcg/aarch64/tcg-target.h            |   3 +
>  tcg/aarch64/tcg-target.opc.h        |   1 +
>  tcg/i386/tcg-target.h               |   3 +
>  tcg/ppc/tcg-target.h                |   3 +
>  tcg/ppc/tcg-target.opc.h            |   1 -
>  accel/tcg/tcg-runtime-gvec.c        | 144 +++++++++++++++++++
>  target/ppc/int_helper.c             |  17 ---
>  target/ppc/translate/vmx-impl.inc.c |   8 +-
>  target/s390x/translate_vx.inc.c     |  66 ++-------
>  target/s390x/vec_int_helper.c       |  31 ----
>  tcg/aarch64/tcg-target.inc.c        |  53 ++++++-
>  tcg/i386/tcg-target.inc.c           | 116 ++++++++++++---
>  tcg/ppc/tcg-target.inc.c            |  23 ++-
>  tcg/tcg-op-gvec.c                   | 212 ++++++++++++++++++++++++++++
>  tcg/tcg-op-vec.c                    |  62 ++++----
>  tcg/tcg.c                           |  85 ++++++++---
>  target/s390x/insn-data.def          |   4 +-
>  tcg/README                          |   7 +-
>  25 files changed, 696 insertions(+), 190 deletions(-)
> 


