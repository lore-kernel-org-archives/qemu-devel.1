Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC51BC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF43E2082F
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF43E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Oi3-0000Es-Fe
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfS-00057I-RC
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfQ-0006dw-SO
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:42 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:49615)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfM-0006Yy-T4; Wed, 21 Aug 2019 07:20:38 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MbBUc-1iXWU71nWC-00bcEU; Wed, 21 Aug 2019 13:20:11 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:44 +0200
Message-Id: <20190821111947.26580-12-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/oOFEv+k3MPTZ96mUEMj/iCXZ45kRUL3eJQ8HPBaJiqO5J0VmDa
 2k9TwkVRGXjuYvwXElBiKM3v1yh68CFr5ElZUw4QMLhzZnT00TuS9pM0RVWHLCql7N5U/rt
 RLiwj2RyW/m4hHYxtzcmKuagGjgNGtiPLatUFycPIiWpmyOUqN2oBYOQKtRKYMcQbeeS4ZJ
 qPhYDng9Lv9teI7IlUV0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BxAiurucm6M=:OTRWXvXQbGGgFzqW+rNfSQ
 on7IFr0c27dgp2X1cDZMDFP4dUJvJOEM7f7v/8Nmi186sFBwMSqcEukgDZcb2vtD8SZvTwAu+
 8hN4B+Wu+dANO6UJDEDWPV6Ot9HzQhHHqmS6t0PlSnkPXyqBl/zLxV6YkPVSLgaqqq4yATFG7
 jMYsX8Q44wndzfNVQyF/UEMYspxqfWipLdp77fl1x7M4yHl2OuUCiBsQ+NPIP16sTCdGjEyqF
 EAhO66A8TEeBJurAGPEcUcLpt7ldpWeTmWGq5NPJdLPD5+eoexnC7yjmN7DmzzH8yazXkfC91
 Pyo0UfKYCRj+JnrtzeDDzzYLdG5UE77ggEcfNFE/tsLAwDxiqlZ6eJNjsuZy9s9Bdk25KD0LD
 8LNDt05YOMSIyct4eTdtYZITA76TmgIcxy5Pqjzo5Uf7pFN4O5W+D4bRq0Dm+jHZEk47+/WnH
 755SmoZniMwwisMkThKcA2yPfGiNZBnsVUdqSkSC9DQhsei9HLRIcqCmGyuoSegTCAP5x2pRh
 UMPojOXps4HC1mlKohK+wWsx9HFIhtPB0dZUp6adsPpA3VlspkUkR31DcwIGMEol+2Ty66iIh
 pQpswTmtkioYLkkzViI6B14hgWUOW9i6IQqRJHMVClAxwIZoUUasAdw9TW+o29/2zgiRwUa3v
 4AqjqR6yQsro7RoZaXiRIahjCGGApxFH8DDznAnr3xDCJlP8juZAEW5MVqX4l79JL6cnEByYQ
 prK/OxiJdNxlCUHtNcUkippyUzJtw0A39wJYu81p+1cf777368FRUWwCCS4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 11/14] vl: Rewrite a fall through comment
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=2:

  vl.c: In function ‘qemu_ref_timedate’:
  vl.c:773:15: error: this statement may fall through [-Werror=implicit-fallthrough=]
    773 |         value -= rtc_realtime_clock_offset;
        |         ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
  vl.c:775:5: note: here
    775 |     case QEMU_CLOCK_VIRTUAL:
        |     ^~~~
  cc1: all warnings being treated as errors

Rewrite the comment using 'fall through' which is recognized by
GCC and static analyzers.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Message-Id: <20190719131425.10835-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 vl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/vl.c b/vl.c
index edd5390110b2..1588dd8fc337 100644
--- a/vl.c
+++ b/vl.c
@@ -772,7 +772,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
     switch (clock) {
     case QEMU_CLOCK_REALTIME:
         value -= rtc_realtime_clock_offset;
-        /* no break */
+        /* fall through */
     case QEMU_CLOCK_VIRTUAL:
         value += rtc_ref_start_datetime;
         break;
-- 
2.21.0


