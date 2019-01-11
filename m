Received: from eggs.gnu.org ([209.51.188.92]:36766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghwlS-0005Oz-Th
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:22:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghwlQ-00020V-24
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:22:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53432)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghwlP-00020H-Nw
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:22:20 -0500
References: <20180906111107.30684-1-danielhb413@gmail.com>
	<47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
	<a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
Date: Fri, 11 Jan 2019 14:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <20190110114113.GC2589@work-vm>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mkWQuXeEFSw9n1uypZiNCjIdavWiRmG9p"
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use
 ID anymore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mkWQuXeEFSw9n1uypZiNCjIdavWiRmG9p
From: Max Reitz <mreitz@redhat.com>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, armbru@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 muriloo@linux.ibm.com
Message-ID: <dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <20180906111107.30684-1-danielhb413@gmail.com>
 <47023eb5-41f1-1b60-1094-d607999e93b6@redhat.com>
 <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
 <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
 <20190109185154.GL4867@localhost.localdomain>
 <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
 <20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
In-Reply-To: <20190110114113.GC2589@work-vm>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.01.19 12:41, Dr. David Alan Gilbert wrote:
> * Kevin Wolf (kwolf@redhat.com) wrote:
>> Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
>>> On 1/9/19 12:51 PM, Kevin Wolf wrote:
>>>
>>>>> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
>>>>> human-monitor-command, since there is no QMP counterpart for intern=
al
>>>>> snapshot.  Even though lately we consistently tell people that inte=
rnal
>>>>> snapshots are underdeveloped and you should use external snapshots,=
 it
>>>>> does not get away from the fact that libvirt has been using 'savevm=
' to
>>>>> drive internal snapshots for years now, and that we MUST consider
>>>>> back-compat and/or add an introspectible QMP interface before makin=
g
>>>>> changes that would break libvirt.
>>>>
>>>> Okay, so what does libvirt do when you request a snapshot with a
>>>> numerical name? Without having looked at the code, the best case I w=
ould
>>>> expect that it forbids them, and more realistically I suspect that w=
e
>>>> may actually fix a bug for libvirt by changing the semantics.
>>>>
>>>> Or does libvirt really use snapshot IDs rather than names?
>>>
>>> At the moment, libvirt does not place any restriction on internal
>>> snapshot names, but passes the user's name through without thought of=

>>> whether it is an id or a name.
>>>
>>> So yes, arguably tightening the semantics fixes a libvirt bug for
>>> libvirt having allowed internal snapshots to get into an inconsistent=

>>> state.
>>
>> So there are two scenarios to consider with respect to breaking
>> backwards compatibility:
>>
>> 1. There may be code out there that relies on numeric arguments being
>>    interpreted as IDs. This code will break if we make this change and=

>>    numeric snapshot names exist. That such code exists is speculation
>>    (even though plausible) and we don't know how widespread it is.
>>
>> 2. There may be code out there that blindly assumes that whatever it
>>    passes is interpreted as a name. Nobody considered that with a
>>    numeric snapshot name, it maybe misinterpreted as an ID. We know th=
at
>>    this is true for libvirt, the single most used management tool for
>>    QEMU. More code like this may (and probably does) exist.
>>
>> Essentially the same two categories exist for human users: those who
>> somehow found out that QEMU accepts IDs as monitor command arguments a=
nd
>> are using those (mitigated by not displaying IDs any more), and those
>> who are trapped because they wanted to access a numeric name, but
>> surprisingly got it interpreted as an ID. Both are speculation to some=

>> degree, but my guess is that the latter group is larger.
>>
>> Given all this, this is a no-brainer for me. We simplify the interface=
,
>> we simplify the code, we make things less confusing for manual users a=
nd
>> we fix the management tool that everybody uses. How could we not make
>> this change?

So you're trying to make a bug fix out of this now to get around
deprecation?  To me, changing behavior in qemu to fix a bug in libvirt
doesn't equate to fixing a bug in qemu.  So let's try to find a real bug
in qemu.

>>> But again, it falls in the category of "properly fixing this
>>> requires a lot of auditing, time, mental power, and unit tests", whic=
h
>>> makes it a rather daunting task to state for certain.
>>
>> Fix the world before we can fix anything?
>=20
> Can't we break this loop for the savevm command fairly easily; it's
> currently documnted as:
>=20
> savevm [tag|id]

