Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2051AC28EB3
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB555207E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 11:09:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB555207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYqGv-0001Qk-U5
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 07:09:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60232)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF2-00005M-Ro
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1hYqF1-00033R-S7
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 07:07:32 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:59695)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>)
	id 1hYqEz-0002uI-DY; Thu, 06 Jun 2019 07:07:29 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
	mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MTzOe-1h8t6B2imY-00R0Q2; Thu, 06 Jun 2019 13:06:49 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 13:06:16 +0200
Message-Id: <20190606110625.32127-8-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606110625.32127-1-laurent@vivier.eu>
References: <20190606110625.32127-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:wUnOf9ABFcZPIdu6WP+ydyND6/T7AEWzdtKYRCuFesgdbDO+pWV
	bscKmJLVjodYrfN8t9iS1cRpPoCDfV+1mf45ZCBA0YdeGPvJXrr2kqU85fI/RCIAeKkf8Jg
	ubdzGz+CcwdO7d2x7jUoCesWsXskwq52BSz9noUg54VgWoR9cGbPPJseEril9oBCNCI+tRH
	L5CUmfTnWIO1Dy5v6GQ1w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PsnsnShj0z4=:G7S6rys+wtd5sUWMA/PkgR
	lfvSW1K9nLgLNl/tGLs0aGnp4VvdO5/LOTBI0aiabPu9ARvuoatC6cxNPlW5n2z0hdcOiF9Wi
	y1VmiJAItG34MlcinYh2/E2kT57r0uQijv7//EeUn2E4FVTXESQy+iUq5U/5q1LLURaNQt/eF
	jARx/NawnA0BNvRlisSTiIVXVXW/1plgAcZWV/H9+9f63llE7F9EBkAwOIyDOP3ZQw2NEYNh/
	8WC9qhwe8/AT+IlPOmGwHXxA1ypI4vd71H29OBk58psaqnxXAld4uxl3HZpj7J5PhZaSS6HuM
	CICOud97dMRjjnYQSq5XcT3SYcjUMJt/h91bAy+c0501mrxy4f9ZOJoSZgS9ZrFubFmvsdll3
	a1c8r4PkFOC9b2q1MTCIVlHrum3itWxporQBDjZaEFFEHjt6ircdnjEER5joOGy/O7ftMKfSJ
	wCumsZiJ2mIbgmq8pYX+hpZLh4l9K7Kuccs9OqqulUhLaZSmMhMzY2CmlUYmZ+CDbMpOKj14E
	nqTf3yKvwhXeEyAkzyNiP6ePbJjEN9GWYVGojba8P1RDcyM/PdAw0amdrd1xvfkKQoxWw10zf
	LfcnH118f4YeFKzp1IVc11aUosTNwp5wIvFxc9LzSENS2788Ds8eaeKl3xPbEePAPLy16Vxdk
	zTfn7zZKQl9NmPzhigTgU2ceoMBtj31vi+cA4U/ve8mvuRsFiqHqChRRvc0Q2G0+LkgJrOWnq
	jgzQMG2ERAx9l0yay8jw2bkWS6GaWZJU8Owp6sYvJm8+DFxaspYnn7KaQ8Y=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PULL 07/16] hw/scsi/vmw_pvscsi: Use qbus_reset_all()
 directly
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
Cc: Fam Zheng <fam@euphon.net>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
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

Since the BusState is accesible from the SCSIBus object,
it is pointless to use qbus_reset_all_fn.
Use qbus_reset_all() directly.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Message-Id: <20190528164020.32250-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/scsi/vmw_pvscsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index 584b4be07e79..c39e33fa3599 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -440,7 +440,7 @@ static void
 pvscsi_reset_adapter(PVSCSIState *s)
 {
     s->resetting++;
-    qbus_reset_all_fn(&s->bus);
+    qbus_reset_all(BUS(&s->bus));
     s->resetting--;
     pvscsi_process_completion_queue(s);
     assert(QTAILQ_EMPTY(&s->pending_queue));
@@ -848,7 +848,7 @@ pvscsi_on_cmd_reset_bus(PVSCSIState *s)
     trace_pvscsi_on_cmd_arrived("PVSCSI_CMD_RESET_BUS");
 
     s->resetting++;
-    qbus_reset_all_fn(&s->bus);
+    qbus_reset_all(BUS(&s->bus));
     s->resetting--;
     return PVSCSI_COMMAND_PROCESSING_SUCCEEDED;
 }
-- 
2.21.0


