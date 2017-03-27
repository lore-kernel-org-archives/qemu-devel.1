Received: from eggs.gnu.org ([2001:4830:134:3::10]:58579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csPaV-0007lx-00
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:01:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csPaQ-0006qS-Ju
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:01:15 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:24814
	helo=SMTP.EU.CITRIX.COM)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <prvs=252db12a3=Paul.Durrant@citrix.com>)
	id 1csPaQ-0006o3-B7
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 04:01:10 -0400
From: Paul Durrant <Paul.Durrant@citrix.com>
Date: Mon, 27 Mar 2017 08:01:07 +0000
Message-ID: <feef084fd323400187f420a2f0588597@AMSPEX02CL03.citrite.net>
References: <1490376002-1223-1-git-send-email-paul.durrant@citrix.com>
	<671b281d-4536-0117-b9a2-b6b72242d3f5@suse.com>
	<alpine.DEB.2.10.1703241153340.8001@sstabellini-ThinkPad-X260>
	<2a218de0a59a4060b00a0f3839323d37@AMSPEX02CL03.citrite.net>
	<4334f125a9174a2e99e5b6f1228da2cd@AMSPEX02CL03.citrite.net>
	<f18632d1-dba1-084d-893c-aca6176754b6@suse.com>
In-Reply-To: <f18632d1-dba1-084d-893c-aca6176754b6@suse.com>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH RESEND] xen: limit pkg-config to
 PKG_CONFIG_PATH for xen libraries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Juergen Gross' <jgross@suse.com>, 'Stefano Stabellini' <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

> -----Original Message-----
[snip]
>=20
> To sum it up we have to care about the following scenarios:
>=20
> a) Xen in-tree build, Xen >=3D 4.9
> b) Xen in-tree build, Xen < 4.9
> c) build out-of-Xen-tree
>=20
> combined with any of:
>=20
> 1) no Xen installed on build machine
> 2) Xen >=3D 4.9 installed
> 3) Xen < 4.9 installed
>=20
> 1) + c) is not supported, all other combinations should work.
>=20

Good summary.

> I suggest the following modifications of my patch:
>=20
> - keep the test program for detection of Xen 4.9
> - scan the extra ldflags for special mentioning of tools/libxc
>   to detect Xen in-tree build < 4.9 (will detect 4.9, too, but
>   this is no problem), set xen_in_tree_old if found
> - if xen_in_tree_old found, don't use pkg-config for Xen version
>   detection and flags
> - otherwise try pkg-config first
>=20
> This should cover all cases we need.
>=20

That sounds plausible.

Thanks,

  Paul

>=20
> Juergen
