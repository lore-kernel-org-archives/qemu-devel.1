Received: from eggs.gnu.org ([2001:4830:134:3::10]:41827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnhDa-0001rE-N9
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dnhDV-0004ZK-PB
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:22:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:9104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dnhDV-0004ZE-Ig
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 04:22:17 -0400
Date: Fri, 1 Sep 2017 16:22:13 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170901082213.GC4330@lemon.lan>
References: <20170831112210.19921-1-famz@redhat.com>
	<20170831112210.19921-4-famz@redhat.com>
	<20170831161835.GQ17315@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170831161835.GQ17315@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 3/3] docker: Add test-block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>

On Thu, 08/31 17:18, Daniel P. Berrange wrote:
> Could you add  'check -luks' - it should be passing already with git
> master.  Ideally it wants password-less sudo enabled, but will skip
> the appropriate test if that's not there.

I have this failure:

192         - output mismatch (see 192.out.bad)
--- /home/fam/work/qemu/tests/qemu-iotests/192.out      2017-08-31 15:12:00.044744485 +0800
+++ 192.out.bad 2017-09-01 16:21:34.908390978 +0800
@@ -1,7 +1,4 @@
 QA output created by 192
 Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=67108864
-QEMU X.Y.Z monitor - type 'help' for more information
-(qemu) nbd_server_start unix:TEST_DIR/nbd
-(qemu) nbd_server_add -w drive0
-(qemu) q
+QEMU_PROG: -drive format=luks,file=driver=luks,key-secret=keysec0,file.filename=TEST_DIR/t.luks,if=ide,id=drive0: Can't specify 'file' and 'filename' options at the same time
 *** done
Failures: 192
Failed 1 of 1 tests

Fam
