Received: from eggs.gnu.org ([209.51.188.92]:46052)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h25IG-0006eZ-AP
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:31:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h25IF-0007kc-CF
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:31:28 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:2486 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h25IE-0007cw-Uc
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 21:31:27 -0500
Received: from dggeml406-hub.china.huawei.com (unknown [172.30.72.53])
	by Forcepoint Email with ESMTP id 3BEFE75D6143515E8C07
	for <qemu-devel@nongnu.org>; Fri,  8 Mar 2019 10:31:21 +0800 (CST)
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Fri, 8 Mar 2019 02:31:12 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA394CD10@dggeml529-mbx.china.huawei.com>
References: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
	<20190306100646.GI22159@stefanha-x1.localdomain>
In-Reply-To: <20190306100646.GI22159@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Question about VM inner route entry's lost when
 vhost-user reconnect
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, wangyunjian <wangyunjian@huawei.com>

Hi, Stefan

This problem is related with backend vhost-user socket abnormal cases, we s=
houldn't ask customers to configure it manually for backend's issues or dep=
ends on guest OS's network configuration.

Thanks

> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Wednesday, March 06, 2019 6:07 PM
> To: Lilijun (Jerry, Cloud Networking) <jerry.lilijun@huawei.com>
> Cc: qemu-devel@nongnu.org; wangxin (U)
> <wangxinxin.wang@huawei.com>; wangyunjian
> <wangyunjian@huawei.com>
> Subject: Re: [Qemu-devel] Question about VM inner route entry's lost when
> vhost-user reconnect
>=20
> On Mon, Mar 04, 2019 at 08:26:23AM +0000, Lilijun (Jerry, Cloud Networkin=
g)
> wrote:
> >       I am running my VM using vhost-user NIC with OVS-DPDK.  The steps=
 of
> my question is shown as follows:
> >      1) In the VM, I add one route entry manually on the vNIC eth0 usin=
g the
> linux tool route.
> >      2) When restarting openvswitch service for the crash of the ovs-vs=
witchd,
> qemu's vhost-user reconnected successfully after 40s.
> >      3) Here VM's vNIC will receive link down and up events, the interv=
al
> between the two events is about 40s.
> >      3) But that route entry disappeared and that will cause user's net=
work
> traffic interruption and the service failed.
> >
> >      Is there some work on this problem?  Can we keep the vNIC's link u=
p
> status when do vhost-user's reconnecting work?
>=20
> Can you add the custom route to the network management tool inside the
> guest so that it will be reinstated when the link comes back up?
>=20
> The details of how to do this depend on the guest's distro.
>=20
> Stefan
