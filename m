Received: from eggs.gnu.org ([209.51.188.92]:51609)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghc6g-0004F6-0d
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:18:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ghc6e-0008TB-VJ
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 10:18:53 -0500
Date: Thu, 10 Jan 2019 16:18:47 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190110161847.51912076.cohuck@redhat.com>
In-Reply-To: <20190108151114.33140-1-liq3ea@163.com>
References: <20190108151114.33140-1-liq3ea@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3] s390: avoid potential null dereference
 ins390_pcihost_unplug()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>
Cc: walling@linux.ibm.com, rth@twiddle.net, david@redhat.com, pasic@linux.ibm.com, borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org

On Tue,  8 Jan 2019 07:11:14 -0800
Li Qiang <liq3ea@163.com> wrote:

> When getting the 'pbdev', the if...else has no default branch.
> From Coverity, the 'pbdev' maybe null when the 'dev' is not
> the TYPE_PCI_BRIDGE/TYPE_PCI_DEVICE/TYPE_S390_PCI_DEVICE.
> This patch adds a default branch for device plug and unplug.
> 
> Spotted by Coverity: CID 1398593
> 
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
> 
> Change since v2: use g_assert_not_reached for default branch
> 
>  hw/s390x/s390-pci-bus.c | 4 ++++
>  1 file changed, 4 insertions(+)

Thanks, applied.
