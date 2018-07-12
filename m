Received: from eggs.gnu.org ([2001:4830:134:3::10]:54372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdjsi-0007AP-Vn
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 18:16:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jsnow@redhat.com>) id 1fdjsi-0000gh-2C
	for qemu-devel@nongnu.org; Thu, 12 Jul 2018 18:16:12 -0400
From: John Snow <jsnow@redhat.com>
Message-ID: <d8b2dc17-d275-272d-a8b3-c4369de4c67d@redhat.com>
Date: Thu, 12 Jul 2018 18:16:05 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] qemu-iotests RC0+ status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>

Hi, on Fedora 28 x64 host, as of 68f1b569 I'm seeing:

`./check -v -qcow`
	- occasional stall on 052
	- stalls on 216

`./check -v -qed`
	- stalls on 200

`./check -v -luks`
	- failures on 226.


052 is something I can't reproduce. The test takes quite a while, so
maybe at some points I am simply not being patient enough.


216 appears to have never worked for qcow1.


226 is my fault: the test doesn't handle LUKS well, because it sets
TEST_IMG to something sneaky:
'driver=luks,key-secret=keysec0,file.filename=/path/to/src/qemu/bin/git/tests/qemu-iotests/scratch/t.luks'
... my test expected this to be a real file and doesn't suffer this
particularly well. I've sent a patch.


200 appears to regress on this commit:
f45280cbf66d8e58224f6a253d0ae2aa72cc6280 is the first bad commit
commit f45280cbf66d8e58224f6a253d0ae2aa72cc6280
Author: Greg Kurz <groug@kaod.org>
Date:   Mon May 28 14:03:59 2018 +0200



Thanks,
--js
