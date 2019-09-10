Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCD7C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:33:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0ED22081B
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 09:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0ED22081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7cWH-0001l0-FX
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 05:33:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41765)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7cEk-00055Z-RU
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:15:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7cEi-0005Y8-Tq
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 05:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7cEb-0005RS-1o; Tue, 10 Sep 2019 05:14:49 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 45004C058CB8;
 Tue, 10 Sep 2019 09:14:48 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 90F035D6B2;
 Tue, 10 Sep 2019 09:14:46 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
From: Max Reitz <mreitz@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=mreitz@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFXOJlcBCADEyyhOTsoa/2ujoTRAJj4MKA21dkxxELVj3cuILpLTmtachWj7QW+TVG8U
 /PsMCFbpwsQR7oEy8eHHZwuGQsNpEtNC2G/L8Yka0BIBzv7dEgrPzIu+W3anZXQW4702+uES
 U29G8TP/NGfXRRHGlbBIH9KNUnOSUD2vRtpOLXkWsV5CN6vQFYgQfFvmp5ZpPeUe6xNplu8V
 mcTw8OSEDW/ZnxJc8TekCKZSpdzYoxfzjm7xGmZqB18VFwgJZlIibt1HE0EB4w5GsD7x5ekh
 awIe3RwoZgZDLQMdOitJ1tUc8aqaxvgA4tz6J6st8D8pS//m1gAoYJWGwwIVj1DjTYLtABEB
 AAG0HU1heCBSZWl0eiA8bXJlaXR6QHJlZGhhdC5jb20+iQFTBBMBCAA9AhsDBQkSzAMABQsJ
 CAcCBhUICQoLAgQWAgMBAh4BAheABQJVzie5FRhoa3A6Ly9rZXlzLmdudXBnLm5ldAAKCRD0
 B9sAYdXPQDcIB/9uNkbYEex1rHKz3mr12uxYMwLOOFY9fstP5aoVJQ1nWQVB6m2cfKGdcRe1
 2/nFaHSNAzT0NnKz2MjhZVmcrpyd2Gp2QyISCfb1FbT82GMtXFj1wiHmPb3CixYmWGQUUh+I
 AvUqsevLA+WihgBUyaJq/vuDVM1/K9Un+w+Tz5vpeMidlIsTYhcsMhn0L9wlCjoucljvbDy/
 8C9L2DUdgi3XTa0ORKeflUhdL4gucWoAMrKX2nmPjBMKLgU7WLBc8AtV+84b9OWFML6NEyo4
 4cP7cM/07VlJK53pqNg5cHtnWwjHcbpGkQvx6RUx6F1My3y52vM24rNUA3+ligVEgPYBuQEN
 BFXOJlcBCADAmcVUNTWT6yLWQHvxZ0o47KCP8OcLqD+67T0RCe6d0LP8GsWtrJdeDIQk+T+F
 xO7DolQPS6iQ6Ak2/lJaPX8L0BkEAiMuLCKFU6Bn3lFOkrQeKp3u05wCSV1iKnhg0UPji9V2
 W5eNfy8F4ZQHpeGUGy+liGXlxqkeRVhLyevUqfU0WgNqAJpfhHSGpBgihUupmyUg7lfUPeRM
 DzAN1pIqoFuxnN+BRHdAecpsLcbR8sQddXmDg9BpSKozO/JyBmaS1RlquI8HERQoe6EynJhd
 64aICHDfj61rp+/0jTIcevxIIAzW70IadoS/y3DVIkuhncgDBvGbF3aBtjrJVP+5ABEBAAGJ
 ASUEGAEIAA8FAlXOJlcCGwwFCRLMAwAACgkQ9AfbAGHVz0CbFwf9F/PXxQR9i4N0iipISYjU
 sxVdjJOM2TMut+ZZcQ6NSMvhZ0ogQxJ+iEQ5OjnIputKvPVd5U7WRh+4lF1lB/NQGrGZQ1ic
 alkj6ocscQyFwfib+xIe9w8TG1CVGkII7+TbS5pXHRxZH1niaRpoi/hYtgzkuOPp35jJyqT/
 /ELbqQTDAWcqtJhzxKLE/ugcOMK520dJDeb6x2xVES+S5LXby0D4juZlvUj+1fwZu+7Io5+B
 bkhSVPb/QdOVTpnz7zWNyNw+OONo1aBUKkhq2UIByYXgORPFnbfMY7QWHcjpBVw9MgC4tGeF
 R4bv+1nAMMxKmb5VvQCExr0eFhJUAHAhVg==
