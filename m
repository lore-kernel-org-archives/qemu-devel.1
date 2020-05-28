Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE44C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:39:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46956206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OetrZItr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46956206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHoa-0006mb-Ez
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:39:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHln-0001Rh-ED
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28007
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHll-000585-SF
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mVjZqVP0wAt2HnF0eXAfdRGW3Pml22lYIIaHBGNUwSg=;
 b=OetrZItr4n6kU20Gm0pe6tvTbTVv9TZTPQifJKfUH1q3AsFzZ95JclK5V0sVQy+Af14TkP
 52GnnnUSUYbreh46DSjaBlNg7wI+ACsUiJp492NL3ldQI37OTuoMoDDSuObedCVx8kZT6c
 zRlowFiwzBsIplS6Uo+tEf5kVBASbis=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-6xIn2NcANOmoCGYmTlSLFQ-1; Thu, 28 May 2020 08:36:18 -0400
X-MC-Unique: 6xIn2NcANOmoCGYmTlSLFQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E964B8014D4;
 Thu, 28 May 2020 12:36:16 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 650AF10013C3;
 Thu, 28 May 2020 12:36:13 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 589CE1753B; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 00/21] Vga 20200528 patches
Date: Thu, 28 May 2020 14:35:48 +0200
Message-Id: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 01:51:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 06539ebc76b8625587aa78d646a9d8d5fddf84f3=
:

  Merge remote-tracking branch 'remotes/philmd-gitlab/tags/mips-hw-next-202=
00526' into staging (2020-05-26 20:25:06 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/vga-20200528-pull-request

for you to fetch changes up to fa0013a1bc5f6011a1017e0e655740403e5555d9:

  sm501: Remove obsolete changelog and todo comment (2020-05-28 11:38:57 +0=
200)

----------------------------------------------------------------
hw/dispaly/sm501: bugfixes, add sanity checks.
hw/display: use tracepoints, misc cleanups.

----------------------------------------------------------------

BALATON Zoltan (7):
  sm501: Convert printf + abort to qemu_log_mask
  sm501: Shorten long variable names in sm501_2d_operation
  sm501: Use BIT(x) macro to shorten constant
  sm501: Clean up local variables in sm501_2d_operation
  sm501: Replace hand written implementation with pixman where possible
  sm501: Optimize small overlapping blits
  sm501: Remove obsolete changelog and todo comment

Philippe Mathieu-Daud=C3=A9 (14):
  hw/display/edid: Add missing 'qdev-properties.h' header
  hw/display/cg3: Convert debug printf()s to trace events
  hw/display/cirrus_vga: Convert debug printf() to trace event
  hw/display/cirrus_vga: Use qemu_log_mask(UNIMP) instead of debug
    printf
  hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead of debug
    printf
  hw/display/cirrus_vga: Convert debug printf() to trace event
  hw/display/dpcd: Fix memory region size
  hw/display/dpcd: Convert debug printf()s to trace events
  hw/display/xlnx_dp: Replace disabled DPRINTF() by error_report()
  hw/display/vmware_vga: Replace printf() calls by qemu_log_mask(ERROR)
  hw/display/vmware_vga: Let the PCI device own its I/O MemoryRegion
  hw/display/exynos4210_fimd: Use qemu_log_mask(GUEST_ERROR)
  hw/display/omap_dss: Replace fprintf() call by
    qemu_log_mask(LOG_UNIMP)
  hw/display/pxa2xx_lcd: Replace printf() call by qemu_log_mask()

 include/hw/display/edid.h    |   1 +
 hw/display/cg3.c             |  14 +-
 hw/display/cirrus_vga.c      | 119 ++++++-------
 hw/display/dpcd.c            |  20 +--
 hw/display/exynos4210_fimd.c |  46 +++--
 hw/display/omap_dss.c        |   2 +-
 hw/display/pxa2xx_lcd.c      |  26 +--
 hw/display/sm501.c           | 313 ++++++++++++++++++-----------------
 hw/display/vmware_vga.c      |  18 +-
 hw/display/xlnx_dp.c         |  14 +-
 hw/display/trace-events      |  10 ++
 11 files changed, 301 insertions(+), 282 deletions(-)

--=20
2.18.4


