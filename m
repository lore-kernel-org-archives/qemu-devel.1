Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8BBC32771
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 485BE2072A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 11:40:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FOfFimJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 485BE2072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58800 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipWAX-0003gf-Ez
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 06:40:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1ipW9s-0003DQ-I8
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1ipW9k-0007xO-39
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:39:19 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47989
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ipW9j-0007vY-JF
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 06:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578569955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DBv6IgDxigcHQkuRs9JmvBvhs7mhO9vNB+yikXxTxm4=;
 b=FOfFimJwIH5pF/UVzneX55uJIQ7EhRdmeLSDFtJDHSiHdOD+dmgsw/zwRAHH/KL9hCQFwY
 DaonayVD1rvOSJ8bdFIzYBSKkwtdTb0YEz76fBcNn+uOgQ1wlFcuvJP592J2zJppsDpbic
 9fCPmZa6Jmiubh9SoHY20WiD4lE5imw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-902Sx07-MG-qgQ23ifArrg-1; Thu, 09 Jan 2020 06:39:14 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F847477;
 Thu,  9 Jan 2020 11:39:12 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E696F272A3;
 Thu,  9 Jan 2020 11:39:07 +0000 (UTC)
Date: Thu, 9 Jan 2020 12:39:06 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 2/3] hw/hppa/machine: Do not limit the RAM to 3840MB
Message-ID: <20200109123906.2a055feb@redhat.com>
In-Reply-To: <00d20bb2-cd8c-37fd-0709-9df1ca0d1545@redhat.com>
References: <20200108181425.21485-1-f4bug@amsat.org>
 <20200108181425.21485-3-f4bug@amsat.org>
 <20200109111514.3ab4396a@redhat.com>
 <00d20bb2-cd8c-37fd-0709-9df1ca0d1545@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: 902Sx07-MG-qgQ23ifArrg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>,
 Sven Schnelle <svens@stackframe.org>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 9 Jan 2020 12:09:26 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/9/20 11:15 AM, Igor Mammedov wrote:
> > On Wed,  8 Jan 2020 19:14:24 +0100
> > Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:
> >  =20
> >> The hardware expects DIMM slots of 1 or 2 GB, allowing up to
> >> 4 GB of memory. Accept the same amount of memory the hardware
> >> can deal with.
> >>
> >> The CPU doesn't have access to the RAM mapped in the
> >> [0xf0000000 - 0xf1000000] range because this is the PDC area
> >> (Processor Dependent Code) where the firmware is loaded.
> >> To keep this region with higher priority than the RAM, lower
> >> the RAM priority. The PDC will overlap it.
> >>
> >> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> =20
> > Looks good to me (since board doesn't fix up ram_size and uses
> > whatever user specified, proper support for 4Gb could be done on top la=
ter).
> >  =20
> >> ---
> >>   hw/hppa/machine.c | 11 +++++------
> >>   1 file changed, 5 insertions(+), 6 deletions(-)
> >>
> >> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >> index 6775d879f8..d10c967d06 100644
> >> --- a/hw/hppa/machine.c
> >> +++ b/hw/hppa/machine.c
> >> @@ -90,16 +90,15 @@ static void machine_hppa_init(MachineState *machin=
e)
> >>           g_free(name);
> >>       }
> >>  =20
> >> -    /* Limit main memory. */
> >> -    if (ram_size > FIRMWARE_START) {
> >> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
> >> -    }
> >> -
> >>       /* Main memory region. */
> >> +    if (machine->ram_size > 4 * GiB) { =20
> > Could it break a build on 32-bit mingw host?
> > (machine->ram_size is 32-bit on that host and condition would be
> > always false, tripping -Werror) =20
>=20
> By following Helge tip to restrict to 3GB, v2 of this series doesn't=20
> have this problem :)
>=20
> > that's why I've worked around it using local uint64_t in the last versi=
on
> >   "[PATCH v3 43/86] hppa: allow max ram size upto 4Gb"
> > coincidentally that would get rid of global ram_size usage
> > and leave only machine->ram_size on this board. =20
>=20
> Since I was not sure how you wanted to clean this, I haven't modified=20
> it. We can add it on top but I'd rather do a whole codebase cleanup.
with 3Gb there is no actual need to do that,
Like you said having a separate tree wide clean up would be a better approa=
ch.

>=20
> Note: you also need to modify hppa_machine_reset() by using ms->ram_size=
=20
> instead.
>=20
> >> +        error_report("RAM size of 4GB or more is not supported");
> >> +        exit(EXIT_FAILURE);
> >> +    }
> >>       ram_region =3D g_new(MemoryRegion, 1);
> >>       memory_region_allocate_system_memory(ram_region, OBJECT(machine)=
,
> >>                                            "ram", ram_size);
> >> -    memory_region_add_subregion(addr_space, 0, ram_region);
> >> +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1=
);
> >>  =20
> >>       /* Init Dino (PCI host bus chip).  */
> >>       pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq); =20
> >=20
> >  =20
>=20


