Received: from eggs.gnu.org ([2001:4830:134:3::10]:35691)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu78a-0007KY-7Q
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fu78W-0008TS-S0
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:16 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53452 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fu78W-0008Sr-L6
	for qemu-devel@nongnu.org; Sun, 26 Aug 2018 22:20:12 -0400
Date: Mon, 27 Aug 2018 10:20:08 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20180827022008.GA19413@lemon.usersys.redhat.com>
References: <20180824135312.1606-1-famz@redhat.com>
	<20180825165306.tyoc5jrcgmkmbzyy@var.youpi.perso.aquilenet.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20180825165306.tyoc5jrcgmkmbzyy@var.youpi.perso.aquilenet.fr>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] slirp: Implement RFC2132 TFTP server name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Samuel Thibault <samuel.thibault@gnu.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, brad@comstyle.com

On Sat, 08/25 18:53, Samuel Thibault wrote:
> Hello,
>=20
> Fam Zheng, le ven. 24 ao=FBt 2018 21:53:12 +0800, a ecrit:
> >                            const char *vnameserver, const char *vname=
server6,
> >                            const char *smb_export, const char *vsmbse=
rver,
> >                            const char **dnssearch, const char *vdomai=
nname,
> > +                          const char *tftp_server_name,
>=20
> I'd say rather put it between the vhostname and tftp_export parameters.
>=20
> > @@ -321,6 +322,9 @@ Slirp *slirp_init(int restricted, bool in_enabled=
, struct in_addr vnetwork,
> >      slirp->vdhcp_startaddr =3D vdhcp_start;
> >      slirp->vnameserver_addr =3D vnameserver;
> >      slirp->vnameserver_addr6 =3D vnameserver6;
> > +    if (tftp_server_name) {
> > +        slirp->tftp_server_name =3D g_strdup(tftp_server_name);
> > +    }
>=20
> I'd say do not bother testing for tftp_server_name !=3D NULL, just alwa=
ys
> use g_strdup, as is done for other values.

Both sound good. I'll send v2.

Fam
