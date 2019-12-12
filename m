Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DFFC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0BAB2077B
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 01:42:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LYVfVI4k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0BAB2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifDUh-00080S-PM
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 20:42:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39551)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDTL-00074E-3k
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifDTJ-00031I-V5
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:40:54 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:44717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifDTJ-0002z7-N8
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 20:40:53 -0500
Received: by mail-pg1-x544.google.com with SMTP id x7so261745pgl.11
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 17:40:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=z+U52Y5u6w9Jve6/uP/+CWL50d6AhacUhs2xO0S4U1c=;
 b=LYVfVI4k0OWSTtf8H+yguKbSYpYt4UZeExX2YsVulGGKk/mhwn+m2tiW9JY3b1luec
 CQP51mk2vFsvX88z84KDa5l/P5eBFjN0dJPAdmEP78Ilk9hXXdxXbWERpSM0CPNOccsc
 OuRQUOOclACcfIffbdRBETvs9zaz35Tq1hFyuoxBn03tuor3W+8x6i1PjnJM6qo770jx
 tnFoyzgWSvYkGNImIFujxuvmmWEEM8+YDrP1W2n5jCIYpUfv2hkXraBU4QEKHP88mtbL
 o/KJ4vbzdJ0vR4QBVJKuYAgsJuft6EICL0ukp+jNPWMJNpkWBSFXt/dL6t1V2qLlozXf
 jEpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=z+U52Y5u6w9Jve6/uP/+CWL50d6AhacUhs2xO0S4U1c=;
 b=PtrhFRArR7ZXa/GgP85RqHVfE8VooNBrh9qmaDO4PcFJC1ELTygsd4eiJVvwzd28XR
 oS6I6SeX/e/Pr5krm6Qz0Nq73LUbru4kLV89BrQ+fn9oswpuDoptSgZkJzpLS0TpxA31
 +S2o32OfuIwlMZ2cRWYd7ThE6Dj2mzJXV9LIeCzTUr87l90Kp4G+RKFXtQ3ZA4ZrtXdZ
 OfYDvrZ7o4QRCg9S/ureyqzicfIKPX0PA17s/4PKbQA9zUTKp2mnaCrKWF4pk1u2eaB5
 ahv9b8PX4LjqGeYcICU8cvBohKw+vW/Rd8ljN9JBdaR8TbSp46/3WZ7j/J+TLMlD3VMI
 CFeA==
X-Gm-Message-State: APjAAAUnL3i8Olr/vnh/g6XnpXJ/+R2mGORhIz9DCkQ8/NhVqYFIXeps
 EI8aQU6D1cmNATUR/pUOCSnBrH49GXc=
X-Google-Smtp-Source: APXvYqwb1dJW5kNBbzSBB5Z8xRhYd27lUULPUofdOvn2+2ZQjB7Sv6uVtoXLUUsFA+cOGO1VbH5B6w==
X-Received: by 2002:a62:3892:: with SMTP id f140mr6985371pfa.190.1576114852070; 
 Wed, 11 Dec 2019 17:40:52 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id i4sm3642894pjd.19.2019.12.11.17.40.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 17:40:51 -0800 (PST)
Subject: Re: [PATCH v2] tests: use g_test_rand_int
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <1576113478-42926-1-git-send-email-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1952843-0598-227e-b476-ae835282a6f6@linaro.org>
Date: Wed, 11 Dec 2019 17:40:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <1576113478-42926-1-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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

On 12/11/19 5:17 PM, Paolo Bonzini wrote:
> g_test_rand_int provides a reproducible random integer number, using a
> different number seed every time but allowing reproduction using the
> --seed command line option.  It is thus better suited to tests than
> g_random_int or random.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/ivshmem-test.c | 2 +-
>  tests/test-bitmap.c  | 8 ++++----
>  tests/test-qga.c     | 4 ++--
>  3 files changed, 7 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

