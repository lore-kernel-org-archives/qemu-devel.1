Received: from eggs.gnu.org ([2001:4830:134:3::10]:52091)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEGl-00062s-Ny
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:35:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEGi-0006Zu-Jm
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:35:51 -0400
Received: from [59.151.112.132] (port=1289 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maozy.fnst@cn.fujitsu.com>) id 1dKEGh-0006Z4-CT
	for qemu-devel@nongnu.org; Sun, 11 Jun 2017 21:35:48 -0400
References: <cover.1496994386.git.maozy.fnst@cn.fujitsu.com>
	<23d76336ccef24473bf20f83628818eb3d97dac4.1496994386.git.maozy.fnst@cn.fujitsu.com>
	<20170609135353.GQ5016@thinpad.lan.raisama.net>
From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-ID: <e19cc067-95d8-fa52-1c99-bb9839aa2e23@cn.fujitsu.com>
Date: Mon, 12 Jun 2017 09:34:14 +0800
MIME-Version: 1.0
In-Reply-To: <20170609135353.GQ5016@thinpad.lan.raisama.net>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, mst@redhat.com, dmitry@daynix.com, jasowang@redhat.com, marcel@redhat.com, alex.williamson@redhat.com, armbru@redhat.com

Hi, Eduardo

On 06/09/2017 09:53 PM, Eduardo Habkost wrote:
> On Fri, Jun 09, 2017 at 07:24:40PM +0800, Mao Zhongyi wrote:
>> After the patch 'Make errp the last parameter of pci_add_capability()',
>> pci_add_capability() and pci_add_capability2() now do exactly the same.
>> So drop the wrapper pci_add_capability() of pci_add_capability2(), then
>> replace the pci_add_capability() with pci_add_capability2() everywhere.
>
> I would do the opposite, and keep pci_add_capability() only.
> It's confusing to have a function named pci_add_capability2() if
> pci_add_capability() doesn't exist anymore.
>

Yes, I see, will fix it right away.

Thanks
Mao
