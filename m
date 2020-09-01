Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3634C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8603A2087D
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uiSh+eZ/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8603A2087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59428 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD9wi-0007oA-Lo
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54996)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD9vp-0007JE-Fz
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:18:53 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39542)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kD9vn-0006by-N5
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:18:53 -0400
Received: by mail-pl1-x642.google.com with SMTP id x18so865184pll.6
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AxfHSwfFuWg6mhsscpFGmVsMU7gj27ADfTaRrSi0uKY=;
 b=uiSh+eZ/CYnJn0qR+TbwO+4IB4vqywBUzcVtCLZRdgljZ6NxPggZTJ5Fl19pYafd/p
 ZXvn5L1nMvJzx9tIfo1t59vGHhQnli07xMRQjUBiz+aRHJhlsM/l4eMcs93sD5zTSVT2
 emaLRTj8FeGYdtfBZWJFDUd1hppE1li4KQ0LTC3odQ54pmrkbmW1v/3gp3tbMlgBupea
 LM/XjDCNFBh0bEeKIL/qZgkbtHsv613Pg9J5dAflkhYow7+wajBnnifPc9WEBVFssbH/
 E5XZGKuVPVo+Fy0ZmCm50qbgfRWFkUockNCGSDfEwPqxRv0KWbZhQu/QIiG0UqlHlx9y
 WR/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AxfHSwfFuWg6mhsscpFGmVsMU7gj27ADfTaRrSi0uKY=;
 b=OMpRS/h48ot5jyHHt4rFeIHJN0WzWiJ+318NjwWtBua9EIrI9gKjKfRbc4u9Jb0WJ4
 Wp00bduMkMf3cVe+6BXzECcy4BpCimCo01vVcF+Fot/oR+PoAuD0uUncopJ6nSMPs+xi
 24ljYe/CFzHovAWYLmAttuCPhpOl9RmiY6TKuTLwveoa+1+innDCHg1UTmOw/AoPXhoa
 68JJR8Oji2oPndzWtEotpX/H06K3oQEgJBWLlbITb+bft7SlMWVm0lATT0jiWhcqgAwg
 xOVXuldHKGRNr7GGlE1d+ATrWSgy37dHYeYW1F8imtlc1FkYEcNfb7Sf+e2MczX+i5zG
 P6wg==
X-Gm-Message-State: AOAM530Oj75dOcAQUqCgffmZeb1YbOqUJR+t4cOzeZ3KDggDnV4XuDdQ
 78sssgAyUBoYTA7w0UXAk8+FdQ==
X-Google-Smtp-Source: ABdhPJx7F9HHSEytdYtjNwzETnV6MJZv7452QVZJSf+P5xR6gnN4dFw2ky/qkCY4K8B5Jc/00Svl9g==
X-Received: by 2002:a17:90a:d515:: with SMTP id
 t21mr2383290pju.149.1598980729375; 
 Tue, 01 Sep 2020 10:18:49 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 62sm2649126pfw.119.2020.09.01.10.18.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:18:48 -0700 (PDT)
Subject: Re: [PATCH v6 02/16] icount: rename functions to be consistent with
 the module name
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-3-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3966a33b-ae2a-f3ee-55e1-4cccad7f6aba@linaro.org>
Date: Tue, 1 Sep 2020 10:18:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-3-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.13,
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alberto Garcia <berto@igalia.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 Colin Xu <colin.xu@intel.com>, haxm-team@intel.com,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Wenchao Wang <wenchao.wang@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/1/20 12:21 AM, Claudio Fontana wrote:
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  accel/tcg/cpu-exec.c        |  4 ++--
>  docs/replay.txt             |  6 +++---
>  include/sysemu/cpu-timers.h | 16 +++++++-------
>  include/sysemu/replay.h     |  4 ++--
>  replay/replay.c             |  2 +-
>  softmmu/cpu-timers.c        |  4 ++--
>  softmmu/cpus.c              |  6 +++---
>  softmmu/icount.c            | 42 ++++++++++++++++++-------------------
>  softmmu/vl.c                |  2 +-
>  stubs/icount.c              | 16 +++++++-------
>  target/arm/helper.c         |  4 ++--
>  target/riscv/csr.c          |  4 ++--
>  util/main-loop.c            |  2 +-
>  util/qemu-timer.c           |  4 ++--
>  14 files changed, 58 insertions(+), 58 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

