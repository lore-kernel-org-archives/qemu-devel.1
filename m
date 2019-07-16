Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B94C76192
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB30321721
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 08:12:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mmenWa5u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB30321721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnIZA-0001gT-Js
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 04:12:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59849)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYa-00081P-2z
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1hnIYY-0003C8-Qd
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:27 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:42478)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1hnIYY-0003B7-JA
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 04:11:26 -0400
Received: by mail-wr1-x430.google.com with SMTP id x1so4841493wrr.9
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 01:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=r1wkf8U1qfQTsGxOWIZL15/KtvIQEJQr6zmWVqZkLeU=;
 b=mmenWa5unZ/YyOVUxIdECz3wcqpbXC7zK27A+VKBBvj5yajLDLhC52ZG2wU93ZSoOC
 fEf+WwxlFTVW/t+Q2fb3lKGbn9CmqOb0VzfSXOH6Mu1H8ajYLeJvVzJNqABEJIW1GcVV
 09pCytZA4+H/HrAObeXuj7NJQ+9/9golh9yKGJwjhANGxhd4LAaA6Rj+lmLzJ3FKBHJE
 ZieyvY5jx79YpG3h5zNYSH4/rC3tB1ysQc3KKjrfQRX8AZQ1mE+FteHR/nukyZDcdh4i
 laAveWviWeHxWrr6zxIsBNiJiYmJRZD4GvIumDFy0C4PhgWr3kmky54/i4lOihoRhW10
 Gmfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=r1wkf8U1qfQTsGxOWIZL15/KtvIQEJQr6zmWVqZkLeU=;
 b=DFAZQqhrlRi+ssX7fwpiwC9VI1baigkyom9I8vqJpV9NvFMq9M14c6g5ve/sWdzpIg
 b5LtVTBl68RD9Lnvm+Vf8KbLQ+s3qa7n9HlNMpMouqk1M0JPZVzYs3qZvyIfZ2VZODrF
 PEOZq1ch4sNWMo4uMvrV0weFq7kdXdYKyAWTp8vGOu6lwODM5BmINxmNGsBiaf1fyYGC
 OyYaVfKquC6kL1Yi8evP+aoRGU1NI6Wu4jxE97gDAPHb75ituSBkrMMUEO7r/GZqz4Yh
 8tz1g6ibdidS9x9JY6mHjWSfMRVPVZ40zj3IM1NJBQBEiqdpxjXBfCeiEKvED6GWuGX7
 v2xQ==
X-Gm-Message-State: APjAAAW1nzqs1JAXA608xqy/16OSttkKyKOaAEKJ87B5nDeKcdlP9+9l
 vJQctUW4+ZxViKMuz5nPo7hCK6/bBYU=
X-Google-Smtp-Source: APXvYqyZAvKiRNSaANjWU0TrTxm2fLe/ytiOTwcBc1dlZhn4BKgZVOt1tLGZYc7fugZjzXYCUxXqbw==
X-Received: by 2002:adf:f046:: with SMTP id t6mr36365525wro.307.1563264685292; 
 Tue, 16 Jul 2019 01:11:25 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id c1sm37723879wrh.1.2019.07.16.01.11.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 16 Jul 2019 01:11:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 16 Jul 2019 10:11:03 +0200
Message-Id: <1563264677-39718-6-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
References: <1563264677-39718-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
Subject: [Qemu-devel] [PULL 05/19] iscsi: base all handling of check
 condition on scsi_sense_to_errno
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Now that scsi-disk is not using scsi_sense_to_errno to separate guest-recoverable
sense codes, we can modify it to simplify iscsi's own sense handling.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 block/iscsi.c | 29 ++++++++++++++---------------
 scsi/utils.c  |  5 ++---
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/block/iscsi.c b/block/iscsi.c
index 6e238bf..506bf5f 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -225,9 +225,9 @@ static inline unsigned exp_random(double mean)
 
 static int iscsi_translate_sense(struct scsi_sense *sense)
 {
-    return - scsi_sense_to_errno(sense->key,
-                                 (sense->ascq & 0xFF00) >> 8,
-                                 sense->ascq & 0xFF);
+    return scsi_sense_to_errno(sense->key,
+                               (sense->ascq & 0xFF00) >> 8,
+                               sense->ascq & 0xFF);
 }
 
 /* Called (via iscsi_service) with QemuMutex held.  */
@@ -244,13 +244,6 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
 
     if (status != SCSI_STATUS_GOOD) {
         if (iTask->retries++ < ISCSI_CMD_RETRIES) {
-            if (status == SCSI_STATUS_CHECK_CONDITION
-                && task->sense.key == SCSI_SENSE_UNIT_ATTENTION) {
-                error_report("iSCSI CheckCondition: %s",
-                             iscsi_get_error(iscsi));
-                iTask->do_retry = 1;
-                goto out;
-            }
             if (status == SCSI_STATUS_BUSY ||
                 status == SCSI_STATUS_TIMEOUT ||
                 status == SCSI_STATUS_TASK_SET_FULL) {
@@ -272,14 +265,20 @@ iscsi_co_generic_cb(struct iscsi_context *iscsi, int status,
                 timer_mod(&iTask->retry_timer,
                           qemu_clock_get_ms(QEMU_CLOCK_REALTIME) + retry_time);
                 iTask->do_retry = 1;
-                goto out;
+            }
+        } else if (status == SCSI_STATUS_CHECK_CONDITION) {
+            int error = iscsi_translate_sense(&task->sense);
+            if (error == EAGAIN) {
+                error_report("iSCSI CheckCondition: %s",
+                             iscsi_get_error(iscsi));
+                iTask->do_retry = 1;
+            } else {
+                iTask->err_code = -error;
+                iTask->err_str = g_strdup(iscsi_get_error(iscsi));
             }
         }
-        iTask->err_code = iscsi_translate_sense(&task->sense);
-        iTask->err_str = g_strdup(iscsi_get_error(iscsi));
     }
 
-out:
     if (iTask->co) {
         aio_bh_schedule_oneshot(iTask->iscsilun->aio_context,
                                  iscsi_co_generic_bh_cb, iTask);
@@ -974,7 +973,7 @@ iscsi_aio_ioctl_cb(struct iscsi_context *iscsi, int status,
     if (status < 0) {
         error_report("Failed to ioctl(SG_IO) to iSCSI lun. %s",
                      iscsi_get_error(iscsi));
-        acb->status = iscsi_translate_sense(&acb->task->sense);
+        acb->status = -iscsi_translate_sense(&acb->task->sense);
     }
 
     acb->ioh->driver_status = 0;
diff --git a/scsi/utils.c b/scsi/utils.c
index 873d49c..c50e81f 100644
--- a/scsi/utils.c
+++ b/scsi/utils.c
@@ -379,8 +379,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case NO_SENSE:
     case RECOVERED_ERROR:
     case UNIT_ATTENTION:
-        /* These sense keys are not errors */
-        return 0;
+        return EAGAIN;
     case ABORTED_COMMAND: /* COMMAND ABORTED */
         return ECANCELED;
     case NOT_READY:
@@ -409,7 +408,7 @@ int scsi_sense_to_errno(int key, int asc, int ascq)
     case 0x2700: /* WRITE PROTECTED */
         return EACCES;
     case 0x0401: /* NOT READY, IN PROGRESS OF BECOMING READY */
-        return EAGAIN;
+        return EINPROGRESS;
     case 0x0402: /* NOT READY, INITIALIZING COMMAND REQUIRED */
         return ENOTCONN;
     default:
-- 
1.8.3.1



