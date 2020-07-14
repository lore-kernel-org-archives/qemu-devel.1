Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45413C433E3
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:29:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CE5C2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:29:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DuTNakhX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CE5C2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTQC-0004Pq-A4
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:29:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50580)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKJ-00023P-9n
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:55618
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKH-0004wy-Eb
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:23:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=34BOciJNToD087b3DmEPBjP+atCQ4f8lF8uOK0B/VQo=;
 b=DuTNakhX71xD8GeB9sLqIaANETRwQUsTiY18bZKFdSbqhCnh5EiamS1VYSAmzg6GcpA53r
 tKE04hvDDM1xAXENrJ1TNN6uQgAXjD9BznRdviLd9wflB5acGxyPI8B1OJM5N/a3V4Gssh
 9LBhH2UW3rIE6gMi7OI6Qs7A21DsJWQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-79--Crii8NfNNOcjMzSqN41iQ-1; Tue, 14 Jul 2020 18:22:57 -0400
X-MC-Unique: -Crii8NfNNOcjMzSqN41iQ-1
Received: by mail-wm1-f71.google.com with SMTP id w25so3502521wmc.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=34BOciJNToD087b3DmEPBjP+atCQ4f8lF8uOK0B/VQo=;
 b=GiJamUMrS+XyxFcomsCHKM2z1o1Wb/j68Wws1HE5VGzcAqXk2n1OeGuNuRxMGfqEWx
 76AQkRlbcfSnl+t6o+Y+qdsU6V72gFi6up+YM3afKh46iEIqGvu2n0wlu4vKEIi/sP+8
 i0B6RU6G1yKBoVxrp49RU7M0ALG4oZ81eyrHfOF64BQ52EtRButtdneLAmSkJ7fZG5iK
 hfq44PFqj9hlfKc3fPJS+vqHN5zGMGLYzBpgyTClFqnRBbRt0nXr7cRCkJrlSkr7aqVX
 YX+sprsp5AomVban5MJMR3syuaTRG9dwBAA1XMTog2g0Tv5NqevZZ1BoIpdEu64kL2EV
 1tOA==
X-Gm-Message-State: AOAM532ejtBAioPntoL4tMobxCvgupUflit4Vz/xNkuzWVRiHOX7dBL6
 EylC03wkefh/BkUOwzbR38eHJD32JK8HRl5B6SQ+zW7VAFlJklgNEwBOY+yDPlBYcl/xcVQVHjl
 /imLL8FEeYS+CJVg=
X-Received: by 2002:adf:e80d:: with SMTP id o13mr7963494wrm.112.1594765375651; 
 Tue, 14 Jul 2020 15:22:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwNHB5UaUZCpE+Fa7BIw0lDObJzVZX+kL0W1LO6KAsXyqyguMPGZdBEvEHX7rhy4WGiyA3dg==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr7963479wrm.112.1594765375473; 
 Tue, 14 Jul 2020 15:22:55 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id a2sm160275wrn.68.2020.07.14.15.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:54 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 17/19] python/qmp.py: Do not return None from cmd_obj
Date: Wed, 15 Jul 2020 00:21:30 +0200
Message-Id: <20200714222132.10815-18-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 12:02:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 John Snow <jsnow@redhat.com>, Ahmed Karaman <ahmedkhaledkaraman@gmail.com>,
 Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

This makes typing the qmp library difficult, as it necessitates wrapping
Optional[] around the type for every return type up the stack. At some
point, it becomes difficult to discern or remember why it's None instead
of the expected object.

Use the python exception system to tell us exactly why we didn't get an
object. Remove this special-cased return.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710052220.3306-5-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 python/qemu/qmp.py | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/python/qemu/qmp.py b/python/qemu/qmp.py
index aa8a666b8a..ef3c919b76 100644
--- a/python/qemu/qmp.py
+++ b/python/qemu/qmp.py
@@ -225,22 +225,18 @@ def accept(self, timeout=15.0):
         self.__sockfile = self.__sock.makefile(mode='r')
         return self.__negotiate_capabilities()
 
-    def cmd_obj(self, qmp_cmd):
+    def cmd_obj(self, qmp_cmd: QMPMessage) -> QMPMessage:
         """
         Send a QMP command to the QMP Monitor.
 
         @param qmp_cmd: QMP command to be sent as a Python dict
-        @return QMP response as a Python dict or None if the connection has
-                been closed
+        @return QMP response as a Python dict
         """
         self.logger.debug(">>> %s", qmp_cmd)
-        try:
-            self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
-        except OSError as err:
-            if err.errno == errno.EPIPE:
-                return None
-            raise err
+        self.__sock.sendall(json.dumps(qmp_cmd).encode('utf-8'))
         resp = self.__json_read()
+        if resp is None:
+            raise QMPConnectError("Unexpected empty reply from server")
         self.logger.debug("<<< %s", resp)
         return resp
 
-- 
2.21.3


