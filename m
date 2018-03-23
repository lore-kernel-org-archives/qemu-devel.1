Received: from eggs.gnu.org ([2001:4830:134:3::10]:49294)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1ezJPZ-0001Rg-LD
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:55:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jing2.liu@linux.intel.com>) id 1ezJPW-0003Px-4p
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:55:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:51248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jing2.liu@linux.intel.com>)
	id 1ezJPV-0003N5-QL
	for qemu-devel@nongnu.org; Fri, 23 Mar 2018 05:54:58 -0400
From: "Liu, Jing2" <jing2.liu@linux.intel.com>
Message-ID: <22f7f184-c295-4e18-c186-3fd9fdcce213@linux.intel.com>
Date: Fri, 23 Mar 2018 17:54:53 +0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [Consult] nfs-vsocks support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: yang.zhong@intel.com, stefanha@redhat.com

Hello,

I am currently trying to use nfs-vsocks on x86 for vitural machine 
filesystem by some manuals on 
https://www.spinics.net/lists/linux-nfs/msg64563.html
and https://lwn.net/Articles/647516/

It tells the quickstart steps with the following codes but I got some 
problems as listed.
  * Linux kernel: https://github.com/stefanha/linux.git vsock-nfs
  * QEMU virtio-vsock device: https://github.com/stefanha/qemu.git vsock
  * nfs-utils vsock: https://github.com/stefanha/nfs-utils.git vsock

1. I would like to ask what is the current status of these codes? If 
there're some updates? :)
2. nfs-utils codes could not compile for me... I refered to the README 
but failed for both ways. It seems no configure script and 
autoheader/automake... So I don't know how to install this.
3. For the 5th step (Start nfsd), I'd like to know the rpc.nfsd --vsock 
is enabled by which codes? Is it the CONFIG_VHOST_VSOCK kernel module in 
host? Because I installed the kernel with vsock-nfs repo with the 
specified config options but failed to do rpc.nfsd --vsock.


Could you give me some help and thanks in advance!

BRs,
Jing Liu