Message-ID: <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
Date: Tue, 10 Sep 2019 11:14:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909161314.GJ17606@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QlnJPj7Z0zlmwMGTEIY4RF18xvcrh1RRL"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Tue, 10 Sep 2019 09:14:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 04/42] block: Add child access functions
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QlnJPj7Z0zlmwMGTEIY4RF18xvcrh1RRL
Content-Type: multipart/mixed; boundary="Em6WvkXatC8Tc3vfV1g6YA43k9AQozaEL";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <89984d52-881f-a1e4-c14a-2bf05fc789d0@redhat.com>
Subject: Re: [PATCH v6 04/42] block: Add child access functions
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-5-mreitz@redhat.com>
 <20190904161658.GD21246@localhost.localdomain>
 <b1c56a8b-b4e4-c32a-f577-89a5e2da743e@redhat.com>
 <20190909093604.GB13841@localhost.localdomain>
 <38c0ff7e-dfd3-189e-6026-3642d78e5029@redhat.com>
 <20190909161314.GJ17606@localhost.localdomain>
In-Reply-To: <20190909161314.GJ17606@localhost.localdomain>

--Em6WvkXatC8Tc3vfV1g6YA43k9AQozaEL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 18:13, Kevin Wolf wrote:
> Am 09.09.2019 um 16:04 hat Max Reitz geschrieben:
>> On 09.09.19 11:36, Kevin Wolf wrote:
>>> Am 09.09.2019 um 09:56 hat Max Reitz geschrieben:
>>>> On 04.09.19 18:16, Kevin Wolf wrote:
>>>>> Am 09.08.2019 um 18:13 hat Max Reitz geschrieben:
>>>>>> There are BDS children that the general block layer code can acces=
s,
>>>>>> namely bs->file and bs->backing.  Since the introduction of filter=
s and
>>>>>> external data files, their meaning is not quite clear.  bs->backin=
g can
>>>>>> be a COW source, or it can be an R/W-filtered child; bs->file can =
be an
>>>>>> R/W-filtered child, it can be data and metadata storage, or it can=
 be
>>>>>> just metadata storage.
>>>>>>
>>>>>> This overloading really is not helpful.  This patch adds function =
that
>>>>>> retrieve the correct child for each exact purpose.  Later patches =
in
>>>>>> this series will make use of them.  Doing so will allow us to hand=
le
>>>>>> filter nodes and external data files in a meaningful way.
>>>>>>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.co=
m>
>>>>>
>>>>> Each time I look at this patch, I'm confused by the function names.=

>>>>> Maybe I should just ask what the idea there was, or more specifical=
ly:
>>>>> What does the "filtered" in "filtered child" really mean?
>>>>>
>>>>> Apparently any child of a filter node is "filtered" (which makes se=
nse),
>>>>
>>>> It isn=E2=80=99t, filters can have non-filter children.  For example=
, backup-top
>>>> could have the source as a filtered child and the target as a non-fi=
lter
>>>> child.
>>>
>>> Hm, okay, makes sense. I had a definition in mind that says that filt=
er
>>> nodes only have a single child node. Is it that a filter may have onl=
y a
>>> single _filtered_ child node?
>>
>> Well, there=E2=80=99s Quorum...
>=20
> Ah, nice, quorum sets is_filter =3D true even though it neither fulfull=
s
> the conditions for it before this series, nor the changed conditions
> after this series.
>=20
> So either quorum lies and isn't actually a filter driver, or our
> definition in the documentation of is_filter is wrong.

You could say it lies because in FIFO mode it clearly isn=E2=80=99t a fil=
ter for
all of its children.

There is a reason for lying, though, which is
bdrv_recurse_is_first_non_filter(), which is necessary to use the whole
to_replace mirror stuff.

(You mirror from a quorum with a failed child and then replace the
failed child.  mirror needs to ensure that there are only R/W filters
between the child and the mirror source so that replacing it will not
suddenly change any visible data.  Which is actually a lie for quorum,
because the child is clearly broken and thus precisely doesn=E2=80=99t sh=
ow the
same data...)

