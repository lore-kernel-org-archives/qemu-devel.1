Received: from eggs.gnu.org ([2001:4830:134:3::10]:42707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMwJV-0004oI-WB
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:34:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eMwJR-0005v4-9S
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:34:10 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51945)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eMwJR-0005uD-2n
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 08:34:05 -0500
Date: Thu, 7 Dec 2017 15:33:54 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171207152806-mutt-send-email-mst@kernel.org>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Avi Cohen (A)" <avi.cohen@huawei.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Thu, Dec 07, 2017 at 07:54:48AM +0000, Avi Cohen (A) wrote:
> There is already a  virtio mechanism in which 2 VMs assigned a virtio device , are communicating via a veth pair  in the host .
> KVM just passes  a pointer of the page of the writer VM to the reader VM - resulting  in  excellent performance (no vSwitch in the middle)

What exactly do you refer to?

> **Question**:  What is the advantage of vhost-pci compared to this ?
> Best Regards
> Avi

I suspect what's missing in this thread is the original motivation rfc:
http://virtualization.linux-foundation.narkive.com/A7FkzAgp/rfc-vhost-user-enhancements-for-vm2vm-communication
