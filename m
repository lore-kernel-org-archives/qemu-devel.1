Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEFFDC28EB4
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C611120868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:10:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C611120868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqI0-0002Po-0V
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:10:36 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFS-0000Ua-VM
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFS-0003kc-1e
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:58 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:41725)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFM-0003Y5-4R; Thu, 06 Jun 2019 07:07:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MyKYE-1gcKlM29eO-00ydrs; Thu, 06 Jun 2019 13:06:44 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:13 +0200
Message-Id: <20190606110625.32127-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Sdcr+43MaEvgOFCLqoBVvN3f0eFhHJAHvIaumx6TwHBbk8Op53r
	mhRKmdzJb12QS3KddxUe1EtLseBs5xkd1SsXwA3+T9NO/kW9XTkRTTOzQes53BFDepWNqGa
	UESSp0MEJu5lf5G+XNU031f0o3i6XLWMYDa2rXelkiJ8HOl/LTYwUX2zHdgQMABfP9IBFXm
	crE91O+LUBQMfdFtDEzyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FhUQ6BSxQOE=:HEakt/fZUJwDEWxUrzBJhV
	IMUgGlIHLecx/vwK/4V6ODYNsPuQlHy01wVQ8XU58vvOw76/Syr6kJMSR1d7QdMnH57sAD/xL
	aYh4iUNm/UtwGhf8M6YyGyPsEyp6H73sEd4RixaMpugkcdJTonPxzt5xnTnPD6CGc3AxWJ6bK
	s9aRAC18kkyFc6u50hUu86enyjKpEQttOEGz4ErmMZOnHcYmxthr61OxYFCaFvzsaFxqOzzKq
	+VL2hAxkBPiiD03SHxi+iz59ofelXdQvM2O1c00rzsD7d6wYZY1vvmJduDJ1fOppQBLtOqVNi
	3MXdercddxWOKg53OllPqCxVlbWh1oIQTQTbJ2U295amOlAuPlM9Za+XSB93oTShAacj+QurY
	ALee5rNrUsnP3M1KHREhYfZoCXjQIUGpH7lndAf3halW3pTCJNLeOpCmeroofyo6QdEbtZJBY
	fDB+epeCrqDnAdA5NnRHtlNq9+21tHIMpEgmPNcEZyuOLtbJu5ALgpsjC8A3vyY/2mW0MpLvQ
	2R+9LzK43lETPlxySTTmj8FuJCNsz8SRcT8Zhjk24og4LEU/qwG94pWY+4cK6vUR6K9xXPrIi
	Zw38MhJk52TEmRfFCrvT21ZosID+Q1yhCW2UA4Rs5ELjkgfmkSakObIwGK0zL5ORTQGjmbINZ
	WET/FUhprHHrOp0t+Lnncq3uQvgZicKI3aI+uNxr1qq2BvMWioiiP7foW4PrJwXJp2IhkdLnY
	P1v7OFtu598stMsEU5eK6ZCRvOp2bauMzPluQySB6WlCrYkMoaZOxkMdMBc=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: [Qemu-devel] [PULL 04/16] util: Adjust qemu_guest_getrandom_nofail
 for Coverity
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
	Dmitry Fleytman <dmitry.fleytman@gmail.com>,
	David Hildenbrand <david@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Gerd Hoffmann <kraxel@redhat.com>, Juan Quintela <quintela@redhat.com>,
	Aleksandar Rikalo <arikalo@wavecomp.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Yuval Shaia <yuval.shaia@oracle.com>,
	Alex Williamson <alex.williamson@redhat.com>,
	Richard Henderson <rth@twiddle.net>,
	=?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
	qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org,
	Michael Walle <michael@walle.cc>,
	Aleksandar Markovic <amarkovic@wavecomp.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Explicitly ignore the return value of qemu_guest_getrandom.
Because we use error_fatal, all errors are already caught.

Fixes: CID 1401701
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190530173824.30699-1-richard.henderson@linaro.org>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 util/guest-random.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/guest-random.c b/util/guest-random.c
index e8124a3cad48..00a08fd9819c 100644
--- a/util/guest-random.c
+++ b/util/guest-random.c
@@ -56,7 +56,7 @@ int qemu_guest_getrandom(void *buf, size_t len, Error **errp)
 
 void qemu_guest_getrandom_nofail(void *buf, size_t len)
 {
-    qemu_guest_getrandom(buf, len, &error_fatal);
+    (void)qemu_guest_getrandom(buf, len, &error_fatal);
 }
 
 uint64_t qemu_guest_random_seed_thread_part1(void)
-- 
2.21.0


