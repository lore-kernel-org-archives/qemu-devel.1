Return-Path: <SRS0=m554=56=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB6EC2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B27A2206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2020 16:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5hnBfwI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B27A2206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34542 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jOOcF-00066M-Py
	for qemu-devel@archiver.kernel.org; Tue, 14 Apr 2020 12:40:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56335)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jOOb8-0003pI-7u
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jOOb7-0005H2-93
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:42 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:34594
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jOOb7-0005Gq-5b
 for qemu-devel@nongnu.org; Tue, 14 Apr 2020 12:39:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586882380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=qjwYkl3cRbkwG2uxirET7doz0xycLkTnyirONRVyO/M=;
 b=d5hnBfwIG084tnAUpqX1fH13420VMS238gO4klfJv1khXBlmja0lNvMGncoTaLlxXsUjnM
 EeTLPg+0xOmgImIR7/+HItuR3lYohY7dTEq0pBtA0+D7Vd+ieChfHQeGEGzSULh/sT5/Tq
 ZzOKupIeGHfoWBb8W36guKhfILeIi7s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-00T9SOqMPhOkf6uSuNRSiQ-1; Tue, 14 Apr 2020 12:39:39 -0400
X-MC-Unique: 00T9SOqMPhOkf6uSuNRSiQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5CC83102C8BB
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 16:39:38 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 22DCD60BEC
 for <qemu-devel@nongnu.org>; Tue, 14 Apr 2020 16:39:38 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/3] More misc patches for QEMU 5.0-rc3
Date: Tue, 14 Apr 2020 12:39:34 -0400
Message-Id: <20200414163937.29669-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 267514b33ffa3f315adc26fc14d89f92e90840f5=
:

  module: increase dirs array size by one (2020-04-13 02:56:18 -0400)

are available in the Git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 9f5a0664187e9411c5c6b7dbd21a1f50922cf698:

  hax: Windows doesn't like posix device names (2020-04-14 10:37:42 -0400)

----------------------------------------------------------------
Bugfixes, and reworking of the atomics documentation.

----------------------------------------------------------------
Igor Mammedov (2):
      hostmem: set default prealloc_threads to valid value
      tests: numa: test one backend with prealloc enabled

Volker R=C3=BCmelin (1):
      hax: Windows doesn't like posix device names

 backends/hostmem.c        | 1 +
 target/i386/hax-windows.c | 4 ++--
 tests/qtest/numa-test.c   | 2 +-
 3 files changed, 4 insertions(+), 3 deletions(-)
--=20
2.18.2


