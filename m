Received: from eggs.gnu.org ([2001:4830:134:3::10]:56408)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cordius.wu@huawei.com>) id 1f7yaT-0006AC-SX
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:30:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cordius.wu@huawei.com>) id 1f7yaP-0006Fr-5a
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:30:05 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2267 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cordius.wu@huawei.com>)
	id 1f7yaO-00069w-Pi
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 03:30:01 -0400
From: "Wuzongyong (Euler Dept)" <cordius.wu@huawei.com>
Date: Mon, 16 Apr 2018 07:28:47 +0000
Message-ID: <9BD73EA91F8E404F851CF3F519B14AA801719EA3@dggemi501-mbs.china.huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA801719260@dggemi501-mbs.china.huawei.com>
	<20180413153857.75556707@redhat.com>
In-Reply-To: <20180413153857.75556707@redhat.com>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Hot add vcpu not working in Windows server 2012r2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, huangfeiqing <huangfeiqing@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> On Fri, 13 Apr 2018 03:14:44 +0000
> "Wuzongyong (Euler Dept)" <cordius.wu@huawei.com> wrote:
>=20
> > Hi,
> >
> > I try to hot add vcpus to a windows server 2012r2 virtual machine on
> RHEL 7.4 platform.
> > But Task Manager didn't show extra processors I hot added though they
> > appeared in Device Manager. Actually, I need to require reboot the vm
> > to make processors hot Added appear in Task Manager.
> > Is there some problem with redhat qemu? Why the processors I hot-added
> > didn't online automatically?
> > I don't know if I ask the right person or in a right mail list,
> apologize first if I bother you.
> It might depend on particular edition of windows server you are running.
> I usually test it with 'data server' edition where it supposed to work.
> Could you check if that works?
Win2012 datacenter build 9200 don't help.
I try to install a high version qemu from a centos repo, and it can hot-add
vcpus normally. I guess the release of qemu in rhel 7.5 is too low.

Thanks,
Wu Zongyong
