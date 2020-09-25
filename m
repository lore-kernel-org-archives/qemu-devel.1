Return-Path: <SRS0=+pSw=DC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C02C4727F
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:51:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A67D21D42
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2020 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="brd1n2Qv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A67D21D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLugm-0000Dq-0a
	for qemu-devel@archiver.kernel.org; Fri, 25 Sep 2020 16:51:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLuff-0008Dg-Pe
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:50:23 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c]:35539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLufe-0006oq-0H
 for qemu-devel@nongnu.org; Fri, 25 Sep 2020 16:50:23 -0400
Received: by mail-pf1-x42c.google.com with SMTP id k8so4402425pfk.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2020 13:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zXdm2YzK6llWR3aRBS9tlx2nX70b6TQBJBt329FaYv4=;
 b=brd1n2QvbvOJkFX36coOSBbDt4oENbVfkqJuZLZ7C1EzxHI/U6lHPPRDs3D1SvmlM6
 B2p2MFCUFTFdYTl+9jaOOyPjlKx4mXijOv84EN+XlOEiQrDe7k8/8RykI4E5y2JZTYzp
 JyFB7qQO6OHWIeO5Hs4SqY/ynpmeMP4ZoBFjxLq5+dwgH+KCBD5fReNB0Qsi1ZdFoEv0
 7RdQh38uXZ4zZNqkLhrm9bvIvcoVA646DdUv8X9mmauvdzpN8v37/X7+lPgIVEBLUvs1
 xQmdKc1pZ6aEBHVhx7ENXv75E9V0PKKQkavdEu+tBUUQsn+T2w1aBJFBICVuyngjtOn7
 Vjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zXdm2YzK6llWR3aRBS9tlx2nX70b6TQBJBt329FaYv4=;
 b=J8msu9rv3E6VgNAUFIJ1XMEUWiHjQP4i2QQdmivFYRHWePchVVvutKvqfFdH3yEVO3
 /D4NqUW9JCCgGriGkQ88aF8s6ZshNSvWTxTozEWF2XVeUx4gTe7nO5bJfcSjl85FaimZ
 JTzZRxmoCwlicYzxijr4WwlE5v29VLEjX90dh1mcICpEP/2KXadBzANcWXCNWohi2iLu
 A+TGUIVuh3OMNAgU2OjoNh17O/xB/MXS2lnDcUCiCiFc00pV31Gwjy0sPw5jNi01Jpxc
 UHVn0yFK9sFHT2eegf29M5Ul5e83qIqL8YSKdC4OBxodi8iAeq7lC426z+ov93tdrfXa
 iykg==
X-Gm-Message-State: AOAM531qSHCkuizxGhD7snsomTQutP8hyXOXqV35H0DK2R/5rLQOaeAY
 0go8lREZV0i7GW6t4e8fLrRGtA5Z6ZnwHA==
X-Google-Smtp-Source: ABdhPJx5t+B5ejbPKdkf9dEhI2SRaMqgSA3oxX+AmS5i9JsVbTsODeew7TaXYfv4KxqqU5IvylZKHg==
X-Received: by 2002:a63:ea15:: with SMTP id c21mr598519pgi.446.1601067019829; 
 Fri, 25 Sep 2020 13:50:19 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id i9sm3405718pfo.138.2020.09.25.13.50.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2020 13:50:19 -0700 (PDT)
Subject: Re: I wanna fixes plugin on windows, any suggestion
To: Paolo Bonzini <pbonzini@redhat.com>, luoyonggang@gmail.com
References: <CAE2XoE-PpsaqJOfEq0iUSkH6N8skkqFAY+2QkSbnENiszA0xQg@mail.gmail.com>
 <a50bc12c-7aa1-19a3-c39e-02328aeaca38@redhat.com>
 <CAE2XoE9F5_gGsiFutW99mbPUbUb2rmG+2+9pEDKrhvu9QRwYvw@mail.gmail.com>
 <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0eee78e-9336-65e2-bd12-a762aab78c3e@linaro.org>
Date: Fri, 25 Sep 2020 13:50:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a808929b-f93c-f68d-da4e-02133b4fcb54@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
Cc: qemu-level <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/25/20 12:25 PM, Paolo Bonzini wrote:
> On 25/09/20 21:23, 罗勇刚(Yonggang Luo) wrote:
>> That's what I am tring to fixes? what does  one import library per
>> emulator, can we do this like NodeJS does?
>>  NodeJS have NAPI support across platform. They create a windows .lib from
>> node.exe
> 
> You'd have to create a .lib for qemu-system-aarch64.exe, one for
> qemu-system-arm.exe, etc.  On Linux the same plugin will work for all
> emulators.

Which is clearly silly.

So what you'd do is create a common .lib that all of the plugins link to, and
so do all of the qemu-foo.exe.

This would probably involve creating a set of call-backs that qemu-foo.exe
would need to pass to the common .lib at startup.  It's harder to do with
windows than linux, but it's not impossible.


r~

