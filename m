Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46BE3CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D0DF2086D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 14:45:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Wq8uCEKf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D0DF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMvPQ-0005kr-0a
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 10:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49370)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iMvNK-0004JJ-UG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iMvNH-0001Ah-EY
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:43:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56345
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iMvNG-00017g-O6
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 10:43:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571755380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MCnrqxOA1FxHJgY2uXRgRnx/jj+MK6t1vDDyq3ARQ4A=;
 b=Wq8uCEKf2ZEtj6BOBmHpT3UlS1+OABXJdgPgx2HFPmhO2aGH36vf5qpyKSXUy0oT17rDND
 GlC/hYyK8pp0r8kvSuLWnm8V2vuzIdywc7KXsRM0GfcFuJnKVEvL9HYbfaefC1Avcaum4m
 knB47j/n35R+8MFD/41VM4/Dg7iwcFg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-7n_DdZMqMOCGdJyNPUb9sQ-1; Tue, 22 Oct 2019 10:42:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9B81800D4E;
 Tue, 22 Oct 2019 14:42:57 +0000 (UTC)
Received: from localhost (unknown [10.43.2.182])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF54B60C83;
 Tue, 22 Oct 2019 14:42:34 +0000 (UTC)
Date: Tue, 22 Oct 2019 16:42:32 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Laszlo Ersek <lersek@redhat.com>
Subject: Re: [RFC 3/3] acpi: cpuhp: add CPHP_GET_CPU_ID_CMD command
Message-ID: <20191022164232.0d699b45@redhat.com>
In-Reply-To: <0f2a4b26-b900-08af-aa3e-f9779ae6b55f@redhat.com>
References: <20191009132252.17860-1-imammedo@redhat.com>
 <20191009132252.17860-4-imammedo@redhat.com>
 <802d0d69-d478-76f5-2bd6-5ad2f1ac4474@redhat.com>
 <20191018181841.6459533a@redhat.com>
 <78f49b7d-6fd9-c977-8fe9-2de78025003d@redhat.com>
 <0f2a4b26-b900-08af-aa3e-f9779ae6b55f@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: 7n_DdZMqMOCGdJyNPUb9sQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 22 Oct 2019 14:39:24 +0200
Laszlo Ersek <lersek@redhat.com> wrote:

> On 10/21/19 15:06, Laszlo Ersek wrote:
> > On 10/18/19 18:18, Igor Mammedov wrote: =20
> >> On Thu, 10 Oct 2019 16:56:18 +0200
> >> Laszlo Ersek <lersek@redhat.com> wrote: =20
>=20
> [...]
>=20
> >>> Can I use the following sequence to detect whether the interface is
> >>> available?
> >>>
> >>> 1. Store 0x0 to command register.
> >>> 2. Store 0x0 to selector register.
> >>> 3. Read 'command data' register.
> >>> 4. If value read is 0, the interface is available. =20
> >>
> >> By default legacy register block layout is in place
> >> (i.e. present cpus bitmap) where 1st byte is guarantied to be ">0" as =
it has
> >> at least the boot CPU bit set and writes to legacy bitmap are ignored.
> >>
> >> Currently AML code code does switching to modern interface, see
> >> docs/specs/acpi_cpu_hotplug.txt:
> >> "
> >>   The first DWORD in bitmap is used in write mode to switch from legac=
y         =20
> >>   to new CPU hotplug interface, write 0 into it to do switch.
> >> "
> >> related code "if (opts.has_legacy_cphp) {" and cpu_status_write()
> >>
> >> Considering firmware runs the first, it should enable modern interface
> >> on its own
> >>   1. Store 0x0 to selector register (actually it's store into bitmap t=
o attempt switch).=20
> >> and to check if interface is present
> >>   2. Store 0x0 to selector register (to ensure valid selector value (o=
therwise command is ignored))
> >>   3. Store 0x0 to command register (to be able to read back selector f=
rom command data)
> >>   4. Store 0x0 to selector register (because #3 can select the a cpu w=
ith events if any)
> >>       be aware libvirt may start QEMU in paused mode (hotplug context)=
 and hotplugs extra CPUs
> >>       with device_add and then let guest run. So firmware may see pres=
ent CPUs with events
> >>       at boot time.
> >>   5. Read 'command data' register.
> >>   6. If value read is 0, the interface is available. =20
> >=20
> > Perfect!
> >=20
> > Basically this is prepending two "write 0 to selector register" steps t=
o
> > what I suspected. I certainly couldn't figure out the "switch to modern=
"
> > step, and whether initializing the selector to something valid was
> > needed at boot. Now I know. :) Thanks!
> >  =20
> >> =20
> >>> (Because I assume that unmapped IO ports read as all-bits-one. Is tha=
t
> >>> right?) =20
> >> that's right but ports are mapped to legacy CPU bitmap, you can't coun=
t on all-bits-one case here. =20
>=20
> It seems I rejoiced too soon.
>=20
> When we read the command data register in the last step, that is at
> offset 0x8 in the register block. Considering the legacy "CPU present
> bitmap", if no CPU is present in that range, then the firmware could
> read a zero value. I got confused because I thought we were reading at
> offset 0, which would always have bit0 set (for CPU#0).
>=20
> Can we detect the modern interface like this:
>=20
> 1. store 0x0 to selector register (attempt to switch)
> 2. read one byte at offset 0 in the register block
> 3. if bit#0 is set, the modern interface is unavailable;
>    otherwise (=3D bit#0 clear), the modern interface is available
>=20
> Here's why:
>=20
> - if even the legacy interface is missing, then step 2 is an unassigned
>   read, hence the value read is all-bits-one; bit#0 is set
>=20
> - if only the legacy interface is available, then bit#0 stands for
>   CPU#0, it will be set
>=20
> - if the switch-over in step 1 is successful, then offset 0 is reserved,
>   hence it returns all-bits-zero.
>=20
> With this, if we ever assigned offset 0 for reading, then we'd have to
> define it with bit#0 constantly clear.

There is no need to reserve bit#0 if in step #5 we use s/'command data'/'Co=
mmand data 2'/

Alternatively we can reserve bit#0 and sequentially read upper half from 'C=
ommand data'
(one a new flag to show that there is more data to read).
(Upper half currently is not necessary, it's there for future ARM's MPIDR).

One more thing, this behavior is based on artifacts of x86 machine and AllO=
nes fallback.
Obviously it won't work with arm/virt, do we care about AVMF at this point?

> Thanks,
> Laszlo


