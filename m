Return-Path: <SRS0=R1m8=X3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1135C352AA
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:37:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9003421A4C
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2019 12:37:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9003421A4C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFdtA-00082A-NF
	for qemu-devel@archiver.kernel.org; Wed, 02 Oct 2019 08:37:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46887)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iFdrm-00070M-T5
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iFdrl-0006fh-F5
 for qemu-devel@nongnu.org; Wed, 02 Oct 2019 08:36:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:18482)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iFdrh-0006dR-Lv; Wed, 02 Oct 2019 08:36:21 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 92894305AB7A;
 Wed,  2 Oct 2019 12:36:20 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.69])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 08F135C226;
 Wed,  2 Oct 2019 12:36:18 +0000 (UTC)
Subject: Re: [PATCH 15/22] mirror: Prevent loops
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190920152804.12875-1-mreitz@redhat.com>
 <20190920152804.12875-16-mreitz@redhat.com>
 <99247c12-cb75-7a22-69c8-7eeed019ad61@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <abf63160-3766-de27-bc05-72f695d05bae@redhat.com>
Date: Wed, 2 Oct 2019 14:36:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <99247c12-cb75-7a22-69c8-7eeed019ad61@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="w1FEhHJYl8fCndJDAteFS6sbi6oRtm7Zm"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.46]); Wed, 02 Oct 2019 12:36:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--w1FEhHJYl8fCndJDAteFS6sbi6oRtm7Zm
Content-Type: multipart/mixed; boundary="SaZUPJ92E5YRYaR0fupv7jE2QuxyPn95Q"

--SaZUPJ92E5YRYaR0fupv7jE2QuxyPn95Q
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.09.19 15:08, Vladimir Sementsov-Ogievskiy wrote:
> 20.09.2019 18:27, Max Reitz wrote:
>> While bdrv_replace_node() will not follow through with it, a specific
>> @replaces asks the mirror job to create a loop.
>>
>> For example, say both the source and the target share a child where th=
e
>> source is a filter; by letting @replaces point to the common child, yo=
u
>> ask for a loop.
>=20
>=20
> source[filter]
>    |
>    v
> child  <----- target
>=20
> and we want target to be a child if itself. OK, it's a loop.
>=20
>>
>> Or if you use @replaces in drive-mirror with sync=3Dnone and
>> mode=3Dabsolute-paths, you generally ask for a loop (@replaces must po=
int
>> to a child of the source, and sync=3Dnone makes the source the backing=

>> file of the target after the job).
>>
>> bdrv_replace_node() will not create those loops, but it by doing so, i=
t
>=20
> s/but it/but ?

Yep.

>> ignores the user-requested configuration, which is not ideally either.=

