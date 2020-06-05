Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F0CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2F262074B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 15:39:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X1YNXkGt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2F262074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhEQv-0005fF-SY
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 11:39:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQ1-0004GB-So
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41950
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1jhEQ0-00020D-0T
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 11:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591371483;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=F4wHx+wwp84Lp/9dM8tV9mcHESwZo9xXpoMoslEGE70=;
 b=X1YNXkGtww+nFPrhfjoHxiexHoECpHfdpuk3WsPZvzC2c2FWFmm9X18tUMvpkXbUSiUiT5
 HJdlsTliLcbsfVjUCdKOfhKzFVGRPjhi81prF3WgeiqTeSEyaVx7G7M7zMPkwjb9ejXYCs
 +5rrXrsabKlCT8X+QzrqijFBtGosAiU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-v2wg8cWONYWAyloEY4g0ZA-1; Fri, 05 Jun 2020 11:38:00 -0400
X-MC-Unique: v2wg8cWONYWAyloEY4g0ZA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5D7E8107B274;
 Fri,  5 Jun 2020 15:37:59 +0000 (UTC)
Received: from localhost (ovpn-113-2.ams2.redhat.com [10.36.113.2])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 03E475C660;
 Fri,  5 Jun 2020 15:37:58 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 00/10] s390x update
Date: Fri,  5 Jun 2020 17:37:46 +0200
Message-Id: <20200605153756.392825-1-cohuck@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/05 03:40:54
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit b489f015fbe2bd59d409211f79ea0a8ac5d2a66d:

  Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-06-05 11:53:37 +0100)

are available in the Git repository at:

  https://github.com/cohuck/qemu tags/s390x-20200605

for you to fetch changes up to c44d26a2347177f9bcd558a7c429396b373bb68e:

  target/s390x: Restrict system-mode declarations (2020-06-05 17:13:11 +0200)

----------------------------------------------------------------
s390x update:
- enhance s390x documentation
- allow ORBs without prefetch specified for vfio-ccw
- various cleanups and enhancements

----------------------------------------------------------------

Christian Borntraeger (1):
  s390x/kvm: help valgrind in several places

Cornelia Huck (4):
  docs/s390x: document the virtual css
  docs/s390x: document 3270
  docs/s390x: document vfio-ccw
  MAINTAINERS: add Thomas as additional s390x maintainer

Janosch Frank (1):
  s390x: pv: Fix KVM_PV_PREP_RESET command wrapper name

Jared Rossi (1):
  vfio-ccw: allow non-prefetch ORBs

Philippe Mathieu-Daudé (3):
  target/s390x: Only compile decode_basedisp() on system-mode
  target/s390x/helper: Clean ifdef'ry
  target/s390x: Restrict system-mode declarations

 MAINTAINERS                    |  1 +
 docs/system/s390x/3270.rst     | 32 +++++++++++++
 docs/system/s390x/css.rst      | 86 ++++++++++++++++++++++++++++++++++
 docs/system/s390x/vfio-ccw.rst | 77 ++++++++++++++++++++++++++++++
 docs/system/target-s390x.rst   |  3 ++
 hw/s390x/pv.c                  |  2 +-
 hw/s390x/s390-virtio-ccw.c     |  2 +-
 hw/vfio/ccw.c                  | 13 ++---
 include/hw/s390x/pv.h          |  4 +-
 target/s390x/helper.c          |  5 --
 target/s390x/internal.h        | 16 +++++--
 target/s390x/kvm.c             |  4 +-
 12 files changed, 219 insertions(+), 26 deletions(-)
 create mode 100644 docs/system/s390x/3270.rst
 create mode 100644 docs/system/s390x/css.rst
 create mode 100644 docs/system/s390x/vfio-ccw.rst

-- 
2.25.4


