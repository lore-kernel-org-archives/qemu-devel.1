Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7BFAC28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:21:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F8D7207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F8D7207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58617 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqSh-0003yO-RQ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:21:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60642)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFU-0000WS-B4
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFT-0003mR-96
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:08:00 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:40829)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFS-0003kp-WE; Thu, 06 Jun 2019 07:07:59 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1Mjjvp-1gpIoc0oep-00lIOV; Thu, 06 Jun 2019 13:07:05 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:25 +0200
Message-Id: <20190606110625.32127-17-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:bl0xDPOBLSFyaA6yuciGO6yWHbSUzI/Taafs3MPVPDjQvSPq2FO
	n6XAL3not5uDhjPw7QdREwMHMqCv3HP2WfHkrW3kJZ0ay6L9pndG/dp1Dt4pPzTs5EeJw6u
	1V+u6VXkuVastSw4iolcMlezkMrmvDF5WnpikF+fvoqBLA+wyljyEMTK3E9u4SO4wdbfSy3
	XnHHHxVxZ1g5nQ0Uka1fQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:B/2HZW/kxEQ=:IBY9o2em4spVu6pcr0bD5N
	4qbMMRjgEyOBMgFfTs8RKny4+saGSRYEv1xWFSYqFG5c13q0jtDJdNc1lDvFgk/wxM9G75xVu
	1MzOz7WbfU35OEX8xX4SGzALQ1gBajW97yxYyX2HUfFUhTPgqPeHEOiHp7wbqEaG3yNBBZugy
	+FltJC6MifGu8Ebu8uHTliWZtsqmsxxB1cOzRVLwo++swCivYQsz9PS+bs9sUL6XmAa9EDACp
	I4gI2i5hWbmtWISlim8JXm2rVqpxqKMN54KHL2hwbys7e7wsil/54oUEBQJPu4gdVylrq0Nqy
	Ov1owG4ToUZOGq8iOce0wTHpcY16y1bywwLRLAfpBML42UHHlcvBMxVDwkSHar65sg3uvtKMi
	YtU5+GpjVmeaelGyfY43SNQCDXVWy+hRlCxo/vWM3EVIj3hf0qtxHx3EssyOD51iZ9kmstQgj
	qk+S+MEBV9/+cWr8Z90TZ4EixwcbpliQlyGCaSlvudNAgo9FuRsHd0p7lz2NCMRwYsyz2TsKN
	+flqumUZQnv3GhLb2M4D1em2avUDq3PCTXSX+0Tfe3+QnCCSwuV8VaRqz+uM+J6kQXP/YQaTz
	TnrdStmsQnynmKN3dWjmA2WfBAe82kIgiqTV8WfaA+d/U+2HSnt3ieRjs3YmDY4pNvppbOUr1
	7oagnQw4SODMvXVuBxJVFlu+plQymHQX4iOCsC2uAcH+FJeE3BYbrlO1JF4B2DAA5IVowEdE6
	EiR3ncUqoE/SMYsiect/LdiFieqFj8omHC6H+HJ2CAgchrjwbRiAGlGH1/c=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 16/16] hw/watchdog/wdt_i6300esb: Use DEVICE()
 macro to access DeviceState.qdev
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Rather than looking inside the definition of a DeviceState with
"s->qdev", use the QOM prefered style: "DEVICE(s)".

This patch was generated using the following Coccinelle script:

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Message-Id: <20190528164020.32250-11-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/watchdog/wdt_i6300esb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 1c6eddf86aea..f2d1e86526f2 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -200,7 +200,7 @@ static void i6300esb_timer_expired(void *vp)
         if (d->reboot_enabled) {
             d->previous_reboot_flag = 1;
             watchdog_perform_action(); /* This reboots, exits, etc */
-            i6300esb_reset(&d->dev.qdev);
+            i6300esb_reset(DEVICE(d));
         }
 
         /* In "free running mode" we start stage 1 again. */
-- 
2.21.0