The bug starts here.  The code doesn't match the interface description,
because this to me as a user suggests that "tag" has precedence over
"id" (same for loadvm and delvm).  But let's go over the strange
behavior for each:

savevm deletes all snapshots where either tag or ID match.[1]  I think
that's buggy because it should replace only one snapshot, not
accidentally remove something totally different.  It then...  Tries to
find that snapshot? and overwrite it with the new one.  Which makes no
sense because it has just deleted that snapshot, if it existed.[2]
So savevm will then just create a new snapshot with the given tag.

So it seems clear that savevm does not accept IDs, but really just tags.
 It follows that it should not try to delete all snapshots where the ID
matches the given tag.


loadvm uses bdrv_all_find_snapshot() -> bdrv_snapshot_find() where the
ID takes precedence over the tag.  This does not seem to match the
interface description, as I've said above.  So the first thing to do
clearly is to switch the comparison order in bdrv_snapshot_find().  Or,
well, apply this series because it removes the ID comparison altogether.
 But that wouldn't be needed for a bug fix.


delvm directly invokes bdrv_all_delete_snapshot() and thus shares the
same woes as savevm (see [1]).


[1] Actually, this is not quite true.  bdrv_all_delete_snapshot()
invokes bdrv_snapshot_delete_by_id_or_name() if bdrv_snapshot_find()
returned true.  So far, so good.  But
bdrv_snapshot_delete_by_id_or_name() will first try to delete a snapshot
with matching ID, and only if that failed it will delete a snapshot with
matching tag.  So if you have two snapshots { "0": "foo", "1": "0" } and
then bdrv_all_delete_snapshot("0"), only "foo" will be deleted.  So this
function doesn't really delete all snapshots that match...

[2] It follows from [1] that this is not quite true as well.  Take the
above example and savevm "0".  It will then delete snapshot "foo" and
indeed overwrite snapshot "0" (ID "1").  But that's just stupid.  It
looks like we have specialized code for after we have deleted an
unrelated snapshot for no reason whatsoever.


So, yes, there are bugs in qemu, but to fix them, we would need to
switch the comparison order in bdrv_snapshot_find() and fix
bdrv_snapshot_delete_by_id_or_name() to always invoke
bdrv_snapshot_delete() for both cases (ID and tag).  And we should
probably remove the special code path in savevm for overwriting an
existing snapshot.

This would also alleviate the bug in libvirt (because the tag then
always takes precedence, like the interface description suggests).


Sure, this series would fix the bugs as well, but it does more than
that.  It really isn't just a bug fix.

> If we made that:
>=20
> savevm [-t] [-i] [tag|id]
>=20
> then:
>   a) with neither -t or -i  it would behave in the same roulette way
>      as it does in the moment, and it might be a tag or id
>=20
>   b) with -t we'd explicitly treat the parameter as a tag and it
>      would error if it wasn't found
>=20
>   c) With -i we'd explicitly treat the parameter as an id and
>      it would error if it wasn't found
>=20
> Since we still allow (a) it doesn't break any existing code.

I agree with the others that while this might solve issues on the
libvirt side of things, I think we also want to confuse end users less.

Max


--mkWQuXeEFSw9n1uypZiNCjIdavWiRmG9p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4mIYACgkQ9AfbAGHV
z0BcDgf/UeIqbD2CK4D/Dd1MQOZpuTZKwQHc+VZ4SmxFU6Uvze0jmTtRJfPRrtiA
UOy87+LxRrV+hufGLektL4wH9m9i5kb+F/LB1c37clzaeQ7q3zv/M3sitbTg9KID
yqYhPwT9KN3kfvgRwOV8mPYqvpZF7QjUgmamZIaknm9p0Xfn6TY+LVQtcH+VF/Ov
4n3x0B33BwnP/xvd8BugBaBNFhGtN42FUTklt6GSoRJD3BL+A4q/V/7SSQggZDi9
+wcp4sA/aTkTJ6cvr4D4eLIUgN6/hTdxpme2YgyIoeU24y8lS2KeJZbpi586AWVa
5k2sOK63D+LkFHwlUDCFWp3vRvzkzw==
=Rxvn
-----END PGP SIGNATURE-----

--mkWQuXeEFSw9n1uypZiNCjIdavWiRmG9p--
