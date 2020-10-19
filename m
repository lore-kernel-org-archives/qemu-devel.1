Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C355C433E7
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:05:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ABC622282
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 21:05:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="i6LL+tlI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ABC622282
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUcLd-0000JW-Hn
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 17:05:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40076)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUcKj-0008J8-KJ
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:04:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1kUcKe-0008A2-Ek
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 17:04:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603141477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wrIWKTp/tHcOOrS6WgrYn7X5sPGb0zz9A8KkpgXkDJU=;
 b=i6LL+tlISkVnwBZK+ZkLgUSWe7e2ntC0WXhgMkfKxC7LtSul8X6RFRC/KtF4pZRj7DRvXw
 32m05Dz5WKXnUPSAHrOYGor9KDk5cqQI/65x26G06HYXR95Cc/Kw13HZ4rVq/nQGB3e1Tr
 i26phqwr0M7tlUgh0VUedrewlT9XEWQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-HfrOnx2tOqK5R39E2LtYQA-1; Mon, 19 Oct 2020 17:04:36 -0400
X-MC-Unique: HfrOnx2tOqK5R39E2LtYQA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D3FF108E1A2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 21:04:35 +0000 (UTC)
Received: from scv.redhat.com (ovpn-113-237.rdu2.redhat.com [10.10.113.237])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 91BD56EF59;
 Mon, 19 Oct 2020 21:04:31 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] scripts/qmp: delete 'qmp' script
Date: Mon, 19 Oct 2020 17:04:30 -0400
Message-Id: <20201019210430.1063390-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jsnow@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=63.128.21.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/19 02:32:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This script has not seen a patch that was specifically for this script
since it was moved to this location in 2013, and I doubt it is used. It
uses "man qmp" for its help message, which does not exist. It also
presumes there is a manual page for qmp-XXX, for each defined qmp
command XXX. I don't think that's true.

The format it expects arguments in is something like:

block-dirty-bitmap-add --node=foo --name=bar

and has no capacity to support nested JSON arguments, either.

Most developers use either qmp-shell or socat (or pasting JSON directly
into qmp stdio), so this duplication and additional alternate syntax is
not helpful.

Remove it. Leave a breadcrumb script just in case, to be removed next
release cycle.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 scripts/qmp/qmp | 131 +++---------------------------------------------
 1 file changed, 7 insertions(+), 124 deletions(-)

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 8e52e4a54d..0f12307c87 100755
--- a/scripts/qmp/qmp
+++ b/scripts/qmp/qmp
@@ -1,128 +1,11 @@
 #!/usr/bin/env python3
-#
-# QMP command line tool
-#
-# Copyright IBM, Corp. 2011
-#
-# Authors:
-#  Anthony Liguori <aliguori@us.ibm.com>
-#
-# This work is licensed under the terms of the GNU GPLv2 or later.
-# See the COPYING file in the top-level directory.
 
-import sys, os
+import sys
 
-sys.path.append(os.path.join(os.path.dirname(__file__), '..', '..', 'python'))
-from qemu.qmp import QEMUMonitorProtocol
+print('''This unmaintained and undocumented script was removed in preference
+for qmp-shell. The assumption is that most users are using either
+qmp-shell, socat, or pasting/piping JSON into stdio. The duplication of
+facilities here is unwanted, and the divergence of syntax harmful.''',
+      file=sys.stderr)
 
-def print_response(rsp, prefix=[]):
-    if type(rsp) == list:
-        i = 0
-        for item in rsp:
-            if prefix == []:
-                prefix = ['item']
-            print_response(item, prefix[:-1] + ['%s[%d]' % (prefix[-1], i)])
-            i += 1
-    elif type(rsp) == dict:
-        for key in rsp.keys():
-            print_response(rsp[key], prefix + [key])
-    else:
-        if len(prefix):
-            print('%s: %s' % ('.'.join(prefix), rsp))
-        else:
-            print('%s' % (rsp))
-
-def main(args):
-    path = None
-
-    # Use QMP_PATH if it's set
-    if 'QMP_PATH' in os.environ:
-        path = os.environ['QMP_PATH']
-
-    while len(args):
-        arg = args[0]
-
-        if arg.startswith('--'):
-            arg = arg[2:]
-            if arg.find('=') == -1:
-                value = True
-            else:
-                arg, value = arg.split('=', 1)
-
-            if arg in ['path']:
-                if type(value) == str:
-                    path = value
-            elif arg in ['help']:
-                os.execlp('man', 'man', 'qmp')
-            else:
-                print('Unknown argument "%s"' % arg)
-
-            args = args[1:]
-        else:
-            break
-
-    if not path:
-        print("QMP path isn't set, use --path=qmp-monitor-address or set QMP_PATH")
-        return 1
-
-    if len(args):
-        command, args = args[0], args[1:]
-    else:
-        print('No command found')
-        print('Usage: "qmp [--path=qmp-monitor-address] qmp-cmd arguments"')
-        return 1
-
-    if command in ['help']:
-        os.execlp('man', 'man', 'qmp')
-
-    srv = QEMUMonitorProtocol(path)
-    srv.connect()
-
-    def do_command(srv, cmd, **kwds):
-        rsp = srv.cmd(cmd, kwds)
-        if 'error' in rsp:
-            raise Exception(rsp['error']['desc'])
-        return rsp['return']
-
-    commands = map(lambda x: x['name'], do_command(srv, 'query-commands'))
-
-    srv.close()
-
-    if command not in commands:
-        fullcmd = 'qmp-%s' % command
-        try:
-            os.environ['QMP_PATH'] = path
-            os.execvp(fullcmd, [fullcmd] + args)
-        except OSError as exc:
-            if exc.errno == 2:
-                print('Command "%s" not found.' % (fullcmd))
-                return 1
-            raise
-        return 0
-
-    srv = QEMUMonitorProtocol(path)
-    srv.connect()
-
-    arguments = {}
-    for arg in args:
-        if not arg.startswith('--'):
-            print('Unknown argument "%s"' % arg)
-            return 1
-
-        arg = arg[2:]
-        if arg.find('=') == -1:
-            value = True
-        else:
-            arg, value = arg.split('=', 1)
-
-        if arg in ['help']:
-            os.execlp('man', 'man', 'qmp-%s' % command)
-            return 1
-
-        arguments[arg] = value
-
-    rsp = do_command(srv, command, **arguments)
-    print_response(rsp)
-
-if __name__ == '__main__':
-    sys.exit(main(sys.argv[1:]))
+sys.exit(1)
-- 
2.26.2


