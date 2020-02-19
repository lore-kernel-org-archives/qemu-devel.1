Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8762CC34047
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FCC24658
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 10:19:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FCC24658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48356 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4MSC-00071F-HM
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 05:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53415)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4MPn-0003e4-8Q
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4MPl-0005IH-WE
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 05:17:11 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:57205)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4MPl-0005Cn-Hs; Wed, 19 Feb 2020 05:17:09 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N8G6I-1jZPnm3yCm-014DQd; Wed, 19 Feb 2020 11:16:27 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/17] audio/alsaaudio: Remove superfluous semicolons
Date: Wed, 19 Feb 2020 11:15:59 +0100
Message-Id: <20200219101612.1033925-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200219101612.1033925-1-laurent@vivier.eu>
References: <20200219101612.1033925-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:YLibFIpZuSQgUlfjKxWHzCGGzkzdZqeA+J1NPtaqKX3dof7T9YQ
 atnabY9tD6WWwlISncER7PKliwcQz8ZEfu31p7eb3muO7uiSkG/MiFtWKBwDzARgQtkyQqq
 iLNbN85O5fe4CzRYOMUiEQ/1Ka2p1ZpgOzHtCYLs/o7hW9mAajgu2vTnn+bJx0lbgt6uvVF
 C76EO0Z4ERETqoIp868nw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3I0iL+lMVTY=:VCzKQXR5Xg/eAVWb074EU1
 PyX03r8ReNRQpHWI+8HEZbOMe5aNlySG1/kHRsHSpo2T7ZAurz7dUkCs4QvtDW5pAEP+1wrxs
 2uh3+A7sl4nS483hdhPapjgHDqv091x9Y5cMufdRE9dm6KEHC6Xjt7Kk0NKylXGgRJbbj3rq1
 ouckDsNL9nHl0rL69ip+TXPSTHQeqpm0LDiS7LBQvCSgqo6Ty1lyAKAz2h33H8Cz870EC7aFw
 egISIpgTy7TMpVY6tPmNP18V9KTkqIJcP7tkh2V6fzG3zxInJiQQqrNd7BDTz+GfKk8kzgl9B
 1DUTbfuYjhZwDJ+OOJSSa1DlaCS+MW9DqTBLMSN6bN4jv6AXkFEkqMzjJiqR3DU2IpgN3X412
 lHarYtfXAi50yNZvHWiLf+Oez6Pmh0kzJaksVUPdrP5wQwrfVZUqoZaoVD31g27ZFLRkxCInQ
 Jg/6Be2vFkmCTHhY+JgmzqwkwnLqy7jTmHoNbGfN+Tn1WSSgcpd2eqiT7MchSBQyCIAKZnhAP
 3iDCMoRVpv+aXI0+0uRjQrNpDQGzNkEviSj2OyAtsAQ5rJ7okkxJYuAjGQPgsoeNRVuFoIYcx
 qIIvLzw1UR9Q1GqLSSk3ejPTt8o8y3dD9PcRYZXIMwL0KVnOgeBNgwNqIghYC2xiE0NyvXgUk
 g2kQd2+6RAthmnhSrEEl3jDecnmbndB2ygzxxbMyOyHIN9iG5XlHAMB/X3SbFugilHPMHlc91
 wo5iw9aId9jzu5ab1bVDBbhEFHtZNcLBg+db1zQXW9Rwube8n0KgvX5AzTpBwVYRwfADTncPS
 rATP9/fLxGHY2OseOtVLnnUrgwN9ROMfZx6kVDWYJ+UEwwAPPyqL2RRsElaO5JhjWk9jbvw
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
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
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Fixes: 286a5d201e4
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20200218094402.26625-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 audio/alsaaudio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/alsaaudio.c b/audio/alsaaudio.c
index a23a5a0b60a1..a8e62542f97e 100644
--- a/audio/alsaaudio.c
+++ b/audio/alsaaudio.c
@@ -819,7 +819,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
             switch (nread) {
             case 0:
                 trace_alsa_read_zero(len);
-                return pos;;
+                return pos;
 
             case -EPIPE:
                 if (alsa_recover(alsa->handle)) {
@@ -835,7 +835,7 @@ static size_t alsa_read(HWVoiceIn *hw, void *buf, size_t len)
             default:
                 alsa_logerr(nread, "Failed to read %zu frames to %p\n",
                             len, dst);
-                return pos;;
+                return pos;
             }
         }
 
-- 
2.24.1


