Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E43CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:24:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BAE22226B
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 10:24:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="CRhnR9N6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BAE22226B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55116 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQpZq-0001y4-0q
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 06:24:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42962)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVO-0005A7-LY
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:06 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:41549 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1kQpVM-0001ly-OX
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 06:20:06 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 4C73wW0ntYz9sTc; Fri,  9 Oct 2020 21:19:55 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1602238795;
 bh=2JsAgi2GmvQGJtk65skTJ1zmHXSUwvBVnyfGGDocyns=;
 h=From:To:Cc:Subject:Date:From;
 b=CRhnR9N6k7ihDUmXZ2JoGJLeOTvfBmSfIzBBGV6pQQmF+YzvGAoa2+4YpBuGhX1uk
 Qzw1RmAysoomSsX0k+3OOweVOJrMquprgAjTMs3LBLeCMD3ylsBT0NfZPMas6rN8qQ
 TU+dGqw1w0cdoO8/Sfe3jDgYUy7LjOWcvknGF36o=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 00/20] ppc-for-5.2 queue 20201009
Date: Fri,  9 Oct 2020 21:19:31 +1100
Message-Id: <20201009101951.1569252-1-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: qemu-devel@nongnu.org, qemu-ppc@nonngu.org,
 David Gibson <david@gibson.dropbear.id.au>, groug@kaod.org,
 dbarboza@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 497d415d76b9f59fcae27f22df1ca2c3fa4df64e:

  Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20201008-1' into staging (2020-10-08 21:41:20 +0100)

are available in the Git repository at:

  git://github.com/dgibson/qemu.git tags/ppc-for-5.2-20201009

for you to fetch changes up to 307e7a34dc474c050f345eeb519d957a42f10c77:

  specs/ppc-spapr-numa: update with new NUMA support (2020-10-09 15:06:14 +1100)

----------------------------------------------------------------
ppc patch queue 2020-10-09

Here's the next set of ppc related patches for qemu-5.2.  There are
two main things here:

* Cleanups to error handling in spapr from Greg Kurz
* Improvements to NUMA handling for spapr from Daniel Barboza

There are also a handful of other bugfixes.

----------------------------------------------------------------
Cédric Le Goater (1):
      ppc/pnv: Increase max firmware size

Daniel Henrique Barboza (5):
      spapr: add spapr_machine_using_legacy_numa() helper
      spapr_numa: forbid asymmetrical NUMA setups
      spapr_numa: change reference-points and maxdomain settings
      spapr_numa: consider user input when defining associativity
      specs/ppc-spapr-numa: update with new NUMA support

Fabiano Rosas (1):
      spapr: Handle HPT allocation failure in nested guest

Greg Kurz (13):
      spapr: Fix error leak in spapr_realize_vcpu()
      ppc: Add a return value to ppc_set_compat() and ppc_set_compat_all()
      ppc: Fix return value in cpu_post_load() error path
      spapr: Simplify error handling in callers of ppc_set_compat()
      spapr: Get rid of cas_check_pvr() error reporting
      spapr: Simplify error handling in do_client_architecture_support()
      spapr: Simplify error handling in spapr_vio_busdev_realize()
      spapr: Add a return value to spapr_drc_attach()
      spapr: Simplify error handling in prop_get_fdt()
      spapr: Add a return value to spapr_set_vcpu_id()
      spapr: Simplify error handling in spapr_cpu_core_realize()
      spapr: Add a return value to spapr_nvdimm_validate()
      spapr: Add a return value to spapr_check_pagesize()

 docs/specs/ppc-spapr-numa.rst | 235 ++++++++++++++++++++++++++++++++++++++++--
 hw/ppc/pnv.c                  |   2 +-
 hw/ppc/spapr.c                |  53 +++++-----
 hw/ppc/spapr_caps.c           |   7 +-
 hw/ppc/spapr_cpu_core.c       |  24 ++---
 hw/ppc/spapr_drc.c            |  17 ++-
 hw/ppc/spapr_hcall.c          |  34 +++---
 hw/ppc/spapr_numa.c           | 185 +++++++++++++++++++++++++++++++--
 hw/ppc/spapr_nvdimm.c         |  19 ++--
 hw/ppc/spapr_pci.c            |   5 +-
 hw/ppc/spapr_vio.c            |  12 +--
 include/hw/ppc/spapr.h        |   6 +-
 include/hw/ppc/spapr_drc.h    |   2 +-
 include/hw/ppc/spapr_nvdimm.h |   2 +-
 target/ppc/compat.c           |  26 +++--
 target/ppc/cpu.h              |   4 +-
 target/ppc/machine.c          |   9 +-
 17 files changed, 514 insertions(+), 128 deletions(-)

