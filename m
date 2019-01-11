Received: from eggs.gnu.org ([209.51.188.92]:34870)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghyev-0002Bg-Ue
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:23:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ghyeu-0004jG-Mt
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:23:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40610)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1ghyeu-0004ip-Cv
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 10:23:44 -0500
References: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
	<200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
	<20190109172023.GK4867@localhost.localdomain>
	<be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
	<40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
	<20190109185154.GL4867@localhost.localdomain>
	<56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
	<20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
	<dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
	<20190111143321.GJ5010@dhcp-200-186.str.redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7121a080-e231-ee04-b17d-d9cd032810b1@redhat.com>
Date: Fri, 11 Jan 2019 16:23:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190111143321.GJ5010@dhcp-200-186.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="AvAhslaRUnQwOFx6e0FyZxN2weGEaQDQn"
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
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, armbru@redhat.com, Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org, muriloo@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AvAhslaRUnQwOFx6e0FyZxN2weGEaQDQn
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Eric Blake <eblake@redhat.com>, armbru@redhat.com,
 Daniel Henrique Barboza <danielhb413@gmail.com>, qemu-devel@nongnu.org,
 muriloo@linux.ibm.com
Message-ID: <7121a080-e231-ee04-b17d-d9cd032810b1@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/3] HMP/snapshot changes - do not use ID
 anymore
References: <a030d899-5a1a-b8b9-4c59-cca4bc304c1d@gmail.com>
 <200ecea3-1ef4-3ecf-6b37-f6e45fef3849@redhat.com>
 <20190109172023.GK4867@localhost.localdomain>
 <be8ac551-4cfd-db62-aa3d-0ca9b79e3e4f@redhat.com>
 <40ef0a8d-3a25-4cc3-95f8-82bc4513776c@redhat.com>
 <20190109185154.GL4867@localhost.localdomain>
 <56880d06-a214-2486-2e80-c565b33461b3@redhat.com>
 <20190110112508.GA6361@linux.fritz.box> <20190110114113.GC2589@work-vm>
 <dedb5829-439e-0d2f-2467-094de70b9938@redhat.com>
 <20190111143321.GJ5010@dhcp-200-186.str.redhat.com>
In-Reply-To: <20190111143321.GJ5010@dhcp-200-186.str.redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 11.01.19 15:33, Kevin Wolf wrote:
> Am 11.01.2019 um 14:22 hat Max Reitz geschrieben:
>> On 10.01.19 12:41, Dr. David Alan Gilbert wrote:
>>> * Kevin Wolf (kwolf@redhat.com) wrote:
>>>> Am 09.01.2019 um 20:02 hat Eric Blake geschrieben:
>>>>> On 1/9/19 12:51 PM, Kevin Wolf wrote:
>>>>>
>>>>>>> Indeed, and libvirt IS using 'savevm' via HMP via QMP's
>>>>>>> human-monitor-command, since there is no QMP counterpart for inte=
rnal
>>>>>>> snapshot.  Even though lately we consistently tell people that in=
ternal
>>>>>>> snapshots are underdeveloped and you should use external snapshot=
s, it
>>>>>>> does not get away from the fact that libvirt has been using 'save=
vm' to
>>>>>>> drive internal snapshots for years now, and that we MUST consider=

>>>>>>> back-compat and/or add an introspectible QMP interface before mak=
ing
>>>>>>> changes that would break libvirt.
>>>>>>
>>>>>> Okay, so what does libvirt do when you request a snapshot with a
>>>>>> numerical name? Without having looked at the code, the best case I=
 would
>>>>>> expect that it forbids them, and more realistically I suspect that=
 we
>>>>>> may actually fix a bug for libvirt by changing the semantics.
>>>>>>
>>>>>> Or does libvirt really use snapshot IDs rather than names?
>>>>>
>>>>> At the moment, libvirt does not place any restriction on internal
>>>>> snapshot names, but passes the user's name through without thought =
of
>>>>> whether it is an id or a name.
>>>>>
>>>>> So yes, arguably tightening the semantics fixes a libvirt bug for
>>>>> libvirt having allowed internal snapshots to get into an inconsiste=
nt
>>>>> state.
>>>>
>>>> So there are two scenarios to consider with respect to breaking
>>>> backwards compatibility:
>>>>
>>>> 1. There may be code out there that relies on numeric arguments bein=
g
>>>>    interpreted as IDs. This code will break if we make this change a=
nd
>>>>    numeric snapshot names exist. That such code exists is speculatio=
n
>>>>    (even though plausible) and we don't know how widespread it is.
>>>>
>>>> 2. There may be code out there that blindly assumes that whatever it=

>>>>    passes is interpreted as a name. Nobody considered that with a
>>>>    numeric snapshot name, it maybe misinterpreted as an ID. We know =
that
>>>>    this is true for libvirt, the single most used management tool fo=
r
>>>>    QEMU. More code like this may (and probably does) exist.
>>>>
>>>> Essentially the same two categories exist for human users: those who=

>>>> somehow found out that QEMU accepts IDs as monitor command arguments=
 and
>>>> are using those (mitigated by not displaying IDs any more), and thos=
e
>>>> who are trapped because they wanted to access a numeric name, but
>>>> surprisingly got it interpreted as an ID. Both are speculation to so=
me
>>>> degree, but my guess is that the latter group is larger.
>>>>
>>>> Given all this, this is a no-brainer for me. We simplify the interfa=
ce,
>>>> we simplify the code, we make things less confusing for manual users=
 and
