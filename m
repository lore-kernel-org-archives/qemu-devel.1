Return-Path: <SRS0=0mkr=WZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D14D7C3A59F
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A834A20828
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Aug 2019 18:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A834A20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i3Or7-0002Yf-Oq
	for qemu-devel@archiver.kernel.org; Thu, 29 Aug 2019 14:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41749)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i3OqE-0001Ub-1s
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:08:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i3OqB-0000mL-A8
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:08:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40330)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1i3OqB-0000lL-4H
 for qemu-devel@nongnu.org; Thu, 29 Aug 2019 14:08:11 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A856882EA
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 18:08:10 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id o5so2489574wrg.15
 for <qemu-devel@nongnu.org>; Thu, 29 Aug 2019 11:08:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=CQWLlOCEAXNM1XHQS+wuXw28cMfRqTy0sIlKvCp7+aE=;
 b=cxOLjxXv6OUfx7LwZISbWfeJoNN8jddQaR2DOQhWh0z0D+nFaBS7oum5UVP2Y8vAaU
 WfIfgc9uWQmssKIlWhmCv9+R2hreddR2dd7jQeNFGa8tZ62R7ZHxo1JFjCtKA/xMvuIb
 aIk8gAPv1faQTYZkWwdyxPWsfw8v9iu3nDNt8iwUDN29YPe/E1j9nqsPxvBhdUnRg+tL
 cveBQ3A++hVIKon9kQ8envigDOTi8r2ybeqnokyI37KTPadV1VtHAeuh1atKYwcXhwh+
 gPZlGMuVk2tX9frbaei7wGkuTTmZTxKB+Y7zGCQe8ozm35DBz3J4UCnXWww8tYrN01VQ
 C8mA==
X-Gm-Message-State: APjAAAVMppaSWaQBJY39ed/UrfE+0vUND0I1NzDdfuA6Sm+nqF8jnFXz
 PAjDwUzJsbFq+90bHFaASzl+6iwe6NhaiK7MANWLDH/PrN/ZL/VSv75H119mkLxUvarNtRHT6ib
 bwo4vb4YNLS6/EiM=
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr13012168wmj.17.1567102088969; 
 Thu, 29 Aug 2019 11:08:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwPoFTc6V/kkhWN1RnUYXwc8BEbyAO5I/RY2iCp7AW8xf/qK39vARP2+qykaugV8O1thUcK4Q==
X-Received: by 2002:a7b:cb11:: with SMTP id u17mr13012138wmj.17.1567102088692; 
 Thu, 29 Aug 2019 11:08:08 -0700 (PDT)
Received: from [192.168.1.41] (251.red-88-10-102.dynamicip.rima-tde.net.
 [88.10.102.251])
 by smtp.gmail.com with ESMTPSA id j17sm2207525wru.24.2019.08.29.11.08.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Aug 2019 11:08:07 -0700 (PDT)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190823135811.13883-1-philmd@redhat.com>
 <20190823135811.13883-4-philmd@redhat.com>
 <402a2532-a61a-18cc-2153-73a0447bad7d@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <26cc14fa-977b-edea-8879-22c84dc01c96@redhat.com>
Date: Thu, 29 Aug 2019 20:08:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <402a2532-a61a-18cc-2153-73a0447bad7d@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] RFC target/arm: Do not build pre-ARMv7
 cpus when using KVM
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/23/19 7:12 PM, Richard Henderson wrote:
> On 8/23/19 6:58 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>> A KVM-only build won't be able to run pre-ARMv7 cpus, disable them.
>>
>> If KVM is not enabled, they are enabled by default.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>> ---
>> Sadly this does not work with --enable-tcg --enable-kvm dual config.
>> ---
>=20
> Huh?  --enable-kvm does not imply --disable-tcg.

That would have made my life easier ;)

>> +config ARM_V4
>> +    default y
>> +    depends on !KVM
>> +    bool
>=20
> This should surely be "depends on TCG".

I restricted this to KVM because this is the only one I know and got
confirmation by Peter. I don't know about other accelerators but I'll
happily take your suggestion!

Thanks,

Phil.

