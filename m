Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9EFC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E47B92084E
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 03:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=danwin1210.me header.i=@danwin1210.me header.b="CGO947kG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E47B92084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUNEN-0007E4-3k
	for qemu-devel@archiver.kernel.org; Mon, 11 Nov 2019 22:52:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kmcopper@danwin1210.me>) id 1iUNDF-0006Ks-Ip
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:51:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kmcopper@danwin1210.me>) id 1iUNDE-0003bX-Es
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:51:29 -0500
Received: from danwin1210.me ([2a01:4f8:c010:d56::1]:33905)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kmcopper@danwin1210.me>)
 id 1iUNDD-0003ak-Up
 for qemu-devel@nongnu.org; Mon, 11 Nov 2019 22:51:28 -0500
Received: from localhost (unknown [10.8.3.3])
 by danwin1210.me (Postfix) with ESMTPA id 55AD91F515
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=danwin1210.me;
 s=mail; t=1573530682;
 bh=NN5bujsWX2iyGRkFY4xRiZD0nVWwpqpDbFlYB3CVlGI=;
 h=From:To:Cc:Subject:Date:From;
 b=CGO947kGgkq86Px4VtHhEd28V0/tzOepRYT2YFoB8MavXDpX1ab1PCikDq9X5ttyA
 j8ZDftpO10fJx/to5PX8g4BAijpSvF35Kjgo2EP/NCb5cL+ANJXc/Fi7Aze9g+ln3S
 GYpmaYlh9nzdutx4XY+KhXlomKII4jDZPOIgt7GHgzfk3C17JV8kfgii7Q/IFItAuM
 9FwGXQOwEttlZExLMe+jXBhEOmetc+q2rNonF6RXQVfHYIG1Za32lSlWI6PfPAT9JF
 iiSRx3FWu8Br6avNEHGY2vJ81u/aIH/aR/kQQQRxh7QvLw9Wc0P6jpwP+kT6aBUmLr
 MGVgthdjPse28NOgVO+ySuRntrWFulfS+zOtcTqDYnsZX17+fbhM7mQCEdxbZYFsi/
 6XZInZGN7sJ8q8Blv8wKkKu1OPGTbJJFT12KGR6AjimEYSvvmycgWR2W3TuIpvV9iM
 Jwl5YwKxly7vQMU9Sd57Hh2ODnBHVg8QfXGRcMGrfu9p0kmLDVstxV/OaWBY+CPP7O
 e5A11/XGlyoj+SjPcQTXr9NLjQymX55mx2ToGlpWeUYyBF807X7rapqY9XURvPwQix
 2gherU2qR7/u5dkZiIebsfsd0STRd/LV/pPhHqJFGlbJj9IT9YbZQzYMPKNlcw8frR
 ay/1LBUbO6QzrqIsYxByVjf0=
Received: from danwin1210.me (localhost [127.0.0.1])
 by localhost (Postfix) with ESMTP id 149F910169F
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 03:51:22 +0000 (UTC)
X-OPENPGPKEY: Message passed unmodified
To: qemu-devel@nongnu.org
Cc: Kyle Copperfield <kmcopper@danwin1210.me>
Subject: [PATCH] i386: define the 'flush_l1d' CPUID feature bit (CVE-2018-3646)
Date: Tue, 12 Nov 2019 03:50:43 +0000
Message-Id: <20191112035043.54600-1-kmcopper@danwin1210.me>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.101.4 at proxy
X-Virus-Status: Clean
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a01:4f8:c010:d56::1
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
Reply-to: Kyle Copperfield <kmcopper@danwin1210.me>
From: Kyle Copperfield via <qemu-devel@nongnu.org>

New microcode introduces the "Flush L1D Cache" CPUID feature bit.
This needs to be exposed to guest OS to allow them to protect against
CVE-2018-3646.

Signed-off-by: Kyle Copperfield <kmcopper@danwin1210.me>
---
 docs/qemu-cpu-models.texi | 7 +++++++
 target/i386/cpu.c         | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/docs/qemu-cpu-models.texi b/docs/qemu-cpu-models.texi
index f88a1def0d..1b5349d86a 100644
--- a/docs/qemu-cpu-models.texi
+++ b/docs/qemu-cpu-models.texi
@@ -180,6 +180,13 @@ Must be explicitly turned on for all Intel CPU model=
s.
 Requires the host CPU microcode to support this feature before it
 can be used for guest CPUs.
=20
+@item @code{flush_l1d}
+
+Required to enable strong Foreshadow-NG (VMM) (CVE-2018-3646) fixes in
+guests.
+
+Requires the host CPU microcode to support this feature before it
+can be used for guest CPUs.
=20
 @item @code{ssbd}
=20
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index a624163ac2..1fb6d677e2 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1083,7 +1083,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WO=
RDS] =3D {
             NULL, NULL, NULL /* pconfig */, NULL,
             NULL, NULL, NULL, NULL,
             NULL, NULL, "spec-ctrl", "stibp",
-            NULL, "arch-capabilities", "core-capability", "ssbd",
+            "flush_l1d", "arch-capabilities", "core-capability", "ssbd",
         },
         .cpuid =3D {
             .eax =3D 7,
--=20
2.24.0


