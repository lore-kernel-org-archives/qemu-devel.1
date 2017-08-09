Received: from eggs.gnu.org ([2001:4830:134:3::10]:37133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRGH-0005JP-8T
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <el13635@mail.ntua.gr>) id 1dfRGG-0002Bw-4h
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 09:43:01 -0400
Date: Wed, 9 Aug 2017 16:42:07 +0300
From: Manos Pitsidianakis <el13635@mail.ntua.gr>
Message-ID: <20170809134205.dbkx5cuvjpbaxftv@postretch>
References: <20170731095443.28211-1-el13635@mail.ntua.gr>
	<20170731095443.28211-6-el13635@mail.ntua.gr>
	<w51valyjj7j.fsf@maestria.local.igalia.com>
	<20170808134544.paekftiounmirhbo@postretch>
	<w51poc6jeln.fsf@maestria.local.igalia.com>
	<20170808145620.wlb5rdutuseutclx@postretch>
	<w51mv7aje27.fsf@maestria.local.igalia.com>
	<20170809093612.oee2u5kdgyojheqm@postretch>
	<w51y3qslxyz.fsf@maestria.local.igalia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nlkvm72nbewpz4m4"
Content-Disposition: inline
In-Reply-To: <w51y3qslxyz.fsf@maestria.local.igalia.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/7] block: add throttle block filter
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block <qemu-block@nongnu.org>


--nlkvm72nbewpz4m4
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 09, 2017 at 02:36:20PM +0200, Alberto Garcia wrote:
>On Wed 09 Aug 2017 11:36:12 AM CEST, Manos Pitsidianakis wrote:
>> On Tue, Aug 08, 2017 at 05:04:48PM +0200, Alberto Garcia wrote:
>>>On Tue 08 Aug 2017 04:56:20 PM CEST, Manos Pitsidianakis wrote:
>>>>>> So basically if we have anonymous groups, we accept limits in the
>>>>>> driver options but only without a group-name.
>>>>>
>>>>>In the commit message you do however have limits and a group name, is
>>>>>that a mistake?
>>>>>
>>>>>    -drive driver=3Dthrottle,file.filename=3Dfoo.qcow2, \
>>>>>           limits.iops-total=3D...,throttle-group=3Dbar
>>>>
>>>> Sorry this wasn't clear, I'm actually proposing to remove limits from
>>>> the throttle driver options and only create/config throttle groups via
>>>> -object/object-add.
>>>
>>>Sorry I think it was me who misunderstood :-) Anyway in the new
>>>command-line API I would be more inclined to have limits defined using
>>>"-object throttle-group" and -drive would only reference the group id.
>>>
>>>I understand that this implies that it wouldn't be possible to create
>>>anonymous groups (at least not from the command line), is that a
>>>problem?
>>
>> We can accept anonymous groups if a user specifies limits but not a
>> group name in the throttle driver. (The only case where limits would
>> be acccepted)
>
>Yeah but that's only if we have the limits.iops-total=3D... options in the
>throttle driver. If we "remove limits from the throttle driver options
>and only create/config throttle groups via -object/object-add" we=20
>cannot
>do that.

We can check that groups is not defined at the same time as limits,
>
>> Not creating eponymous throttle groups via the throttle driver means
>> we don't need throttle_groups anymore, since even anonymous ones don't
>> need to be accounted for in a list.
>
>I don't follow you here, how else do you get a group by its name?

If all eponymous groups are managed by the QOM tree, we should be able=20
to iterate over the object root container for all ThrottleGroups just=20
like qmp_query_iothreads() in iothread.c

--nlkvm72nbewpz4m4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEvy2VxhCrsoeMN1aIc2J8L2kN9xAFAlmLES0ACgkQc2J8L2kN
9xBnrxAA1Kg7M7de56Mx370fhsR5JXih2x4J7fntbzFsnadQ0P+emHJ73+CNnco9
p9aISGHrVYWb/sNBjZ8OdLSz/NGlb7J1EBDxt3/SquD0Ig+30EqSowelKfZ0Rogp
eKKRDlpryH11CqQyN/0YzWFfqtHmtK1Ox4VGsnOyk2kRiwnXi8GW74nH8XpepNV7
5AyYX4E71LVeJusU/GED/9ZgXYNHA7YmVxYqA8evxNYpnuc3NILhqa836iJg61xS
E7qMIx+++0gD4LzbucbHFwfoTkXyJHzuc62feU96KrhEHSQWvF4C2O6YQl4L+R84
xzNFO97sKqeajDy70FRuCD2J5WMhkykYtcqOWw9ugtcjtIAPOfbosB5BgtNtYC6o
do/KS6n6lTP7X2wejHWUBFQ/UcH3QGZvma483PnGjCJIc4GrDeFZ0ebQw6pZUd0M
yn/lRVJD62jYcJcFHBZ+JLOWALkIzI1yJsR0GmwlTqHxZr/gu0lAz2MYvuW2FysN
WNamC6Yw3WaZGJgR8Beu07Uwyd505nn+Qw1SuQmnmwNf2G+hjnsajZGL991OreWl
jKeeWCUoL+tiQaFv7D2cgslBqkXuz5B63sscpy+GtsxEgLelLJm2nDtJatJCXaoV
qkEMWBkhpDEGi75y2NsEzHkE+T1TADFv+I5+PjsaVen6stbTs8k=
=geRZ
-----END PGP SIGNATURE-----

--nlkvm72nbewpz4m4--
