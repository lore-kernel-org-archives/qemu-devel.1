Return-Path: <SRS0=nlPZ=TC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6A5AC43219
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:07:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2122085A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2019 19:07:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2122085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57474 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMH3h-0002R9-Rz
	for qemu-devel@archiver.kernel.org; Thu, 02 May 2019 15:07:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36352)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvq-0003nd-0E
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMGvo-00036r-0t
	for qemu-devel@nongnu.org; Thu, 02 May 2019 14:59:45 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:51429)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMGvi-000345-00; Thu, 02 May 2019 14:59:39 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MbjBo-1glYC01KHe-00dHYJ; Thu, 02 May 2019 20:59:02 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  2 May 2019 20:58:32 +0200
Message-Id: <20190502185835.15185-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190502185835.15185-1-laurent@vivier.eu>
References: <20190502185835.15185-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:emdVrM76Q9ZEwCt3gx+FcPMEVNlFoFdGjNYiDdUfivFiNUywUmo
	Pdm93O77b65iwG8WV78xD0AOErIyYJek7OJKojo8+TDeBLZsV+aLxMDL9Mm82nDhEeiNsiP
	ficUJejGofvek/lDs7yvaOygFoMjShIcNFToa+y1fbYIwpeCVef1R8koBbBb2A2B4uEFpjk
	eWXrl06DqhqnSdM36vljQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:un3pcgT1kvc=:Ee2aYE/fsfQN4vI90Ph2Ut
	Eq2QcByaDVoRJCK+dRQsZg6yt04d2dgJVNTDnJkz9YIw62S6rM9lK4mbZfjgW3Fq1QLT9x3rs
	pgiFgXXqhP6fu755rVnzGIAZPrhk7zkgLln8SVU7EjVPY1DXJOWL8BWKRhfZJkDhp6dWyhKFE
	CkRIMBPtHlFuFg+PEZPtz8hbrO+/1E2ETa2xQ7B795T/EDLEUDyPv1RLma6VR9wlNZW60dvqi
	uxvTvJUKbXTRcGDX/ZwtCgkImGvcD6sSuB8dPZieg5lGDtmUQ2rUZ2zn4+OZzVncSozbOlYSb
	2KBdjEYDFrC/WwsLzbLPCWWsMLHaLXfLye33fDocHkOVcL68zd3ZU3ANjDXNSSWt2IsUw1liq
	ny63RRxP8lMDImZj0Jpa8w+4l6j2HRFm7uSWwCtXf4WLSB88Mfg6aTHB9aXUtywBB2KFrNqkN
	pSasz/xVu1Erb+emN8YCuttjPvM3mYeIXdn6fs/j/l+4nAofjnRiQwE6MsedaqDFwimszSwcK
	KQV0eOdfT6xtFBdKYgAJz/1sb0lCvX1NMG34VMY7EptGh7H+Ppt51Yey4mWJ1qmI2Pcg94mxR
	N29KuI3QoMtLwhd2ULna9VimbM7KOsSlwbYJ2cPRVb4TK85qo4qJuYehRehzIoJPc0ywX+5fX
	sTMi1lIuqm83hbEUAciuDBhr9wIJx6mwXk65XJVxzvDYCYeZ+LvsoKGoroaT+z2vClaVJaZxO
	pWzfOaMvLCfijWIGR3Tw0dsXf9Uewqc2cYfjBBRbWDCRTM56IwIBSDQhDqE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: [Qemu-devel] [PULL 10/13] net: Print output of "-net nic,
 model=help" to stdout instead of stderr
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
	Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, qemu-trivial@nongnu.org,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Artyom Tarasenko <atar4qemu@gmail.com>,
	Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
	Eduardo Habkost <ehabkost@redhat.com>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Fabien Chouteau <chouteau@adacore.com>,
	=?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
	Richard Henderson <rth@twiddle.net>,
	Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
	Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190502185832._1FWr4363nVcZCSEW7HIa0Wce4ytSV5hqhYJDkg6mJY@z>

From: Thomas Huth <thuth@redhat.com>

We are printing all other help output to stdout already (e.g. "-help",
"-cpu help" and "-machine help" output). So the "-net nic,model=help"
output should go to stdout instead of stderr, too. And while we're at
it, also print the NICs line by line, like we do it e.g. with the
"-cpu help" or "-M help" output, too.

Buglink: https://bugs.launchpad.net/qemu/+bug/1574327
Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190423160608.7519-1-thuth@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 net/net.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/net.c b/net/net.c
index f3a3c5444cc3..2cf5e7646997 100644
--- a/net/net.c
+++ b/net/net.c
@@ -837,9 +837,10 @@ int qemu_show_nic_models(const char *arg, const char *const *models)
         return 0;
     }
 
-    fprintf(stderr, "qemu: Supported NIC models: ");
-    for (i = 0 ; models[i]; i++)
-        fprintf(stderr, "%s%c", models[i], models[i+1] ? ',' : '\n');
+    printf("Supported NIC models:\n");
+    for (i = 0 ; models[i]; i++) {
+        printf("%s\n", models[i]);
+    }
     return 1;
 }
 
-- 
2.20.1


