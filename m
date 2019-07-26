Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ECB3C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B72A22BF5
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 12:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B72A22BF5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqzN9-0006oF-5I
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 08:30:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45418)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hqzMu-0006Oo-K4
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:30:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hqzMs-0006JQ-9V
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 08:30:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35774)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hqzMn-0005Y1-4n; Fri, 26 Jul 2019 08:30:33 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9A105C0703C6;
 Fri, 26 Jul 2019 12:30:31 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-164.ams2.redhat.com
 [10.36.116.164])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8084519696;
 Fri, 26 Jul 2019 12:30:29 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-4-kwolf@redhat.com>
 <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
 <20190726113653.GC6295@localhost.localdomain>
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
Message-ID: <365a60c1-ff7b-1d0a-db68-17f5eb1615a9@redhat.com>
Date: Fri, 26 Jul 2019 14:30:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190726113653.GC6295@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6cs3NEpZK70iifk8YBl9LBOf49Nta1IY1"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 26 Jul 2019 12:30:31 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/4] mirror: Keep target drained until
 graph changes are done
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
Cc: dplotnikov@virtuozzo.com, vsementsov@virtuozzo.com, den@virtuozzo.com,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6cs3NEpZK70iifk8YBl9LBOf49Nta1IY1
Content-Type: multipart/mixed; boundary="OOaxHRijijgtuxy9PnTlRiUr7iUb4VfFY";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, dplotnikov@virtuozzo.com,
 vsementsov@virtuozzo.com, den@virtuozzo.com, qemu-devel@nongnu.org
Message-ID: <365a60c1-ff7b-1d0a-db68-17f5eb1615a9@redhat.com>
Subject: Re: [PATCH 3/4] mirror: Keep target drained until graph changes are
 done
References: <20190725162704.12622-1-kwolf@redhat.com>
 <20190725162704.12622-4-kwolf@redhat.com>
 <d6466e56-b57b-7cf7-1a39-8cd38db14ede@redhat.com>
 <20190726113653.GC6295@localhost.localdomain>
In-Reply-To: <20190726113653.GC6295@localhost.localdomain>

--OOaxHRijijgtuxy9PnTlRiUr7iUb4VfFY
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 26.07.19 13:36, Kevin Wolf wrote:
> Am 26.07.2019 um 11:52 hat Max Reitz geschrieben:
>> On 25.07.19 18:27, Kevin Wolf wrote:
>>> Calling bdrv_drained_end() for target_bs can restarts requests too
>>> early, so that they would execute on mirror_top_bs, which however has=

>>> already dropped all permissions.
>>>
>>> Keep the target node drained until all graph changes have completed.
>>>
>>> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
>>> ---
>>>  block/mirror.c | 14 ++++++++------
>>>  1 file changed, 8 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/block/mirror.c b/block/mirror.c
>>> index 8cb75fb409..7483051f8d 100644
>>> --- a/block/mirror.c
>>> +++ b/block/mirror.c
>>> @@ -644,6 +644,11 @@ static int mirror_exit_common(Job *job)
>>>      bdrv_ref(mirror_top_bs);
>>>      bdrv_ref(target_bs);
>>> =20
>>> +    /* The mirror job has no requests in flight any more, but we nee=
d to
>>> +     * drain potential other users of the BDS before changing the gr=
aph. */
>>> +    assert(s->in_drain);
>>> +    bdrv_drained_begin(target_bs);
>>> +
>>
>> In contrast to what Eric said, I think it is a problem that this is ju=
st
>> code motion.
>>
>> The comment doesn=E2=80=99t tell the reason why the target needs to be=
 drained
>> here.  Other users of the BDS have their own BdrvChild and thus their
>> own permissions, their requests do not go through mirror.
>>
>> So in addition to why the target needs to be drained around
>> bdrv_replace_node(), the comment should tell why we need to drain it
>> here, like the commit message does.
>>
>> Now, the thing is, I don=E2=80=99t quite understand the connection bet=
ween the
>> target and mirror_top_bs that the commit message wants to establish.
>>
>> I see the following problem:
>> (1) We drain src (at the end of mirror_run()).
>> (2) This implicitly drains mirror_top_bs.
>> (3) We drain target.
>> (4) bdrv_replace_node() replaces src by target, thus replacing the dra=
in
>>     on mirror_top_bs from src by the one from target.
>> (5) We undrain target, thus also undraining mirror_top_bs.
>=20
> (5.5) Remove mirror_top_bs from the target chain
>=20
>> (6) After all is done, we undrain src, which has no effect on
>>     mirror_top_bs, because they haven=E2=80=99t been connected since (=
4).
>>
>> I suppose (5) is the problem.  This patch moves it down to (6), so
>> mirror_top_bs is drained as long as src is drained.
>=20
> The problem is that (5) happens before (5.5), so we can start requests
> on a node that we're about to remove (without draining it again before)=
=2E

