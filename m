Received: from eggs.gnu.org ([2001:4830:134:3::10]:41241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJKMX-0007JO-EX
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dJKMT-0006qd-Js
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:54:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dJKMT-0006pw-E4
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 09:54:01 -0400
Date: Fri, 9 Jun 2017 10:53:53 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170609135353.GQ5016@thinpad.lan.raisama.net>
References: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
	<23d76336ccef24473bf20f83628818eb3d97dac4.1496994386.git.maozy.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23d76336ccef24473bf20f83628818eb3d97dac4.1496994386.git.maozy.fnst@cn.fujitsu.com>
Subject: Re: [Qemu-devel] [PATCH v4 5/7] pci: Replace pci_add_capability()
 with pci_add_capability2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

On Fri, Jun 09, 2017 at 07:24:40PM +0800, Mao Zhongyi wrote:
> After the patch 'Make errp the last parameter of pci_add_capability()',
> pci_add_capability() and pci_add_capability2() now do exactly the same.
> So drop the wrapper pci_add_capability() of pci_add_capability2(), then
> replace the pci_add_capability() with pci_add_capability2() everywhere.

I would do the opposite, and keep pci_add_capability() only.
It's confusing to have a function named pci_add_capability2() if
pci_add_capability() doesn't exist anymore.

-- 
Eduardo
