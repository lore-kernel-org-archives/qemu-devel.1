Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1CE4C43218
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:58:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC24220657
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 08:58:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC24220657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hacbr-0001qj-24
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 04:58:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58638)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hacZr-0007lC-HX
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:56:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hacZq-0000dW-1o
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:56:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hacZp-0000bL-96
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 04:56:21 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 53D01307D857;
 Tue, 11 Jun 2019 08:56:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-148.ams2.redhat.com
 [10.36.116.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0655619C70;
 Tue, 11 Jun 2019 08:56:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C41611386A0; Tue, 11 Jun 2019 10:56:18 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
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
 <79b821a4-7cc0-2461-7ca4-d71c3e5ee4ef@suse.de>
 <c49abf01-c209-b206-edee-507c31269011@redhat.com>
Date: Tue, 11 Jun 2019 10:56:18 +0200
In-Reply-To: <c49abf01-c209-b206-edee-507c31269011@redhat.com> (Paolo
 Bonzini's message of "Mon, 10 Jun 2019 18:18:31 +0200")
Message-ID: <87o934sdot.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Tue, 11 Jun 2019 08:56:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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
Cc: Natalia Fursova <Natalia.Fursova@ispras.ru>,
 Andreas =?utf-8?Q?F=C3=A4rber?= <afaerber@suse.de>,
 =?utf-8?B?J9Cf?= =?utf-8?B?0LDRiNCwJw==?= <Pavel.Dovgaluk@ispras.ru>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 10/06/19 18:12, Andreas F=C3=A4rber wrote:
>> Am 10.06.19 um 15:52 schrieb Paolo Bonzini:
>>> On 10/06/19 15:28, Andreas F=C3=A4rber wrote:
>>>> Am 10.06.19 um 14:03 schrieb Paolo Bonzini:
>>>>> Well, that was explained upthread---finding out what device can be
>>>>> plugged where.

Fair feature request.  It has come up before.

[...]
>>>> So if we want a new QMP operation, the most sense would probably make
>>>> where-can-I-attach-type(foo) returning a list of QOM paths, showing on=
ly
>>>> the first free slot per bus. That would allow a more efficient lookup
>>>> implementation inside QEMU than needing to check each slot[n] property
>>>> via qom-get after discovering it with qom-list.
>>>
>>> Note that what Natalia is seeking is an introspection mechanism to be
>>> used _before_ creating a virtual machine though.

This requires introspecting the machine to find its onboard devices,
then introspecting onboard devices to find relevant sockets.  Perhaps
even introspect the devices that could be plugged into available sockets
to find more sockets.

I'm afraid this founders right on the first step: we can't introspect
machines that way, can we?

Instead, we need to run with -M $machine_of_interest, then walk the QOM
tree to find the onboard devices.

>> QMP implied creating a virtual machine though.
>
> Yes, but you can start QEMU with -M none and just invoke QOM
> introspection commands.

Yes, this is how introspection (both QMP and QOM) is commonly used.
Just keep in mind one difference: QMP is static, QOM is dynamic.

QMP being static means it's defined at compile time.  So is the value of
query-qmp-schema.  Same QEMU build, same value.  This permits caching.

QOM being dynamic means to introspect an object's properties, you have
to create it.  Worse, an object's properties may (in theory) change at
any time.  *Properties*, not just property *values*.  In practice, I'd
expect properties to change only at realize time.

QOM introspection can only see the properties in a newly created object.
Even these could (in theory) depend on state, i.e.  the next time you
introspect, you could get a different result.  Even in the same process.

I never quite understood why QOM needs *that* much flexibility.  But it
is how it is.  The common way for a management application to deal with
it is to assume what introspection shows us is for all practical
purposes close enough to what we'll actually get.

[...]

