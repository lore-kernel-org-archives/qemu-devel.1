Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 118A2CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:01:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFC372084C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 11:01:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SNHplR8t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFC372084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37842 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMVRj-00040n-RZ
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 07:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45823)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iMVKQ-0004Qe-Lz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iMVKP-0001rO-FG
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:22 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30060
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1iMVKP-0001qy-Al
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 06:54:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571655260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXJRCDn0+l4gCV7yTkBZRBy899zbb0rUJ6QExh/wgTM=;
 b=SNHplR8tQsnjYSRq+66r1OrPxvHwgFjbe+OmcYb6qRWF6sq2LIeEKgLKJurcJpHizy1Hqz
 4Dif5GArjaY7CWUX3ITq8waTcJH10d0QOIEMaFMW3jVbREEajYWWPSOmWI3ZIksPjLM874
 sxlCJpQLcybmKKv7KGGb1lkTx/1oN0M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-296-dN9MG7_pP8eUqcMcNZZ4lw-1; Mon, 21 Oct 2019 06:54:18 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EF595ED;
 Mon, 21 Oct 2019 10:54:17 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3621960BE2;
 Mon, 21 Oct 2019 10:54:16 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Max Reitz <mreitz@redhat.com>,
	qemu-block@nongnu.org
Subject: [PATCH v2 6/6] iotests: Remove 130 from the "auto" group
Date: Mon, 21 Oct 2019 12:53:50 +0200
Message-Id: <20191021105350.1710-7-thuth@redhat.com>
In-Reply-To: <20191021105350.1710-1-thuth@redhat.com>
References: <20191021105350.1710-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-MC-Unique: dN9MG7_pP8eUqcMcNZZ4lw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter hit a "Could not open 'TEST_DIR/t.IMGFMT': Failed to get shared
'write' lock - Is another process using the image [TEST_DIR/t.IMGFMT]?"
error with 130 already twice. Looks like this test is a little bit
shaky, so for the time being, let's disable it from the "auto" group so
that it does not gate the pull requests.

Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/group | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 2dd671b82e..9f99f8623f 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -151,7 +151,7 @@
 127 rw auto backing quick
 128 rw quick
 129 rw quick
-130 rw auto quick
+130 rw quick
 131 rw quick
 132 rw quick
 133 auto quick
--=20
2.18.1


