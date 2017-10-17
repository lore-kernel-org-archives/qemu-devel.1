Received: from eggs.gnu.org ([2001:4830:134:3::10]:54078)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1e4GlC-0002jG-24
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 21:33:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1e4Gl8-0000Sn-4f
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 21:33:34 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <gengdongjiu@huawei.com>) id 1e4Gl7-0000Rw-Hu
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 21:33:30 -0400
References: <8ba7e693-4e32-7873-70bf-4efbf57f9cf5@huawei.com>
	<20170928011407-mutt-send-email-mst@kernel.org>
	<405bbc99-1a43-aa8b-37e9-9599480f4c06@huawei.com>
	<20171001063010-mutt-send-email-mst@kernel.org>
	<49d576f3-454f-05f4-7afd-9ca8b5fb0706@huawei.com>
	<20171016113324.14e549c9@nial.brq.redhat.com>
	<0184EA26B2509940AA629AE1405DD7F2016994E5@DGGEMA503-MBX.china.huawei.com>
	<59E4E57D.4040304@arm.com>
From: gengdongjiu <gengdongjiu@huawei.com>
Message-ID: <496857a4-9333-02d1-1b31-b71b9332872e@huawei.com>
Date: Tue, 17 Oct 2017 09:31:55 +0800
MIME-Version: 1.0
In-Reply-To: <59E4E57D.4040304@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] using which notification for guest about GHES error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: James Morse <james.morse@arm.com>
Cc: Igor Mammedov <imammedo@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Wuquanming <wuquanming@huawei.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Huangshaoyu <huangshaoyu@huawei.com>, Andrew Jones <drjones@redhat.com>

Hi James,

On 2017/10/17 0:59, James Morse wrote:
>>> Do we really care about old guests in this case?
> I think the scenario here is the host kernel has some RAS support, Qemu has RAS
> support and has advertised its CPER regions via the HEST, but the guest doesn't
> doesn't support RAS. (booted via DT, wasn't configured for APEI, the kernel
> pre-dates the support etc).
> 
> What should Qemu do in response to 'action optional' memory errors?
> 
> My suggestion is whatever action Qemu takes, it shouldn't kill a guest that
> doesn't support RAS. Using NOTIFY_SEI for an action-optional memory error will
> do this. A guest that doesn't know about NOTIFY_SEI will take this as a fatal
> SError.

In short, if for this purpose, I think NOTIFY_GPIO meets the requirement, which will not kill a guest which does not
support RAS, and keep the ACPI the spec, so I suggestion using NOTIFY_GPIO to 'action
optional' memory errors

> 
> 
