Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE83FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:09:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81ED9204EA
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 18:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UnoEICwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81ED9204EA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb6gO-0000GM-Nh
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 14:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40368)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6fj-0008Hy-V6
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:08:59 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:37355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb6fi-00059C-Qe
 for qemu-devel@nongnu.org; Tue, 19 May 2020 14:08:59 -0400
Received: by mail-pg1-x544.google.com with SMTP id d10so207541pgn.4
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 11:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=9Jje+G+dwiL2UEzrOi9arB5uZxwp+Eq0nj2C155nxCI=;
 b=UnoEICwiGJc9tL7mykC9BpksmdSeptjPq3/ZuUNG38Z6s3UCR1rGOoi7KD39VpB+Th
 blgsxCjNg2CvhXZPNJKI1oNAr/+fYUcLfR3FM1rnJd7RVhwvpFyb29cWm4qwG2tiOSlN
 9wTKw//S6qiXrJ44up6+EAKxd7iHmXFYvi+HXy61c5qY35qccl9rUtERyXp9dym75xH9
 bXExqjAUBukuEUNU1tDIEyN1Vc+z+yJv/ToWxZIwXKdOhD4KqPJfFX3kNh52lXMdCQ4u
 GrYU0y2PE7kqCu6H/+iu80Ibj0uoUNjxmaALm8lb8h9DZtaE34CGFpKTz6uKI2Nrgqh+
 IGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=9Jje+G+dwiL2UEzrOi9arB5uZxwp+Eq0nj2C155nxCI=;
 b=EilhkVQW8xr+8Z9edHePkyWvy91ox9czjiEbSEbzxanFh+XjC17kdpvRP2oP7+AYiH
 QvGGxRXgCJsqkCQrlCfMI3On1+JVHz1yZdtArmMKms4jdv4CpN6JFL6mmtVbiNq1Kssq
 wXqiAbE6lLLhvButuoFsIsR3iezdNqeginNRkLlX847W1tPtrQ+KDE8fu6CBk4pHEzzW
 MvwX6YpQqol0wPzDG4AlBGmyVN2Wqq+gHt3jtMP6BqoT3Ve8BguE+FhXWxD4aFDIJcW5
 4FGmcvb7gfLAEWW+2iWUvB6oPUd5B5uh7E+lakrRBM0NH+jABmTCcy0R8qdcOiwVbT+j
 3fcQ==
X-Gm-Message-State: AOAM530RvRST2NJE9/tfvhcByLOU7gD5/9H07a3bv2sLTleoR7QAxNbh
 rd5mkBY5yke1kVE18NW3oH/wPA==
X-Google-Smtp-Source: ABdhPJxe6MqLWwQ9iCsbse3sJBq9WqoK04HTFlch8Y8H4kXdgsp4pT9IcYlEh4e2Md1UpYeJ151fBQ==
X-Received: by 2002:a63:db57:: with SMTP id x23mr418475pgi.94.1589911736215;
 Tue, 19 May 2020 11:08:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id g18sm135242pfq.146.2020.05.19.11.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 11:08:55 -0700 (PDT)
Subject: Re: [PATCH 1/4] target/i386: fix floating-point load-constant rounding
To: Joseph Myers <joseph@codesourcery.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com
References: <alpine.DEB.2.21.2005132345100.11687@digraph.polyomino.org.uk>
 <alpine.DEB.2.21.2005132348310.11687@digraph.polyomino.org.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3539dece-d72e-936f-97ad-5094834f6aa7@linaro.org>
Date: Tue, 19 May 2020 11:08:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2005132348310.11687@digraph.polyomino.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
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

On 5/13/20 4:49 PM, Joseph Myers wrote:
> The implementations of the fldl2t, fldl2e, fldpi, fldlg2 and fldln2
> instructions load fixed constants independent of the rounding mode.
> Fix them to load a value correctly rounded for the current rounding
> mode (but always rounded to 64-bit precision independent of the
> precision control, and without setting "inexact") as specified.
> 
> Signed-off-by: Joseph Myers <joseph@codesourcery.com>
> ---
>  target/i386/fpu_helper.c          |  54 +++++++-
>  tests/tcg/i386/test-i386-fldcst.c | 199 ++++++++++++++++++++++++++++++
>  2 files changed, 248 insertions(+), 5 deletions(-)
>  create mode 100644 tests/tcg/i386/test-i386-fldcst.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

