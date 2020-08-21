Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF4DBC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:15:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A5D9207C3
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 15:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J1LgmQXj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A5D9207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k98kw-0006mH-Nk
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 11:15:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98kM-0006GL-5r
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:14:26 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:54602
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k98kJ-0004Nm-9B
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 11:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598022862;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9wW2R1txbDruOQwk4ej7U8TTbA4SEYTfXBJdpBxm1P0=;
 b=J1LgmQXjGjBBHuBI+I/dOnNpS3JYnkK6AM3L+3iuRZTiqFuOwd9IDiwM7SsiDSEFw4rjGD
 7R+Ok+d91H3Ol5o2rmJrLbNAsQXKDoM8qKbrlXO9+kWG40qpqDfcgQ9mBBCvgr5LdFAXWt
 TRM/tg/w9LXnBw/6SV0iSVv++sJnDWk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-165-EAkn8gBwN1aH8H_taupvfA-1; Fri, 21 Aug 2020 11:14:20 -0400
X-MC-Unique: EAkn8gBwN1aH8H_taupvfA-1
Received: by mail-wr1-f69.google.com with SMTP id s23so632591wrb.12
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 08:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=9wW2R1txbDruOQwk4ej7U8TTbA4SEYTfXBJdpBxm1P0=;
 b=YMtb5m5x6ny4FbHCX5LyhdUO/tdYCKqpX11s2VVvyQbThkkAoJIQ0tJngBbEpPwHS8
 ZoITq7Drbl9B5XimEPWwJ+NF3SXMbMD4YJrHCtwF9RRWEpf6aO1Xxh0xmtft9QSZ17az
 j/HoATcPIZjTmkGHFQdJX8Lj6+HcZrVI/7+xqv3Vuj5YSnfssyZ4XDgdlWjZAz2sWHfH
 gcYrqJelfXd6tuk9822abz/uQj07TrZb21WKsrN9DfjzX+9vtEIdkCawagydlcXeqHue
 XWE8zRdvkoSkjevwOgbU1HszrPnC9jJfkV7lMMLfAzrszRQKBXDxGiAZWLzVBw4Kp21u
 zxIA==
X-Gm-Message-State: AOAM530I4a/2PIHPPJplgKawpXFthiw7oAH3FDgwy27JO0FCfC82hIgP
 Zgy/aHmGNgk43M6MvnDJNNmOOEjtS6r679a5wceUtR4Sg8NN6aJWj3N5nv4xHK8LI4JncUIAMZz
 +o387YbHT6bMfiXg=
X-Received: by 2002:adf:fbc6:: with SMTP id d6mr3235224wrs.189.1598022858943; 
 Fri, 21 Aug 2020 08:14:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8mCDgChHVeJcHIrS83PxYMRgIiV0Yp26sDWfi7Jf2P20ks01HMDhfnYLpp47IS8uplWojMw==
X-Received: by 2002:adf:fbc6:: with SMTP id d6mr3235197wrs.189.1598022858676; 
 Fri, 21 Aug 2020 08:14:18 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id l7sm5540760wmh.15.2020.08.21.08.14.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2020 08:14:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: Silence shift warning in version_ge()
Date: Fri, 21 Aug 2020 17:14:16 +0200
Message-Id: <20200821151416.1240494-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 05:15:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As we might expect less than 2 argument, only shift again
if there is arguments to shift.

This fixes:

    ../configure: line 232: shift: shift count out of range

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index 4e5fe332110..cf044ad2d25 100755
--- a/configure
+++ b/configure
@@ -229,7 +229,7 @@ version_ge () {
         set x $local_ver1
         local_first=${2-0}
         # shift 2 does nothing if there are less than 2 arguments
-        shift; shift
+        shift || shift
         local_ver1=$*
         set x $local_ver2
         # the second argument finished, the first must be greater or equal
-- 
2.26.2


