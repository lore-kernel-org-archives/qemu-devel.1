Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3542EC432C0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3C3920718
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 12:39:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JZWRmmn9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3C3920718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY8Dp-0006rG-TD
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 07:39:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47794)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1iY8Cw-0006LL-Af
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:38:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1iY8Cu-0004hy-LB
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:38:42 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:59672
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1iY8Cu-0004hq-Hc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 07:38:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574426319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v8kbnIGhU3HsAIJpxQQEEJBFVbTjly7MTqFexcfS0eU=;
 b=JZWRmmn9T8WiNZxWxgYkdu1/cfcHLwa59zO4GhXnesB0LzaNFiRlVfPEksDQKssHDVSX1C
 ZP0Kh5XXv3dOBkd4CGzUTjLtBcuejVHIyzrZrsA5xQ3tD7M0vcsfkXMBPnDzyuYPNvsltG
 4JxUsLbI3KYFcs8qPYpF2PYOqgN/S2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-hsb0_fosPr2YIW71yGJLGQ-1; Fri, 22 Nov 2019 07:38:36 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9456A107ACC4;
 Fri, 22 Nov 2019 12:38:34 +0000 (UTC)
Received: from localhost (unknown [10.43.2.114])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9191A7A5D2;
 Fri, 22 Nov 2019 12:38:28 +0000 (UTC)
Date: Fri, 22 Nov 2019 13:38:27 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: no-reply@patchew.org
Subject: Re: [PATCH v17 00/14] Build ACPI Heterogeneous Memory Attribute
 Table (HMAT)
Message-ID: <20191122133827.4f5ba34a@redhat.com>
In-Reply-To: <157441423058.7001.17579951694228090696@37313f22b938>
References: <20191122074826.1373-1-tao3.xu@intel.com>
 <157441423058.7001.17579951694228090696@37313f22b938>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: hsb0_fosPr2YIW71yGJLGQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: lvivier@redhat.com, thuth@redhat.com, ehabkost@redhat.com, mst@redhat.com,
 sw@weilnetz.de, tao3.xu@intel.com, fan.du@intel.com, qemu-devel@nongnu.org,
 armbru@redhat.com, jonathan.cameron@huawei.com, jingqi.liu@intel.com,
 mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 22 Nov 2019 01:17:12 -0800 (PST)
no-reply@patchew.org wrote:

> Patchew URL: https://patchew.org/QEMU/20191122074826.1373-1-tao3.xu@intel=
.com/
>=20
do not ignore warnings "line over 80 characters",
just fix them

