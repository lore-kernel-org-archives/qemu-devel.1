Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B952FC33CA2
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:17:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 821D4206ED
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 10:17:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvvBZiGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 821D4206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iprLy-0006NC-K8
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 05:17:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34485)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iprKf-0004jH-Il
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:15:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iprKc-0004db-Ju
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:15:55 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:56903
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iprKc-0004Yj-5z
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 05:15:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578651353;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQ2UfU8w29G/oaVKTKp2mh8vmKini1n9h6Red2B+zW0=;
 b=YvvBZiGfP8W6cDRC3A8gzsfL57867DmSIVyMEcygBY+kdt+IesAqSopmbhtC2nDYUCF463
 B+/oO0OVEf5AyGaoSpcjle6SooR8mowpsPwv014BgCU92+AjjW1AFSsMTC9dRa3rhBO4wD
 0NqTkqaQ9Yoe1IGrHTda7BhXgDIzEBM=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-233-tMGkBLXTNiqEJpQ8FiR0-Q-1; Fri, 10 Jan 2020 05:15:47 -0500
Received: by mail-wr1-f72.google.com with SMTP id c6so674905wrm.18
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2020 02:15:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8YWpjZUgl4Xi2Yz395aHpL0tkUwIStHBd0XsZhLc/lg=;
 b=dsYkT9da8im79oNGZ7wkzwDnOv4vYjMTfiKXwhXwdAC72pYVJj+lOmwTKH8m3UR+Kd
 nD+A8X9vCvZZUdXBSTevGL5nxSq9WWM0UZgayYENKuYj5dI4b+FeF9im5b6j7G7Fpl3e
 K9V3SrbsFzDoVpH4MG/yicNs0Zw/mgs/w4DQQ/ZmBWDv99F/avesU6p9iJf5Uc/h7yiU
 g81YlnoRPLUZhOIDTQXdXZDwpUoHt16BbY/zUQv6oqPIAbl4FXJW9CrAPuBcgkdNYot6
 AUuEJXMF6eW9Ooi17cP5WYViXtqqRgAtxpJ/1OYMT3zYhvWpvNgk42TbOwss/yQggbqx
 NswQ==
X-Gm-Message-State: APjAAAX0LBLtVmg+hS6y+qA2yYpka1gZE5RID/OaDN+EsGjaIUjnaDW5
 KokPQtpqcobmxqmy40CK2NDa5FJD3tUR4ZVbuTFVmOwo8HNtScFUan4NXitCgAcryJx8oqwYtwb
 35DLpR9rV5gvP/I0=
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3309190wml.67.1578651346883; 
 Fri, 10 Jan 2020 02:15:46 -0800 (PST)
X-Google-Smtp-Source: APXvYqwLZU7keuAfhDTa93VsoltEM8MMdewrk9fDAPV/LgD2mHNOld34jLRIvOQiDuWSwC+QCukwWg==
X-Received: by 2002:a7b:c956:: with SMTP id i22mr3309163wml.67.1578651346676; 
 Fri, 10 Jan 2020 02:15:46 -0800 (PST)
Received: from [10.101.1.81] ([176.12.107.132])
 by smtp.gmail.com with ESMTPSA id 124sm1716162wmc.29.2020.01.10.02.15.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2020 02:15:46 -0800 (PST)
Subject: Re: Difference between 'current_machine' vs
 MACHINE(qdev_get_machine())
To: Like Xu <like.xu@linux.intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <a88f7647-c061-bf3f-a272-72700078ef26@redhat.com>
 <e6a7197d-1647-4667-dae8-10c8dba1737f@redhat.com>
 <a6d997f6-40b3-4a68-a911-7b9d7ebf9514@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d8cd9ea-5534-14a0-1d48-11b1bc916c14@redhat.com>
Date: Fri, 10 Jan 2020 11:15:42 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <a6d997f6-40b3-4a68-a911-7b9d7ebf9514@linux.intel.com>
Content-Language: en-US
X-MC-Unique: tMGkBLXTNiqEJpQ8FiR0-Q-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Igor Mammedov <imammedo@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/9/20 4:24 PM, Like Xu wrote:
> On 2020/1/9 20:01, Paolo Bonzini wrote:
>> On 09/01/20 12:23, Philippe Mathieu-Daud=C3=A9 wrote:
>>>
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0 current_machine =3D
>>> MACHINE(object_new_with_class(OBJECT_CLASS(machine_class)));
>>> =C2=A0=C2=A0=C2=A0=C2=A0 object_property_add_child(object_get_root(), "=
machine",
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 OBJECT(current_machine), &error_abort)=
;
>>>
>>> The bigger user of 'current_machine' is the accel/KVM code.
>>>
>>> Recently in a0628599f..cc7d44c2e0 "Replace global smp variables with
>>> machine smp properties" we started to use MACHINE(qdev_get_machine()).
>>>
>>> qdev_get_machine() resolves the machine in the QOM composition tree.
>>> I am confused by this comment:
>>>
>>> =C2=A0=C2=A0 /* qdev_get_machine() can return something that's not TYPE=
_MACHINE
>>> =C2=A0=C2=A0=C2=A0 * if this is one of the user-only emulators; in that=
 case there's
>>> =C2=A0=C2=A0=C2=A0 * no need to check the ignore_memory_transaction_fai=
lures board=20
>>> flag.
>>> =C2=A0=C2=A0=C2=A0 */
>>>
>>> Following a0628599f..cc7d44c2e0, a5e0b33119 use 'current_machine' again=
.
>>>
>>> What are the differences between both form, when should we use one or
>>> another (or can we use a single one?). Can this break user-only mode?
>>
>> I would always use MACHINE(qdev_get_machine()), espeecially outside
>> vl.c.=C2=A0 Ideally, current_machine would be static within vl.c or even
>> unused outside the object_property_add_child() that you quote above.
>>
>> Most of the times, I noticed from a quick grep, we actually want to
>> access the accelerator, not the machine, so we could add a
>> qemu_get_accelerator() wrapper that does
>> MACHINE(qdev_get_machine())->accelerator.
>>
>> Paolo
>>
>=20
> I prefer to use MACHINE(qdev_get_machine()) wherever possible.
>=20
> However, the qdev_get_machine() would return non TYPE_MACHINE object if:
> - call qdev_get_machine() before we do=20
> "object_property_add_child(object_get_root(), "machine",=20
> OBJECT(current_machine), &error_abort);" in vl.c;

OK I'll add an assert() in case.

> - or in the context with '#ifdef CONFIG_USER_ONLY';

Good to know, I can simplify further :)


