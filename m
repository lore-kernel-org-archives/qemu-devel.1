Received: from eggs.gnu.org ([2001:4830:134:3::10]:59349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRAm8-0005wv-50
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:53:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <linzhecheng@huawei.com>) id 1gRAm5-0001sd-0v
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:53:44 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:2413 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <linzhecheng@huawei.com>)
	id 1gRAm3-0001iO-3U
	for qemu-devel@nongnu.org; Mon, 26 Nov 2018 01:53:40 -0500
From: linzhecheng <linzhecheng@huawei.com>
Date: Mon, 26 Nov 2018 06:53:23 +0000
Message-ID: <D9DE8DBB19F2A24080482022C1DE758302D336B2@DGGEMM529-MBX.china.huawei.com>
References: <D9DE8DBB19F2A24080482022C1DE758302D325DC@DGGEMM529-MBX.china.huawei.com>
	<20181126064611.zgsxden3jemuglaj@sirius.home.kraxel.org>
In-Reply-To: <20181126064611.zgsxden3jemuglaj@sirius.home.kraxel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [question] live migration about redir-usb
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>



> -----Original Message-----
> From: Gerd Hoffmann [mailto:kraxel@redhat.com]
> Sent: Monday, November 26, 2018 2:46 PM
> To: linzhecheng <linzhecheng@huawei.com>
> Cc: qemu-devel@nongnu.org; wangxin (U) <wangxinxin.wang@huawei.com>;
> Zhoujian (jay) <jianjay.zhou@huawei.com>
> Subject: Re: [Qemu-devel] [question] live migration about redir-usb
>=20
> On Mon, Nov 26, 2018 at 02:29:12AM +0000, linzhecheng wrote:
> > Hi, Gerd
> > I have read this discussion thread about live migration in tcp mode.
> > https://bugzilla.redhat.com/show_bug.cgi?id=3D1254971
> > Only spice redirection supports live migration not, but why not tcp mod=
e?
> > Does usbredirserver not support it or qemu?
>=20
> usbredirserver.
>=20
> spice client holds a connection to both source and target host for a seam=
less
> connection handover, and usb-redir needs that too to hand over the usb de=
vice
> without interruption.
>=20
> usbredirserver can't do that.
So if we realize the handover between src and dst chardev of qemu, we can d=
o live migration in tcp mode.
Is it similar with openvswtich who both accept the connection of src and ds=
t qemu?
>=20
> cheers,
>   Gerd
