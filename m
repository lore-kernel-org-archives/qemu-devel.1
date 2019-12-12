Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAD44C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:22:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B378D21556
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 22:22:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TMHwXyBN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B378D21556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifWqy-00077B-7E
	for qemu-devel@archiver.kernel.org; Thu, 12 Dec 2019 17:22:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53686)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <quintela@redhat.com>) id 1ifWpA-0005TQ-P6
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <quintela@redhat.com>) id 1ifWp9-00075a-P7
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:44 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:47280
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <quintela@redhat.com>) id 1ifWp9-0006y8-Kt
 for qemu-devel@nongnu.org; Thu, 12 Dec 2019 17:20:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576189240;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=5cneVVudEh2WomY6R4hYvMD2yNRDM2PEnQc/eAwWfYM=;
 b=TMHwXyBNRI/C/p+q7bLtBTM6nVPnzyoV9yY+0hTHrFLrZgUz2AiwVAK3aKKWNYaZJp8PbF
 duCxVpY+AN08ugRONQV7nVuWbncgIrQ6rEUA+H4pJDoZ3aglZzOJtRcQQras58rziigOxD
 vX3m3J4cyFB+xoVbnC/6sBm+EsfldVI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-406-Zo7ECFu_PEOLziuLzVf0bA-1; Thu, 12 Dec 2019 17:20:37 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A3993801E74
 for <qemu-devel@nongnu.org>; Thu, 12 Dec 2019 22:20:36 +0000 (UTC)
Received: from secure.mitica (ovpn-116-25.ams2.redhat.com [10.36.116.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 28B1610013A1;
 Thu, 12 Dec 2019 22:20:34 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/10] Migration Arguments cleanup
Date: Thu, 12 Dec 2019 23:20:23 +0100
Message-Id: <20191212222033.1026-1-quintela@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: Zo7ECFu_PEOLziuLzVf0bA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Juan Quintela <quintela@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

This series simplify test_migrate_start() in two ways:
- simplify the command line creation, so everything that is common between
  architectures don't have to be repeated (DRY).
  Note that this bit remove lines of code.
- test_migrate_start() has two bools and two strings as arguments, it is ve=
ry
  difficult to remmeber which is which and meaning.  And it is even worse t=
o
  add new parameters.  Just pass them through one struct.

Please, review.

Juan Quintela (10):
  migration-test: Create cmd_soure and cmd_target
  migration-test: Move hide_stderr to common commandline
  migration-test: Move -machine to common commandline
  migration-test: Move memory size to common commandline
  migration-test: Move shmem handling to common commandline
  migration-test: Move -name handling to common commandline
  migration-test: Move -serial handling to common commandline
  migration-test: Move -incomming handling to common commandline
  migration-test: Rename cmd_src/dst to arch_source/arch_target
  migration-test: Use a struct for test_migrate_start parameters

 tests/migration-test.c | 265 +++++++++++++++++++++++------------------
 1 file changed, 147 insertions(+), 118 deletions(-)

--=20
2.21.0


