Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5955AC35249
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28F3320661
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 09:34:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="GWfjsl8g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28F3320661
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izH59-0002Sa-7T
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 04:34:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3f-0000gp-KX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3e-0004wY-2U
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:19 -0500
Received: from mailout2.w1.samsung.com ([210.118.77.12]:41521)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1izH3d-0004S6-PV
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 04:33:17 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314euoutp02fc6dc6f16b800acda75ad85cdcdd7665~wd82-Psht1423114231euoutp02z
 for <qemu-devel@nongnu.org>; Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com
 20200205093314euoutp02fc6dc6f16b800acda75ad85cdcdd7665~wd82-Psht1423114231euoutp02z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580895194;
 bh=5mFOD1IZNL7/pLpY4OnCuWTrmXgD8GydlgVG5zxwGGA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=GWfjsl8gHHUgK72YTia5K2ZMrRPj5XcrLuW+EQnSrYgJ4yNilNko3wTonmfSYP/MX
 ReX048OlvzZReWHiGz6ot17VF+vUlzIhiaAAPRY2K1L+i9j3/vs36L8aee5WalNAkG
 Nrsyve4BKv/EsZK4n45Q/MK7eVEkQ0yK/Pzt6p2Y=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314eucas1p1869d124bc424f82ac200221f21fb12d4~wd82v5CWl3272532725eucas1p1Z;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
 eusmges2new.samsung.com (EUCPMTA) with SMTP id FB.39.60679.ADB8A3E5; Wed,  5
 Feb 2020 09:33:14 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200205093314eucas1p10c6fc436026bb6e30d78b1d729ffd4d4~wd82Zpplw3269932699eucas1p1Y;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
Received: from eusmgms2.samsung.com (unknown [182.198.249.180]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200205093314eusmtrp1ec4218069b2d35238ef20a4b577a58b3~wd82ZIQx41029010290eusmtrp1R;
 Wed,  5 Feb 2020 09:33:14 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-8e-5e3a8bda466a
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms2.samsung.com (EUCPMTA) with SMTP id 68.9A.07950.ADB8A3E5; Wed,  5
 Feb 2020 09:33:14 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200205093313eusmtip21c519e0caa1beae45f789c659ba88bfc~wd82GfX3p0077300773eusmtip2J;
 Wed,  5 Feb 2020 09:33:13 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 0/9] Add an interVM memory sharing device
Date: Wed,  5 Feb 2020 10:32:56 +0100
Message-Id: <1580895185-24341-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFIsWRmVeSWpSXmKPExsWy7djP87q3uq3iDLpOSFjsufCYzWL/tn+s
 FnPOPGCxON67g8WBxePOtT1sHk+ubWbyOPhuD5PH+31X2QJYorhsUlJzMstSi/TtErgytl/e
 w1qwQaHi6rF7LA2MW8S7GDk5JARMJDbO7WbvYuTiEBJYwSixfMlcVpCEkMAXRon+b3YQic+M
 Eu/2/WCE6fhzoBmqYzmjxP1PL6AcoI7mqffYQKrYBNQkdh75DNYhIiAp8bvrNDOIzSyQIfF8
 VjeYLSzgIHF1zy12EJtFQFXi8o/pLCA2r0CAxJmNf1kgtslJ3DzXyQyyQEJgB5vEnWUHoc5w
 kZi9aAKULSzx6vgWdghbRuL05B6o5nqJljs7mCCaOxgl+lZOZ4NIWEt82bAUqIgD6CJNifW7
 9CHCjhLvt4MczQFk80nceCsIcTOfxKRt05khwrwSHW1CENV6Et1PbjLBbF3W+IgFosRDonE3
 IyQQYyVmr93COIFRbhbCqgWMjKsYxVNLi3PTU4uN8lLL9YoTc4tL89L1kvNzNzECY/z0v+Nf
 djDu+pN0iFGAg1GJh3fFJMs4IdbEsuLK3EOMEhzMSiK85/WBQrwpiZVVqUX58UWlOanFhxil
 OViUxHmNF72MFRJITyxJzU5NLUgtgskycXBKNTBazJI/xzuvSjNU96yK05cwz2OfpG4FWphe
 q05av/OPWVZEiP6dwoDZO+N+7OP26rv91TL0g9+ERz/kLlr85ShL/Z0ezzDBWLvYtEv2993N
 K4TuT576Y8sfvR//HTpXG9z9ttIsXO7Cms1btRf8/Py0V/mnyRNePbvnZ2LuKfbOLZKyYJ6f
 fmaCEktxRqKhFnNRcSIAKMjqq+0CAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xe7q3uq3iDG4cZ7XYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbL+8h7Vgg0LF1WP3WBoYt4h3MXJy
 SAiYSPw50MzexcjFISSwlFHiy7PTrBAJGYkfp9ewQdjCEn+udbFBFH1ilNj36BtYgk1ATWLn
 kc+MILaIgKTE767TzCA2s0CWxM7Z95lAbGEBB4mre26xg9gsAqoSl39MZwGxeQUCJM5s/MsC
 sUBO4ua5TuYJjDwLGBlWMYqklhbnpucWG+kVJ+YWl+al6yXn525iBIbXtmM/t+xg7HoXfIhR
 gINRiYc3YIJlnBBrYllxZe4hRgkOZiUR3vP6QCHelMTKqtSi/Pii0pzU4kOMpkDLJzJLiSbn
 A0M/ryTe0NTQ3MLS0NzY3NjMQkmct0PgYIyQQHpiSWp2ampBahFMHxMHp1QDo/+HW91MR7nO
 rfbRUfS4+sVnofOZHyzl3LN/+3H+PraFabG43MGg4mqlMPWgPs2zhzfl/ud+PNvVc6+Do7VX
 i7NtyMnvzurzszsnGilsjTyuO41F9eGlkI3XHJ4oHpS/bfH3VfP/0M6nR+K8N87UXcdrei7L
 wuVFxMc4R1nfoGunAlpe23cqKLEUZyQaajEXFScCAMBUqK9FAgAA
X-CMS-MailID: 20200205093314eucas1p10c6fc436026bb6e30d78b1d729ffd4d4
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200205093314eucas1p10c6fc436026bb6e30d78b1d729ffd4d4
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200205093314eucas1p10c6fc436026bb6e30d78b1d729ffd4d4
References: <CGME20200205093314eucas1p10c6fc436026bb6e30d78b1d729ffd4d4@eucas1p1.samsung.com>
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
 Igor Kotrasinski <i.kotrasinsk@partner.samsung.com>, pbonzini@redhat.com
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


