Received: from eggs.gnu.org ([2001:4830:134:3::10]:39822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRS9C-0002Wi-Hq
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:26:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRS98-0004r8-K1
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:26:42 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2415 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gRS97-0004q9-VS
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 20:26:38 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Tue, 27 Nov 2018 01:26:24 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D358E6@DGGEMM529-MBX.china.huawei.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel]  [BUG] qemu stuck when detach host-usb device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>

Description of problem:
The guest has a host-usb device(Kingston Technology DataTraveler 100 G3/G4/=
SE9 G2), which is attached
to xhci controller(on host). Qemu will stuck if I detach it from guest.

How reproducible:
100%

Steps to Reproduce:
1.            Use usb stick to copy files in guest , make it busy working.
2.            virsh detach-device vm_name usb.xml

Then qemu will stuck for 20s, I found this is because libusb_release_interf=
ace block for 20s.
Dmesg prints:

[35442.034861] usb 4-2.1: Disable of device-initiated U1 failed.
[35447.034993] usb 4-2.1: Disable of device-initiated U2 failed.
[35452.035131] usb 4-2.1: Set SEL for device-initiated U1 failed.
[35457.035259] usb 4-2.1: Set SEL for device-initiated U2 failed.

Is this a hardware error or software's bug?
