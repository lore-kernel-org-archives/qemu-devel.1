Received: from eggs.gnu.org ([2001:4830:134:3::10]:43000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJaE-0005qQ-IK
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:24:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eNJaD-0001YS-CF
	for qemu-devel@nongnu.org; Fri, 08 Dec 2017 09:24:58 -0500
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
	<01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
	<cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
	<8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
	<40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
	<4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
	<20171121172324.GC11073@localhost.localdomain>
	<1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
	<20171207115648.5mnvoyfnig7dhgbn@eukaryote>
	<a172b331-77c7-f7bb-5bd1-2e59f0fdcde4@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ebc88d65-c44a-92dd-0a38-0d3016c8fd01@redhat.com>
Date: Fri, 8 Dec 2017 15:24:34 +0100
MIME-Version: 1.0
In-Reply-To: <a172b331-77c7-f7bb-5bd1-2e59f0fdcde4@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="eFgrd8JUwAU8L7f8tCU25xBLcmIPGiqRo"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.12 0/4] qmp dirty bitmap
 API
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, mnestratov@virtuozzo.com, armbru@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eFgrd8JUwAU8L7f8tCU25xBLcmIPGiqRo
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, famz@redhat.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org, mnestratov@virtuozzo.com,
 armbru@redhat.com, nshirokovskiy@virtuozzo.com, stefanha@redhat.com,
 pbonzini@redhat.com, den@openvz.org
Message-ID: <ebc88d65-c44a-92dd-0a38-0d3016c8fd01@redhat.com>
Subject: Re: [Qemu-block] [Qemu-devel] [PATCH for-2.12 0/4] qmp dirty bitmap
 API
References: <20171113162053.58795-1-vsementsov@virtuozzo.com>
 <01108daa-fed3-c142-bbd6-0ecc4c8b795d@redhat.com>
 <cd0a2e5e-f788-0e5a-dec7-f428479f3b89@virtuozzo.com>
 <8c61f43c-5f56-8c1b-a2fe-f954d34dc687@redhat.com>
 <40392ab9-ec2a-30ed-ddab-a557682a4192@virtuozzo.com>
 <4e4e28d7-aebc-4a86-e691-99afdcca27f5@redhat.com>
 <20171121172324.GC11073@localhost.localdomain>
 <1a8e9d48-5be1-e014-41ee-a1164f32dd17@redhat.com>
 <20171207115648.5mnvoyfnig7dhgbn@eukaryote>
 <a172b331-77c7-f7bb-5bd1-2e59f0fdcde4@redhat.com>
In-Reply-To: <a172b331-77c7-f7bb-5bd1-2e59f0fdcde4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-12-07 23:47, John Snow wrote:
>=20
>=20
> On 12/07/2017 06:56 AM, Kashyap Chamarthy wrote:
>> On Tue, Nov 21, 2017 at 07:10:19PM -0500, John Snow wrote:
>>> On 11/21/2017 12:23 PM, Kevin Wolf wrote:
>>
>> [...] # Snip lot of good discussion.
>>
>>>> On another note, I would double check before adding a new block job =
type
>>>> that this is the right way to go. We have recently noticed that many=
, if
>>>> not all, of the existing block jobs (at least mirror, commit and bac=
kup)
>>>> are so similar that they implement the same things multiple times an=
d
>>>> are just lacking different options and have different bugs. I'm
>>>> seriously considering merging all of them into a single job type
>>>> internally that just provides options that effectively turn it into =
one
>>>> of the existing job types.
>>>>
>>>
>>> I'm not particularly opposed. At the very, very least "backup" and
>>> "mirror" are pretty much the same thing and "stream" and "commit" are=

>>> basically the same.
>>>
>>> Forcing the backuppy-job and the consolidatey-job together seems like=
 an
>>> ever-so-slightly harder case to make, but I suppose the truth of the
>>> matter in all cases is that we're copying data from one node to anoth=
er...
>>
>> So from the above interesting discussion, it seems like Kevin is leani=
ng
>> towards a single job type that offers 'stream', 'commit', 'backup', an=
d
>> 'mirror' functionality as part of a single command / job type.  Based =
on
>> an instinct, this sounds a bit too stuffy and complex to me.
>>
>> And John seems to be leaning towards two block device job types:
>>
>>   - 'blockdev-foo' that offers both current 'stream' and 'commit'
>>     functionality as two different options to the same QMP command; an=
d
>>
>>   - 'blockdev-bar' will offer both 'mirror' and 'backup' functionality=

>>     as part of the same QMP command
>>
>> FWIW, this seems a bit more palatable, as it is unifying
>> similar-functionality-that-differ-slightly into two distinct commands.=

>>
>> (/me is still wrapping his head around the bitmaps and incremental
>> backups infrastructure.)
>>
>=20
> The discussion you're honing in on is tangential to the one at the hear=
t
> of this topic, which is:
>=20
> "What's the right API for pull model incremental backups?" which digs u=
p
> the question "What is the right API for our existing data copying comma=
nds?"
>=20
> Kevin is probably right in the end, though; he usually is. We do need t=
o
> unify our data moving logic to avoid fixing the same bugs in four
> different but nearly identical jobs.
>=20
> My only concern is that the special casing will grow too complex for
> that one unified job and the job will become so complicated nobody know=
s
> how to work on it anymore without breaking other cases. Maybe this is a=

> reasonable concern, maybe it isn't.

The thing is that mirror is becoming more complicated anyway.  For one
thing, we already do commits through it and I don't see why intermediate
commits shouldn't just work the same way (the only thing is that we
would have to automatically complete the job instead of emitting a ready
event).

The other lies in the active mirror thingy.  If we have active mirror,
then we should be able to implement backup pretty easily, too.  We just
need to copy the old data to the target instead of the new one (I think).=


So the thing is that commit and backup are going to be pretty much
included in mirror for free by accident.  There is no real reason to
have own code for them, then.

Max


--eFgrd8JUwAU8L7f8tCU25xBLcmIPGiqRo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloqoKISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnjAH/31I2VWVLLoiRmygYDtKQoEFQBJzm3dx
wrsQA7lh4fnGKBsHjzCFguq3P21vREcpEnMxVhDT5d/StPkswozSU222lstLOYWr
3qLYtZpuj+ywAE7h479oFhuEaW+vPLlzTuqcaVB2ZNddmgju2NTZQB69xh/2xOSy
h5iJVHBMANyat0cp1qPjwEZBecRuPXlEzj8YB5ZT66i4AQu9XRa2c2vpos0k0f3S
6pUguVyFcc3fbDiG/2dQQpGJNhEk23zyrWQoLK+PWCYJ1bHyEp7fw9EFWZF5euA3
VKAtt0oVWPVZEJcvSXldmibcRcSAZqg4LYPPif9SuQsRVL2kZRcZbBI=
=hCjo
-----END PGP SIGNATURE-----

--eFgrd8JUwAU8L7f8tCU25xBLcmIPGiqRo--
