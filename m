Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A94AC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:53:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56EB521882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 17:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56EB521882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS31e-0006Ri-7A
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 12:53:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47156)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iS2yb-0002M8-JU
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iS2ya-0004XO-IB
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 12:50:45 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:46591)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iS2ya-0004Wq-8i; Tue, 05 Nov 2019 12:50:44 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MdeOl-1hsREj3xdx-00Zj7B; Tue, 05 Nov 2019 18:50:21 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL v2 0/3] Trivial branch patches
Date: Tue,  5 Nov 2019 18:50:07 +0100
Message-Id: <20191105175010.2591-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bVlXh+qfacMYAJz0JYhOyV/CyLXAoaePIt05Vn/XxD8LtGnM1tr
 GXXn06EiHaloQjwhDdOWzFLEfaOUmFNry8lZMGSIvXXQY/AvH/MOpXkIPZTpoD8ZWKbZoPT
 AlrpUTkZ2yTxn/w8RnJof5KISGUZwN8ctqeco5tBWFnYqxWmaut/OixibWFpfqCzugpOgUN
 AYjerAX25MByQ9tiRIp9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FDAFY9f0SXI=:JhUvsvMKENvKfD/dRw9zBJ
 ttvXeWgWtQ0G3bGac4B0To/qcFALz5sKpcxEWnHS29A6okPGDzapmAd/IShQY40J0eMEICMdY
 Hhzf9Hv/Ar5WdBr4nPDRIaV4oXFzDj11D1kGeinxlLF8ATqRqqqj74PKDOkRlbxpWtHB/ZkT9
 h0l6BM+7TbeMhlPykRA9n7cBN85XmNhUbItIeBUQ1dBxKHb3PXojjC/5Nd52kLo3cuiDG+qwW
 i0yUuL0LyLSmCVL1Phv2oJWmDkJmYpOd30QrCrLfBegwku/pYcPkGVmvOlQoDqtCBTPuH2Vdc
 avbzYzExQuGDPlqelThcukrRhp1Lf7nRAJ5I397SctfYy90gJ/+JtN/O6rICOOJFxv4Mw0t/w
 /IYZBfO+J9luFhU349T/KwemXsHRilcrTAi4HuXIZSPY9DRifvYs5MC3XQ3HPhYW+mBNYHSz7
 b12PjhLdPJNuVEX1fvuYCi4H4YTsGEJGrMEfqrcuceKOfKtcORLa2YXltU2buGnPX1TSj2ucy
 JByAjDcbOJWiOpjuMwC4M7q6e6pOvehyJnKnkwno1Kg7d4layedaxjcKRBM7WnF12bGxHRVmW
 1dCHl+goyPjFvWKp85s5wItlIJgeQkPL54xcsKV8kS8cH9i2eZoaoFqzXiy5xgYvi7/4Mir35
 Cd0FJuQPGz6Q0Ec0lmnPkQPoR1+oJr+MMbGx9QNhuDXOzk1W1sXb8XaZrGceyWRfIktYY0mTx
 IKPhbskzE9rR0Rh/mSIF+t6LfpMcmBLSxazfbvNWxQk7F65vUHflTE5Za7e5hoaUV+g2YTSwD
 nyT5Pf5CoiVM0EwhDU/DfgpcBn2lUtSjaRXZyY/LGv71R2E2jhgL/AnOkDtII8BQd5A6X1oS2
 Nm4tEFD373kW4k8ERvB9jzTREmeslEmIZmwsqqXr0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 217.72.192.73
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Paul Durrant <paul@xen.org>,
 qemu-trivial@nongnu.org, Claudio Fontana <claudio.fontana@huawei.com>,
 Cleber Rosa <crosa@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 36609b4fa36f0ac934874371874416f7533a5408:

  Merge remote-tracking branch 'remotes/palmer/tags/palmer-for-master-4.2-sf1' into staging (2019-11-02 17:59:03 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to e187e55ec65039ed6bd982debee632450ace3bae:

  global: Squash 'the the' (2019-11-05 18:39:14 +0100)

----------------------------------------------------------------
Trivial fixes (20191105-v2)

----------------------------------------------------------------

Dr. David Alan Gilbert (1):
  global: Squash 'the the'

Philippe Mathieu-Daudé (2):
  hw/misc/grlib_ahb_apb_pnp: Avoid crash when writing to PnP registers
  hw/misc/grlib_ahb_apb_pnp: Fix 8-bit accesses

 disas/libvixl/vixl/invalset.h       |  2 +-
 docs/interop/pr-helper.rst          |  2 +-
 docs/specs/ppc-spapr-hotplug.txt    |  2 +-
 docs/specs/ppc-xive.rst             |  2 +-
 docs/specs/tpm.txt                  |  2 +-
 hw/misc/grlib_ahb_apb_pnp.c         | 12 ++++++++++++
 include/hw/xen/interface/io/blkif.h |  2 +-
 scripts/dump-guest-memory.py        |  2 +-
 8 files changed, 19 insertions(+), 7 deletions(-)

-- 
v2: remove patch from Greg that has lines with more than 80 columns
2.21.0


