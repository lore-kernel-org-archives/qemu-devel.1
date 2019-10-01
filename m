Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89F17ECE587
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5573320B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 18:06:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GcSKQVJe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5573320B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMXi-0008CW-Im
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38418)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMTb-00040v-0O
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:02:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMTa-0000CX-1d
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:02:18 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40131)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFMTZ-0000Bg-Oh
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 14:02:17 -0400
Received: by mail-pf1-x441.google.com with SMTP id x127so8581761pfb.7
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 11:02:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=2XXEriAxokMcV7VOY031/4RQoGYJDLoaB/07nRGpCKM=;
 b=GcSKQVJe0hDgfuUVrjwf8cbVpJsYjZJ8FYiDKjunSttpomWeGlaVhfljPY/+JtTcAJ
 GI4bjuWcDbmE/xGI/K1uIHI70u4ML9zHIf01veQ5UgJ+oqrNCQP7Y6haSMqXOV/NeYB+
 HTBkbe+q6L9+6drCOEAGDKZktDfBn+1fxswfMajwGEBTBTzxJ+Exy8FecNe/t2+R7N4t
 QR+OxZ/e7bdInv6u5DhPfyEgF44AXxuL69a6O02eGU0YwoZmCE1DAsV50V2o7X9Ct4oJ
 AuSuT7enz0stT4TNTC3dty+smG6G6emQSUnHmp6K9hzbc1mMKq1T7WLH+ffYB7uphQMq
 4eLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2XXEriAxokMcV7VOY031/4RQoGYJDLoaB/07nRGpCKM=;
 b=Sfg2IVz6ZKlS7TGnfSVaDf1Wbky+9rWRqng+twt96KePSWVCsizYLaMLo1gg5v7PYb
 1EmuHNaTgs4UXTOhsenYq3fmzRWNuG0pgdVBBy6xAvJhkmhK3UpD6vujKHlao4mUh77B
 sE/CXOd6ahpvmRKAZq4eOegNNcR6Zwv2MiybAjA+13JFq0cQU8ZBYeZJJygOkhnnXsz2
 gBdPuTUwjAoHs8z4sAN+KFjHZ34Fo/SHu5tD7u26Uhb8zLiCj2qQq4hAhJGxsla22IlZ
 SeNm1E7TAX28CHZhy80fZ2a+eeihzAWouPeBtZYwhWmyLVwT3XNNi4dZt1On+g2hmgQr
 S2Qw==
X-Gm-Message-State: APjAAAWLmQzydh7PFWHxmbK9R1lgt5C5Q3yM56d3K3ImkhzOhYNO8xq5
 60zsjKRvuffCfGbwO0h620V61Q==
X-Google-Smtp-Source: APXvYqwkbbkDV8sT9mZvbQO/xf2srShFmxJ4hZ0ngt3dV9YdFQYTxA9H+mo/23++bqgXGLQqotirmQ==
X-Received: by 2002:a63:dc13:: with SMTP id s19mr31102952pgg.272.1569952936575; 
 Tue, 01 Oct 2019 11:02:16 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n6sm15997932pgp.12.2019.10.01.11.02.15
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 11:02:15 -0700 (PDT)
Subject: Re: [RFC PATCH] configure: deprecate 32 bit build hosts
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20190925233013.6449-1-alex.bennee@linaro.org>
 <CAFEAcA9vb5_Mi_axWpu7269Zg0xMLbiiV80ofLeyDpfws3G4nQ@mail.gmail.com>
 <4512b61a-ed82-e628-88e5-f44ef87c2b50@linaro.org>
 <20190930092519.GB11996@redhat.com> <87impakrky.fsf@linaro.org>
 <CAFEAcA8_Zt+4RuXh8ww3Xm5=fQT+e_XcjZ6VC2N9k5mzLy0bnw@mail.gmail.com>
 <ddf455e3-742e-81ce-c51a-d783e8d2ad55@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <58da7aa4-877b-2c85-71f5-e703a841e6d4@linaro.org>
Date: Tue, 1 Oct 2019 11:02:14 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <ddf455e3-742e-81ce-c51a-d783e8d2ad55@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::441
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
Cc: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "qemu-discuss@nongnu.org" <qemu-discuss@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, qemu-ppc <qemu-ppc@nongnu.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 10:56 AM, Mark Cave-Ayland wrote:
> Just out of interest, which host/compiler combinations don't currently implement
> int128_t?

GCC only implements int128_t for 64-bit targets.


r~

