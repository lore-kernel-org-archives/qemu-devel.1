Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0B39C352A1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EB482072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 13:30:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="K5jcGBSx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EB482072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izKkn-00012v-Qo
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 08:30:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36808)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjZ-0007kP-Rf
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004rm-FX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:49 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:50225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izKjX-0004cG-8Z
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 08:28:47 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205132843euoutp0269cdc53e78195e868fc12ef1e2717ccf~whKdVPMcz0780307803euoutp02I
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205132843euoutp0269cdc53e78195e868fc12ef1e2717ccf~whKdVPMcz0780307803euoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580909323;
 bh=VYr99tyFZEWAYBKH3h0koobEg2QlKohc8cZHhaNRbCs=;
 h=From:To:Cc:Subject:Date:References:From;
 b=K5jcGBSxQkTfhn5BZ9dikFlc1f03q6nz4NPn47H8OfHmlKAxS7KSpGeFALRGXySu1
 73IykNYnhfMrAanPn1e1QSpWiOCFpDhaX5gaYlPBIJdhJnC8vomFOMfAOhQx/3iJxW
 vCYDsd9eyMsH8ZIO4YNAo8XEAQEkn4f6cI+QLFcs=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205132843eucas1p1c820bded638f3f7c1be0cd5a2b9b6294~whKdHuWIH2962029620eucas1p1h;
 Wed,  5 Feb 2020 13:28:43 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id 56.1E.61286.B03CA3E5; Wed,  5
 Feb 2020 13:28:43 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
 eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132842eucas1p2152831620dc94c77dbccb6a371079e49~whKc4khXE0489104891eucas1p2C;
 Wed,  5 Feb 2020 13:28:42 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
 20200205132842eusmtrp2a4f67dd24144115c670e83a01ee2ed60~whKc38uo42992629926eusmtrp2i;
 Wed,  5 Feb 2020 13:28:42 +0000 (GMT)
X-AuditID: cbfec7f2-f0bff7000001ef66-9d-5e3ac30b0adf
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 61.00.08375.A03CA3E5; Wed,  5
 Feb 2020 13:28:42 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205132842eusmtip2f98dc4e797c6029375d3fa2ab325b5d0~whKcepkKW3192731927eusmtip2W;
 Wed,  5 Feb 2020 13:28:42 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 0/9] Add an interVM memory sharing device
Date: Wed,  5 Feb 2020 14:28:28 +0100
Message-Id: <1580909317-23884-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrMIsWRmVeSWpSXmKPExsWy7djP87rch63iDB6v5bbYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRXDYpqTmZ
 ZalF+nYJXBkn515nLnigUHGx4wN7A+NV8S5GDg4JAROJeU3ZXYxcHEICKxgl/i5awgzhfGGU
 mL58NTuE85lRYu/ZJUAOJ1jHnQlnmUBsIYHljBLPZtbAdcxec4gZJMEmoCax88hnRhBbREBS
 4nfXabCxzAINjBKPrp8FSwgLOEjcPLyZFcRmEVCVeLX2B5jNKxAgsX9lByvENjmJm+c6wZol
 BI6wSRzsuscMcbiLxK5uc4gaYYlXx7dAXScj8X/nfCYIu16i5c4OJojeDkaJvpXT2SAS1hJf
 NixlAZnDLKApsX6XPkTYUeLC83Y2iPF8EjfeCoKEmYHMSdumQ23llehoE4Ko1pPofnKTCWbr
 ssZHLBAlHhJ725MgwRMrMW3jAqYJjHKzEFYtYGRcxSieWlqcm55abJiXWq5XnJhbXJqXrpec
 n7uJERj1p/8d/7SD8eulpEOMAhyMSjy8KyZZxgmxJpYVV+YeYpTgYFYS4T2vDxTiTUmsrEot
 yo8vKs1JLT7EKM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qB0btwltDvE77y4eKbyv/J
 Ny+xUJt+5fXeM+VyjvW9r5tOLV/6xUSNaTn7UY9T0bN3Hjp59M1P++e3dY5J5Dwy4nju5SG6
 4t6rqU++r1CaZnfz0XUG1UtfMg+9FWzSOv+nmbk2/qLH96Mr3xu5S3WWpqzUmHdJZNmaksPs
 77wzn00xj5fIunheuFiJpTgj0VCLuag4EQAdlya09gIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsVy+t/xe7pch63iDB4eM7bYc+Exm8W9mzeZ
 LfZv+8dqMefMAxaL4707WBxYPe5c28Pm8eTaZiaPg+/2MHm833eVzWP7yUlMAaxRejZF+aUl
 qQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6djYpqTmZZalF+nYJehkn515nLnigUHGx
 4wN7A+NV8S5GTg4JAROJOxPOMoHYQgJLGSVePfeGiMtI/Di9hg3CFpb4c60LyOYCqvnEKNF3
 /ysLSIJNQE1i55HPjCC2iICkxO+u08wgRcwCLYwSz560g00VFnCQuHl4MyuIzSKgKvFq7Q8w
 m1cgQGL/yg5WiA1yEjfPdTJPYORZwMiwilEktbQ4Nz232FCvODG3uDQvXS85P3cTIzDkth37
 uXkH46WNwYcYBTgYlXh4V0yyjBNiTSwrrsw9xCjBwawkwnteHyjEm5JYWZValB9fVJqTWnyI
 0RRo+URmKdHkfGA85JXEG5oamltYGpobmxubWSiJ83YIHIwREkhPLEnNTk0tSC2C6WPi4JRq
 YLRvWZk9V7zuyI/SyT8mXW569On+oeDVp9RvyGtGCUe0Szns+vQvR8X9T3j6rVLxnAOTWY7n
 P0gsd5x6peH15AKr+kuZAcvSQqefOvYgOKXs6fWlhgqBC99FcibkbFS4IOTRNm3uL503e7jr
 LgcZBM1w/V8YVrCAw9rYdEpIRATTdcf8Bw7/Y5RYijMSDbWYi4oTAbA7pf5PAgAA
