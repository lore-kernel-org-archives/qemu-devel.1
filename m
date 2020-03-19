Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4F36C43333
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:03:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92CF820753
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:03:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0Ca34ct"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92CF820753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEs1Q-0001Kp-PR
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:03:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jEs0e-0000n4-6B
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:02:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jEs0Z-0004oU-5d
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:02:40 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:40044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jEs0Y-0004oB-Uj
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584612154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5q11skmYIcnBYVdiHpdLtG5yjOzJR+w1Z0fZwpgwlI0=;
 b=a0Ca34ctl4VXGYrSWPYVOOhBOnivWUyE4VXT4Y6LZEzd8ifGDpfuo1PrR6IBx8zazYscaF
 BZXU1G5PAXVT5kx/L18sbJso2HbGYpTWHgpt9FhfaWNCqDxoIYk4rXFg+OghUWBjNzm1AP
 OrnDVISpyGBzG9oe0e8HwLpsDzxKTaU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-hP6lggJ1OzeuCaNoGY6nZA-1; Thu, 19 Mar 2020 06:02:30 -0400
X-MC-Unique: hP6lggJ1OzeuCaNoGY6nZA-1
Received: by mail-wm1-f72.google.com with SMTP id n188so498182wmf.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2020 03:02:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=cMMWTazjnMHIB+B2IdY+dBDzgBwCwE53d+kdif1fHXA=;
 b=sZeaVkQI560JpEkNOk8A0MXyZixHwaKvQZtb7ZXQH03wLxFNtO0z2RmA9hFPlsVG3x
 Ud5jla/GdQ2o7UvJhwtKvQSttpfFDjhq4r0mqUTrexVKzPbL1Aug6gUMjare76bxVzax
 FU8YGu1LMo8cQCkoAoY+WPESaRTeyzsPbZW4o5UNseXqYqRradrkgKKLCUc/1jLtTuFD
 ozgXNLu2AqhYOBkATfpkPdkSUz7t0kJDjedGOvGDxU7dVN2P+0D3KsaCCUEjf9Sr4Mgb
 rd4WATDU346SFM1qWxQsvgIldEL+92K9RlDeeOF5FnRYlJDelfyWmxAC0uk+HZNQ4iQR
 E4cQ==
X-Gm-Message-State: ANhLgQ2LP16bDVLdrmswaD1ZOEDqDu79BwOgIyB0lsJWya/k7gsmSSVA
 DgUBdlhfA8Ykx32YvkpCzH1OKATvPiDQOnM3mOqwHCfmYBaFo6VdoaF67AVqUhrGyzvaD6n7adH
 8eFGKQQS1OanjSzc=
X-Received: by 2002:adf:f30b:: with SMTP id i11mr3153003wro.224.1584612149353; 
 Thu, 19 Mar 2020 03:02:29 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvKHn+enou47LWOVtxAl2vIJoEKpFa9Tda1ASis5QLNZd/zbR2LoXC4BVwNuVqc/lbEwXJVEg==
X-Received: by 2002:adf:f30b:: with SMTP id i11mr3152974wro.224.1584612149129; 
 Thu, 19 Mar 2020 03:02:29 -0700 (PDT)
Received: from [192.168.178.58] ([151.21.15.43])
 by smtp.gmail.com with ESMTPSA id v7sm2560832wml.18.2020.03.19.03.02.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2020 03:02:28 -0700 (PDT)
Subject: Re: [PATCH-for-5.0 1/2] hw/acpi/piix4: Add 'system-hotplug-support'
 property
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200318221531.22910-1-philmd@redhat.com>
 <20200318221531.22910-2-philmd@redhat.com>
 <3ac0d8f1-15d8-51d3-b40e-8975ec1353ad@redhat.com>
 <1b61a51a-0419-1bd3-2728-e5c11606f99e@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <c0ea77ce-bd5f-aa3b-2dd0-e4793800208a@redhat.com>
Date: Thu, 19 Mar 2020 11:02:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1b61a51a-0419-1bd3-2728-e5c11606f99e@redhat.com>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 19/03/20 10:42, Philippe Mathieu-Daud=C3=A9 wrote:
> On 3/19/20 10:36 AM, Paolo Bonzini wrote:
>> On 18/03/20 23:15, Philippe Mathieu-Daud=C3=A9 wrote:
>>> The I/O ranges registered by the piix4_acpi_system_hot_add_init()
>>> function are not documented in the PIIX4 datasheet.
>>> This appears to be a PC-only feature added in commit 5e3cb5347e
>>> ("initialize hot add system / acpi gpe") which was then moved
>>> to the PIIX4 device model in commit 9d5e77a22f ("make
>>> qemu_system_device_hot_add piix independent")
>>> Add a property (default enabled, to not modify the current
>>> behavior) to allow machines wanting to model a simple PIIX4
>>> to disable this feature.
>>
>> Yes, all hotplug stuff (PCI/memory/CPU) are custom additions by QEMU.
>>
>>> +=C2=A0=C2=A0=C2=A0 DEFINE_PROP_BOOL("system-hotplug-support", PIIX4PMS=
tate,
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 use_acpi_system_hotplug=
, true),
>>
>> Why not cpu-hotplug-support?
>=20
> Because I have no idea what this code is about, and it seems more than
> cpu (pci, memory):

Right, I should have been more verbose.  You mentioned I/O port 0xaf00
which is CPU hotplug.  Perhaps unless you can also crash with PCI
hotplug (0xae00-0xae0f) it's worth removing only CPU hotplug from MIPS
machines, and keep PCI hotplug.

Paolo

> static void piix4_acpi_system_hot_add_init(MemoryRegion *parent,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PCIBus *bus, PIIX4PMState *s)
> {
> =C2=A0=C2=A0=C2=A0 memory_region_init_io(&s->io_gpe, OBJECT(s), &piix4_gp=
e_ops, s,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 "acpi-gpe0", GPE_LEN);
> =C2=A0=C2=A0=C2=A0 memory_region_add_subregion(parent, GPE_BASE, &s->io_g=
pe);
>=20
> =C2=A0=C2=A0=C2=A0 acpi_pcihp_init(OBJECT(s), &s->acpi_pci_hotplug, bus, =
parent,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 s->use_acpi_pci_hotplug);
>=20
> =C2=A0=C2=A0=C2=A0 s->cpu_hotplug_legacy =3D true;
> =C2=A0=C2=A0=C2=A0 object_property_add_bool(OBJECT(s), "cpu-hotplug-legac=
y",
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 piix4_get_cpu_hotplug_legacy,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 piix4_set_cpu_hotplug_legacy,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 NULL);
> =C2=A0=C2=A0=C2=A0 legacy_acpi_cpu_hotplug_init(parent, OBJECT(s), &s->gp=
e_cpu,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 PIIX4_CPU_HOTPLUG_IO_BASE);
>=20
> =C2=A0=C2=A0=C2=A0 if (s->acpi_memory_hotplug.is_enabled) {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 acpi_memory_hotplug_init(paren=
t, OBJECT(s),
> &s->acpi_memory_hotplug,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_MEMORY_HOTPLUG_BASE);
> =C2=A0=C2=A0=C2=A0 }
> }
>=20


