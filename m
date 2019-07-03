Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MSGID_MULTIPLE_AT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A0FDC5B578
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42401218A4
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 08:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42401218A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiaVb-0002sG-4Q
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 04:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45799)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1hiaV7-0002Qb-J9
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1hiaV5-0005ch-Du
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:20:25 -0400
Received: from mail.ispras.ru ([83.149.199.45]:36456)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Natalia.Fursova@ispras.ru>) id 1hiaUS-0005AS-PU
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 04:20:18 -0400
Received: from NATALIAFURSOVA (unknown [85.142.117.226])
 by mail.ispras.ru (Postfix) with ESMTPSA id 91665540089;
 Wed,  3 Jul 2019 11:19:42 +0300 (MSK)
From: "Natalia Fursova" <Natalia.Fursova@ispras.ru>
To: "'Markus Armbruster'" <armbru@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>	<1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>	<5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>	<ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>	<003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>	<67806828-f666-0c9c-00fc-b520f15013d9@suse.de>	<e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>	<98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>	<39250506-f38f-c440-5728-7b970d32ab41@redhat.com>	<79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>	<c49abf01-c209-b206-edee-507c31269011@redhat.com>	<87o934sdot.fsf@dusky.pond.sub.org>	<8d391b41-bf6d-b83b-7b22-25fefa18c518@redhat.com>	<87ftogp7f5.fsf@dusky.pond.sub.org>	<4ed45e59-6d7d-a9ea-9af3-7ec336c7ec3d@redhat.com>	<014c01d530cb$73ff1950$5bfd4bf0$@Fursova@ispras.ru>
 <8736jo1mqw.fsf@dusky.pond.sub.org>
In-Reply-To: <8736jo1mqw.fsf@dusky.pond.sub.org>
Date: Wed, 3 Jul 2019 11:19:47 +0300
Message-ID: <015001d53178$13d72100$3b856300$@Fursova@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Office Outlook 12.0
Thread-Index: AdUw6oNDASMKZcFqSwS5FGhyq0TsFAAjYUiw
Content-Language: ru
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 83.149.199.45
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
Cc: 'Paolo Bonzini' <pbonzini@redhat.com>,
 =?utf-8?Q?'Andreas_F=C3=A4rber'?= <afaerber@suse.de>,
 =?utf-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thank you!

=D0=A1 =D1=83=D0=B2=D0=B0=D0=B6=D0=B5=D0=BD=D0=B8=D0=B5=D0=BC,=20
=D0=9D=D0=B0=D1=82=D0=B0=D0=BB=D1=8C=D1=8F


-----Original Message-----
From: Markus Armbruster [mailto:armbru@redhat.com]=20
Sent: Tuesday, July 02, 2019 6:26 PM
To: Natalia Fursova
Cc: 'Paolo Bonzini'; 'Andreas F=C3=A4rber'; '=D0=9F=D0=B0=D1=88=D0=B0'; =
qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] qgraph

"Natalia Fursova" <Natalia.Fursova@ispras.ru> writes:

> Hi there again!
> Thank you for your answers, I have new question.
> =20
> I want to identify PCI devices (e.g. network cards) and observed one
> strange thing. I use qmp command "qom-list-type" and build tree from
> it output. Some items don't have parent and don't give information
> about themselves. E. g. "e1000-base". It has three children and it
> belongs to PCI devices, but I can't know it, cuz command
> "qom-list-properties" returns empty message.
>
> There is no information about "e1000-base" in "qom-list-type"
> output. It is referenced only as a parent for network cards.  Is it
> ok? Maybe is there other way for get information about all PCI
> devices?

qom-list-types only returns concrete types by default.  Try passing
"abstract": true.


