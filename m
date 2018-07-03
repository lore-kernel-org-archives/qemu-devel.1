Received: from eggs.gnu.org ([2001:4830:134:3::10]:33488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1faNKI-0000KP-Nx
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1faNKC-0002If-A3
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:46 -0400
Received: from mail-vi1eur04hn0221.outbound.protection.outlook.com
	([104.47.14.221]:56143
	helo=EUR04-VI1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1faNKB-0002Eq-BT
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:34:40 -0400
Date: Tue, 3 Jul 2018 18:34:22 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20180703153422.GD30904@rkaganb.sw.ru>
References: <20180629221907.3662-1-venu.busireddy@oracle.com>
	<20180702161404.GA2339@rkaganb.sw.ru>
	<449f1449-ddf6-cd95-976c-14d04d8d503a@oracle.com>
	<20180703095825.GC30904@rkaganb.sw.ru>
	<20180703142817.GA3088@vbusired-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180703142817.GA3088@vbusired-vm>
Subject: Re: [Qemu-devel] [PATCH v3 0/3] Use of unique identifier for
 pairing virtio and passthrough devices...
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Venu Busireddy <venu.busireddy@oracle.com>
Cc: si-wei liu <si-wei.liu@oracle.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org

On Tue, Jul 03, 2018 at 09:28:17AM -0500, Venu Busireddy wrote:
> On 2018-07-03 12:58:25 +0300, Roman Kagan wrote:
> > My point with these two questions is that since this patchset is
> > defining external interfaces -- with guest OS, with management layer --
> 
> This patch set is not defining any external interfaces. All this is doing
> is provide the means and locations to store the "group identifier". How
> that info will be used, I thought, should be another patch set.

Device properties are a part of the interface to the management layer.
PCI vendor capabilities are a part of the interface to the guest OS.

So yes, I think it makes sense to have at least a rough plan on how it's
going to be used.

Thanks,
Roman.
