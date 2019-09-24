Return-Path: <SRS0=+sEj=XT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179B4C4320D
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:56:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0425207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Sep 2019 07:56:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0425207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42176 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCfgZ-0003Lm-D7
	for qemu-devel@archiver.kernel.org; Tue, 24 Sep 2019 03:56:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iCfcP-0008Ps-PS
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:52:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iCfcL-00016D-Go
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:52:17 -0400
Received: from 1.mo173.mail-out.ovh.net ([178.33.111.180]:39044)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iCfcH-000124-OK
 for qemu-devel@nongnu.org; Tue, 24 Sep 2019 03:52:11 -0400
Received: from player729.ha.ovh.net (unknown [10.109.146.82])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 2118B11AA6A
 for <qemu-devel@nongnu.org>; Tue, 24 Sep 2019 09:52:06 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player729.ha.ovh.net (Postfix) with ESMTPSA id 676C3A4E7989;
 Tue, 24 Sep 2019 07:52:01 +0000 (UTC)
Date: Tue, 24 Sep 2019 09:52:00 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH 0/4] xics: Eliminate unnecessary class
Message-ID: <20190924095200.7f624278@bahia.lan>
In-Reply-To: <cb87c744-a618-0627-5c2f-8f8e18616f6d@kaod.org>
References: <20190924045952.11412-1-david@gibson.dropbear.id.au>
 <cb87c744-a618-0627-5c2f-8f8e18616f6d@kaod.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 14638387640565209483
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrvdelgdduvdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 178.33.111.180
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
Cc: gkurz@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 24 Sep 2019 07:22:51 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 24/09/2019 06:59, David Gibson wrote:
> > The XICS interrupt controller device used to have separate subtypes
> > for the KVM and non-KVM variant of the device.  That was a bad idea,
> > because it leaked information that should be entirely host-side
> > implementation specific to the kinda-sorta guest visible QOM class
> > names.
> >=20
> > We eliminated the KVM specific class some time ago, but it's left
> > behind a distinction between the TYPE_ICS_BASE abstract class and
> > TYPE_ICS_SIMPLE subtype which no longer serves any purpose.
> >=20
> > This series collapses the two types back into one.
>=20
> OK. Is it migration compatible ? because this is why we have kept

Yeah, the types themselves don't matter, only the format of the
binary stream described in the VMStateDescription does.

> this subclass. I am glad we can remove it finally.=20
>=20

I was thinking we were keeping that for pnv...

> Thanks,
>=20
> C.
>=20
>    =20
> >=20
> > David Gibson (4):
> >   xics: Eliminate 'reject', 'resend' and 'eoi' class hooks
> >   xics: Merge reset and realize hooks
> >   xics: Rename misleading ics_simple_*() functions
> >   xics: Merge TYPE_ICS_BASE and TYPE_ICS_SIMPLE classes
> >=20
> >  hw/intc/trace-events  |  10 +-
> >  hw/intc/xics.c        | 211 ++++++++++++++----------------------------
> >  hw/intc/xics_spapr.c  |  12 +--
> >  hw/ppc/pnv_psi.c      |   6 +-
> >  hw/ppc/spapr_irq.c    |   6 +-
> >  include/hw/ppc/xics.h |  30 +-----
> >  6 files changed, 92 insertions(+), 183 deletions(-)
> >=20
>=20


