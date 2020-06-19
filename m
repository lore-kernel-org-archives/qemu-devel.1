Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D66C4C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62E6208C7
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 13:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ijlu6FIf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62E6208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmGvs-0003s7-R2
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 09:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu2-0001uD-37
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:54 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53939
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jmGu0-00037r-C1
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 09:17:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592572671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aUi8I3F0vxoUlkRqlsWKNA4S5IEby7gUIdYMcagMnlI=;
 b=Ijlu6FIfFRK4HQA/6Y9GqCWthHHl8SFiPAdxQBFtOPuks3r9OM4cYUziXTUSc1K2o5izyv
 c1zzsF6Y4W/F4tc4CWOOPNDHXf3uicYzGnbzthMZAnC4kr6opGFOVX+/dTGh7GPAd5D0UQ
 8T+LenD62sJmsm66a6z+HnbcXHxGOMg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-449-oG_3yn80NouJ1U8vJMM9vg-1; Fri, 19 Jun 2020 09:17:49 -0400
X-MC-Unique: oG_3yn80NouJ1U8vJMM9vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9BB518FF660
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 13:17:48 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D690410013C4;
 Fri, 19 Jun 2020 13:17:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 619F816E16; Fri, 19 Jun 2020 15:17:41 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/7] Audio 20200619 patches
Date: Fri, 19 Jun 2020 15:17:34 +0200
Message-Id: <20200619131741.10857-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/19 01:50:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/audio-20200619-pull-request

for you to fetch changes up to 586803455b3fa44d949ecd42cd9c87e5a6287aef:

  hw/audio/gus: Fix registers 32-bit access (2020-06-19 11:20:09 +0200)

----------------------------------------------------------------
audio: bugfixes for jack backend and gus emulation.

----------------------------------------------------------------

Allan Peramaki (1):
  hw/audio/gus: Fix registers 32-bit access

Geoffrey McRae (6):
  audio/jack: fix invalid minimum buffer size check
  audio/jack: remove unused stopped state
  audio/jack: remove invalid set of input support bool
  audio/jack: do not remove ports when finishing
  audio/jack: honour the enable state of the audio device
  audio/jack: simplify the re-init code path

 audio/jackaudio.c       | 73 +++++++++++++++++++++--------------------
 hw/audio/gusemu_hal.c   |  2 +-
 hw/audio/gusemu_mixer.c |  2 +-
 3 files changed, 40 insertions(+), 37 deletions(-)

-- 
2.18.4


