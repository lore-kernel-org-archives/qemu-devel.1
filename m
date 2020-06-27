Return-Path: <SRS0=GMHn=AI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC65C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 18:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64C59206F1
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jun 2020 18:40:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pb2Znqs7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64C59206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jpFkN-0000SA-HZ
	for qemu-devel@archiver.kernel.org; Sat, 27 Jun 2020 14:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50238)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jpFjf-0008Jy-1g
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 14:39:31 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54025)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jpFjd-0002NN-5q
 for qemu-devel@nongnu.org; Sat, 27 Jun 2020 14:39:30 -0400
Received: by mail-pj1-x1044.google.com with SMTP id q90so5526507pjh.3
 for <qemu-devel@nongnu.org>; Sat, 27 Jun 2020 11:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:from:to:cc:references:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RI/VCIJSf3DcHrzBe16V3YRS7S/XLHhnIfa5uXgdCEY=;
 b=pb2Znqs7ZGHeP3eV4IdkQELzKA5Tfk3UcPakB3q4RS/xynBtJE1ZoqFh99YTXMGqK8
 3I2PAykvyUhAx1j9q0hKE1BTbNs/r0qolxXITu6s+k8LLo4NCiAL9hrioRbopWYhKAZm
 T1IRNVwAYgmk3b0jnsLACRDXNc+aiva7J7kRdpUzl0NPALstu2qBTf5mfApm4JaQ5Xp2
 tnvrB7Ijm30daYtS/V+GEVC6O5zL9H1qMsy0sWgsMnoCHkV8RnSHbSXQ8BxU2BqQZwbq
 deJjPWks92SpPwgEOyqlPPipIpLklI1qJVhWwGHKGq+MIMxUs0/IDibfZ28jMKeS426T
 lQNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RI/VCIJSf3DcHrzBe16V3YRS7S/XLHhnIfa5uXgdCEY=;
 b=S97rHtScdDvhdqNbx+a7HmmBRw9yqOSWuAdBXwC485Q7EsaPHp+8wrkp2kWHto/Zhn
 C8JfhDoiZ1Eq9dPinFctkZ7FZvB3zoleB0+uxbi0/TwmsHmzPSfExp3de94L84jDaqvt
 Orh1o0cUBp8fQz+p6/4BcGNhLNU2aWg2OLx52MDHibXijfKRyCTo/y+BtRcEaYoQeqOF
 OTheSCJXVXeIn+I6tHiJVV29NCpm/Xgxy/XNOCOGIrimf6PWXNk/XWL4b7kCyMl3F3p3
 wJS78/PSI6JyNL5Y9Nu0qbmKqwD/kojk381nOskMj7O6XJKXzh/fmD0fKjz6Fx7bmONN
 4y9Q==
X-Gm-Message-State: AOAM533fhVz2TXZeXqD2JltwIHRl0qKlEBgtD5SAXgLGs2T8gfa8Eabk
 d2YhyRkCyHN6sOrkngOdmigqzw==
X-Google-Smtp-Source: ABdhPJzTf637Qhcnje3hO86y4Q7I4+90b841wwQeMshrAXO0vwDDtvlaVD+3h0EpWUXi5nZMyQhKzg==
X-Received: by 2002:a17:90a:4d09:: with SMTP id
 c9mr9819085pjg.137.1593283167100; 
 Sat, 27 Jun 2020 11:39:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y27sm6390827pgc.56.2020.06.27.11.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 27 Jun 2020 11:39:26 -0700 (PDT)
Subject: Re: [PATCH v9 0/5] linux-user: User support for AArch64 BTI
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20200520172800.8499-1-richard.henderson@linaro.org>
Message-ID: <5af1c062-9d12-6490-1655-7d51e9a85c4b@linaro.org>
Date: Sat, 27 Jun 2020 11:39:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200520172800.8499-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/20/20 10:27 AM, Richard Henderson wrote:
> The kernel ABI for this is (finally) close to being merged:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=for-next/bti-user
> 
> I've made a couple of tweaks from v8:
> 
>  (1) Only map the interpreter or a static executable with BTI.
>      The interpreter is responsible for handling the pages of
>      a dynamic executable.  This is a behaviour change in the
>      kernel ABI since the last time I audited the code.
> 
>  (2) Rely on the recently released gcc 10 for building the test case.
>      Thanks to Alex for helping me get a docker setup for that.
> 
> Based-on: <20200519185645.3915-1-richard.henderson@linaro.org>
> ("linux-user: mmap/mprotect prot values")
> 
> Based-on: An unpublished version of stsquad's testing/next
> 
> So for avoidance of doubt, the complete tree may be found at
> 
> https://github.com/rth7680/qemu/tree/tgt-arm-bti

The Linux ABI on which this is based has been merged for v5.8-rc1, so pinging
this series.

Alex's testing/next is upstream, but the "mmap/mprotect prot values" patch is
still outstanding.

Everything rebases without issue onto qemu master.  Again for avoidance of
doubt, I have updated my branch.


r~

