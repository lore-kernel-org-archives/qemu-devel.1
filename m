Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF6F2C433E7
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:37:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2066821D81
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 23:37:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pajk3LOe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2066821D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSTqs-0005gO-Tn
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 19:37:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTpg-00056E-4I
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:35:52 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:52271)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kSTpe-0006xi-9b
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 19:35:51 -0400
Received: by mail-pj1-x1041.google.com with SMTP id gm14so396845pjb.2
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 16:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=jazn452RSM1TEOWk31DmOc20UT+aIjpk6jMBELW6MNw=;
 b=pajk3LOeujOzcnakiBlvrE6m46HjssN+2T9hlqgRpASyGm3PKa2ZEICAuq3VC6FjzT
 jXnz3w8pXtEEP4DWsIS2RpTY22ZB8MN3uJxbdQzMXW9A0XuC6zZwgBNXmdDjvOnvqPk9
 djK7Q93S0Am8K71wXI+2muTXgnC8Eq+z4xp31zmW39QvmgeRYOfH4aaIHdQCvUabO8G/
 DO3SdewDQv33o+waTSZUprQuOKihA0Cs0Ko9xaYA9WkeuviSNVto9CZWWxWMQTlrmMPF
 ROYqoBWPFt0VO4a6p/PeTEdrHXKqCo884UHH6unb4Gqem6RYHwUCBYcNuQQKh7WeenqA
 XHdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jazn452RSM1TEOWk31DmOc20UT+aIjpk6jMBELW6MNw=;
 b=hVJkdOhRSDJpnbMmrRUzI9bFiuP9cjKor3ncM4U7SlHdjTnMnnpu6moEweawRrT64a
 rY7NK8K0qFLxj1uXxtGXv4n3Pn9md4G2Xihp7vPJqhnKlKtfPgTrrGyWIVh8N+F/1TeP
 iIWI3of33hk8ce15y3tCkp9fMCoM2BDqKbAFJ1KWfwGRipA96ZElj0IINgz61wWlx5Tm
 ojQGd8IWycvhiKcvY9iHruut70sL0YpYoVsaOeULHM3aPA+Pq8Whz8JtTSZG6LCIhCWo
 1xFh9jGshZPKaIr2g68+SyT1r5f+N/VowrPfyzokx5NWs+TeLEvM0bXaU6eiykI9FXLm
 vfWA==
X-Gm-Message-State: AOAM531LXdl4jGJDbjdVZVwgtxdkxvGTFFrdrocrPB5+mNXXrMOAB5FV
 g/r2sjSrYu7DO5d8JSKyQFVHIQ==
X-Google-Smtp-Source: ABdhPJxy4iQODNO5Zhv5Zxxu20N4kBQnKxoitrymsaMLEwMU/g+2eya89BBMewMNIUCPmL++5Kxa8g==
X-Received: by 2002:a17:902:8b89:b029:d2:4345:5dd with SMTP id
 ay9-20020a1709028b89b02900d2434505ddmr1820399plb.57.1602632148498; 
 Tue, 13 Oct 2020 16:35:48 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x18sm825201pfj.90.2020.10.13.16.35.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Oct 2020 16:35:47 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] hw: Replace some magic by definitions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20201012132017.3423954-1-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <63cb45ed-ba1f-2395-43c6-54fdc86cbd11@linaro.org>
Date: Tue, 13 Oct 2020 16:35:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201012132017.3423954-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/12/20 6:20 AM, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (5):
>   hw: Replace magic value by PCI_NUM_PINS definition
>   hw/pci-host/pam: Use ARRAY_SIZE() instead of magic value
>   hw/pci-host/versatile: Add the MEMORY_WINDOW_COUNT definition
>   hw/pci-host/versatile: Add the PCI_BAR_COUNT definition
>   tests/qtest: Replace magic value by NANOSECONDS_PER_SECOND definition

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

