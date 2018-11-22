Received: from eggs.gnu.org ([2001:4830:134:3::10]:42952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gPkyM-0006Br-9m
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:08:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guoheyi@huawei.com>) id 1gPkyH-00043k-AS
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:08:30 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:2575 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <guoheyi@huawei.com>) id 1gPkyG-0003yh-Ud
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 04:08:25 -0500
References: <B328F08581D714418202ABF306D3781C3B774417@dggeml509-mbx.china.huawei.com>
	<20181120152325.ekxhvjndzgflijvb@sirius.home.kraxel.org>
	<B328F08581D714418202ABF306D3781C3B776FA6@dggeml509-mbx.china.huawei.com>
	<20181121082307.3fa3nd7cuu3canx4@sirius.home.kraxel.org>
From: Heyi Guo <guoheyi@huawei.com>
Message-ID: <95db2c67-d3bd-1ab3-2f12-2adf218a3038@huawei.com>
Date: Thu, 22 Nov 2018 17:08:16 +0800
MIME-Version: 1.0
In-Reply-To: <20181121082307.3fa3nd7cuu3canx4@sirius.home.kraxel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

Hi Gerd,

One more question: do you know any VNC client which supports rich cursor =
extension? We'd like to try such client to see the real effect.

Thanks,

Heyi


On 2018/11/21 16:23, Gerd Hoffmann wrote:
>    Hi,
>
>> and can=E2=80=99t see cursor either with =E2=80=9Cvirtio-gpu=E2=80=9D.=
 Does that mean
>> virtio-gpu + VNC must rely on VNC client to draw the cursor image on
>> the screen?
> Yes.  virtio-gpu sends the cursor to the vnc client (via rich cursor
> extension) and expects the vnc client to show it.  So, if you ask your
> vnc client to not show the rich cursor the cursor is gone.  Solution:
> don't do that.
>
> stdvga has no hardware cursor support, so it is rendered to the
> framebuffer (by the guest).
>
> cirrus hardware cursor can't be mapped to rich cursor,
> so it is rendered to the framebuffer too (by qemu this time).
>
> cheers,
>    Gerd
>
>
>
