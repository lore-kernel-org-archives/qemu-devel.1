Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27945C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F46B208C3
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 20:06:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F46B208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52610 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZL85-0006jw-Vi
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 16:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51913)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hZJfT-0006Ex-Fc
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:32:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hZJfR-0000Zq-FG
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:32:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9053)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hZJfQ-0000T2-GB
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 14:32:45 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E68CD2E97DE;
 Fri,  7 Jun 2019 18:32:32 +0000 (UTC)
Received: from localhost (ovpn-116-9.gru2.redhat.com [10.97.116.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D1D7F8CFBA;
 Fri,  7 Jun 2019 18:32:29 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Fri,  7 Jun 2019 15:32:26 -0300
Message-Id: <20190607183228.22454-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Fri, 07 Jun 2019 18:32:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 0/2] Machine Core queue, 2019-06-07
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
Cc: Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 185b7ccc11354cbd69b6d53bf8d831dd964f6c88:

  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20190607-2' into staging (2019-06-07 15:24:13 +0100)

are available in the Git repository at:

  git://github.com/ehabkost/qemu.git tags/machine-next-pull-request

for you to fetch changes up to 754f1dbcf1d4d543167e3212366055761c30bcf4:

  accel: Remove unused AccelClass::opt_name attribute (2019-06-07 15:28:46 -0300)

----------------------------------------------------------------
Machine Core queue, 2019-06-07

* Improve CPU hotplug error message
  (Laurent Vivier)
* Remove unused AccelClass::opt_name field
  (Wainer dos Santos Moschetta)

----------------------------------------------------------------

Queue for Machine Core patches


Laurent Vivier (1):
  numa: improve cpu hotplug error message with a wrong node-id

Wainer dos Santos Moschetta (1):
  accel: Remove unused AccelClass::opt_name attribute

 include/sysemu/accel.h | 1 -
 numa.c                 | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

-- 
2.18.0.rc1.1.g3f1ff2140


