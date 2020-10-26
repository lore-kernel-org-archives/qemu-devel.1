Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3457CC55178
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDE3822263
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 14:52:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDE3822263
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47156 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX3rm-00048A-Uy
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 10:52:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55092)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX3lx-0006qQ-79
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:46:57 -0400
Received: from 10.mo51.mail-out.ovh.net ([46.105.77.235]:46678)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1kX3lt-0001xM-GH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 10:46:56 -0400
Received: from mxplan5.mail.ovh.net (unknown [10.109.146.107])
 by mo51.mail-out.ovh.net (Postfix) with ESMTPS id 8688B2311BA;
 Mon, 26 Oct 2020 15:46:49 +0100 (CET)
Received: from kaod.org (37.59.142.100) by DAG8EX1.mxp5.local (172.16.2.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 26 Oct
 2020 15:46:49 +0100
Authentication-Results: garm.ovh; auth=pass
 (GARM-100R003714acb2a-6ee3-4cdd-9946-3f090ed9112c,
 D69A261E470FD7A087455D2B3B9CC66C186A091D) smtp.auth=groug@kaod.org
Date: Mon, 26 Oct 2020 15:46:47 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [PATCH 1/4] spapr: qemu_memalign() doesn't return NULL
Message-ID: <20201026154647.4a421bc5@bahia.lan>
In-Reply-To: <7b6abe52-c17e-09b8-9239-e0e38d4d0a1f@redhat.com>
References: <160371602625.305923.7832478283946753271.stgit@bahia.lan>
 <160371603337.305923.17158585537944509438.stgit@bahia.lan>
 <7b6abe52-c17e-09b8-9239-e0e38d4d0a1f@redhat.com>
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [37.59.142.100]
X-ClientProxiedBy: DAG3EX1.mxp5.local (172.16.2.21) To DAG8EX1.mxp5.local
 (172.16.2.71)
X-Ovh-Tracer-GUID: 56c60f93-2e46-4637-8056-b678b123b3de
X-Ovh-Tracer-Id: 16238009934842272224
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedujedrkeejgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgihesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecuggftrfgrthhtvghrnhepveelhfdtudffhfeiveehhfelgeellefgteffteekudegheejfffghefhfeeuudffnecukfhppedtrddtrddtrddtpdefjedrheelrddugedvrddutddtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepmhigphhlrghnhedrmhgrihhlrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=46.105.77.235; envelope-from=groug@kaod.org;
 helo=10.mo51.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 08:54:00
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 26 Oct 2020 14:43:08 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 10/26/20 1:40 PM, Greg Kurz wrote:
> > qemu_memalign() aborts if OOM. Drop some dead code.
> >=20
> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   hw/ppc/spapr.c       |    6 ------
> >   hw/ppc/spapr_hcall.c |    8 ++------
> >   2 files changed, 2 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 0cc19b5863a4..f098d0ee6d98 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -1521,12 +1521,6 @@ void spapr_reallocate_hpt(SpaprMachineState *spa=
pr, int shift,
> >           int i;
> >  =20
> >           spapr->htab =3D qemu_memalign(size, size);
> > -        if (!spapr->htab) {
> > -            error_setg_errno(errp, errno,
> > -                             "Could not allocate HPT of order %d", shi=
ft);
> > -            return;
>=20
> Wasn't the idea to use qemu_try_memalign() here?
>=20

Well... I have mixed feeling around this. The HTAB was first
introduced by commit:

commit f43e35255cffb6ac6230dd09d308f7909f823f96
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri Apr 1 15:15:22 2011 +1100

    Virtual hash page table handling on pSeries machine

using qemu_mallocz(), which was aborting on OOM. It then got
replaced by g_malloc0() when qemu_mallocz() got deprecated
and eventually by qemu_memalign() when KVM support was added.

Surviving OOM when allocating the HTAB never seemed to be an
option until this commit that introduced the check:

commit c5f54f3e31bf693f70a98d4d73ea5dbe05689857
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Tue Feb 9 10:21:56 2016 +1000

    pseries: Move hash page table allocation to reset time

I don't really see in the patch and in the changelog an obvious
desire to try to handle OOM.

> > -        }
> > -
> >           memset(spapr->htab, 0, size);
> >           spapr->htab_shift =3D shift;
> >  =20
> > diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
> > index 607740150fa2..34e146f628fb 100644
> > --- a/hw/ppc/spapr_hcall.c
> > +++ b/hw/ppc/spapr_hcall.c
> > @@ -361,12 +361,8 @@ static void *hpt_prepare_thread(void *opaque)
> >       size_t size =3D 1ULL << pending->shift;
> >  =20
> >       pending->hpt =3D qemu_memalign(size, size);
> > -    if (pending->hpt) {
> > -        memset(pending->hpt, 0, size);
> > -        pending->ret =3D H_SUCCESS;
> > -    } else {
> > -        pending->ret =3D H_NO_MEM;
>=20
> Ditto.
>=20

This one was introduced by commit:

commit 0b0b831016ae93bc14698a5d7202eb77feafea75
Author: David Gibson <david@gibson.dropbear.id.au>
Date:   Fri May 12 15:46:49 2017 +1000

    pseries: Implement HPT resizing

I agree that maybe the intent here could have been to use qemu_try_memalign=
(),
but again I don't quite see any strong justification to handle OOM in the
changelog.

David,

Any insight to share ?

> > -    }
> > +    memset(pending->hpt, 0, size);
> > +    pending->ret =3D H_SUCCESS;
> >  =20
> >       qemu_mutex_lock_iothread();
> >  =20
>=20


