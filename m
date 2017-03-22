Received: from eggs.gnu.org ([2001:4830:134:3::10]:58724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqh3F-0000sW-Uw
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:15:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cqh3B-0007LB-1a
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 10:15:49 -0400
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
	<20170322133509.30547.6423.malone@soybean.canonical.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <69a94326-4115-cac7-7f0f-1f455896fd2c@redhat.com>
Date: Wed, 22 Mar 2017 15:15:23 +0100
MIME-Version: 1.0
In-Reply-To: <20170322133509.30547.6423.malone@soybean.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Bug 1674925] Re: Qemu PPC64 kvm no display if
 --device virtio-gpu-pci is selected
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1674925 <1674925@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemU-ppc@nongnu.org

On 22.03.2017 14:35, luigiburdo wrote:
> Hi Thomas with 2.9 rc1 i have this with --enable-kvm
> 
> emu-system-ppc64 --enable-kvm
> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kernel XICS
> 
> and the qemu dont run.

Does it exit, or just hang afterwards? Was this with or without --device
virtio-gpu-pci option? Do you get any output if you run QEMU with
"-nographic" instead?

 Thomas
