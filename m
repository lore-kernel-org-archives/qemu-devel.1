Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C4D8C4727E
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 701F220848
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 18:01:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2IBbyyI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 701F220848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kO2t7-0005Bj-AZ
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 14:01:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36628)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fU-0003PS-4e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:47:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48174)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kO2fR-0006oV-11
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 13:46:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601574413;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QX4TOfYM+e5sPgITVFJGKCkwky6vjqx01fxRK7Ks3x8=;
 b=O2IBbyyIHerc8ujaatsDvJqPVA9gxZm60P1VB06gLt28HxtiCNO7MBuK9jTzkTls44/z82
 v8BgTU1xVhNQlyKtGRs5Els4uJGTTAgSPl2+FSTH0pb7g83/bdxXFjHtgYcwLCfjnuEgEM
 XcKg4BIwWORVrIBEN/PMCfZkoNHlWr0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-U_zG-SEaOsWZEZDcnNKHEQ-1; Thu, 01 Oct 2020 13:46:52 -0400
X-MC-Unique: U_zG-SEaOsWZEZDcnNKHEQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E1B5D107465A;
 Thu,  1 Oct 2020 17:46:50 +0000 (UTC)
Received: from scv.redhat.com (ovpn-120-38.rdu2.redhat.com [10.10.120.38])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 056B05C1CF;
 Thu,  1 Oct 2020 17:46:49 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Subject: [PULL 0/9] Ide patches
Date: Thu,  1 Oct 2020 13:46:40 -0400
Message-Id: <20201001174649.1911016-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 37a712a0f969ca2df7f01182409a6c4825cebfb5=
:=0D
=0D
  Merge remote-tracking branch 'remotes/bonzini-gitlab/tags/for-upstream' i=
nto staging (2020-10-01 12:23:19 +0100)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/jsnow/qemu.git tags/ide-pull-request=0D
=0D
for you to fetch changes up to 55adb3c45620c31f29978f209e2a44a08d34e2da:=0D
=0D
  ide: cancel pending callbacks on SRST (2020-10-01 13:04:16 -0400)=0D
=0D
----------------------------------------------------------------=0D
Pull request=0D
=0D
----------------------------------------------------------------=0D
=0D
John Snow (8):=0D
  MAINTAINERS: Update my git address=0D
  ide: rename cmd_write to ctrl_write=0D
  ide: don't tamper with the device register=0D
  ide: model HOB correctly=0D
  ide: reorder set/get sector functions=0D
  ide: remove magic constants from the device register=0D
  ide: clear interrupt on command write=0D
  ide: cancel pending callbacks on SRST=0D
=0D
Philippe Mathieu-Daud=C3=A9 (1):=0D
  hw/ide/ahci: Do not dma_memory_unmap(NULL)=0D
=0D
 include/hw/ide/internal.h |  21 +++++--=0D
 hw/ide/ahci.c             |   2 +-=0D
 hw/ide/core.c             | 124 +++++++++++++++++++++++---------------=0D
 hw/ide/ioport.c           |   2 +-=0D
 hw/ide/macio.c            |   2 +-=0D
 hw/ide/mmio.c             |   8 +--=0D
 hw/ide/pci.c              |  12 ++--=0D
 MAINTAINERS               |   6 +-=0D
 hw/ide/trace-events       |   2 +-=0D
 9 files changed, 110 insertions(+), 69 deletions(-)=0D
=0D
--=20=0D
2.26.2=0D
=0D


