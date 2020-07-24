Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7CEAC43457
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:46:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82BD7206C1
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 16:46:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YwUOeLzA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82BD7206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz0q5-0000oe-Q9
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 12:46:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56024)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jz0mw-0005Mk-7b
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:43:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:47414
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jz0mu-0002aE-Ju
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 12:43:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595608991;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=j4Avp+evuy3lGWRW/wF3VnbX9D8jtxzLrMUE3Wyr84E=;
 b=YwUOeLzASmzkREdS/ADJxt7LIxwqepqBBX/7mwqhOTo3B6K+dudXf7MePG2V95u66uR1wx
 J2K0rNfZtL8wJASJf02Gess+R0OK75LBWZubA9MD9lo2sVNWhHi+QXygSESNrsXhsWtrtD
 HM8rZB2Qw2UC7s6zS8J84+95F7Vys2g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-384-2HiQOSZ4O6WJsdxQ5qdAQA-1; Fri, 24 Jul 2020 12:43:07 -0400
X-MC-Unique: 2HiQOSZ4O6WJsdxQ5qdAQA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 312D680046A;
 Fri, 24 Jul 2020 16:43:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDFE637DD;
 Fri, 24 Jul 2020 16:42:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 974AA17444; Fri, 24 Jul 2020 18:42:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] Fixes 20200724 patches
Date: Fri, 24 Jul 2020 18:42:55 +0200
Message-Id: <20200724164258.24886-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:44:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 09e0cd773723219d21655587954da2769f64ba01:

  Merge remote-tracking branch 'remotes/alistair/tags/pull-riscv-to-apply-20200722-1' into staging (2020-07-23 19:00:42 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20200724-pull-request

for you to fetch changes up to 9b52b17ba5e96cec182537715e87308108b47117:

  configure: Allow to build tools without pixman (2020-07-24 17:36:03 +0200)

----------------------------------------------------------------
bugfixes: virtio-input, usb-dwc2, pixman.

----------------------------------------------------------------

Peter Maydell (1):
  hw/input/virtio-input-hid.c: Don't undef CONFIG_CURSES

Thomas Huth (2):
  hw: Only compile the usb-dwc2 controller if it is really needed
  configure: Allow to build tools without pixman

 configure                   | 2 +-
 hw/input/virtio-input-hid.c | 1 -
 hw/arm/Kconfig              | 1 +
 hw/usb/Kconfig              | 1 -
 4 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.18.4


