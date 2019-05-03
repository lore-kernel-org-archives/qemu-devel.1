Return-Path: <SRS0=LbB6=TD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47F0AC43219
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:24:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1AAF82081C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2019 11:24:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1AAF82081C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38384 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMWJA-00044D-BM
	for qemu-devel@archiver.kernel.org; Fri, 03 May 2019 07:24:52 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59528)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE6-0008Ef-Ny
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hMWE5-0001MQ-J1
	for qemu-devel@nongnu.org; Fri, 03 May 2019 07:19:38 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:44665)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hMWE5-0001L8-9E; Fri, 03 May 2019 07:19:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA
	(Nemesis)
	id 1Mt8cD-1gU0if2kXZ-00tSSq; Fri, 03 May 2019 13:19:04 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Fri,  3 May 2019 13:18:26 +0200
Message-Id: <20190503111832.30316-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190503111832.30316-1-laurent@vivier.eu>
References: <20190503111832.30316-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:/giShaB3q6BMKEIJ47bzB6xzi03fHl0BlHkOGMzhH0r9PGQ47hB
	XnPw3K4OJdg1QGaxH8z8ziqKVpRfIF8y6zfR3iFN7UVhWX1ZQyTsmKvgyEjqNP7lp4UpPtp
	gSXUDRJYbuWLk7Edy2mRwSOcXAMOO0wWrYK0nAUNkjwr9hLr573VQiT9EBDIW7I7F9H6RMX
	Ue7/klX2cvd1aEg+++w+Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TCZFDqBeCW0=:dyIoieh8JqKGlJq1fyQLx8
	jvt63rayJMaP7KZqO45jAogpix+6BCkFy7b0WwyCx2EBGsTmw++4IHdGCLDXVrB9Afqix5+3R
	ou+Yiye42IqyXow1o2gBWWGyfhaAy8qppG7q/0DQpJ8TuoBfOB7eA45+q/ztWrH+1BFeg+Obu
	kP4Cr85vDimXT3UdnCfcbx0501XPm8b2nUWWaw3ddao9YF9Q2NojNFYtcdx52a7hSaEcE7iZ3
	gOJ/CRmj6tIk+0DfGCXfXo76GiHz1mjulMEUmzQkGMFsz2+mkhk9QZqkZ269p+D96fxotLVOX
	wdJRM4arWtRHBqgNN0Ax1bzW/QulLAozw7z0AH5xTFZGC32uCd971Jrq+hWSdXCIpw9iy6nV7
	s7cRE3sT+1G6POe1D24t/yywhUW5DH5aQNysWIEdqT1k/ZS+dncoWq61Ep6SjU1od6PydfzEn
	Gc5Y1ba79B9VOt7xAt8KMsaDfZq8Nd/DSrtNW1HKb7D+3pgglGQFbwt1GqKdMXH5sNf8ZjBIO
	ojGtrGG+ub8bpp5zE01pBo8eE8xX6OaTlirZjduceZPgwETsI+sDrwF8Rc0myXHTv6UWlfCyR
	7j52CWVjQZ6xCSoMk4JlHoHZ47c0P9pt5W+DFeick0bPEJlvqmNjygmmoY/yzj3SYjs1nebEM
	6hjsFOeo8BUwP7HtGoiiPpXmP904jqt/5g2MLTT8v2lnz2DXpSIutdXZO4KUIUYfm5nzRTVxd
	uyWl76ZQWBtSKgr8N4BNCXL8SDapKFnC9ZaIW/MzJTQV+ta1KvDrOM3XR50=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: [Qemu-devel] [PULL v2 06/12] configure: fix pam test warning
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
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-trivial@nongnu.org,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	Jason Wang <jasowang@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
	Laurent Vivier <laurent@vivier.eu>, Fabien Chouteau <chouteau@adacore.com>,
	Michael Roth <mdroth@linux.vnet.ibm.com>,
	Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
	=?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
	Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190503111826.srVCIYrQ8CHIGZL_aKUNaiO4GSeyiROMgBTc0an5Tzk@z>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The pam test generates a warning on Fedora 29 with -O3 compilation
because the headers declare that the pam_conversation pointer to
pam_start must be non-NULL.  Change it to use the same 0 initialised
structure as we actually use in qauthz.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20190404091725.20595-1-dgilbert@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 configure | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 60719ddcc5b0..a2607afb3408 100755
--- a/configure
+++ b/configure
@@ -2940,9 +2940,9 @@ if test "$auth_pam" != "no"; then
 int main(void) {
    const char *service_name = "qemu";
    const char *user = "frank";
-   const struct pam_conv *pam_conv = NULL;
+   const struct pam_conv pam_conv = { 0 };
    pam_handle_t *pamh = NULL;
-   pam_start(service_name, user, pam_conv, &pamh);
+   pam_start(service_name, user, &pam_conv, &pamh);
    return 0;
 }
 EOF
-- 
2.20.1


