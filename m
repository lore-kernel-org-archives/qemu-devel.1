Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E822C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2526206DF
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 00:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUR0iSMh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2526206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ka76M-0002Hh-RI
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 19:56:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nH-0006Q4-O3
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30699)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1ka6nB-0004qT-SW
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 19:36:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604450209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dMO+7r18+Q3UhJY6oz0UqEMA/RbbAsgceTEHl6F+zUU=;
 b=VUR0iSMh0N87jaTXxpLwe49O0yyLoQQKYmhV+IDu7lVCGFiC8T/aydUwVLCWklZzxK1ahC
 MuCY611VoUtLVChEr7NR97tFcwoFijRQZQcNuU2AhPWvBCwoVCpey/Yx6Pb1mvAJB8G7xZ
 EEJX+bc4x0W+5mNIx+Ylqr61mYs6KwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-xPCAocIWMGqddjo95UrZ2g-1; Tue, 03 Nov 2020 19:36:46 -0500
X-MC-Unique: xPCAocIWMGqddjo95UrZ2g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AACB0102C7D2
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 00:36:38 +0000 (UTC)
Received: from scv.redhat.com (ovpn-119-97.rdu2.redhat.com [10.10.119.97])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9EE8355766;
 Wed,  4 Nov 2020 00:36:37 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 22/72] scripts/qemu-ga-client: apply (most) pylint rules
Date: Tue,  3 Nov 2020 19:35:12 -0500
Message-Id: <20201104003602.1293560-23-jsnow@redhat.com>
In-Reply-To: <20201104003602.1293560-1-jsnow@redhat.com>
References: <20201104003602.1293560-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I'm only doing a very quick best-effort to preserve this script, to help
keep it from breaking further. I think there are pending ideas swirling
on the right way to implement better SDKs and better clients, and this
script might be a handy reference for those discussions. It presents
some interesting design problems, like static type safety when using an
RPC-like mechanism.

So; disable docstrings for now. If you would like to help improve this
script, please add docstrings alongside any refactors or rejuvenations
you might apply at that time.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qemu-ga-client | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qemu-ga-client b/scripts/qmp/qemu-ga-client
index 1061d2eb1437..59b91c78d884 100755
--- a/scripts/qmp/qemu-ga-client
+++ b/scripts/qmp/qemu-ga-client
@@ -40,6 +40,7 @@ See also: https://wiki.qemu.org/Features/QAPI/GuestAgent
 
 import argparse
 import base64
+import errno
 import os
 import random
 import sys
@@ -49,6 +50,13 @@ sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
 from qemu import qmp
 
 
+# This script has not seen many patches or careful attention in quite
+# some time. If you would like to improve it, please review the design
+# carefully and add docstrings at that point in time. Until then:
+
+# pylint: disable=missing-docstring
+
+
 class QemuGuestAgent(qmp.QEMUMonitorProtocol):
     def __getattr__(self, name):
         def wrapper(**kwds):
@@ -104,7 +112,8 @@ class QemuGuestAgentClient:
 
         return '\n'.join(msgs)
 
-    def __gen_ipv4_netmask(self, prefixlen):
+    @classmethod
+    def __gen_ipv4_netmask(cls, prefixlen):
         mask = int('1' * prefixlen + '0' * (32 - prefixlen), 2)
         return '.'.join([str(mask >> 24),
                          str((mask >> 16) & 0xff),
@@ -207,10 +216,12 @@ def _cmd_fstrim(client, args):
 
 
 def _cmd_ifconfig(client, args):
+    assert not args
     print(client.ifconfig())
 
 
 def _cmd_info(client, args):
+    assert not args
     print(client.info())
 
 
@@ -239,6 +250,7 @@ def _cmd_suspend(client, args):
 
 
 def _cmd_shutdown(client, args):
+    assert not args
     client.shutdown()
 
 
@@ -246,10 +258,12 @@ _cmd_powerdown = _cmd_shutdown
 
 
 def _cmd_halt(client, args):
+    assert not args
     client.shutdown('halt')
 
 
 def _cmd_reboot(client, args):
+    assert not args
     client.shutdown('reboot')
 
 
@@ -269,8 +283,6 @@ def send_command(address, cmd, args):
     try:
         client = QemuGuestAgentClient(address)
     except OSError as err:
-        import errno
-
         print(err)
         if err.errno == errno.ECONNREFUSED:
             print('Hint: qemu is not running?')
-- 
2.26.2


