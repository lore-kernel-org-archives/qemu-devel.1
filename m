Return-Path: <SRS0=yhYb=B3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AB4C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:39:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41BA920674
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2020 20:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A+zTyDXI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41BA920674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k7lur-0004EG-Co
	for qemu-devel@archiver.kernel.org; Mon, 17 Aug 2020 16:39:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44000)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7luL-0003oC-Hj
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:39:05 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:36897)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k7luI-0001j0-2e
 for qemu-devel@nongnu.org; Mon, 17 Aug 2020 16:39:05 -0400
Received: by mail-pf1-x443.google.com with SMTP id x25so8821626pff.4
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2020 13:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XmTXBIlxorc44akpYoeWurqJdj5UDxjDqNhaJmPUB+U=;
 b=A+zTyDXI0+oGzKLz1Cq1oyfO7A3Fyk4lD4uB/p7tkVnI/AAXcqQgucwRgyFmgGf2gd
 KuDJQBddwkeJicdykpzxiOoIP59Z0C/wMXwkTpS2ZJTc+UKRF/YDCprljkZqHFyy+mgr
 XQLpiDpnTevi5etg4RnTXzHIXklVee7Gtki6s381AI6a2jJn9ubXef7oSCJ6UzjbZm1H
 spk7uKFiyogT5RgAJ3Nt8jwBO/fesD0E3zgNBruRlT74BzXsUivhZF4maBkCGPVRU4ik
 Tq8SzyelSfmghNfWClcFxXCkL+U4IPESu9ZUu4pAAmdK/sczPBY1dLpll2V9FpM1GXiM
 +hEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XmTXBIlxorc44akpYoeWurqJdj5UDxjDqNhaJmPUB+U=;
 b=AVtXsj+019q2Afsr4L4IH0PjUPB0nH98KlchQbIckQjhsjcr2vAPM6Y86SlSW6juV6
 Z90qeqgICxU0NzRwlza9bhWWv0boaJMxEEMvidsydgNhhtz5bxpwDclY0QsiFjOu9D6Q
 icEnM9jdgx0SMhUChT2cQRis/VQT3CqjdqUb0GkGaLETMmk9Udpven7S2JcfTCsYMV/9
 Qwd68qwYKL/Z5ItwTf5T0QgyzjG0irtHt6+Gtu+lK9i2u35Vht18nCrVrl/aWvEt02sE
 nKnhkBkIM+prsnskGCD83YKGaeppXjwZQ4V+xY2uNGPkSMla8j8Yda/UHfNhlpgwz/NV
 Ax2g==
X-Gm-Message-State: AOAM533W3rKAM0ksi3XQ8N68aoLFlwQvDlRMXseuVBlDqhOrEPy7lxGB
 r4SOx/WQ9BcGKI0KulSMupc7qAwqAtqnRw==
X-Google-Smtp-Source: ABdhPJx83XYGI+fT6OHXcOtxceOwrEfKe6T5g5cxpPQRLHzkxeWzp8JWh6OVKAksFe4C3FW3IK0MmQ==
X-Received: by 2002:a62:5b07:: with SMTP id p7mr12804570pfb.326.1597696739887; 
 Mon, 17 Aug 2020 13:38:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id k125sm18762339pga.48.2020.08.17.13.38.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Aug 2020 13:38:59 -0700 (PDT)
Subject: Re: [PATCH 01/17] crypto: Move QCryptoCipher typedef to
 qemu/typedefs.h
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20200813032537.2888593-1-richard.henderson@linaro.org>
 <20200813032537.2888593-2-richard.henderson@linaro.org>
 <20200817164801.GK4775@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <01f1a99c-9983-9b92-b91d-bd117055cf21@linaro.org>
Date: Mon, 17 Aug 2020 13:38:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817164801.GK4775@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 9:48 AM, Daniel P. Berrangé wrote:
> On Wed, Aug 12, 2020 at 08:25:21PM -0700, Richard Henderson wrote:
>> This allows header files to declare pointers without pulling
>> in the entire crypto subsystem.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  include/crypto/cipher.h | 2 --
>>  include/qemu/typedefs.h | 1 +
>>  2 files changed, 1 insertion(+), 2 deletions(-)
> 
> I'm not in favour of this change or the next. Using #include "cipher.h"
> is not a burden on the users of the crypto code. Moving typedefs away
> from the associated struct is a step backwards IMHO.

Consider if you put a pointer to QCryptoCipher in a relatively generic header
file (e.g. "target/foo/cpu.h"), restricting "cipher.h" to a portion of the
implementation (e.g. target/foo/helper_crypto.c).

This sort of thing is exactly why "qemu/typedefs.h" exists.


r~

