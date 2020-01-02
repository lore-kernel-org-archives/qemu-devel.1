Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BBE2C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FFDF20866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 17:33:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TSeG5PAh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FFDF20866
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in4Lw-00067k-Fh
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 12:33:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36513)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1in4LE-0005hn-KW
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:33:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1in4LA-0000yS-TZ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:32:58 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:38378
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1in4LA-0000xJ-7s
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 12:32:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577986375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LUx2Hn5xLdb3GE2FPI0mGhYGvB/tPPLufyoHlv4AeZs=;
 b=TSeG5PAh+eHAViX2BNSSHyM1M/htgGhXsDZ/BMTCSmqI9diADD0sIHVTN8GD5WtZQmzCna
 dL+GTrzsXf/uCQo+PysFmPgXUoAzV7LGQWme57WJOxY40gIg/zNQBphmdqb/2Eu8TdKUYb
 o5RS5H/2n7DkOmPSelMRfP9QTidAkCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-bUWaT3QJPtq6StQ8SXz5fg-1; Thu, 02 Jan 2020 12:32:54 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDA3D801E7A;
 Thu,  2 Jan 2020 17:32:52 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BCA3760C18;
 Thu,  2 Jan 2020 17:32:49 +0000 (UTC)
Date: Thu, 2 Jan 2020 18:32:47 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 43/86] hppa: drop RAM size fixup
Message-ID: <20200102183247.0d05ebb1@redhat.com>
In-Reply-To: <c20c891f-aa17-27f2-66c2-45025b921ca8@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
 <1577797450-88458-44-git-send-email-imammedo@redhat.com>
 <bc7bac60-0d20-d0e3-b9ac-2c9ff62c2c15@redhat.com>
 <8cb7bd0f-7841-7e60-8de6-708515b81b00@gmx.de>
 <7cc361d0-300f-a8a1-3650-9358e815c070@redhat.com>
 <20200102151223.73e1448b@redhat.com>
 <a3017f38-b32b-de32-9896-b287253d0fa2@redhat.com>
 <20200102160827.790b8ed2@redhat.com>
 <f073e703-5caf-e63c-ef1b-04fa7ab51716@redhat.com>
 <20200102175021.35b07b0d@redhat.com>
 <c20c891f-aa17-27f2-66c2-45025b921ca8@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: bUWaT3QJPtq6StQ8SXz5fg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
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
Cc: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jan 2020 18:14:32 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 1/2/20 5:50 PM, Igor Mammedov wrote:
> > On Thu, 2 Jan 2020 16:49:00 +0100
> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >  =20
> >> On 1/2/20 4:08 PM, Igor Mammedov wrote: =20
> >>> On Thu, 2 Jan 2020 15:17:14 +0100
> >>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >>>     =20
> >>>> On 1/2/20 3:12 PM, Igor Mammedov wrote: =20
> >>>>> On Thu, 2 Jan 2020 13:06:33 +0100
> >>>>> Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:
> >>>>>        =20
> >>>>>> On 1/2/20 12:31 PM, Helge Deller wrote: =20
> >>>>>>> On 31.12.19 16:44, Philippe Mathieu-Daud=C3=A9 wrote: =20
> >>>>>>>> On 12/31/19 2:03 PM, Igor Mammedov wrote: =20
> >>>>>>>>> If user provided non-sense RAM size, board will complain and
> >>>>>>>>> continue running with max RAM size supported.
> >>>>>>>>> Also RAM is going to be allocated by generic code, so it won't =
be
> >>>>>>>>> possible for board to fix things up for user.
> >>>>>>>>>
> >>>>>>>>> Make it error message and exit to force user fix CLI,
> >>>>>>>>> instead of accepting non-sense CLI values.
> >>>>>>>>>
> >>>>>>>>> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >>>>>>>>> ---
> >>>>>>>>>     =C2=A0 hw/hppa/machine.c | 3 ++-
> >>>>>>>>>     =C2=A0 1 file changed, 2 insertions(+), 1 deletion(-)
> >>>>>>>>>
> >>>>>>>>> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >>>>>>>>> index 5d0de26..25f5afc 100644
> >>>>>>>>> --- a/hw/hppa/machine.c
> >>>>>>>>> +++ b/hw/hppa/machine.c
> >>>>>>>>> @@ -92,7 +92,8 @@ static void machine_hppa_init(MachineState *m=
achine)
> >>>>>>>>>     =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Limit main memory.=
 */
