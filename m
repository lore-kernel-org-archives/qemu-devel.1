Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC00C34047
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:23:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE9A321D56
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:23:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Kv01+6EW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE9A321D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40734 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48Se-0004kc-Vt
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:23:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54908)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Jx-0003Eq-5s
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:14:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j48Jv-0000JA-0z
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:14:12 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:38408)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j48Ju-0000HG-Pg
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:14:10 -0500
Received: by mail-pf1-x442.google.com with SMTP id x185so11123293pfc.5
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 11:14:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Q7rUwdi0prvNk3ZvYSJ53p/vwPF2xCpbk/nQYIhptts=;
 b=Kv01+6EWIvqV9yQSEqUsC3rTBZa7c1WzfCmgv2bIZrqwVkO8twS/S5VAPA/cgZVb1O
 puglKsjeHyv79HOEzfko58vPsYbbt5ouVSKjQURoxFvn7hxwtVo8imM9YdWxspZQew96
 3Yx9SbbGDHOG7hyTg8r+JRErWg9JSm8eRaZZLa7TtR7YQ//MP7+Hz2JrcDLws49S8Kki
 5KSEwH2kQvrT11kEwoj5o3/+7QMXpYUZeWO2PT26q/nO+5VLTK7xU+BL5SLE5XhtGutw
 H6ieaSmWX+Zr4N9UWA9wIo88kDKX1hVmJqpHRcgaeHO185lmqHovUj+WffPEaSdvsZYw
 iO5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Q7rUwdi0prvNk3ZvYSJ53p/vwPF2xCpbk/nQYIhptts=;
 b=IFOb4aaoW5cclBQj7Tw5ktgVdpwMkPCnR+2Rq15B5I6ThenFFkEKRdKe4aqlmMiXKP
 uApmNxOP/IGTFE0sOd2mpBODc0naXCbb1/1i8agsTGKNnhzDtK0bJ1yrE+lL4SJUp5pQ
 Ltrhq8IAYrgq3a6bTsVaSyRskevqylsgI2wnlcJZcofdVKvvL3BEJi5ZA3vGsBvhTUz4
 aN9sGLccmG7b8Zhw7m10XvqQu3e9G1UitIFLCg8R4duL9CFZS6aaa9NREMUVyvDYsDx8
 +ANtwDOId5eXGRkJsuFSqqvoXJnXY42bbiXwhndhYxnzHlldAZbO7KdNaMwdx9INiPfi
 1Rgg==
X-Gm-Message-State: APjAAAVYw41yE/y2ighy15S+Sz/TR2IOQdL+BOFZB0BV1wwcL0aT7Ws+
 fHVsrHJuiu/Vx8IQjUX3lIpTfQ==
X-Google-Smtp-Source: APXvYqwrVMs0yh7CDR2NFVCdL3eYWxKYDhRdf9ecfSKiuilKs1u6UAQfvxQI6D9fsMIalDTt0BqZkQ==
X-Received: by 2002:a63:c643:: with SMTP id x3mr22957967pgg.299.1582053249684; 
 Tue, 18 Feb 2020 11:14:09 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 m187sm5572153pga.65.2020.02.18.11.14.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 11:14:09 -0800 (PST)
Subject: Re: [PATCH] Avoid cpu_physical_memory_rw() with a constant is_write
 argument
To: Stefan Weil <sw@weilnetz.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20200218132023.22936-1-philmd@redhat.com>
 <87e06de3-179b-54a1-3451-39a0a30b65f0@weilnetz.de>
 <CAFEAcA9Jr2Yi1K8_9MGUJYt8C=OcKbWDh1UJjTQG1EspLux3JQ@mail.gmail.com>
 <eed26f29-6cbd-7663-7f30-39596bb70422@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d0eab4fe-14ec-70a0-6917-8fc097265bf7@linaro.org>
Date: Tue, 18 Feb 2020 11:14:07 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <eed26f29-6cbd-7663-7f30-39596bb70422@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 "open list:X86" <xen-devel@lists.xenproject.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 10:59 AM, Stefan Weil wrote:
> Personally I like the way how the standard C library handles such
> pointers for functions like memcpy, fread, fwrite and others.
> 
> Therefore I suggest to use `const void *` and `void *` and to avoid type
> casts.

Seconded.


r~


