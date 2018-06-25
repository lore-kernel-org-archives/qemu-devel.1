Received: from eggs.gnu.org ([2001:4830:134:3::10]:42565)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fXRZf-0006BB-OC
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:30:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1fXRZc-0002ZD-Df
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:30:31 -0400
Received: from [45.249.212.255] (port=35980 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1fXRZb-0002XG-UR
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 09:30:28 -0400
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 25 Jun 2018 13:30:10 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302C971CE@dggemm509-mbx.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] Some issues of hotpluging memory and cpus
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU <qemu-devel@nongnu.org>
Cc: "imammedo@redhat.com" <imammedo@redhat.com>, "mst@redhat.com" <mst@redhat.com>, "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, lidonglin <lidonglin@huawei.com>, "Gonglei
	(Arei)" <arei.gonglei@huawei.com>, "robert.moore@intel.com" <robert.moore@intel.com>, "lersek@redhat.com" <lersek@redhat.com>

Hi, all,
I had some problems when doing memory hot plugging. After a lot of tests, I=
 was able to stably reproduce the following issues with Windows 2012 R2:

1. If I hot-plug the memory immediately after hot-plugging the CPUs, these =
memory devices will not be detected by windows OS because I cannot see them=
 in the device manager.
2. If I add a certain delay (for example, 2s or more) between the hot-plugg=
ing memory and the CPU, the memory devices will be detected but some of the=
m may not be online.
And Memory Module Properties displaying the following contents:

This device cannot start. (Code 10)
{Conflicting Address Range}
The specified address range conflicts with the address space.

3. usb tablet mouse would not work probability after hot adding memory.

Due to the closed nature of windows OS, I can't know what's going on inside=
.
Is it related to acpi tables exposure?
I hope you can give me some advice, thank you.
