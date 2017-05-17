Received: from eggs.gnu.org ([2001:4830:134:3::10]:59280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAudk-0001o7-B1
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAudg-0006Oy-Oj
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:04 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:3869)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <arei.gonglei@huawei.com>) id 1dAudf-0006NL-RY
	for qemu-devel@nongnu.org; Wed, 17 May 2017 04:49:00 -0400
From: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Date: Wed, 17 May 2017 08:48:33 +0000
Message-ID: <33183CC9F5247A488A2544077AF19020DA29B1CF@DGGEMA505-MBS.china.huawei.com>
References: <1494243504-127980-1-git-send-email-arei.gonglei@huawei.com>
	<1494243504-127980-6-git-send-email-arei.gonglei@huawei.com>
	<20170516154317.GS8498@stefanha-x1.localdomain>
In-Reply-To: <20170516154317.GS8498@stefanha-x1.localdomain>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [RFC v1 5/9] virtio-crypto: update header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, Luonengjun <luonengjun@huawei.com>, "cornelia.huck@de.ibm.com" <cornelia.huck@de.ibm.com>, Linqiangmin <linqiangmin@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "Wubin (H)" <wu.wubin@huawei.com>

>
> -----Original Message-----
> From: Stefan Hajnoczi [mailto:stefanha@redhat.com]
> Sent: Tuesday, May 16, 2017 11:43 PM
> To: Gonglei (Arei)
> Cc: qemu-devel@nongnu.org; mst@redhat.com; Huangweidong (C);
> pasic@linux.vnet.ibm.com; Luonengjun; cornelia.huck@de.ibm.com;
> Linqiangmin; xin.zeng@intel.com; Wubin (H)
> Subject: Re: [RFC v1 5/9] virtio-crypto: update header file
>=20
> On Mon, May 08, 2017 at 07:38:20PM +0800, Gonglei wrote:
> > @@ -166,8 +175,8 @@ struct virtio_crypto_aead_session_para {
> >  	uint32_t algo;
> >  	/* length of key */
> >  	uint32_t key_len;
> > -	/* hash result length */
> > -	uint32_t hash_result_len;
> > +	/* Authentication tag length */
> > +	uint32_t tag_len;
>=20
> Why is this field being renamed?

Oh, I just think the latter name ' tag_len' is more proper than 'hash_resul=
t_len',
and the current code don't touch this field.

Thanks,
-Gonglei
