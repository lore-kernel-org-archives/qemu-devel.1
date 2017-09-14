Received: from eggs.gnu.org ([2001:4830:134:3::10]:47953)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPdk-00036C-QG
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:36:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1dsPdg-0002SD-T9
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:36:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49102)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1dsPdg-0002RL-N5
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 04:36:48 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 294A1C04B94B
	for <qemu-devel@nongnu.org>; Thu, 14 Sep 2017 08:36:47 +0000 (UTC)
Message-ID: <1505378205.31557.3.camel@redhat.com>
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 14 Sep 2017 10:36:45 +0200
In-Reply-To: <47d72e62-8ebb-3b45-3efe-ab5f98ed4f39@redhat.com>
References: <20170913120937.5645-1-kraxel@redhat.com>
	<20170913120937.5645-3-kraxel@redhat.com>
	<47d72e62-8ebb-3b45-3efe-ab5f98ed4f39@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/2] Add --firmwarepath to configure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

  Hi,

> > +=C2=A0=C2=A0--firmwarepath=3DPATH=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
search PATH for firmware files
>=20
> Maybe --firmwaredir or --with-firmwaredir (because firmwaredir is not
> one of the "standard" directories)?

I've intentionally named this "path" because it can actually have
multiple directories.

Or do you mean something else?  If so --verbose please.

> > +=C2=A0=C2=A0=C2=A0=C2=A0/* add configured firmware directories */
> > +=C2=A0=C2=A0=C2=A0=C2=A0dirs =3D g_strsplit(CONFIG_QEMU_FIRMWAREPATH=
, ":", 0);
>=20
> Windows probably wants to use ; here, so you can use
> G_SEARCHPATH_SEPARATOR_S instead of ":".

Ah, cool, didn't know this exists.  Fixing ...

cheers,
  Gerd
