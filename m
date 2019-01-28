Received: from eggs.gnu.org ([209.51.188.92]:36151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go5JR-00089P-7V
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:42:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1go5JN-000448-D1
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 06:42:49 -0500
Date: Mon, 28 Jan 2019 12:42:20 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190128124220.4ab5054f.cohuck@redhat.com>
In-Reply-To: <20190122125133.1191-1-david@redhat.com>
References: <20190122125133.1191-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 0/2] s390x/pci: PCI bridge plugging fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Collin Walling <walling@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Henderson <rth@twiddle.net>

On Tue, 22 Jan 2019 13:51:31 +0100
David Hildenbrand <david@redhat.com> wrote:

> Hotplugging of PCI bridges is right now pretty much broken. Coldplugging
> and hotplugging will assign wrong primary bus numbers in some scenarios.
> 
> I base my knowledge on how this is supposed to work on
> http://www.science.unitn.it/~fiorella/guidelinux/tlk/node76.html
> 
> I did a couple of tests, building whole hierarchies of bridges, both
> hot and coldplugged. "info pci" as well as the Linux guests showed
> what I was expecting.
> 
> David Hildenbrand (2):
>   s390x/pci: Fix primary bus number for PCI bridges
>   s390x/pci: Fix hotplugging of PCI bridges
> 
>  hw/s390x/s390-pci-bus.c | 41 +++++++++++++++++++++++++++--------------
>  1 file changed, 27 insertions(+), 14 deletions(-)
> 

So, if I understand the discussion correctly:
- Patch 1 is fine, just needs a description tweak.
- Patch 2 fixes a crash, and certainly makes things better. However,
  current handling seems to be at least a bit odd, if not broken;
  something to be looked into later.

I'd like to queue these, can I get an ack/feedback from IBM?
