Return-Path: <SRS0=3KIA=4V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB17C3F2D1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 588F620838
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2020 21:42:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BJ0c23LL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 588F620838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9bmn-0004lW-Fg
	for qemu-devel@archiver.kernel.org; Wed, 04 Mar 2020 16:42:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1j9bis-0006Jn-42
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1j9biq-0007bY-EA
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:34 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33871
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>) id 1j9biq-0007bO-A3
 for qemu-devel@nongnu.org; Wed, 04 Mar 2020 16:38:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583357912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SJXLUajiq3YMTkLwEJrAD67OeT7UWGUmWE02Z1mt+zU=;
 b=BJ0c23LLiKnKza07oTTz2qqw96LeIHOnw7D5BZIA17T9TcCHOK4JpIkNT0FEfpjNjZKYOH
 HRlAJ4e8aphvq1xKjMzHBU9CT7fH2ByPChtfM/Tw07KhAR2MHKz+mvSAEqlKLiVq4nAypj
 JEEPI4ufq9XtQI/45T41tSwsBc0PXrs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-0i9ZZPeuMz2T-PxGGZ8nJg-1; Wed, 04 Mar 2020 16:38:28 -0500
X-MC-Unique: 0i9ZZPeuMz2T-PxGGZ8nJg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 953C513E2;
 Wed,  4 Mar 2020 21:38:27 +0000 (UTC)
