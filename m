Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E98C4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:56:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21A5E212CC
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 20:56:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx6+7n+w"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21A5E212CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPXXI-0005ol-A6
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 16:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTQ-0001ap-5f
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51621)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kPXTO-0005pz-9D
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 16:52:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601931161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xxT0lWY/pBsdRzPLysfCVHNonuY7lEkIqV/GVx79ho4=;
 b=Bx6+7n+wXLZRMn4jahfyo9w+2Qnj2TiqTPviwlbCMTL3ivbJjBcJkAxefRn2HC/Kg59O7H
 bjh9zQQ7i0tLVxa6Nh6WjAeqSDqBsyC7hi+6JlGFt/JHdlX7iVbatzIK0k4Qa2KuGmseiE
 HnTYfSrwKVfA9ms+h/13cL6yWopRIm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-85-042pkQhWOmuK30pVYDKPrg-1; Mon, 05 Oct 2020 16:52:40 -0400
X-MC-Unique: 042pkQhWOmuK30pVYDKPrg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2FA5E925C3E
 for <qemu-devel@nongnu.org>; Mon,  5 Oct 2020 20:52:39 +0000 (UTC)
Received: from localhost (ovpn-119-102.rdu2.redhat.com [10.10.119.102])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5525578807;
 Mon,  5 Oct 2020 20:52:36 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/3] docs/devel/qtest: Include libqtest API reference
Date: Mon,  5 Oct 2020 16:52:28 -0400
Message-Id: <20201005205228.697463-4-ehabkost@redhat.com>
In-Reply-To: <20201005205228.697463-1-ehabkost@redhat.com>
References: <20201005205228.697463-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/05 02:11:31
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 docs/devel/qtest.rst          |  6 ++++++
 tests/qtest/libqos/libqtest.h | 20 ++++++++++----------
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/docs/devel/qtest.rst b/docs/devel/qtest.rst
index 3bf9ebee7f0..075fe5f7d53 100644
--- a/docs/devel/qtest.rst
+++ b/docs/devel/qtest.rst
@@ -64,3 +64,9 @@ QTest Protocol
 
 .. kernel-doc:: softmmu/qtest.c
    :doc: QTest Protocol
+
+
+libqtest API reference
+----------------------
+
+.. kernel-doc:: tests/qtest/libqos/libqtest.h
diff --git a/tests/qtest/libqos/libqtest.h b/tests/qtest/libqos/libqtest.h
index a6ee1654f20..209fcf69737 100644
--- a/tests/qtest/libqos/libqtest.h
+++ b/tests/qtest/libqos/libqtest.h
@@ -24,7 +24,7 @@ typedef struct QTestState QTestState;
 
 /**
  * qtest_initf:
- * @fmt...: Format for creating other arguments to pass to QEMU, formatted
+ * @fmt: Format for creating other arguments to pass to QEMU, formatted
  * like sprintf().
  *
  * Convenience wrapper around qtest_init().
@@ -87,7 +87,7 @@ void qtest_quit(QTestState *s);
  * @s: #QTestState instance to operate on.
  * @fds: array of file descriptors
  * @fds_num: number of elements in @fds
- * @fmt...: QMP message to send to qemu, formatted like
+ * @fmt: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
  *
@@ -100,7 +100,7 @@ QDict *qtest_qmp_fds(QTestState *s, int *fds, size_t fds_num,
 /**
  * qtest_qmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu, formatted like
+ * @fmt: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
  *
@@ -112,7 +112,7 @@ QDict *qtest_qmp(QTestState *s, const char *fmt, ...)
 /**
  * qtest_qmp_send:
  * @s: #QTestState instance to operate on.
- * @fmt...: QMP message to send to qemu, formatted like
+ * @fmt: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
  *
@@ -124,7 +124,7 @@ void qtest_qmp_send(QTestState *s, const char *fmt, ...)
 /**
  * qtest_qmp_send_raw:
  * @s: #QTestState instance to operate on.
- * @fmt...: text to send, formatted like sprintf()
+ * @fmt: text to send, formatted like sprintf()
  *
  * Sends text to the QMP monitor verbatim.  Need not be valid JSON;
  * this is useful for negative tests.
@@ -201,7 +201,7 @@ QDict *qtest_qmp_receive(QTestState *s);
 /**
  * qtest_qmp_eventwait:
  * @s: #QTestState instance to operate on.
- * @s: #event event to wait for.
+ * @event: event to wait for.
  *
  * Continuously polls for QMP responses until it receives the desired event.
  */
@@ -210,7 +210,7 @@ void qtest_qmp_eventwait(QTestState *s, const char *event);
 /**
  * qtest_qmp_eventwait_ref:
  * @s: #QTestState instance to operate on.
- * @s: #event event to wait for.
+ * @event: event to wait for.
  *
  * Continuously polls for QMP responses until it receives the desired event.
  * Returns a copy of the event for further investigation.
@@ -237,7 +237,7 @@ QDict *qtest_qmp_receive_success(QTestState *s,
 /**
  * qtest_hmp:
  * @s: #QTestState instance to operate on.
- * @fmt...: HMP command to send to QEMU, formats arguments like sprintf().
+ * @fmt: HMP command to send to QEMU, formats arguments like sprintf().
  *
  * Send HMP command to QEMU via QMP's human-monitor-command.
  * QMP events are discarded.
@@ -629,7 +629,7 @@ void qtest_add_abrt_handler(GHookFunc fn, const void *data);
 /**
  * qtest_qmp_assert_success:
  * @qts: QTestState instance to operate on
- * @fmt...: QMP message to send to qemu, formatted like
+ * @fmt: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
  *
@@ -676,7 +676,7 @@ void qtest_qmp_device_add_qdict(QTestState *qts, const char *drv,
  * @qts: QTestState instance to operate on
  * @driver: Name of the device that should be added
  * @id: Identification string
- * @fmt...: QMP message to send to qemu, formatted like
+ * @fmt: QMP message to send to qemu, formatted like
  * qobject_from_jsonf_nofail().  See parse_escape() for what's
  * supported after '%'.
  *
-- 
2.26.2


