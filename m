Received: from eggs.gnu.org ([2001:4830:134:3::10]:53768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eMraw-0005cu-Fe
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:31:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eMrar-0007Xy-0n
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:31:48 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49394)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eMraq-0007VV-PE
	for qemu-devel@nongnu.org; Thu, 07 Dec 2017 03:31:44 -0500
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<20171206134957.GD12584@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937B57F@shsmsx102.ccr.corp.intel.com>
	<CAJSP0QWugAKQy6hYEJfy_XHEg-Q2swAzZMNcWBqn-r9Yi7yiEg@mail.gmail.com>
	<5A28BC2D.6000308@intel.com>
	<CAJSP0QUxRv9LNb1+McYxV0KY4Ss3NkaSjwO6fXiJd+oU2+zJSQ@mail.gmail.com>
	<B84047ECBD981D4B93EAE5A6245AA3610159323B@FRAEML521-MBX.china.huawei.com>
	<CAJSP0QVSOsPXYTyjCsBbUmzivjtYbC7xKpU2m7dQbAPMhrcLnA@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <ed3c3bb2-acc9-b44e-2a5b-7f4f22c2230a@redhat.com>
Date: Thu, 7 Dec 2017 16:31:27 +0800
MIME-Version: 1.0
In-Reply-To: <CAJSP0QVSOsPXYTyjCsBbUmzivjtYbC7xKpU2m7dQbAPMhrcLnA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Stefan Hajnoczi <stefanha@gmail.com>, "Avi Cohen (A)" <avi.cohen@huawei.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "mst@redhat.com" <mst@redhat.com>, "Yang,
	Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>



On 2017=E5=B9=B412=E6=9C=8807=E6=97=A5 16:04, Stefan Hajnoczi wrote:
> On Thu, Dec 7, 2017 at 7:54 AM, Avi Cohen (A) <avi.cohen@huawei.com> wr=
ote:
>> There is already a  virtio mechanism in which 2 VMs assigned a virtio =
device , are communicating via a veth pair  in the host .
>> KVM just passes  a pointer of the page of the writer VM to the reader =
VM - resulting  in  excellent performance (no vSwitch in the middle)
>> **Question**:  What is the advantage of vhost-pci compared to this ?
> Which mechanism do you mean?
>
> vhost-pci will allow VM-to-VM communication without vmexits when
> polling mode is used.  Does the mechanism you are thinking about
> require vmexits?
>
> Stefan

I guess what Avi means is probably veth tap support (RFC) here:

https://www.spinics.net/lists/netdev/msg454040.html

But in fact, we don't need veth at all, by using rx handler trick, we=20
can easily implement pair mode on TUN/TAP.

Thanks
