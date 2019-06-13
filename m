Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78568C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 409192082C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 15:37:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 409192082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbRn2-0001J5-2e
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 11:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34196)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbQMk-0005FJ-I7
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbQMd-0005TS-3l
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 10:06:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbQMY-0005OO-84; Thu, 13 Jun 2019 10:05:58 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D31BDA3EC0;
 Thu, 13 Jun 2019 14:05:47 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 82D901001B04;
 Thu, 13 Jun 2019 14:05:45 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-10-mreitz@redhat.com>
 <d6074caa-ee1e-4dde-1977-83ab327e2771@virtuozzo.com>
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
Message-ID: <e4832ffc-62bd-bbaa-a00b-71fedf4d52bc@redhat.com>
Date: Thu, 13 Jun 2019 16:05:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <d6074caa-ee1e-4dde-1977-83ab327e2771@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="dYxqDe86c1rxAE4t13CMfDFDpX2d5cvRX"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Thu, 13 Jun 2019 14:05:49 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 09/42] block: Include filters when
 freezing backing chain
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dYxqDe86c1rxAE4t13CMfDFDpX2d5cvRX
Content-Type: multipart/mixed; boundary="CSWZjMUnXPnH9PuokQymOLNxc07oRPZNa";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <e4832ffc-62bd-bbaa-a00b-71fedf4d52bc@redhat.com>
Subject: Re: [PATCH v5 09/42] block: Include filters when freezing backing
 chain
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-10-mreitz@redhat.com>
 <d6074caa-ee1e-4dde-1977-83ab327e2771@virtuozzo.com>
In-Reply-To: <d6074caa-ee1e-4dde-1977-83ab327e2771@virtuozzo.com>

--CSWZjMUnXPnH9PuokQymOLNxc07oRPZNa
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 15:04, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> In order to make filters work in backing chains, the associated
>> functions must be able to deal with them and freeze all filter links, =
be
>> they COW or R/W filter links.
>>
>> While at it, add some comments that note which functions require their=

