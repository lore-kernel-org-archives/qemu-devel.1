Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17860C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2D8F20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 14:41:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EmDhOjF3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2D8F20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUXLo-0001AC-Vk
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 09:41:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58399)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iUXKD-0000Ii-LK
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:39:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iUXKB-0005IM-OT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:39:20 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34754
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iUXKB-0005I1-L5
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 09:39:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573569559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tnhPRLPJ/5MrUb5GfbZcfW8Ek/saOTgyfSOq0d+rRSM=;
 b=EmDhOjF3xdTVQwDGKx76GXb3mtxEv2Zo0vHlo5OMt9WqDE7dUzqclHrnQiAEWjk6pOkBzJ
 NaBtSH5Zoxx+silx2JcC54W0n7bAKPJKwCfx9kOMn0SCeTCpwdmPh6Rv51tU8nAcZR+ikI
 6dETmj9Gvt6foOuq+l8z+zDQFGC9qtY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-m-8exEPtMt6WE6B7_oki3g-1; Tue, 12 Nov 2019 09:39:17 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 395F8108BD1B;
 Tue, 12 Nov 2019 14:39:16 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 865595DDAA;
 Tue, 12 Nov 2019 14:39:11 +0000 (UTC)
Date: Tue, 12 Nov 2019 15:39:10 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Shameer Kolothum <shameerali.kolothum.thodi@huawei.com>
Subject: Re: [PATCH 0/5] ARM virt: Add NVDIMM support
Message-ID: <20191112153910.435414be@redhat.com>
In-Reply-To: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
References: <20191004155302.4632-1-shameerali.kolothum.thodi@huawei.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: m-8exEPtMt6WE6B7_oki3g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: peter.maydell@linaro.org, shannon.zhaosl@gmail.com, qemu-devel@nongnu.org,
 xuwei5@hisilicon.com, linuxarm@huawei.com, eric.auger@redhat.com,
 qemu-arm@nongnu.org, lersek@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 4 Oct 2019 16:52:57 +0100
Shameer Kolothum <shameerali.kolothum.thodi@huawei.com> wrote:

> This series adds NVDIMM support to arm/virt platform.
> This has a dependency on [0] and make use of the GED
> device for NVDIMM hotplug events. The series reuses
> some of=C2=A0the=C2=A0patches posted by Eric in his earlier
> attempt here[1].
>=20
> Patch 1/5 is a fix to the Guest reboot issue on NVDIMM
> hot add case described here[2].
>=20
> I have done basic sanity testing of NVDIMM deviecs with
> both ACPI and DT Guest boot. Further testing is always
> welcome.
>=20
> Please let me know your feedback.
one more thing,

It's possible to run bios-tables-test for virt/arm now,
pls add corresponding test case
it might be easier to just extend test_acpi_virt_tcg_memhp() with nvdimms

>=20
> Thanks,
> Shameer
>=20
> [0] https://patchwork.kernel.org/cover/11150345/
> [1] https://patchwork.kernel.org/cover/10830777/
> [2] https://patchwork.kernel.org/patch/11154757/
>=20
> Eric Auger (1):
>   hw/arm/boot: Expose the pmem nodes in the DT
>=20
> Kwangwoo Lee (2):
>   nvdimm: Use configurable ACPI IO base and size
>   hw/arm/virt: Add nvdimm hot-plug infrastructure
>=20
> Shameer Kolothum (2):
>   hw/arm: Align ACPI blob len to PAGE size
>   hw/arm/virt: Add nvdimm hotplug support
>=20
>  docs/specs/acpi_hw_reduced_hotplug.rst |  1 +
>  hw/acpi/generic_event_device.c         | 13 ++++++++
>  hw/acpi/nvdimm.c                       | 32 ++++++++++++------
>  hw/arm/Kconfig                         |  1 +
>  hw/arm/boot.c                          | 45 ++++++++++++++++++++++++++
>  hw/arm/virt-acpi-build.c               | 20 ++++++++++++
>  hw/arm/virt.c                          | 42 ++++++++++++++++++++----
>  hw/i386/acpi-build.c                   |  6 ++++
>  hw/i386/acpi-build.h                   |  3 ++
>  hw/i386/pc_piix.c                      |  2 ++
>  hw/i386/pc_q35.c                       |  2 ++
>  hw/mem/Kconfig                         |  2 +-
>  include/hw/acpi/generic_event_device.h |  1 +
>  include/hw/arm/virt.h                  |  1 +
>  include/hw/mem/nvdimm.h                |  3 ++
>  15 files changed, 157 insertions(+), 17 deletions(-)
>=20


