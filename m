Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 652EAC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F0F8B206C3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 16:15:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F0F8B206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48198 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haMx7-0006NK-Q9
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 12:15:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33166)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <afaerber@suse.de>) id 1haMuB-00053d-2N
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <afaerber@suse.de>) id 1haMuA-0007QD-4q
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:12:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:35640 helo=mx1.suse.de)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <afaerber@suse.de>) id 1haMu9-0007O2-VM
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 12:12:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 14141AF0F;
 Mon, 10 Jun 2019 16:12:15 +0000 (UTC)
To: Paolo Bonzini <pbonzini@redhat.com>
References: <5cf62de9.1c69fb81.66fc.8f4fSMTPIN_ADDED_BROKEN@mx.google.com>
 <1e9e4edd-f4ad-d8d6-95a2-e0aeab89510d@redhat.com>
 <5cf7b6e6.1c69fb81.1cdca.e260SMTPIN_ADDED_BROKEN@mx.google.com>
 <ec5033a4-5c68-91b7-ca9e-a1f38c990221@redhat.com>
 <003b01d51f72$5e6f4160$1b4dc420$@Fursova@ispras.ru>
 <67806828-f666-0c9c-00fc-b520f15013d9@suse.de>
 <e4fe4dc0-f3c4-a051-d39d-afd7bfdc680d@redhat.com>
 <98826c5f-4a74-5364-2aef-28a10db12c20@suse.de>
 <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
Date: Mon, 10 Jun 2019 18:12:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39250506-f38f-c440-5728-7b970d32ab41@redhat.com>
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
Cc: Natalia Fursova <Natalia.Fursova@ispras.ru>, qemu-devel@nongnu.org,
 =?UTF-8?B?J9Cf0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 10.06.19 um 15:52 schrieb Paolo Bonzini:
> On 10/06/19 15:28, Andreas F=C3=A4rber wrote:
>> So if we want a new QMP operation, the most sense would probably make
>> where-can-I-attach-type(foo) returning a list of QOM paths, showing on=
ly
>> the first free slot per bus. That would allow a more efficient lookup
>> implementation inside QEMU than needing to check each slot[n] property
>> via qom-get after discovering it with qom-list.
>=20
> Note that what Natalia is seeking is an introspection mechanism to be
> used _before_ creating a virtual machine though.

QMP implied creating a virtual machine though.

This then goes back to the long-discussed topic of not doing recursive
realized=3Dtrue when starting halted with -s but deferring that to the
cont operation. I doubt that's been implemented in the meantime?

Cheers,
Andreas

--=20
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, Germany
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG N=C3=BCrnberg)

