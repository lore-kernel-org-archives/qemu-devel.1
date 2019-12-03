Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBDC5C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5B0520661
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gcLF2Adl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5B0520661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3ye-000415-Q8
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49583)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ic3uY-00030i-4o
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ic3uS-0007pF-Ez
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47323
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ic3uS-0007jf-62
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:51:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575363110;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bGbF1OMeTjYTIddv4pfJs5BJo3brw71EqIuTMdkiLV8=;
 b=gcLF2Adl/y7kDGlLaFs/vubryCc5vwIobZpt0Ixe6N4iKebNegdPaQEUgoSCOarcDEHxKX
 gL6eTb93MEFiQKHayyJLoU1sP8M+WxRAS4Sevu3W/yjUykNeXB22jMNAQ/nIrnDEU4bLis
 vSN7+0Apy3bYWg5adpwXVuaxXeBakX0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-sIr8WkfjPbCc2lnXoMKJnw-1; Tue, 03 Dec 2019 03:51:46 -0500
Received: by mail-wm1-f72.google.com with SMTP id o135so707704wme.2
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 00:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=b5uv3s+EDaZPv50WmwPuWGxqb0D8QZ53kUMQ0zvzyuM=;
 b=B1qYAgE0JTFDWJCGrDs7LsmCx4rbKkDAj5VO64k4YTyFFz/7j3CXarrON/g/L5ZqqM
 lO7nTm+A7g7S9IVHnD4b4J1XPOxZG58N8Xb4/UCTRc9OtkNR+X4THvDGsvZxvGPCfjZr
 Neu/8x844eHKKbz00A+7L0BFb56GAGfiABbAnOmuPbrqG7nmBIAUCY60BOy6NjAPscgG
 R3DmMdQ8pH8bBpC1/5RuoaprkvSpIQpn4LE4kvahMG1qCK+s+FyKCd3E8TZF2mGvfQkd
 uDNNzo8BClu50GglJeBkk8KrNA9QpO303SobH+9d7a5mu88utcANCptZrWeBU7EQa9tt
 XKXg==
X-Gm-Message-State: APjAAAXUm0lluAVzG9kUvF/IP8TGbaM72Zw1Dl0gF+6LcbU2yD4TjUxl
 UA2N1qbHdNcusHJrMqRvfXLIoXp5PCbU8nQ+PzRf8Mjz6zjWBGul2I5pJme9019gQZbkNKua97B
 lgglZW1Y3zHAYXQU=
X-Received: by 2002:adf:b605:: with SMTP id f5mr3657115wre.383.1575363105131; 
 Tue, 03 Dec 2019 00:51:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqyl96c0V0JLDNpuz4al4iVX3ihG2ipiT3hlf1BD6XT6+bx8sLCZXV2CWUBWJU/pIB6QjEmBZw==
X-Received: by 2002:adf:b605:: with SMTP id f5mr3657096wre.383.1575363104880; 
 Tue, 03 Dec 2019 00:51:44 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id i16sm2163066wmb.36.2019.12.03.00.51.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Dec 2019 00:51:44 -0800 (PST)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
 <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <6966e660-688a-977e-c882-9cb44ef97574@redhat.com>
Date: Tue, 3 Dec 2019 09:51:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
Content-Language: en-US
X-MC-Unique: sIr8WkfjPbCc2lnXoMKJnw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/3/19 9:25 AM, Thomas Huth wrote:
> On 03/12/2019 08.45, Philippe Mathieu-Daud=C3=A9 wrote:
>> On 12/3/19 8:29 AM, Thomas Huth wrote:
>>> It's been deprecated since QEMU v3.1. The 40p machine should be
>>> used nowadays instead.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>  =C2=A0 .gitmodules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>>  =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>  =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>  =C2=A0 docs/interop/firmware.json |=C2=A0=C2=A0 3 +-
>>>  =C2=A0 hw/ppc/ppc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 --
>>>  =C2=A0 hw/ppc/prep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 384 +------------------------------------
>>>  =C2=A0 include/hw/ppc/ppc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 1 -
>>>  =C2=A0 pc-bios/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>>>  =C2=A0 pc-bios/ppc_rom.bin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=
 Bin 1048576 -> 0 bytes
>>>  =C2=A0 qemu-deprecated.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=
=A0=C2=A0 6 -
>>>  =C2=A0 qemu-doc.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
>>>  =C2=A0 roms/openhackware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 1 -
>>>  =C2=A0 tests/boot-order-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ---
>>>  =C2=A0 tests/cdrom-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
>>>  =C2=A0 tests/endianness-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>>>  =C2=A0 15 files changed, 10 insertions(+), 456 deletions(-)
>>>  =C2=A0 delete mode 100644 pc-bios/ppc_rom.bin
>>>  =C2=A0 delete mode 160000 roms/openhackware
>> [...]
>>> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
>>> index a725bce729..4a6218a516 100644
>>> --- a/tests/boot-order-test.c
>>> +++ b/tests/boot-order-test.c
>>> @@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
>>>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_boot_orders(NULL, read_boot_order_=
pc, test_cases_pc);
>>>  =C2=A0 }
>>>  =C2=A0 -static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uin=
t16_t
>>> reg)
>>> -{
>>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr, reg & 0xff);
>>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr + 1, reg >> 8);
>>> -=C2=A0=C2=A0=C2=A0 return qtest_readb(qts, addr + 3);
>>> -}
>>> -
>>> -static uint64_t read_boot_order_prep(QTestState *qts)
>>> -{
>>> -=C2=A0=C2=A0=C2=A0 return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
>>
>> I'd rather keep this generic mmio-mapped ISA test.
>> Maybe run it with the 40p machine?
>=20
> I don't think that this is possible in an easy way here. On the prep
> machine, the ISA bus is on a hard-coded MMIO address. On the 40p
> machine, the ISA bus is behind a PCI-to-ISA bridge, thus the PCI part
> needs to be set up first.

The why ...

>> Maybe we can rename this as read_boot_order_mm, and the previous
>> read_boot_order_pc as read_boot_order_io.
>=20
> I don't think it makes much sense. This was completely specific to the
> "prep" machine, even the "40p" machine seems to prefer fw_cfg nowadays.
> So let's simply remove this old stuff.
 >
 >> diff --git a/tests/endianness-test.c b/tests/endianness-test.c
 >> index 58527952a5..2798802c63 100644
 >> --- a/tests/endianness-test.c
 >> +++ b/tests/endianness-test.c
 >> @@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
 >>       { "mips64", "malta", 0x10000000, .bswap =3D true },
 >>       { "mips64el", "fulong2e", 0x1fd00000 },
 >>       { "ppc", "g3beige", 0xfe000000, .bswap =3D true, .superio =3D
 >> "i82378" },
 >> -    { "ppc", "prep", 0x80000000, .bswap =3D true },
 >> +    { "ppc", "40p", 0x80000000, .bswap =3D true },

... here you access the Super I/O behind the PCI bridge via MMIO?

 >>       { "ppc", "bamboo", 0xe8000000, .bswap =3D true, .superio =3D
 >> "i82378" },
 >>       { "ppc64", "mac99", 0xf2000000, .bswap =3D true, .superio =3D
 >> "i82378" },
 >>       { "ppc64", "pseries", (1ULL << 45), .bswap =3D true, .superio =3D
 >> "i82378" },
 >>


