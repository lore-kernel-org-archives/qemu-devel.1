Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BBCC432C3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D00CA2053B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 08:28:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fculr8IV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D00CA2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic3Xj-0000Jb-UV
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 03:28:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52523)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ic3VN-00089M-FG
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:25:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ic3VI-0002eZ-RB
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:25:53 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:29799)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ic3VE-0002Z9-3l
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 03:25:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575361542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=UTwEcgQYwRcsBbix2oYndsxT71QP5XeELLmI0hZlPqI=;
 b=fculr8IVcSV7yy7/+34ZBv7Kf4deNdCHkh5eMbZKsMkabO+suWd80GzpiUEOKfcfw+qsjS
 4v+JLX+L8QoYv5RldqIiHSHTsTJl9cFW7kCVg2rVsHAY8BBoMElRa0wJbrFiu9XdkZxEea
 /CoHepvuCZ7nNI6DbyW5vDnHt6i+XFE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-22-Y0jC1lhYMLiSPxjuFODESw-1; Tue, 03 Dec 2019 03:25:39 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1509B593A9;
 Tue,  3 Dec 2019 08:25:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F256967E58;
 Tue,  3 Dec 2019 08:25:33 +0000 (UTC)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
Date: Tue, 3 Dec 2019 09:25:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: Y0jC1lhYMLiSPxjuFODESw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 08.45, Philippe Mathieu-Daud=C3=A9 wrote:
> On 12/3/19 8:29 AM, Thomas Huth wrote:
>> It's been deprecated since QEMU v3.1. The 40p machine should be
>> used nowadays instead.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 .gitmodules=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>> =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 -
>> =C2=A0 Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 docs/interop/firmware.json |=C2=A0=C2=A0 3 +-
>> =C2=A0 hw/ppc/ppc.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 18 --
>> =C2=A0 hw/ppc/prep.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 384 +------------------------------------
>> =C2=A0 include/hw/ppc/ppc.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 1 -
>> =C2=A0 pc-bios/README=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 3 -
>> =C2=A0 pc-bios/ppc_rom.bin=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | B=
in 1048576 -> 0 bytes
>> =C2=A0 qemu-deprecated.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=
=C2=A0 6 -
>> =C2=A0 qemu-doc.texi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 15 +-
>> =C2=A0 roms/openhackware=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 |=C2=A0=C2=A0 1 -
>> =C2=A0 tests/boot-order-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0 25 ---
>> =C2=A0 tests/cdrom-test.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 tests/endianness-test.c=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 2 +-
>> =C2=A0 15 files changed, 10 insertions(+), 456 deletions(-)
>> =C2=A0 delete mode 100644 pc-bios/ppc_rom.bin
>> =C2=A0 delete mode 160000 roms/openhackware
> [...]
>> diff --git a/tests/boot-order-test.c b/tests/boot-order-test.c
>> index a725bce729..4a6218a516 100644
>> --- a/tests/boot-order-test.c
>> +++ b/tests/boot-order-test.c
>> @@ -108,30 +108,6 @@ static void test_pc_boot_order(void)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test_boot_orders(NULL, read_boot_order_pc=
, test_cases_pc);
>> =C2=A0 }
>> =C2=A0 -static uint8_t read_m48t59(QTestState *qts, uint64_t addr, uint1=
6_t
>> reg)
>> -{
>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr, reg & 0xff);
>> -=C2=A0=C2=A0=C2=A0 qtest_writeb(qts, addr + 1, reg >> 8);
>> -=C2=A0=C2=A0=C2=A0 return qtest_readb(qts, addr + 3);
>> -}
>> -
>> -static uint64_t read_boot_order_prep(QTestState *qts)
>> -{
>> -=C2=A0=C2=A0=C2=A0 return read_m48t59(qts, 0x80000000 + 0x74, 0x34);
>=20
> I'd rather keep this generic mmio-mapped ISA test.
> Maybe run it with the 40p machine?

I don't think that this is possible in an easy way here. On the prep
machine, the ISA bus is on a hard-coded MMIO address. On the 40p
machine, the ISA bus is behind a PCI-to-ISA bridge, thus the PCI part
needs to be set up first.

> Maybe we can rename this as read_boot_order_mm, and the previous
> read_boot_order_pc as read_boot_order_io.

I don't think it makes much sense. This was completely specific to the
"prep" machine, even the "40p" machine seems to prefer fw_cfg nowadays.
So let's simply remove this old stuff.

 Thomas