Received: from probe.redhat.com (ovpn-120-212.rdu2.redhat.com [10.10.120.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A1DC5C1D4;
 Wed,  4 Mar 2020 21:38:26 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 06/10] iotests: limit line length to 79 chars
Date: Wed,  4 Mar 2020 16:38:14 -0500
Message-Id: <20200304213818.15341-7-jsnow@redhat.com>
In-Reply-To: <20200304213818.15341-1-jsnow@redhat.com>
References: <20200304213818.15341-1-jsnow@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, armbru@redhat.com,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

79 is the PEP8 recommendation. This recommendation works well for
reading patch diffs in TUI email clients.

Signed-off-by: John Snow <jsnow@redhat.com>
---
 tests/qemu-iotests/iotests.py | 69 ++++++++++++++++++++++-------------
 tests/qemu-iotests/pylintrc   |  6 ++-
 2 files changed, 48 insertions(+), 27 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 54d68774e1..1be11f491f 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -76,9 +76,11 @@
 def qemu_img(*args):
     '''Run qemu-img and return the exit code'''
     devnull =3D open('/dev/null', 'r+')
-    exitcode =3D subprocess.call(qemu_img_args + list(args), stdin=3Ddevnu=
ll, stdout=3Ddevnull)
+    exitcode =3D subprocess.call(qemu_img_args + list(args),
+                               stdin=3Ddevnull, stdout=3Ddevnull)
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode,=
 ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' % (
+            -exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
=20
 def ordered_qmp(qmsg, conv_keys=3DTrue):
@@ -117,7 +119,8 @@ def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit cod=
e'''
     exitcode =3D subprocess.call(qemu_img_args + list(args))
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode,=
 ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' % (
+            -exitcode, ' '.join(qemu_img_args + list(args))))
     return exitcode
=20
 def qemu_img_pipe(*args):
@@ -128,7 +131,8 @@ def qemu_img_pipe(*args):
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode,=
 ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n' % (
+            -exitcode, ' '.join(qemu_img_args + list(args))))
     return subp.communicate()[0]
=20
 def qemu_img_log(*args):
@@ -158,7 +162,8 @@ def qemu_io(*args):
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, =
' '.join(args)))
+        sys.stderr.write('qemu-io received signal %i: %s\n' % (
+            -exitcode, ' '.join(args)))
     return subp.communicate()[0]
=20
 def qemu_io_log(*args):
@@ -280,10 +285,13 @@ def filter_test_dir(msg):
 def filter_win32(msg):
     return win32_re.sub("", msg)
=20
-qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* \([0-9\/.inf]* [EPT=
GMKiBbytes]*\/sec and [0-9\/.inf]* ops\/sec\)")
+qemu_io_re =3D re.compile(r"[0-9]* ops; [0-9\/:. sec]* "
+                        r"\([0-9\/.inf]* [EPTGMKiBbytes]*\/sec "
+                        r"and [0-9\/.inf]* ops\/sec\)")
 def filter_qemu_io(msg):
     msg =3D filter_win32(msg)
-    return qemu_io_re.sub("X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)=
", msg)
+    return qemu_io_re.sub("X ops; XX:XX:XX.X "
+                          "(XXX YYY/sec and XXX ops/sec)", msg)
=20
 chown_re =3D re.compile(r"chown [0-9]+:[0-9]+")
 def filter_chown(msg):
@@ -335,7 +343,9 @@ def filter_img_info(output, filename):
         line =3D line.replace(filename, 'TEST_IMG') \
                    .replace(imgfmt, 'IMGFMT')
         line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
-        line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XXXX=
-XXXXXXXXXXXX', line)
+        line =3D re.sub('uuid: [-a-f0-9]+',
+                      'uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
+                      line)
         line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
         lines.append(line)
     return '\n'.join(lines)
@@ -356,12 +366,9 @@ def log(msg, filters=3D(), indent=3DNone):
     for flt in filters:
         msg =3D flt(msg)
     if isinstance(msg, (dict, list)):
-        # Python < 3.4 needs to know not to add whitespace when pretty-pri=
nting:
-        separators =3D (', ', ': ') if indent is None else (',', ': ')
         # Don't sort if it's already sorted
         do_sort =3D not isinstance(msg, OrderedDict)
-        print(json.dumps(msg, sort_keys=3Ddo_sort,
-                         indent=3Dindent, separators=3Dseparators))
+        print(json.dumps(msg, sort_keys=3Ddo_sort, indent=3Dindent))
     else:
         print(msg)
=20
@@ -529,11 +536,13 @@ def pause_drive(self, drive, event=3DNone):
             self.pause_drive(drive, "write_aio")
             return
         self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, ev=
ent, drive))
+                 command_line=3D'qemu-io %s "break %s bp_%s"' % (
+                     drive, event, drive))
=20
     def resume_drive(self, drive):
         self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (drive=
, drive))
+                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (
+                     drive, drive))
=20
     def hmp_qemu_io(self, drive, cmd):
         '''Write to a given drive using an HMP command'''
@@ -790,16 +799,18 @@ def dictpath(self, d, path):
                 idx =3D int(idx)
=20
             if not isinstance(d, dict) or component not in d:
-                self.fail('failed path traversal for "%s" in "%s"' % (path=
, str(d)))
+                self.fail(f'failed path traversal for "{path}" in "{d}"')
             d =3D d[component]
=20
             if m:
                 if not isinstance(d, list):
-                    self.fail('path component "%s" in "%s" is not a list i=
n "%s"' % (component, path, str(d)))
+                    self.fail(f'path component "{component}" in "{path}" '
+                              f'is not a list in "{d}"')
                 try:
                     d =3D d[idx]
                 except IndexError:
-                    self.fail('invalid index "%s" in path "%s" in "%s"' % =
(idx, path, str(d)))
+                    self.fail(f'invalid index "{idx}" in path "{path}" '
+                              f'in "{d}"')
         return d
=20
     def assert_qmp_absent(self, d, path):
@@ -850,10 +861,13 @@ def assert_json_filename_equal(self, json_filename, r=
eference):
         '''Asserts that the given filename is a json: filename and that it=
s
            content is equal to the given reference object'''
         self.assertEqual(json_filename[:5], 'json:')
-        self.assertEqual(self.vm.flatten_qmp_object(json.loads(json_filena=
me[5:])),
-                         self.vm.flatten_qmp_object(reference))
+        self.assertEqual(
+            self.vm.flatten_qmp_object(json.loads(json_filename[5:])),
+            self.vm.flatten_qmp_object(reference)
+        )
=20
-    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse, resume=3DFa=
lse, wait=3D60.0):
+    def cancel_and_wait(self, drive=3D'drive0', force=3DFalse,
+                        resume=3DFalse, wait=3D60.0):
         '''Cancel a block job and wait for it to finish, returning the eve=
nt'''
         result =3D self.vm.qmp('block-job-cancel', device=3Ddrive, force=
=3Dforce)
         self.assert_qmp(result, 'return', {})
@@ -877,8 +891,8 @@ def cancel_and_wait(self, drive=3D'drive0', force=3DFal=
se, resume=3DFalse, wait=3D60.0):
         self.assert_no_active_block_jobs()
         return result
=20
-    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue, =
wait=3D60.0,
-                             error=3DNone):
+    def wait_until_completed(self, drive=3D'drive0', check_offset=3DTrue,
+                             wait=3D60.0, error=3DNone):
         '''Wait for a block job to finish, returning the event'''
         while True:
             for event in self.vm.get_qmp_events(wait=3Dwait):
@@ -1017,8 +1031,11 @@ def verify_quorum():
         notrun('quorum support missing')
=20
 def qemu_pipe(*args):
-    '''Run qemu with an option to print something and exit (e.g. a help op=
tion),
-    and return its output'''
+    """
+    Run qemu with an option to print something and exit (e.g. a help optio=
n).
+
+    :return: QEMU's stdout output.
+    """
     args =3D [qemu_prog] + qemu_opts + list(args)
     subp =3D subprocess.Popen(args, stdout=3Dsubprocess.PIPE,
                             stderr=3Dsubprocess.STDOUT,
@@ -1056,8 +1073,8 @@ def func_wrapper(test_case: QMPTestCase, *args, **kwa=
rgs):
=20
             usf_list =3D list(set(fmts) - set(supported_formats(read_only)=
))
             if usf_list:
-                test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
-                    test_case, usf_list))
+                test_case.case_skip(f'{test_case}: formats {usf_list} '
+                                    'are not whitelisted')
                 return None
             else:
                 return func(test_case, *args, **kwargs)
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index 8720b6a0de..8d02f00607 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -19,4 +19,8 @@ disable=3Dinvalid-name,
         too-many-public-methods,
         # These are temporary, and should be removed:
         missing-docstring,
-        line-too-long,
+
+[FORMAT]
+
+# Maximum number of characters on a single line.
+max-line-length=3D79
--=20
2.21.1


