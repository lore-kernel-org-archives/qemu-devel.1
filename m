Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89583C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:17:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53031214AF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 13:17:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OokTOI3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53031214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izh2S-0001Uk-GY
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 08:17:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41662)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1izh0l-0000Sp-GY
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:16:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1izh0i-0005tb-Lx
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:16:02 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:35218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1izh0i-0005rL-C7
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 08:16:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580994958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4/btJhu5BTV1w8aRcJPEDLMys62WT/cdXUmdyyFnRrA=;
 b=OokTOI3O7hAVKnlMITOFMfElE6qE7dt2YrfqTmnhnS8lpqQ+hyIRFSXzTRPO84wahDbJ5B
 3Eth2mG8s/hnfhW4pXPIDQguMhdPCQxvGYXCM58YM5mv0fRIlsKFZRVmrAqxIaUNiMq245
 n26iHsAJGHWJkKQ9ma88LKLxoIRVgrU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-cHbk5HIjOpKo2kBdpDXQxA-1; Thu, 06 Feb 2020 08:15:56 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 96622101FC68;
 Thu,  6 Feb 2020 13:15:55 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1B1325C1B0;
 Thu,  6 Feb 2020 13:15:54 +0000 (UTC)
Date: Thu, 6 Feb 2020 14:15:53 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [PATCH v4 38/80] s390x/s390-virtio-ccw: use memdev for RAM
Message-ID: <20200206141553.706bc17b@redhat.com>
In-Reply-To: <20200205211123.43914b0c.pasic@linux.ibm.com>
References: <1580483390-131164-1-git-send-email-imammedo@redhat.com>
 <1580483390-131164-39-git-send-email-imammedo@redhat.com>
 <20200205211123.43914b0c.pasic@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: cHbk5HIjOpKo2kBdpDXQxA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 5 Feb 2020 21:11:23 +0100
Halil Pasic <pasic@linux.ibm.com> wrote:

> On Fri, 31 Jan 2020 16:09:08 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
>=20
> > memory_region_allocate_system_memory() API is going away, so
> > replace it with memdev allocated MemoryRegion. The later is
> > initialized by generic code, so board only needs to opt in
> > to memdev scheme by providing
> >   MachineClass::default_ram_id
> > and using MachineState::ram instead of manually initializing
> > RAM memory region.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Acked-by: Cornelia Huck <cohuck@redhat.com> =20
>=20
> Hi Igor!
>=20
> I gave=20
> -object memory-backend-file,id=3Dmem=20
> -machine type=3Ds390-ccw-virtio,memory-backend=3Dmem
> a spin on s390x. Seems to largely work a expected. So I guess it is:
>=20
> Tested-by: Halil Pasic <pasic@linux.ibm.com>
> Acked-by: Halil Pasic <pasic@linux.ibm.com>
Thanks,

Could you also take a look at patches 3-7/8o that makes this possible?
(it never hurts to have second pair of eyes on a code that affects
everyone).

>=20
> Thanks!
>=20
> Halil
>=20
> > ---
> > CC: pasic@linux.ibm.com
> > ---
> >  hw/s390x/s390-virtio-ccw.c | 7 +++----
> >  1 file changed, 3 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index e759eb5..a89cf4c 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -154,14 +154,12 @@ static void virtio_ccw_register_hcalls(void)
> >                                     virtio_ccw_hcall_early_printk);
> >  }
> > =20
> > -static void s390_memory_init(ram_addr_t mem_size)
> > +static void s390_memory_init(MemoryRegion *ram)
> >  {
> >      MemoryRegion *sysmem =3D get_system_memory();
> > -    MemoryRegion *ram =3D g_new(MemoryRegion, 1);
> >      Error *local_err =3D NULL;
> > =20
> >      /* allocate RAM for core */
> > -    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_si=
ze);
> >      memory_region_add_subregion(sysmem, 0, ram);
> > =20
> >      /*
> > @@ -245,7 +243,7 @@ static void ccw_init(MachineState *machine)
> > =20
> >      s390_sclp_init();
> >      /* init memory + setup max page size. Required for the CPU model *=
/
> > -    s390_memory_init(machine->ram_size);
> > +    s390_memory_init(machine->ram);
> > =20
> >      /* init CPUs (incl. CPU model) early so s390_has_feature() works *=
/
> >      s390_init_cpus(machine);
> > @@ -471,6 +469,7 @@ static void ccw_machine_class_init(ObjectClass *oc,=
 void *data)
> >      hc->plug =3D s390_machine_device_plug;
> >      hc->unplug_request =3D s390_machine_device_unplug_request;
> >      nc->nmi_monitor_handler =3D s390_nmi;
> > +    mc->default_ram_id =3D "s390.ram";
> >  }
> > =20
> >  static inline bool machine_get_aes_key_wrap(Object *obj, Error **errp)=
 =20
>=20


