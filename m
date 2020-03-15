Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92114C10DCE
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:21:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5327E2051A
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 22:21:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T7GAaOpa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5327E2051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDbd4-0002oN-8c
	for qemu-devel@archiver.kernel.org; Sun, 15 Mar 2020 18:21:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60054)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jDbYt-00022c-FL
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jDbYr-0008LA-Vc
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:16:47 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25689
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jDbYr-0008Br-Mn
 for qemu-devel@nongnu.org; Sun, 15 Mar 2020 18:16:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584310604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JVq0jzVMd22wrFGV6AGs0YUGbFRod6Ol4uSuY4S5wO0=;
 b=T7GAaOpaxLaLx2IPzp8aW37rhQ3rC0zC6M6IbH+gCVzQzbHFxvHCKuAXakK9CXMXYGdGgd
 vp4Ht1vUzjkYi8QwCNcwPSSkti5H0qd73yOs7/yEXg0tKydr12Mj19NKV3Pf4AdpjMC3KD
 hag44n8VIqE+i8hMkgiTLGQh1QA1OaM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-c0-3WB2KOdudekQDnO5xwQ-1; Sun, 15 Mar 2020 18:16:43 -0400
X-MC-Unique: c0-3WB2KOdudekQDnO5xwQ-1
Received: by mail-wr1-f69.google.com with SMTP id w11so8018426wrp.20
 for <qemu-devel@nongnu.org>; Sun, 15 Mar 2020 15:16:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iRHW7+jG/l3gvTxinmkE5xtvg/1Q8eGX49Sjbci+aqU=;
 b=Tl4lCnvzmZZZWMHZvEz5dZflD7tYVzPZs1leHigAJHwKnWAK+8/sdnvshJv9zjUCIu
 EWm9vZSm+BHoRZE2eZsNv1nEBQ1NjjhUAU1AQZEPT5kOzw0I8XDscDDqd1e+Z3TV4VCq
 8dzof+CpdOJml2Y//BcNalIU3q/NIoU1XfxprrovvTyMqvvbieSKOTVWT2RHV9x4A/Ur
 7Sn17JXedv5XCPiPrmwoEINp/HlNgwcJQN7KRQ/QUZkGxfnp+JdaZJxTtJF+nf+bQcxD
 ARd77001AW62fpMAE01eH0nZ0SEPgo874/N7zvJZrEuYB/UdW0YZd56YaJuEj6SKy0xn
 QVHg==
X-Gm-Message-State: ANhLgQ2KciSvpEWoshEmcKCA99k5K/XFUtnM9Z4A1O9iFTkBB1Wgraag
 hqkvdM9jiC/AdaPz+4Du5C4SYTtN5S9C29NByDl7HmRsFikQw8zzg9p2imOwzlA0Xf/G4Frvxr6
 kzvQAOXoEMn3sMP0=
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr23419072wmj.176.1584310602051; 
 Sun, 15 Mar 2020 15:16:42 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vv6iaxjkr3W2PE6VXHais/j4NhYURo+zr0W427LdzZXnh8ZgZ8giUhQG/4lD5VEPVdDGxcR2Q==
X-Received: by 2002:a7b:cd83:: with SMTP id y3mr23419039wmj.176.1584310601749; 
 Sun, 15 Mar 2020 15:16:41 -0700 (PDT)
Received: from [192.168.1.40] (191.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.191])
 by smtp.gmail.com with ESMTPSA id d15sm89324337wrp.37.2020.03.15.15.16.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Mar 2020 15:16:40 -0700 (PDT)
Subject: Re: [PATCH 01/14] Makefile: Only build virtiofsd if system-mode is
 enabled
To: Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
References: <20200313183652.10258-1-philmd@redhat.com>
 <20200313183652.10258-2-philmd@redhat.com>
 <8f73d608-d28e-b896-b1f0-f95d599502f0@vivier.eu>
 <d9b29b2b-58ff-512c-c426-0ffe7bcad295@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <29d183c5-6dc5-39a0-e8be-fa2e7f37d331@redhat.com>
Date: Sun, 15 Mar 2020 23:16:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d9b29b2b-58ff-512c-c426-0ffe7bcad295@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Cornelia Huck <cohuck@redhat.com>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/15/20 8:40 PM, Richard Henderson wrote:
> On 3/13/20 3:28 PM, Laurent Vivier wrote:
>>>   ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
>>> -HELPERS-y +=3D virtiofsd$(EXESUF)
>>> -vhost-user-json-y +=3D tools/virtiofsd/50-qemu-virtiofsd.json
>>> +HELPERS-$(CONFIG_SOFTMMU) +=3D virtiofsd$(EXESUF)
>>> +vhost-user-json-$(CONFIG_SOFTMMU) +=3D tools/virtiofsd/50-qemu-virtiof=
sd.json
> ...
>>
>> Why don't you do that instead?
>>
>>    ifeq
>> ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_SOFTMMU),yy=
yy)

This was my first option but checkpatch complained because it is 80=20
chars long...

I also tried:

ifeq \
($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG)$(CONFIG_SOFTMMU),yyyy)

which is uglier and still too long.

Following qemu-bridge-helper syntax I also tried:

ifeq ($(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yy)
HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) +=3D virtiofsd$(EXES=
UF)

which is also too long =C2=AF\_(=E3=83=84)_/=C2=AF

If you accept checkpatch complain I can use the form you prefer :)

>=20
> Seconded.
>=20
> r~
>=20


