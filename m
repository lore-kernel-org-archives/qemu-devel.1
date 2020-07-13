Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44A57C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 112892072D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 14:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIQhrA+t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 112892072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juzBh-0006Lc-9m
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 10:12:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAb-0004cp-NY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:51218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1juzAZ-0006ZY-4A
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 10:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594649458;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=MlMQLXyJASzOziS/y1F/U9ge/EM05rWDfVAQW6+yScM=;
 b=eIQhrA+t9N31WIM7IxQHy+ykaLCR+1OzbFYGLxbvL8am+Z32YbQ2NtO31/+5nOORYmHCkO
 GupXzlv9+ps1hqj/7oaCFRTXVmo0vRaellpsX/cDr/gQXSHSdbUmnLq25DfBl5kW3UGiAd
 HB+stQ/DuwQTunUxhbdCTWR6IbwUx5g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-0G6CaGd8NX6G9chfeOddBw-1; Mon, 13 Jul 2020 10:10:54 -0400
X-MC-Unique: 0G6CaGd8NX6G9chfeOddBw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4561418FF669
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 14:10:53 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-115-89.ams2.redhat.com
 [10.36.115.89])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C70560BEC;
 Mon, 13 Jul 2020 14:10:50 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 179FE3EBB7; Mon, 13 Jul 2020 16:10:49 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Fixes 20200713 patches
Date: Mon, 13 Jul 2020 16:10:45 +0200
Message-Id: <20200713141049.2241-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 9f526fce49c6ac48114ed04914b5a76e4db75785=
:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-misc-=
110720-2' into staging (2020-07-12 15:32:05 +0100)

are available in the Git repository at:

  git://git.kraxel.org/qemu tags/fixes-20200713-pull-request

for you to fetch changes up to 631009e775a91018a62e2670b4473e99916f858f:

  usb: fix usb-host build on windows. (2020-07-13 11:46:51 +0200)

----------------------------------------------------------------
bugfixes for audio, usb, ui and docs.

----------------------------------------------------------------

Gerd Hoffmann (2):
  ui: fix vc_chr_write call in text_console_do_init
  usb: fix usb-host build on windows.

Thomas Huth (1):
  docs/qdev-device-use: Clean up the sentences related to -usbdevice

Volker R=C3=BCmelin (1):
  ossaudio: fix out of bounds write

 docs/qdev-device-use.txt | 28 +++-------------------------
 audio/ossaudio.c         |  1 +
 hw/usb/host-libusb.c     |  4 ++--
 ui/console.c             |  8 ++++----
 4 files changed, 10 insertions(+), 31 deletions(-)

--=20
2.18.4


