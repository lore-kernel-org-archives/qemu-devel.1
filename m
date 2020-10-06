Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5499C47095
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:33:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A2CB20760
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 18:33:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/3Vhnbm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A2CB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40474 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPrmf-0004tu-67
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 14:33:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrke-0002zr-CT
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:31:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kPrkR-0006Np-04
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 14:31:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602009096;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=px390/cbU5fRijvT9BgBdVcgqRCtywOOscTZCvwFeZc=;
 b=c/3Vhnbm+TP9KsO5PcsH7Xczts+eJuby4MCLV+kfBB0TcQORuwhFV3V2aP5axL9Vy28EcC
 SDsbcm+Uf+mL+DvSlRQ1Dfi/vQ26tPD7Uehf01o+nGTaiNbuK5wFT4MqGiiZw0ib/wk5+k
 CRlWMH5XITf0BrPyeDnF4APiW3peSq4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-UnRi0o1iOW6Efmz3bvaFgA-1; Tue, 06 Oct 2020 14:31:33 -0400
X-MC-Unique: UnRi0o1iOW6Efmz3bvaFgA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 77EF680365F;
 Tue,  6 Oct 2020 18:31:31 +0000 (UTC)
Received: from thuth.com (ovpn-113-60.ams2.redhat.com [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 972A06EF43;
 Tue,  6 Oct 2020 18:31:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/16] s390-ccw bios update
Date: Tue,  6 Oct 2020 20:31:06 +0200
Message-Id: <20201006183122.155609-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 00:55:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 Cornelia Huck <cohuck@redhat.com>, Marc Hartmayer <mhartmay@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

 Hi Peter,

the following changes since commit d7c5b788295426c1ef48a9ffc3432c51220f69ba:

  Merge remote-tracking branch 'remotes/stefanha-gitlab/tags/block-pull-request' into staging (2020-10-06 12:15:59 +0100)

are available in the Git repository at:

  https://gitlab.com/huth/qemu.git tags/pull-request-2020-10-06

for you to fetch changes up to eb32abd8d931994d10327bd965a4fb12d765a0fb:

  tests/qtest/cdrom: Add more s390x-related boot tests (2020-10-06 20:14:48 +0200)

----------------------------------------------------------------
* Don't stop at the first unbootable device, continue scanning
* Fix corner cases in booting from ECKD
* s390x-ccw bios cleanup part 2​
----------------------------------------------------------------

Janosch Frank (4):
      pc-bios: s390x: Fix bootmap.c zipl component entry data handling
      pc-bios: s390x: Save PSW rework
      pc-bios: s390x: Use reset PSW if avaliable
      pc-bios: s390x: Go into disabled wait when encountering a PGM exception

Marc Hartmayer (2):
      pc-bios/s390-ccw: fix off-by-one error
      pc-bios/s390-ccw: break loop if a null block number is reached

Thomas Huth (10):
      pc-bios/s390-ccw/Makefile: Compile with -std=gnu99, -fwrapv and -fno-common
      pc-bios/s390-ccw: Move ipl-related code from main() into a separate function
      pc-bios/s390-ccw: Introduce ENODEV define and remove guards of others
      pc-bios/s390-ccw: Move the inner logic of find_subch() to a separate function
      pc-bios/s390-ccw: Do not bail out early if not finding a SCSI disk
      pc-bios/s390-ccw: Scan through all devices if no boot device specified
      pc-bios/s390-ccw: Allow booting in case the first virtio-blk disk is bad
      pc-bios/s390-ccw/main: Remove superfluous call to enable_subchannel()
      pc-bios/s390: Update the s390-ccw bios binaries
      tests/qtest/cdrom: Add more s390x-related boot tests

 pc-bios/s390-ccw.img             | Bin 42608 -> 42608 bytes
 pc-bios/s390-ccw/Makefile        |   7 +-
 pc-bios/s390-ccw/bootmap.c       |  47 +++++++----
 pc-bios/s390-ccw/bootmap.h       |   7 +-
 pc-bios/s390-ccw/jump2ipl.c      |  45 +++++-----
 pc-bios/s390-ccw/main.c          | 172 ++++++++++++++++++++++++---------------
 pc-bios/s390-ccw/s390-ccw.h      |   9 +-
 pc-bios/s390-ccw/start.S         |   5 +-
 pc-bios/s390-ccw/virtio-blkdev.c |   7 +-
 pc-bios/s390-ccw/virtio-scsi.c   |  28 +++++--
 pc-bios/s390-ccw/virtio-scsi.h   |   2 +-
 pc-bios/s390-netboot.img         | Bin 67232 -> 67232 bytes
 tests/qtest/cdrom-test.c         |  12 +++
 13 files changed, 218 insertions(+), 123 deletions(-)


