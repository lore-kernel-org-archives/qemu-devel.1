Received: from eggs.gnu.org ([2001:4830:134:3::10]:33102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hyu@cs.utexas.edu>) id 1gPZds-0004h5-OA
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hyu@cs.utexas.edu>) id 1gPZdm-0007YS-ME
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:36 -0500
Received: from newman.cs.utexas.edu ([128.83.139.110]:48657)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <hyu@cs.utexas.edu>) id 1gPZdk-0007Ql-Nd
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 16:02:29 -0500
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com
	[209.85.167.42]) (authenticated bits=0)
	by newman.cs.utexas.edu (8.14.4/8.14.4/Debian-4.1ubuntu1) with ESMTP id
	wALKoGPe048351
	(version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 14:50:17 -0600
Received: by mail-lf1-f42.google.com with SMTP id n18so4993225lfh.6
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 12:50:17 -0800 (PST)
MIME-Version: 1.0
From: Hangchen YU <hyu@cs.utexas.edu>
Date: Wed, 21 Nov 2018 14:50:02 -0600
Message-ID: <CAFR1mYHjqa20cKUHKBeepZR9TSbQK96d-ayv8mkS8bHy9GswkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] MMIO access hangs the whole virtual machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi-

I created an IO by memory_region_init_io with a MemoryRegionOps in a block
device. The IO r/w handler takes a while to finish, and during that time
the whole VM hangs.
There was a similar discussion about the synchronous qemu_aio_cancel four
years ago (
https://lists.gnu.org/archive/html/qemu-devel/2014-08/msg01545.html). Has
that issue been resolved or is there any alternative way to make the MMIO
access asynchronous?

Thanks,
Hangchen
