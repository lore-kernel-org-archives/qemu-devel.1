Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA6AC47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:10:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D078C2078C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 13:10:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/H1WK+x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D078C2078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVxLI-0004sE-Ud
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 09:10:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxA6-0001oN-UB
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:02 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:48896
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mreitz@redhat.com>) id 1jVxA5-000171-2x
 for qemu-devel@nongnu.org; Tue, 05 May 2020 08:59:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588683540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0gr15OrJS9tsXYgJJWW/K6LyEGhoZx2WchC4Ory6oOA=;
 b=c/H1WK+xdeWIWh1RnsDS/oCW6mBUSzpcjpnP5KoZ9LwVnbgvYhyESedcnsyq+lcVRj+z13
 6etM0JaJ2w1leFq6wb9lcbn+hKfODbxZBPpDfbNFggnPzZFJKXQ69sQBi5fjA1uqQoWb9v
 zcTr2kwoiittW1w3HjCIb8IoXhO38Y8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-zab3n-jLN0KNVViENfGLkA-1; Tue, 05 May 2020 08:58:49 -0400
X-MC-Unique: zab3n-jLN0KNVViENfGLkA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31D2A1899526;
 Tue,  5 May 2020 12:58:48 +0000 (UTC)
Received: from localhost (ovpn-113-206.ams2.redhat.com [10.36.113.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A09305D9DA;
 Tue,  5 May 2020 12:58:47 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 09/24] iotests: limit line length to 79 chars
Date: Tue,  5 May 2020 14:58:11 +0200
Message-Id: <20200505125826.1001451-10-mreitz@redhat.com>
In-Reply-To: <20200505125826.1001451-1-mreitz@redhat.com>
References: <20200505125826.1001451-1-mreitz@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mreitz@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/05 00:37:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: John Snow <jsnow@redhat.com>

79 is the PEP8 recommendation. This recommendation works well for
reading patch diffs in TUI email clients.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
Message-Id: <20200331000014.11581-10-jsnow@redhat.com>
Reviewed-by: Kevin Wolf <kwolf@redhat.com>
Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/iotests.py | 64 +++++++++++++++++++++++------------
 tests/qemu-iotests/pylintrc   |  6 +++-
 2 files changed, 47 insertions(+), 23 deletions(-)

diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
index 69f24223d2..9f5da32dae 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -80,9 +80,11 @@ luks_default_key_secret_opt =3D 'key-secret=3Dkeysec0'
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
+        sys.stderr.write('qemu-img received signal %i: %s\n'
+                         % (-exitcode, ' '.join(qemu_img_args + list(args)=
)))
     return exitcode
=20
 def ordered_qmp(qmsg, conv_keys=3DTrue):
@@ -121,7 +123,8 @@ def qemu_img_verbose(*args):
     '''Run qemu-img without suppressing its output and return the exit cod=
e'''
     exitcode =3D subprocess.call(qemu_img_args + list(args))
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode,=
 ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n'
+                         % (-exitcode, ' '.join(qemu_img_args + list(args)=
)))
     return exitcode
=20
 def qemu_img_pipe(*args):
@@ -132,7 +135,8 @@ def qemu_img_pipe(*args):
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu-img received signal %i: %s\n' % (-exitcode,=
 ' '.join(qemu_img_args + list(args))))
+        sys.stderr.write('qemu-img received signal %i: %s\n'
+                         % (-exitcode, ' '.join(qemu_img_args + list(args)=
)))
     return subp.communicate()[0]
=20
 def qemu_img_log(*args):
@@ -162,7 +166,8 @@ def qemu_io(*args):
                             universal_newlines=3DTrue)
     exitcode =3D subp.wait()
     if exitcode < 0:
-        sys.stderr.write('qemu-io received signal %i: %s\n' % (-exitcode, =
' '.join(args)))
+        sys.stderr.write('qemu-io received signal %i: %s\n'
+                         % (-exitcode, ' '.join(args)))
     return subp.communicate()[0]
=20
 def qemu_io_log(*args):
@@ -284,10 +289,13 @@ win32_re =3D re.compile(r"\r")
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
@@ -340,7 +348,9 @@ def filter_img_info(output, filename):
         line =3D filter_testfiles(line)
         line =3D line.replace(imgfmt, 'IMGFMT')
         line =3D re.sub('iters: [0-9]+', 'iters: XXX', line)
-        line =3D re.sub('uuid: [-a-f0-9]+', 'uuid: XXXXXXXX-XXXX-XXXX-XXXX=
-XXXXXXXXXXXX', line)
+        line =3D re.sub('uuid: [-a-f0-9]+',
+                      'uuid: XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX',
+                      line)
         line =3D re.sub('cid: [0-9]+', 'cid: XXXXXXXXXX', line)
         lines.append(line)
     return '\n'.join(lines)
@@ -538,11 +548,13 @@ class VM(qtest.QEMUQtestMachine):
             self.pause_drive(drive, "write_aio")
             return
         self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "break %s bp_%s"' % (drive, ev=
ent, drive))
+                 command_line=3D'qemu-io %s "break %s bp_%s"'
+                 % (drive, event, drive))
=20
     def resume_drive(self, drive):
         self.qmp('human-monitor-command',
-                 command_line=3D'qemu-io %s "remove_break bp_%s"' % (drive=
, drive))
+                 command_line=3D'qemu-io %s "remove_break bp_%s"'
+                 % (drive, drive))
=20
     def hmp_qemu_io(self, drive, cmd):
         '''Write to a given drive using an HMP command'''
@@ -802,16 +814,18 @@ class QMPTestCase(unittest.TestCase):
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
@@ -862,10 +876,13 @@ class QMPTestCase(unittest.TestCase):
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
@@ -889,8 +906,8 @@ class QMPTestCase(unittest.TestCase):
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
@@ -1029,8 +1046,11 @@ def verify_quorum():
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
@@ -1068,8 +1088,8 @@ def skip_if_unsupported(required_formats=3D(), read_o=
nly=3DFalse):
=20
             usf_list =3D list(set(fmts) - set(supported_formats(read_only)=
))
             if usf_list:
-                test_case.case_skip('{}: formats {} are not whitelisted'.f=
ormat(
-                    test_case, usf_list))
+                msg =3D f'{test_case}: formats {usf_list} are not whitelis=
ted'
+                test_case.case_skip(msg)
                 return None
             else:
                 return func(test_case, *args, **kwargs)
diff --git a/tests/qemu-iotests/pylintrc b/tests/qemu-iotests/pylintrc
index daec2c4942..5481afe528 100644
--- a/tests/qemu-iotests/pylintrc
+++ b/tests/qemu-iotests/pylintrc
@@ -18,5 +18,9 @@ disable=3Dinvalid-name,
         too-many-locals,
         too-many-public-methods,
         # These are temporary, and should be removed:
-        line-too-long,
         missing-docstring,
+
+[FORMAT]
+
+# Maximum number of characters on a single line.
+max-line-length=3D79
--=20
2.26.2


