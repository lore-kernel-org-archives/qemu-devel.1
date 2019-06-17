Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91DCFC31E44
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:55:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 651BC21855
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 06:55:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 651BC21855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=birkelund.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44616 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hclYX-0004Si-KQ
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 02:55:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52197)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <klaus@birkelund.eu>) id 1hclXC-0003sm-RU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:54:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <klaus@birkelund.eu>) id 1hclXB-0007Vb-KU
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 02:54:30 -0400
Received: from charlie.dont.surf ([128.199.63.193]:46348)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <klaus@birkelund.eu>)
 id 1hclX7-0007Sr-PZ; Mon, 17 Jun 2019 02:54:26 -0400
Received: from apples.localdomain (soho-cph.cust-cnex.dsd101.net
 [194.62.216.132])
 by charlie.dont.surf (Postfix) with ESMTPSA id 90B33BF602;
 Mon, 17 Jun 2019 06:54:23 +0000 (UTC)
Date: Mon, 17 Jun 2019 08:54:19 +0200
From: Klaus Birkelund <klaus@birkelund.eu>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190617065419.GA15574@apples.localdomain>
Mail-Followup-To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-devel@nongnu.org
References: <20190606092530.14206-1-klaus@birkelund.eu>
 <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 128.199.63.193
Subject: Re: [Qemu-devel] [PATCH] nvme: do not advertise support for
 unsupported arbitration mechanism
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
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 14, 2019 at 10:39:27PM +0200, Max Reitz wrote:
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

Not sure if you want me to change the commit message? Feel free to
change it if you want to ;)

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

Not explicitly setting it to zero aligns with how the other fields in
CAP are also left out if kept at zero. If we explicitly set it to zero I
think we should also set all the other fields that way (DSTRD, NSSRS,
etc.).


Klaus

