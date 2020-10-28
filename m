Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9613FC388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:45:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12564247D2
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:45:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hh+Nwqeq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12564247D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXne9-0007Cu-Uv
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXnaV-00024f-KE
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:42:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:23932)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1kXnaS-0001O5-UM
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 11:42:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603899728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uM9w+y2LttTOkTPRYemZHQ4TQKXbUq9poFDMMgUWzDY=;
 b=hh+Nwqeq3EQSM07tUeVnpkSOdDZfMzOMlOhItwPybzrDHY9oNtaAIaJc40hbuas1qheCu2
 hlwc9fifdQWTWspQjQhuIeGOlYzV9lVeCe85kRuHEhWyEUixoUFvWDwy8EC6Lr6XoC1dDr
 QxOmwNkOuUebvlLqrI9U/zOpJX0gM28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-17-Wq_1L2JFOuO71JNISM2kpQ-1; Wed, 28 Oct 2020 11:42:06 -0400
X-MC-Unique: Wq_1L2JFOuO71JNISM2kpQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36A8C1099F67;
 Wed, 28 Oct 2020 15:42:04 +0000 (UTC)
Received: from w520.home (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B26A85C1D7;
 Wed, 28 Oct 2020 15:41:59 +0000 (UTC)
Date: Wed, 28 Oct 2020 09:41:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Subject: Re: [PULL 00/32] VFIO updates 2020-10-26 (for QEMU 5.2 soft-freeze)
Message-ID: <20201028094159.619a4afd@w520.home>
In-Reply-To: <ad19996f-b2fc-c8aa-2bc4-40b5b0cfb91c@linux.ibm.com>
References: <160374054442.22414.10832953989449611268.stgit@gimli.home>
 <CAFEAcA9pgxKY7Q8bHRR0MXvYkWAWjakJS=uo4V_Bs14zLLc-Jw@mail.gmail.com>
 <ad19996f-b2fc-c8aa-2bc4-40b5b0cfb91c@linux.ibm.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=alex.williamson@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:50:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Artem Polyakov <artemp@nvidia.com>,
 Peter Maydell <peter.maydell@linaro.org>, Zhengui li <lizhengui@huawei.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Zhi Wang <zhi.wang.linux@gmail.com>,
 Pierre Morel <pmorel@linux.ibm.com>, Neo Jia <cjia@nvidia.com>,
 Cornelia Huck <cohuck@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Amey Narkhede <ameynarkhede03@gmail.com>,
 Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 28 Oct 2020 11:20:36 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 10/28/20 11:07 AM, Peter Maydell wrote:
> > On Mon, 26 Oct 2020 at 19:39, Alex Williamson
> > <alex.williamson@redhat.com> wrote: =20
> >>
> >> The following changes since commit a5fac424c76d6401ecde4ecb7d846e656d0=
d6e89:
> >>
> >>    Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pu=
ll-request' into staging (2020-10-26 10:33:59 +0000)
> >>
> >> are available in the Git repository at:
> >>
> >>    git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20201026.0
> >>
> >> for you to fetch changes up to 5219bf8e0fa86573427aa8812bbfe93d83c3d66=
4:
> >>
> >>    vfio: fix incorrect print type (2020-10-26 12:07:46 -0600)
> >>
> >> ----------------------------------------------------------------
> >> VFIO update 2020-10-26
> >>
> >>   * Migration support (Kirti Wankhede)
> >>   * s390 DMA limiting (Matthew Rosato)
> >>   * zPCI hardware info (Matthew Rosato)
> >>   * Lock guard (Amey Narkhede)
> >>   * Print fixes (Zhengui li)
> >> =20
> >=20
> > I retried the merge of this after the revert from Max, and it
> > no longer gives merge conflicts, but it has compile errors:
> >=20
> > On FreeBSD, OpenBSD, NetBSD, OSX and Windows:
> >=20
> > In file included from ../src/hw/arm/sysbus-fdt.c:35:
> > In file included from
> > /usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-platform.h:20:
> > /usr/home/qemu/qemu-test.ffr5Sp/src/include/hw/vfio/vfio-common.h:201:3=
7:
> > warning: declaration of 'struct vfio_iommu_type1_info' will not be
> > visible outside of this function [-Wvisibility]
> > bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
> >                                      ^ =20
>=20
> Alex, for this one I think the definition of
> bool vfio_get_info_dma_avail(struct vfio_iommu_type1_info *info,
>                               unsigned int *avail);
>=20
> in vfio-common.h needs to be behind the #ifdef CONFIG_LINUX as that's=20
> the only case where we include vfio.h where vfio_iommu_type1_info is=20
> defined.

Thank you.  I'll update and repost, I think the others below are
resolved using HWADDR_PRIx and PRIx64, plus removing the redundant
parens.  Thanks,

Alex


> > On clang x86-64 Linux:
> >=20
> > ../../hw/vfio/migration.c:737:42: error: equality comparison with
> > extraneous parentheses [-Werror,-Wparentheses-equality]
> >      if ((vbasedev->migration->vm_running =3D=3D running)) {
> >           ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~
> > ../../hw/vfio/migration.c:737:42: note: remove extraneous parentheses
> > around the comparison to silence this warning
> >      if ((vbasedev->migration->vm_running =3D=3D running)) {
> >          ~                                ^         ~
> > ../../hw/vfio/migration.c:737:42: note: use '=3D' to turn this equality
> > comparison into an assignment
> >      if ((vbasedev->migration->vm_running =3D=3D running)) {
> >                                           ^~
> >                                           =3D
> >=20
> > On AArch32:
> >=20
> > ../../hw/vfio/migration.c: In function 'vfio_mig_access':
> > ../../hw/vfio/migration.c:58:68: error: format '%lx' expects argument
> > of type 'long unsigned int', but argument 5 has type 'off_t {aka long
> > long int}' [-Werror=3Dformat=3D]
> >           error_report("vfio_mig_%s %d byte %s: failed at offset 0x%lx,=
 err: %s",
> >                                                                    ~~^
> >                                                                    %llx
> > cc1: all warnings being treated as errors
> >=20
> >=20
> > On PPC64:
> >=20
> > ../../hw/vfio/common.c: In function =E2=80=98vfio_dma_unmap_bitmap=E2=
=80=99:
> > ../../hw/vfio/common.c:400:9: error: format =E2=80=98%llx=E2=80=99 expe=
cts argument of
> > type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has type =
=E2=80=98__u64=E2=80=99
> > [-Werror=3Dformat=3D]
> >           error_report("UNMAP: Size of bitmap too big 0x%llx", bitmap->=
size);
> >           ^
> > ../../hw/vfio/common.c: In function =E2=80=98vfio_get_dirty_bitmap=E2=
=80=99:
> > ../../hw/vfio/common.c:1003:17: error: format =E2=80=98%llx=E2=80=99 ex=
pects argument
> > of type =E2=80=98long long unsigned int=E2=80=99, but argument 2 has ty=
pe =E2=80=98__u64=E2=80=99
> > [-Werror=3Dformat=3D]
> >                   range->iova, range->size, errno);
> >                   ^
> > ../../hw/vfio/common.c:1003:17: error: format =E2=80=98%llx=E2=80=99 ex=
pects argument
> > of type =E2=80=98long long unsigned int=E2=80=99, but argument 3 has ty=
pe =E2=80=98__u64=E2=80=99
> > [-Werror=3Dformat=3D]
> >=20
> > thanks
> > -- PMM
> >  =20
>=20


