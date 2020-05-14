Return-Path: <SRS0=rzeH=64=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63103C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:53:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331762065D
	for <qemu-devel@archiver.kernel.org>; Thu, 14 May 2020 19:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331762065D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZJvY-0007mZ-FO
	for qemu-devel@archiver.kernel.org; Thu, 14 May 2020 15:53:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZJgS-00009k-6F
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:38:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:55482)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1jZJgR-0002bv-7d
 for qemu-devel@nongnu.org; Thu, 14 May 2020 15:38:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0BAD0AC50;
 Thu, 14 May 2020 19:38:18 +0000 (UTC)
From: Claudio Fontana <cfontana@suse.de>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH v4 0/2] Makefile: libfdt: build only the strict necessary
Date: Thu, 14 May 2020 21:38:09 +0200
Message-Id: <20200514193811.6798-1-cfontana@suse.de>
X-Mailer: git-send-email 2.16.4
Received-SPF: pass client-ip=195.135.220.15; envelope-from=cfontana@suse.de;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/14 11:26:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Markus Armbruster <armbru@redhat.com>, Claudio Fontana <cfontana@suse.de>,
 Alex Bennee <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v3 -> v4: NB! only useful when updating to latest dtc (not in QEMU yet)

* changed the approach to leverage new upstream dtc Makefile,
  needs dtc submodule update to include upstream dtc commit
  85e5d839847af54efab170f2b1331b2a6421e647.

* LIBFDT_srcdir does not exist anymore in upstream dtc: it is also
  not used anymore.

* LIBFDT_lib: need to avoid building libfdt.so at least for now, so pass as
  empty to avoid building the .so. This is to avoid breaking existing
  trees with objects already compiled without -fPIC.

* clean: no need to make dtc clean target, every artifact is captured by
  global clean rule

v2 -> v3:

* changed into a 2 patch series; in the second patch we remove the old
  compatibility gunks that were meant for removal some time after 4.1.

* renamed the libfdt PHONY rule to dtc/all, with the intent to make
  existing working trees forward and backward compatible across the change.

v1 -> v2:

* fix error generated when running UNCHECKED_GOALS without prior configure,
  for example during make docker-image-fedora. Without configure, DSOSUF is
  empty, and the module pattern rule in rules.mak that uses this variable
  can match too much; provide a default in the Makefile to avoid it.

* only attempt to build the archive when there is a non-empty list of objects.
  This could be done in general for the %.a: pattern in rules.mak, but maybe
  there are valid reasons to build an empty .a?

* removed some intermediate variables that did not add much value
  (LIBFDT_srcdir, LIBFDT_archive)

Tested locally with 3 VPATH configurations (no-, VPATH, VPATH in src subdir),
and with docker-image-fedora, docker-test-debug@fedora that failed before.

Claudio Fontana (2):
  Makefile: libfdt: build only the strict necessary
  Makefile: remove old compatibility gunks

 Makefile  | 32 ++++++++++++++++----------------
 configure |  6 +-----
 rules.mak |  2 ++
 3 files changed, 19 insertions(+), 21 deletions(-)

-- 
2.16.4