> >>>>>>>>>     =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ram_size > FIRMWARE_STAR=
T) {
> >>>>>>>>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 machine->ram_size =
=3D ram_size =3D FIRMWARE_START;
> >>>>>>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_report("RAM s=
ize more than %d is not supported", FIRMWARE_START);
> >>>>>>>>> +        exit(EXIT_FAILURE); =20
> >>>>>>>>
> >>>>>>>> $ qemu-system-hppa -m 3841m
> >>>>>>>> qemu-system-hppa: invalid accelerator kvm
> >>>>>>>> qemu-system-hppa: falling back to tcg
> >>>>>>>> qemu-system-hppa: RAM size more than -268435456 is not supported
> >>>>>>>>
> >>>>>>>> Instead of using qemu_strtosz_MiB on FIRMWARE_START or unsigned =
format, we can simply use "RAM size more than 3840m is not supported". Is t=
hat OK with you? =20
> >>>>>>>
> >>>>>>> I don't really like that change.
> >>>>>>>
> >>>>>>> We currently only emulate a 32-bit system, and for those 4GB is t=
he maximum.
> >>>>>>> So, if I start my machine with "qemu-system-hppa -m 4G", the curr=
ent code
> >>>>>>> then automatically uses the maximum possible of 3841MB (which is =
limited by
> >>>>>>> firmware start address).
> >>>>>>> I don't expect users to know the excact 3841MB number.
> >>>>>>> Even on a phyiscal machine you can only add DIMMs of sizes 2GB, 3=
GB or 4GB,
> >>>>>>> but not "3841MB". =20
> >>>>>>
> >>>>>> Thanks for the explanation. This deserves a comment in the source =
file
> >>>>>> IMHO (and displaying a warning to the user that the behavior is ch=
anged).
> >>>>>>
> >>>>>> I understand the CPU can't access this DRAM area because the ROM i=
s
> >>>>>> mapped there. What about other devices, can they do DMA access to =
it?
> >>>>>>
> >>>>>> Igor: If this complicates your series too much, I think we can dir=
ectly
> >>>>>> allocate up-to 4GiB and not worry about the 256MiB lost. =20
> >>>>>
> >>>>> Do you mean
> >>>>> s/"RAM size more than %d is not supported"/"RAM size more than 4Gb =
is not supported"/ =20
> >>>>
> >>>> Works for me! You can keep my R-b with this change, thanks. =20
> >>>
> >>> Well, it's not that simple.
> >>> Do we map whole 4G in address space, if yes then we have to "unbreak"
> >>> firmware mapping and use overlap mapping or do we map only portion of=
 it?
> >>> Both would make code more confusing and all for the sake of user conv=
enience
> >>> so they won't have to change their CLI? =20
> >>
> >> I was thinking about this patch: =20
> > it probably should be a bit more complicated.
> >  =20
> >> =20
> >> -- >8 -- =20
> >> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> >> index 5d0de26140..fa0b6a9536 100644
> >> --- a/hw/hppa/machine.c
> >> +++ b/hw/hppa/machine.c
> >> @@ -91,15 +91,16 @@ static void machine_hppa_init(MachineState *machin=
e)
> >>        }
> >>
> >>        /* Limit main memory. */
> >> -    if (ram_size > FIRMWARE_START) {
> >> -        machine->ram_size =3D ram_size =3D FIRMWARE_START;
> >> +    if (ram_size > 4 * GiB) {
> >> +        error_report("Can not model more than 4GB of RAM");
> >> +        exit(EXIT_FAILURE);
> >>        }
> >>
> >>        /* Main memory region. */
> >>        ram_region =3D g_new(MemoryRegion, 1);
> >>        memory_region_allocate_system_memory(ram_region, OBJECT(machine=
),
> >>                                             "ram", ram_size);
> >> -    memory_region_add_subregion(addr_space, 0, ram_region);
> >> +    memory_region_add_subregion_overlap(addr_space, 0, ram_region, -1=
);
> >>
> >>        /* Init Dino (PCI host bus chip).  */
> >>        pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq); =20
> >=20
> > Ok, I give up on trying to convince you to avoid relaxing error check
> > but I'd make it an extra patch on top of "[PATCH 43/86] hppa: drop RAM =
size fixup"
> > as it's a separate change. =20
>=20
> I am simply not understanding what you are suggesting...
> Can you share a diff snippet of what you would prefer?
>=20

My preference is to error out with:
  "RAM size more than 3840m is not supported"
and let user fix their CLI


