Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EE0C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 660A024649
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 17:32:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CdJl1mmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 660A024649
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j46j1-0000SJ-HJ
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 12:31:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53772)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j46gZ-00061j-Rv
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j46gY-0007Vt-Ul
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:27 -0500
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:40146)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j46gY-0007Uw-O5
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 12:29:26 -0500
Received: by mail-pf1-x441.google.com with SMTP id b185so664769pfb.7
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 09:29:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=tNymIGaDL1k9Vm6DWjh8/BMCjNDMJ8vmvxm1VFckJdA=;
 b=CdJl1mmgYy53WpAH8CZQX1KALK5VHI1GkHEG3Wty9ltMIAYgxaiZoR5jGWVa+mDJwP
 upQTeYv9ccn00+cWsUkMILZJyJzA9YalJjVlbbCjaCCjC5icKeRhmOCuZHDvqT9a4Yyr
 fZ8tUnAbCzVIEaFc3mNFC7hd8XTuCNfZ6nYjdhCtQDSGPx570XtZhXPp/CzF65MyfZPw
 eCuyFOByLxJeNv8EX7bGwlt5WaA1JpYvYP8O+VJvqeVBhu+NIf3XQ9x9tFB8M0wGu+OZ
 s4f0W1cKTRcucCTL8z1EyoZeTDhqmBgfFzkOj/nibHVSSb1Mp1sxWVVBKxBlGTk+rVUv
 dXrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tNymIGaDL1k9Vm6DWjh8/BMCjNDMJ8vmvxm1VFckJdA=;
 b=plullFW3+NaiwOuYGuE8lFZv+OOhLU/ZAR5ElKerLuIUjNPskrXa//UusvSCPLkWsP
 WAQ17ygh6RlxdRp4uh0VbSYoEm/iuBT/QfnaJXti8Uyik9OWwwcEQGBPUG4dzzf/xSwF
 Bnz4wWHG4cKs2Pb1raEeW7H0scbSK3xEmwHXoBba0o9u8wJt8Qz6GMckPEd2De05qCGK
 YBom65TGl5xiB47Zw+aUfCj3fRJeBowy9THpQkt+FUzrDPrHI5uPUYu/29SGBx91rQeM
 gAsfQ+YoiSBpIq/QVLwXI7N4MXZK/ayvywp78snBdemM725RDMZKOMu3mcoj0Eyrk07n
 ABvg==
X-Gm-Message-State: APjAAAVMkfWGEGNPlPGPyv1yEq9scxj36RZaljL+RcN/w4GsStyeKIdU
 k78HqtKBqMjQuyQL7G7Znu0YUw==
X-Google-Smtp-Source: APXvYqybo7GNtGavtxLg1kUNZhbOecfPi4+pKBF30yyu15ZtlIgiYlN2J/jD+19qE+hpr1WIwK1K+A==
X-Received: by 2002:a63:5807:: with SMTP id m7mr22058939pgb.83.1582046965621; 
 Tue, 18 Feb 2020 09:29:25 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 200sm4914517pfz.121.2020.02.18.09.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2020 09:29:24 -0800 (PST)
Subject: Re: [PATCH v5 24/79] arm/musicpal: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-25-imammedo@redhat.com>
 <a0a461ef-b4b3-fe1a-dba3-c1672a33670a@linaro.org>
 <20200218095905.1890f768@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7e913182-6c8a-e52c-22a2-47d9c4322252@linaro.org>
Date: Tue, 18 Feb 2020 09:29:22 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200218095905.1890f768@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jan.kiszka@web.de,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/18/20 12:59 AM, Igor Mammedov wrote:
>> If for some reason you need to re-spin this series again, and considering my
>> comment re arm/imx25_pdk, I think it would be worthwhile to create a common
>> helper for this:
>>
> 
> This check is temporary, I plan to replace it with a similar
> check in generic machine code and clean it up. The reason it
> is not done in this series is that generalizing it is not
> related to this series. Hence I'd prefer to keep current
> approach in this series to avoid touching already reviewed
> patches and generalize it later.

Fair enough.


r~

