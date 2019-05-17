Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C906C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FC420879
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 11:15:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FC420879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46697 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRapT-0005Lf-38
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 07:15:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58784)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRanq-0004Dd-BQ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:13:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1hRanp-0002zP-3d
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:13:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55646)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1hRano-0002y8-SS
	for qemu-devel@nongnu.org; Fri, 17 May 2019 07:13:29 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D49F29D4F2;
	Fri, 17 May 2019 11:13:22 +0000 (UTC)
Received: from Igors-MacBook-Pro (unknown [10.40.205.69])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F3DC71001DC1;
	Fri, 17 May 2019 11:13:16 +0000 (UTC)
Date: Fri, 17 May 2019 13:13:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190517131315.117fea4b@Igors-MacBook-Pro>
In-Reply-To: <20190517025903.GA17182@richard>
References: <20190515121146.7248-1-mst@redhat.com>
	<CAFEAcA95Uh=j+vGCT08+ztAc5Yk8RWGzApDZrrt5DS7XudGQhQ@mail.gmail.com>
	<6d652ee6-ffee-6316-88f4-ba9f2a237817@redhat.com>
	<CAP+75-XuuUamjbouNYRJzm2Qwtorwhbe+QX8BHBK_WaUc8F+7A@mail.gmail.com>
	<20190517025903.GA17182@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.39]);
	Fri, 17 May 2019 11:13:27 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 00/37] pci, pc, virtio: features, fixes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Peter Maydell <peter.maydell@linaro.org>,
	Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	"Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 17 May 2019 10:59:03 +0800
Wei Yang <richardw.yang@linux.intel.com> wrote:

> On Thu, May 16, 2019 at 08:53:04PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> >On Thu, May 16, 2019 at 8:33 PM Philippe Mathieu-Daud=C3=A9
> ><philmd@redhat.com> wrote:
> >> On 5/16/19 6:04 PM, Peter Maydell wrote:
> >> > On Thu, 16 May 2019 at 13:17, Michael S. Tsirkin <mst@redhat.com> wr=
ote:
> >> >>
> >> >> The following changes since commit efb4f3b62c69383a7308d7b739a3193e=
7c0ccae8:
> >> >>
> >> >>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-re=
quest' into staging (2019-05-10 14:49:36 +0100)
> >> >>
> >> >> are available in the Git repository at:
> >> >>
> >> >>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstr=
eam
> >> >>
> >> >> for you to fetch changes up to 0534d255dae78450d90d59db0f3a9a46b32e=
bd73:
> >> >>
> >> >>   tests: acpi: print error unable to dump ACPI table during rebuild=
 (2019-05-14 21:19:14 -0400)
> >> >>
> >> >> ----------------------------------------------------------------
> >> >> pci, pc, virtio: features, fixes
> >> >>
> >> >> reconnect for vhost blk
> >> >> tests for UEFI
> >> >> misc other stuff
> >> >>
> >> >> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> >> >>
> >> >> ----------------------------------------------------------------
> >> >
> >> > Hi -- this pullreq has a conflict in default-configs/arm-softmmu.mak
> >> > because the conversion of arm to Kconfig has landed in master.
> >> > Could you rebase and fix up to use whatever the Kconfig
> >> > equivalent of these changes is, please?
> >>
> >> Culprit is "hw/acpi: Consolidate build_mcfg to pci.c"
> >>
> >> The conflict doesn't look trivial to resolve (to me) so I'd rather see
> >> it reviewed (by Thomas). I suggest to drop the patch(es) from your PR =
:(
> >
> >Thomas, FYI I did this to resolve the conflict:
> >
> >- keep default-configs/arm-softmmu.mak from master:
> >
> >  git checkout origin/master default-configs/arm-softmmu.mak
> >
> >- applied the following !fixup snippet:
> >
> >-- >8 --
> >--- a/hw/acpi/Kconfig
> >+++ b/hw/acpi/Kconfig
> >@@ -25,7 +25,7 @@ config ACPI_NVDIMM
> >
> > config ACPI_PCI
> >     bool
> >-    depends on ACPI
> >+    depends on ACPI && PCI
> >
> >---
> >
> >I felt it easier to review on top of "hw/acpi: Improve build modularity"
> >https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg04718.html
> >
>=20
> Well, I hope this will not block the merge.
>=20
> I took a look in the change of default-configs/arm-softmmu.mak. The gener=
al
> idea from Thomas is put those hard-coded config to Kconfig.
>=20
> This is fine and what I need to change in my patch is to select ACPI_PCI =
in
> the proper place, if my understanding is correct.
>=20
> Two things I need to fix:
>=20
>   * add select ACPI_PCI in proper place of hw/arm/Kconfig
>   * add a dummy build_mcfg() for link when ACPI_PCI is not configured.
>=20
> Then I have two questions:
>=20
>   * In hw/arm/Kconfig, I don't see one option contains both PCI and ACPI.=
 I am
>     confused where to put the select.
>   * put dummy build_mcfg() in aml-build.c works. Igor, do you like this? =
Or
>     you haver other preference?

could you point out why we need dummy build_mcfg(), in the first place?

>=20
> >Sadly both series clash :(
> >
> >Regards,
> >
> >Phil.
>=20


