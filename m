Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A9BC55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:38:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCE32076A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 16:38:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCE32076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXRz9-0006S1-VP
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 12:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrr-0006wc-Rr; Tue, 27 Oct 2020 12:30:41 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:50107)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>)
 id 1kXRrg-0001ZX-HR; Tue, 27 Oct 2020 12:30:32 -0400
Received: from localhost.localdomain ([82.252.139.38]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1M1qfu-1kVEw93cdM-002J5r; Tue, 27 Oct 2020 17:30:22 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 6/8] scripts/qmp: delete 'qmp' script
Date: Tue, 27 Oct 2020 17:30:12 +0100
Message-Id: <20201027163014.247336-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027163014.247336-1-laurent@vivier.eu>
References: <20201027163014.247336-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:8iVYIAo6CNjm8HetN2bxTGU1xtvkDVd73KOxTv+ipEqWtnovhTS
 BcMexsCCgTB2ifYi7FwbLDLEz49uGrOmg65aqheQQuRrVpHSgZnrJkSvFsKJKYx81b3cHOs
 lLBHZNo44BX+yJI6qoLa1GqtIyX9IfCoqNCZS+yzk4KU/Qpkyt/wCqTH+4eEBlnpLrBItQz
 KL1TLpEnGUOmTjYlBBqVg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J/dDARgCVsk=:21gqiUrwYfttXwXUaAgebF
 nDzsjsKmYT085tsrJjpyTh3rXFsTShTnbZsyE1tQpmzeD2hVnOkXnWDfjaKFp/QlhXMsa/vr9
 MlcbPf8JDVHq1dTcfQVasPlVvt3K7JtfX2x06mPJxB6/MHKZY4wgVMJOlNdxnTTFw7hT7K6Pd
 ApTjhH3t97mH/fO2wwyiNW3/GGK2lszDpe54BK3WQwfEFcy3mXNYmL0QwG6Uo31UXzBCoSBIa
 C1NUFbN+93hTmaRhJVU2hoPp7/28tVbD57xUgqhgmAAilq8AcaVEzUMlW8/QMJz6xXjgItjmb
 0RoNdOYP5E0ZlqsyH6MyHoQK2qnr76oGqbPw4OWfIvIwPOD7GcaWj4y9+VwkjwwP7I2cI4pyu
 AqbNy3hLCsChF4lwd95vhHsun3Z0FAYpeuJmBulyhlKQ2N6G/bU4k3RS4LHF7V9lzuNp9yEWJ
 lpdwZ8v3rg==
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 12:30:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
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
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20201019210430.1063390-1-jsnow@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 scripts/qmp/qmp | 131 +++---------------------------------------------
 1 file changed, 7 insertions(+), 124 deletions(-)

diff --git a/scripts/qmp/qmp b/scripts/qmp/qmp
index 8e52e4a54dee..0f12307c8767 100755
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


