Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09950C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D36F620693
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 12:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D36F620693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsnne-0007nl-60
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 08:33:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hsnnD-0007I3-GE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hsnnC-0008F2-Jv
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:33:19 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:52830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hsnnC-0008EW-De
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 08:33:18 -0400
Received: by mail-wm1-f68.google.com with SMTP id s3so60601042wms.2
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 05:33:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0T9lTxOLDFBEseRDcg90PQpjuDzOlXyjEFc5keDzUUc=;
 b=Vl8bMOflvknyek2aVgn4R9X2bMgOvCPFEGzHXNHkpT9dqD2Pf/Vsan/nEAm7eOQxxb
 OJFPajxOjA778yrZnsGNAn3YV/8MEQfnfHIEZiPQ3m1UQTaCfaWDNIBMpG8T3VMxhA+3
 KLhIK3OPeW6jSJL4H1mPSraNtW4ZUNgv6omHBBPvNHPMrdovDdcEWM5ZgXLWEhoOeH81
 qIP9DHHMzGq/nG/fmrcThPOFhV9pfI1bocbwWzPv33XAPUGPzSlwx1dklF+K3o5IMBId
 guJwREZ2ApszHxISz0gNsvRE4YT9WcWixpnaBYv1nOWK4hpWZXsNVM9NYJ3iFsR8BfOp
 QSCQ==
X-Gm-Message-State: APjAAAWWqmOHJS01U0WFf2tYyAu4yXzxexGI/pn6+jlKwIUOj1r1R2Ey
 SEfkTOKrHdl2YZZwz7lmLnrWRQ==
X-Google-Smtp-Source: APXvYqx0Gfxen1aDoNjtvwtNPLL16ulsQ5fHs4tgo9lQCqT/m+qcBJy38OhVcwypF6w7tCP1kJiuFA==
X-Received: by 2002:a1c:968c:: with SMTP id
 y134mr104737672wmd.122.1564576397171; 
 Wed, 31 Jul 2019 05:33:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91e7:65e:d8cd:fdb3?
 ([2001:b07:6468:f312:91e7:65e:d8cd:fdb3])
 by smtp.gmail.com with ESMTPSA id b5sm58014119wru.69.2019.07.31.05.33.16
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 05:33:16 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 qemu-devel@nongnu.org
References: <20190731075652.17053-1-thuth@redhat.com>
 <20190731075652.17053-5-thuth@redhat.com>
 <b3696656-201d-9777-0b73-b6903949d61f@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <533ca6da-a3ae-1c6b-a75d-f20bf97d8115@redhat.com>
Date: Wed, 31 Jul 2019 14:33:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b3696656-201d-9777-0b73-b6903949d61f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH v2 4/8] hw/core: Add a config switch for
 the "register" device
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31/07/19 13:44, Philippe Mathieu-Daudé wrote:
> What about naming it REGISTER_ARRAY or REGISTER_BLOCK?
> 
> The API is:
> 
>     RegisterInfoArray *register_init_block32(...);
> 
> Cc'ing Alistair for better name ideas :)
> 

I think REGISTER is okay. :)

Paolo

