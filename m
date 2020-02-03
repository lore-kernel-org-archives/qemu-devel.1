Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25747C35247
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E74CB20721
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:02:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NuBFgFQj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E74CB20721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43953 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyeB9-0005w1-4f
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:02:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:38725)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iye9p-0004j1-FN
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:01:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iye9k-00036O-Lv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:01:04 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iye9k-000315-Gz
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580745658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=IAdqvzQNt8vvFcm9pzVdkYtmWpjLOlEKovoZ56WEzKg=;
 b=NuBFgFQjJ5hCA9bd6NTLELQv9MEp7Ex0srmL1R5KUmfAJSrbrfVQp1+JNOgYX4S9s4Q+aB
 Pq4BVmKg19SMygTMkwSzJDQTSHChw9BWvwX2XlP/nUnId8HbGOkE4E6/g0eIxxuPXzXMt+
 TQ95gNp9OejQ8WHX5qD+3D/3lEherGQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-HKIGd7IIMYyNTlmPMibQ1w-1; Mon, 03 Feb 2020 11:00:53 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5A3DF63AD8;
 Mon,  3 Feb 2020 16:00:50 +0000 (UTC)
Received: from thuth.com (ovpn-116-129.ams2.redhat.com [10.36.116.129])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 98E8E5D9CA;
 Mon,  3 Feb 2020 16:00:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Fix typo of the have_afalg variable
Date: Mon,  3 Feb 2020 17:00:46 +0100
Message-Id: <20200203160046.23194-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: HKIGd7IIMYyNTlmPMibQ1w-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Longpeng <longpeng2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The variable is called 'have_afalg' and not 'hava_afalg'.

Fixes: f0d92b56d88 ('introduce some common functions for af_alg backend')
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 5095f01728..115dc38085 100755
--- a/configure
+++ b/configure
@@ -5843,7 +5843,7 @@ fi
=20
 ##########################################
 # check for usable AF_ALG environment
-hava_afalg=3Dno
+have_afalg=3Dno
 cat > $TMPC << EOF
 #include <errno.h>
 #include <sys/types.h>
--=20
2.18.1


