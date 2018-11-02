Received: from eggs.gnu.org ([2001:4830:134:3::10]:42736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gIUYZ-0004hW-0K
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 04:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dongli.zhang@oracle.com>) id 1gIUYT-0008SK-BK
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 04:11:50 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43482)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dongli.zhang@oracle.com>)
	id 1gIUYM-0008My-HZ
	for qemu-devel@nongnu.org; Fri, 02 Nov 2018 04:11:41 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
	by userp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	wA288xUZ052893
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 08:11:33 GMT
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
	by userp2120.oracle.com with ESMTP id 2ncgnrd2kr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 02 Nov 2018 08:11:33 +0000
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
	by aserv0022.oracle.com (8.14.4/8.14.4) with ESMTP id wA28BWbj028172
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 08:11:32 GMT
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
	by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id wA28BWiI006229
	for <qemu-devel@nongnu.org>; Fri, 2 Nov 2018 08:11:32 GMT
MIME-Version: 1.0
Message-ID: <ae2d0fbd-5198-47e8-9ad2-40a85f0b3576@default>
Date: Fri, 2 Nov 2018 01:11:32 -0700 (PDT)
From: Dongli Zhang <dongli.zhang@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Subject: [Qemu-devel] How to emulate block I/O timeout on qemu side?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi,

Is there any way to emulate I/O timeout on qemu side (not fault injection i=
n VM
kernel) without modifying qemu source code?

For instance, I would like to observe/study/debug the I/O timeout handling =
of
nvme, scsi, virtio-blk (not supported) of VM kernel.

Is there a way to trigger this on purpose on qemu side?

Thank you very much!

Dongli Zhang
