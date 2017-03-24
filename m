Received: from eggs.gnu.org ([2001:4830:134:3::10]:42444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRm-0004dy-9j
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1crXRl-0002vh-Ai
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40920)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1crXRl-0002vS-4i
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 18:12:37 -0400
Date: Fri, 24 Mar 2017 16:12:34 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170324161234.2ada63fb@t450s.home>
In-Reply-To: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1490260163-6157-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] vfio-pci: support recovery of AER
 non fatal error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cao jin <caoj.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, izumi.taku@jp.fujitsu.com, mst@redhat.com

On Thu, 23 Mar 2017 17:09:20 +0800
Cao jin <caoj.fnst@cn.fujitsu.com> wrote:

> v3 changelog:
> 1. Address all comments from MST in patch 3, include remove the flag
>    pci_aer_non_fatal & passive_reset, also the boilerplate code.
>    The corresponding kernel patch is v6.
> 
> Test:
> Test with func1 passthroughed while func0 doesn't have user.

So the slot_reset trigger really hasn't been tested at all?
 
> Cao jin (3):
>   pcie aer: verify if AER functionality is available
>   vfio pci: new function to init AER capability
>   vfio-pci: process non fatal error of AER
> 
>  hw/pci/pcie_aer.c          |  28 ++++++
>  hw/vfio/pci.c              | 243 ++++++++++++++++++++++++++++++++++++++++++++-
>  hw/vfio/pci.h              |   3 +
>  linux-headers/linux/vfio.h |   2 +
>  4 files changed, 271 insertions(+), 5 deletions(-)
> 
