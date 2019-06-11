Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB70C4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:08:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3325B20652
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 14:08:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3325B20652
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hahS2-0003va-Dn
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 10:08:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56669)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hah3B-0007DX-J6
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:42:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hah3A-0001xl-G8
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:42:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41842)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hah3A-0001dD-8g
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 09:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CAD930BC572;
 Tue, 11 Jun 2019 13:42:27 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B18035D704;
 Tue, 11 Jun 2019 13:42:25 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 11 Jun 2019 10:42:21 -0300
Message-Id: <20190611134224.6683-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Tue, 11 Jun 2019 13:42:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/3] x86 queue, 2019-06-11
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a578cdfbdd8f9beff5ced52b7826ddb1669abbbf:

  Merge remote-tracking branch 'remotes/rth/tags/pull-tcg-20190610' into staging (2019-06-10 16:09:19 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/x86-next-pull-request

for you to fetch changes up to 89a44a103315267122119b4311218d00d2561ebe:

  i386: Save EFER for 32-bit targets (2019-06-11 10:17:47 -0300)

----------------------------------------------------------------
x86 queue, 2019-06-11

* "unavailable-features" QOM property (Eduardo Habkost)
* Save EFER for 32-bit targets (Pavel Dovgalyuk)

----------------------------------------------------------------

Eduardo Habkost (2):
  i386: x86_cpu_list_feature_names() function
  i386: "unavailable-features" QOM property

Pavel Dovgalyuk (1):
  i386: Save EFER for 32-bit targets

 target/i386/cpu.c     | 55 +++++++++++++++++++++++++++++++++----------
 target/i386/machine.c | 24 +++++++++++++++++++
 2 files changed, 66 insertions(+), 13 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


