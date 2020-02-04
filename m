Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74C76C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4556420674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 11:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VzAumLsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4556420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=partner.samsung.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iywT1-0004bN-EW
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 06:34:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQH-0008KR-MZ
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQA-0008W5-OD
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:17 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:47524)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <i.kotrasinsk@partner.samsung.com>)
 id 1iywQ8-0008Hz-U3
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 06:31:09 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20200204113103euoutp01c861955742a832b66d75d852a2439a4c~wL6btPQxh1728417284euoutp01S
 for <qemu-devel@nongnu.org>; Tue,  4 Feb 2020 11:31:03 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20200204113103euoutp01c861955742a832b66d75d852a2439a4c~wL6btPQxh1728417284euoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1580815863;
 bh=hTzS/RN98i5l6EEVjpih9xHmPAfJ8QHKT3vnAoLR594=;
 h=From:To:Cc:Subject:Date:References:From;
 b=VzAumLsUQcEDkkWigOj2ma1sWzF63qTZuUgOGMCUumz5qao4SUbeqqgYyOOCJEaVz
 D8YAGzFush/95fMeyFBxL4a+5Ou2fP8kOGxI3iNcLKKceVFkBipBt3DXBo0FAWZpa3
 avGkO+qzTeLoDD6ioNn8aKqWr4QFljq3iDuE72uw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTP id
 20200204113102eucas1p1fe984246d84c9358c4c7e6d8abfd5dfb~wL6bUAA8b1663216632eucas1p1I;
 Tue,  4 Feb 2020 11:31:02 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
 eusmges1new.samsung.com (EUCPMTA) with SMTP id BB.FE.61286.6F5593E5; Tue,  4
 Feb 2020 11:31:02 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a~wL6a4w4j91661016610eucas1p1F;
 Tue,  4 Feb 2020 11:31:02 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
 eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
 20200204113102eusmtrp17ddf958e8176f3a65388f310efcf7ae1~wL6a4IXVh2102721027eusmtrp1o;
 Tue,  4 Feb 2020 11:31:02 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-7a-5e3955f61ccd
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
 eusmgms1.samsung.com (EUCPMTA) with SMTP id 84.AC.08375.6F5593E5; Tue,  4
 Feb 2020 11:31:02 +0000 (GMT)
Received: from AMDC3304.digital.local (unknown [106.120.51.21]) by
 eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
 20200204113101eusmtip2eebe236dfe355e56454d9b50613d0a24~wL6aikNZT1903619036eusmtip2O;
 Tue,  4 Feb 2020 11:31:01 +0000 (GMT)
From: i.kotrasinsk@partner.samsung.com
To: qemu-devel@nongnu.org
Subject: [RFC 0/9] Add an interVM memory sharing device
Date: Tue,  4 Feb 2020 12:30:42 +0100
Message-Id: <1580815851-28887-1-git-send-email-i.kotrasinsk@partner.samsung.com>
X-Mailer: git-send-email 2.7.4
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrDIsWRmVeSWpSXmKPExsWy7djPc7rfQi3jDE4u1LXYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwRHHZpKTmZJalFunbJXBlbJ+8
 kaXgnXzF7YWL2RoYm8S7GDk5JARMJLbu2M7SxcjFISSwglFiycP7rBDOF0aJ/ce+Q2U+M0rc
 3XuBEabl2/X1UFXLGSX+nl7ABNfyeNZmJpAqNgE1iZ1HPoN1iAhISvzuOs0MYjMLZEg8n9UN
 ZgsLmEusWNPFBmKzCKhKdL6Zzwpi8woESFy4fZkVYpucxM1zncwgCyQEdrBJ3Hi6CCrhIvF1
 2UN2CFtY4tXxLVC2jMTpyT0sEHa9RMudHUwQzR2MEn0rp7NBJKwlvmxYClTEAXSRpsT6XfoQ
 YUeJK3eamEHCEgJ8EjfeCkLczCcxadt0qDCvREebEES1nkT3k5tMMFuXNT6C2uoh0T5hI9iV
 QgKxEl3PLjNNYJSbhbBrASPjKkbx1NLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMA4P/3v+Kcd
 jF8vJR1iFOBgVOLhvWBnESfEmlhWXJl7iFGCg1lJhPe8vmWcEG9KYmVValF+fFFpTmrxIUZp
 DhYlcV7jRS9jhQTSE0tSs1NTC1KLYLJMHJxSDYwmsvX71M6xS/9Z0raWIcZ2V7n+M+cHMyW3
 7GZ0lP6y5HHqNPM9k6ey/ap9cGUzX13d3kDWI52LbhuxiM5/ueCxQfqtKW8mmX41uj2f+bj+
 S1X/XqkF81zffgiVDJ5ucubc/nNGG19mfnA1uflq2dPebaYLTLWObpp1bv+O9sQ9IstfHTt2
 IpM3SImlOCPRUIu5qDgRAL/mJt3vAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrELMWRmVeSWpSXmKPExsVy+t/xe7rfQi3jDKYs5rPYc+Exm8X+bf9Y
 LeacecBicbx3B4sDi8eda3vYPJ5c28zkcfDdHiaP9/uusgWwROnZFOWXlqQqZOQXl9gqRRta
 GOkZWlroGZlY6hkam8daGZkq6dvZpKTmZJalFunbJehlbJ+8kaXgnXzF7YWL2RoYm8S7GDk5
 JARMJL5dX8/axcjFISSwlFHi5a/dTBAJGYkfp9ewQdjCEn+udbFBFH1ilHj3+QwzSIJNQE1i
 55HPjCC2iICkxO+u02BxZoEsiZ2z74MNEhYwl1ixpgtsEIuAqkTnm/msIDavQIDEhduXWSEW
 yEncPNfJPIGRZwEjwypGkdTS4tz03GJDveLE3OLSvHS95PzcTYzA8Np27OfmHYyXNgYfYhTg
 YFTi4b1gZxEnxJpYVlyZe4hRgoNZSYT3vL5lnBBvSmJlVWpRfnxRaU5q8SFGU6DlE5mlRJPz
 gaGfVxJvaGpobmFpaG5sbmxmoSTO2yFwMEZIID2xJDU7NbUgtQimj4mDU6qBkSdokjPrer8n
 G7Jz7Kxd7RZt2mazxyDCO7swrmHrywVy22fOirJ5uEZBWprNtCihvlyaof+aafXm3ZsOrMv6
 2vJ1+Zl9caGZ6/ZvWXhQ3+2QcpjZumS+X38lY055z/gQq3Cl+Ebz4vik7K3TEu/MdHV69yv4
 YI39kQMPGPJ7Ita8yuoOlftWp8RSnJFoqMVcVJwIAPenfE1FAgAA
X-CMS-MailID: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a
References: <CGME20200204113102eucas1p172cfb883c70cfc8d7c2832682df3df2a@eucas1p1.samsung.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 210.118.77.11
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
 MAINTAINERS                             |  12 +
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
 include/exec/memory.h                   |  20 +
 include/exec/ram_addr.h                 |   2 +-
 include/hw/arm/virt.h                   |   5 +
 include/qemu/mmap-alloc.h               |   1 +
 memory.c                                |  82 ++++-
 tests/qtest/Makefile.include            |   2 +
 tests/qtest/memexpose-test.c            | 364 ++++++++++++++++++
 util/mmap-alloc.c                       |   7 +-
 util/oslib-posix.c                      |   2 +-
 29 files changed, 2360 insertions(+), 16 deletions(-)
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


