Received: from eggs.gnu.org ([2001:4830:134:3::10]:44493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e99Ot-0000wN-4l
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:42:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e99Oq-0005T9-1S
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 08:42:43 -0400
Date: Mon, 30 Oct 2017 13:42:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171030134233.6aaa81a1.cohuck@redhat.com>
In-Reply-To: <feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
References: <1507124979-8880-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<feea3ded-fecc-50ff-fe70-09e63966933b@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/5][RFC] Refactoring of AIS support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, qemu-devel@nongnu.org, agraf@suse.de, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, qemu-s390x@nongnu.org

On Mon, 30 Oct 2017 09:28:09 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> Now I thought about that for a while and I start to think that we cannot implement ais
> in QEMU and cover all cases.
> One aspect was certainly passthrough (like you handled in patch 4).
> Another aspect is that some interrupts might be injected from the kernel - even for
> emulated devices. e.g. virtio-pci together with vhost-net, will inject interrupts via
> the set_irq callback. I think disabling irqfd for these cases is not a good idea.

Is there still a fallback for irqfd emulation?

> 
> So what about adding a new KVM capability (for 4.14), fixup the other things in
> QEMU and then bind it to the new capability?

For 4.15, surely?

Probably the only way we can make this work correctly...
