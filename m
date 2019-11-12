Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C3D7C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32F9D20679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32F9D20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYsM-0005nP-Bq
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:18:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUYqy-0004nx-3G
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUYqv-0007j0-Q9
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:15 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:56347)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUYqv-0007hF-3Z
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:17:13 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1N49Ul-1hmfQR16O1-0107NJ; Tue, 12 Nov 2019 17:16:58 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 0/2] Linux user for 4.2 patches
Date: Tue, 12 Nov 2019 17:16:52 +0100
Message-Id: <20191112161654.2253-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:uZ43GMnjBxmgJnu/YfAwUZ2XUDywIsf4cg1+YMf4rdl5Xj4hACU
 HYgb1xTkIh8axmmaTWn6EjrarkTHrmqoDES3WFCvl4SujcA9q/L0n0EGVBuccnDWOGDKcUU
 UcqmznvZxDNGnsENxr+/ImP81t8SZOkn7pBTTsGKebdN2wJ0Fd9Z8eIYm+Pau+B2RVkcw7b
 YiWn51fZ+EiA/wj13t2mw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WDdoDoZNP/k=:tl1u7Bkp9WSLL/B1CKbSy2
 dVjcisOZ77sh6oGKA919R8MP3mek3IVWBRzWxMI4mUetE7WwXG+a+D4dM6zSXbgSiXSwbHXsr
 64N144RVVcT1cdX8prPO3gesARgSlm2DYf+VdTC8qw5kc1Dc0nevBAWnd6lScMlswlnJt1ssh
 O9T6cgqCUqxbp8BqTNch1XJqbFU2K2ygdkBb6BnKeZWwnU/tHRrsgaaqduObQGmA9+MvHePw2
 Qgx6XdAWhgf/OUBpRhQAZ5vEWlt1h2Rj7R0CcnytR/7jdsJxOK1e3EIdoJbi+m5loFLWaq32G
 zNgg4NRBLBLcLraJl0tM3DR5aNPaYZA8Vm3HjG5I4yN9Y/ZZuHAJAIJ3MXJztvr8lGTZp7zBR
 WKthjNeTKooZeoGtfNbhGyw/Ms2PQzMJcplTLbX5lOdwwc1WeB0R2iiJSvJAYHUAAG0p4M0TB
 Xffsl3DkZYcXbSyieIGlcgW+OWk0rdcyR6iLMZjC9H3xnr3eXn1Wkrd/Og77zTivBNO7GtrBr
 gso6YXzgweoFFCCJNXK2ca50BaDyCVHhdLEkRbhyrLzderoxyKCjkS8M/RSzbuWQbbzxUUAPi
 jniP7gaVgrZJ0Ta7pbmGeP5ECFnt30LM0JrJMBUi1Jqb2BSLFNQtdm3m4iNg50SQkoivXfDFx
 0RfOENgwGaSyk7WasX9t4Xy9Ct31oVkR+lAe4U5w6X+JnO6G+TlcFGSLqHrIQ73uj7IQYedwc
 670mc6/MFxGswqn/o94afFJ8OxHTU3ug0dKiKYb4pDGZY5iSVClZYM4f0k/R+8q2SdOqvG0VE
 cKWEws0OfktXpewaVWgxeQqciWz0wd7Tz2K5wg9BTY8clNJtTnSyHTEYNSuLtJwt6CbMKrdZv
 v42tNhyOOcZ5reM+TiPg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.24
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
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit 2a7e7c3e103a5c29af7c583390c243d85a2527e8:

  Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-and-tcg-121119-1' into staging (2019-11-12 14:51:00 +0000)

are available in the Git repository at:

  git://github.com/vivier/qemu.git tags/linux-user-for-4.2-pull-request

for you to fetch changes up to 0f1f2d4596aee037d3ccbcf10592466daa54107f:

  linux-user: remove host stime() syscall (2019-11-12 17:05:57 +0100)

----------------------------------------------------------------
Fix CID 1407221 and stime()

----------------------------------------------------------------

Laurent Vivier (2):
  linux-user: fix missing break
  linux-user: remove host stime() syscall

 linux-user/syscall.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.21.0


