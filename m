Received: from eggs.gnu.org ([2001:4830:134:3::10]:44913)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFnzi-0003DE-BL
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:20:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gFnzd-0002qU-9k
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:20:46 -0400
Received: from indium.canonical.com ([91.189.90.7]:52696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gFnzd-0002q6-3R
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 18:20:41 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gFnzb-0006rd-72
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 22:20:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1CA5D2E80CC
	for <qemu-devel@nongnu.org>; Thu, 25 Oct 2018 22:20:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Oct 2018 22:11:35 -0000
From: Jose Carlos Venegas Munoz <1762707@bugs.launchpad.net>
Reply-To: Bug 1762707 <1762707@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152335683378.30174.9724305388945769166.malonedeb@gac.canonical.com>
Message-Id: <154050549549.13720.2363106623081279823.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1762707] Re: VFIO device gets DMA failures when
 virtio-balloon leak from highmem to lowmem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Alex, I see this issue is closed but I have a question, do you know if
the problem only comes the balloon is resized to return memory to the
host. I ask because we have a situation where we will start a VM with
balloon enabled, and later it maybe possible a devices is assigned via
hot-plug. So I would like to avoid this issue by doing the following:

if a vfio devices is assigned;
   resize the balloon size the the maximal guest memory
end =


Then because we know we added a vfio devices never resize the balloon to
return memory again.

More information about what we want to do: https://github.com/kata-
containers/runtime/pull/793

Regards,
Carlos

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1762707

Title:
  VFIO device gets DMA failures when virtio-balloon leak from highmem to
  lowmem

Status in QEMU:
  Invalid

Bug description:
  Is there any known conflict between VFIO passthrough device and
  virtio-balloon?

  The VM has:
  1. 4GB system memory
  2. one VFIO passthrough device which supports high address memory DMA and=
 uses GFP_HIGHUSER pages.
  3. Memory balloon device with 4GB target.

  When setting the memory balloon target to 1GB and 4GB in loop during
  runtime (I used the command "virsh qemu-monitor-command debian --hmp
  --cmd balloon 1024"), the VFIO device DMA randomly gets failure.

  More clues:
  1. configure 2GB system memory (no highmem) VM, no issue with similar ope=
rations
  2. setting the memory balloon to higher like 8GB, no issue with similar o=
perations

  I'm also trying to narrow down this issue. It's appreciated for that
  you guys may share some thoughts.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1762707/+subscriptions
