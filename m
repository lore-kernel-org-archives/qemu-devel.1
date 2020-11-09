Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E817C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFDCA20867
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 14:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFDCA20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kc7ky-0004pm-HA
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 09:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35440)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <remi@remlab.net>)
 id 1kc7eY-0007RG-D9; Mon, 09 Nov 2020 08:56:14 -0500
Received: from poy.remlab.net ([2001:41d0:2:5a1a::]:60098
 helo=ns207790.ip-94-23-215.eu)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <remi@remlab.net>)
 id 1kc7eW-0006K8-18; Mon, 09 Nov 2020 08:56:13 -0500
Received: from basile.remlab.net (dzyqn8ypzhx7l91mxjsvy-3.rev.dnainternet.fi
 [IPv6:2001:14ba:a01a:be01:9434:f69e:d553:3be2])
 (Authenticated sender: remi)
 by ns207790.ip-94-23-215.eu (Postfix) with ESMTPSA id 3B4525FAAA;
 Mon,  9 Nov 2020 14:56:07 +0100 (CET)
From: =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi.denis.courmont@huawei.com>
To: qemu-arm@nongnu.org
Subject: [PATCHv2 00/17] ARM Secure EL2 extension
Date: Mon, 09 Nov 2020 15:56:03 +0200
Message-ID: <5554493.MhkbZ0Pkbq@basile.remlab.net>
Organization: Huawei Technologies, Finland
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:41d0:2:5a1a::; envelope-from=remi@remlab.net;
 helo=ns207790.ip-94-23-215.eu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/09 08:56:07
X-ACL-Warn: Detected OS   = ???
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 193f51ddcf1d87d725f1dfd51b8a95351c910e8f:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-fixes-20201=
109' into staging (2020-11-09 10:10:49 +0000)

are available for review.

Changes since version 1:
=2D Add the first patch which was accidentally dropped.
=2D Try to address comments from Peter and Richard.

=2D---------------------------------------------------------------
R=C3=A9mi Denis-Courmont (17):
      target/arm: remove redundant tests
      target/arm: add arm_is_el2_enabled() helper
      target/arm: use arm_is_el2_enabled() where applicable
      target/arm: use arm_hcr_el2_eff() where applicable
      target/arm: factor MDCR_EL2 common handling
      target/arm: declare new AA64PFR0 bit-fields
      target/arm: add 64-bit S-EL2 to EL exception table
      target/arm: return the stage 2 index for stage 1
      target/arm: add MMU stage 1 for Secure EL2
      target/arm: add ARMv8.4-SEL2 system registers
      target/arm: do S1_ptw_translate() before address space lookup
      target/arm: secure stage 2 translation regime
      target/arm: handle VMID change in secure state
      target/arm: set HPFAR_EL2.NS on secure stage 2 faults
      target/arm: add ARMv8.4-SEL2 extension
      target/arm: enable Secure EL2 in max CPU
      target/arm: refactor vae1_tlbmask()

 target/arm/cpu-param.h     |   2 +-
 target/arm/cpu.c           |  10 +-
 target/arm/cpu.h           |  92 ++++++++--
 target/arm/cpu64.c         |   1 +
 target/arm/helper-a64.c    |   8 +-
 target/arm/helper.c        | 421 ++++++++++++++++++++++++++++++-----------=
=2D---
 target/arm/internals.h     |  54 +++++-
 target/arm/op_helper.c     |   4 +-
 target/arm/tlb_helper.c    |   3 +
 target/arm/translate-a64.c |   4 +
 target/arm/translate.c     |   6 +-
 target/arm/translate.h     |   1 +
 12 files changed, 426 insertions(+), 180 deletions(-)
=2D-=20
R=C3=A9mi Denis-Courmont
http://www.remlab.net/




