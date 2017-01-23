Received: from eggs.gnu.org ([2001:4830:134:3::10]:33538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdFC-0006ys-Mq
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:57:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cVdF8-0006hM-F6
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:57:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37982)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cVdF8-0006gv-9O
	for qemu-devel@nongnu.org; Mon, 23 Jan 2017 06:57:02 -0500
Message-ID: <1485172618.2149.14.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 23 Jan 2017 12:56:58 +0100
In-Reply-To: <20170120094635.GA28338@olga.wb>
References: <1476776717-24807-1-git-send-email-ppandit@redhat.com>
	<CAJ+F1CKnyE1d8nT_dj2D5St=2e9+W5Zx0zvXGxPDsOsg1NW66w@mail.gmail.com>
	<alpine.LFD.2.20.1611281003090.19776@wniryva>
	<20170111145934.nogaszs5gvmn5bad@perseus.local>
	<1484167421.26755.10.camel@redhat.com> <20170120094635.GA28338@olga.wb>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH] display: cirrus: check vga bits per
 pixel(bpp) value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wolfgang Bumiller <w.bumiller@proxmox.com>
Cc: Alberto Garcia <berto@igalia.com>, Huawei PSIRT <psirt@huawei.com>, Peter Maydell <peter.maydell@linaro.org>, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Qemu Developers <qemu-devel@nongnu.org>, P J P <ppandit@redhat.com>

  Hi,

> > > What seems to happen is that blit_is_unsafe() is also called for
> > > CIRRUS_BLTMODE_PATTERNCOPY, but in this case cirrus_blt_srcpitch is
> > > not used. However, because of this new check if its value is 0 then
> > > cirrus_bitblt_common_patterncopy() returns early and becomes a no-op.
> >=20
> > inflight vga queue pull request has a fix for that.
>=20
> Do you mean:
>  [PATCH] display: cirrus: ignore source pitch value as needed in blit_is_=
unsafe
>  (Message-Id: <20170109203520.5619-1-brogers@suse.com>)

Yes.

> Because I'm still seeing artifacts on some setups (eg. on win XP).
> As far as I can tell the check is still too strong:
> The rops used by cirrus_bitblt_common_patterncopy seem to only be using
> the destination pitch as far as I can see (all functions in
> cirrus_vga_rop2.h) and in my tests only the destination pitch got
> filled in, the source pitch was left as zero. Adapting the check when
> coming from cirrus_bitblt_common_patterncopy seems to fix the issue for
> me.

> From a3be50cc3e3bb0f5eb784d30048b88333366bdca Mon Sep 17 00:00:00 2001
> From: Wolfgang Bumiller <w.bumiller@proxmox.com>
> Date: Fri, 20 Jan 2017 09:44:39 +0100
> Subject: [PATCH] cirrus: allow zero source pitch in pattern fill rops
>=20
> The rops used by cirrus_bitblt_common_patterncopy only use
> the destination pitch, so the source pitch shoul allowed to
> be zero.
>=20
> Signed-off-by: Wolfgang Bumiller <w.bumiller@proxmox.com>

Looks good to me, can you 'git send-email' it to the list?

thanks,
  Gerd
