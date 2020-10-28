Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EA53C4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A94246B1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 10:23:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kh+3/5w+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A94246B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXicU-0003DB-Bi
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 06:23:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34576)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiab-0001z0-6J
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:21:57 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:36586)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kXiaZ-0004tR-5f
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 06:21:56 -0400
Received: by mail-ed1-x542.google.com with SMTP id l16so4537844eds.3
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 03:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PlLkNQBt2MV06C4uFr6eNVAWnXgAtugaA2raWzl1jU4=;
 b=Kh+3/5w+QekMfnUjQZ1Xbla9Gi//GhIWgHB4Uhb8dOMcG5z+yyXxkIDTQQxLRmj6VK
 VcTCBECUPO0W4vNN2ghmvqWoSu0FSrz0aWJ9O0wHhay1bxOfRrteRQnRA/YGYdDDFXLR
 flpYKiKWOdGKUEcW8GCbHlJ8M2z+fzSJVm8JPHJPwsBZzDRQDUd0nVXrd1J4D5pNADgM
 3Bg5Q5WjrUWlvR9IswsxFEkKCl7NpkFUkb/0En4oOA5j38XQtPVCDRiWE0LtLWowjSCt
 8CNKxcCHPdCxl5PL4Hwls9/62B8r9uKbYdkOzaiOQBGug83Cy9t7iWmWeJSokr08aYl+
 v+ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PlLkNQBt2MV06C4uFr6eNVAWnXgAtugaA2raWzl1jU4=;
 b=kcVNhgC4qirc3nYoaEFlyw80wjJcFAcEn4Y++O1c4yanOmekynZCB0OQu5Jld/Ki+n
 nh9IQz6hmEIQF0RcP6UPuAnTV79QLo405uObLCEX3pnkVYXgl2FFfwTCfCInsljTfUAH
 Uf0sO2Be0TK1uIlmJmAoEznc4r2GCRs9modtk3iMu0dH4MdY/FYi0VjEPYqK2TXoK2Fi
 qOar3VUgKCj+p29XH9TwOqO+rB9r8VZsb/CRtB/4kfjHdyFGtDOe5qLc2vIrkSgKnZ7j
 Ds5tZA6a2dcJncLTs39eTPEFEuZw+ZtaBwoFPiShP3Hle6zpQP4ykEFjqvL/0ZmATjMm
 oi5A==
X-Gm-Message-State: AOAM532MawYFeRvKqBl8S7NWakwW7PNNAxsrWyJgvZvofwNJDliKgw3D
 U4LY4XDFv+IEgXt9s5UPc9s=
X-Google-Smtp-Source: ABdhPJzlKyl5uSwghErlLKJ9QF9k19+CJTTAr3SvFIDxLfK0cht4gg9SqkckibadOM4AegN0Oo4R/Q==
X-Received: by 2002:a05:6402:1d8b:: with SMTP id
 dk11mr2892278edb.102.1603880513496; 
 Wed, 28 Oct 2020 03:21:53 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y1sm2653715edj.76.2020.10.28.03.21.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 28 Oct 2020 03:21:52 -0700 (PDT)
Subject: Re: [RFC PATCH v4 1/1] tests/vm: Add Haiku test based on their
 vagrant images
To: Thomas Huth <thuth@redhat.com>,
 Alexander von Gluck IV <kallisti5@unixzen.com>
References: <20201027102121.264963-1-f4bug@amsat.org>
 <20201027102121.264963-2-f4bug@amsat.org>
 <7556a1c9-9237-779e-dc28-6b16abd7d6f5@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <65d1bb1a-fcdf-1d51-81aa-6b5653ff3b46@amsat.org>
Date: Wed, 28 Oct 2020 11:21:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <7556a1c9-9237-779e-dc28-6b16abd7d6f5@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::542;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-ed1-x542.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-2.167,
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/28/20 7:02 AM, Thomas Huth wrote:
> On 27/10/2020 11.21, Philippe Mathieu-Daudé wrote:
>> From: Alexander von Gluck IV <kallisti5@unixzen.com>
>>
...
>> +class HaikuVM(basevm.BaseVM):
>> +    name = "haiku"
>> +    arch = "x86_64"
>> +
>> +    link = "https://app.vagrantup.com/haiku-os/boxes/r1beta2-x86_64/versions/20200702/providers/libvirt.box"
>> +    csum = "41c38b316e0cbdbc66b5dbaf3612b866700a4f35807cb1eb266a5bf83e9e68d5"
>> +
>> +    poweroff = "shutdown"
>> +
>> +    requirements = [
>> +        "devel:libbz2",
>> +        "devel:libcapstone",
>> +        "devel:libcurl",
>> +        "devel:libfdt",
>> +        "devel:libgcrypt",
>> +        "devel:libgl",
>> +        "devel:libglib_2.0",
>> +        "devel:libgnutls",
>> +        "devel:libgpg_error",
>> +        "devel:libintl",
>> +        "devel:libjpeg",
>> +        "devel:liblzo2",
>> +        "devel:libncursesw",
>> +        "devel:libnettle",
>> +        "devel:libpixman_1",
>> +        "devel:libpng16",
>> +        "devel:libsdl2_2.0",
>> +        "devel:libsnappy",
>> +        "devel:libssh2",
>> +        "devel:libtasn1",
>> +        "devel:libusb_1.0",
>> +        "devel:libz",
>> +        "setuptools_python3"
>> +    ]
> 
> When running this image, I now get:
> 
> ERROR: Cannot find Ninja
> 
> And even if I add "ninja" to the list, it fails after configuration:
> 
> make: *** No rule to make target 'qemu-img', needed by 'check-block'.  Stop.
> 
> ... so this needs some more fine-tuning for the new build system?

Sorry, last time I tested was 2 weeks ago, before
commit 09e93326e44 ("build: replace ninjatool with ninja").

