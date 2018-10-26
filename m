Received: from eggs.gnu.org ([2001:4830:134:3::10]:51869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFvOI-0004kT-4R
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:14:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gFvOD-0001vR-CI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:14:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1gFvOC-0001up-J0
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 02:14:33 -0400
References: <1540512223-21199-1-git-send-email-max7255@yandex-team.ru>
	<1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ba3b8e2d-8d3a-b738-3d87-d56def3ab1e3@redhat.com>
Date: Fri, 26 Oct 2018 07:14:27 +0100
MIME-Version: 1.0
In-Reply-To: <1540512223-21199-5-git-send-email-max7255@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH RFC 4/4] net/slirp: add ipv6-hostfwd option
 for user netdev type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxim Samoylov <max7255@yandex-team.ru>, qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>

On 2018-10-26 01:03, Maxim Samoylov wrote:
> This allows forwarding TCP6 and UDP6 connections down to
> netdev=3Duser connected guests.
>=20
> Signed-off-by: Maxim Samoylov <max7255@yandex-team.ru>
> ---
>  hmp-commands.hx     |  31 ++++++++
>  include/net/slirp.h |   2 +
>  net/slirp.c         | 214 ++++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qapi/net.json       |   3 +-
>  4 files changed, 249 insertions(+), 1 deletion(-)
>=20
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index db0c681..b0e1a08 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -1448,6 +1448,37 @@ STEXI
>  Remove host-to-guest TCP or UDP redirection.
>  ETEXI
> =20
> +#ifdef CONFIG_SLIRP
> +    {
> +        .name       =3D "ipv6_hostfwd_add",
> +        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
> +        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr=
6]:hostport-guestaddr6:guestport",
> +        .help       =3D "redirect TCP6 or UDP6 connections from host t=
o guest (requires -net user)",
> +        .cmd        =3D hmp_ipv6_hostfwd_add,
> +    },
> +#endif
> +STEXI
> +@item hostfwd_add
> +@findex hostfwd_add
> +Redirect TCP6 or UDP6 connections from host to guest (requires -net us=
er).
> +ETEXI
> +
> +#ifdef CONFIG_SLIRP
> +    {
> +        .name       =3D "ipv6_hostfwd_remove",
> +        .args_type  =3D "arg1:s,arg2:s?,arg3:s?",
> +        .params     =3D "[hub_id name]|[netdev_id] [tcp|udp]:[hostaddr=
6]:hostport",
> +        .help       =3D "remove host-to-guest TCP6 or UDP6 redirection=
",
> +        .cmd        =3D hmp_ipv6_hostfwd_remove,
> +    },

 Hi,

could you please remove the "[hub_id name]" touple here? I recently sent
a patch to deprecate it for the IPv4 version, too:

https://lists.gnu.org/archive/html/qemu-devel/2018-09/msg03198.html

Also I think it would make sense if you mention in the help text that
IPv6 addresses have to be given with square brackets?

 Thanks,
  Thomas
