Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3B90C47404
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B782064A
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 07:31:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B782064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIpOG-0000c9-GK
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 03:31:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1iIpKd-0006tX-HH
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1iIpKc-00053c-3V
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 03:27:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60194)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1iIpKY-00052X-4o; Fri, 11 Oct 2019 03:27:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 46C61309DEE1;
 Fri, 11 Oct 2019 07:27:17 +0000 (UTC)
Received: from thuth.remote.csb (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E1FA194BE;
 Fri, 11 Oct 2019 07:27:16 +0000 (UTC)
Subject: Re: [PATCH 00/23] iotests: Add and use $SOCK_DIR
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20191010152457.17713-1-mreitz@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=thuth@redhat.com; prefer-encrypt=mutual; keydata=
 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
Organization: Red Hat
Message-ID: <5f346ee9-9ffe-7290-eb0e-50d2ab28d363@redhat.com>
Date: Fri, 11 Oct 2019 09:27:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191010152457.17713-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Fri, 11 Oct 2019 07:27:17 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/2019 17.24, Max Reitz wrote:
> Hi,
>=20
> Perhaps the main reason we cannot run important tests such as 041 in CI
> is that when they care Unix sockets in $TEST_DIR, the path may become
> too long to connect to them.
>=20
> To get by this problem, this series lets the check script create a new
> temporary directory (mktemp -d) and then makes the iotests use it for
> all Unix sockets.

Thanks a lot for tackling this!

I gave it a try, and most tests work fine now indeed when I run them in
a directory with a veeeery long file name.

I still get an error with 028 though:


$ ./check -qcow2 028
QEMU          --
"/home/thuth/tmp/qemu-with-very-long-directory-name-012345678901234567890=
1234567890123456789012345678901234567890123456789012345678901234567890123=
4567890123456789/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_=
64"
-nodefaults -display none -machine accel=3Dqtest
QEMU_IMG      --
"/home/thuth/tmp/qemu-with-very-long-directory-name-012345678901234567890=
1234567890123456789012345678901234567890123456789012345678901234567890123=
4567890123456789/tests/qemu-iotests/../../qemu-img"

QEMU_IO       --
"/home/thuth/tmp/qemu-with-very-long-directory-name-012345678901234567890=
1234567890123456789012345678901234567890123456789012345678901234567890123=
4567890123456789/tests/qemu-iotests/../../qemu-io"
 --cache writeback -f qcow2
QEMU_NBD      --
"/home/thuth/tmp/qemu-with-very-long-directory-name-012345678901234567890=
1234567890123456789012345678901234567890123456789012345678901234567890123=
4567890123456789/tests/qemu-iotests/../../qemu-nbd"

IMGFMT        -- qcow2 (compat=3D1.1)
IMGPROTO      -- file
PLATFORM      -- Linux/x86_64 thuth 4.18.0-80.11.2.el8_0.x86_64
TEST_DIR      --
/home/thuth/tmp/qemu-with-very-long-directory-name-0123456789012345678901=
2345678901234567890123456789012345678901234567890123456789012345678901234=
567890123456789/tests/qemu-iotests/scratch
SOCK_DIR      -- /tmp/tmp.YEmubpCxRH
SOCKET_SCM_HELPER --
/home/thuth/tmp/qemu-with-very-long-directory-name-0123456789012345678901=
2345678901234567890123456789012345678901234567890123456789012345678901234=
567890123456789/tests/qemu-iotests/socket_scm_helper

028      fail       [09:11:52] [09:11:53]                    output
mismatch (see 028.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/028.out	2019-08-16
18:00:39.258741027 +0200
+++
/home/thuth/tmp/qemu-with-very-long-directory-name-0123456789012345678901=
2345678901234567890123456789012345678901234567890123456789012345678901234=
567890123456789/tests/qemu-iotests/028.out.bad
2019-10-11 09:11:53.822111901 +0200
@@ -468,7 +468,8 @@

 block-backup

-Formatting 'TEST_DIR/t.IMGFMT.copy', fmt=3DIMGFMT size=3D4294968832
backing_file=3DTEST_DIR/t.IMGFMT.base backing_fmt=3DIMGFMT
+(qemu)
+Timeout waiting for Formatting on handle 0
 (qemu) info block-jobs
 No active jobs
 =3D=3D=3D IO: pattern 195
Failures: 028
Failed 1 of 1 iotests


028 works fine if I start it from a directory with a short filename.


I also saw an error with "./check -raw 055" once, but it does not seem
to be reproducible:


055      fail       [09:08:28] [09:10:57]                    output
mismatch (see 055.out.bad)
--- /home/thuth/devel/qemu/tests/qemu-iotests/055.out	2019-08-16
18:00:39.262741079 +0200
+++
/home/thuth/tmp/qemu-with-very-long-directory-name-0123456789012345678901=
2345678901234567890123456789012345678901234567890123456789012345678901234=
567890123456789/tests/qemu-iotests/055.out.bad
2019-10-11 09:10:57.059254617 +0200
@@ -1,5 +1,35 @@
-..............................
+WARNING:qemu.machine:qemu received signal 9:
/home/thuth/tmp/qemu-with-very-long-directory-name-0123456789012345678901=
2345678901234567890123456789012345678901234567890123456789012345678901234=
567890123456789/tests/qemu-iotests/../../x86_64-softmmu/qemu-system-x86_6=
4
-chardev socket,id=3Dmon,path=3D/tmp/tmp.3mKmQDU7Ft/qemu-24878-monitor.so=
ck
-mon chardev=3Dmon,mode=3Dcontrol -display none -vga none -qtest
unix:path=3D/tmp/tmp.3mKmQDU7Ft/qemu-24878-qtest.sock -accel qtest
-nodefaults -display none -machine accel=3Dqtest -drive
if=3Dvirtio,id=3Ddrive0,file=3Dblkdebug::/home/thuth/tmp/qemu-with-very-l=
ong-directory-name-012345678901234567890123456789012345678901234567890123=
45678901234567890123456789012345678901234567890123456789/tests/qemu-iotes=
ts/scratch/test.img,format=3Draw,cache=3Dwriteback
-drive
if=3Dnone,id=3Ddrive1,file=3D/home/thuth/tmp/qemu-with-very-long-director=
y-name-012345678901234567890123456789012345678901234567890123456789012345=
67890123456789012345678901234567890123456789/tests/qemu-iotests/scratch/b=
lockdev-target.img,format=3Dvmdk,cache=3Dwriteback
+E.............................
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+ERROR: test_complete_compress_blockdev_backup
(__main__.TestDriveCompression)
+----------------------------------------------------------------------
+Traceback (most recent call last):
+  File
"/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qmp.py",
line 122, in __get_events
+    ret =3D self.__json_read(only_event=3DTrue)
+  File
"/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qmp.py",
line 82, in __json_read
+    data =3D self.__sockfile.readline()
+  File "/usr/lib64/python3.6/socket.py", line 586, in readinto
+    return self._sock.recv_into(b)
+socket.timeout: timed out
+
+During handling of the above exception, another exception occurred:
+
+Traceback (most recent call last):
+  File "055", line 499, in test_complete_compress_blockdev_backup
+    target=3D'drive1')
+  File "055", line 484, in do_test_compress_complete
+    self.wait_until_completed()
+  File "/home/thuth/devel/qemu/tests/qemu-iotests/iotests.py", line
751, in wait_until_completed
+    for event in self.vm.get_qmp_events(wait=3Dwait):
+  File
"/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/machine.py",=
 line
406, in get_qmp_events
+    events =3D self._qmp.get_events(wait=3Dwait)
+  File
"/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qmp.py",
line 236, in get_events
+    self.__get_events(wait)
+  File
"/home/thuth/devel/qemu/tests/qemu-iotests/../../python/qemu/qmp.py",
line 124, in __get_events
+    raise QMPTimeoutError("Timeout waiting for event")
+qemu.qmp.QMPTimeoutError: Timeout waiting for event
+
 ----------------------------------------------------------------------
 Ran 30 tests

-OK
+FAILED (errors=3D1)

 Thomas

