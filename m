Received: from eggs.gnu.org ([2001:4830:134:3::10]:57100)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6yuv-00024d-1i
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:39:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6yuq-0001ra-Bj
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:39:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60384 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1f6yuq-0001rL-6N
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 09:39:00 -0400
Date: Fri, 13 Apr 2018 15:38:57 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180413153857.75556707@redhat.com>
In-Reply-To: <9BD73EA91F8E404F851CF3F519B14AA801719260@dggemi501-mbs.china.huawei.com>
References: <9BD73EA91F8E404F851CF3F519B14AA801719260@dggemi501-mbs.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Hot add vcpu not working in Windows server 2012r2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Wuzongyong (Euler Dept)" <cordius.wu@huawei.com>
Cc: "Wanzongshun (Vincent)" <wanzongshun@huawei.com>, huangfeiqing <huangfeiqing@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

On Fri, 13 Apr 2018 03:14:44 +0000
"Wuzongyong (Euler Dept)" <cordius.wu@huawei.com> wrote:

> Hi,
> 
> I try to hot add vcpus to a windows server 2012r2 virtual machine on RHEL 7.4 platform.
> But Task Manager didn't show extra processors I hot added though they appeared in
> Device Manager. Actually, I need to require reboot the vm to make processors hot
> Added appear in Task Manager.
> Is there some problem with redhat qemu? Why the processors I hot-added didn't online
> automatically?
> I don't know if I ask the right person or in a right mail list, apologize first if I bother you.
It might depend on particular edition of windows server you are running.
I usually test it with 'data server' edition where it supposed to work.
Could you check if that works?

> 
> Thanks,
> Zongyong Wu
> 
