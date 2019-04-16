Return-Path: <SRS0=xvb4=SS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D25C10F13
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99808206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2019 18:48:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99808206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40947 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGT82-0002QX-VD
	for qemu-devel@archiver.kernel.org; Tue, 16 Apr 2019 14:48:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6Q-0001e0-Gx
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6P-0005Hz-Bi
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:42 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:48702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dan.streetman@canonical.com>)
	id 1hGT6P-00058j-2s
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 14:46:41 -0400
Received: from mail-yb1-f199.google.com ([209.85.219.199])
	by youngberry.canonical.com with esmtps
	(TLS1.0:RSA_AES_128_CBC_SHA1:16) (Exim 4.76)
	(envelope-from <dan.streetman@canonical.com>) id 1hGT6N-00006W-37
	for qemu-devel@nongnu.org; Tue, 16 Apr 2019 18:46:39 +0000
Received: by mail-yb1-f199.google.com with SMTP id n18so16391575yba.9
	for <qemu-devel@nongnu.org>; Tue, 16 Apr 2019 11:46:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:from:to:subject:date:message-id:mime-version
	:content-transfer-encoding;
	bh=fkDEhZ2o3tPIW3GrdfSX85lrCARfcz4Utog34tks2y0=;
	b=erGQsIlwVqtfa2MqKfcR3JzXDCk1UJ9ZEAoAHHlt9CnwfdcIUsiYJH9wRizHME8nep
	nfFsa3wJWRj4ty4kzgwQU9HhobkDXBxzymYc48wLo4Ga7HqGlc1I+O1UQNAZSJaTCJ5Q
	pjD7tVeuJPl5nvjqhYTZ2NQfsXF/sDXaPbrGdOGZGBUCNAsQO9LaKBA0t1XM6TY1bysb
	q+IOiGywRsUIl8vt3r+3ZOoRuc2UcOWYErJrn4jvJyklZ67Iy1rlh7YgB2EugsaA1Snt
	fOfPHCDPaEJfU4oOXWTA41iNMCkknb7QTD6kg2/brEAEYfYa9vizM5ST9miDGGyaqnDo
	gw0A==
X-Gm-Message-State: APjAAAXVOVDR7veiiplLRN2sdDU8MJ1qw/fX+6EDMW8+mmlIP/Gvrsz4
	aBC5GjDNDqTQji47kz0j8+7HqdvUuy+oihUxzaEw2+66eH1Ip/6mWw5H3ktoTezSUq/8SqUi98f
	4sZUDv5JQaDQzyvosIHMPq1IffqVzv6Z/
X-Received: by 2002:a5b:c7:: with SMTP id d7mr48102246ybp.284.1555440398189;
	Tue, 16 Apr 2019 11:46:38 -0700 (PDT)
X-Google-Smtp-Source: APXvYqymJR0gMzX2beqyBTXH83ow6fTyt+E7MR0flux5OT3rIuaW7ivkm85IWshI0AwB+0/E+0zVQg==
X-Received: by 2002:a5b:c7:: with SMTP id d7mr48102231ybp.284.1555440397951;
	Tue, 16 Apr 2019 11:46:37 -0700 (PDT)
Received: from thorin.lan (45-27-90-188.lightspeed.rlghnc.sbcglobal.net.
	[45.27.90.188]) by smtp.gmail.com with ESMTPSA id
	c205sm17554833ywc.10.2019.04.16.11.46.37
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 16 Apr 2019 11:46:37 -0700 (PDT)
From: Dan Streetman <dan.streetman@canonical.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org
Date: Tue, 16 Apr 2019 14:46:22 -0400
Message-Id: <20190416184624.15397-1-dan.streetman@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 91.189.89.112
Subject: [Qemu-devel] [PATCH 0/2] vhost-user race condition on shutdown
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416184622.4EepiWsQ4H0ftmkV6ESYZonHRoIqklGZ78oFq-oc0Nk@z>

From: Dan Streetman <ddstreet@canonical.com>

Buglink: https://launchpad.net/bugs/1823458

This is a race condition between the normal shutdown of a guest
and the handling of its vhost-user net being externally closed.
It's explained in more detail at the bug link; the short version
is that there are 2 problems, fixed by the 2 patches.  The first
patch fixes the race condition where multiple threads call
vhost_net_stop(), and the second patch prevents vhost-user from
calling vhost_net_cleanup() on CHR_EVENT_CLOSED, because it will
be cleaned up later and its fields will be accessed when
vhost_net_stop() is called later.

As explained in the bug report, this requires a rather complicated
setup to reproduce, and I'm not able to create a setup to reproduce
it myself.  However this has been reported to me/Canonical, and the
reporter is able to reproduce it consistently, so I've used them for
debug and testing.  This reproduction was done with the older 2.5
qemu, from Ubuntu Xenial; but the problem does still appear to exist
in upstream qemu, based on review of the code, which is why I'm sending
these patches.

Dan Streetman (2):
  add VirtIONet vhost_stopped flag to prevent multiple stops
  do not call vhost_net_cleanup() on running net from char user event

 hw/net/virtio-net.c            | 3 ++-
 include/hw/virtio/virtio-net.h | 1 +
 net/vhost-user.c               | 1 -
 3 files changed, 3 insertions(+), 2 deletions(-)

-- 
2.20.1


