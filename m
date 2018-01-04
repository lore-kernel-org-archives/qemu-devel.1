Received: from eggs.gnu.org ([2001:4830:134:3::10]:54601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9Wt-0007tI-7z
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:42:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eX9Wp-000552-8A
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:42:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55696)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1eX9Wp-00054a-1J
	for qemu-devel@nongnu.org; Thu, 04 Jan 2018 12:42:07 -0500
References: <20171222155522.17868-1-pbonzini@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <909f1d30-ff36-08ce-d05d-e563815a7f5e@redhat.com>
Date: Thu, 4 Jan 2018 11:42:04 -0600
MIME-Version: 1.0
In-Reply-To: <20171222155522.17868-1-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="QycKQD3obYWsQNOUzUuTX0VCQ1atV8h01"
Subject: Re: [Qemu-devel] [PATCH] scsi: fix scsi_convert_sense crash when
 in_buf == NULL && in_len == 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QycKQD3obYWsQNOUzUuTX0VCQ1atV8h01
From: Eric Blake <eblake@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rkagan@virtuozzo.com
Message-ID: <909f1d30-ff36-08ce-d05d-e563815a7f5e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi: fix scsi_convert_sense crash when
 in_buf == NULL && in_len == 0
References: <20171222155522.17868-1-pbonzini@redhat.com>
In-Reply-To: <20171222155522.17868-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/22/2017 09:55 AM, Paolo Bonzini wrote:
> scsi_disk_emulate_command passes in_buf =3D=3D NULL when sent a REQUEST=

> SENSE command.  Check for in_len =3D=3D 0 before dereferencing in_buf.
>=20
> Fixes: f68d98b21fa74155dc7c1fd212474379ac3c7531
> Reported-by: Roman Kagan <rkagan@virtuozzo.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  scsi/utils.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)

How does this compare to
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg00582.html ?

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--QycKQD3obYWsQNOUzUuTX0VCQ1atV8h01
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpOZ20ACgkQp6FrSiUn
Q2rJsAf/SW0QB9eR2m5bP+kckfeKnoHFXJV86FHQtJrl4Q3diiq6cb1H6dfH5tzy
zEK5FH8XDwZl4OYeUeY9iOEwjycDY/Kafgui8JD0aHEEk7baR7vxASu9Ui9AFYQu
XJlLTmRlAEA+TLNYzp4z/8aFa8lwLVaeUKItb2/WNUjpG97RWcPTxYy/tUEWheC7
eNmLqKmjpXLz1dp4fpJUO4ndzXqXQRNt3OjKE4musueWrnlHhR5/azYgX2bO+VUK
d93/llRFX4ogVCvuhuYilA66YfF/WiYEQAU+CrXLMKanXDdX+Y83oP/yzv0D+Ue5
TBUJOH2V/lMEEfZxADoOmXAiy68tAA==
=P3ju
-----END PGP SIGNATURE-----

--QycKQD3obYWsQNOUzUuTX0VCQ1atV8h01--
