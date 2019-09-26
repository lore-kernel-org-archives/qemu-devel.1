Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 411CEC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:34:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B5EA222BE
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 09:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B5EA222BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDQA7-00042B-71
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 05:34:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iDQ9F-0003OX-0Z
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iDQ9A-00084r-Hf
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:33:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33776)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iDQ9A-0007uH-9U
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 05:33:12 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDF445859E
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 09:33:08 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id l3so878620wmf.8
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 02:33:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JY56Tr2VUbh7JwWp11AFOj0Tv0tuy7dvFGwG04+QxyU=;
 b=aW5UBmGsKLFcJWX9fotYvaJGXXeVn8t5hhMELs0A8hwB1XBT2I84IbRG0WkkbHL90I
 I62/Ef3lG3FK96Gav3DeWIeZ8XUlvZOgLiIzFebmZV8boIEnefs8ejdvayBdVCjocFut
 0ZlKmsvkxFcJI3zRtqXXWMQAkmTP0gtcEG+TkkYdCy6MushxqW140k3ljK3Xk30A1Q+O
 Ys69bT1AKjG0Zd+U0WIdgshG8A4iJxshk0ZovmGnnzZjsnhR4AzZfJME+nEM2Jk/NGv7
 2KAEOz8NbrR/3/ihqqb/aBzAYUb4kFW0GfpTM9LmuwN+p0+lZGUVc82xxzT8NFr+ktQn
 n+wA==
X-Gm-Message-State: APjAAAWBSo392OOrggMdV+HQ5iEHiZCN8wYuhoO8UaYv417I5vuUtyfy
 UDQpu+gXPe4PWvnBVHnyPkfnI2+0Y3KpqSucuNmFJlGeR/ZOnorDIzIYKrlYm9I9MgRZyTFmUOu
 DSQucee1EVJVX3vo=
X-Received: by 2002:a5d:5643:: with SMTP id j3mr2241816wrw.357.1569490387444; 
 Thu, 26 Sep 2019 02:33:07 -0700 (PDT)
X-Google-Smtp-Source: APXvYqx7X9UQ+1zii8t+9UMOq3wQWLNhSrPUcunCotDf9Dcl2g/WY6mbOKGMSZ/0dVOlamn2Fj3g0A==
X-Received: by 2002:a5d:5643:: with SMTP id j3mr2241788wrw.357.1569490387120; 
 Thu, 26 Sep 2019 02:33:07 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9520:22e6:6416:5c36?
 ([2001:b07:6468:f312:9520:22e6:6416:5c36])
 by smtp.gmail.com with ESMTPSA id b184sm1586429wmg.47.2019.09.26.02.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Sep 2019 02:33:06 -0700 (PDT)
Subject: Re: Questions about the real mode in kvm/qemu
To: Maxim Levitsky <mlevitsk@redhat.com>, Li Qiang <liq3ea@gmail.com>
References: <CAKXe6SJfZt8WcA43Vsh0=GT=jBedcAOUx9DNGZ4Bsvi10oCkog@mail.gmail.com>
 <644968ffb11c11fd580e96c1e67932501a633fe4.camel@redhat.com>
 <CAKXe6SK+cEytTtgKHw8KXY=jY4xv=27GBu55hTbTmbRyTPsfxg@mail.gmail.com>
 <3d3f3a0e6e796260348c66e69e859e1901501ee8.camel@redhat.com>
 <23789310-35fb-8c93-44f4-532bcd34007d@redhat.com>
 <7c019f3a5236daaa79e67467f64cde212ad05f35.camel@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <4ed0f9ca-6cd1-fd8e-9abd-4098f85c7f9d@redhat.com>
Date: Thu, 26 Sep 2019 11:33:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <7c019f3a5236daaa79e67467f64cde212ad05f35.camel@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Qemu Developers <qemu-devel@nongnu.org>, Avi Kivity <avi.kivity@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26/09/19 11:24, Maxim Levitsky wrote:
> On Thu, 2019-09-26 at 11:18 +0200, Paolo Bonzini wrote:
>> On 26/09/19 10:59, Maxim Levitsky wrote:
>>> If you mean to ask if there is a way to let guest access use no
>>> paging at all, that is access host physical addresses directly, then
>>> indeed there is no way, since regular non 'unrestricted guest' mode
>>> required both protected mode and paging, and 'unrestricted guest'
>>> requires EPT. Academically speaking it is of course possible to
>>> create paging tables that are 1:1...
>>
>> Not so academically, it's exactly what KVM does.
> You mean KVM uses 1:1 EPT pages and no guest paging,
> to allow guest to access host physical address space?

No, it uses the usual HVA->GPA EPT pages and 1:1 GPA->GVA pages when EPT
is enabled and guest CR0.PG=3D0.  This lets KVM work around the CR0.PG=3D=
1
requirement when unrestricted guest mode.

Thinking more about it, I suppose that saves memory (the same EPT page
tables can now be used independent of guest CR0.PG), at the cost of
making TLB misses a little slower.

Thanks,

Paolo

>>   However, indeed it
>> would also be possible to switch out of EPT mode when CR0.PG=3D0.  I'm=
 not
>> sure why it was done this way, maybe when the code was written it was
>> simpler to use the identity map.
>>
>> Let's see if Avi is listening... :)
>>
>> Paolo
>=20
> Here a quote from the PRM:
>=20
> "The first processors to support VMX operation require CR0.PE and CR0.P=
G to be 1 in VMX operation (see Section
> 23.8). This restriction implies that guest software cannot be run in un=
paged protected mode or in real-address
> mode. Later processors support a VM-execution control called =E2=80=9Cu=
nrestricted guest=E2=80=9D. 1 If this control is 1, CR0.PE and
> CR0.PG may be 0 in VMX non-root operation. Such processors allow guest =
software to run in unpaged protected
> mode or in real-address mode. The following items describe the behavior=
 of such software:"
> ...
>=20
> "As noted in Section 26.2.1.1, the =E2=80=9Cenable EPT=E2=80=9D VM-exec=
ution control must be 1 if the =E2=80=9Cunrestricted guest=E2=80=9D VM-ex=
ecution control is 1."
>=20
>=20
> Best regards,
> 	Maxim Levitsky
>=20


