Received: from eggs.gnu.org ([2001:4830:134:3::10]:48197)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq5La-0006jc-GW
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cq5LW-0000yb-Ee
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:00:14 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cq5LW-0000xu-7I
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 18:00:10 -0400
References: <20170316084229.32497-1-fanc.fnst@cn.fujitsu.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f3c810e0-10b7-08a3-59c3-5ceb469442a4@redhat.com>
Date: Mon, 20 Mar 2017 17:00:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170316084229.32497-1-fanc.fnst@cn.fujitsu.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Cve3Txcjmdg6acX0Thuract2F5EsH8VwW"
Subject: Re: [Qemu-devel] [PATCH] Add page-size to output in 'info migrate'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org, dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com, berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com, maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Cve3Txcjmdg6acX0Thuract2F5EsH8VwW
From: Eric Blake <eblake@redhat.com>
To: Chao Fan <fanc.fnst@cn.fujitsu.com>, qemu-devel@nongnu.org,
 dgilbert@redhat.com, quintela@redhat.com, armbru@redhat.com,
 berrange@redhat.com
Cc: caoj.fnst@cn.fujitsu.com, douly.fnst@cn.fujitsu.com,
 maozy.fnst@cn.fujitsu.com, Li Zhijian <lizhijian@cn.fujitsu.com>
Message-ID: <f3c810e0-10b7-08a3-59c3-5ceb469442a4@redhat.com>
Subject: Re: [PATCH] Add page-size to output in 'info migrate'
References: <20170316084229.32497-1-fanc.fnst@cn.fujitsu.com>
In-Reply-To: <20170316084229.32497-1-fanc.fnst@cn.fujitsu.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/16/2017 03:42 AM, Chao Fan wrote:
> The number of dirty pages outputed in 'pages' in the command
> 'info migrate', so add page-size to calculate the number of dirty
> pages in bytes.
>=20
> Signed-off-by: Chao Fan <fanc.fnst@cn.fujitsu.com>
> Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
> ---

> +++ b/qapi-schema.json
> @@ -575,6 +575,9 @@
>  # @postcopy-requests: The number of page requests received from the de=
stination
>  #        (since 2.7)
>  #
> +# @page-size: The number of bytes in page of this gutst.
> +#        (since 2.10)

s/gutst/guest/

Grammar is awkward; better might be:

@page-size: The number of bytes per page for the various page-based
statistics (since 2.10)

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Cve3Txcjmdg6acX0Thuract2F5EsH8VwW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY0FDkAAoJEKeha0olJ0Nqe3EH/A2IzljnImrhBdpQy/mUgZYa
llmpaQkHIUVpnZdCUQS7cEUdD9qlWg0SYmuIuixKeIwDO6NtsUX6zVwDUQpQiWag
Sa6yySrcXz1RU+VkB3HlkXrBJGojQ3xkZxHEZeLMPQI24ofcJcsMbk+BUyUh0AYy
9d8FE0W0+3Qq16pRzSXGotI3vDLsQf5TmaRvRBbftS9BGsZ/ESANz0X9lJvutZqD
vvaEsW2zHn8FgEwQwq4LdB0seDaVwWZxR65xaHUd8tFeju3U2ZRbHd6KYtmFyabt
TteSsSRtqYLELNHvw3okwPdsF/uiooGEk2M+/pZpM0pglpzM7u+3g5BjRaxxsfM=
=igwO
-----END PGP SIGNATURE-----

--Cve3Txcjmdg6acX0Thuract2F5EsH8VwW--
