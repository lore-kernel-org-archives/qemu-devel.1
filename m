Return-Path: <SRS0=kcoF=UO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE4DCC31E50
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 18:10:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4CDB21841
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Jun 2019 18:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4CDB21841
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35072 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcD81-0007Aa-0B
	for qemu-devel@archiver.kernel.org; Sat, 15 Jun 2019 14:10:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39691)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hcD6s-0006e9-Hs
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hcD6o-000231-Mb
 for qemu-devel@nongnu.org; Sat, 15 Jun 2019 14:09:02 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34734)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hcD6d-0001tp-Cu; Sat, 15 Jun 2019 14:08:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D3E1E2F8BC7;
 Sat, 15 Jun 2019 18:08:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.31])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D33891001B1B;
 Sat, 15 Jun 2019 18:08:35 +0000 (UTC)
Message-ID: <5154aa1deb2c8a2d51f575f3b89a1a3b2cb7c9b3.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, Klaus Birkelund Jensen
 <klaus@birkelund.eu>,  qemu-block@nongnu.org
Date: Sat, 15 Jun 2019 21:08:35 +0300
In-Reply-To: <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
References: <20190606092530.14206-1-klaus@birkelund.eu>
 <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Sat, 15 Jun 2019 18:08:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] nvme: do not advertise
 support for unsupported arbitration mechanism
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
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-06-14 at 22:39 +0200, Max Reitz wrote:
> On 06.06.19 11:25, Klaus Birkelund Jensen wrote:
> > The device mistakenly reports that the Weighted Round Robin with Urge=
nt
> > Priority Class arbitration mechanism is supported.
> >=20
> > It is not.
>=20
> I believe you based on the fact that there is no =E2=80=9Cweight=E2=80=9D=
 or =E2=80=9Cpriority=E2=80=9D
> anywhere in nvme.c, and that it does not evaluate the Arbitration
> Mechanism Selected field.
>=20
> > Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
> > ---
> >  hw/block/nvme.c | 1 -
> >  1 file changed, 1 deletion(-)
> >=20
> > diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> > index 30e50f7a3853..415b4641d6b4 100644
> > --- a/hw/block/nvme.c
> > +++ b/hw/block/nvme.c
> > @@ -1383,7 +1383,6 @@ static void nvme_realize(PCIDevice *pci_dev, Er=
ror **errp)
> >      n->bar.cap =3D 0;
> >      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
> >      NVME_CAP_SET_CQR(n->bar.cap, 1);
> > -    NVME_CAP_SET_AMS(n->bar.cap, 1);
>=20
> I suppose the better way would be to pass 0, so it is more explicit, I
> think.
>=20
> (Just removing it looks like it may have just been forgotten.)
>=20
> Max
>=20
> >      NVME_CAP_SET_TO(n->bar.cap, 0xf);
> >      NVME_CAP_SET_CSS(n->bar.cap, 1);
> >      NVME_CAP_SET_MPSMAX(n->bar.cap, 4);
> >=20
>=20
>=20

Yea. no way that this driver supports WRRU and I haven't noticed it.
Just checked again to be sure.

To be honest, after some quick look,=20
that driver doesn' even really support the regular Round-Robin as it uses=
 a timer to process a specific queue,=20
kicked up by a doorbell write :-)


Acked-by: Maxim Levitsky <mlevitsk@redhat.com>


Best regards,
	Maxim Levitsky


