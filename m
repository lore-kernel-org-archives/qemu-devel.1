Received: from eggs.gnu.org ([2001:4830:134:3::10]:38276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driYV-0007yZ-Cr
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1driYP-00071R-Af
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:36:35 -0400
Received: from mail-wm0-x22b.google.com ([2a00:1450:400c:c09::22b]:45845)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1driYP-000704-4S
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 06:36:29 -0400
Received: by mail-wm0-x22b.google.com with SMTP id f199so56878457wme.0
	for <qemu-devel@nongnu.org>; Tue, 12 Sep 2017 03:36:28 -0700 (PDT)
Date: Tue, 12 Sep 2017 11:36:25 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170912103625.GF6123@stefanha-x1.localdomain>
References: <129545317.4985876.1504789379418.ref@mail.yahoo.com>
	<129545317.4985876.1504789379418@mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <129545317.4985876.1504789379418@mail.yahoo.com>
Subject: Re: [Qemu-devel] Converting host virtual addresses to guest physical
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Padmanabhan S N <paddusn@yahoo.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Thu, Sep 07, 2017 at 01:02:59PM +0000, Padmanabhan S N via Qemu-devel wrote:
> I'm developing a new block backend driver. Since my Guest RAM is coming out of shared memory (memory-backend-file,mem-path=/dev/shmem/foo), while performing the IO I would like to pass QEMUIOVector buffers directly to another user-space process running on the same host to enable zerocopy. Can someone help me understand the different memory regions that are mapped in the qemu process address space and how they map to each other ?
> 1. My guest is configured with 1G RAM. /proc/<pid>/maps on the qemu process shows two 1G regions that are mapped. One of them is /dev/shmem/foo, which I believe corresponds to the guest physical memory. What is the other 1G region ? 
> 2. The QEMUIOVector buffers point to this 'other' 1G region that I referred above. How do I convert these pointers to locations in the /dev/shmem/foo region ? My plan is to convert the QEMUIOVector buffer pointer to a region in /dev/shmem/foo and pass that pointer to another userspace process that also has the /dev/shmem/foo region mapped.

Please post the full QEMU command-line and /proc/<pid>/maps.

> I understand vhost-user might be the right way to approach this problem. However I'm currently working with qemu-2.8 and it looks neither vhost-user-scsi nor vhost-user-blk are available in that version. If you believe there is a better approach to solve this problem, let me know.

Are you sure that QEMU 2.8 will still be relevant by the time your block
driver is production-ready?

Stefan
