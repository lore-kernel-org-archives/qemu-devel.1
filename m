Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41944C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A887206D5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 12:33:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F2eFQ/kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A887206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOKl2-0007tF-52
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 08:33:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jOKhe-0004j4-6D
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:30:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jOKhc-0008JT-Jw
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:30:10 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:20053
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jOKhc-0008JE-G4
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 08:30:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586867408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRy3uiNfqn1wYKIgSvGw0/w0aZlVZpMzMPmvZODeLMU=;
 b=F2eFQ/kCvt3nb0cakpnGhdFHniteHbSOu2vSk3fPI7nK7+TU13ZO4mqYRB2dQPA2DOEdX0
 vhV2EFxeRPLsDJolQio6tDmhU31KDHf541ncYZ7ORolkwMotCAcdvKV+9cJNg4VMcVXakW
 2WwjGTbsZCc3bKqJpe46Ogpzuw76JnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-468-_d8jbpChOTGAbtckpBZTMw-1; Tue, 14 Apr 2020 08:30:06 -0400
X-MC-Unique: _d8jbpChOTGAbtckpBZTMw-1
Received: by mail-wm1-f71.google.com with SMTP id c129so3689771wme.8
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 05:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=89f3HfIxGtyCwGbicp7SH5wF0RbSJiR4Pg4t8CjkheE=;
 b=ZI4+JPnAtz5k2ZcdPBRAdBq3oSd+eRWqxeAfB2T5YJSrs74JOiE/wN9E2eAqRGJS1n
 AvqtoDTht1U1HeOk5Q6jUgvYbNIVxJii855qYay5Bi3S8o6TLiSVCHX1UbrN9J2EXCT6
 0IwiXHD/GpB9bQeRweat8JtpwjrpNyx2cdgxRpdxMk770aPpimZ1M2VT9jpvwqSI542w
 Ois4tOtQlBHxAOaVtkGaa002vdj5Ju+VGwRp/ub/Ck4qn0RIR4wlLNyLF53MR70kfSUh
 z0PC8XvkR4MzdjmTvvM96/CQ0rHhysFRCmxcM9gTDhyS0HmbosittXY0vAAiiH2Wx8K9
 3VxA==
X-Gm-Message-State: AGi0PuZawM2+hflJOiEBYLEqY/6ds5N6rzU8AmWIkaI2gix2UGiakgF1
 Htu/gkhvQfn5c5MUyHk57NFUETI5EAXePF2ukwswPqr3XUaGj9OqoSZPEkfE32Fbt9itF2Vf4wJ
 vTwQdGwIgDL76Y2A=
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr7663261wrm.143.1586867405082; 
 Tue, 14 Apr 2020 05:30:05 -0700 (PDT)
X-Google-Smtp-Source: APiQypKSkvSeGEjNJliPtICYSPNogxdsHPBFjxKxE8EijFmahDArIrB3cHQWfl0UKLFkZM4opDF42Q==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr7663206wrm.143.1586867404770; 
 Tue, 14 Apr 2020 05:30:04 -0700 (PDT)
