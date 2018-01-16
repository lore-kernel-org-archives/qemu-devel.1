Received: from eggs.gnu.org ([2001:4830:134:3::10]:49700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebQar-0007sF-WC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:43:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ebQan-00009F-Vy
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:43:58 -0500
Received: from szxga03-in.huawei.com ([45.249.212.189]:2247 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ebQan-00005d-Ic
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 07:43:53 -0500
From: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Date: Tue, 16 Jan 2018 12:43:42 +0000
Message-ID: <B2D15215269B544CADD246097EACE7473AB4651A@DGGEMM505-MBS.china.huawei.com>
References: <1514623933-25568-1-git-send-email-jianjay.zhou@huawei.com>
	<1514623933-25568-4-git-send-email-jianjay.zhou@huawei.com>
	<20180116062059-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180116062059-mutt-send-email-mst@kernel.org>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v2 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>

> -----Original Message-----
> From: Michael S. Tsirkin [mailto:mst@redhat.com]
> Sent: Tuesday, January 16, 2018 12:24 PM
> To: Zhoujian (jay) <jianjay.zhou@huawei.com>
> Cc: qemu-devel@nongnu.org; pbonzini@redhat.com; Huangweidong (C)
> <weidong.huang@huawei.com>; stefanha@redhat.com; pasic@linux.vnet.ibm.com=
;
> longpeng <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.=
com;
> Gonglei (Arei) <arei.gonglei@huawei.com>
> Subject: Re: [PATCH v2 3/4] cryptodev-vhost-user: add crypto session hand=
ler
>=20
> On Sat, Dec 30, 2017 at 04:52:12PM +0800, Jay Zhou wrote:
> > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > index 954771d..f43c63d 100644
> > --- a/docs/interop/vhost-user.txt
> > +++ b/docs/interop/vhost-user.txt
> > @@ -596,6 +596,25 @@ Master message types
> >        and expect this message once (per VQ) during device configuratio=
n
> >        (ie. before the master starts the VQ).
> >
> > + * VHOST_USER_CREATE_CRYPTO_SESSION
> > +
> > +      Id: 23
> > +      Equivalent ioctl: N/A
> > +      Master payload: crypto session description
> > +      Slave payload: crypto session description
> > +
> > +      Create a session for crypto operation. The server side must retu=
rn
> the
> > +      session id, 0 or positive for success, negative for failure.
> > +
> > + * VHOST_USER_CLOSE_CRYPTO_SESSION
> > +
> > +      Id: 24
> > +      Equivalent ioctl: N/A
> > +      Master payload: u64
> > +
> > +      Close a session for crypto operation which was previously
> > +      created by VHOST_USER_CREATE_CRYPTO_SESSION.
> > +
> >  Slave message types
> >  -------------------
> >
>=20
>=20
> Sorry about a delayed response.
> So an issue with this patchset is that you are adding new messages
> unconditionally.
>=20
> You must add a protocol bit whenever you add new messages.
> If appropriate, you can document that it's a required feature for crypto
> devices.

OK, will do.

Regards,
Jay

>=20
>=20
> --
> MST
