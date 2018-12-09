Received: from eggs.gnu.org ([2001:4830:134:3::10]:54321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gW02W-00071G-3Y
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 09:26:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gW02R-0004Co-Bl
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 09:26:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57826)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gW02R-0004CH-4i
	for qemu-devel@nongnu.org; Sun, 09 Dec 2018 09:26:31 -0500
Date: Sun, 9 Dec 2018 09:26:24 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181209092558-mutt-send-email-mst@kernel.org>
References: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7CECC2DFC21538489F72729DF5EFB4D908ABD3A4@dggemm521-mbs.china.huawei.com>
Subject: Re: [Qemu-devel] [BUG]Unassigned mem write during pci device
 hot-plug
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: xuyandong <xuyandong2@huawei.com>
Cc: "marcel@redhat.com" <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>

On Sat, Dec 08, 2018 at 11:58:59AM +0000, xuyandong wrote:
> Hi all,
> 
>  
> 
> In our test, we configured VM with several pci-bridges and a virtio-net nic
> been attached with bus 4,
> 
> After VM is startup, We ping this nic from host to judge if it is working
> normally. Then, we hot add pci devices to this VM with bus 0.
> 
> We  found the virtio-net NIC in bus 4 is not working (can not connect)
> occasionally, as it kick virtio backend failure with error below:
> 
>     Unassigned mem write 00000000fc803004 = 0x1

Thanks for the report. Which guest was used to produce this problem?

-- 
MST
