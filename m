Received: from eggs.gnu.org ([2001:4830:134:3::10]:33793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgCyk-0005rd-9V
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgCyh-00046q-0t
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:07:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35884)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgCyg-00045x-QQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:07:46 -0500
Date: Tue, 21 Feb 2017 09:07:45 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170221090745.7aea1461@t450s.home>
In-Reply-To: <58AC14C1.60603@cn.fujitsu.com>
References: <58AC14C1.60603@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] seek help for AER
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>

On Tue, 21 Feb 2017 18:21:53 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> Hi,
> 
> First, sorry for such a long time delay on the AER job. I was on 12 days
> holiday, and start to work on the patch 2 weeks ago, because I use a
> newer version kernel(4.10 rc8) to start off the work, several tiny
> problems slow me.
> 
> Now I meet a confusing issue on aer_inject module. When I use aer_inject
> command before, it says:
> 
>     Error: Failed to write, No such device
> 
> then in dmesg, it says:
> 
>     pcieport 0000:00:09.0: aer_inject: AER device not found
> 
> and then I add some debug line in find_aer_device_iter() to check
> device->bus-name, find that it is "pci", so that is why I can't inject,
> it should have been "pci_express". But everything is same as before
> except a newer host kernel.
> 
> I still don't have a clue on this problem for almost 2 days, could you help?

If it only happens with a new host kernel, I would suggest finding a
kernel where it works and bisecting between working and non-working
kernels to find the commit that introduced the change.  You may have
found a regression in the kernel that should be reported upstream.
Thanks,

Alex
