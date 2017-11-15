Received: from eggs.gnu.org ([2001:4830:134:3::10]:53891)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lichunguang@hust.edu.cn>) id 1eEr8q-0001mw-AY
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:25:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lichunguang@hust.edu.cn>) id 1eEr8l-0004Aw-8H
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:25:44 -0500
Received: from mail.hust.edu.cn ([202.114.0.240]:65368 helo=hust.edu.cn)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lichunguang@hust.edu.cn>) id 1eEr8k-0003wK-DW
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 01:25:39 -0500
From: "Chunguang Li" <lichunguang@hust.edu.cn>
Date: Wed, 15 Nov 2017 14:24:37 +0800
Message-ID: <000001d35dda$6a1856b0$3e490410$@hust.edu.cn>
MIME-Version: 1.0
Content-Language: zh-cn
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Abnormal observation during migration: too many
 "write-not-dirty" pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: lichunguang@hust.edu.cn
Cc: qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, stefanha@redhat.com

Some more details about this experiment:

The host is running Ubuntu-16.04 with 4.4.0 Linux kernel and QEMU-2.5.1; The
guest is running Ubuntu-12.04, except Memcached with Ubuntu-16.04.

 

The exact numbers of the proportions of write-not-dirty pages for the first
2 pre-copy iterations: (0.445 means 44.5%)

Memcached:  0.445, 0.478

Zeusmp:      0.670, 0.727

Mcf:         0.808, 0.793

Bzip2:        0.464, 0.447

Milc:         0.341, 0.037

cactusADM:   0.280, 0.248

lbm:         0.090, 0.037

GemsFDTD:   0.226, 0.172

Bwaves:      0.069, 0.003

Astar:        0.113, 0.039

Xalancbmk:   0.082, 0.041

Wrf:         0.141, 0.073

 

Any advice? Looking forward to any response. Thank you.

 

Chunguang
