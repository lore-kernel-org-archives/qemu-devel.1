Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76D95C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:05:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44C6422313
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 09:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O3ya9g3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44C6422313
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWzRZ-0006gQ-9k
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 04:05:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56232)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <armbru@redhat.com>) id 1iWzNQ-0004G6-7k
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1iWzNM-0004aT-RY
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:47 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:34275
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1iWzNM-0004aH-JV
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 04:00:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574154043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HNhLQgHHasV7jBYpL0FGXN27Gp9jfAgPM/xC+EEItW8=;
 b=O3ya9g3QM8Wo29Q6PlGG0ANwDIvcONUP0MtR2ga3kafdzBTvgriBQc00EmylR9toZ7jI4H
 YqQzNYmcMi5wHE18ful3xrP+zEw5yesE1gddtxVBRYbEb344uodpkxbUbnQHjYCGhI8jLr
 wcE+uWodgkxRyJNElkjtV9gyRjLfd6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-357-gYUTzuduNem3DBcc0NxfZw-1; Tue, 19 Nov 2019 04:00:40 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FD5F801FD2;
 Tue, 19 Nov 2019 09:00:39 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.36.118.163])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 149A45E243;
 Tue, 19 Nov 2019 09:00:38 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 71E331138606; Tue, 19 Nov 2019 10:00:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/1] Monitor patches for 2019-11-19
Date: Tue, 19 Nov 2019 10:00:36 +0100
Message-Id: <20191119090037.21686-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: gYUTzuduNem3DBcc0NxfZw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: w.bumiller@proxmox.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'd like to propose this bug fix for -rc2.  Certain usage of QMP can
leave the monitor permanently wedged (depends on event timing).
Libvirt does not use it this way as far as I know.  I understand it
affects other applications.  It's not a a regression in 4.2.

If it's too late for fixing it in 4.2, we'll punt to 5.0 with cc:
qemu-stable.

The following changes since commit a5c2a235103ab366ad5318636ec138e52c6dcfa4=
:

  Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into stagi=
ng (2019-11-18 17:06:17 +0000)

are available in the Git repository at:

  git://repo.or.cz/qemu/armbru.git tags/pull-monitor-2019-11-19

for you to fetch changes up to 2895aaa139b3f916b3650ca516b35dceb9c0d4c4:

  monitor/qmp: resume monitor when clearing its queue (2019-11-19 08:21:47 =
+0100)

----------------------------------------------------------------
Monitor patches for 2019-11-19

----------------------------------------------------------------
Wolfgang Bumiller (1):
      monitor/qmp: resume monitor when clearing its queue

 monitor/qmp.c | 36 +++++++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 5 deletions(-)

--=20
2.21.0


