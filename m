Received: from eggs.gnu.org ([2001:4830:134:3::10]:47371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnQRQ-0003gL-3h
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:55:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cnQRL-0000ux-RN
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:55:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48744)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cnQRL-0000sF-IT
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:55:11 -0400
Message-ID: <1489413307.13264.21.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 13 Mar 2017 14:55:07 +0100
In-Reply-To: <20170313131029.14044-1-hangaohuai@huawei.com>
References: <20170313131029.14044-1-hangaohuai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] fix :cirrus_vga fix OOB read case qemu
 Segmentation fault
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: hangaohuai <hangaohuai@huawei.com>
Cc: qemu-devel@nongnu.org, fangying1@huawei.com, arei.gonglei@huawei.com

> @@ -97,6 +97,11 @@ glue(glue(cirrus_bitblt_rop_fwd_transp_, ROP_NAME),_8)=
(CirrusVGAState *s,
>      uint8_t p;
>      dstpitch -=3D bltwidth;
>      srcpitch -=3D bltwidth;
> +
> +    if (dstpitch < 0 || srcpitch < 0) {
> +        return;
> +    }

Shouldn't that be ...

    if (bltheight > 1 && (dstpitch < 0 || srcpitch < 0)) {


... matching the check of the non-transparent version a few lines up in
the same source file?

cheers,
  Gerd
