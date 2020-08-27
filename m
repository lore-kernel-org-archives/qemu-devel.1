Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A69C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE9A220737
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 17:01:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="asiZ+Yks"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE9A220737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBLHW-0007YN-3h
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 13:01:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLFz-0005pc-N6
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53362
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kBLFv-0005MB-DW
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 13:00:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598547604;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q4B9lJ1zNV2k8MCrs+64HM71tVHtntOLx3Tf/4eDOFM=;
 b=asiZ+YksshMfoMyi3Pu8In/avtKzWElNqQtuZlYVo5KnXYGe6hCDTSOb5f+j/iWQlRLKIv
 D/0KY1E3Sn4ocbC3QuP5JgjYYd5zCZ9X9prodg4cqetOYZWkfsA0f0P8gbnhoN4KFsdn+K
 Dzn0qb7DnSej6b89GUN88+HctWVcDbQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-TuUbqGmeNHq6teCsnELveA-1; Thu, 27 Aug 2020 12:59:59 -0400
X-MC-Unique: TuUbqGmeNHq6teCsnELveA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88B60425D4
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 16:59:57 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 543A678437
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2020 16:59:57 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/17] Meson fixes for 2020-08-27
Date: Thu, 27 Aug 2020 12:59:39 -0400
Message-Id: <20200827165956.12925-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 00:13:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit d1a2b51f868d09ca8489ee9aee9c55632ed8fb92:

  Merge remote-tracking branch 'remotes/berrange/tags/socket-next-pull-request' into staging (2020-08-25 15:01:43 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 666ab710f83c29966cca3a5d3ac2776c2b5f1afa

  ninjatool: Fixes E$$: in generated Makefile.ninja (2020-08-27 08:31:54 +0200)

Since I am officially on vacation I don't have access to the full set
of tests I run, but it passes both gitlab CI and the docker-mingw build.
It does not include the submodule update for Meson 0.55.1.

----------------------------------------------------------------
meson fixes:
* fix PIE default for Windows
* tweak conditions for requiring SDL2 and pixman
* move NSIS building to Meson
* fix creation of systemtap files
* add --ninja option for Windows builds
* other fixes for stupid bugs and for Windows paths

meson related:
* forward port of dtrace fix for MacOS
* change colorout option to auto

----------------------------------------------------------------
Bruce Rogers (2):
      meson: Fix meson build with --enable-libdaxctl
      meson: Fix chardev-baum.so name

Daniel P. Berrangé (1):
      configure: default to PIE disabled on Windows platforms

Gerd Hoffmann (1):
      meson: set colorout to auto

Mark Cave-Ayland (1):
      meson: don't require CONFIG_VTE for the GTK UI

Paolo Bonzini (5):
      meson: move pixman detection to meson
      meson: skip SDL2 detection if --disable-system
      configure: add --ninja option
      meson: cleanup xkbcommon detection
      ninjatool: quote dollars in variables

Roman Bolshakov (1):
      meson: Don't make object files for dtrace on macOS

Stefan Hajnoczi (1):
      trace: fix creation of systemtap files

Thomas Huth (2):
      meson: Build qemu-nbd on macOS again
      scripts/qemu-version.sh: Add missing space before ']'

Yonggang Luo (3):
      meson: fix relpath failure on Win32
      meson: Mingw64 gcc doesn't recognize system include_type for sdl2
      ninjatool: Fixes E$$: in generated Makefile.ninja

 chardev/meson.build                |  2 +-
 configure                          | 39 +++++++++++----------
 contrib/vhost-user-gpu/meson.build |  3 +-
 meson.build                        | 70 ++++++++++++++++++++++----------------
 scripts/mtest2make.py              | 11 ++++--
 scripts/ninjatool.py               |  5 +--
 scripts/qemu-version.sh            |  2 +-
 trace/meson.build                  | 13 ++++---
 ui/meson.build                     |  6 ++--
 9 files changed, 87 insertions(+), 64 deletions(-)
-- 
2.26.2


