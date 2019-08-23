Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82319C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:58:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58CB220870
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:58:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58CB220870
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1B1X-0002A5-19
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:58:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52170)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <eblake@redhat.com>) id 1i1AkS-0007wy-98
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <eblake@redhat.com>) id 1i1AkQ-0008Ej-09
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:41:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <eblake@redhat.com>)
 id 1i1AkM-00089t-8P; Fri, 23 Aug 2019 10:40:58 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A874310C0217;
 Fri, 23 Aug 2019 14:40:57 +0000 (UTC)
Received: from blue.redhat.com (ovpn-116-234.phx2.redhat.com [10.3.116.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4853860126;
 Fri, 23 Aug 2019 14:40:55 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: libguestfs@redhat.com
Date: Fri, 23 Aug 2019 09:40:51 -0500
Message-Id: <20190823144054.27420-1-eblake@redhat.com>
In-Reply-To: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
References: <25ead363-4f37-5450-b985-1876374e314d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.65]); Fri, 23 Aug 2019 14:40:57 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [nbdkit PATCH 0/3] nbdkit support for new NBD fast zero
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
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, nbd@other.debian.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

See the cross-post cover letter for details:
https://www.redhat.com/archives/libguestfs/2019-August/msg00322.html

Notably, this series did NOT add fast zero support to the file plugin
yet; there, I probably need to do more testing and/or kernel source
code reading to learn whether to mark fallocate() as potentially slow,
as well as to definitely mark ioctl(BLKZEROOUT) as definitely slow.
That will be a followup patch.

Eric Blake (3):
  server: Add internal support for NBDKIT_FLAG_FAST_ZERO
  filters: Add .can_fast_zero hook
  plugins: Add .can_fast_zero hook

 docs/nbdkit-filter.pod                  |  27 ++++--
 docs/nbdkit-plugin.pod                  |  74 +++++++++++---
 docs/nbdkit-protocol.pod                |  11 +++
 filters/delay/nbdkit-delay-filter.pod   |  15 ++-
 filters/log/nbdkit-log-filter.pod       |   2 +-
 filters/nozero/nbdkit-nozero-filter.pod |  41 ++++++--
 plugins/sh/nbdkit-sh-plugin.pod         |  13 ++-
 server/internal.h                       |   2 +
 common/protocol/protocol.h              |  11 ++-
 server/filters.c                        |  33 ++++++-
 server/plugins.c                        |  47 ++++++++-
 server/protocol-handshake.c             |   7 ++
 server/protocol.c                       |  46 +++++++--
 include/nbdkit-common.h                 |   7 +-
 include/nbdkit-filter.h                 |   3 +
 include/nbdkit-plugin.h                 |   2 +
 filters/blocksize/blocksize.c           |  12 +++
 filters/cache/cache.c                   |  20 ++++
 filters/cow/cow.c                       |  20 ++++
 filters/delay/delay.c                   |  28 +++++-
 filters/log/log.c                       |  16 ++--
 filters/nozero/nozero.c                 |  62 +++++++++++-
 filters/truncate/truncate.c             |  15 +++
 plugins/data/data.c                     |  14 ++-
 plugins/full/full.c                     |  12 +--
 plugins/memory/memory.c                 |  14 ++-
 plugins/nbd/nbd.c                       |  28 +++++-
 plugins/null/null.c                     |   8 ++
 plugins/ocaml/ocaml.c                   |  26 ++++-
 plugins/sh/call.c                       |   1 -
 plugins/sh/sh.c                         |  39 ++++++--
 plugins/ocaml/NBDKit.ml                 |  10 +-
 plugins/ocaml/NBDKit.mli                |   2 +
 plugins/rust/src/lib.rs                 |   3 +
 tests/test-eflags.sh                    | 122 +++++++++++++++++++++---
 tests/test-fua.sh                       |   4 +-
 36 files changed, 686 insertions(+), 111 deletions(-)

--=20
2.21.0