>> (In the first example above, the target's child will remain what it wa=
s,
>> which may still be reasonable.  But in the second example, the target
>> will just not become a child of the source, which is precisely what wa=
s
>> requested with @replaces.)
>=20
> so you say that second example is bad [1]
>=20
>>
>> So prevent such configurations, both before the job, and before it
>> actually completes.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   include/block/block_int.h |  3 +++
>>   block.c                   | 30 ++++++++++++++++++++++++
>>   block/mirror.c            | 19 +++++++++++++++-
>>   blockdev.c                | 48 +++++++++++++++++++++++++++++++++++++=
+-
>>   4 files changed, 98 insertions(+), 2 deletions(-)
>>
>> diff --git a/include/block/block_int.h b/include/block/block_int.h
>> index 70f26530c9..8a26a0d88a 100644
>> --- a/include/block/block_int.h
>> +++ b/include/block/block_int.h
>> @@ -1256,6 +1256,9 @@ void bdrv_format_default_perms(BlockDriverState =
*bs, BdrvChild *c,
>>   bool bdrv_recurse_can_replace(BlockDriverState *bs,
>>                                 BlockDriverState *to_replace);
>>  =20
>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *pare=
nt,
>> +                      int min_level);
>> +
>>   /*
>>    * Default implementation for drivers to pass bdrv_co_block_status()=
 to
>>    * their file.
>> diff --git a/block.c b/block.c
>> index 0d9b3de98f..332191fb47 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -6260,6 +6260,36 @@ out:
>>       return to_replace_bs;
>>   }
>>  =20
>> +/*
>> + * Return true iff @child is a (recursive) child of @parent, with at
>> + * least @min_level edges between them.
>> + *
>> + * (If @min_level =3D=3D 0, return true if @child =3D=3D @parent.  Fo=
r
>> + * @min_level =3D=3D 1, @child needs to be at least a real child; for=

>> + * @min_level =3D=3D 2, it needs to be at least a grand-child; and so=
 on.)
>> + */
>> +bool bdrv_is_child_of(BlockDriverState *child, BlockDriverState *pare=
nt,
>> +                      int min_level)
>> +{
>> +    BdrvChild *c;
>> +
>> +    if (child =3D=3D parent && min_level <=3D 0) {
>> +        return true;
>> +    }
>> +
>> +    if (!parent) {
>> +        return false;
>> +    }
>> +
>> +    QLIST_FOREACH(c, &parent->children, next) {
>> +        if (bdrv_is_child_of(child, c->bs, min_level - 1)) {
>> +            return true;
>> +        }
>> +    }
>> +
>> +    return false;
>> +}
>> +
>>   /**
>>    * Iterates through the list of runtime option keys that are said to=

>>    * be "strong" for a BDS.  An option is called "strong" if it change=
s
>> diff --git a/block/mirror.c b/block/mirror.c
>> index d877637e1e..f30a6933d8 100644
>> --- a/block/mirror.c
>> +++ b/block/mirror.c
>> @@ -701,7 +701,24 @@ static int mirror_exit_common(Job *job)
>>            * there.
>>            */
>>           if (bdrv_recurse_can_replace(src, to_replace)) {
>> -            bdrv_replace_node(to_replace, target_bs, &local_err);
>> +            /*
>> +             * It is OK for @to_replace to be an immediate child of
>> +             * @target_bs, because that is what happens with
>> +             * drive-mirror sync=3Dnone mode=3Dabsolute-paths: target=
_bs's
>> +             * backing file will be the source node, which is also
>> +             * to_replace (by default).
>> +             * bdrv_replace_node() handles this case by not letting
>> +             * target_bs->backing point to itself, but to the source
>> +             * still.
>=20
> but here you said [1] is good

Well.  Not quite.

In [1] I say that sync=3Dnone mode=3Dabsolute-paths replaces=3Dsome-node =
will
not work as intended, because the target will not replace some-node.
(bdrv_replace_node() prevents that.)

Here, it=E2=80=99s about when there is no @replaces option.  Then, the ta=
rget
will absolutely replace the source, and target->backing will point to
the source.

Here=E2=80=99s what happens (as far as I understand):

Without @replaces:

target->backing is first set to the source.

Then, target replaces the source node.  bdrv_replace_node() will not
create loops, so it keeps the target->backing link as it is.

With replaces=3Dsome-node (must be a (recursive) child of the source):

target->backing is first set to the source.

Then target replaces some-node.  bdrv_replace_node() will not create
loops, so it keeps all links that would connect the source and the
target as they are.  Thus, the target will actually not really replace
some-node.

Example:

quorum --children.0--> to-replace

Now we mirror from quorum to some target (target-node) with sync=3Dnone,
mode=3Dabsolute-paths, and replaces=3Dto-replace.

What we=E2=80=99re effectively asking for is this:

quorum --children.0--> target-node
  ^                         |
  +---------backing---------+

Which of course doesn=E2=80=99t work.  It makes sense if you break up the=
 loop
by imagining that quorum simply won=E2=80=99t read from children.0, but i=
n
reality it is a loop, so it can=E2=80=99t work.

What happens though is this:

  quorum --children.0--> to-replace
     ^
  backing
     |
target-node

The target node does not replace to-replace, because changing the
children.0 link to point to target-node would create a loop.  Thus, the
user doesn=E2=80=99t get what they want.

(Note that if to-replace has other parents, target-node would absolutely
replace it for them.)

>> +             */
>> +            if (!bdrv_is_child_of(to_replace, target_bs, 2)) {
>> +                bdrv_replace_node(to_replace, target_bs, &local_err);=

>> +            } else {
>=20
>=20
> So, we allow bdrv_replace_node automatically handle case whith immediat=
e child of target is
> replaces.. But if consider several additional filters above target (so =
target is a filter),
> we not allow it. Why filtered case is worse?

Because if it=E2=80=99s an immediate child, there are no other nodes invo=
lved.
Just one link stays as it is (e.g. target->backing simply still points
to the source node).

If it=E2=80=99s an indirect child, then there are other nodes involved an=
d it=E2=80=99s
likely the user won=E2=80=99t get what they want (as in the example above=
, where
the replacement just won=E2=80=99t happen).


The pragmatic explanation is =E2=80=9CWe need to allow immediate children=
,
because that=E2=80=99s the no-@replaces sync=3Dnone mode=3Dabsolute-paths=
 case.  We
need to forbid everything else because it=E2=80=99d probably lead to unex=
pected
results.=E2=80=9D

Max


--SaZUPJ92E5YRYaR0fupv7jE2QuxyPn95Q--

--w1FEhHJYl8fCndJDAteFS6sbi6oRtm7Zm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2UmcEACgkQ9AfbAGHV
z0AfPQgAs2vO5ou3gOOLZNZKtEzDbGlCp8fMnsLveeIe5nzb1UpwRCqMMPV+DC8V
ga1B9/GthezwSsKNnea7/DfGEqbGEKie1g91jl3ufE3nWGsxhxDgSvfGl4aYSiv3
UVP4/f6TkVkHkxdumwctepcphAKqo0wMnLIF1Uu179Y9etKJ5gdU5xtQ7zWbhGsL
622NklQfOpXSVn8TVqNDuHYvAAa/cVoR8W6IEWR2xDMZdEcgVGUDlLPMpHKAtEdw
y8KRzKED1JohMOZJ0hdjKSTvLdhNj4ZRJ6vxAcYMPv98a4MIMI71EU9WVmrEWfSb
MWMFz4wpCGbXmAhJ8HUiGA8Tkz8S8g==
=NuXT
-----END PGP SIGNATURE-----

--w1FEhHJYl8fCndJDAteFS6sbi6oRtm7Zm--

