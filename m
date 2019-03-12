Received: from eggs.gnu.org ([209.51.188.92]:44321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h3WjL-0003fJ-Le
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jerry.lilijun@huawei.com>) id 1h3WjK-00005r-85
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:01:23 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:2425 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jerry.lilijun@huawei.com>)
	id 1h3WjJ-0008TC-PA
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 22:01:22 -0400
Received: from dggeml405-hub.china.huawei.com (unknown [172.30.72.53])
	by Forcepoint Email with ESMTP id 644DC188D3E702BE430B
	for <qemu-devel@nongnu.org>; Tue, 12 Mar 2019 10:01:13 +0800 (CST)
From: "Lilijun (Jerry, Cloud Networking)" <jerry.lilijun@huawei.com>
Date: Tue, 12 Mar 2019 02:01:04 +0000
Message-ID: <40280F65B1B0B44E8089ED31C01616EBA43F939C@dggeml529-mbx.china.huawei.com>
References: <40280F65B1B0B44E8089ED31C01616EBA3947B1A@dggeml529-mbx.china.huawei.com>
	<20190306100646.GI22159@stefanha-x1.localdomain>
	<40280F65B1B0B44E8089ED31C01616EBA394CD10@dggeml529-mbx.china.huawei.com>
	<20190311094639.GA5991@stefanha-x1.localdomain>
In-Reply-To: <20190311094639.GA5991@stefanha-x1.localdomain>
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



> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@gmail.com]
> Sent: Monday, March 11, 2019 5:47 PM
> To: Lilijun (Jerry, Cloud Networking) <jerry.lilijun@huawei.com>
> Cc: qemu-devel@nongnu.org; wangxin (U)
> <wangxinxin.wang@huawei.com>; wangyunjian
> <wangyunjian@huawei.com>
> Subject: Re: [Qemu-devel] Question about VM inner route entry's lost when
> vhost-user reconnect
>=20
> On Fri, Mar 08, 2019 at 02:31:12AM +0000, Lilijun (Jerry, Cloud Networkin=
g)
> wrote:
> > This problem is related with backend vhost-user socket abnormal cases, =
we
> shouldn't ask customers to configure it manually for backend's issues or
> depends on guest OS's network configuration.
>=20
> In Step 1 you said:
>=20
> > > >      1) In the VM, I add one route entry manually on the vNIC eth0
> > > > using the
> > > linux tool route.
>=20
> You configured the route manually inside the guest.  Seems like a guest
> problem to me.
>=20
> If this was a physical machine that lost connectivity due to a link event=
, what
> would happen?

Yes, the configuration can be recovered manually by customers.

But in the virtualization machines, this configuration's lost is a result o=
f backend process's software unexpected bugs or version update. So I think =
we need hide this change to customers.
>=20
> Stefan