Well, yes.  I generally put that under the idea of =E2=80=9CWe set
bs_opaque->stop, so we shouldn=E2=80=99t issue any further requests=E2=80=
=9D (which I
find implied by =E2=80=9Chas already dropped all permissions=E2=80=9D in =
your commit
message).

>> (If to_replace is not src, then src will stay attached, which keeps
>> mirror_top_bs drained, too.)
>>
>> This makes it seem to me like the actually important thing is to drain=

>> mirror_top_bs, not target.  If so, it would seem more obvious to me to=

>> just add a drain on mirror_top_bs than to move the existing target dra=
in.
>=20
> Do you really think having a third drained section makes things easier
> to understand?

Yes, I do.  It makes immediate sense because of the bs_opaque->stop
concept.  As you explain yourself, mirror_top_bs dropped all
permissions, it mustn=E2=80=99t perform any further requests.  As such, i=
t must
be drained.

>                Draining both source and target while we're modifying th=
e
> graph seems pretty intuitive to me - which is also why I moved the
> bdrv_drained_begin() to the very start instead of looking for the first=

> operation that actually strictly needs it.

The problem for me is that we don=E2=80=99t actually care about whether t=
he
target is drained or not, do we?  Anyone can access it at basically any
point[1], we don=E2=80=99t care.

The point is that mirror must not perform any further requests.  Thus it
should be mirror_top_bs that=E2=80=99s drained.

[1] Maybe not during bdrv_replace_node(), even though I don=E2=80=99t qui=
te know
why.  Why do we care about other users of target accessing it while we
attach more parents to it?

>>>      /* Remove target parent that still uses BLK_PERM_WRITE/RESIZE be=
fore
>>>       * inserting target_bs at s->to_replace, where we might not be a=
ble to get
>>>       * these permissions.
>>> @@ -684,12 +689,7 @@ static int mirror_exit_common(Job *job)
>>>              bdrv_reopen_set_read_only(target_bs, ro, NULL);
>>>          }
>>> =20
>>> -        /* The mirror job has no requests in flight any more, but we=
 need to
>>> -         * drain potential other users of the BDS before changing th=
e graph. */
>>> -        assert(s->in_drain);
>>> -        bdrv_drained_begin(target_bs);
>>
>> By the way, don=E2=80=99t we need to drain to_replace also?  In case i=
t isn=E2=80=99t src?
>=20
> I think to_replace is required to be in the subtree of src, no?
>=20
> Though maybe it could have another parent, so you might be right.

That might be broken, but there could be a throttle node between src and
to_replace.  Not sure whether draining src would drain that, too.

But we don=E2=80=99t, actually, because bdrv_replace_node() already takes=
 care
of keeping @from drained.

Max


--OOaxHRijijgtuxy9PnTlRiUr7iUb4VfFY--

--6cs3NEpZK70iifk8YBl9LBOf49Nta1IY1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl068mMACgkQ9AfbAGHV
z0DoPQf7BPY6kAYQHiN0HFswcUHMdrJLgP0MHMQ09K6hZAjdpxD7H0fjdLVdr2jH
QTeHNVtA9RQm1mBWeS1sJknzdR/z1nJd0/fCxrNC1gySGVOgU6hq0WtRxA+JHAZ4
BrSrtKWpfaRm2b47EW1j4r1eSYH/1FQ0gUG+jyJAniWxAlwG1Zpp6Hyv+C9SVPHZ
VnZFko9g8ZHyr/MTwxGlCZk4uz5nfHGU5teuDft8WSB5gNyizad51nPU4s8YBmL+
G8ClJaltL2Nmxu16Wx4NKDfzdDZB7z1LDu70Bxn1O5KVVyHdN9vy3Bg9dPrGXmob
0N1kxBSLRldcv1O53LFBkWcB2pAi4g==
=KovR
-----END PGP SIGNATURE-----

--6cs3NEpZK70iifk8YBl9LBOf49Nta1IY1--

