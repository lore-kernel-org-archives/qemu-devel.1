Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E0AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:31:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C08BD206B5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:31:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C08BD206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48022 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yiZ-0004iN-30
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:31:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3ygj-000343-Lm; Fri, 07 Aug 2020 05:29:21 -0400
Received: from smtpout1.mo804.mail-out.ovh.net ([79.137.123.220]:48681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>)
 id 1k3ygg-0002bm-Sn; Fri, 07 Aug 2020 05:29:21 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.108.20.27])
 by mo804.mail-out.ovh.net (Postfix) with ESMTPS id 8932154AFAE1;
 Fri,  7 Aug 2020 11:29:14 +0200 (CEST)
Received: from kaod.org (37.59.142.98) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3; Fri, 7 Aug 2020
 11:29:13 +0200
Authentication-Results: garm.ovh; auth=pass
 (GARM-98R0025762a9e4-0521-441d-afc9-fa6b3ef79d2d,
 0FAFD30B9C3B2BFB516736AB00726897D031F517) smtp.auth=groug@kaod.org
Date: Fri, 7 Aug 2020 11:29:12 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH v2 for-5.2 3/5] ppc/xive: Introduce dedicated
 kvm_irqchip_in_kernel() wrappers
Message-ID: <20200807112912.5ba553a2@bahia.lan>
In-Reply-To: <20200807091554.633833c5@bahia.lan>
References: <159673295739.766512.2950380687630225803.stgit@bahia.lan>
 <159673298011.766512.17389427967409788911.stgit@bahia.lan>
 <64551e66-e867-037e-bf2e-efa22ebdd324@kaod.org>
 <20200807091554.633833c5@bahia.lan>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.98]
X-ClientProxiedBy: DAG8EX1.mxp5.local (172.16.2.71) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: e01457b0-0f74-418b-baa9-cdf5f7145a2a
X-Ovh-Tracer-Id: 2227311494357621155
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgddukecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehmgihplhgrnhehrdhmrghilhdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtoheptghlgheskhgrohgurdhorhhg
Received-SPF: pass client-ip=79.137.123.220; envelope-from=groug@kaod.org;
 helo=smtpout1.mo804.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 05:29:15
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Daniel Henrique Barboza <danielhb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 7 Aug 2020 09:15:54 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Thu, 6 Aug 2020 19:55:29 +0200
> C=C3=A9dric Le Goater <clg@kaod.org> wrote:
>=20

[...]

> > > diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> > > index 705cf48176fc..aa46e3fcf512 100644
> > > --- a/include/hw/ppc/xive.h
> > > +++ b/include/hw/ppc/xive.h
> > > @@ -161,6 +161,7 @@ typedef struct XiveNotifier XiveNotifier;
> > >  typedef struct XiveNotifierClass {
> > >      InterfaceClass parent;
> > >      void (*notify)(XiveNotifier *xn, uint32_t lisn);
> > > +    bool (*in_kernel)(const XiveNotifier *xn);
> > >  } XiveNotifierClass;
> > > =20
> > >  /*
> > > @@ -396,6 +397,7 @@ typedef struct XivePresenterClass {
> > >                       uint8_t nvt_blk, uint32_t nvt_idx,
> > >                       bool cam_ignore, uint8_t priority,
> > >                       uint32_t logic_serv, XiveTCTXMatch *match);
> > > +    bool (*in_kernel)(const XivePresenter *xptr);
> > >  } XivePresenterClass;
> > > =20
> > >  int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,
> > >=20
> > >=20
> >=20
> > It seems redundant. Can we introduce a new XiveBackend QOM interface=20
> > which would implement an in_kernel() handler ? and XiveRouter would=20
> > inherit from it.=20
> >=20
>=20
> Not sure to see how it would help... the XiveRouter type isn't used
> at the locations where we call kvm_irqchip_in_kernel(). Only
> XivePresenter and XiveNotifier...
>=20

Looking again at xive_source_realize(), I now realize (forgive the pun ;) t=
hat
the negative check on kvm_irqchip_in_kernel() is a bit awkward. We usually
do more stuff when we have a KVM backend, not less. The intent seems to be
that the ESB MMIO should point to either I/O sub-region when XIVE is emulat=
ed
or to a mmapped subregion when XIVE is backed by a KVM device. This can be
achieved with a container and overlapping sub-regions (prio 0 for emulated,
prio 1 for KVM). And we no longer need to hijack XiveNotifier.

So in the end, we only need the method for XivePresenter.

I'll cook a v3.

> > C.
> >=20
> >=20
> >=20
> >=20
> >=20
>=20


