Received: from eggs.gnu.org ([2001:4830:134:3::10]:46514)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqk5E-0004sM-Fm
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:30:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cqk5A-0003EJ-KT
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:30:04 -0400
Received: from 5.mo173.mail-out.ovh.net ([46.105.40.148]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cqk5A-0003E2-EB
	for qemu-devel@nongnu.org; Wed, 22 Mar 2017 13:30:00 -0400
Received: from player739.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo173.mail-out.ovh.net (Postfix) with ESMTP id E8DD52D872
	for <qemu-devel@nongnu.org>; Wed, 22 Mar 2017 18:29:57 +0100 (CET)
References: <20170322092818.25605.49354.malonedeb@gac.canonical.com>
	<20170322133509.30547.6423.malone@soybean.canonical.com>
	<69a94326-4115-cac7-7f0f-1f455896fd2c@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <e7be24c8-dbc6-0e32-5b18-73cd5454fc64@kaod.org>
Date: Wed, 22 Mar 2017 18:29:47 +0100
MIME-Version: 1.0
In-Reply-To: <69a94326-4115-cac7-7f0f-1f455896fd2c@redhat.com>
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
To: Thomas Huth <thuth@redhat.com>, Bug 1674925 <1674925@bugs.launchpad.net>, qemu-devel@nongnu.org
Cc: qemU-ppc@nongnu.org

On 03/22/2017 03:15 PM, Thomas Huth wrote:
> On 22.03.2017 14:35, luigiburdo wrote:
>> Hi Thomas with 2.9 rc1 i have this with --enable-kvm
>>
>> emu-system-ppc64 --enable-kvm
>> qemu-system-ppc64: KVM and IRQ_XICS capability must be present for in-kernel XICS
>>
>> and the qemu dont run.
> 
> Does it exit, or just hang afterwards? Was this with or without --device
> virtio-gpu-pci option? Do you get any output if you run QEMU with
> "-nographic" instead?

I guess this is an issue with the host kernel. Which one are you running ? 

C.
