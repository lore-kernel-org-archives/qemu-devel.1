Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A42CC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:37:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E6F022D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 16:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=temperror (0-bit key) header.d=greensocs.com header.i=@greensocs.com header.b="hk8pDHTK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E6F022D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=greensocs.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0TcS-0001tg-3o
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 12:37:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59113)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZM-0006Y3-Cl
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:34:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <damien.hedde@greensocs.com>) id 1i0TZK-0005La-Pu
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:34:44 -0400
Received: from beetle.greensocs.com ([5.135.226.135]:36314)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <damien.hedde@greensocs.com>)
 id 1i0TZK-0005Ju-9E
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 12:34:42 -0400
Received: from kouign-amann.bar.greensocs.com (unknown [172.16.11.117])
 by beetle.greensocs.com (Postfix) with ESMTPS id 1335B96F50;
 Wed, 21 Aug 2019 16:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com;
 s=mail; t=1566405279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WSZCf5q/9sv8cWAFzLb6DtBViG89QMisz/wUpvaIT9A=;
 b=hk8pDHTKOMmzHpCU5o8m0FBfd5QNbWdVL6dhxugGUUvV8y6hAylXHXa5nhuf1dJ/wmhjYM
 hOQADG3rgtaqJlCk2cG4v6DUyBI1G2kRy8Q/zShNYjhEYAB7GqUQRwqf54GjhfbPcy6W2x
 c4Q7b+B1lyC8eqVYzJne1cyhApl1Cwk=
From: Damien Hedde <damien.hedde@greensocs.com>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 18:33:31 +0200
Message-Id: <20190821163341.16309-1-damien.hedde@greensocs.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=greensocs.com; 
 s=mail; t=1566405279;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WSZCf5q/9sv8cWAFzLb6DtBViG89QMisz/wUpvaIT9A=;
 b=DqVDy2rX2YCErBPZo4TzigG3JumRncH1pFN+QWu6Og7J1IvmyYmipQxGgXUXRKMtO6AJMi
 T83z6MEhcxuQOAMBVeiV+ODc/Pqfy6HVEhrnC1vmcMSc3UlS4+zgWWL+xv0LbX28c+KCZd
 PuUR7zhv90IcEr0lQZQkGBgsrAIYLlk=
ARC-Seal: i=1; s=mail; d=greensocs.com; t=1566405279; a=rsa-sha256; cv=none;
 b=zfzBJT4XRePr+2eXJjPjSYVNOdbyLt5Vwcz7doKLUlfxEb4FTE78OgvhJS79c6oUc3g7lS
 XQDozTM3ysWOE8PjEjjGVVDImqxUcaFBqF4o6+tWaq/zHGw0nEY3PvI9XpGkDd+YtgmTOW
 8jG+JA7uvvu95R2OrWrCQPsCl4bb2SA=
ARC-Authentication-Results: i=1;
	beetle.greensocs.com;
	none
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.135.226.135
Subject: [Qemu-devel] [PATCH v4 00/10] Multi-phase reset mechanism
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
Cc: Damien Hedde <damien.hedde@greensocs.com>, peter.maydell@linaro.org,
 edgar.iglesias@xilinx.com, berrange@redhat.com, ehabkost@redhat.com,
 mark.burton@greensocs.com, pbonzini@redhat.com, philmd@redhat.com,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi all,

Here's the 4th version of the multi-phase reset proposal patches.
Previous version can be found here:
https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06365.html

The purpose of this series is to split the current reset procedure into
multiple phases. This will help to solve some ordering difficulties we ha=
ve
during reset. Please see patch 4 which adds documentation for more detail=
s.

Compared to previous version, I've reduced the scope of the series to
multi-phase basics. In particular, I've removed migration-related feature=
s
which can be added and discussed later when we've settled the api. I've a=
lso
not included the change to the new api for the ~20 impacted files because=
 it
highly depends on whether we handle cold vs warm reset difference or not.=
 I'll
handle them when we'll advance on this point.

I've isolated in patch 2 to 4, the multi-phase base mechanism handling on=
ly
cold reset as suggested by David.
Patches 5 and 6 do trivial modifications related to the registration of r=
eset
handler in the main system reset.
Patch 7 handles the hotplug device reset case.
These first 7 patches form a multi-phase basics independent subset; the f=
irst 6
do not modify the behavior. I'd really like to move forward on them as we=
 have
