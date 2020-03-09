Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585EC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:20:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0F1E20578
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 15:20:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0F1E20578
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44750 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBKD1-0007TX-DC
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 11:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jBK2Q-0007gf-CJ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jBK2P-0007f9-C7
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 11:09:50 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42163)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1jBK2L-0007bH-3U; Mon, 09 Mar 2020 11:09:45 -0400
Received: from localhost.localdomain ([82.252.135.106]) by
 mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MLA6m-1it6gQ1PvO-00ICtI; Mon, 09 Mar 2020 16:08:52 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/33] hw/audio/fmopl: Fix a typo twice
Date: Mon,  9 Mar 2020 16:08:08 +0100
Message-Id: <20200309150837.3193387-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309150837.3193387-1-laurent@vivier.eu>
References: <20200309150837.3193387-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UW5nFl3f49l8EiqWcfH03Ht250um51CqWYk29wqkrHzC4CE9/8v
 yvNVfXE6dwOJmOKLhm1rMwsd2FKEPF8KExXy1sjgLYb8o7YUNLn0xL5tObTiul3rg/iJ3R8
 yZrQgO/JHzMPIznk/T8XviRYpr1UopbO4Ledubv6MxDlLgoeQ7EqB+GOtiu8WDJEMoEK1Tj
 SM0ey6TJpqQa5oAMnGufQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PKcDQf/GEU0=:NYOCc4WQHMU5AT87QeR0WP
 wgmyeLkw8DoGQnnPhw2UJ1tHCnK/DR2s34/VLUlp2KZE2Jd9IucAAAGCxqa516KS/qVEU0cXr
 xcarRNVNjequblZzPzs3o5jsYpaU/W94DqzginImn1mWNpWBCVdi7RIG8nKdU8IghpEqPuh/1
 XEskxxrrrcYX9w5kGqASWqlcIEW2Vq74d7ZXK6D6RUb4YyBkQGnBtZWVpgfQVy/XlNTimp+ni
 ytabDwqgN5geI99zsa+YsOavglqs+Z+Cw1smyI4BoLfecKSj6BeReyUhlJxlD8T9ubQ1Yv3HS
 EmTaAWH2SenB/Ngjv5OKdHj0YJMm15BLf9pCTavl6Gp21NR8uZZdfTnezukBkZ2nZu84f+IVK
 wRfSsz8peXfxV5G3IXfB31zbE3FZ2LDrooOGw0xM5OITcpgD1tyvCb781RrpwFZ6wzK72XdHm
 VzV9gEk1LUkENAPZIG6w8IfY/0BM32DJM/s7CyPOdfWiIrwdTipWIX7ME4IfubbFdBK7hrupn
 Y+cVnFnrjMMNkgbrX7zTgF25xm853uDyTnkJY5tqoTxH8d0xJp5wkXVvTBVpm4RmwDUxblC7q
 dvTxBCEykduxUMj440r1JOT4N1xYWJw6jgNZIQb1YUZFuAtM5tMONI9rjNa3E6cbgEGk14S4P
 bZxXgBqPBcUG0DCbe4L3ofcvOA4ZFDEUJIOvDWlfWdYVV95ak68XJycOGzKystn6w1nDBmZsO
 v40onrSU9yo6MMLktRWK7OU8ZAjFbu1RUVLeW+HiXCqw770JLYMynKpzfJCEOTJc4UUtD8BM4
 Irr26i1hFfbJOI0z8ApQ3mU77QjcQbF44yrulu64Z8Iv6VMo84dhTUzucd/m3LeaH0WsZ2I
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
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

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200305124525.14555-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/audio/fmopl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 9f50a89b4a88..173a7521f2a7 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1066,7 +1066,7 @@ static void OPLResetChip(FM_OPL *OPL)
 	}
 }
 
-/* ----------  Create one of vietual YM3812 ----------       */
+/* ----------  Create one of virtual YM3812 ----------       */
 /* 'rate'  is sampling rate and 'bufsiz' is the size of the  */
 FM_OPL *OPLCreate(int clock, int rate)
 {
@@ -1115,7 +1115,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 	return OPL;
 }
 
-/* ----------  Destroy one of vietual YM3812 ----------       */
+/* ----------  Destroy one of virtual YM3812 ----------       */
 void OPLDestroy(FM_OPL *OPL)
 {
 #ifdef OPL_OUTPUT_LOG
-- 
2.24.1


