Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 279FCC43603
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE408205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 21:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE408205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieQBn-0005zl-64
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 16:03:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42719)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1ieQB9-0005Wu-5K
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:02:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1ieQB7-0003nT-OC
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:02:50 -0500
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:50344)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1ieQB7-0003m9-Hz
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 16:02:49 -0500
Received: from player737.ha.ovh.net (unknown [10.108.35.122])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id 05888231AAA
 for <qemu-devel@nongnu.org>; Mon,  9 Dec 2019 22:02:46 +0100 (CET)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player737.ha.ovh.net (Postfix) with ESMTPSA id C150A3A5B7DB;
 Mon,  9 Dec 2019 21:02:32 +0000 (UTC)
Date: Mon, 9 Dec 2019 22:02:31 +0100
From: Greg Kurz <groug@kaod.org>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [for-5.0 PATCH v2 0/3] cpu: Clarify overloading of reset QOM
 methods
Message-ID: <20191209220231.186166aa@bahia.w3ibm.bluemix.net>
In-Reply-To: <20191209192143.3dda1b54.cohuck@redhat.com>
References: <157591411283.46967.15944326590669093952.stgit@bahia.lan>
 <20191209192143.3dda1b54.cohuck@redhat.com>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 13147696165288647106
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrudeltddgudeghecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeffhffvuffkjghfofggtgfgsehtqhertdertdejnecuhfhrohhmpefirhgvghcumfhurhiiuceoghhrohhugheskhgrohgurdhorhhgqeenucffohhmrghinhepghhithhhuhgsrdgtohhmpdhqvghmuhdrohhrghenucfkpheptddrtddrtddrtddpkedvrddvheefrddvtdekrddvgeeknecurfgrrhgrmhepmhhouggvpehsmhhtphdqohhuthdphhgvlhhopehplhgrhigvrhejfeejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepghhrohhugheskhgrohgurdhorhhgpdhrtghpthhtohepqhgvmhhuqdguvghvvghlsehnohhnghhnuhdrohhrghenucevlhhushhtvghrufhiiigvpedt
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 87.98.150.177
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, David Hildenbrand <david@redhat.com>,
 qemu-devel@nongnu.org, Alistair Francis <alistair.francis@wdc.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 9 Dec 2019 19:21:43 +0100
Cornelia Huck <cohuck@redhat.com> wrote:

> On Mon, 09 Dec 2019 18:55:12 +0100
> Greg Kurz <groug@kaod.org> wrote:
>=20
> > Each cpu subclass overloads the reset method of its parent class with
> > its own. But since it needs to call the parent method as well, it keeps
> > a parent_reset pointer to do so. This causes the same not very explicit
> > boiler plate to be duplicated all around the place:
> >=20
> >     pcc->parent_reset =3D cc->reset;
> >     cc->reset =3D ppc_cpu_reset;
> >=20
> > A similar concern was addressed some time back by Philippe Mathieu-Daud=
=C3=A9
> > in qdev, with the addition of device_class_set_parent_reset() and frien=
ds:
> >=20
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D46795cf2e2f6
> > https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3Dbf853881690d
> >=20
> > Follow the same approach with cpus.
> >=20
> > Changes in v2:
> > - added Reviewed-by and Acked-by tags
> > - rebased on top of https://github.com/cohuck/qemu.git s390-next
> >   SHA1 dd6252f035a2
>=20
> My apologies for the churn. I'll try to flush my queue ASAP after 5.0
> development opens.
>=20

No problems. It is perfectly fine to queue patches during freeze :)

> >=20
> > --
> > Greg
> >=20
> > ---
> >=20
> > Greg Kurz (3):
> >       cpu: Introduce CPUReset callback typedef
> >       cpu: Introduce cpu_class_set_parent_reset()
> >       cpu: Use cpu_class_set_parent_reset()
> >=20
> >=20
> >  hw/core/cpu.c                   |    8 ++++++++
> >  include/hw/core/cpu.h           |    8 +++++++-
> >  target/alpha/cpu-qom.h          |    2 +-
> >  target/arm/cpu-qom.h            |    2 +-
> >  target/arm/cpu.c                |    3 +--
> >  target/cris/cpu-qom.h           |    2 +-
> >  target/cris/cpu.c               |    3 +--
> >  target/hppa/cpu-qom.h           |    2 +-
> >  target/i386/cpu-qom.h           |    2 +-
> >  target/i386/cpu.c               |    3 +--
> >  target/lm32/cpu-qom.h           |    2 +-
> >  target/lm32/cpu.c               |    3 +--
> >  target/m68k/cpu-qom.h           |    2 +-
> >  target/m68k/cpu.c               |    3 +--
> >  target/microblaze/cpu-qom.h     |    2 +-
> >  target/microblaze/cpu.c         |    3 +--
> >  target/mips/cpu-qom.h           |    2 +-
> >  target/mips/cpu.c               |    3 +--
> >  target/moxie/cpu.c              |    3 +--
> >  target/moxie/cpu.h              |    2 +-
> >  target/nios2/cpu.c              |    3 +--
> >  target/nios2/cpu.h              |    2 +-
> >  target/openrisc/cpu.c           |    3 +--
> >  target/openrisc/cpu.h           |    2 +-
> >  target/ppc/cpu-qom.h            |    2 +-
> >  target/ppc/translate_init.inc.c |    3 +--
> >  target/riscv/cpu.c              |    3 +--
> >  target/riscv/cpu.h              |    2 +-
> >  target/s390x/cpu-qom.h          |    2 +-
> >  target/s390x/cpu.c              |    3 +--
> >  target/sh4/cpu-qom.h            |    2 +-
> >  target/sh4/cpu.c                |    3 +--
> >  target/sparc/cpu-qom.h          |    2 +-
> >  target/sparc/cpu.c              |    3 +--
> >  target/tilegx/cpu.c             |    3 +--
> >  target/tilegx/cpu.h             |    2 +-
> >  target/tricore/cpu-qom.h        |    2 +-
> >  target/tricore/cpu.c            |    3 +--
> >  target/xtensa/cpu-qom.h         |    2 +-
> >  target/xtensa/cpu.c             |    3 +--
> >  40 files changed, 53 insertions(+), 57 deletions(-)
> >=20
>=20


