Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA89DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:53:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF5C325480
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 07:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF5C325480
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnHHC-0000xP-Vi
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 03:53:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnHGf-0000Pa-5N
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:53:25 -0400
Received: from 2.mo173.mail-out.ovh.net ([178.33.251.49]:52671)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <groug@kaod.org>) id 1jnHGb-0003fD-UY
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 03:53:24 -0400
Received: from player157.ha.ovh.net (unknown [10.108.54.97])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id E09BB145171
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2020 09:53:18 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player157.ha.ovh.net (Postfix) with ESMTPSA id A25FA139BCF7B;
 Mon, 22 Jun 2020 07:53:13 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass
 (GARM-103G0051f1eb5bc-80bc-43a3-a771-26561e097bc8,6D3CA472F13BA58F0C95800BF735BE34A93B107C)
 smtp.auth=groug@kaod.org
Date: Mon, 22 Jun 2020 09:53:12 +0200
From: Greg Kurz <groug@kaod.org>
To: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>
Subject: Re: [PATCH] ppc/pnv: Silence missing BMC warning with qtest
Message-ID: <20200622095312.0919cfc4@bahia.lan>
In-Reply-To: <47741f1f-0070-4325-9690-9549211f266c@kaod.org>
References: <159280903824.485572.831378159272329707.stgit@bahia.lan>
 <47741f1f-0070-4325-9690-9549211f266c@kaod.org>
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 7164664058301618571
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduhedrudekuddguddtlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucggtffrrghtthgvrhhnpeeukeejkeeiffeftdevueekvdetjeegieevhffgjefgtdeluddvgfefleekueevueenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpqdhouhhtpdhhvghlohepphhlrgihvghrudehjedrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehgrhhouhhgsehkrghougdrohhrghdprhgtphhtthhopehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhg
Received-SPF: pass client-ip=178.33.251.49; envelope-from=groug@kaod.org;
 helo=2.mo173.mail-out.ovh.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 03:53:19
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: qemu-ppc@nongnu.org,
 Philippe =?UTF-8?B?TWF0?= =?UTF-8?B?aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jun 2020 09:13:46 +0200
C=C3=A9dric Le Goater <clg@kaod.org> wrote:

> On 6/22/20 8:57 AM, Greg Kurz wrote:
> > The device introspect test in qtest emits some warnings with the
> > the pnv machine types during the "nodefaults" phase:
> >=20
> > TEST check-qtest-ppc64: tests/qtest/device-introspect-test
> > qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> > ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to defi=
ne
> > one
> > qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> > ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to defi=
ne
> > one
> > qemu-system-ppc64: warning: machine has no BMC device. Use '-device
> > ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10' to defi=
ne
> > one
> >=20
> > This is expected since the pnv machine doesn't create the internal
> > BMC simulator fallback when "-nodefaults" is passed on the command
> > line, but these warnings appear in ci logs and confuse people.
> >=20
> > Not having a BMC isn't recommended but it is still a supported
> > configuration, so a straightforward fix is to just silent this
> > warning when qtest is enabled.
> >=20
> > Fixes: 25f3170b0654 ("ppc/pnv: Create BMC devices only when defaults ar=
e enabled")
> > Reported-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > Signed-off-by: Greg Kurz <groug@kaod.org>
>=20
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
>=20
> It looks good but could you reproduce ?=20
>=20

Yup, this test is only run in "slow" mode, eg:

    make check-qtest-ppc64 SPEED=3Dslow


> C.
>=20
> > ---
> >  hw/ppc/pnv.c |    9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >=20
> > diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> > index 806a5d9a8d34..1622d29b4ba7 100644
> > --- a/hw/ppc/pnv.c
> > +++ b/hw/ppc/pnv.c
> > @@ -21,6 +21,7 @@
> >  #include "qemu-common.h"
> >  #include "qemu/units.h"
> >  #include "qapi/error.h"
> > +#include "sysemu/qtest.h"
> >  #include "sysemu/sysemu.h"
> >  #include "sysemu/numa.h"
> >  #include "sysemu/reset.h"
> > @@ -587,9 +588,11 @@ static void pnv_reset(MachineState *machine)
> >      bmc =3D pnv_bmc_find(&error_fatal);
> >      if (!pnv->bmc) {
> >          if (!bmc) {
> > -            warn_report("machine has no BMC device. Use '-device "
> > -                        "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-bt,bm=
c=3Dbmc0,irq=3D10' "
> > -                        "to define one");
> > +            if (!qtest_enabled()) {
> > +                warn_report("machine has no BMC device. Use '-device "
> > +                            "ipmi-bmc-sim,id=3Dbmc0 -device isa-ipmi-b=
t,bmc=3Dbmc0,irq=3D10' "
> > +                            "to define one");
> > +            }
> >          } else {
> >              pnv_bmc_set_pnor(bmc, pnv->pnor);
> >              pnv->bmc =3D bmc;
> >=20
> >=20
>=20


