Received: from eggs.gnu.org ([2001:4830:134:3::10]:39512)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gPfbx-0002fw-QU
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:25:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gPfbo-0005gf-Fc
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:24:57 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:47777 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1gPfbi-0005Fn-AH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 22:24:48 -0500
References: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
	<20181120152325.ekxhvjndzgflijvb@sirius.home.kraxel.org>
	<B328F08581D714418202ABF306D3781C3B776FA6@dggeml509-mbx.china.huawei.com>
	<20181121082307.3fa3nd7cuu3canx4@sirius.home.kraxel.org>
	<994425cd-c99e-f69f-9fac-fbd7d2edf470@huawei.com>
	<20181121102215.ctlw6yy45dzic3cq@sirius.home.kraxel.org>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <de74bad2-2ec6-5fe9-1898-5ea708298a97@huawei.com>
Date: Thu, 22 Nov 2018 11:24:25 +0800
MIME-Version: 1.0
In-Reply-To: <20181121102215.ctlw6yy45dzic3cq@sirius.home.kraxel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel]
 =?utf-8?b?562U5aSNOiAgQ2FuJ3Qgc2VlIG1vdXNlIGN1cnNv?=
 =?utf-8?q?r_on_VNC_viewer?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, wanghaibin 00208455 <wanghaibin.wang@huawei.com>

After adding a configuration file under /etc/X11/xorg.conf.d with below lines, we can finally see remote mouse cursor on the VNC viewer.

Section "Device"
         Option      "SWcursor" "True"
         Identifier  "Card0"
         Driver      "modesetting"
         BusID       "PCI:10:3:0"
EndSection

Really appreciate it :)

Heyi


On 2018/11/21 18:22, Gerd Hoffmann wrote:
> On Wed, Nov 21, 2018 at 04:54:15PM +0800, Heyi Guo wrote:
>> Hi Gerd,
>>
>> Is there any hacking way to turn off hardware cursor support for virtio-gpu, and make the cursor also be rendered to the framebuffer?
> Well, you can configure xorg in the guest to force software cursor mode.
>
> cheers,
>    Gerd
>
>
>