Maybe we should stop declaring Quorum a filter and then rename the
bdrv_recurse_is_first_non_filter() to, I don=E2=80=99t know,
bdrv_recurse_can_be_replaced_by_mirror()?

>>>>> but also bs->backing of a qcow2 image, while bs->file of qcow2 isn'=
t.
>>>>> raw doesn't have any "filtered" child. What's the system behind thi=
s?
>>>>
>>>> =E2=80=9Cfiltered=E2=80=9D means: If the parent node returns data fr=
om this child, it
>>>> won=E2=80=99t modify it, neither its content nor its position.  COW =
and R/W
>>>> filters differ in how they handle writes; R/W filters pass them thro=
ugh
>>>> to the filtered child, COW filters copy them off to some other child=

>>>> node (and then the filtered child=E2=80=99s data will no longer be v=
isible at
>>>> that location).
>>>
>>> But there is no reason why a node couldn't fulfill this condition for=

>>> more than one child node. bdrv_filtered_child() isn't well-defined th=
en.
>>> Technically, the description "Return any filtered child" is correct
>>> because "any" can be interpreted as "an arbitrary", but obviously tha=
t
>>> makes the function useless.
>>
>> Which is why it currently returns NULL for Quorum.
>=20
> Which is about the only possible choice that breaks the contract...
>=20
>  * Return any filtered child, independently of how it reacts to write

I don=E2=80=99t know if you=E2=80=99re serious about this proposition, be=
cause I don=E2=80=99t
know whether that could be useful in any way. :-?

>  * accesses and whether data is copied onto this BDS through COR.

I meant the contract as =E2=80=9CReturn the single filtered child there i=
s, or NULL=E2=80=9D

> Maybe the documentation of bdrv_filtered_child() needs to be rephrased?=

>=20
> Going back to qcow2, it's really not much different as it has multiple
> (two) filtered children, too.

Well, it doesn=E2=80=99t.  It isn=E2=80=99t an R/W filter.

Maybe what we actually need to rephrase is the definition of .is_filter.
 (Namely something along the lines of =E2=80=9CFulfills these guarantees =
(same
data, etc. pp.), *and* should be skipped for allocation information
queries etc.=E2=80=9D.

> So if quorum returns NULL to mean "no
> unambiguous result", why does it return bs->backing instead of NULL for=

> a qcow2 node?
>=20
> (Yes, I know, because it's useful. But I'm trying to get some basic
> consistency into these interfaces.)

Not precisely because it=E2=80=99s useful, but because qcow2 does not hav=
e
=2Eis_filter set.  :-)
(And it doesn=E2=80=99t have it set because that wouldn=E2=80=99t be usef=
ul.)

>>> Specficially, according to your definition, qcow2 filters both the
>>> backing file (COW filter) and the external data file (R/W filter).
>>
>> Not wrong.  But the same question as for raw arises: Is there any use =
to
>> declaring qcow2 an R/W filter driver just because it fits the definiti=
on?
>=20
> Wait, where is there even a place where this could be declared?
>=20
> The once thing I see that a driver even can declare is drv->is_filter,
> which is about the whole driver and not about nodes. It is false for
> qcow2.

That=E2=80=99s correct.  But that=E2=80=99s not a fundamental problem, of=
 course, we
could make it a per-BDS attribute if that made sense.

> Then you made some criteria above that tell us whether a specific child=

> of a node is a filtered child or not. As it happens, qcow2 (which is no=
t
> a filter driver) can have two children that match the criteria for bein=
g
> filtered children.

But just arguing that I=E2=80=99m incapable of giving a good definition w=
on=E2=80=99t
bring us along.

> I already think this is a bit inconsistent, because why should a driver=

> that declares itself a non-filter be considered to filter children?

=2Eis_filter is for R/W filters.  COW filters have .supports_backing for =
that.

> Okay, you say a broader definition of a filtered child is useful becaus=
e
> you can then include all BdrvChild links in a backing/filter chain. Fai=
r
> enough, it's not intuitive, but use a broader definition then.
>=20
> But the point where you say that even though two of the children
> are filtered children under your broader definition, for the purpose of=

