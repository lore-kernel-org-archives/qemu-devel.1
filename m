Received: from eggs.gnu.org ([2001:4830:134:3::10]:41433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNkgg-0004um-Bu
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:53:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1fNkgd-00004t-88
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:53:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37490 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1fNkgd-0008Vj-2i
	for qemu-devel@nongnu.org; Tue, 29 May 2018 15:53:39 -0400
References: <CA+6CiVCSPCQ-3iBa=ivJtqsbsV2G9MxTndDFXkMBk2AgWHxPOA@mail.gmail.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <7f7124d6-2775-9b5c-e647-6091aebe67a4@redhat.com>
Date: Tue, 29 May 2018 14:53:38 -0500
MIME-Version: 1.0
In-Reply-To: <CA+6CiVCSPCQ-3iBa=ivJtqsbsV2G9MxTndDFXkMBk2AgWHxPOA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Live viewing qemu running image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Olga Levy <olgalevy91@gmail.com>, qemu-devel@nongnu.org

On 05/29/2018 07:33 AM, Olga Levy wrote:
> Hi,
> 
> Nice to meet you. I'm a new security engineer and working on a prototype
> using QEMU.
> 
> What I need is to collect running image internal data (like running
> processes, netstat, files modification, etc.) but without running any
> process inside. I mean, doing it from "outside" (I need Qemu support).
> 
> For example,
> 
> How can I live view FS of a running image?

In general, you can't - qemu does not know and does not care what 
operating system the guest code is running, let alone what file systems 
that guest has structured on top of the raw storage that qemu is 
emulating for the guest.  What you are asking for is akin to asking 
Intel to add a new register to their chips that will tell you how many 
open files a bare-metal processor is managing, while telling the chip 
designers that they are not permitted to know whether the user will 
install Windows, Linux, or some other operating system on the machine 
using that chip.

With some effort and knowledge about specific types of guests, it IS 
possible to take snapshots of a guest, and then peek at specific memory 
locations or read the (hopefully consistent) state of the disk at the 
time of the snapshot to learn things about that guest.  And in fact, the 
libguestfs project does a LOT of those hacks, for several mainstream 
operating systems where the effort of writing the hacks is not too much 
of a maintenance burden.  But that's more a question for the libguestfs 
list, as interacting with the guest (or a snapshot of the guest) is 
outside the realm of things that qemu directly targets.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
