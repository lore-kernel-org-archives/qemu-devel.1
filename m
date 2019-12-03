Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9C13C432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:21:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8382520659
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 13:21:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sh/WhPdU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8382520659
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53444 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic87A-0001cW-Mo
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 08:21:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43446)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1ic82R-0006ux-Pk
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:16:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1ic82O-0005tL-IW
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:16:23 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23338
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1ic82M-0005pZ-2j
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 08:16:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575378975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:openpgp:openpgp;
 bh=c3s487rSTOQAbpaqXo07JxNNjhJI2+e1LlRkUm/tcKQ=;
 b=Sh/WhPdUVVcIh+qjFe6ckw1ncZhEvRooAIhFP9eGMHzi+BDIaOnY/m95yUP/8eHW16zsOu
 A+bCK/gyOukxbeeUopX9uOsWr4kIEB+XniBdz2Gh3P/+jcAkKhG/4PRsWq1E52Hi7hARPQ
 X5EQwyz4P6obucvNbP1b+IYTMrtgKzI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-PpKVdHnZPJWjNuMpL-zMtw-1; Tue, 03 Dec 2019 08:16:12 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B6F98005A8;
 Tue,  3 Dec 2019 13:16:11 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-116-176.ams2.redhat.com [10.36.116.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5B3B0619E2;
 Tue,  3 Dec 2019 13:16:01 +0000 (UTC)
Subject: Re: [PATCH] hw/ppc/prep: Remove the deprecated "prep" machine and the
 OpenHackware BIOS
To: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>
References: <20191203072922.14981-1-thuth@redhat.com>
 <2b5d3c2d-6982-03f6-26cc-7400440b990f@redhat.com>
 <8ca69db3-7dfa-0c4d-bc50-61a80eb574c1@redhat.com>
 <6966e660-688a-977e-c882-9cb44ef97574@redhat.com>
 <f9c24324-b04a-f88c-3da7-3dfd2041b048@redhat.com>
 <7528162c-ce2f-985e-7f58-9267389edd33@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <fcee5492-8a0b-c54c-0a6a-16a69532892f@redhat.com>
Date: Tue, 3 Dec 2019 14:16:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <7528162c-ce2f-985e-7f58-9267389edd33@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: PpKVdHnZPJWjNuMpL-zMtw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8
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
Cc: Laurent Vivier <lvivier@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03/12/2019 14.04, Paolo Bonzini wrote:
> On 03/12/19 10:15, Thomas Huth wrote:
>>>>> Maybe we can rename this as read_boot_order_mm, and the previous
>>>>> read_boot_order_pc as read_boot_order_io.
>>>>
>>>> I don't think it makes much sense. This was completely specific to the
>>>> "prep" machine, even the "40p" machine seems to prefer fw_cfg nowadays=
.
>>>> So let's simply remove this old stuff.
>>>>
>>>>> diff --git a/tests/endianness-test.c b/tests/endianness-test.c
>>>>> index 58527952a5..2798802c63 100644
>>>>> --- a/tests/endianness-test.c
>>>>> +++ b/tests/endianness-test.c
>>>>> @@ -35,7 +35,7 @@ static const TestCase test_cases[] =3D {
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64", "malta", 0x10000000,=
 .bswap =3D true },
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "mips64el", "fulong2e", 0x1fd0=
0000 },
>>>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { "ppc", "g3beige", 0xfe000000, =
.bswap =3D true, .superio =3D
>>>>> "i82378" },
>>>>> -=C2=A0=C2=A0=C2=A0 { "ppc", "prep", 0x80000000, .bswap =3D true },
>>>>> +=C2=A0=C2=A0=C2=A0 { "ppc", "40p", 0x80000000, .bswap =3D true },
>>>
>>> ... here you access the Super I/O behind the PCI bridge via MMIO?
>>
>> The difference is that this is an *arbitrary* address in I/O space
>> there.
>=20
> No, it's the base address of the ISA space, to which the tests add the
> address of the pc-testdev device.  It's not any different from the
> 0x80000000 in boot-order-test.

Hmm, interesting. Why is it not necessary to set up the BARs of the
PCI-to-ISA bridge in this case?

> That said, I think it's a sensible objection that boot order doesn't
> come from m48t59 on 40p (does it not?).
Right. I'm also not an expert here, but I think the OpenBIOS on 40p
rather uses fw_cfg instead.

 Thomas


