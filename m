Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125AAC10F29
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDAD21D7E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:17:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDAD21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKA5-0003F4-U6
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:17:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33413)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2W-0007yZ-Gf
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2V-0007jA-Eh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:56 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:56317)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2O-0007dx-Ih; Mon, 09 Mar 2020 11:09:48 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MlwBh-1jbc562ffX-00j3HZ; Mon, 09 Mar 2020 16:08:47 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 02/33] maint: Include top-level *.rst files early in git diff
Date: Mon,  9 Mar 2020 16:08:06 +0100
Message-Id: <20200309150837.3193387-3-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:mld9B2FysAyq/JRuJU+HFs/fY2Io+TPiAPpRJFtmcONIGZ7Rto7
 jJngslIHaKNCPsm6Jad44FfZYle4J+6wCXsvIg+eevB7FPsW8i/2B6S/wQ0UuUmvv+k4XfL
 MhUkN6utxBSs6g0zJ1g4BnqSzC/pU7OydL3bgdaqwI450A+P7TjcOC7DelGlHUzvqN/mkrg
 jffHr+MimU0GPcCXXHKIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fI/dpnRvQCE=:004FYDGB+IXXAKS5m2OuEq
 iZgWkTOPZvx6OXWgcaA9G2+5FYYFSvkdty/JRl2zEMtKq+HtDm3zKoZprgiJISrSF/Dc5Undy
 VsA+CGtFua24pZWKwQdfHUCVozfTllzbtvnVMO78pvGM8WMqgKXaCSyi6DoQ/piNMTX9io4eJ
 8PPXAQjP0oX1eVe/o60yV+uHdmLuztVi8EReo13c+8x2a3tl5Umz4UTAg9rYOXwNxCfBgMXAB
 iizvsmBPQoz3dARVsTTBSuwVkVaANhJVNEE1N02y0x/zaembnwNc2eF4pQsnGoQJf1ClnV6dO
 yHFVAmld2/6rMW3NDdm6dB1lRlYeNrDuZSCvN8q+1ttOqmZA7dsCCBF0AoR1/Ise2ScB89cK8
 vOrr/JvvhaEvTr0zOtXrV7G+8ZbIieoPyJvEsWQgLSS7gI0KLeTLRNwNjLqciriZm/NE/bXRn
 +rI6PCih5nYdVR8reMjX8TY/RKRIH/C+qXsObPHg5w7/shoQrDQrTAbVtL4rJmoIDwgXrQamy
 cUnhRPJPMuLKa+14MSDSxYvT8An7GWFRo2GiwONhSlpRVnLAzndyMJ6WLP1oRABdQ3pRziGld
 tMfjT5igKE4yAH6SlhMjvCCb/snjW65pfOO/g1C5H90SfEXEggtXj1DOU9eEk47t9UXHmKRMG
 srR2YiIkNBUZ6HxwuZj3sa2o169Ayoo1VpytZyjr2HZVk/Ht+BPFiBpSluUBfbr4pnpomCI+g
 QFvkFDPavc07FsHHb2bCUdZIncL7QRH9yWZOj6iT8fp7IZZZKpFyAhiXPEEPSeRpGCSOFwLH8
 Kb8JYqmKFMJ00Sh6NzMvtAeRRnu+l9Iwczk+nXXCMhUMrNanwc3h5+pNBEAfApeHjJQnf/8
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
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair@alistair23.me>, Greg Kurz <groug@kaod.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Blake <eblake@redhat.com>

We are converting more doc files to *.rst rather than *.texi.  Most
doc files are already listed early in diffs due to our catchall
docs/*, but a few top-level files get missed by that glob.

Signed-off-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200220162214.3474280-1-eblake@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/git.orderfile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/git.orderfile b/scripts/git.orderfile
index 7cf22e0bf546..73fd818d7f3e 100644
--- a/scripts/git.orderfile
+++ b/scripts/git.orderfile
@@ -11,6 +11,7 @@
 
 # Documentation
 docs/*
+*.rst
 *.texi
 
 # build system
-- 
2.24.1


