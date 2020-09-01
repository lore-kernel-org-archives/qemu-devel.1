Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D9AC433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8621F206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 14:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8621F206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD73X-0006MM-KS
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 10:14:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zK-0005Ra-Vq; Tue, 01 Sep 2020 10:10:19 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:60169)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kD6zF-0003mn-Ri; Tue, 01 Sep 2020 10:10:18 -0400
Received: from localhost.localdomain ([82.252.135.186]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MN5W9-1jucEO0eqD-00J61w; Tue, 01 Sep 2020 16:10:09 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 18/44] docs: Fix broken links
Date: Tue,  1 Sep 2020 16:09:28 +0200
Message-Id: <20200901140954.889743-19-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200901140954.889743-1-laurent@vivier.eu>
References: <20200901140954.889743-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+vZfMsL2aeP5mDvhJCgG1EfxnPH9cPYAmsuNrE9+KP2my/6K2fO
 FmuOAtwmmGS8nxABOv1RxMy7Sx9h/AP6vqtX97xiwTLzWyA8nQRu8+MuPcjlZYGzM6Zr2dm
 VkbUmn1zPiEA71qspNIWwsLj8BKYvZbiFdKJXYAwa9MDVfcgCOiW66frgDhd1PK52AiYxu9
 uWBnU1z5gCPahU3p3zr/A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VUFn8QefwbM=:/koVAmFzYVRyvHSS6/a05G
 IpmJov7MDilOR1BOV9KAO33wXzfm5brFXptu4tqLJ7ZJlvpYPmjPzzqdEeIUrDKLXn8stDZKO
 Gdoqu8gUf+wWjVDj1vDnre9h1Vio9AjVb3N4PIhE9SXe9QKeFQJ4PcSQSbp6LCbq4KgAd1Kw7
 1BxSiYvT9Y1EyruZMHPElJbpBxW4v5XHGHeJdzzjESWomYxgvtnRK2FD76U06iNYpNebv4l6X
 9U24t2v+T0nzIP5KDqHghksYSeP9j4fTtmA0nAvprqAhHgo0m9TJVkUntGSAYVngGcvh6DVay
 AbzQ8F8GkND7Q8gnXfPsSgi6dAeKs7IqZWjx92n5CISQvrI7kDkmWhHeAYpco2x0rakAmEl6F
 JrsAVyxG7D9kFfC023wTZlV/z0EbJlpigoX9h5Nb74k70fHlE5/7HzhbFHaWkFKEbctuBWbaw
 J2zeTiBYjSX/TPlNJwVEW78nUlDZtM5veg9gwlIbhV0tht44XDlCkk4Vn4gsLQFXxOTOCLx5Q
 tA7MDS6EhMW0BLceVVE5EKPnOFXwQ3vE1jQuWYOSVzmcJpOdq8ncp3kP/ivABhLZ7csh/kYMf
 Q84sAFJIW/Y7eZXcLpeomKbAht89LrmPjjm142BIvVz6BNh5o/wRTCUmqHWvTvG/cWwioBuZu
 SRFN5LLfV/4qzlPC1fWDqOEpjrHLYf61KVMRkIWUkfw9mjd5eip+VtjRcCyxn6Sa6TWRER/C/
 FAoK6AMMGdqajpnsgGgkTdEECvdjfXluOMuH7xRvCFoDOy85bEksXseSdp9FiBKNVqLIatLGA
 BKpcfcb8pCQ1VQULIXrUGHS7FU5a+T099j3tbPHQm3Yoyt7arUJrGI2sdO6T9us6J/vDKjl
Received-SPF: none client-ip=212.227.126.135; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 10:10:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Han Han <hhan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Han Han <hhan@redhat.com>

Signed-off-by: Han Han <hhan@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200807101736.3544506-1-hhan@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 docs/amd-memory-encryption.txt | 4 ++--
 docs/pvrdma.txt                | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/docs/amd-memory-encryption.txt b/docs/amd-memory-encryption.txt
index 43bf3ee6a5a9..80b8eb00e980 100644
--- a/docs/amd-memory-encryption.txt
+++ b/docs/amd-memory-encryption.txt
@@ -95,10 +95,10 @@ References
 -----------------
 
 AMD Memory Encryption whitepaper:
-http://amd-dev.wpengine.netdna-cdn.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
+https://developer.amd.com/wordpress/media/2013/12/AMD_Memory_Encryption_Whitepaper_v7-Public.pdf
 
 Secure Encrypted Virtualization Key Management:
-[1] http://support.amd.com/TechDocs/55766_SEV-KM API_Specification.pdf
+[1] http://developer.amd.com/wordpress/media/2017/11/55766_SEV-KM-API_Specification.pdf
 
 KVM Forum slides:
 http://www.linux-kvm.org/images/7/74/02x08A-Thomas_Lendacky-AMDs_Virtualizatoin_Memory_Encryption_Technology.pdf
diff --git a/docs/pvrdma.txt b/docs/pvrdma.txt
index 0f0dd8a7e562..5c122fe81813 100644
--- a/docs/pvrdma.txt
+++ b/docs/pvrdma.txt
@@ -18,7 +18,7 @@ over-commit and, even if not implemented yet, migration support will be
 possible with some HW assistance.
 
 A project presentation accompany this document:
-- http://events.linuxfoundation.org/sites/events/files/slides/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
+- https://blog.linuxplumbersconf.org/2017/ocw/system/presentations/4730/original/lpc-2017-pvrdma-marcel-apfelbaum-yuval-shaia.pdf
 
 
 
-- 
2.26.2


