Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 501EAC388F2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86B89208FE
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 09:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="hu8zzA1+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86B89208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35580 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kayDE-0007BV-DW
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 04:39:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com>)
 id 1kayBw-000632-2n
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:37:56 -0500
Received: from lizzy.crudebyte.com ([91.194.90.13]:34053)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com>)
 id 1kayBu-00074U-6l
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 04:37:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Cc:To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:Subject:Date:From:Message-Id:References:In-Reply-To:Content-ID:
 Content-Description; bh=tfrEytemkaN/RQpqEXQgYkNzTfsRTeUpksJx8K5///k=; b=hu8zz
 A1+FQy7Q4IHD+vvjUxvDt/nHUaBu8IiZYcjofk4QfTHZy1ofafFuam4X7T5k1R3QlW65ugZ2TVFFb
 pzcStqwhSVudyruS5UCe7PCw5hvzLC35efcfyefZbIGCKTy7fn+oTx8iNrIOOt4olNglLAMNrloHz
 UxlJQa1xCwPG0hBMf9mKireFY+dSKSBqNpGeQhT4p+LKpXabpRv/ryJ+y9X1qAPm/4ToC1RXVS9FW
 UT72s4CmhORKWS2B8r4ZPiVvdFxpnmoot6AkmG4lx/44RJUAd31fGAvo7/OCaxKLymH2d7AS5LuZB
 TIuoplSFUK7l9YfOy8kiBok9TFhdg==;
Message-Id: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
Date: Fri, 06 Nov 2020 10:13:10 +0100
Subject: [PULL 0/4] 9p queue for 5.2 (2020-11-06)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org,
    Peter Maydell <peter.maydell@linaro.org>
Cc: Greg Kurz <groug@kaod.org>
Received-SPF: none client-ip=91.194.90.13;
 envelope-from=e6b99460b14469e0b83febc8d5a501947d1d5c7c@lizzy.crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 04:36:52
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit e2766868d45d8c8f8991cfd133e6a0c14abfe577:

  Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20201104-pull-request' into staging (2020-11-04 22:13:02 +0000)

are available in the Git repository at:

  https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201106

for you to fetch changes up to e6b99460b14469e0b83febc8d5a501947d1d5c7c:

  hw/9pfs: Fix Kconfig dependency problem between 9pfs and Xen (2020-11-05 15:21:11 +0100)

----------------------------------------------------------------
9pfs: some fixes

* Fix meson build config for Xen.

* Code style fixes.

----------------------------------------------------------------
Philippe Mathieu-Daudé (1):
      hw/9pfs: Fix Kconfig dependency problem between 9pfs and Xen

Xinhao Zhang (3):
      hw/9pfs : add spaces around operator
      hw/9pfs : open brace '{' following struct go on the same line
      hw/9pfs : add space before the open parenthesis '('

 hw/9pfs/9p-local.c  | 10 +++++-----
 hw/9pfs/9p.c        | 16 ++++++++--------
 hw/9pfs/9p.h        |  9 +++------
 hw/9pfs/Kconfig     |  4 ----
 hw/9pfs/cofs.c      |  2 +-
 hw/9pfs/meson.build |  2 +-
 6 files changed, 18 insertions(+), 25 deletions(-)

