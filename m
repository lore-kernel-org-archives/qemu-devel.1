Received: from eggs.gnu.org ([2001:4830:134:3::10]:45381)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eExb3-0001Vc-QL
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:19:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eExau-0001VS-7v
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:19:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55552)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eExau-0001Ua-1i
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 08:19:08 -0500
References: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d344052d-ac24-2ce0-38bc-b8008c895946@redhat.com>
Date: Wed, 15 Nov 2017 14:18:55 +0100
MIME-Version: 1.0
In-Reply-To: <8E78D212B8C25246BE4CE7EA0E645FE501B557EA@dggeml511-mbs.china.huawei.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] Qemu's Heap Becomes Very Large and
 Never Reduce Down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Xulei (Stone)" <stone.xulei@huawei.com>, qemu-devel <qemu-devel@nongnu.org>, "yang.zhong" <yang.zhong@intel.com>, "anthony.xu" <anthony.xu@intel.com>, stefanha <stefanha@redhat.com>, berrange <berrange@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "liujunjie (A)" <liujunjie23@huawei.com>

On 15/11/2017 04:14, Xulei (Stone) wrote:
> Hi, guys
>=20
> I met a strange problem, with qemu 2.8.1:
> qemu consumes too many heap memory after several operations and can not
> release them anymore:=A0
> hot pulg/unplug disk & net, vnc connect/disconnect,=A0guestOS reboot, e=
tc.

Try with newer QEMU; until recently we used a lot of memory at startup,
but it was improved in 2.11.

However, I think Anthony also had a patch adding a malloc_trim call in
the RCU thread, which improved memory usage.  Anthony, do you know if
this is still necessary in 2.11?

Thanks,

Paolo
