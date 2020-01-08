Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01A6BC33C99
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA58120692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 00:46:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dfqfXUpj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA58120692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iozUW-0004Io-SB
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 19:46:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41276)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iozTq-0003la-Hx
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:45:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iozTp-0005s1-8R
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:45:50 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36706)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iozTo-0005rK-W3
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 19:45:49 -0500
Received: by mail-pj1-x1043.google.com with SMTP id n59so313724pjb.1
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 16:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=MBH1THDQftYD9NEr/nhNb5+NTPmR+h97Q6JEYvjk68Q=;
 b=dfqfXUpjmBq7UKAL0MjHD1fKJlvZ067Yv7wflEZX3WJP13IfQQIfAW667ATEBjV1KW
 RQwAgGMx9cUIixnHXbgrhpghhBzp9egQb4Sekr+CRTakG0guhinxGG04lyKHW5j/r+0m
 NskeVh3m7BZdAr8zIdsDNM9ZmsGxStDcCQnhbGevI4RVLzQCUQ8/iIZgSMcyqK5Ot+VO
 g1TGk8ktm5s55FX3HylSB2slBq414VqBg7qWRvo1+0W/tQdyb9R7nkpeAeeInBL1K4+e
 IzCgkhw+T8iidGIGN0Jf3E/p9CR3bg2sGV7QgtmVJVwnzXFp8nrDVXBLJ26Q+3eg1qYN
 gzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MBH1THDQftYD9NEr/nhNb5+NTPmR+h97Q6JEYvjk68Q=;
 b=enPbwHr0HP37QkZjOSlzA+LCSXLFnDcnqY9+AOgHRiFMk4+dWQNjoFqG/yFPog1KVa
 3C56OXZDwm7/+vrzIjFyz7KKIZ9aoYDD7ebVSZmIg5YodaTuG+O7Cb1Krj4toMuLFXlk
 2RQmMORzF96u3geFBJ9xHgN6f12XGbvwUOhQN8gePxwrSBJ4M2zyYpk8Ysxj8mqhD9/0
 H2ZnL1uMxiBVRbYPxoo7tN8UOO5D+0mt/aT8F07FqXoOo5XiBDHjMVO8EbocU1MzOx4I
 oUFO4WTzoTWkO0L9dZhITUfKJaItFsiUhnIy/U5clqWSLdtNEh55+oYfgrUZyW/rfP8y
 aFTg==
X-Gm-Message-State: APjAAAUGfGr/qo7rAy1IYpreQ7MoHXjmyJqcLRkmJywGDoc76gu74fte
 Qv4UXvTI3ep9XIQxT7ayXdFKVw==
X-Google-Smtp-Source: APXvYqx4NRfoJmMHsJ2kLKV9yo6bt2k+w4+UrPPGftkWKn1fFV5Z+vKzzxvzE/VS1MF4LDlwMYqDJg==
X-Received: by 2002:a17:90a:22e7:: with SMTP id
 s94mr1509903pjc.12.1578444347594; 
 Tue, 07 Jan 2020 16:45:47 -0800 (PST)
Received: from [192.168.15.12] (alanje.lnk.telstra.net. [120.151.179.201])
 by smtp.gmail.com with ESMTPSA id b4sm802637pfd.18.2020.01.07.16.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jan 2020 16:45:46 -0800 (PST)
Subject: Re: [PATCH v2 4/7] configure: Always detect -no-pie toolchain support
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191218223441.23852-1-richard.henderson@linaro.org>
 <20191218223441.23852-5-richard.henderson@linaro.org>
 <87o8vf4dan.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <54884771-5615-0518-9da0-9c3271e47a65@linaro.org>
Date: Wed, 8 Jan 2020 10:45:40 +1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <87o8vf4dan.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: philmd@redhat.com, Thomas Huth <thuth@redhat.com>, i@maskray.me,
 berrange@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/7/20 11:16 PM, Alex Bennée wrote:
> 
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> The CFLAGS_NOPIE and LDFLAGS_NOPIE variables are used
>> in pc-bios/optionrom/Makefile, which has nothing to do
>> with the PIE setting of the main qemu executables.
>>
>> This overrides any operating system default to build
>> all executables as PIE, which is important for ROMs.
> 
> But if the compiler doesn't support no-pie it just keeps going on.
> Should the sub-build be bailing if _NOPIE is empty?

If the compiler doesn't support no-pie, we assume that pie isn't default, and
so no arguments are required.


r~