>> caller to ensure that a given child link is not frozen, and how the
>> callers do so.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c | 45 ++++++++++++++++++++++++++++++++-------------
>>   1 file changed, 32 insertions(+), 13 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 8438b0699e..45882a3470 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -2214,12 +2214,15 @@ static void bdrv_replace_child_noperm(BdrvChil=
d *child,
>>    * If @new_bs is not NULL, bdrv_check_perm() must be called beforeha=
nd, as this
>>    * function uses bdrv_set_perm() to update the permissions according=
 to the new
>>    * reference that @new_bs gets.
>> + *
>> + * Callers must ensure that child->frozen is false.
>>    */
>>   static void bdrv_replace_child(BdrvChild *child, BlockDriverState *n=
ew_bs)
>>   {
>>       BlockDriverState *old_bs =3D child->bs;
>>       uint64_t perm, shared_perm;
>>  =20
>> +    /* Asserts that child->frozen =3D=3D false */
>>       bdrv_replace_child_noperm(child, new_bs);
>>  =20
>>       if (old_bs) {
>> @@ -2360,6 +2363,7 @@ static void bdrv_detach_child(BdrvChild *child)
>>       g_free(child);
>>   }
>>  =20
>> +/* Callers must ensure that child->frozen is false. */
>=20
> Is such a comment better than one-line extra assertion at start of the =
function body?

Well, there already is an assertion, it is in
bdrv_replace_child_noperm().  I personally prefer to read comments than
assertions.

>>   void bdrv_root_unref_child(BdrvChild *child)
>>   {
>>       BlockDriverState *child_bs;
>> @@ -2369,6 +2373,7 @@ void bdrv_root_unref_child(BdrvChild *child)
>>       bdrv_unref(child_bs);
>>   }
>>  =20
>> +/* Callers must ensure that child->frozen is false. */
>>   void bdrv_unref_child(BlockDriverState *parent, BdrvChild *child)
>>   {
>>       if (child =3D=3D NULL) {
>> @@ -2435,6 +2440,7 @@ void bdrv_set_backing_hd(BlockDriverState *bs, B=
lockDriverState *backing_hd,
>>       }
>>  =20
>>       if (bs->backing) {
>> +        /* Cannot be frozen, we checked that above */
>>           bdrv_unref_child(bs, bs->backing);
>>       }
>>  =20
>> @@ -3908,6 +3914,7 @@ static void bdrv_close(BlockDriverState *bs)
>>  =20
>>       if (bs->drv) {
>>           if (bs->drv->bdrv_close) {
>> +            /* Must unfreeze all children, so bdrv_unref_child() work=
s */
>>               bs->drv->bdrv_close(bs);
>>           }
>>           bs->drv =3D NULL;
>> @@ -4281,17 +4288,20 @@ BlockDriverState *bdrv_find_base(BlockDriverSt=
ate *bs)
>>    * Return true if at least one of the backing links between @bs and
>>    * @base is frozen. @errp is set if that's the case.
>>    * @base must be reachable from @bs, or NULL.
>> + * (Filters are treated as normal elements of the backing chain.)
>>    */
>>   bool bdrv_is_backing_chain_frozen(BlockDriverState *bs, BlockDriverS=
tate *base,
>>                                     Error **errp)
>>   {
>>       BlockDriverState *i;
>> +    BdrvChild *child;
>>  =20
>> -    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>> -        if (i->backing && i->backing->frozen) {
>> +    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
>> +        child =3D bdrv_filtered_child(i);
>> +
>> +        if (child && child->frozen) {
>>               error_setg(errp, "Cannot change '%s' link from '%s' to '=
%s'",
>> -                       i->backing->name, i->node_name,
>> -                       backing_bs(i)->node_name);
>> +                       child->name, i->node_name, child->bs->node_nam=
e);
>>               return true;
>>           }
>>       }
>> @@ -4305,19 +4315,22 @@ bool bdrv_is_backing_chain_frozen(BlockDriverS=
tate *bs, BlockDriverState *base,
>>    * none of the links are modified.
>>    * @base must be reachable from @bs, or NULL.
>>    * Returns 0 on success. On failure returns < 0 and sets @errp.
>> + * (Filters are treated as normal elements of the backing chain.)
>>    */
>>   int bdrv_freeze_backing_chain(BlockDriverState *bs, BlockDriverState=
 *base,
>>                                 Error **errp)
>>   {
>>       BlockDriverState *i;
>> +    BdrvChild *child;
>>  =20
>>       if (bdrv_is_backing_chain_frozen(bs, base, errp)) {
>>           return -EPERM;
>>       }
>>  =20
>> -    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>> -        if (i->backing) {
>> -            i->backing->frozen =3D true;
>> +    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
>> +        child =3D bdrv_filtered_child(i);
>> +        if (child) {
>> +            child->frozen =3D true;
>>           }
>>       }
>>  =20
>> @@ -4328,15 +4341,18 @@ int bdrv_freeze_backing_chain(BlockDriverState=
 *bs, BlockDriverState *base,
>>    * Unfreeze all backing links between @bs and @base. The caller must=

>>    * ensure that all links are frozen before using this function.
>>    * @base must be reachable from @bs, or NULL.
>> + * (Filters are treated as normal elements of the backing chain.)
>>    */
>>   void bdrv_unfreeze_backing_chain(BlockDriverState *bs, BlockDriverSt=
ate *base)
>>   {
>>       BlockDriverState *i;
>> +    BdrvChild *child;
>>  =20
>> -    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>> -        if (i->backing) {
>> -            assert(i->backing->frozen);
>> -            i->backing->frozen =3D false;
>> +    for (i =3D bs; i !=3D base; i =3D child_bs(child)) {
>> +        child =3D bdrv_filtered_child(i);
>> +        if (child) {
>> +            assert(child->frozen);
>> +            child->frozen =3D false;
>>           }
>>       }
>>   }
>> @@ -4438,8 +4454,11 @@ int bdrv_drop_intermediate(BlockDriverState *to=
p, BlockDriverState *base,
>>               }
>>           }
>>  =20
>> -        /* Do the actual switch in the in-memory graph.
>> -         * Completes bdrv_check_update_perm() transaction internally.=
 */
>> +        /*
>> +         * Do the actual switch in the in-memory graph.
>> +         * Completes bdrv_check_update_perm() transaction internally.=

>> +         * c->frozen is false, we have checked that above.
>> +         */
>>           bdrv_ref(base);
>>           bdrv_replace_child(c, base);
>>           bdrv_unref(top);
>>
>=20
> Hmm, OK, it's better than it was, so:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> But I have one thought: we check that frozen is false at some point, an=
d then
> do some logic around this child. Where is guarantee, that someone else =
will not
> set frozen=3Dtrue during some yield, for example? So, do we need a kind=
 of child_mutex,
> or something like this?

The guarantee is that the caller does not do anything that could cause
the child link to become frozen between checking whether it is and
performing an operation that relies on it not being frozen.

Freezing (currently) only happens when starting block jobs, which can
only happen because of monitor commands.  Even in
bdrv_drop_intermediate(), which has quite a bit of code between checking
the frozen status and calling bdrv_replace_child(), I don=E2=80=99t see h=
ow a
new block job could sneak in.

Max


--CSWZjMUnXPnH9PuokQymOLNxc07oRPZNa--

--dYxqDe86c1rxAE4t13CMfDFDpX2d5cvRX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CWDcACgkQ9AfbAGHV
z0DO8QgAjMnPRWcW0hk3Jfibgw013Os9phBHpoAEcLZ7qkccfsCxHcspwESCbDG8
iUBY73m37DuyNrm0eYWL9og5Zp9B+PCOWfe63Uf0qJ8ZOdcPH85+9LOBK85UDOoc
3r4NjYCV4e/Tp5dTvCe1EX5VpbxdMx3UxfPOxKUJKVS1Kjf41OcRIRmxDq6xZ2jN
KtjAA0S5oziCcp5gDKV8ZLWJSnTUp0CNhlgtjs6TnELXy6UkkC6JgFH9GYNzJ3A1
JB3Zg6Zb1gfjvSSTdT7b2bJ9a0tOYyOCaUJvXwn4uySgvjneVSeNmsf4gpZLBSGB
vjpzmRzVBTX3IIjowymX9z6kjR4I4w==
=JIWn
-----END PGP SIGNATURE-----

--dYxqDe86c1rxAE4t13CMfDFDpX2d5cvRX--

