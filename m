Received: from eggs.gnu.org ([2001:4830:134:3::10]:53895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csaIg-0001vL-2e
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:27:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1csaId-0008M3-Eh
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:27:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1csaId-0008Kg-6F
	for qemu-devel@nongnu.org; Mon, 27 Mar 2017 15:27:31 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0014F8553C
	for <qemu-devel@nongnu.org>; Mon, 27 Mar 2017 19:27:29 +0000 (UTC)
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
	<1490621195-2228-9-git-send-email-armbru@redhat.com>
	<d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
	<87h92eefmf.fsf@dusky.pond.sub.org>
	<a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com>
	<87lgrq8rbv.fsf@dusky.pond.sub.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <8b3f906d-a71b-4b41-adfd-ab24f3431de0@redhat.com>
Date: Mon, 27 Mar 2017 14:27:28 -0500
MIME-Version: 1.0
In-Reply-To: <87lgrq8rbv.fsf@dusky.pond.sub.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Pr889329b7JAbj6EQiQ1WT5lOp2BdNDax"
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
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
--Pr889329b7JAbj6EQiQ1WT5lOp2BdNDax
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: kwolf@redhat.com, jdurgin@redhat.com, mreitz@redhat.com,
 qemu-devel@nongnu.org, jcody@redhat.com
Message-ID: <8b3f906d-a71b-4b41-adfd-ab24f3431de0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC v3 for-2.9 08/11] rbd: Revert -blockdev
 and -drive parameter auth-supported
References: <1490621195-2228-1-git-send-email-armbru@redhat.com>
 <1490621195-2228-9-git-send-email-armbru@redhat.com>
 <d6cd1529-2f9a-45fe-3bbf-76e7baf5e9d4@redhat.com>
 <87h92eefmf.fsf@dusky.pond.sub.org>
 <a07cf17a-146e-1b5b-e5e5-0456cecb88d1@redhat.com>
 <87lgrq8rbv.fsf@dusky.pond.sub.org>
In-Reply-To: <87lgrq8rbv.fsf@dusky.pond.sub.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 03/27/2017 02:14 PM, Markus Armbruster wrote:

>>>>
>>>> Removing the .json QMP support is fine. But I'm reluctant to give R-=
b
>>>> without knowing for sure that -drive usage won't regress.
>>>
>>> auth-supported landed in master only on March 2nd.
>>
>> auth-supported via -blockdev-add only landed on March 2nd.  But
>> auth-supported via -drive landed in commit 60390a2, Jan 2016; and is i=
n
>> use by libvirt:
>>
>> src/qemu/qemu_command.c:
>> ":key=3D%s:auth_supported=3Dcephx\\;none",
>=20
> That's a key-value part of the pseudo-filename.  *Not* reverted by this=

> patch.  Only QemuOpts parameter auth_supported is.
>=20
> QemuOpts parameter: -drive driver=3Drbd,auth_supported.0.auth=3Dnone,..=
=2E
> Pseudo-filename:    -drive file=3Drbd:...:auth_supported=3Dnone
>=20
>>> What libvirt usage exactly do you think this could break?
>>>
>>
>> Libvirt has been managing rbd drives using -drive since at least libvi=
rt
>> commit 5745cd1, in Nov 2011, where even back then it was passing:
>>             virBufferEscape(opt, ":", ":key=3D%s:auth_supported=3Dceph=
x none",
>>
>> (back when it used space instead of ; to separate the list of supporte=
d
>> auth types).

Ah, so as long as libvirt uses 'drive file=3Drbd:...' with key-value
pairs, our backdoor of =3Dkey-values will let it continue to work.  And
looking more at libvirt, it definitely looks like it is sticking to
file=3Drbd: pseudo-filenames for now; for example:

tests/qemuxml2argvdata/qemuxml2argv-disk-drive-network-rbd-auth-AES.args:=
-drive
'file=3Drbd:pool/image:id=3Dmyname:auth_supported=3Dcephx\;none:\


I'm not sure if (or where) a big fat comment to that effect would be
beneficial, but it certainly goes a long ways in explaining the goals of
your series.

>>
>> As I've never personally used RBD (whether through qemu directly, or
>> through libvirt), I'm extremely wary of breaking -drive usage that
>> "works" (for some definition of "works"), even though I have no qualms=

>> making the QMP interface extremely limited.
>=20
> All clear now?

I think so.  Commit 60390a2 (Jan 2016) mentions the use of
auth_supported in the commit message (matching libvirt usage), but under
the pseudo-file format; the actual rbd.c file did not special case it
differently from any other key-value pair.  "auth" wasn't added to
QemuOpts (for the -drive driver=3Drbd, form) until commit 0a55679, which
is unreleased, so libvirt can't have been relying on it, and ripping it
out now is safe enough.

Under that light, I'm now going to re-read your patch...

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--Pr889329b7JAbj6EQiQ1WT5lOp2BdNDax
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJY2WegAAoJEKeha0olJ0NqMLcH/Rs3eCvaxTjxqPptxKVvzQ2z
Pbo7HyTXutzjHeVwST7L0q4loTIz/I0oEHCnLWrsF03aUVpWKqsIEqdeXfhCEfWh
r0kr5fjby+WYxYNmn4gXL6aUm/pdgkye40f2vNWvjYUtatf/HqvUfokoXTz+h8Zq
u9B0Pa0yXChBMUJcsCKJUnJPAuCYvMd2LUnbeQg3kLsXXTETtQbn9tQCnq57I38d
V+YtEjYJ44UsbVDuFb2lPakPwIoRIbruKKbFpzVwbgnf5VVej3hYSeDsD4Qgo/7H
xzOpwG9ePkqYOI8pHhpz5HFRr3Lfg58vIUeFhFKD2V2VR85+RLVyHMenWhVhsxE=
=ID8Z
-----END PGP SIGNATURE-----

--Pr889329b7JAbj6EQiQ1WT5lOp2BdNDax--
