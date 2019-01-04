Received: from eggs.gnu.org ([208.118.235.92]:51289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfSAA-00026G-2M
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:17:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gfSA9-0001ef-7S
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 11:17:34 -0500
References: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1756fe6d-3bbb-081c-896b-419f1ffa4463@redhat.com>
Date: Fri, 4 Jan 2019 10:17:10 -0600
MIME-Version: 1.0
In-Reply-To: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="of8SA0wXz4P0Wd95cXSkeXBEHjRcJpsHb"
Subject: Re: [Qemu-devel] [PATCH v2] qemu: avoid memory leak while remove
 disk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: w00426999 <wangjian161@huawei.com>, mst@redhat.com, kwolf@redhat.com, mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@gmail.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--of8SA0wXz4P0Wd95cXSkeXBEHjRcJpsHb
From: Eric Blake <eblake@redhat.com>
To: w00426999 <wangjian161@huawei.com>, mst@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, pbonzini@redhat.com, famz@redhat.com, stefanha@gmail.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, eric.fangyi@huawei.com
Message-ID: <1756fe6d-3bbb-081c-896b-419f1ffa4463@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2] qemu: avoid memory leak while remove disk
References: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
In-Reply-To: <1545474448-24488-1-git-send-email-wangjian161@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/22/18 4:27 AM, w00426999 wrote:
> Memset vhost_dev to zero in the vhost_dev_cleanup function.
> This causes dev.vqs to be NULL, so that
> vqs does not free up space when calling the g_free function.
> This will result in a memory leak. But you can't release vqs
> directly in the vhost_dev_cleanup function, because vhost_net
> will also call this function, and vhost_net's vqs is assigned by array.=

> In order to solve this problem, we first save the pointer of vqs,
> and release the space of vqs after vhost_dev_cleanup is called.
>=20
> Signed-off-by: Jian Wang <wangjian161@huawei.com>

It appears that this is your first qemu contribution - welcome!

Your S-o-b tag uses a different spelling "Jian Wang" than your From:
line "w00426999".  You may want to address your git config settings so
that outgoing mail sets the From: line correctly (I'm not sure which
config settings are involved; I also know that sometimes you can't
control the actual mail From: such as when sending from an address that
undergoes list munging due to SPF settings, but in that case git can be
told to insert a From: in the message body that will override any From:
header).  Fixing it now will avoid having to add a .mailmap entry to tie
the two spellings together.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--of8SA0wXz4P0Wd95cXSkeXBEHjRcJpsHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEY3OaSlgimHGqKqRv3g5py3orov0FAlwvhwcACgkQ3g5py3or
ov3bXgf9FgxjJA9uV4YNxNufDlnf8Dpl9FQdcD+56r3W7adRSea47p82VIYkqtDi
iIjPFg7NJ9Ow78i1ym9J/5CKa4Yz0Vld4CutZH1z5abb5qbVemxIuAOqxdzt0cyJ
Eypca/i+1woRea/rsAuZcwd05BduqGVqAG4jyeUO0l6/4P0aYrjvEAOT+oa6uY5j
NFE6kAJeQwkVNufl4zFU5pZgV4+7xEvkR6YOLZalM3He0DkNaZRAQkkrvR6op411
MpM5x0fZkRo1MVkYteihhDwY6N1ZxrcAvvHiUjHLerJ5gWtwdPabvw3wKsSA+pCc
8zbRUUxvZZZ/TkiGBZTmwtF9qyuQrQ==
=KYnj
-----END PGP SIGNATURE-----

--of8SA0wXz4P0Wd95cXSkeXBEHjRcJpsHb--
