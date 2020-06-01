Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5606DC433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 204602076B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 19:49:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="V8Uh57Fx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 204602076B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfqQt-0005Va-CO
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 15:49:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfqQB-00053g-7F
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 15:48:31 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35927)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfqQA-0006Az-2e
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 15:48:30 -0400
Received: by mail-pg1-x541.google.com with SMTP id t7so3127069pgt.3
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 12:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9jSF1p3yhy971IG1fCGwpZVQlAyDNDHhSeqfmi8xI7I=;
 b=V8Uh57FxBXUdmt1i2fawliIs5CN29rbQLjcSS5wdRhL3Le6abC9onZr6ZPnIkJY66D
 qGYQWgcjaOyaaccsy58ekQt2+yM/SFqLplUTvhMNWV8731/D0Q/n8FUnLa6xMYm1oVAS
 Y+Xt52vIkDY0s1l5SaeM+wqEnqs+20OwUmix+qt3/SboEdbfaTX/4hPs0yZMLrxnz7LK
 fBF2FXA49QlDvWOYSbvlrn2YhuTgo/9xRI7Mvqfd/aSQ5j2XG/p3JBMTpzXQA0uqJrEB
 xyAY7+vqEhHx6UoWLOczH4phCnNAqYxM9mt29Uq3QdstKEOrNpaS54+tdHHiSkR3iNut
 hI+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9jSF1p3yhy971IG1fCGwpZVQlAyDNDHhSeqfmi8xI7I=;
 b=sJuDFG2YyLjIT38JiaXEedvwjzF+6FKsqiTx00Q4AX+Sd9vd4H1jPXgh83xEyBlo8O
 Qu39k4+aMRZe4trtagXzhy1ppRPMjVeJEj95iUg6g5O9+oHDzrhzyJkCc0YxfeHaIe3i
 VeuxQPXQ2u+K9sSWBeGScMz15c71px4mUbQGpMpffkFpwaMVI2vaJojyYpQJgrXH8gjl
 S/mi9SQMdG21OvYa4wCbpNxtwMFZQR5bPE3Vc8XoHR7YGmEHkvtaekLA7rDIUXdYnPtY
 FDFGOGt04wXxi7FFUJORoyQ3KnnJtk1jTcFOXueeBpQr1gfnSyL9Sb/OQSJtcArtyPJh
 JtOA==
X-Gm-Message-State: AOAM533EQpaWAmuYPTFgoU2KlTUNKfdd7eFjkzTKF3RuDvykbyuuFSNd
 5BqfJMKrdZ30tYqI48JH0QdSKkXk8ec=
X-Google-Smtp-Source: ABdhPJzqzI/0Uo4Cdnk92qnJxpZHIyABSraZtExP2V5DPdPeeebe4g3STmqqRqTwdVxaGXFdoweKjg==
X-Received: by 2002:a05:6a00:1490:: with SMTP id
 v16mr21164525pfu.173.1591040908111; 
 Mon, 01 Jun 2020 12:48:28 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l67sm211268pfl.81.2020.06.01.12.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 12:48:27 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] target/tricore: Don't save pc in generate_qemu_excp
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, qemu-devel@nongnu.org
References: <20200529072148.284037-1-kbastian@mail.uni-paderborn.de>
 <20200529072148.284037-2-kbastian@mail.uni-paderborn.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <973dfb31-169f-0f1c-c192-41c064ab2b50@linaro.org>
Date: Mon, 1 Jun 2020 12:48:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200529072148.284037-2-kbastian@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/29/20 12:21 AM, Bastian Koppelmann wrote:
> EXCP_DEBUG is the only user. If we encounter a jump in tricore-gdb it's
> target was overwritten by generate_qemu_excp() and we would never leave.
> 
> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> ---
>  target/tricore/translate.c | 1 -
>  1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

