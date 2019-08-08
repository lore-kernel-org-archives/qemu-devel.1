Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E175C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:10:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D85172186A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 05:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hpp9q7hS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D85172186A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvagf-0000gD-3k
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 01:10:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55818)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hvagC-0000Fa-0x
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:09:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hvagB-0001dH-0C
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:09:35 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:33717)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hvagA-0001d1-PG
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 01:09:34 -0400
Received: by mail-pl1-x644.google.com with SMTP id c14so42918696plo.0
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 22:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ki0an8t+XycXtBkdcydgbnQPkp64g6Uoo4kwWAslmZo=;
 b=hpp9q7hSj+5+p8yAhBntyH7luXypM1AM/siXXJq1Ltrp8ODZNLr7iBEy5IJre+1dx/
 1hOWsr5Z+uMNVHC6JOhimSePY52/HQ7vi5KH7CCPQlQ1OWfYmKBp8SwEUcSx+7iGm6Y8
 B4heo9cwbf7Kd8IRjAu1JWJeoQW6EAsTag6deSf6HlWk2mTXeZT7fUyclIba0O3qpCOO
 7Jwul4OD4PcV8sYQU3sxh21LxzjKYK5P2xTDv0AVW2SWbh38mLioZQKogOE40fnjdk8V
 6fOic5gZRxs6+UYL0AnRN+jph1MWhmaZRhpuhXvCzl9oG2qSLj8/OdyQELRMhPuSjlFi
 zPtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ki0an8t+XycXtBkdcydgbnQPkp64g6Uoo4kwWAslmZo=;
 b=BaW/aVv6i13Z0UbTSRWqjiDNUNM1SFsFMgWTdN8soUERorgzbb8H06me+VkY2E3CAD
 Ee8eZaYA+NekTJlVS3bYBx8GLP9EPhLPY+a1Nw49JUr7OMrR5cC358OsRYYImpyYpYyn
 oSr95U6m4Wlg9rwI/merd3uYiMC0Mpe7zY13On+nCfapOOgehwmmb5HuIQV6/WVMGFV1
 f1U6BZFBC0RtnuW7upZ0pvevl/6qVIzSRumnZQbioTnbwGBGkppCpG+jllWVPmR4nNvZ
 KL/EscFXJ3Cq87+iavfMr5r0bAJO8CzTfEo+nB6HjX0T5Z0ziai8RhOktmPff4UDBFhm
 plFw==
X-Gm-Message-State: APjAAAXAAWBPF4rCZVVwiaSbKYS13gZhJY13EQtI14zzZpqc3lZZ8oWu
 /nkd/bJH9RGsRyzElNZ4HJBY7KWiTQE=
X-Google-Smtp-Source: APXvYqyDHpQEHzmoeGP9qqKyX96vGV6bMGcm591jk2whUVLJ2IwloRiKAl3TL0SuAm0Kj6F7Q7FR4g==
X-Received: by 2002:a17:902:e613:: with SMTP id
 cm19mr10894436plb.299.1565240973340; 
 Wed, 07 Aug 2019 22:09:33 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h1sm121799064pfg.55.2019.08.07.22.09.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 07 Aug 2019 22:09:31 -0700 (PDT)
To: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-13-armbru@redhat.com>
 <d822b034-f283-5945-da5d-4fe3bc767f2b@redhat.com>
 <fd6a172e-1c79-5c0a-c9ba-3dbc671dc72f@redhat.com>
 <87pnlgl1sr.fsf@dusky.pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <83f142c4-99cd-5d60-2547-1c0e608f638b@linaro.org>
Date: Wed, 7 Aug 2019 22:09:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87pnlgl1sr.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
Subject: Re: [Qemu-devel] [PATCH v2 12/29] Include hw/irq.h a lot less
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/19 9:27 PM, Markus Armbruster wrote:
>>>>  typedef void SaveStateHandler(QEMUFile *f, void *opaque);
>>>>  typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
>>>> +typedef void (*qemu_irq_handler)(void *opaque, int n, int level);
>>
>> Should we prefer a consistent form for function pointer typedefs?  Here,
>> we've mixed 'rettype Name(params)' with 'rettype (*name)(params)'.
> 
> Which of the two difference I can see do you mean?

Eric asked about function type vs pointer-to-function type.

In usage,

  SaveStateHandler *variable;
vs
  qemu_irq_handler variable;


r~

