Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4535C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:22:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9066520643
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 08:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GFLsszf2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9066520643
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52018 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZVcI-00058i-PD
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 04:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51508)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbP-0002iH-T0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:55 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29388
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jZVbO-000737-Bq
 for qemu-devel@nongnu.org; Fri, 15 May 2020 04:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589530913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6B6hlpC58PsiuL+KWTaE9Snggpp9u6qN9D//XtVEP4w=;
 b=GFLsszf2FKm9O7f9bTvLE43cGoURwheTtJQHqrz0srUPkAuQjwbgQUvJ/A/SAKHXPxvc+u
 IpeoSOwUIrB+ez9szm017Mly0KNy1MN6oJ5VP7IA48ZEdNmFAPzNPMSDVhjRTCwn0qZdtj
 efnzalAAwiei+CZeU/r8LOxA8ADGPyo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-wU4hwLEZOUeHv0bm1bpOAA-1; Fri, 15 May 2020 04:21:51 -0400
X-MC-Unique: wU4hwLEZOUeHv0bm1bpOAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7642B1B18BD1
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 08:21:50 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-145.ams2.redhat.com
 [10.36.115.145])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C31095C1D6;
 Fri, 15 May 2020 08:21:46 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id B07A516E16; Fri, 15 May 2020 10:21:45 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Ui 20200515 patches
Date: Fri, 15 May 2020 10:21:43 +0200
Message-Id: <20200515082145.4732-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/15 00:39:12
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit d5c75ec500d96f1d93447f990cd5a4ef5ba27fae:

  Merge remote-tracking branch 'remotes/stefanberger/tags/pull-tpm-2020-05-08-1' into staging (2020-05-12 17:00:10 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/ui-20200515-pull-request

for you to fetch changes up to 32ec9839d89d2b814ada20b041b25feae23596bc:

  ui/sdl2: fix segment fault caused by null pointer dereference (2020-05-14 14:26:42 +0200)

----------------------------------------------------------------
ui: sdl bugfix, -show-cursor deprecation message

----------------------------------------------------------------

Changbin Du (1):
  ui/sdl2: fix segment fault caused by null pointer dereference

Gerd Hoffmann (1):
  ui: improve -show-cursor deprecation message

 softmmu/vl.c |  6 ++++--
 ui/sdl2.c    | 12 ++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

-- 
2.18.4


