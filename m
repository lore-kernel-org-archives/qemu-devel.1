Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4A9DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:06:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2644206A4
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 19:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hsk/d8Zo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2644206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjSWZ-0004F7-0x
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 15:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSVO-0002wL-Eg
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:41188
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1jjSVM-0008Nm-PG
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 15:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591902287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YcIboS8Cc4kLaj9b7l7Y5V+bFBKD3JWkEApwwRLTMJI=;
 b=hsk/d8ZoVNwVQyPqZowIYT/9SF2sW/GwdkKagsqcbM/CJA7r1DXrdJtnleyD4eS0ppwq/I
 fTIJ3I4uNNfLHsmRblO6F6Aqgv2RekcetFX+pMBcMmriJ+IAjuthjLb8Al4gAHoN26lHe6
 IJZem32lHtsF4Go2nzoulRb3hhSxjEg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-r_FUu9lPNyKE5TFXMhUfrw-1; Thu, 11 Jun 2020 15:04:46 -0400
X-MC-Unique: r_FUu9lPNyKE5TFXMhUfrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01364100AA4E;
 Thu, 11 Jun 2020 19:04:19 +0000 (UTC)
Received: from gimli.home (ovpn-112-195.phx2.redhat.com [10.3.112.195])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A15CD2B4D1;
 Thu, 11 Jun 2020 19:04:15 +0000 (UTC)
Subject: [PULL 0/2] VFIO update 2020-06-11
From: Alex Williamson <alex.williamson@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 11 Jun 2020 13:04:15 -0600
Message-ID: <159190218710.22110.16614504111613456036.stgit@gimli.home>
User-Agent: StGit/0.19-dirty
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.120;
 envelope-from=alex.williamson@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/11 08:37:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jon Derrick <jonathan.derrick@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 3666f684761a3cccd86d13c752273be207ecade4:

  Merge remote-tracking branch 'remotes/ericb/tags/pull-bitmaps-2020-06-09' into staging (2020-06-11 15:35:44 +0100)

are available in the Git repository at:

  git://github.com/awilliam/qemu-vfio.git tags/vfio-update-20200611.0

for you to fetch changes up to 643a4eacef87a318cf71800a4fb2ae1f78c4b245:

  hw/vfio/pci-quirks: Fix broken legacy IGD passthrough (2020-06-11 11:36:40 -0600)

----------------------------------------------------------------
VFIO update 2020-06-11

 - Fix IGD split, include header to honor Kconfig (Thomas Huth)

 - New VMD device paravirt quirk (Jon Derrick)

----------------------------------------------------------------
Jon Derrick (1):
      hw/vfio: Add VMD Passthrough Quirk

Thomas Huth (1):
      hw/vfio/pci-quirks: Fix broken legacy IGD passthrough

 hw/vfio/pci-quirks.c | 85 ++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 73 insertions(+), 12 deletions(-)


