Received: from eggs.gnu.org ([2001:4830:134:3::10]:35354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eRIki-0002jp-9p
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eRIkf-0000sY-GZ
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:20:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50824)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1eRIkf-0000qz-5y
	for qemu-devel@nongnu.org; Tue, 19 Dec 2017 09:20:13 -0500
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
	<20171212164114.GF2409@work-vm>
	<e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
	<b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
	<225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
Date: Tue, 19 Dec 2017 15:20:07 +0100
MIME-Version: 1.0
In-Reply-To: <225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AoxMFINdsTRWA9R0NjD2kL6Nph3qMnK1a"
Subject: Re: [Qemu-devel] [PATCH v1] hmp: 'info snapshots' not showing the id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: seeteena <s1seetee@linux.vnet.ibm.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AoxMFINdsTRWA9R0NjD2kL6Nph3qMnK1a
From: Max Reitz <mreitz@redhat.com>
To: seeteena <s1seetee@linux.vnet.ibm.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, lma@suse.com
Cc: qemu-devel@nongnu.org
Message-ID: <9b719ebe-8b38-708c-45a7-d377a583f899@redhat.com>
Subject: Re: [PATCH v1] hmp: 'info snapshots' not showing the id
References: <1511273358-21789-1-git-send-email-s1seetee@linux.vnet.ibm.com>
 <20171212164114.GF2409@work-vm>
 <e37d8871-544f-3c4f-3a59-bb66dc5c8b67@linux.vnet.ibm.com>
 <b5c7e566-34f0-adb0-0fcb-bf272cbb0a81@redhat.com>
 <225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
In-Reply-To: <225a4478-dc5e-a067-f207-e8a183afa0d9@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-18 10:24, seeteena wrote:
>=20
>=20
> On 12/15/2017 02:48 PM, Max Reitz wrote:
>> On 2017-12-13 05:50, seeteena wrote:
>>> Hi David,
>>>
>>> While creating snapshots when tag name '0' used in the very first and=
 followed by tag name '1' then snapshot created with tag name '0' is gett=
ing erased.=20
>>> A snapshot is identified by a name computed either from an id, which =
is basically a numerical counter starting at 1 for qcow2, or from a tag, =
which is a string (provided
>>> by the user or automatically computed).=20
>>>
>>> (qemu) savevm 0
>>>
>>> This creates a snapshot with tag '0' and id '1'.
>> That's something someone has complained about already, as far as I
>> remember, and this is indeed an issue.
>>
>>>> (qemu) savevm 1
>>> This deletes snapshot with name '1' (ie, with id '1') and creates sna=
pshot with tag '1' and id '1'.
>> I think this is the issue, not info snapshots.
>>
>>> From the output of 'info snapshots' id '1' is not seen for tag '0' in=
stead seeing an empty field.
>>>
>>> ID        TAG                 VM SIZE                DATE       VM CL=
OCK
>>> --        0                      338M 2017-10-16 13:44:35   00:02:07.=
491
>>>
>>> If an ID shown as '1' in the above then user can understand the above=
 documented stuff i.e "If there is already a snapshot with the same tag o=
r ID, it is replaced".
>>> The '--' in ID field is annoying.
>> Maybe, but this patch is wrong still.  Commit 3a1ee711904 says exactly=
 why:
>>
>>> The patch uses snapshot name instead of snapshot id to determine whet=
her a
>>> snapshot is fully available and uses '--' instead of snapshot id in o=
utput
>>> because the snapshot id is not guaranteed to be the same on all image=
s.
>> info snapshots first shows a list of snapshots that are present on all=

>> disks.  However, those are matched by name and not by ID, so the ID is=

>> not necessarily the same.
>>
>> Therefore, we can only print it if it is.  Sure, we can do that, but
>> your patch is missing that check.
> =C2=A0As you referred I had checked Commit 3a1ee711904. Does it mean th=
at we
> need to add the check option for ID as well along with name to get the
> list of snapshots that are present on all disks with my patch ?
> so info snapshots shows list of snapshots that are present on all disks=

> that matched either by ID or name.
>=20
> like
> if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) =3D=3D 0) ||
> (bdrv_all_find_snapshot(sn_tab[i].id_str, &bs1) =3D=3D 0)

Kind of true, but I think that first this is a separate issue and
secondly, this can get rather hairy.  (See below under (3).)

So there are three things:

(1) We probably should not allow snapshot names that could be IDs.
Easiest way to solve this: Names have to start with a non-digit.

(2) If we want to print a global snapshot's common ID, we need to affirm
that this ID is indeed the same on all disks before we can print it.
Same for names, but currently the name is always the same on all disks
because that is how we identify global snapshots.

(3) You can give an ID to loadvm and then it will load the snapshot with
that ID from all disks.  So if you have snapshots with a common ID on
all disks, these are kind of global snapshots, too, even though they
don't share a name.  Thus, they should probably be included in the
listing (this is what you have just proposed).
I don't like this at all, though.  A snapshot's ID is not really
user-controlled, it's just some auto-generated number.  Therefore, just
because the ID of a snapshot matches across multiple disks, this doesn't
mean that they are related whatsoever.
So, first, I don't think loadvm should work with IDs (at least not
across multiple disks).  But I don't think this really needs to be fixed.=

On the other hand, I really don't think info snapshots should list
snapshots that match by ID, because a matching ID does not mean that
snapshots are actually related.  A matching name usually does, though,
so I think what we currently do is sufficient and the right way to do it.=


Max


--AoxMFINdsTRWA9R0NjD2kL6Nph3qMnK1a
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlo5IBcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWXsH/1RoJu6QXDBckFbcz7BsMLSIKGPm1u3h
vtkjHKEHIiwypRnYO7dfzM+zxrT0K01xU2bp9Ke8e58SbXQic2a9dedKynUBubws
NbsnvbfUCFHJwliA2Y9y2PCbkJsu4K/zODK9Ofgmb3rLlp4UBBUjkSv3dBs4Q/SD
1Br8y6Cwgm5Ki5rL262ghtI5f9nojkSXdfW8y5FbgO+mUCOLfrxy33Wp8v0boKMB
/MQgxZYCM+3i+mCPutmLHWhBILfxyh4TkC6VjEHE0fX9fGeacMVVbiF8e4/03bRD
/+LKCRjQc/1Xh07ZVBrHXAuVf8uCQT4RBMoX2tUriv7AqkQCmmoScHc=
=pIMU
-----END PGP SIGNATURE-----

--AoxMFINdsTRWA9R0NjD2kL6Nph3qMnK1a--
