Received: from eggs.gnu.org ([2001:4830:134:3::10]:38943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLmK-0006gr-Br
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:39:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gWLcS-0002CZ-D0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:29:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43390)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gWLcS-0002BX-5x
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 08:29:08 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F077A307D845
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 13:29:06 +0000 (UTC)
Date: Mon, 10 Dec 2018 14:28:59 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <20181210132859.jflevx6hp7zi2d5r@sirius.home.kraxel.org>
References: <20181128155932.16171-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181128155932.16171-1-marcandre.lureau@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 v3] configure: bump spice-server
 required version to 0.12.5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, fziglio@redhat.com, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Nov 28, 2018 at 07:59:32PM +0400, Marc-Andr=E9 Lureau wrote:
> Looking at chardev/spice.c code, I realize compilation was broken for
> a while with spice-server < 0.12.3. Let's bump required version
> to 0.12.5, released May 19 2014, instead of adding more #ifdef.
>=20
> (this patch combines changes from an early version and some of
> Frediano "[PATCH 2/2] spice: Bump required spice-server version to
> 0.12.6")
>=20
> According to repology, all the distros that are build target platforms
> for QEMU include it:
>=20
>       RHEL-7: 0.14.0
>       Debian (Stretch): 0.12.8
>       Debian (Jessie): 0.12.5
>       FreeBSD (ports): 0.14.0
>       OpenSUSE Leap 15: 0.14.0
>       Ubuntu (Xenial): 0.12.6
>=20
> Note that a previous version of this patch was bumping version to
> 0.12.6. Unfortunately, Debian Jessie (oldstable) is stuck with spice
> server 0.12.5, and QEMU should keep building until after 2y of current
> stable (Stretch), which will be around June 17th 2019. Qemu 4.1
> should thus be free of bumping to spice-server 0.12.6 during 4.1
> development cycle.

Added to UI queue.

thanks,
  Gerd
