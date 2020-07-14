Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F2DFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:32:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 48DDF2072D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 22:32:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QxDOnFwM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 48DDF2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvTTp-0000ii-Ik
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 18:32:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTKD-0001oR-E6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49304
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jvTK7-0004w7-N5
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 18:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594765371;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rq8+AkQ2f65ZI8kNrmi3lYHC8ESMu5ga2yLy+oSnBcw=;
 b=QxDOnFwMUuzrxwRLSGizeAxDPFnDgbpMM95M6Tj2uR/viYQG25+KlQv62E9nUPmpi8JOP6
 s20w44LSrxjky0cKYrHUYPPYSAGGLU+yhuc/7S3DXoUpeVlMZQtfRD/Uvwa+g/4ZtA9Nex
 ENOiD/h9IU7e0R1ydX3eHe+8h8JBP0Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-175-LVXPlCMdNomaVdBRg7awvg-1; Tue, 14 Jul 2020 18:22:47 -0400
X-MC-Unique: LVXPlCMdNomaVdBRg7awvg-1
Received: by mail-wm1-f72.google.com with SMTP id b13so88718wme.9
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 15:22:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rq8+AkQ2f65ZI8kNrmi3lYHC8ESMu5ga2yLy+oSnBcw=;
 b=JEEcp0gkLO5+RxgDZpU2hJ229gGULvHJX0HE7QlHL0Xf/Pn7U8dpJq7UyCO6mwpj8R
 LwnGaw6PHvngkOlb5pKqAiZLSLRqcpj1fWYE0GAOYPuAm+wxOrzNPR1lC2svEL9RZaNy
 fyxxeJviU/M+QzloNW6jcs+A7trLJQxgkAD8qzrpSoJvyCRBdnjqM6LbHwZac1y3zchz
 4G05zdcu9rgzMgZ6zrZ8XLYCnIWSHNYveIO4jmeQOCX+mhp7tfMznSsOeV4x/nVGA3yS
 ypL7gYiszZNAO4TlGUPL09SwxPNckMVfr4diQ53KJu5LtI8YALV1iFKN54qApCbV5wqd
 +bTg==
X-Gm-Message-State: AOAM5332j2qComIeLxAA/YKioxvI2SgvtLGRgQn/vwpTtBnlC/pV/FI4
 taPxhXyYTnH8y3xjO0wNYotL8X5DG6ylemYxuGYpmDYviJGmmQ8qVpMzNYT7XDAYJo3dLZKFiol
 X+yQ/Xjw4c7oIcY4=
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr5630259wmg.17.1594765366150; 
 Tue, 14 Jul 2020 15:22:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZ0W1+mYV+xIoQKOnPVpPvIcjDUeg6KBenJbmH5A4pOKNAkP29TAvjcxBiE/kLmrFQ3GPijQ==
X-Received: by 2002:a1c:dcd5:: with SMTP id t204mr5630246wmg.17.1594765365977; 
 Tue, 14 Jul 2020 15:22:45 -0700 (PDT)
Received: from localhost.localdomain
 (138.red-83-57-170.dynamicip.rima-tde.net. [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id 68sm285232wmz.40.2020.07.14.15.22.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 15:22:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] iotests.py: use qemu.qmp type aliases
Date: Wed, 15 Jul 2020 00:21:28 +0200
Message-Id: <20200714222132.10815-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200714222132.10815-1-philmd@redhat.com>
References: <20200714222132.10815-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 18:21:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=unavailable autolearn_force=no
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
 "open list:Block layer core" <qemu-block@nongnu.org>,
 John Snow <jsnow@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Ahmed Karaman <ahmedkhaledkaraman@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

iotests.py should use the type definitions from qmp.py instead of its
own.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Message-Id: <20200710052220.3306-3-jsnow@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 tests/qemu-iotests/iotests.py | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 8b760405ee..3590ed78a0 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -35,13 +35,10 @@
 # pylint: disable=import-error, wrong-import-position
 sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qtest
+from qemu.qmp import QMPMessage
 
 assert sys.version_info >= (3, 6)
 
-# Type Aliases
-QMPResponse = Dict[str, Any]
-
-
 # Use this logger for logging messages directly from the iotests module
 logger = logging.getLogger('qemu.iotests')
 logger.addHandler(logging.NullHandler())
@@ -561,7 +558,7 @@ def add_incoming(self, addr):
         self._args.append(addr)
         return self
 
-    def hmp(self, command_line: str, use_log: bool = False) -> QMPResponse:
+    def hmp(self, command_line: str, use_log: bool = False) -> QMPMessage:
         cmd = 'human-monitor-command'
         kwargs = {'command-line': command_line}
         if use_log:
@@ -582,7 +579,7 @@ def resume_drive(self, drive: str) -> None:
         self.hmp(f'qemu-io {drive} "remove_break bp_{drive}"')
 
     def hmp_qemu_io(self, drive: str, cmd: str,
-                    use_log: bool = False) -> QMPResponse:
+                    use_log: bool = False) -> QMPMessage:
         """Write to a given drive using an HMP command"""
         return self.hmp(f'qemu-io {drive} "{cmd}"', use_log=use_log)
 
-- 
2.21.3