Received: from [192.168.1.39] (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id p5sm20566572wrg.49.2020.04.14.05.30.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Apr 2020 05:30:04 -0700 (PDT)
Subject: Re: [PATCH-for-5.1 v3 02/24] scripts/coccinelle: Script to simplify
 DeviceClass error propagation
To: Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
References: <20200412223619.11284-1-f4bug@amsat.org>
 <20200412223619.11284-3-f4bug@amsat.org> <875ze2tfvc.fsf@dusky.pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <23ad6d04-1f42-29b8-caa6-6506cf1b7422@redhat.com>
Date: Tue, 14 Apr 2020 14:30:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <875ze2tfvc.fsf@dusky.pond.sub.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Cody <codyprime@gmail.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
 Peter Chubb <peter.chubb@nicta.com.au>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-riscv@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Wen Congyang <wencongyang2@huawei.com>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/14/20 2:24 PM, Markus Armbruster wrote:
> Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:
>=20
>> When a device uses an Error* with data not modified before realize(),
>> this call can be moved to init(). Add a Coccinelle patch to find such
>> uses.
>>
>> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>> ---
>>   ...implify-init-realize-error_propagate.cocci | 69 +++++++++++++++++++
>>   MAINTAINERS                                   |  1 +
>>   2 files changed, 70 insertions(+)
>>   create mode 100644 scripts/coccinelle/simplify-init-realize-error_prop=
agate.cocci
>>
>> diff --git a/scripts/coccinelle/simplify-init-realize-error_propagate.co=
cci b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>> new file mode 100644
>> index 0000000000..2e3ec4d98a
>> --- /dev/null
>> +++ b/scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>> @@ -0,0 +1,69 @@
>> +// Find error-propagation calls that don't need to be in DeviceClass::r=
ealize()
>> +// because they don't use information user can change before calling re=
alize(),
>> +// so they can be moved to DeviceClass:initfn() where error propagation=
 is not
>> +// needed.
>> +//
>> +// Copyright: (C) 2020 Philippe Mathieu-Daud=C3=A9
>> +// This work is licensed under the terms of the GNU GPLv2 or later.
>> +//
>> +// spatch \
>> +//  --macro-file scripts/cocci-macro-file.h \
>> +//  --sp-file \
>> +//    scripts/coccinelle/simplify-init-realize-error_propagate.cocci \
>> +//  --timeout 60
>> +//
>> +// Inspired by https://www.mail-archive.com/qemu-devel@nongnu.org/msg69=
2500.html
>> +
>> +
>> +@ match_class_init @
>> +TypeInfo info;
>> +identifier class_initfn;
>> +@@
>> +    info.class_init =3D class_initfn;
>> +
>> +
>> +@ match_instance_init @
>> +TypeInfo info;
>> +identifier instance_initfn;
>> +@@
>> +    info.instance_init =3D instance_initfn;
>> +
>> +
>> +@ match_realize @
>> +identifier match_class_init.class_initfn;
>> +DeviceClass *dc;
>> +identifier realizefn;
>> +@@
>> +void class_initfn(...)
>> +{
>> +    ...
>> +    dc->realize =3D realizefn;
>> +    ...
>> +}
>=20
> I'm afraid this misses realize() methods of DeviceClass subclasses.
> Consider PCI device "i6300esb" (picked just because it's simple).
>=20
> pci_device_class_init() sets DeviceClass method realize() to
> pci_qdev_realize().  pci_qdev_realize() does the work common to all PCI
> devices, and calls PCIDeviceClass method realize() for the work specific
> to the PCI device at hand.
>=20
> i6300esb_class_init() sets PCIDeviceClass method realize() to
> i6300esb_realize().
>=20
> Your first rule should match i6300esb_info alright, and thus identify
> i6300esb_class_init() as a class_init() method.
>=20
> But your third rule can't match i6300esb_class_init()'s
>=20
>      k->realize =3D i6300esb_realize;
>=20
> because @k is a PCIDeviceClass, not a DeviceClass.
>=20
> I think it also misses cases that have a realize(), but no
> instance_init().
>=20
> Finding only some instances of an anti-pattern can still be useful.  But
> you should explain the script's limitations then, both in the script and
> the commit message.

OK.

>=20
>> +
>> +
>> +@ propagate_in_realize @
>> +identifier match_realize.realizefn;
>> +identifier err;
>> +identifier errp;
>> +identifier func_with_errp =3D~ "(?!object_property_set_link)";
>=20
> What are you trying to accomplish with this lookahead assertion?

"match all func_with_errp() except object_property_set_link()"?

>=20
>> +symbol error_abort, error_fatal;
>> +position pos;
>> +@@
>> +void realizefn@pos(..., Error **errp)
>> +{
>> +    ...
>> +    Error *err =3D NULL;
>=20
> Why is this line required for a match?

Hmmm maybe I was expecting a local_err... else a left-over from previous=20
intents :)

>=20
>> +    <+...
>> +    func_with_errp(..., \(&error_abort\|&error_fatal\));
>> +    ...+>
>> +}
>> +
>> +
>> +@ script:python @
>> +initfn << match_instance_init.instance_initfn;
>> +realizefn << match_realize.realizefn;
>> +p << propagate_in_realize.pos;
>> +@@
>> +print('>>> possible moves from {}() to {}() in {}:{}'
>> +      .format(initfn, realizefn, p[0].file, p[0].line))
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 642c8e0b6b..6203543ec0 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2058,6 +2058,7 @@ F: scripts/coccinelle/err-bad-newline.cocci
>>   F: scripts/coccinelle/error-use-after-free.cocci
>>   F: scripts/coccinelle/error_propagate_null.cocci
>>   F: scripts/coccinelle/remove_local_err.cocci
>> +F: scripts/coccinelle/simplify-init-realize-error_propagate.cocci
>>   F: scripts/coccinelle/use-error_fatal.cocci
>>  =20
>>   GDB stub
>=20