X-CMS-MailID: 20200205132842eucas1p2152831620dc94c77dbccb6a371079e49
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205132842eucas1p2152831620dc94c77dbccb6a371079e49
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205132842eucas1p2152831620dc94c77dbccb6a371079e49
References: <CGME20200205132842eucas1p2152831620dc94c77dbccb6a371079e49@eucas1p2.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.12
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
Cc: peter.maydell@linaro.org,
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, jan.kiszka@siemens.com,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>

This patchset adds a "memory exposing" device that allows two QEMU
instances to share arbitrary memory regions. Unlike ivshmem, it does not
create a new region of memory that's shared between VMs, but instead
allows one VM to access any memory region of the other VM we choose to
share.

The motivation for this device is a sort of ARM Trustzone "emulation",
where a rich system running on one machine (e.g. x86_64 linux) is able
to perform SMCs to a trusted system running on another (e.g. OpTEE on
ARM). With a device that allows sharing arbitrary memory between VMs,
this can be achieved with minimal changes to the trusted system and its
linux driver while allowing the rich system to run on a speedier x86
emulator. I prepared additional patches for linux, OpTEE OS and OpTEE
build system as a PoC that such emulation works and passes OpTEE tests;
I'm not sure what would be the best way to share them.

This patchset is my first foray into QEMU source code and I'm certain
it's not yet ready to be merged in. I'm not sure whether memory sharing
code has any race conditions or breaks rules of working with memory
regions, or if having VMs communicate synchronously via chardevs is the
right way to do it. I do believe the basic idea for sharing memory
regions is sound and that it could be useful for inter-VM communication.

Changes in v3:
- Fixed CI build for good.

Changes in v2:
- Fixed patchew errors.
- Rebased on master.


Igor Kotrasinski (9):
  memory: Add function for finding flat memory ranges
  memory: Support mmap offset for fd-backed memory regions
  memory: Hack - use shared memory when possible
  hw/misc/memexpose: Add documentation
  hw/misc/memexpose: Add core memexpose files
  hw/misc/memexpose: Add memexpose pci device
  hw/misc/memexpose: Add memexpose memory region device
  hw/misc/memexpose: Add simple tests
  hw/arm/virt: Hack in support for memexpose device

 Kconfig.host                            |   3 +
 MAINTAINERS                             |  13 +
 Makefile                                |   1 +
 backends/hostmem-memfd.c                |   2 +-
 configure                               |   8 +
 docs/specs/memexpose-spec.txt           | 168 +++++++++
 exec.c                                  |  10 +-
 hw/arm/virt.c                           | 110 +++++-
 hw/core/numa.c                          |   4 +-
 hw/mem/Kconfig                          |   3 +
 hw/misc/Makefile.objs                   |   1 +
 hw/misc/ivshmem.c                       |   3 +-
 hw/misc/memexpose/Makefile.objs         |   4 +
 hw/misc/memexpose/memexpose-core.c      | 630 ++++++++++++++++++++++++++++++++
 hw/misc/memexpose/memexpose-core.h      | 109 ++++++
 hw/misc/memexpose/memexpose-memregion.c | 142 +++++++
 hw/misc/memexpose/memexpose-memregion.h |  41 +++
 hw/misc/memexpose/memexpose-msg.c       | 261 +++++++++++++
 hw/misc/memexpose/memexpose-msg.h       | 161 ++++++++
 hw/misc/memexpose/memexpose-pci.c       | 218 +++++++++++
 include/exec/memory.h                   |  21 ++
 include/exec/ram_addr.h                 |   2 +-
 include/hw/arm/virt.h                   |   5 +
 include/qemu/mmap-alloc.h               |   1 +
 memory.c                                |  82 ++++-
 tests/qtest/Makefile.include            |   2 +
 tests/qtest/memexpose-test.c            | 364 ++++++++++++++++++
 util/mmap-alloc.c                       |   7 +-
 util/oslib-posix.c                      |   2 +-
 29 files changed, 2362 insertions(+), 16 deletions(-)
 create mode 100644 docs/specs/memexpose-spec.txt
 create mode 100644 hw/misc/memexpose/Makefile.objs
 create mode 100644 hw/misc/memexpose/memexpose-core.c
 create mode 100644 hw/misc/memexpose/memexpose-core.h
 create mode 100644 hw/misc/memexpose/memexpose-memregion.c
 create mode 100644 hw/misc/memexpose/memexpose-memregion.h
 create mode 100644 hw/misc/memexpose/memexpose-msg.c
 create mode 100644 hw/misc/memexpose/memexpose-msg.h
 create mode 100644 hw/misc/memexpose/memexpose-pci.c
 create mode 100644 tests/qtest/memexpose-test.c

-- 
2.7.4


