Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A06C282DD
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:59:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04C95207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 11:59:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04C95207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44924 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haIxJ-000159-7i
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 07:59:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <afaerber@suse.de>) id 1haIwC-00007V-0z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afaerber@suse.de>) id 1haIwA-0006mU-C7
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:58:07 -0400
Received: from mx2.suse.de ([195.135.220.15]:53948 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <afaerber@suse.de>) id 1haIw9-0006QZ-UJ
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 07:58:06 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 5FFCAAE82;
 Mon, 10 Jun 2019 11:57:41 +0000 (UTC)
To: Natalia Fursova <Natalia.Fursova@ispras.ru>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
Date: Mon, 10 Jun 2019 13:57:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
Content-Type: text/plain; charset=UTF-8
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
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Natalia,

Am 10.06.19 um 11:53 schrieb Natalia Fursova:
> Hi there!
> Read please our correspondence and answer on last question (Will it ok =
for
> QOM conception?)
> Also forwarding to QOM and QMP maintainers. Can you make comments on th=
is
> discussion?

Your question doesn't make sense grammatically or conceptually. As Paolo
explained below, QOM is a pure object model, with object types/classes
and properties. Buses are just object instances attached as properties
and don't necessarily even need their own type of bus object (e.g, CPU).
An answer you don't like doesn't change by asking it to other people...
The information is all there, you just need to interpret it correctly.

There is no technical discussion (no concrete proposal of yours) to
comment on here, and kindly refer to last week's change of maintainers.

You would be better off just explaining what you really want to achieve.

Regards,
Andreas

> -----Original Message-----
> From: Natalia Fursova [mailto:Natalia.Fursova@ispras.ru]=20
> Sent: Wednesday, June 05, 2019 5:23 PM
> To: 'Paolo Bonzini'; 'qemu-devel@nongnu.org'; '=D0=9F=D0=B0=D1=88=D0=B0=
'
> Subject: RE: [Qemu-devel] qgraph
>=20
> I see.
> We need this opportunity and want to implement it. Will it ok for QOM
> conception?
>=20
>=20
>=20
> Best regards,
> Natalia
>=20
> -----Original Message-----
> From: Paolo Bonzini [mailto:pbonzini@redhat.com]=20
> Sent: Wednesday, June 05, 2019 4:07 PM
> To: Natalia Fursova; qemu-devel@nongnu.org; '=D0=9F=D0=B0=D1=88=D0=B0'
> Subject: Re: [Qemu-devel] qgraph
>=20
> On 05/06/19 14:34, Natalia Fursova wrote:
>>
>> Thank you for your answer. I would like to clarify something about the=
 qmp
>> commands.
>> For example, consider SCSI controller "lsi53c895a". For getting
> information
>> we use two commands: "device-list-properties" and "qom-list-properties=
".
>> Output consists of many properties, but there is no information about
>> provided buses by this device. Is there a qmp command which provides t=
his
>> information?
>=20
> Unfortunately there is no information in QMP about buses that are
> provided.   qom-list-types gives the buses that are requested.
>=20
> Paolo
>=20


--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)

