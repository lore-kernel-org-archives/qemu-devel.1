Received: from eggs.gnu.org ([2001:4830:134:3::10]:49450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMrAM-0005s6-7Z
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:04:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1eMrAL-0002s6-3M
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:04:22 -0500
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:39527)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1eMrAK-0002rr-SN
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:04:21 -0500
Received: by mail-wm0-x22e.google.com with SMTP id i11so11202235wmf.4
	for <qemu-devel@nongnu.org>; Thu, 07 Dec 2017 00:04:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Dec 2017 08:04:18 +0000
Message-ID: <CAJSP0QVSOsPXYTyjCsBbUmzivjtYbC7xKpU2m7dQbAPMhrcLnA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Thu, Dec 7, 2017 at 7:54 AM, Avi Cohen (A) <avi.cohen@huawei.com> wrote:
> There is already a  virtio mechanism in which 2 VMs assigned a virtio device , are communicating via a veth pair  in the host .
> KVM just passes  a pointer of the page of the writer VM to the reader VM - resulting  in  excellent performance (no vSwitch in the middle)
> **Question**:  What is the advantage of vhost-pci compared to this ?

Which mechanism do you mean?

vhost-pci will allow VM-to-VM communication without vmexits when
polling mode is used.  Does the mechanism you are thinking about
require vmexits?

Stefan
