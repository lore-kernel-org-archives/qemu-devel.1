Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38770C432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:34:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 034D220715
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 15:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIaOxh8d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 034D220715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iYAxQ-0001c9-4N
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 10:34:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43308)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iYAwi-0000ov-Rp
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iYAwh-0007U1-QE
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:08 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51909
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iYAwh-0007Tq-ML
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 10:34:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574436847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RZeAEYFQVD82NtGZfW60Tmc5Yfxxs01U6iaCVtjrHYY=;
 b=fIaOxh8daKihlwPSRU38ZADzPdM9mHiZ0iCpgJXeoeVHhfgfLL1FiBO5LaOqANLhLK8z5O
 P0nvIhq9y/nZdVfvy3FGJ5CpdpJLJegOwfMHdwwOn81KZSYVjpO9SGzaQ7t6xqx1CxOKX8
 xnMuWh2tfHAa+Dp0IbacI2kIyUVxvKU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-84-jQLEjeCrNfK581MSNYAfRA-1; Fri, 22 Nov 2019 10:34:05 -0500
Received: by mail-wm1-f69.google.com with SMTP id q186so3247693wma.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 07:34:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/vxWEDfBNC6nyK9DqM0zK1b2kUACjo4Abp3TFY5gFBE=;
 b=XB7vrCbOSbnw1/X2n6TVm3H7YAyxASwILkHmUjGfzzqSzCgOUVcIVUtmAKHgeRFa2z
 wweqAZXn8MtyHiMZfhdxnQEgo5AzOoiwkuss1W9IDiqpSFJenHZtZO7F44xPtcAcEUO+
 EvtIQKU5N4q93AY11Nsyn0IJLYDLGkpX1uBROrzUAQCHBw5fEbmglq+JJMZ16aty1HyR
 oM1FmfR8Lt4DahoqshUQTmlANU5vkf16H5tTC8C5lCS4f74bAEOR2JH+nDNvuds/oY5s
 8nL6sfVYr62NWbpN1qT/kEO0JJhldvqmKAT+HFvfOeLnhDAk1LALW1mxxDqJk+9oM8xs
 nTfA==
X-Gm-Message-State: APjAAAXgCbk46wWq3K+zmrFcNw4soT1TbbqniUikECLa1BMWkmEzuxkD
 WsbYfmdKep7ngDfxrED18sM3dCeyQ7SqgOGQJfZjfWVBQUMF2Bpt1J0MJb/1vyNwyRPTZdww+s1
 1Vws4Rc+twPUJVcA=
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr17182233wme.89.1574436844133; 
 Fri, 22 Nov 2019 07:34:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqxO3O76vTGyW3LNpO55+Tt4nnWoWam/nsmRONgORJQbnODSYM4yY/daPg0kYC+7qVpHQhM3xA==
X-Received: by 2002:a1c:9c54:: with SMTP id f81mr17182210wme.89.1574436843861; 
 Fri, 22 Nov 2019 07:34:03 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id t187sm3810796wma.16.2019.11.22.07.34.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 07:34:03 -0800 (PST)
Subject: Re: [QUESTION] Usage of '0b' as a prefix for numerical constants?
To: Eric Blake <eblake@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAL1e-=gstogyXyAFV09-_mdqPs525bQP673+TcoxoRRDKwYAqw@mail.gmail.com>
 <f78d09e1-c416-9646-7786-8091640da383@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2eae7dc1-af66-28e1-e8a9-e5b9d8bd14c7@redhat.com>
Date: Fri, 22 Nov 2019 16:34:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <f78d09e1-c416-9646-7786-8091640da383@redhat.com>
Content-Language: en-US
X-MC-Unique: jQLEjeCrNfK581MSNYAfRA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/22/19 4:10 PM, Eric Blake wrote:
> On 11/22/19 8:56 AM, Aleksandar Markovic wrote:
>> Hello, all.
>>
>> I am currently reviewing some code, and I see it uses '0b' as a prefix
>> of numerical constants, similar to these examples:
>>
>> switch (((inst >> 22) & 0b1111111000) | ((inst >> 12) & 0b0000000111)) {
>>
>> or
>>
>> ARRAY_FIELD_DP32(s->regs, CRB_INTF_ID, RID, 0b0000);
>=20
> Binary constants introduced by 0b are a gcc'ism, copied by clang, and=20
> thus usable in qemu if we want to (similar to our use of the ?:=20
> operator, the {} initializer, the ranged case 0 ... 7,=20
> __attribute__((cleanup)), ...).=C2=A0 But it is not standard C.
>=20
>>
>> I remember a while ago, something stopped me from using '0b' as a
>> prefix in my own code (was it checkpatch.pl, or perhaps some statement
>> on coding style, or a compiler, or something else - I don't really
>> remember), so I didn't use it, and used '0x' (hexadecimal constant).
>>
>> What is really the view of the community on usage of '0b'?
>=20
> For small constants, 0b111 is just about as readable as 0x7.=C2=A0 But fo=
r=20
> large constants, I much prefer 0x7f over 0b1111111.

I use both. The choice depends on the datasheet I'm following. If=20
reviewers look at the datasheet, I don't want them to do extra=20
conversion just to verify the implementation.

So in my case it depends of the documentation used (usually restricted=20
to ISA/hardware registers although).

>> Please C language standard and compiler experts, and also regular
>> participants like me, speak up.
>=20
> If you want to provide a patch for coding standards (either admitting=20
> that yes we use the extension and here are some guidelines on using it,=
=20
> or declaring no new uses of it and maybe patching existing uses to=20
> switch to hex constants), then go for it.=C2=A0 Maybe wait for more opini=
ons=20
> to come in to see which color more of the developers prefer for their=20
> bikeshed.
>=20


