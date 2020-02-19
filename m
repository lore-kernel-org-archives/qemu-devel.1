Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7C75C34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:21:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C3E24658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:21:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C3E24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MTT-0001Ya-LL
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53248)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPd-0003VN-4P
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPb-00053Y-Ur
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:01 -0500
Received: from mout.kundenserver.de ([217.72.192.74]:48735)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPY-0004wJ-KJ; Wed, 19 Feb 2020 05:16:57 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MA844-1jBX864Afq-00BZbZ; Wed, 19 Feb 2020 11:16:25 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 03/17] scripts/checkpatch.pl: Detect superfluous semicolon in C
 code
Date: Wed, 19 Feb 2020 11:15:58 +0100
Message-Id: <20200219101612.1033925-4-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:IXjQSl0/la5Z164rm+NUocD7xxaoxaSU6n1TNuuHRPZySrnB6ZK
 ERe9mV2ShoYfilQNcB/XWW26hyR3PLF4xK4+AmGpRcGl3/5CD9liea+WM0dbL9DOi+qkCeP
 QuR2bJN3cFWKOsZNa6YfHyJndq8+/GWKYzTDzP5C74KkPHePbTCmVZg4fwhAC7USJnIHXFj
 bF47FrPpZzFc5ljlKUGag==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AkDA87X+Y5E=:6ksXsQXRv/pp0BO0P6vdkL
 o/cUtpoes6GpFbmnioboLNgjaKlV4Dhc7/87lXiP++/TDvJGwn5TySJ3ZoJM69bl67Uh0L4S7
 jALtHU25lPO1+uif/yuHJBLir6mDnfGbLhezdXcuHLwhv7m4sTS2PWIWA3A9burkzV0jGmMC+
 OvAQumCZj8zS1BuLtg8cQFGFb6tB4qiMXbtACVYcMIo5t7lKDLgirJOrZ2GXpg/6To6V6GCwF
 //Gs7Tp0epABuZsTCsxeQJNIT/qJjsiMq2MSpvHIATR+mTIXkPYIfHLQjWliyKmGHhAS5g3ca
 Jj/Xh0A3fl1J0myDlkrFjVXprYc5IfWmYhS7AmRnDtzclQI07atDTXK6YE6njQVBwPgA2geLK
 zFi+sZgY2L4uEo17kUiNm2dIDEVRWTDQMEeg9UQd3hzictBTULpxJdYGpMhIY34AQ9s12AHx9
 dgqfVWxZ0AGDHeOPn+P9LEaQ0CleOfpuIBsvPElMrw4IMKQHAr1/HKx7cm/SjOlxf2smfsDbR
 4s7qJQPn/vvxXvJSVacsEJTUoCp+3e036hYnbqNVlKfi4WkhU3puasGfDAk0K/1sdsmm3cHVE
 xdz7EdAhPu2HxPg9px1WILlj5xJ+pRFKhxYE9Rf30RkFDxdTw9u1SaXt0sg+dbQD5fErstm6B
 s4UEzPDCssKhyJyvhJfYAvLgvuZi1C6DChw1wk8ZjtKIW1C5agBWBcnKXk2nIHwW4LdwgqJYv
 oUniudlqOJq5RndusmdFVoHV7eGkkfZb83gISD1duhCvAxvXycl/OXK3DYnbC/cIe+awVbCt2
 ixwyqBRUOydiBRtsVzi6p/iMLnqGZ0FzObvMiR2E1DbfNcJkGXVSIVOF1xqOebA0tj8uUrj
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.74
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Yuval Shaia <yuval.shaia.ml@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Marek Vasut <marex@denx.de>,
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 qemu-trivial@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>, qemu-arm@nongnu.org,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <huth@tuxfamily.org>, Chris Wulff <crwulff@gmail.com>,
 Laurent Vivier <laurent@vivier.eu>, Max Reitz <mreitz@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Display error when a commit contains superfluous semicolon:

  $ git show 6663a0a3376 | scripts/checkpatch.pl -q -
  ERROR: superfluous trailing semicolon
  #276: FILE: block/io_uring.c:186:
  +                ret = -ENOSPC;;
  total: 1 errors, 1 warnings, 485 lines checked

Reported-by: Luc Michel <luc.michel@greensocs.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Message-Id: <20200218094402.26625-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/checkpatch.pl | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index ce43a306f867..11512a8a09b8 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1830,6 +1830,11 @@ sub process {
 			ERROR("suspicious ; after while (0)\n" . $herecurr);
 		}
 
+# Check superfluous trailing ';'
+		if ($line =~ /;;$/) {
+			ERROR("superfluous trailing semicolon\n" . $herecurr);
+		}
+
 # Check relative indent for conditionals and blocks.
 		if ($line =~ /\b(?:(?:if|while|for)\s*\(|do\b)/ && $line !~ /^.\s*#/ && $line !~ /\}\s*while\s*/) {
 			my ($s, $c) = ($stat, $cond);
-- 
2.24.1


