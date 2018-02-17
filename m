Received: from eggs.gnu.org ([2001:4830:134:3::10]:48974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1en9qf-00033F-Ak
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 16:16:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1en9qc-0005xt-50
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 16:16:45 -0500
Received: from hera.aquilenet.fr ([185.233.100.1]:38496)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1en9qb-0005xK-Up
	for qemu-devel@nongnu.org; Sat, 17 Feb 2018 16:16:42 -0500
Date: Sat, 17 Feb 2018 22:16:39 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180217211639.3nmuftec64455qor@var.youpi.perso.aquilenet.fr>
References: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180216125504.25955-1-benjamin.drung@profitbricks.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/1] slirp: Add domainname option to
 slirp's DHCP server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Benjamin Drung <benjamin.drung@profitbricks.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org

Hello,

Benjamin Drung, on ven. 16 f=C3=A9vr. 2018 13:55:03 +0100, wrote:
> Or should the command line option be simpler, but how should it be spec=
ified
> then? Maybe
>=20
>   -net staticroute=3D10.0.2.0/24via10.0.2.2,staticroute=3D192.168.0.0/1=
6via10.0.2.2

I guess=20

>   -net staticroute=3D10.0.2.0/24:10.0.2.2,staticroute=3D192.168.0.0/16:=
10.0.2.2

would be more mainstream.

I'm also wondering to which extent we want to extend our dhcp server,
when a tap device can be used to plug (or proxy) an actual dhcp serveR.

samuel
