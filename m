Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D2A1CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 670A92173B
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 15:21:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Uej6Vmmg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 670A92173B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNISJ-0007LL-ET
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 11:21:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34780)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iNI7Q-0007ZY-2C
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:00:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iNI7K-0000Ms-7o
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:00:11 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56633
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iNI7K-0000MG-3n
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 11:00:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571842804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5V/DVkx7bbSaPqGw0TBkessld/4DuUudfyNyqi2W5VY=;
 b=Uej6VmmgPQTkf8XFZhnh6eINW1foXvpLHcpUzP7GRQTk0Owe1WeKzSU/p7xTEoswXEHIzc
 lTZ181c1B8t4R49jNHhZ0zHVQkXQYSVOukFNj/DRnRiKhYpbsmg80L3o7uSvNJbZX3EWk5
 6bBr9TGKrg+1gIevPB7pGbY4TVci0tU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-374-MG6-iWOOPxOomrajVCLLww-1; Wed, 23 Oct 2019 11:00:01 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 636301800D6B;
 Wed, 23 Oct 2019 15:00:00 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E72445D6D0;
 Wed, 23 Oct 2019 14:59:51 +0000 (UTC)
Date: Wed, 23 Oct 2019 16:59:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Message-ID: <20191023165950.3e36ba15@redhat.com>
In-Reply-To: <2dcf8863-6584-dfa7-9b15-724d159da1da@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-4-imammedo@redhat.com>
 <802d0d69-d478-76f5-2bd6-5ad2f1ac4474@redhat.com>
 <20191018181841.6459533a@redhat.com>
 <78f49b7d-6fd9-c977-8fe9-2de78025003d@redhat.com>
 <0f2a4b26-b900-08af-aa3e-f9779ae6b55f@redhat.com>
 <20191022164232.0d699b45@redhat.com>
 <2dcf8863-6584-dfa7-9b15-724d159da1da@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: MG6-iWOOPxOomrajVCLLww-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?= =?UTF-8?B?w6k=?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 17:49:06 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 10/22/19 16:42, Igor Mammedov wrote:
> > On Tue, 22 Oct 2019 14:39:24 +0200
> > Laszlo Ersek <lersek@redhat.com> wrote:
> >  =20
> >> On 10/21/19 15:06, Laszlo Ersek wrote: =20
> >>> On 10/18/19 18:18, Igor Mammedov wrote:   =20
>=20
> >>>> Considering firmware runs the first, it should enable modern interfa=
ce
> >>>> on its own
> >>>>   1. Store 0x0 to selector register (actually it's store into bitmap=
 to attempt switch).=20
> >>>> and to check if interface is present
> >>>>   2. Store 0x0 to selector register (to ensure valid selector value =
(otherwise command is ignored))
> >>>>   3. Store 0x0 to command register (to be able to read back selector=
 from command data)
> >>>>   4. Store 0x0 to selector register (because #3 can select the a cpu=
 with events if any)
> >>>>       be aware libvirt may start QEMU in paused mode (hotplug contex=
t) and hotplugs extra CPUs
> >>>>       with device_add and then let guest run. So firmware may see pr=
esent CPUs with events
> >>>>       at boot time.
> >>>>   5. Read 'command data' register.
> >>>>   6. If value read is 0, the interface is available.   =20
>=20
> >> When we read the command data register in the last step, that is at
> >> offset 0x8 in the register block. Considering the legacy "CPU present
> >> bitmap", if no CPU is present in that range, then the firmware could
> >> read a zero value. I got confused because I thought we were reading at
> >> offset 0, which would always have bit0 set (for CPU#0).
> >>
> >> Can we detect the modern interface like this:
> >>
> >> 1. store 0x0 to selector register (attempt to switch)
> >> 2. read one byte at offset 0 in the register block
> >> 3. if bit#0 is set, the modern interface is unavailable;
> >>    otherwise (=3D bit#0 clear), the modern interface is available
> >>
> >> Here's why:
> >>
> >> - if even the legacy interface is missing, then step 2 is an unassigne=
d
> >>   read, hence the value read is all-bits-one; bit#0 is set
> >>
> >> - if only the legacy interface is available, then bit#0 stands for
> >>   CPU#0, it will be set
> >>
> >> - if the switch-over in step 1 is successful, then offset 0 is reserve=
d,
> >>   hence it returns all-bits-zero.
> >>
> >> With this, if we ever assigned offset 0 for reading, then we'd have to
> >> define it with bit#0 constantly clear. =20
> >=20
> > There is no need to reserve bit#0 if in step #5 we use s/'command data'=
/'Command data 2'/ =20
>=20
> Good idea. We can drop step 4 too:
>=20
>     [0x0] Command data 2: (DWORD access, little endian)
>           If the "CPU selector" value last stored by the guest refers to
>           an impossible CPU, then 0.
>=20
> This is skipped by step 2.
>=20
>           Otherwise, if the "Command field" value last stored by the
>           guest differs from 3, then 0.
>=20
> This is triggered by step 3.
>=20
> So step 4 does not look necessary. (As long as the guest is OK with the
> selector ending up with a changed value.)

sounds good,
I'll respin patches taking this into account.

>           Otherwise, the most significant 32 bits of the selected CPU's
>           architecture specific ID.
>=20
> Not relevant for this use case.
>=20
> > Alternatively we can reserve bit#0 and sequentially read upper half fro=
m 'Command data'
> > (one a new flag to show that there is more data to read). =20
>=20
> I like the "Command data 2" register more. The "temporal domain" is
> always a complication in register definitions.
>=20
> > (Upper half currently is not necessary, it's there for future ARM's MPI=
DR).
> >=20
> > One more thing, this behavior is based on artifacts of x86 machine and =
AllOnes fallback.
> > Obviously it won't work with arm/virt, do we care about AVMF at this po=
int? =20
>=20
> No, in the firmware, all this is strictly x86 code. The ArmVirtQemu
> guest firmware has no support for multiprocessing at this time, to my
> understanding.
>=20
> (Nonetheless, if the register block got placed at an MMIO base address
> on arm/virt, I think "unassigned_mem_ops" would apply there just the same=
.)
>=20
> Thanks!
> Laszlo
>=20
>=20


