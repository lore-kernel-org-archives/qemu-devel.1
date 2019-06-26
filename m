Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37D71C48BD6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12020208E3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 20:05:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12020208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgEAc-0000oa-Bt
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 16:05:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35077)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hgE8t-0007ra-7H
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hgE8l-00014N-P9
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 16:03:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:47723)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1hgE8f-000101-Vw; Wed, 26 Jun 2019 16:03:31 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N2E9Y-1iiNzw2I74-013gr2; Wed, 26 Jun 2019 22:02:58 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 22:02:51 +0200
Message-Id: <20190626200252.30220-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190626200252.30220-1-laurent@vivier.eu>
References: <20190626200252.30220-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6Eu+HSQFiVFuj5n34n9byGYW1DCaRx0C6Pl2ex5KQhZc9CYgSTe
 0diqwb6b7oHg+N/+QACDCwfGV1+stUC/IC+SLrgY8ICBDvo7hAw3qLqqm+ovvis7PpS/CaQ
 qYv/YFQo9SIhdYa1wtYUyU6HW+eSZXQENYYtQlCIvtVBdIC7HN98gu7ZqMoR718xzohyBn+
 xcY/rbbv+lLxMdlXNfkWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hloth9wYqoM=:pPPx9cKo2Yenaqt0777Vpq
 UWJj3lSlH0jaJJf7fDFuHtAYAWe6dPH1iA8A5k2iZhvPJcI1NOVrcEg3HpbSuGncikAoZ8pkg
 5cD4F1sGOvVCW4FkbR1Ujlk1lUNIs17VEbFB3tWoTNyC16E/KIBkySJTVUk50Gxs5WLnHJeew
 lOrvtV0kXZf5w08iKWBQeRPrtpDY7QpceFlOBX/TQvx0CCbsbK1U6de1YqSVH6HMhae/cjcSh
 XOwfze/juSUQBRzrXcLndtxlJ5apAuW2OwDmdDxPb696YXStEOWKG2d73/kQ2gayKuspbkKMt
 pbKFOdZvbfrBNvkxUzkTqdom88z0DkW8jBRIqy511hNt+C84WVl8lKQ6Yn/d0LWZqAw8e3lPn
 8dhulLdem/VSFAQSUQEWbZkuuG7tLo8VIxxGg146CpzQWev/vBa9apFKbLsAPzO6G0Lmd8GHB
 1TapaTsCM83R+aRc1ytKmY10Va8eE74hNoC1MxMhzp4Su8rlD3jRJQbNODmgpME26LP0OPvuH
 dsiHZTt9laimVKjnvUSTUbw1bZKuJB6XMJkI1U9ZIkG4aGoyR05Euiht/XeyxOADUba2jajvL
 FunGXnksfpOKd9yvvhhJRNWDBphSSiMqrxFOl+jHF+wdEDlWB3lu1UNbjTM54gahQ6xtgzwWl
 liM4WrvkJfJjhmu2qT1NEYw3g9ikltOk7XvrbMDtAuPfcDNRS9qtTpCcHzJ/p6b/fLtQLFrNl
 J8ZiC6fglB1RxaTAVAzXeoqKzxqpB2bUPOha0HDui+gnWalmPGfB82DTcmY=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 3/4] configure: use valid args testing
 sem_timedwait
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
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Daniel P. Berrangé <berrange@redhat.com>

The sem_timedwait function has been annotated as requiring
non-null args in latest header files from GCC snapshot
representing the future 2.30 release.

This causes configure to fail when -Werror is used:

config-temp/qemu-conf.c: In function ‘main’:
config-temp/qemu-conf.c:2:25: error: null argument where non-null required (argument 1) [-Werror=nonnull]
    2 | int main(void) { return sem_timedwait(0, 0); }
      |                         ^~~~~~~~~~~~~
config-temp/qemu-conf.c:2:25: error: null argument where non-null required (argument 2) [-Werror=nonnull]

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190617114114.24897-1-berrange@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index cf3d9d30bfce..f94633101094 100755
--- a/configure
+++ b/configure
@@ -5144,7 +5144,7 @@ fi
 sem_timedwait=no
 cat > $TMPC << EOF
 #include <semaphore.h>
-int main(void) { return sem_timedwait(0, 0); }
+int main(void) { sem_t s; struct timespec t = {0}; return sem_timedwait(&s, &t); }
 EOF
 if compile_prog "" "" ; then
     sem_timedwait=yes
-- 
2.21.0


