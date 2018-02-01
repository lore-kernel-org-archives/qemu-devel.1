Received: from eggs.gnu.org ([2001:4830:134:3::10]:47668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehFmA-0000eG-9D
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ehFm6-0004uJ-Ac
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 09:23:42 -0500
Date: Thu, 1 Feb 2018 15:23:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180201152319.720c0391.cohuck@redhat.com>
In-Reply-To: <7cefb712-9af5-7a01-3a94-0bd02a2563d1@linux.vnet.ibm.com>
References: <20180131181742.2037-1-cohuck@redhat.com>
	<20180131181742.2037-2-cohuck@redhat.com>
	<7cefb712-9af5-7a01-3a94-0bd02a2563d1@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 1/2] s390x/tcg: wire up pci instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Pierre Morel <pmorel@linux.vnet.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, david@redhat.com, agraf@suse.de, rth@twiddle.net

On Thu, 1 Feb 2018 11:00:09 +0100
Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:

> On 31/01/2018 19:17, Cornelia Huck wrote:
> > On s390x, pci support is implemented via a set of instructions
> > (no mmio). Unfortunately, none of them are documented in the
> > PoP; the code is based upon the existing implementation for KVM
> > and the Linux zpci driver.
> >
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >   target/s390x/helper.h      |   9 ++++
> >   target/s390x/insn-data.def |  15 +++++++
> >   target/s390x/misc_helper.c | 109 +++++++++++++++++++++++++++++++++++++++++++++
> >   target/s390x/translate.c   | 101 +++++++++++++++++++++++++++++++++++++++++
> >   4 files changed, 234 insertions(+)

> Hi,
> 
> I am not an expert for TCG but the patches are looking clean to me.
> 
> And since I also rapidly tested with multibus, virtio_pci_block, and all 
> went good so:
> 
> Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>

Thanks!

Out of curiousity, do you have some scripts or instructions for testing
you can share?
