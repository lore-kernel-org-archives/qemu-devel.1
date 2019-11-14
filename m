Return-Path: <SRS0=NHD5=ZG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF80C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:49:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2F58206D9
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2019 10:49:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kj9GSECt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2F58206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVCgY-00067Z-Md
	for qemu-devel@archiver.kernel.org; Thu, 14 Nov 2019 05:49:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52985)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iVCfG-0005WB-Fl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:47:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iVCfF-0000Ib-6k
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:47:50 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:24095
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iVCfF-0000IN-34
 for qemu-devel@nongnu.org; Thu, 14 Nov 2019 05:47:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573728468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=fzOlYy6h7VsmWs67bBTOooJ/a+ugTtnWlEf5027GEbA=;
 b=Kj9GSECtIMbtMguIdznfZ1aSOLzNzWkXtRiYbCfKiNqBlWlY0QBY6upqVBo7Uw5iZ+ZEM2
 eha1RPTSZVV9+oZkAdmHQOUUMSwOrcbzsi/EjwcifhvWmpdDdymN3uhiX3Ai+Dz7jAa2pI
 mCdAmlsdu7jpKzazrvfaHvDROyg2JiE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-RHH-wY5JPjWvy-6Pfd7MCA-1; Thu, 14 Nov 2019 05:47:45 -0500
Received: by mail-wm1-f70.google.com with SMTP id g14so3646754wmk.9
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2019 02:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pG43dw39Vf5xaVxHJxC0S8P0fzBrCu1zHRzg9iHxAhQ=;
 b=LXClRoCgQ9VwhrztpN1enTkT/VfoadzSJbPg5GihRZT1dU5gUT+kPn2mDWkSWihtG8
 vf9eqxOTBCdjuho8WEXNS69ZJ/7F4iVkLyKJTAVMFP8yH4U4XiD1UMlWtlVbryDXVLQ9
 fPL6J+N1ZNpGdg/MRd+B14CpY1xQJ4F2nc0xs3JDuskRJHMTlkXXza9JMYbxJ72q2elP
 jYI69Vf/v5BQnVwVZjR15L3HcUOHFFanb8wIDHEFX188MT6nZaslWmKeAo4bEqthBK3n
 ajO+JefstMPcO8ruY8rc6FCyk3j41dazBM+5yOmx38WuGGIPl+2QEGQsiwuyMeBeX76S
 CBHw==
X-Gm-Message-State: APjAAAULcrWphL63FOQV7ge8glRIsS0Wxxh7h0barC5KIECBccdkGZXQ
 /KaaeSCEKZaM8okcQM88W78bCP0SbcJtv9a9uQUgv3JC9Bvt51GqbGIpPIdl0lBVuOFCvAKAA1M
 m0VcXLpZvUGJyRro=
X-Received: by 2002:adf:f50b:: with SMTP id q11mr7510691wro.343.1573728464475; 
 Thu, 14 Nov 2019 02:47:44 -0800 (PST)
X-Google-Smtp-Source: APXvYqxlB5HTk7mOcAtMVIOwgliy/TCh4oLKqY8wI6BgaOm6huUlj21h2o4wQp+szlWPv4wHHSdJWg==
X-Received: by 2002:adf:f50b:: with SMTP id q11mr7510670wro.343.1573728464182; 
 Thu, 14 Nov 2019 02:47:44 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:a15b:f753:1ac4:56dc?
 ([2001:b07:6468:f312:a15b:f753:1ac4:56dc])
 by smtp.gmail.com with ESMTPSA id w7sm6393412wru.62.2019.11.14.02.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2019 02:47:43 -0800 (PST)
Subject: Re: [PATCH 01/16] memory: do not look at current_machine->accel
To: Peter Maydell <peter.maydell@linaro.org>
References: <1573655945-14912-1-git-send-email-pbonzini@redhat.com>
 <1573655945-14912-2-git-send-email-pbonzini@redhat.com>
 <2db4f901-65ad-4b80-d309-b8b63330492f@redhat.com>
 <4783e606-19b8-c3c0-08ab-ac84b02af6f4@redhat.com>
 <CAFEAcA_FnfJx=oae5e_KGcmqwyUtM01KeywjpSSa09fu9++sMw@mail.gmail.com>
 <07c6a4ea-1d5b-da75-9fed-3b9e7bb1d193@redhat.com>
 <CAFEAcA-9n38=Zg1YuFfy1pS-8Vc8EZD82nPdfYUf2gBAJY8tBA@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <3f1478bc-ef78-23eb-122c-3f9912ba250e@redhat.com>
Date: Thu, 14 Nov 2019 11:47:44 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-9n38=Zg1YuFfy1pS-8Vc8EZD82nPdfYUf2gBAJY8tBA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: RHH-wY5JPjWvy-6Pfd7MCA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/11/19 11:40, Peter Maydell wrote:
> On Thu, 14 Nov 2019 at 10:32, Paolo Bonzini <pbonzini@redhat.com> wrote:
>>
>> On 14/11/19 11:21, Peter Maydell wrote:
>>>> FlatView #1
>>>>  AS "memory", root: system
>>>>  AS "cpu-memory-0", root: system
>>>>  Root memory region: system
>>>>   0000000000000000-00000000000effff (prio 0, ram): microvm.ram kvm:tcg
>>>>   00000000000f0000-00000000000fffff (prio 0, ram): pc.bios kvm:tcg
>>>>   0000000000100000-0000000007ffffff (prio 0, ram): microvm.ram @000000=
0000100000 kvm:tcg
>>> Why do we need to print the accelerator name for every
>>> memory region? Isn't it just a global property, or at
>>> least a property of the CPU ?
>>
>> Not all regions are registered with the accelerator, in particular not
>> for devices.  So we print it next to regions that are registered.
>=20
> Ah, I see -- so it's really saying "this is a kvm memslot"?

Yes, exactly.

Paolo


