Received: from eggs.gnu.org ([2001:4830:134:3::10]:32790)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd26s-00042o-J7
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:27:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd26o-0004rc-Hn
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:27:22 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138]:55836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from
	<SRS0=Iw5G=7E=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
	id 1dd26o-0004qB-BL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 18:27:18 -0400
Date: Thu, 3 Aug 2017 00:27:16 +0200
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20170802222716.gvs2wvxr3litnd3f@var.youpi.perso.aquilenet.fr>
References: <20170802222607.32085-1-samuel.thibault@ens-lyon.org>
	<20170802222607.32085-3-samuel.thibault@ens-lyon.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170802222607.32085-3-samuel.thibault@ens-lyon.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/2] slirp: check len against dhcp options
 array end
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Prasad J Pandit <pjp@fedoraproject.org>, stefanha@redhat.com, jan.kiszka@siemens.com

Samuel Thibault, on jeu. 03 ao=C3=BBt 2017 00:26:07 +0200, wrote:
> From: Prasad J Pandit <pjp@fedoraproject.org>
>=20
> While parsing dhcp options string in 'dhcp_decode', if an options'
> length 'len' appeared towards the end of 'bp_vend' array, ensuing
> read could lead to an OOB memory access issue. Add check to avoid it.
>=20
> Reported-by: Reno Robert <renorobert@gmail.com>
> Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
> Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>

Oops, this should have mentioned the CVE, I'll redo the pull request,
sorry.

> ---
>  slirp/bootp.c | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/slirp/bootp.c b/slirp/bootp.c
> index 5a4646c182..5dd1a415b5 100644
> --- a/slirp/bootp.c
> +++ b/slirp/bootp.c
> @@ -123,6 +123,9 @@ static void dhcp_decode(const struct bootp_t *bp, i=
nt *pmsg_type,
>              if (p >=3D p_end)
>                  break;
>              len =3D *p++;
> +            if (p + len > p_end) {
> +                break;
> +            }
>              DPRINTF("dhcp: tag=3D%d len=3D%d\n", tag, len);
> =20
>              switch(tag) {
> --=20
> 2.13.2
>=20

--=20
Samuel
"...[Linux's] capacity to talk via any medium except smoke signals."
(By Dr. Greg Wettstein, Roger Maris Cancer Center)
