Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CAFC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:38:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C429621951
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 16:38:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C429621951
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqKHi-0006US-4D
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 12:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38170)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <dgilbert@redhat.com>) id 1hqKHY-0005xy-0e
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1hqKHW-00047J-TC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 12:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59360)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>)
 id 1hqKHU-0003z1-D5; Wed, 24 Jul 2019 12:38:20 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 508A930B9BF7;
 Wed, 24 Jul 2019 16:38:19 +0000 (UTC)
Received: from work-vm (ovpn-117-166.ams2.redhat.com [10.36.117.166])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F267410190AA;
 Wed, 24 Jul 2019 16:38:15 +0000 (UTC)
Date: Wed, 24 Jul 2019 17:38:12 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Message-ID: <20190724163812.GJ2717@work-vm>
References: <20190724143553.21557-1-damien.hedde@greensocs.com>
 <543de194-b4e9-de7b-3dab-55fcc0976bc2@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <543de194-b4e9-de7b-3dab-55fcc0976bc2@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 24 Jul 2019 16:38:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for 4.1?] pl330: fix vmstate description
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Philippe Mathieu-Daud=E9 (philmd@redhat.com) wrote:
> On 7/24/19 4:35 PM, Damien Hedde wrote:
> > Fix the pl330 main and queue vmstate description.
> > There were missing POINTER flags causing crashes during
> > incoming migration because:
> > + PL330State chan field is a pointer to an array
> > + PL330Queue queue field is a pointer to an array
> >=20
> > Also bump corresponding vmsd version numbers.
> >=20
> > Signed-off-by: Damien Hedde <damien.hedde@greensocs.com>
> > ---
> >=20
> > I found this while working on reset with xilinx-zynq machine.
> >=20
> > I'm not sure what's the vmsd version policy in such cases (for
> > backward compatibility). I've simply bumped them since migration
> > was not working anyway (vmstate_load_state was erasing critical part
> > of PL330State and causing segfaults while loading following fields).
>=20
> I still not understand versioning and migration

Incrementing the version (and minimum) is the right thing
to do if you conclude the old one was hopelessly broken.
Migration to and from old qemu breaks, but who cares since it was toast
anyway.
As far as I can tell pl330 is only on our zynq and exynos models
so wont break our versioned 'virt' type.
So from a migration point of view:


Acked-by: Dr. David Alan Gilbert <dgilbert@redhat.com>


> so I can't say, but
> then you use the correct macro, since we have:
>=20
>     s->chan =3D g_new0(PL330Chan, s->num_chnls);
>=20
> So:
> Reviewed-by: Philippe Mathieu-Daude <philmd@redhat.com>
>=20
> >=20
> > Tested doing migration with the xilinx-zynq-a9 machine.
> >=20
> > ---
> >  hw/dma/pl330.c | 17 +++++++++--------
> >  1 file changed, 9 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/hw/dma/pl330.c b/hw/dma/pl330.c
> > index 58df965a46..a56a3e7771 100644
> > --- a/hw/dma/pl330.c
> > +++ b/hw/dma/pl330.c
> > @@ -218,11 +218,12 @@ typedef struct PL330Queue {
> > =20
> >  static const VMStateDescription vmstate_pl330_queue =3D {
> >      .name =3D "pl330_queue",
> > -    .version_id =3D 1,
> > -    .minimum_version_id =3D 1,
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 2,
> >      .fields =3D (VMStateField[]) {
> > -        VMSTATE_STRUCT_VARRAY_UINT32(queue, PL330Queue, queue_size, =
1,
> > -                                 vmstate_pl330_queue_entry, PL330Que=
ueEntry),
> > +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(queue, PL330Queue, queu=
e_size,
> > +                                             vmstate_pl330_queue_ent=
ry,
> > +                                             PL330QueueEntry),
> >          VMSTATE_END_OF_LIST()
> >      }
> >  };
> > @@ -278,12 +279,12 @@ struct PL330State {
> > =20
> >  static const VMStateDescription vmstate_pl330 =3D {
> >      .name =3D "pl330",
> > -    .version_id =3D 1,
> > -    .minimum_version_id =3D 1,
> > +    .version_id =3D 2,
> > +    .minimum_version_id =3D 2,
> >      .fields =3D (VMStateField[]) {
> >          VMSTATE_STRUCT(manager, PL330State, 0, vmstate_pl330_chan, P=
L330Chan),
> > -        VMSTATE_STRUCT_VARRAY_UINT32(chan, PL330State, num_chnls, 0,
> > -                                     vmstate_pl330_chan, PL330Chan),
> > +        VMSTATE_STRUCT_VARRAY_POINTER_UINT32(chan, PL330State, num_c=
hnls,
> > +                                             vmstate_pl330_chan, PL3=
30Chan),
> >          VMSTATE_VBUFFER_UINT32(lo_seqn, PL330State, 1, NULL, num_chn=
ls),
> >          VMSTATE_VBUFFER_UINT32(hi_seqn, PL330State, 1, NULL, num_chn=
ls),
> >          VMSTATE_STRUCT(fifo, PL330State, 0, vmstate_pl330_fifo, PL33=
0Fifo),
> >=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

