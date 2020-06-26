Return-Path: <SRS0=ZkAM=AH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6FF9C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:31:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 771FF207D8
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2020 18:31:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTnUcbkF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 771FF207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jot8l-0001OX-Lc
	for qemu-devel@archiver.kernel.org; Fri, 26 Jun 2020 14:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60142)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jot7X-00006h-TT
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:30:39 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33217)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jot7V-00006V-T5
 for qemu-devel@nongnu.org; Fri, 26 Jun 2020 14:30:39 -0400
Received: by mail-pl1-x644.google.com with SMTP id 35so4579431ple.0
 for <qemu-devel@nongnu.org>; Fri, 26 Jun 2020 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PTJcDQO5aEuvretSBIS4yy5RHu6MPt9cNZhgh83l8YE=;
 b=FTnUcbkFfuCrC8p7nSWPWbTZAtR3Ou1yveL6/vVdPBCq3gZ73vdIgSV9h3OrDEV4J3
 06YQhBztDkgxJQsEfmAR/peVHpI+YkJ4SlyVFsLDpGu7qz2d399Hov0MHteEQIDNXJp9
 2GLPGW6Yaa1KpUXQbTpoC4I1BMP5hD+GLgXW1isG5dTMgI+RkXyLUInp1H6EQMMYontx
 rI58uJAzot/OzVsNHzMf6jIK9dLT3ivi4wGKfWu9lHxsClObzat8IaHSyog8UtUUGHpY
 DZaILeLfsqA1Z0JLO1Gn1KjEUQ2ZpARLHAP5vi4nMsdn2Nx5OThrJYtQKXQ4USFyjW2d
 ji1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PTJcDQO5aEuvretSBIS4yy5RHu6MPt9cNZhgh83l8YE=;
 b=iGu2jj6FtKHWQmJBZFYyjnwhf6Ew2tT5QyxNPpYb07oca5R4XyY4XbqPj6CyTobj5D
 KGp0w6/53vmt03GpDAyCx7TnNsTWSOivKrYkxRHGYDQJk/8OiGh+ls2nAUj+j0wC/n98
 reRY0vJdHw8/1o03CJkP5qYet6YAbwFmAnCJX6UJbuRyqW/K2hKBK1aAr0k76MIlhpFn
 14istKbh/Sz1aHl/mqRC0HQPtFlHEpqYUfOQ9I6F3qCQm696C0Ucrir1uQzNgjOPHPer
 pYv/OShIRiv6WYNu4+1hhiJesyiC3X8W4f891/Jg1MeN9aPIgslwJAGREfnhdrWikrTU
 x07A==
X-Gm-Message-State: AOAM531iVFjIqYUCBTKPPCKi8abjZu45FByoczi3Db+inbBuz9vSZ501
 y81IwsDa6o5lzM/WMGHMJoWGZA==
X-Google-Smtp-Source: ABdhPJw73YE5ugtWzmlxcNnULtFBSsxNP2EYeuHKpGuK2GMIQL1WZm7G8A/oy2pJyF3j2fkSoL3eYg==
X-Received: by 2002:a17:902:7045:: with SMTP id
 h5mr3655100plt.151.1593196235603; 
 Fri, 26 Jun 2020 11:30:35 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id y5sm23804520pgl.85.2020.06.26.11.30.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jun 2020 11:30:34 -0700 (PDT)
Subject: Re: [PATCH v1 12/18] tests/vm: allow us to take advantage of MTTCG
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200622143204.12921-1-alex.bennee@linaro.org>
 <20200622143204.12921-13-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3ab77b68-9f5d-6b99-e226-df4abb186add@linaro.org>
Date: Fri, 26 Jun 2020 11:30:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200622143204.12921-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: fam@euphon.net, berrange@redhat.com,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, f4bug@amsat.org,
 cota@braap.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/22/20 7:31 AM, Alex Bennée wrote:
>          if kvm_available(vmcls.arch):
>              return multiprocessing.cpu_count() // 2
> +        elif os.uname().machine == "x86_64" and \
> +             vmcls.arch in ["aarch64", "x86_64", "i386"]:
> +            # MTTCG is available on these arches and we can allow more cores.
> +            # But only up to a reasonable limit. User can always override
> +            # these limits with --jobs.
> +            return min(multiprocessing.cpu_count() // 2, 8)
>          else:

And if multiprocessing.cpu_count() == 1?
Seems like we should add max(count, 1) as well.


r~