things depending on the basic multi-phase capability only (in particular =
the
clock-tree support).

Nevertheless I've kept in this series the addition of warm reset (in patc=
hes 8
to 10) so we can continue the discussion. Even if we don't introduce warm
reset, it allows discussion about multiple reset type support.
Maybe I should have put these 3 patches in their own (rfc ?) series, sinc=
e
there was lot of questioning about the warm reset and talking about handl=
ing
other resets like bus specific ones.

I've tested that the actual reset order was not modified by these patches=
 by
tracing calls to individual reset method after and before applying the se=
ries.


Changes v3 -> v4
general:
    + various comments and typos
patch 1: add device_legacy_reset function to prepare for reset api change
    + squash of 2 patches from v3 (asked by Peter and David)
patch 2: Create Resettable QOM interface
    + ResetType enum (only cold for now) (David and Philippe's remark)
    + ResetState to factorize most of the code (to address David's concer=
n)
    + all phases order is now children-to-parent (Peter's remark)
    + assert/deassert removed to isolate migration related features
patch 3: add Resettable interface in Bus and Device classes
    + squash of 2 patches (make Device and Bus Resettable & switch to
      resettable api) since patch 2 has reduced their size.
    + adaptation to patch 2 changes (warm reset, state and methods)
    + isolate hotplug reset change into patch 7 (Peter's remark)
    + fix qdev/qbus_reset_not doing a cold reset (Peter's remark)
    + call helper device_reset_cold instead of device_reset (David's rema=
rk)
patch 4: docs/devel/reset.txt: create doc about Resettable interface
    + various improvements
    + in this patch, doc is reduced to cold multi-phase reset with no "in=
 reset"
      state (other parts are kept for following commits)
patch 5: vl.c: replace deprecated qbus_reset_all registration
    + suggested comment improvement from Peter
patch 6: hw/s390x/ipl.c: replace deprecated qbus_reset_all registration
    + suggested comment improvement from Peter

Thanks for your feedback,
Damien

Damien Hedde (10):
  add device_legacy_reset function to prepare for reset api change
  hw/core: create Resettable QOM interface
  hw/core: add Resettable interface in Bus and Device classes
  docs/devel/reset.txt: create doc about Resettable interface
  vl.c: replace deprecated qbus_reset_all registration
  hw/s390x/ipl.c: replace deprecated qbus_reset_all registration
  hw/core/qdev: replace deprecated device_legacy_reset when hotplugging
    device
  hw/core/resettable: add support for warm reset
  hw/core/: add warm reset helpers for devices and buses
  docs/devel/reset.txt: add documentation about warm reset

 Makefile.objs            |   1 +
 docs/devel/reset.txt     | 284 +++++++++++++++++++++++++++++++++++++++
 hw/audio/intel-hda.c     |   2 +-
 hw/core/Makefile.objs    |   1 +
 hw/core/bus.c            |  64 +++++++++
 hw/core/qdev.c           |  86 +++++++++---
 hw/core/resettable.c     | 199 +++++++++++++++++++++++++++
 hw/core/trace-events     |  36 +++++
 hw/hyperv/hyperv.c       |   2 +-
 hw/i386/pc.c             |   2 +-
 hw/ide/microdrive.c      |   8 +-
 hw/intc/spapr_xive.c     |   2 +-
 hw/ppc/pnv_psi.c         |   2 +-
 hw/ppc/spapr_pci.c       |   2 +-
 hw/ppc/spapr_vio.c       |   2 +-
 hw/s390x/ipl.c           |  10 +-
 hw/s390x/s390-pci-inst.c |   2 +-
 hw/scsi/vmw_pvscsi.c     |   2 +-
 hw/sd/omap_mmc.c         |   2 +-
 hw/sd/pl181.c            |   2 +-
 include/hw/qdev-core.h   | 100 +++++++++++++-
 include/hw/resettable.h  | 171 +++++++++++++++++++++++
 tests/Makefile.include   |   1 +
 vl.c                     |  10 +-
 24 files changed, 949 insertions(+), 44 deletions(-)
 create mode 100644 docs/devel/reset.txt
 create mode 100644 hw/core/resettable.c
 create mode 100644 hw/core/trace-events
 create mode 100644 include/hw/resettable.h

--=20
2.22.0


