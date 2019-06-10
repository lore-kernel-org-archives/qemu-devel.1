Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7DC5C28CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD4EE207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 13:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD4EE207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46430 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haKN1-0004cv-Tn
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 09:29:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45527)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <afaerber@suse.de>) id 1haKM4-0004A3-KG
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:28:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afaerber@suse.de>) id 1haKM3-0004g1-Kc
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:28:56 -0400
Received: from mx2.suse.de ([195.135.220.15]:40268 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <afaerber@suse.de>) id 1haKM3-0004fb-CH
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 09:28:55 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 66DB9AFF5;
 Mon, 10 Jun 2019 13:28:53 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
Date: Mon, 10 Jun 2019 15:28:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x (no
 timestamps) [generic]
X-Received-From: 195.135.220.15
Subject: Re: [Qemu-devel] qgraph
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
Cc: =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>,
 qemu-devel@nongnu.org, Natalia Fursova <Natalia.Fursova@ispras.ru>,
 armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.19 um 14:03 schrieb Paolo Bonzini:
> On 10/06/19 13:57, Andreas F=C3=A4rber wrote:
>> Your question doesn't make sense grammatically or conceptually. As Pao=
lo
>> explained below, QOM is a pure object model, with object types/classes
>> and properties. Buses are just object instances attached as properties
>> and don't necessarily even need their own type of bus object (e.g, CPU=
).
>> An answer you don't like doesn't change by asking it to other people..=
.
>> The information is all there, you just need to interpret it correctly.
>>
>> There is no technical discussion (no concrete proposal of yours) to
>> comment on here, and kindly refer to last week's change of maintainers=
.
>>
>> You would be better off just explaining what you really want to achiev=
e.
>=20
> Well, that was explained upthread---finding out what device can be
> plugged where.
>=20
> Let's see what is in QOM right now:
>=20
> $ qemu-kvm -qmp unix:foo.sock,server,nowait -device virtio-scsi-pci,id=3D=
vs
> $ ./qmp/qom-list -s ~/foo.sock /machine/peripheral/vs|less
>=20
> There is a "virtio-bus" here, and iside it there is a scsi-bus.
>=20
> $ ./qmp/qom-list -s ~/foo.sock /machine/peripheral/vs/virtio-bus/child[=
0]/
> vs.0/
>=20
> I guess you could add to virtio-scsi-pci a class property for the bus,
> and then make "vs.0" an alias to that class property.  This would allow
> you find buses by enumerating the class properties.

That kind of goes against the spirit of QOM though and ignores simpler
mechanisms of hot-plugging, as mentioned.

The theoretical generic way would be to discover that any random object
beneath /machine has a null property of a link<> type that inherits from
device and is compatible with the device type to be plugged.

In practice we decided against Anthony's idea of adding tons of empty
slot properties for e.g. PCI buses (the number space is too large). We
did add QOM support for wildcard "foo[*]" array properties though. A
null slot[42] property of a certain link<> type then means a device can
be plugged there, and the property's setter then needs to take care of
hot-plugging and un-plugging.
This was unfortunately obscured by the legacy qdev model where we
magically add new child[0] properties (pointing to
/machine/peripheral(-anon) sub-nodes) to its bus parent during device
instantiation IIRC.

So if we want a new QMP operation, the most sense would probably make
where-can-I-attach-type(foo) returning a list of QOM paths, showing only
the first free slot per bus. That would allow a more efficient lookup
implementation inside QEMU than needing to check each slot[n] property
via qom-get after discovering it with qom-list.

Regards,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)

