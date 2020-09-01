Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FE1C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:36:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C0532071B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 17:36:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N82w2VQx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C0532071B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDACh-0001zB-KZ
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 13:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAC9-0001ZL-5T
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:35:45 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:38218)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDAC7-0000ZU-Iq
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 13:35:44 -0400
Received: by mail-pg1-x542.google.com with SMTP id l191so1049352pgd.5
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2020 10:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mW74WJeg2fcKAsGk5EWZjND7YU4mfiq1YsRkXNkTfmI=;
 b=N82w2VQxpPU9MrctLG8xhwZRPYLFq8kUpu6E5NEq2OhqbRIX9hDxf83Jq0K74IQsnP
 SwhcVxojAOv/Eje/5qXHeo6Omoazo+CjhjEXfRW+KEeSTiMKNE97clWiiCUVD92xagI3
 6JFdHx9NhPAZzlwhP+5gfwrWWrFTrHBLhjtcweWZK9axYkO1CORe5lQqqd3BFrjPFPkL
 PxbD0W207X5OEIDSCK9eP/29U9P58EaykCs8Kiy9JE8o9H5eQfVnJvQFCSIWW5XqzkiL
 n1eh892V3Xk7a3355uLOlX7EVYaCVrdGkqU/UsbrEeog84MT5TkQ3ZD8wiUMNmngbZEi
 8A+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mW74WJeg2fcKAsGk5EWZjND7YU4mfiq1YsRkXNkTfmI=;
 b=uaGsJSM+erNp0oaWiYQGR/YpCnPZcIrajJ1Q4lLPEwUSBriq9hmdFpBGkF6GmyuH7/
 DHhMWSULcLOpj6q18meDWVJL06d7uIufoLVADAIS2HWZ0/nKz7pwVzWZxJnUBpPWPCmT
 B9tCNwbeMHn8RPEkOSDbifWlkYix6MBMzBeTaNPiuO8/oibgric1uidNVDKrYOWmxAYP
 kDVL05K0Fn8g3w/NJ/UYFl4J3iKVPVF02PnF/GHh0+71qj9gh3zCRKMhtdH+hsrguy+5
 6H3qnvA2vUTNTnqwc1m+OkGBH+Ca+aKU8Qio55B8y2H6rH1VPmmFHaTMrT7dStA3aTyN
 X9vg==
X-Gm-Message-State: AOAM533krq9vIOmGCZDhX12TsKh9PgSBjfku0Gixw1GcHUCsq7sROfgs
 Q91rMKbjXWW3K9jyY5XPpMhrWEqmom7q1w==
X-Google-Smtp-Source: ABdhPJz3k2F8mbhEVzuxKtvpv+GTOe/5dwmGLo97SbT+f7v1+dtsiAuFzLCLcFzXc6AlGD1Ga2vgSQ==
X-Received: by 2002:a63:1a23:: with SMTP id a35mr2368278pga.86.1598981742129; 
 Tue, 01 Sep 2020 10:35:42 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y3sm2273242pjg.8.2020.09.01.10.35.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2020 10:35:41 -0700 (PDT)
Subject: Re: [PATCH v6 05/16] cpus: extract out qtest-specific code to
 accel/qtest
To: Claudio Fontana <cfontana@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Roman Bolshakov <r.bolshakov@yadro.com>
References: <20200901072201.7133-1-cfontana@suse.de>
 <20200901072201.7133-6-cfontana@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7944d33a-a93d-ba9f-3be6-f3636e7fd68e@linaro.org>
Date: Tue, 1 Sep 2020 10:35:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200901072201.7133-6-cfontana@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
> register a "CpusAccel" interface for qtest as well.
> 
> Signed-off-by: Claudio Fontana <cfontana@suse.de>
> ---
>  MAINTAINERS               |  2 +-
>  accel/meson.build         |  2 +-
>  accel/qtest/meson.build   |  7 +++
>  accel/qtest/qtest-cpus.c  | 91 +++++++++++++++++++++++++++++++++++++++
>  accel/qtest/qtest-cpus.h  | 17 ++++++++
>  accel/{ => qtest}/qtest.c |  7 +++
>  softmmu/cpus.c            | 64 +--------------------------
>  7 files changed, 125 insertions(+), 65 deletions(-)
>  create mode 100644 accel/qtest/meson.build
>  create mode 100644 accel/qtest/qtest-cpus.c
>  create mode 100644 accel/qtest/qtest-cpus.h
>  rename accel/{ => qtest}/qtest.c (86%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~