> the API only one of them should be considered because the other one
> isn't that useful, that's really one inconsistency too much for me. You=

> can't use a broad definition and then arbitrarily restrict the
> definition again so that it matches the special case you're currently
> interested in.
>=20
> Either use a narrow definition, or use a broad one. But use only one an=
d
> use it consistently.

I think the problem appears because you restrict the process to a single
step where there=E2=80=99s actually two.

Drivers can be either
(1) R/W filters (e.g. throttle)
(2) COW filters (e.g. qcow2)
(3) None of the above (e.g. vhdx, curl)

This choice is made on the driver level, not on the node level (for good
reason, see below*).

And then we derive the node=E2=80=99s filtered children from what the dri=
ver is.
 If it=E2=80=99s an R/W filter, bdrv_filtered_child() will return the R/W=

filtered child.  If it=E2=80=99s a COW filter, bdrv_filtered_child() will=
 return
the potentially existing COW backing child (or NULL, if there is no
backing child).


*
What is clear to me is that it isn=E2=80=99t useful to treat nodes of a s=
pecific
driver sometimes as R/W filter nodes and sometimes not.  R/W filter
nodes are handled differently from other nodes, and it would be
confusing if a certain driver sometimes behaves this and sometimes that
way.  (For example, if you put a raw node on top of a qcow2 node,
sometimes it would stop the backing chain, sometimes it wouldn=E2=80=99t.=
  That
makes no sense to me.)

OTOH, for COW filters, we do exactly that.  Sometimes they have a
backing file, sometimes they don=E2=80=99t.  That=E2=80=99s completely fi=
ne because
their overall behavior doesn=E2=80=99t change.


That makes me agree that there is indeed too much of a difference
between R/W filters and COW filters to lump them together under the
=E2=80=9Cfilter=E2=80=9D label.

[...]

> My point is not about changing the logic in the code, but about using
> names that actually describe accurately what the logic does.

Again, naming things is hard.

[...]

>> You disagreeing with me on these terms to me shows that there is a nee=
d
>> to formalize.  This is precisely what I want to do in this series.
>>
>> The fact that we don=E2=80=99t use the term =E2=80=9Cfilter chain=E2=80=
=9D so far is the reason
>> why I introduce it.  Because it comes as a clean slate.  =E2=80=9Cback=
ing chain=E2=80=9D
>> already means something to me, and it means something different.
>=20
> Well, if "backing chain" is too narrow, "filter chain" is both too
> unspecific and inconsistent with the various definitions of "filter" an=
d
> "filtered" we're using, and we can't think of anything more concise, we=

> might have to use names that just mention both.
>=20
> bdrv_cow_child() // don't call COW a filter, because .is_filter =3D fal=
se
> bdrv_filter_child() // your R/W filter, only for .is_filter =3D true no=
des
> bdrv_filter_or_cow_child()
>=20
> Or something like that. This would bring some more consistency into the=

> way we use the words filter/filtered at least.

I=E2=80=99ll see how that looks overall, but why not.  Sounds good to me.=


Max


--Em6WvkXatC8Tc3vfV1g6YA43k9AQozaEL--

--QlnJPj7Z0zlmwMGTEIY4RF18xvcrh1RRL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13aYQACgkQ9AfbAGHV
z0CPRAf/arc6PD1ofxvn4lpMfTCTfezmrycmEsbEQTZqn8+0+OhzATFdnlGXGMen
SaO9X+uS0n1aFPWHMrKFWsY5n0MKs8uoSKAVTQnAXquUSTUr112oXLMnc7a8g+/e
buiHanUUQ2Stix5mW95cVl/BR+jy3iQ0DT+JN5Y+CfMLZgHE6oE/8FexN8G/hD6p
fr8g8B55dM9pxWl9UeSQn/YpBiApiYcf5L5it0hPAA48GxIXxkgcgcJgX8PLsHgI
JCzyTAv/4ejd3OQ6ij49DUIMl4s/hxWq7yIUs70w8hhbPwIKtYyvY3dxMa2/kXLv
ZxA8ko7V8dI57rI79N5ggsGAw+psJg==
=TYd0
-----END PGP SIGNATURE-----

--QlnJPj7Z0zlmwMGTEIY4RF18xvcrh1RRL--

