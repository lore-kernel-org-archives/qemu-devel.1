Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AD59C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF0EF22263
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 10:19:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZLFesMBb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF0EF22263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXM4P-0007fB-Ls
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 06:19:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXM2g-0006fe-4D
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:17:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54552)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1kXM2Y-0006km-7s
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 06:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603793832;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/ZvcjIFipLmB2yeqWuLImtzpnfkfJSGR6QF/uPVnN6g=;
 b=ZLFesMBbUm04UHGcrKhQ58LEQMm8vCkZCOF0qmxuv9EPM91gtx9y5qFU+EBsSP5uwPq9ed
 F6jZE1GQlaVXixRbSVm378jbBfrgw2R5ltGCen0jFlKIR38pIHfhTBUsfTxKkdDFuRCQH3
 k9INrMLhasy9gtJAoFSJ8bIN1Rk0aJY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-6AJO8gMCPfmCC2HuuyRtyA-1; Tue, 27 Oct 2020 06:17:10 -0400
X-MC-Unique: 6AJO8gMCPfmCC2HuuyRtyA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 748DF1074645;
 Tue, 27 Oct 2020 10:17:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-182.ams2.redhat.com
 [10.36.112.182])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0C4CF5B4AF;
 Tue, 27 Oct 2020 10:17:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8C9961138461; Tue, 27 Oct 2020 11:17:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 2/2] scripts/qmp: delete 'qmp' script
Date: Tue, 27 Oct 2020 11:17:07 +0100
Message-Id: <20201027101707.2988553-3-armbru@redhat.com>
In-Reply-To: <20201027101707.2988553-1-armbru@redhat.com>
References: <20201027101707.2988553-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=armbru@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="US-ASCII"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
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
Cc: peter.maydell@linaro.org, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

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
Message-Id: <20201019210430.1063390-1-jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
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


