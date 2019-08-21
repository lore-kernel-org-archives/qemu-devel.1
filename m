Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECF8C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:46:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B392B22D6D
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:46:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B392B22D6D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0P4o-0001kf-N1
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:46:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfW-0005Bs-7j
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfU-0006h0-Pn
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:45 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:36673)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfA-0006Re-Ak; Wed, 21 Aug 2019 07:20:24 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MXHBo-1hkUrl3R8w-00YiE0; Wed, 21 Aug 2019 13:20:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:39 +0200
Message-Id: <20190821111947.26580-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:u2atPAoeKpCu5Yo8clBe1Kcd3F6j4dMNP1n92CWUCIMF4iVFIN0
 HB3W5V2tXHG2XG9Zm+Pa8nQINXF2pbWxvfvh2RAM8NfvoZXbQtpe9szEYfiXEwdj9YjqWIB
 PHDnBafwblquxKDujYqeU0nulnO7JcGY8tW4sRoULOwhlj/LEw08cbFsSm0YsDzpYrcA8TN
 zJZL6suIPqxMmvCij41/g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+Cos+Wn8A+E=:EWRm5POM6JvWWBgwUC1dty
 XbsDJN4qMDvRF/LC/PQ0lUTQuVf/vtc9MXw12GuA4HIjLerASa2z09iOdqYnl2mmjhKxDDdQb
 Jr4y63PH1lizLwlv5pyVFRxe2xs8CaKUaCAjEJz+PSRrt1XSmJ+kaSDb3OMN7uoWH7B90f13m
 XyB8hZEFcNgs3iqAnogpmoB7ds4wUGjMsxamQBA1YTzz5o6bNNc1g7qZadhYTFIntGvWUzVsX
 PkMiP7I4imrCGVmQQ7GT50nP/QPvsJMnQFX8LqzV5NC7N1KMvNZQadEy3GrQyzEQ/I4maM/4L
 6sw4JaYy6f/sxAHZ5I16+W3EfQV4UuZxlp7ONfNyYKXzUpdtYGLTnk+Uycu4K6OG/rlFxytCc
 hIaN8RRNJHeOJ2xMD0bgR9bU5d7zqnwz7UyEMRG45gUrLIReVjWXxg2uYtclJwMyNgkT8bDnf
 gQWI4vUp91zDKX49cz738GNQB+mdqayZCy4C0cmgvII/suqIZXeiDIuZJdBghBjU7GTKicEEw
 jKaG+4Yct5Jk6XHAoiGLpivJHIJwqJfru5/EMhh91PX9ZSfPxNG3l/lLYzhUxeCjL0mlMy+Fx
 m1AYQY0ScDO9PWywouTom8kzT2LWy4XnV6iPPzcYqyRchK/OGecrpa0ZKoOFn/u8komWXEODX
 jMGwj0apc6wBsmPllCElERy9rxuRtbA8MCZvfB6W1mOyFf3MfKJeCyxMPEi78bw0qRN+I4nBm
 Knmol9q88Z2yEnN5N+dl6bcFCNd2XmUkWSOyeirx7WXDQMdSvCVze041XJk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 06/14] hw/net/e1000: Fix erroneous comment
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
 Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Missed during the QOM convertion in 9af21dbee14.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20190715102210.31365-1-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/net/e1000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 8ae4e08f1e90..a73f8d404e6c 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1608,7 +1608,7 @@ static const VMStateDescription vmstate_e1000 = {
 
 /*
  * EEPROM contents documented in Tables 5-2 and 5-3, pp. 98-102.
- * Note: A valid DevId will be inserted during pci_e1000_init().
+ * Note: A valid DevId will be inserted during pci_e1000_realize().
  */
 static const uint16_t e1000_eeprom_template[64] = {
     0x0000, 0x0000, 0x0000, 0x0000,      0xffff, 0x0000,      0x0000, 0x0000,
-- 
2.21.0


