Received: from eggs.gnu.org ([2001:4830:134:3::10]:48367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr9hn-00041M-Bh
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:51:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cr9hm-0003EL-8P
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:51:35 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42828)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cr9hl-0003C9-Vm
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 16:51:34 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id F08C48049C
	for <qemu-devel@nongnu.org>; Thu, 23 Mar 2017 20:51:33 +0000 (UTC)
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
	<1490266548-22500-4-git-send-email-armbru@redhat.com>
	<011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
	<878tnv6e6q.fsf@dusky.pond.sub.org>
	<385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ff1ac3a6-2ad0-f3aa-f085-17e1fc43d21c@redhat.com>
Date: Thu, 23 Mar 2017 15:51:25 -0500
MIME-Version: 1.0
In-Reply-To: <385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lkWvg1JiHaVvsdnXRlMFVgsccS4d517pK"
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to
 extract list-valued options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, mreitz@redhat.com, qemu-devel@nongnu.org, jcody@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lkWvg1JiHaVvsdnXRlMFVgsccS4d517pK
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, mreitz@redhat.com,
 qemu-devel@nongnu.org, jcody@redhat.com
Message-ID: <ff1ac3a6-2ad0-f3aa-f085-17e1fc43d21c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.9 3/5] rbd: Rewrite the code to extract
 list-valued options
References: <1490266548-22500-1-git-send-email-armbru@redhat.com>
 <1490266548-22500-4-git-send-email-armbru@redhat.com>
 <011d21ee-aa96-2541-2e54-16c423f07cce@redhat.com>
 <878tnv6e6q.fsf@dusky.pond.sub.org>
 <385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
In-Reply-To: <385d2fa4-a7ec-e22c-e89d-5387cccc2ca4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/23/2017 02:18 PM, Eric Blake wrote:

>>>> -            if (port) {
>>>> -                /* check for ipv6 */
>>>> -                if (strchr(host, ':')) {
>>>> -                    strbuf =3D g_strdup_printf("[%s]:%s", host, por=
t);
>>>> -                } else {
>>>> -                    strbuf =3D g_strdup_printf("%s:%s", host, port)=
;
>>>
>>> The old code only prints port information if it is present...
>>>

>>> ...but the new code unconditionally prints port information, even whe=
n
>>> port =3D=3D NULL.  Oops.
>>
>> How can port be null?  SocketAddress member port is mandatory...
>=20
> Indeed. Does that mean the old code had a dead branch? Looks like it!

Or else my reading of the old code was wrong.  It looks like port was
optional on the command line, but in the conversion to QemuOpts, a
missing port was treated as the default port.  Now that you are not
going through QemuOpts, you have to make sure that you can still supply
a default port to keep the QAPI happy with a mandatory port.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--lkWvg1JiHaVvsdnXRlMFVgsccS4d517pK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY1DVNAAoJEKeha0olJ0NqiscIAIv7ko7aKpWZeOHdvzArBtGo
97eMLwWepssMnfmqY+oIs/mDGxZyfmGHMnzd3meWdTxaXFpy+tXYwcOtJIZFyUxX
hH7hRbWibqiedwxVsaMxglPw88AY5h8lli9ptulRko1eyBIjFHB/OP+e7KyE7uY8
DIL0qqsTOqFnBaBj+oOXk0rXnl9C1TcoPehQBRgn/VwJwyMjqVuNqtvypMP5dEZH
KmXL4HxsOaAe7XKo89WZWk8+O/7zsIsOaD8bkO7oBlRw53MXJjyMvv/fz7WFaAtK
d1g3qvNFf6O+5JJDLkOlOVmKPE7P+Z9YazXjBhL6EHSLaAL8O6TlewweLaNoxjc=
=7Vzd
-----END PGP SIGNATURE-----

--lkWvg1JiHaVvsdnXRlMFVgsccS4d517pK--
