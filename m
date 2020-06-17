Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:33:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84B352078D
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 12:33:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pe5u/1KN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84B352078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlXFn-0000P5-Ib
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 08:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60266)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlXBw-0004Qg-MT
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:29:20 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21170
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jlXBv-0002Ww-2R
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 08:29:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592396958;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=njPufjQU9J06Is2FXVSy/pVf/aMSRVIW2nX5LRoWV4E=;
 b=Pe5u/1KNBnU4/rSwGzk2KmoMdtsa2OqWP6lRqpmEx7Wr9OWXJd7KD67LMKtTCxyeTTZPdo
 VByY1VStcofVuqsl2d5fwb9CmIKnXpKFiS9SBlecviLhFoc4yvBNTkbDBJU//zGl25IfFw
 xYslxpfhOd4b5725/tTklF9wsAAo+q4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-266-KQmlQncdOiGFUbPBAR1Qlw-1; Wed, 17 Jun 2020 08:29:16 -0400
X-MC-Unique: KQmlQncdOiGFUbPBAR1Qlw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 75DFE100962B;
 Wed, 17 Jun 2020 12:29:15 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-67.ams2.redhat.com
 [10.36.112.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 09EB719D7B;
 Wed, 17 Jun 2020 12:29:06 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9AC9B16E16; Wed, 17 Jun 2020 14:29:01 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Microvm 20200617 patches
Date: Wed, 17 Jun 2020 14:28:57 +0200
Message-Id: <20200617122901.13327-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 02:02:46
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Stefano Stabellini <sstabellini@kernel.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paul Durrant <paul@xen.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 5c24bce3056ff209a1ecc50ff4b7e65b85ad8e74:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-plugin-160620-2' into staging (2020-06-16 14:57:15 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/microvm-20200617-pull-request

for you to fetch changes up to c8b473594b8fbba169a6ea950493a3015d15a18d:

  microvm: move virtio base to 0xfeb00000 (2020-06-17 14:24:28 +0200)

----------------------------------------------------------------
microvm: memory config tweaks

----------------------------------------------------------------

Gerd Hoffmann (4):
  microvm: use 3G split unconditionally
  microvm: drop max-ram-below-4g support
  x86: move max-ram-below-4g to pc
  microvm: move virtio base to 0xfeb00000

 include/hw/i386/microvm.h |  2 +-
 include/hw/i386/pc.h      |  2 ++
 include/hw/i386/x86.h     |  4 ----
 hw/i386/microvm.c         | 35 +----------------------------
 hw/i386/pc.c              | 46 +++++++++++++++++++++++++++++++++++++++
 hw/i386/pc_piix.c         | 10 ++++-----
 hw/i386/pc_q35.c          | 10 ++++-----
 hw/i386/x86.c             | 46 ---------------------------------------
 hw/i386/xen/xen-hvm.c     |  2 +-
 9 files changed, 61 insertions(+), 96 deletions(-)

-- 
2.18.4


