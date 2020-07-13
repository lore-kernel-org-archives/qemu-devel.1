Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D83C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:58:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 019BB20773
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 10:58:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IJzFbSvG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 019BB20773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46196 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juwAT-0004bU-Va
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 06:58:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7i-000096-QU
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:28976
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1juw7g-0003x1-Do
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 06:55:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594637747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=aO1keFBsKf3vcu+Q9JgNlkxiw0haKoT15HjvT/KfGAI=;
 b=IJzFbSvG2wOHaxnHzuCv32L0o0Yw+P3i/126sjTYW6uR6covNqTvv2vQ1q7ZdgBvNEuTbB
 oej5LNjdfwBxzXRFxS6N3jUxHm4bm3gycofw88y31NsXaF3/WBl4SxC4iyqd3N6bomN31p
 e1EwYdLqLWUI8SaM8WdQWEk6dl+rd3w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-lrVLRacWOoS72OBt8nQYTw-1; Mon, 13 Jul 2020 06:55:45 -0400
X-MC-Unique: lrVLRacWOoS72OBt8nQYTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6B21A108B;
 Mon, 13 Jul 2020 10:55:44 +0000 (UTC)
Received: from thuth.com (ovpn-112-125.ams2.redhat.com [10.36.112.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9139C27CCC;
 Mon, 13 Jul 2020 10:55:43 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL 5/9] docs/devel/fuzzing: Fix bugs in documentation
Date: Mon, 13 Jul 2020 12:55:30 +0200
Message-Id: <20200713105534.10872-6-thuth@redhat.com>
In-Reply-To: <20200713105534.10872-1-thuth@redhat.com>
References: <20200713105534.10872-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 02:19:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix typo - the option is called "--fuzz-target" and not "--fuzz_taget".
Also use a different fuzzer in the example, since "virtio-net-fork-fuzz"
does not seem to be a valid fuzzer target (anymore?).

Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20200709084059.22539-1-thuth@redhat.com>
---
 docs/devel/fuzzing.txt | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/devel/fuzzing.txt b/docs/devel/fuzzing.txt
index 324d2cd92b..db5641de74 100644
--- a/docs/devel/fuzzing.txt
+++ b/docs/devel/fuzzing.txt
@@ -33,11 +33,11 @@ Fuzz targets are built similarly to system/softmmu:
 
 This builds ./i386-softmmu/qemu-fuzz-i386
 
-The first option to this command is: --fuzz_taget=FUZZ_NAME
+The first option to this command is: --fuzz-target=FUZZ_NAME
 To list all of the available fuzzers run qemu-fuzz-i386 with no arguments.
 
-eg:
-    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-net-fork-fuzz
+For example:
+    ./i386-softmmu/qemu-fuzz-i386 --fuzz-target=virtio-scsi-fuzz
 
 Internally, libfuzzer parses all arguments that do not begin with "--".
 Information about these is available by passing -help=1
-- 
2.18.1