>=20
> Hi,
>=20
> This series seems to have some coding style problems. See output below fo=
r
> more information:
>=20
> Subject: [PATCH v17 00/14] Build ACPI Heterogeneous Memory Attribute Tabl=
e (HMAT)
> Type: series
> Message-id: 20191122074826.1373-1-tao3.xu@intel.com
>=20
> =3D=3D=3D TEST SCRIPT BEGIN =3D=3D=3D
> #!/bin/bash
> git rev-parse base > /dev/null || exit 0
> git config --local diff.renamelimit 0
> git config --local diff.renames True
> git config --local diff.algorithm histogram
> ./scripts/checkpatch.pl --mailback base..
> =3D=3D=3D TEST SCRIPT END =3D=3D=3D
>=20
> Updating 3c8cf5a9c21ff8782164d1def7f44bd888713384
> From https://github.com/patchew-project/qemu
>  - [tag update]      patchew/20191121000843.24844-1-beata.michalska@linar=
o.org -> patchew/20191121000843.24844-1-beata.michalska@linaro.org
>  - [tag update]      patchew/20191122080039.12771-1-armbru@redhat.com -> =
patchew/20191122080039.12771-1-armbru@redhat.com
> Switched to a new branch 'test'
> 9192aa6 tests/bios-tables-test: add test cases for ACPI HMAT
> 309fd85 tests/numa: Add case for QMP build HMAT
> 864da49 hmat acpi: Build Memory Side Cache Information Structure(s)
> 6d92931 hmat acpi: Build System Locality Latency and Bandwidth Informatio=
n Structure(s)
> 39ba308 hmat acpi: Build Memory Proximity Domain Attributes Structure(s)
> 7d0bffc numa: Extend CLI to provide memory side cache information
> 3fc8a54 numa: Extend CLI to provide memory latency and bandwidth informat=
ion
> 592a96a numa: Extend CLI to provide initiator information for numa nodes
> 7032fc4 tests: Add test for QAPI builtin type time
> 2d89c93 qapi: Add builtin type time
> dbe82f5 util/cutils: Add qemu_strtotime_ns()
> 2fef66f util/cutils: refactor do_strtosz() to support suffixes list
> 2cae457 util/cutils: Use qemu_strtold_finite to parse size
> a691b5f util/cutils: Add Add qemu_strtold and qemu_strtold_finite
>=20
> =3D=3D=3D OUTPUT BEGIN =3D=3D=3D
> 1/14 Checking commit a691b5f92191 (util/cutils: Add Add qemu_strtold and =
qemu_strtold_finite)
> ERROR: consider using qemu_strtold in preference to strtold
> #61: FILE: util/cutils.c:636:
> +    *result =3D strtold(nptr, &ep);
>=20
> total: 1 errors, 0 warnings, 69 lines checked
>=20
> Patch 1/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
>=20
> 2/14 Checking commit 2cae457669b9 (util/cutils: Use qemu_strtold_finite t=
o parse size)
> 3/14 Checking commit 2fef66fd2a82 (util/cutils: refactor do_strtosz() to =
support suffixes list)
> 4/14 Checking commit dbe82f50cf86 (util/cutils: Add qemu_strtotime_ns())
> 5/14 Checking commit 2d89c9350115 (qapi: Add builtin type time)
> 6/14 Checking commit 7032fc4756a0 (tests: Add test for QAPI builtin type =
time)
> 7/14 Checking commit 592a96a0ff21 (numa: Extend CLI to provide initiator =
information for numa nodes)
> 8/14 Checking commit 3fc8a542a4b7 (numa: Extend CLI to provide memory lat=
ency and bandwidth information)
> WARNING: line over 80 characters
> #130: FILE: hw/core/numa.c:299:
> +            /* Set lb_info_provided bit 0 as 1, latency information is p=
rovided */
>=20
> total: 0 errors, 1 warnings, 462 lines checked
>=20
> Patch 8/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 9/14 Checking commit 7d0bffca6382 (numa: Extend CLI to provide memory sid=
e cache information)
> 10/14 Checking commit 39ba308b5612 (hmat acpi: Build Memory Proximity Dom=
ain Attributes Structure(s))
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #72:=20
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 185 lines checked
>=20
> Patch 10/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 11/14 Checking commit 6d92931a0a40 (hmat acpi: Build System Locality Late=
ncy and Bandwidth Information Structure(s))
> 12/14 Checking commit 864da49c0ce4 (hmat acpi: Build Memory Side Cache In=
formation Structure(s))
> 13/14 Checking commit 309fd85d39fc (tests/numa: Add case for QMP build HM=
AT)
> WARNING: line over 80 characters
> #124: FILE: tests/numa-test.c:433:
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
>=20
> WARNING: line over 80 characters
> #159: FILE: tests/numa-test.c:468:
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
>=20
> WARNING: line over 80 characters
> #206: FILE: tests/numa-test.c:515:
> +    g_assert(!qmp_rsp_is_err(qtest_qmp(qs, "{ 'execute': 'x-exit-preconf=
ig' }")));
>=20
> total: 0 errors, 3 warnings, 206 lines checked
>=20
> Patch 13/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> 14/14 Checking commit 9192aa6b273f (tests/bios-tables-test: add test case=
s for ACPI HMAT)
> WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> #106:=20
> new file mode 100644
>=20
> total: 0 errors, 1 warnings, 65 lines checked
>=20
> Patch 14/14 has style problems, please review.  If any of these errors
> are false positives report them to the maintainer, see
> CHECKPATCH in MAINTAINERS.
> =3D=3D=3D OUTPUT END =3D=3D=3D
>=20
> Test command exited with code: 1
>=20
>=20
> The full log is available at
> http://patchew.org/logs/20191122074826.1373-1-tao3.xu@intel.com/testing.c=
heckpatch/?type=3Dmessage.
> ---
> Email generated automatically by Patchew [https://patchew.org/].
> Please send your feedback to patchew-devel@redhat.com


