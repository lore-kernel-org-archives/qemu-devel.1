Received: from eggs.gnu.org ([208.118.235.92]:40577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ftboO-0008PJ-ME
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:53:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1ftboL-0004I9-7K
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:53:20 -0400
Received: from hera.aquilenet.fr ([185.233.100.1]:47942)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1ftboK-0004CC-Nw
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 12:53:16 -0400
Date: Sat, 25 Aug 2018 18:53:06 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180825165306.tyoc5jrcgmkmbzyy@var.youpi.perso.aquilenet.fr>
References: <20180824135312.1606-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180824135312.1606-1-famz@redhat.com>
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
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, berrange@redhat.com, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, brad@comstyle.com

Hello,

Fam Zheng, le ven. 24 ao=C3=BBt 2018 21:53:12 +0800, a ecrit:
>                            const char *vnameserver, const char *vnamese=
rver6,
>                            const char *smb_export, const char *vsmbserv=
er,
>                            const char **dnssearch, const char *vdomainn=
ame,
> +                          const char *tftp_server_name,

I'd say rather put it between the vhostname and tftp_export parameters.

> @@ -321,6 +322,9 @@ Slirp *slirp_init(int restricted, bool in_enabled, =
struct in_addr vnetwork,
>      slirp->vdhcp_startaddr =3D vdhcp_start;
>      slirp->vnameserver_addr =3D vnameserver;
>      slirp->vnameserver_addr6 =3D vnameserver6;
> +    if (tftp_server_name) {
> +        slirp->tftp_server_name =3D g_strdup(tftp_server_name);
> +    }

I'd say do not bother testing for tftp_server_name !=3D NULL, just always
use g_strdup, as is done for other values.

Samuel
