Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ED29C43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:28:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7054320692
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 16:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7054320692
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieLtR-0003rv-H8
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 11:28:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34193)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieLsh-0003N4-Ro
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:27:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieLsg-00057A-GK
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:27:31 -0500
Received: from 7.mo178.mail-out.ovh.net ([46.105.58.91]:36929)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieLsg-00054j-9Q
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 11:27:30 -0500
Received: from player698.ha.ovh.net (unknown [10.108.16.135])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id DAD69846B9
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 17:27:27 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player698.ha.ovh.net (Postfix) with ESMTPSA id 821B8D0FFA17;
 Mon,  9 Dec 2019 16:27:18 +0000 (UTC)
Date: Mon, 9 Dec 2019 17:27:16 +0100
From: Greg Kurz <groug@kaod.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Subject: Re: [for-5.0 PATCH] ppc: Make PPCVirtualHypervisor an incomplete type
Message-ID: <20191209172716.175a86b5@bahia.w3ibm.bluemix.net>
In-Reply-To: <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
References: <157589808041.21182.18121655959115011353.stgit@bahia.lan>
 <bf095dc0-321e-0d19-9d18-309317654050@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 8498011025946220835
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgkeelucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepfffhvffukfgjfhfogggtgfesthhqredtredtjeenucfhrhhomhepifhrvghgucfmuhhriicuoehgrhhouhhgsehkrghougdrohhrgheqnecukfhppedtrddtrddtrddtpdekvddrvdehfedrvddtkedrvdegkeenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrieelkedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.58.91
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
Cc: "Daniel P . Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 15:02:38 +0100
Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> wrote:

> On 12/9/19 2:28 PM, Greg Kurz wrote:
> > PPCVirtualHypervisor is an interface instance. It should never be
> > dereferenced. Drop the dummy type definition for extra safety, which
> > is the common practice with QOM interfaces.
>=20
> This "common practice" is also referenced in commit 00ed3da9b5:
>=20
>      xics: Minor fixes for XICSFabric interface
>=20
>      Interface instances should never be directly dereferenced.  So, the=
=20
> common
>      practice is to make them incomplete types to make sure no-one does=20
> that.
>      XICSFrabric, however, had a dummy type which is less safe.
>=20
>      We were also using OBJECT_CHECK() where we should have been using
>      INTERFACE_CHECK().
>=20
> This indeed follow the changes from commit aa1b35b975d8:
>=20
>      qom: make interface types abstract
>=20
>      Interfaces don't have instance, let's make the interface type really
>      abstract to avoid confusion.
>=20
> Now I can't find guidelines for this. If you don't know about it and use=
=20
> 'git-grep', it is very confusing to see we use structures we never define.
>=20

I agree that this deliberate usage of incomplete types isn't common.

> Can we document this use please?
>=20

Probably we could amend the related section in the object.h header file.
Something like:

--- a/include/qom/object.h
+++ b/include/qom/object.h
@@ -200,8 +200,11 @@ typedef struct InterfaceInfo InterfaceInfo;
  *
  * Interfaces allow a limited form of multiple inheritance.  Instances are
  * similar to normal types except for the fact that are only defined by
- * their classes and never carry any state.  You can dynamically cast an o=
bject
- * to one of its #Interface types and vice versa.
+ * their classes and never carry any state.  As a consequence, a pointer to
+ * an interface instance should always be of incomplete type in order to be
+ * sure it cannot be dereferenced.
+ * You can dynamically cast an object to one of its #Interface types and v=
ice
+ * versa.
  *
  * # Methods #
  *

And even better, we could maybe come up with a way to detect that a type
was wrongly defined with coccinelle ?

> > Signed-off-by: Greg Kurz <groug@kaod.org>
> > ---
> >   target/ppc/cpu.h |    4 ----
> >   1 file changed, 4 deletions(-)
> >=20
> > diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> > index e3e82327b723..ab7d07d66047 100644
> > --- a/target/ppc/cpu.h
> > +++ b/target/ppc/cpu.h
> > @@ -1220,10 +1220,6 @@ PowerPCCPUClass *ppc_cpu_class_by_pvr(uint32_t p=
vr);
> >   PowerPCCPUClass *ppc_cpu_class_by_pvr_mask(uint32_t pvr);
> >   PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc);
> >  =20
> > -struct PPCVirtualHypervisor {
> > -    Object parent;
> > -};
> > -
> >   struct PPCVirtualHypervisorClass {
> >       InterfaceClass parent;
> >       void (*hypercall)(PPCVirtualHypervisor *vhyp, PowerPCCPU *cpu);
> >=20
> >=20
>=20


