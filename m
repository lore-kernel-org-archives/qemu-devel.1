Return-Path: <SRS0=SZz4=XU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0A9AC432C2
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:51:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8BE420872
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Sep 2019 07:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8BE420872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iD25P-0008SF-L6
	for qemu-devel@archiver.kernel.org; Wed, 25 Sep 2019 03:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47797)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iD229-0006d8-Jl
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:48:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iD228-0002DR-Hd
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:48:21 -0400
Received: from 4.mo3.mail-out.ovh.net ([178.33.46.10]:55011)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iD228-00027o-B8
 for qemu-devel@nongnu.org; Wed, 25 Sep 2019 03:48:20 -0400
Received: from player750.ha.ovh.net (unknown [10.109.146.175])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 54BCE228FE1
 for <qemu-devel@nongnu.org>; Wed, 25 Sep 2019 09:48:17 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player750.ha.ovh.net (Postfix) with ESMTPSA id 6BD6CA494BAF;
 Wed, 25 Sep 2019 07:48:06 +0000 (UTC)
Date: Wed, 25 Sep 2019 09:48:04 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 01/20] xics: Use incomplete type for XICSFabric
Message-ID: <20190925094804.56c6138d@bahia.lan>
In-Reply-To: <f20d189d-14ea-28e7-741b-68186ea608a8@kaod.org>
References: <20190925064534.19155-1-david@gibson.dropbear.id.au>
 <20190925064534.19155-2-david@gibson.dropbear.id.au>
 <f20d189d-14ea-28e7-741b-68186ea608a8@kaod.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 1999598235154815371
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrfedugdduvdeiucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 178.33.46.10
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
Cc: Jason Wang <jasowang@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 =?UTF-8?B?TWFy?= =?UTF-8?B?Yy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 25 Sep 2019 08:55:50 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 25/09/2019 08:45, David Gibson wrote:
> > Interface instances should never be directly dereferenced.  So, the com=
mon
> > practice is to make them incomplete types to make sure no-one does that.
> > XICSFrabric, however, had a dummy type which is less safe.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  include/hw/ppc/xics.h | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> >=20
> > diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> > index 64a2c8862a..1ae34ce9cd 100644
> > --- a/include/hw/ppc/xics.h
> > +++ b/include/hw/ppc/xics.h
> > @@ -147,9 +147,7 @@ struct ICSIRQState {
> >      uint8_t flags;
> >  };
> > =20
> > -struct XICSFabric {
> > -    Object parent;
> > -};
> > +typedef struct XICSFabric XICSFabric;
> > =20
> >  #define TYPE_XICS_FABRIC "xics-fabric"
> >  #define XICS_FABRIC(obj)                                     \
> >=20
>=20
> you should also change :
>=20
> #define XICS_FABRIC(obj)                                     \
>     OBJECT_CHECK(XICSFabric, (obj), TYPE_XICS_FABRIC)
>=20
>=20
> and use INTERFACE_CHECK()
>=20

Yes but I think this deserves a separate patch.

> C.


