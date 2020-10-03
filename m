Return-Path: <SRS0=be0Y=DK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96F01C4363D
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:22:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2BCF206CA
	for <qemu-devel@archiver.kernel.org>; Sat,  3 Oct 2020 09:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EFVHyv2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2BCF206CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOdk5-0000jJ-Tb
	for qemu-devel@archiver.kernel.org; Sat, 03 Oct 2020 05:22:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36070)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOdjC-0000Ha-BE
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:21:18 -0400
Received: from mail-oo1-xc2c.google.com ([2607:f8b0:4864:20::c2c]:45912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kOdjA-0007WB-KB
 for qemu-devel@nongnu.org; Sat, 03 Oct 2020 05:21:17 -0400
Received: by mail-oo1-xc2c.google.com with SMTP id h8so975160ooc.12
 for <qemu-devel@nongnu.org>; Sat, 03 Oct 2020 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Y/I2A5wvU4Itk6Ind2PkxlvSevzjOQlZzlFBUwJtDm4=;
 b=EFVHyv2VGWgOrV9FsZXEOlXFScZQIi48loE4hoEhZihIZdDgXvaxxBxoFFkjhA3+G/
 wJTAMd/vgTQ/t8ORLaOSpoxm0t8pVmqwKYMyWpdqp00qvc+U/uIe5Qr2dguVXjTkJdji
 BGYk9Ribxx+EoEJvN09Sz6b/62O9awyT1xjN8985pVDqoXX4l0pE3Ki40eXikiIfqcmC
 z6NWHqoZyzT5M6xR0aC92Jx9QcFTeNkFbqg/W9mBvbVsfSq78b7+qNOvg2wE/sFZlwvW
 pfE7j7FP0SvAYYDHct14f5DC2fVzdvDu53ORJaKgV8uV2kisthyciB2RrdTHSlOuwGeW
 hlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Y/I2A5wvU4Itk6Ind2PkxlvSevzjOQlZzlFBUwJtDm4=;
 b=fjvhYxorWfjk5ZKZaLSILx1tAkaEppHaF4zgLQlaARPddFrgqs9vy7s8coDqrD3s3u
 W7EH0CskfAJw04nVXB86u+tR3JkQbHHYTIlmqaCLcjtAN/TfhG6rvQwfWyOZC+Jh1e4P
 EZDC83RgYzv4C8/QMFemljg+5ppNog53bSxAkpAfkcJesf2tlVlScr/NZNo96Extd+ka
 cq7sNI6DfJatWtj3y7dzWHcC2I2YqKVlGlu+9NbXN0VA6KlbshwNpeqBHhPksSmCNcHa
 GO1vXF5F5ETD8BcPJ+9S2d60wG9sNv4zzCy51pT+s3aimd8OZ+xFpgufkbnNbjkxSUgZ
 2jBg==
X-Gm-Message-State: AOAM5314Xg8y/vCBsUXcLfGA3GEtK9NOZPhQsV7f5dQUm9bLKPwz/kKT
 xpY7aPiIpSS2jhbGxU5kUESmR0AeprkQz5vA
X-Google-Smtp-Source: ABdhPJxTtZceqx4mJvC/blFzhuHzyOKnlglbTMKiVoEwBRrip+47Lgadc05g99k/4LlbZyufjhuV/A==
X-Received: by 2002:a4a:e862:: with SMTP id m2mr5070852oom.33.1601716874980;
 Sat, 03 Oct 2020 02:21:14 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id t9sm1172141ood.30.2020.10.03.02.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 Oct 2020 02:21:14 -0700 (PDT)
Subject: Re: [PULL v2 00/11] capstone + disassembler patch queue
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20201002165127.130369-1-richard.henderson@linaro.org>
 <CAFEAcA_kr5M+TbLDiYVMZbSMgpZE8fN+ae27rgOVkpOj2b9-xQ@mail.gmail.com>
 <579da0f8-3b59-1cf6-9e0d-54c21905d683@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <6e05b1fb-be2a-3051-63f1-1c86158f645c@linaro.org>
Date: Sat, 3 Oct 2020 04:21:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <579da0f8-3b59-1cf6-9e0d-54c21905d683@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.256,
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/3/20 2:06 AM, Paolo Bonzini wrote:
> On 02/10/20 22:37, Peter Maydell wrote:
>> Found CMake: /usr/bin/cmake (2.8.12.2)
>> WARNING: The version of CMake /usr/bin/cmake is 2.8.12.2 but version
>>> =3.4 is required
>> Run-time dependency capstone found: NO (tried pkgconfig and cmake)
>> Configuring capstone-defs.h using configuration
>> Configuring config-host.h using configuration
>>
>> We shouldn't be looking for or using cmake at all.
> 
> This is a missing "method: 'pkg-config'".

Ah, thanks.


r~

