Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64742C3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:02:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35B21208C0
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 14:02:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35B21208C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAx0W-0002aj-5F
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 10:02:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51755)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAwx3-0007Qj-O4
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAwtX-0003h7-KK
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 09:54:52 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:47997)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAwtW-0003fw-A2; Thu, 19 Sep 2019 09:54:50 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MWBC8-1ihVjo1xVK-00Xdgp; Thu, 19 Sep 2019 15:54:46 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu, 19 Sep 2019 15:54:35 +0200
Message-Id: <20190919135443.15164-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:qT9jtAZuYABIbTuHOgQwUSlVHJq8uvu7QXs+09cW7dtpCV17uxv
 7wQ12Sim5YYRTgrn8KZILG8NVWEGw6+JxxlfdEqcDl9+AGfktFvZU7+UXSJMfgZjHRW/pg+
 a9np0kvJk6xGLhLFpgrDFX13fZGTIJExshtvAPJUk8WdumYmf7R9CAfLqWacJAuIhboA3bL
 d1vXmSAK92wfdPWJckvnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jhnjZvyvdjU=:Q1z8sSARPwxWwfXXZspSIO
 CgJ8HetCaa1yNQsTnFMqHclGoO55k5eya+rcmu7lx08eXS9CMmbkPZU6ih/MjCNdFyRTH1m59
 cZsJQ3fDon1pVTjkjTG1G1oYsgqrkhwzi/v2B1Y03w0b2wJ+2SLWZPZStIum6w6QmcgFlQH4g
 U4Gw449sBrqVgi8hAfRpAl467+ccu2mtpXrW3mRoQjZo+TRrsEtzLFXZWKatCUvTixpSbu1AJ
 f6qM2oXLQc6PN1FKXqd/rqPISdXJ/Gwx9ripIWxfSgIkJn65QVGUNPteDYrDS1JmwUY1e39Wb
 iQFOvMmQGwVGRZumROgZDulIn2hCCyYg7DX8BL66e+FWqSKRYt1tBbNYWRDjFCywtakPujf2e
 Vtncs1ZGcXvnZs0eKsCHUHGUxSwhNKF59V6a7TfUCD5gMKfWjHmSunfqbHWG4xgllp2+fivRW
 G5Hy2BqLA2GfNrKAH8TbhItyg5l1ZTdFHuoUPpVwXVrf2moYBQ+eu9vT/q52bYWH6pZdypBIJ
 jhrgYp7MRn9FEgZ0NpbKN3r9QQTkCLD8Gp3Zq70xR/RLB1+kjbsnNcLN2wQQqMZkw91RtMTlw
 dmHYONv5CIb+Uf9UR3wbr5ET7naS59qaywvFe23AMaH2X7EE8ERWcAR6AjeVbpEA0EacdAEqP
 Js36n63Jyb1eKK6KApppY865UkpYKB6WN0K9zXH+g7uTg8W7Od2qKc5+xcoJg7XTvibewWwNW
 XvkrJN9Eah1QK0aXc8xNpSnBAgUIiOjhV5NjFwtecRfmmFe2Ul3w02D4jesFSBSHZXrLWG5G1
 xftHJHV14i0VBx09AyFpXP32ibFDeEF5MoNWBVaCCBktbGIWpQCP8e59aVQN+EScY3Gj8FkDe
 JHicRWkSY6emjvcYxyD5Bw2AiWEJQru7IvhCRb/rU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 0/8] Trivial branch patches
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
Cc: qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit f8c3db33a5e863291182f8862ddf81618a7c6194:

  target/sparc: Switch to do_transaction_failed() hook (2019-09-17 12:01:00 +0100)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/trivial-branch-pull-request

for you to fetch changes up to 754119198de633683d7af79bc08e73c2de9df011:

  configure: Add xkbcommon configure options (2019-09-19 14:42:31 +0200)

----------------------------------------------------------------
Trivial patches 20190919

----------------------------------------------------------------

Chen Zhang (1):
  vfio: fix a typo

Eric Blake (1):
  build: Don't ignore qapi-visit-core.c

Greg Kurz (1):
  kvm: Fix typo in header of kvm_device_access()

James Le Cuirot (1):
  configure: Add xkbcommon configure options

Justin Hibbits (1):
  Fix cacheline detection on FreeBSD/powerpc.

KONRAD Frederic (1):
  target/m68k/fpu_helper.c: rename the access arguments

Philippe Mathieu-Daudé (1):
  cutils: Move size_to_str() from "qemu-common.h" to "qemu/cutils.h"

Thomas Huth (1):
  Replace '-machine accel=xyz' with '-accel xyz'

 .gitignore                          |  1 +
 block/qapi.c                        |  2 +-
 configure                           |  5 +++++
 hw/vfio/pci.c                       |  4 ++--
 include/qemu-common.h               |  1 -
 include/qemu/cutils.h               |  2 ++
 include/sysemu/kvm.h                |  2 +-
 python/qemu/qtest.py                |  2 +-
 qapi/string-output-visitor.c        |  2 +-
 qemu-deprecated.texi                |  3 +--
 qemu-options.hx                     |  2 +-
 target/m68k/fpu_helper.c            |  8 ++++----
 tests/libqtest.c                    |  2 +-
 tests/migration/guestperf/engine.py |  2 +-
 tests/qemu-iotests/172              |  2 +-
 util/cacheinfo.c                    | 23 +++++++++++++----------
 16 files changed, 36 insertions(+), 27 deletions(-)

-- 
2.21.0


