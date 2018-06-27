Received: from eggs.gnu.org ([2001:4830:134:3::10]:40695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB87-0000Tw-3x
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:09:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYB83-0001rQ-SJ
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:09:07 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54214 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYB83-0001q3-OP
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 10:09:03 -0400
Date: Wed, 27 Jun 2018 16:08:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180627160859.3733036d@redhat.com>
In-Reply-To: <D9DE8DBB19F2A24080482022C1DE758302C971CE@dggemm509-mbx.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302C971CE@dggemm509-mbx.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Some issues of hotpluging memory and cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linzhecheng <linzhecheng@huawei.com>
Cc: QEMU <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "robert.moore@intel.com" <robert.moore@intel.com>, lidonglin <lidonglin@huawei.com>, "Gonglei
	(Arei)" <arei.gonglei@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>, "lersek@redhat.com" <lersek@redhat.com>

On Mon, 25 Jun 2018 13:30:10 +0000
linzhecheng <linzhecheng@huawei.com> wrote:

> Hi, all,
> I had some problems when doing memory hot plugging. After a lot of tests, I was able to stably reproduce the following issues with Windows 2012 R2:
> 
> 1. If I hot-plug the memory immediately after hot-plugging the CPUs, these memory devices will not be detected by windows OS because I cannot see them in the device manager.
> 2. If I add a certain delay (for example, 2s or more) between the hot-plugging memory and the CPU, the memory devices will be detected but some of them may not be online.
> And Memory Module Properties displaying the following contents:
> 
> This device cannot start. (Code 10)
> {Conflicting Address Range}
> The specified address range conflicts with the address space.
it could help if you can find in device manger what it conflicts with


> 3. usb tablet mouse would not work probability after hot adding memory.
> 
> Due to the closed nature of windows OS, I can't know what's going on inside.
> Is it related to acpi tables exposure?
> I hope you can give me some advice, thank you.

you also can try running QEMU with cphp_* and mhp_* trace events enabled [*],
it should show ACPI interaction os Windows with QEMU including address assignment.


*) docs/devel/tracing.txt
