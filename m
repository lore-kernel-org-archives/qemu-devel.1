Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF7F9C74A30
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:09:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5896B20844
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 17:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5896B20844
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35522 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlG6P-0006pP-BS
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 13:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43791)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hlG56-00062J-IR
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:08:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hlG54-0005hh-Hu
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 13:08:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44606)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hlG4x-0005bU-7P; Wed, 10 Jul 2019 13:08:28 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 310885AFF8;
 Wed, 10 Jul 2019 17:08:26 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.78])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55315196FE;
 Wed, 10 Jul 2019 17:08:21 +0000 (UTC)
Message-ID: <a6857e0264da525868063c47d9bbe6e23acccd48.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Michal
 Privoznik <mprivozn@redhat.com>, qemu-block@nongnu.org
Date: Wed, 10 Jul 2019 20:08:20 +0300
In-Reply-To: <3b4ea43e-9223-7d72-d708-958ae18a7abd@redhat.com>
References: <927aae40b617ba7d4b6c7ffe74e6d7a2595f8e86.1562770546.git.mprivozn@redhat.com>
 <3b4ea43e-9223-7d72-d708-958ae18a7abd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Wed, 10 Jul 2019 17:08:26 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nvme: Set number of queues
 later in nvme_init()
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-10 at 17:34 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 7/10/19 4:57 PM, Michal Privoznik wrote:
> > When creating the admin queue in nvme_init() the variable that
> > holds the number of queues created is modified before actual
> > queue creation. This is a problem because if creating the queue
> > fails then the variable is left in inconsistent state. This was
> > actually observed when I tried to hotplug a nvme disk. The
> > control got to nvme_file_open() which called nvme_init() which
> > failed and thus nvme_close() was called which in turn called
> > nvme_free_queue_pair() with queue being NULL. This lead to an
> > instant crash:
> >=20
> >   #0  0x000055d9507ec211 in nvme_free_queue_pair (bs=3D0x55d952ddb880=
, q=3D0x0) at block/nvme.c:164
> >   #1  0x000055d9507ee180 in nvme_close (bs=3D0x55d952ddb880) at block=
/nvme.c:729
> >   #2  0x000055d9507ee3d5 in nvme_file_open (bs=3D0x55d952ddb880, opti=
ons=3D0x55d952bb1410, flags=3D147456, errp=3D0x7ffd8e19e200) at block/nvm=
e.c:781
> >   #3  0x000055d9507629f3 in bdrv_open_driver (bs=3D0x55d952ddb880, dr=
v=3D0x55d95109c1e0 <bdrv_nvme>, node_name=3D0x0, options=3D0x55d952bb1410=
, open_flags=3D147456, errp=3D0x7ffd8e19e310) at block.c:1291
> >   #4  0x000055d9507633d6 in bdrv_open_common (bs=3D0x55d952ddb880, fi=
le=3D0x0, options=3D0x55d952bb1410, errp=3D0x7ffd8e19e310) at block.c:155=
1
> >   #5  0x000055d950766881 in bdrv_open_inherit (filename=3D0x0, refere=
nce=3D0x0, options=3D0x55d952bb1410, flags=3D32768, parent=3D0x55d9538ce4=
20, child_role=3D0x55d950eaade0 <child_file>, errp=3D0x7ffd8e19e510)
> > at block.c:3063
> >   #6  0x000055d950765ae4 in bdrv_open_child_bs (filename=3D0x0, optio=
ns=3D0x55d9541cdff0, bdref_key=3D0x55d950af33aa "file", parent=3D0x55d953=
8ce420, child_role=3D0x55d950eaade0 <child_file>,
> > allow_none=3Dtrue, errp=3D0x7ffd8e19e510) at block.c:2712
> >   #7  0x000055d950766633 in bdrv_open_inherit (filename=3D0x0, refere=
nce=3D0x0, options=3D0x55d9541cdff0, flags=3D0, parent=3D0x0, child_role=3D=
0x0, errp=3D0x7ffd8e19e908) at block.c:3011
> >   #8  0x000055d950766dba in bdrv_open (filename=3D0x0, reference=3D0x=
0, options=3D0x55d953d00390, flags=3D0, errp=3D0x7ffd8e19e908) at block.c=
:3156
> >   #9  0x000055d9507cb635 in blk_new_open (filename=3D0x0, reference=3D=
0x0, options=3D0x55d953d00390, flags=3D0, errp=3D0x7ffd8e19e908) at block=
/block-backend.c:389
> >   #10 0x000055d950465ec5 in blockdev_init (file=3D0x0, bs_opts=3D0x55=
d953d00390, errp=3D0x7ffd8e19e908) at blockdev.c:602
> >=20
>=20
> Fixes: bdd6a90a9e5
>=20
> > Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>=20
> > ---
> >  block/nvme.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/block/nvme.c b/block/nvme.c
> > index 73ed5fa75f..9896b7f7c6 100644
> > --- a/block/nvme.c
> > +++ b/block/nvme.c
> > @@ -613,12 +613,12 @@ static int nvme_init(BlockDriverState *bs, cons=
t char *device, int namespace,
> > =20
> >      /* Set up admin queue. */
> >      s->queues =3D g_new(NVMeQueuePair *, 1);
> > -    s->nr_queues =3D 1;
> >      s->queues[0] =3D nvme_create_queue_pair(bs, 0, NVME_QUEUE_SIZE, =
errp);
> >      if (!s->queues[0]) {
> >          ret =3D -EINVAL;
> >          goto out;
> >      }
> > +    s->nr_queues =3D 1;
> >      QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
> >      s->regs->aqa =3D cpu_to_le32((NVME_QUEUE_SIZE << 16) | NVME_QUEU=
E_SIZE);
> >      s->regs->asq =3D cpu_to_le64(s->queues[0]->sq.iova);
> >=20
>=20
>=20


Reviewed-by: Maxim Levitsky <mlevitsk@redhat.com>
Best regards,
	Maxim Levitsky


