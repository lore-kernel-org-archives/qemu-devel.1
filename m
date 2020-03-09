Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86038C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:42:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BF5620873
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 18:42:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BF5620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ehu.eus
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48004 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBNMe-0003dE-Gu
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 14:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNJI-0006Pk-Ct
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <unai.martinezcorral@ehu.eus>) id 1jBNJG-0004jO-Vh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:39:28 -0400
Received: from smtp.lg.ehu.es ([158.227.0.66]:25912 helo=smtp.ehu.eus)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <unai.martinezcorral@ehu.eus>)
 id 1jBNJF-0004iX-Tn
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 14:39:26 -0400
Received: from imsva2.lgp.ehu.es (imsva2.lgp.ehu.es [10.0.3.246])
 by postfix.smtp2.imsva2 (Postfix) with ESMTPS id 8F95E61E1;
 Mon,  9 Mar 2020 19:39:24 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5BC375A050;
 Mon,  9 Mar 2020 19:39:24 +0100 (CET)
Received: from imsva2.lgp.ehu.es (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 509FB5A045;
 Mon,  9 Mar 2020 19:39:24 +0100 (CET)
Received: from smtp.ehu.eus (unknown [10.0.100.76])
 by imsva2.lgp.ehu.es (Postfix) with ESMTPS;
 Mon,  9 Mar 2020 19:39:24 +0100 (CET)
Received: from 669c1c222ef4 (static.187.0.0.81.ibercom.com [81.0.0.187])
 by smtp2 (Postfix) with ESMTPSA id 0F5DF61E1;
 Mon,  9 Mar 2020 19:39:24 +0100 (CET)
Date: Mon, 9 Mar 2020 18:39:22 +0000
From: Unai Martinez-Corral <unai.martinezcorral@ehu.eus>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 5/9] qemu-binfmt-conf.sh: remove 'qemu' prefix from cli
 options
Message-ID: <20200309183922.GE14@669c1c222ef4>
References: <20200309183521.GA9@669c1c222ef4>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200309183521.GA9@669c1c222ef4>
X-Greylist: ACL 191 matched, not delayed by milter-greylist-4.6.2 (smtp2
 [10.0.100.76]); Mon, 09 Mar 2020 19:39:24 +0100 (CET)
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSVA-9.1.0.1631-8.5.0.1020-25280.001
X-TM-AS-Result: No-0.609-7.0-31-10
X-imss-scan-details: No-0.609-7.0-31-10
X-TMASE-Version: IMSVA-9.1.0.1631-8.5.1020-25280.001
X-TMASE-Result: 10-0.609300-10.000000
X-TMASE-MatchedRID: zi/SDN/U4yNXxVT6/C14BeFgDmzNVVKokRkcrpA9poA3ZbGC9oP/OzB9
 ccde3hbUf+3yqvQrlggtpxclXgLOJWQZ31TQwyj3YXOD42j+642nU+NxqV3DDV2YKfSY6fzM1jx
 n/1gr0UiuQih3+HqEP1e9QrNgNMNku1aOOerCaCkoSebb2328i30tCKdnhB58HOI0tZ7A+B36C0
 ePs7A07a10/0DMlNjcB1hkAxSn3qp3MbLx3aiXjk2voIlyWME6hpvJ/Pu+aTTw8vXnqhGMsTQTy
 YRgKtFXL47a7Z8JkyLUdaAWhRon8GjV5YOxSYvMNDDkhDzsQTLp+5dP4kj0S+Fheyow6ZGG0vzW
 LJp2OfpVyvbTg/runA==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-12:0,22:0,33:0,34:0-0
X-Greylist: Sender IP whitelisted, Sender succeeded SMTP AUTH, not delayed by
 milter-greylist-4.6.2 (postfix.smtp2.imsva2 [10.0.100.76]);
 Mon, 09 Mar 2020 19:39:24 +0100 (CET)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 158.227.0.66
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
Cc: riku.voipio@iki.fi, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This breaks backward compatibility.

Options 'qemu-path' and 'qemu-suffix' have the 'qemu-' prefix, which is
not present in other option names ('debian', 'systemd', 'persistent',
'credential'...). In order to keep consistency, the prefix is removed.

Signed-off-by: umarcor <unai.martinezcorral@ehu.eus>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qemu-binfmt-conf.sh | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/scripts/qemu-binfmt-conf.sh b/scripts/qemu-binfmt-conf.sh
index 870815fb22..5cc6db6aed 100755
--- a/scripts/qemu-binfmt-conf.sh
+++ b/scripts/qemu-binfmt-conf.sh
@@ -171,6 +171,7 @@ qemu_get_family() {
 
 usage() {
     cat <<EOF
+
 Usage: qemu-binfmt-conf.sh [options]
 
 Configure binfmt_misc to use qemu interpreter
@@ -179,8 +180,8 @@ Options and associated environment variables:
 
 Argument             Env-variable     Description
 -h|--help                             display this usage
--Q|--qemu-path PATH  QEMU_PATH        set path to qemu interpreter
--F|--qemu-suffix SUFFIX               add a suffix to the default interpreter name
+-Q|--path PATH       QEMU_PATH        set path to qemu interpreter(s)
+-F|--suffix SUFFIX                    add a suffix to the default interpreter name
 -p|--persistent      QEMU_PERSISTENT  (yes) load the interpreter and keep it in memory; all future
                                       uses are cloned from the open file.
 -c|--credential      QEMU_CREDENTIAL  (yes) credential and security tokens are calculated according
@@ -333,7 +334,7 @@ QEMU_CREDENTIAL="${QEMU_CREDENTIAL:-no}"
 
 QEMU_SUFFIX=""
 
-options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,qemu-path:,qemu-suffix:,exportdir:,help,credential,persistent -- "$@")
+options=$(getopt -o ds:Q:S:e:hcp -l debian,systemd:,path:,suffix:,exportdir:,help,credential,persistent -- "$@")
 eval set -- "$options"
 
 while true; do
@@ -365,11 +366,11 @@ while true; do
             fi
         fi
         ;;
-    -Q|--qemu-path)
+    -Q|--path)
         shift
         QEMU_PATH="$1"
         ;;
-    -F|--qemu-suffix)
+    -F|--suffix)
         shift
         QEMU_SUFFIX="$1"
         ;;
-- 
2.25.1



