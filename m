Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CCD8C28EB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24CF9207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24CF9207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqN2-0007IE-8k
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:15:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60539)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFR-0000Sa-2T
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqFP-0003fm-Vb
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:57 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:48335)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqFM-0003XM-8B; Thu, 06 Jun 2019 07:07:52 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MF45G-1hJOpv4BHE-00FVwS; Thu, 06 Jun 2019 13:07:00 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:22 +0200
Message-Id: <20190606110625.32127-14-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fzaLTWynTwDqw6BjWmgpLb2j0IKt7+qM8X08zaQ6i9wGrXiov9X
	wSpTCy06OGdyElX7Nu4C3qjeTx82I/dXttSwj8u7Um3YjV8hbFFJFfij/5g9aVoTRZMBsgU
	qRFZL0xYRoujggCov1NFhZcDbnqII1+ueWrGKkHuP6rsAW5OyeZ+lG4bUnfHOe4LlnTqIjF
	O/l0SKuUv7l8LcvaDxYGg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Hbvzz2t+sbA=:O/5Xg9ZXO9P0MYOLKekIUO
	42O8iR3bR2OTpFSjE/mr0VGHbSNoL+DgTUJeZf8rtvpC2oqiQbZGMbj7L5TDfU9RPivEzId1S
	tQsl5ZlOhBnJQxMT80vywmOoJgoeLDLz32hbMu6fs2w+eOwu5I1Fee2Hc+FBS23MIYWTURf51
	tmbHnhTWGWetV1ZmPRGamqojQNd8KznKwpt+le0Qmj0fnW7y+BFc4lxktjt3sDLSQsuYbhBN/
	LGKbYA2X/dnvmILr1zYmyEAR/gzKAA5OzgwO1sGjr8suE3Evekh/qOLxDD3zEtE1Zm9q3pYGh
	7ftFN6nvFnvZvN+wl5L2LdgZSBKhaX6m1VDIvKy6WWAdNIQWgeYNy4xxE5UhMKGLggTbdQD3o
	wZEppG7j7ZoVHJp9qw6gS1wtnNYsofIxKWDmnq3dke1b+vb3Qjz3eTuj7tSeDFI8XuqwQ9KEb
	39v75ZQggF9F7r0UFwTd/ujaWqvQgzPe80YweWAEzxiZ6RLqkvHSmyxVtK+j+lA72H+8uRLoK
	w05IjZqJP4RXFYSNvkBHTu6+l8ppc/qG6e1NzPjJoDE8RHXjYWZjxoSSGcpV59W15K2pH6o22
	ZTeMQK0dxgXX75rxPLRnqhvjOMlEyOnqasQ3/8+MH/s9mAkhptO2jmWN3SwWRWAhucN4hjCIB
	jUZYJ/HboaJs+kHcYLgD9NBDSRnwDL5YZucpvfmRZf5sQCcFcpFxgCO5hBqG+JBigvCWc0ZcR
	ngA0FWEl9uDMvfez9BUfX7onzPQB12WuPnCop8J1c+JrbzPVolK2NnTNJJk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: [Qemu-devel] [PULL 13/16] hw/audio/ac97: Use the QOM DEVICE() macro
 to access DeviceState.qdev
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

This patch was generated using the following Coccinelle script
(with a bit of manual fix-up, removing an extra space to please
checkpatch.pl):

    // Use DEVICE() macros to access DeviceState.qdev
    @use_device_macro_to_access_qdev@
    expression obj;
    identifier dev;
    @@
    -&obj->dev.qdev
    +DEVICE(obj)

Suggested-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>.
Message-Id: <20190528164020.32250-7-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/audio/ac97.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 2265622d44a2..a4e8d99e7775 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1388,7 +1388,7 @@ static void ac97_realize(PCIDevice *dev, Error **errp)
     pci_register_bar (&s->dev, 0, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nam);
     pci_register_bar (&s->dev, 1, PCI_BASE_ADDRESS_SPACE_IO, &s->io_nabm);
     AUD_register_card ("ac97", &s->card);
-    ac97_on_reset (&s->dev.qdev);
+    ac97_on_reset(DEVICE(s));
 }
 
 static void ac97_exit(PCIDevice *dev)
-- 
2.21.0


