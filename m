Received: from eggs.gnu.org ([209.51.188.92]:50841)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1giMqw-0003kw-Vl
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:13:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjt@tls.msk.ru>) id 1giMp3-0005Jz-Jx
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:11:50 -0500
Received: from isrv.corpit.ru ([86.62.121.231]:47349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mjt@tls.msk.ru>) id 1giMp3-0005If-CT
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:11:49 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
	by isrv.corpit.ru (Postfix) with ESMTP id 4DFB640696
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 20:11:48 +0300 (MSK)
Received: from [192.168.177.103] (mjtmob.vpn.tls.msk.ru [192.168.177.103])
	by tsrv.corpit.ru (Postfix) with ESMTP id 32DBC5B
	for <qemu-devel@nongnu.org>; Sat, 12 Jan 2019 20:11:48 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <e5021228-184b-cc1b-7aba-3bba795127a6@msgid.tls.msk.ru>
Date: Sat, 12 Jan 2019 20:11:48 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: ru-RU
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] 3.1: second invocation of migrate crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>

$ qemu-system-x86_64 -monitor stdio -hda foo.img
QEMU 3.1.0 monitor - type 'help' for more information
(qemu) stop
(qemu) migrate "exec:cat >/dev/null"
(qemu) migrate "exec:cat >/dev/null"
qemu-system-x86_64: /build/qemu/qemu-3.1/block.c:4647: bdrv_inactivate_recurse: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
Aborted

(it is irrelevant what's in foo.img, it only needs to be initialized).

If it is worth to bisect I'll do that tomorrow.

Thanks,

/mjt