>>>> we fix the management tool that everybody uses. How could we not mak=
e
>>>> this change?
>>
>> So you're trying to make a bug fix out of this now to get around
>> deprecation?  To me, changing behavior in qemu to fix a bug in libvirt=

>> doesn't equate to fixing a bug in qemu.  So let's try to find a real b=
ug
>> in qemu.
>=20
> I'm not making this a bug fix, but a interface cleanup that fixes a bug=


which is not in qemu (at least the one you're describing)

> as a side effect, which makes it only more appealing. I'm also not sure=

> what exactly you mean by "get around deprecation".
>=20
> If you mean the formal two releases deprecation period that is required=

> by our deprecation policy, it doesn't apply because this is HMP and not=

> a stable interface.

Of course you're right, formally.  But that's just not a very good
argument to me, personally.  If deprecation is easy and helpful, there
is no reason to be nasty and skip it just because we are formally
allowed to do so.

Sure, the question is whether it is helpful.

> If you mean deprecation not because we must but because we're
> considering actual users, then I have described how making the change
> fixes things for more users than it could potentially break things

OK.

> In
> addition, I pointed out how a deprecation period is useless for
> user-facing changes.

You pointed that out for users of specific distros.  I myself use Fedora
(every release) and Arch, so as a user I do see all qemu versions.

> I'm concluding that a "voluntary" deprecation for
> two releases isn't helpful at all.

Yes, you can conclude that from your reasoning.  But I disagree with
your reasoning because you are only considering users such as yourself
who skip releases on purpose or users who use long-term distros.  Most
importantly we probably have professional end users that do update qemu
every release because they know the deprecation policy, who do not use
libvirt.

I agree that adding a warning has little impact.  But I also claim that
doing it is little effort.

I mean, whatever.  I'm really not that much against taking the series as-=
is.

>>>>> But again, it falls in the category of "properly fixing this
>>>>> requires a lot of auditing, time, mental power, and unit tests", wh=
ich
>>>>> makes it a rather daunting task to state for certain.
>>>>
>>>> Fix the world before we can fix anything?
>>>
>>> Can't we break this loop for the savevm command fairly easily; it's
>>> currently documnted as:
>>>
>>> savevm [tag|id]
>>
>> The bug starts here.
>> [... snipped long description of how horrible everything is ...]
>=20
> Yes, it's horrible. Let's radically simplify the interface (and with it=

> the code) by throwing away the useless ID stuff. Which happens to be
> exactly what this series was getting at.
>=20
> There is no point in spending time for changing the current interface t=
o
> make a little more sense while keeping its fundamental insanity
> unaddressed, then deprecate it, and then change it again to _actually_
> make sense. Let's convert it directly to something that makes sense.

Of course we'd do the deprecation while fixing the bug. :-P

>> So, yes, there are bugs in qemu, but to fix them, we would need to
>> switch the comparison order in bdrv_snapshot_find() and fix
>> bdrv_snapshot_delete_by_id_or_name() to always invoke
>> bdrv_snapshot_delete() for both cases (ID and tag).  And we should
>> probably remove the special code path in savevm for overwriting an
>> existing snapshot.
>>
>> This would also alleviate the bug in libvirt (because the tag then
>> always takes precedence, like the interface description suggests).
>=20
> Yes, at least tools which don't use IDs wouldn't be broken any more. Bu=
t
> you removed none of the insanity. The same way addressing by tag was
> broken before, addressing by ID is broken now (previously, you need to
> check first that no ID exists while you want to address a tag; now, you=

> need to check first that no tag exists while you want to address an ID)=
=2E
>=20
> In fact, if you're willing to go there, you break exactly the same user=
s
> that would be broken if we dropped IDs from the interface completely. S=
o
> why not do the full thing instead of stopping halfway? You're taking th=
e
> potential problems without the advantages you could get.

Not quite true.  What I proposed here would still allow addressing
snapshots by ID.  This series completely removes that.

I only break things for users where the tag conflicts with the ID.

>> Sure, this series would fix the bugs as well, but it does more than
>> that.  It really isn't just a bug fix.
>=20
> It was never meant to be a bug fix (unless, of course, you consider
> insane interfaces a bug). But that it fixes a bug as a side effect
> contributes to the fact that breaking compatibility has not only
> downsides and that a deprecation period would be useless or even
> counterproductive.

Sure, for this case, probably.

Max


--AvAhslaRUnQwOFx6e0FyZxN2weGEaQDQn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlw4tPoACgkQ9AfbAGHV
z0Cykgf+L9YHlhMY9epe8WpF/2inSURofhAaCggtY5AVXin2N4oMzhyvETGHcRBl
q/mHPfvxF+uds/NO5dnkxbfxUWAr5C5D1UjTlrAz5q4IMMRDQ4lA8fE0iuB1yJ54
riABoQItzR8sWMFMiTDogHRSlOQPwJKkPM39LQsI7/ziYbdv1VnC15/AW3Xiep3J
1QnKjvf20rf8LTE6ROC/xNvh3hyUjqiPli3JdsbEqIGOmjup7zdfbpTuF4Gd0WnO
B1ZjsG2uTWCZ+aDwqPQfnWQLq9SFyQPBGWMHLnYwyz9Gnoh/K0bIdy6ZYUUfkfsX
1yPo95F5pMBfNhCsyR5bg0AQbxGRZg==
=tRiu
-----END PGP SIGNATURE-----

--AvAhslaRUnQwOFx6e0FyZxN2weGEaQDQn--
