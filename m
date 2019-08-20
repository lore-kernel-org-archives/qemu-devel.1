Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE2FFC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEA7D205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEA7D205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39274 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06fp-0001zk-PU
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42116)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lvivier@redhat.com>) id 1i06eP-0000OP-6y
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lvivier@redhat.com>) id 1i06eN-0002Uo-Hx
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:06:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43850)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1i06eN-0002TN-Aq
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:06:23 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7B58B309B6C4;
 Tue, 20 Aug 2019 16:06:21 +0000 (UTC)
Received: from thinkpad.redhat.com (ovpn-117-179.ams2.redhat.com
 [10.36.117.179])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 52678859B7;
 Tue, 20 Aug 2019 16:06:16 +0000 (UTC)
From: Laurent Vivier <lvivier@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 18:06:12 +0200
Message-Id: <20190820160615.14616-1-lvivier@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Tue, 20 Aug 2019 16:06:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v8 0/3] rng-builtin: add an RNG backend that
 uses qemu_guest_getrandom()
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
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Kashyap Chamarthy <kchamart@redhat.com>, Amit Shah <amit@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a new RNG backend using QEMU builtin getrandom function.

v8: rebase on v4.1

v7: rebase on master
    Make rng-builtin asynchronous with QEMUBH (removed existing R-b)

v6: remove "sysemu/rng-random.h" from virtio-rng.c
    rebase on qemu_getrandom v8

v5: PATCH 1 s/linux/Linux/
    remove superfluous includes from rng-builtin.c
    don't update rng-random documentation
    add a patch from Markus to keep the default backend out of VirtIORNGC=
onf
    move TYPE_RNG_BUILTIN to sysemu/rng.h and remove sysemu/rng-builtin.h

v4: update PATCH 1 commit message

v3: Include Kashyap's patch in the series
    Add a patch to change virtio-rng default backend to rng-builtin

v2: Update qemu-options.hx
    describe the new backend and specify virtio-rng uses the
    rng-random by default

Laurent Vivier (2):
  rng-builtin: add an RNG backend that uses qemu_guest_getrandom()
  virtio-rng: change default backend to rng-builtin

Markus Armbruster (1):
  virtio-rng: Keep the default backend out of VirtIORNGConf

 backends/Makefile.objs         |  2 +-
 backends/rng-builtin.c         | 77 ++++++++++++++++++++++++++++++++++
 hw/virtio/virtio-rng.c         | 19 ++++-----
 include/hw/virtio/virtio-rng.h |  2 -
 include/sysemu/rng.h           |  2 +
 qemu-options.hx                |  7 ++++
 6 files changed, 95 insertions(+), 14 deletions(-)
 create mode 100644 backends/rng-builtin.c

--=20
2.21.0


