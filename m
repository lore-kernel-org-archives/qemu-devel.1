Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22663C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA8962173C
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 16:23:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA8962173C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53252 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboym-0002qD-IN
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 12:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60414)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hboVs-0004eO-5W
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hboVq-00016s-51
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 11:53:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52994)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hboVm-00013T-QI; Fri, 14 Jun 2019 11:53:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 790BB3086202;
 Fri, 14 Jun 2019 15:53:00 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.125])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4BEE32D26D;
 Fri, 14 Jun 2019 15:52:58 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-16-mreitz@redhat.com>
 <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>
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
Message-ID: <3f7ec115-9014-e375-ac7a-4b1ea46873e6@redhat.com>
Date: Fri, 14 Jun 2019 17:52:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3clvIKI2ps1QoeDEkPoDRDmbcrhCqGfiR"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Fri, 14 Jun 2019 15:53:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 15/42] block: Re-evaluate backing file
 handling in reopen
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
--3clvIKI2ps1QoeDEkPoDRDmbcrhCqGfiR
Content-Type: multipart/mixed; boundary="wBQLrt8jIJs66FoHkfMQ4cEG1exKMQ6JT";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <3f7ec115-9014-e375-ac7a-4b1ea46873e6@redhat.com>
Subject: Re: [PATCH v5 15/42] block: Re-evaluate backing file handling in
 reopen
References: <20190612221004.2317-1-mreitz@redhat.com>
 <20190612221004.2317-16-mreitz@redhat.com>
 <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>
In-Reply-To: <9e448427-1d53-c1a7-c51f-123acf6eccaf@virtuozzo.com>

--wBQLrt8jIJs66FoHkfMQ4cEG1exKMQ6JT
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.06.19 15:42, Vladimir Sementsov-Ogievskiy wrote:
> 13.06.2019 1:09, Max Reitz wrote:
>> Reopening a node's backing child needs a bit of special handling becau=
se
>> the "backing" child has different defaults than all other children
>> (among other things).  Adding filter support here is a bit more
>> difficult than just using the child access functions.  In fact, we oft=
en
>> have to directly use bs->backing because these functions are about the=

>> "backing" child (which may or may not be the COW backing file).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>   block.c | 36 +++++++++++++++++++++++++++++-------
>>   1 file changed, 29 insertions(+), 7 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 505b3e9a01..db2759c10d 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -3542,17 +3542,39 @@ static int bdrv_reopen_parse_backing(BDRVReope=
nState *reopen_state,
>>           }
>>       }
>>  =20
>> +    /*
>> +     * Ensure that @bs can really handle backing files, because we ar=
e
>> +     * about to give it one (or swap the existing one)
>> +     */
>> +    if (bs->drv->is_filter) {
>> +        /* Filters always have a file or a backing child */
>> +        if (!bs->backing) {
>> +            error_setg(errp, "'%s' is a %s filter node that does not =
support a "
>> +                       "backing child", bs->node_name, bs->drv->forma=
t_name);
>> +            return -EINVAL;
>> +        }
>> +    } else if (!bs->drv->supports_backing) {
>> +        error_setg(errp, "Driver '%s' of node '%s' does not support b=
acking "
>> +                   "files", bs->drv->format_name, bs->node_name);
>> +        return -EINVAL;
>> +    }
>=20
> hmm, shouldn't we have these checks for overlay_bs?

I think this is correct here because this is the only node the user has
control over, so this is the only one we can reasonably complain about.

And I do think it is reasonable to complain about.

>> +
>>       /*
>>        * Find the "actual" backing file by skipping all links that poi=
nt
>>        * to an implicit node, if any (e.g. a commit filter node).
>> +     * We cannot use any of the bdrv_skip_*() functions here because
>> +     * those return the first explicit node, while we are looking for=

>> +     * its overlay here.
>>        */
>>       overlay_bs =3D bs;
>> -    while (backing_bs(overlay_bs) && backing_bs(overlay_bs)->implicit=
) {
>> -        overlay_bs =3D backing_bs(overlay_bs);
>> +    while (bdrv_filtered_bs(overlay_bs) &&
>> +           bdrv_filtered_bs(overlay_bs)->implicit)
>> +    {
>> +        overlay_bs =3D bdrv_filtered_bs(overlay_bs);
>>       }
>=20
> here, overlay_bs may be some filter with file child ..
>=20
>>  =20
>>       /* If we want to replace the backing file we need some extra che=
cks */
>> -    if (new_backing_bs !=3D backing_bs(overlay_bs)) {
>> +    if (new_backing_bs !=3D bdrv_filtered_bs(overlay_bs)) {
>>           /* Check for implicit nodes between bs and its backing file =
*/
>>           if (bs !=3D overlay_bs) {
>>               error_setg(errp, "Cannot change backing link if '%s' has=
 "
>> @@ -3560,8 +3582,8 @@ static int bdrv_reopen_parse_backing(BDRVReopenS=
tate *reopen_state,
>>               return -EPERM;
>>           }
>>           /* Check if the backing link that we want to replace is froz=
en */
>> -        if (bdrv_is_backing_chain_frozen(overlay_bs, backing_bs(overl=
ay_bs),
>> -                                         errp)) {
>> +        if (bdrv_is_backing_chain_frozen(overlay_bs,
>> +                                         child_bs(overlay_bs->backing=
), errp)) {
>=20
> .. and here we are doing wrong thing, as it don't have backing child
>=20
> Aha, you use the fact that we now don't have implicit filters with file=
 child. Then, should
> we add an assertion for this?

No, that wasn=E2=80=99t my intention.  The real reason is that all of thi=
s is a
mess.

Here is the full context:

>     overlay_bs =3D bs;
>     while (bdrv_filtered_bs(overlay_bs) &&
>            bdrv_filtered_bs(overlay_bs)->implicit)
>     {
>         overlay_bs =3D bdrv_filtered_bs(overlay_bs);
>     }
>=20
>     /* If we want to replace the backing file we need some extra checks=
 */
>     if (new_backing_bs !=3D bdrv_filtered_bs(overlay_bs)) {
>         /* Check for implicit nodes between bs and its backing file */
>         if (bs !=3D overlay_bs) {
>             error_setg(errp, "Cannot change backing link if '%s' has " =
                                                                         =
                                                                         =
                   =20
>                        "an implicit backing file", bs->node_name);
>             return -EPERM;
>         }
>         /* Check if the backing link that we want to replace is frozen =
*/
>         if (bdrv_is_backing_chain_frozen(overlay_bs,
>                                          child_bs(overlay_bs->backing),=
 errp)) {
>             return -EPERM;
>         }

Note the =E2=80=9CCheck for implicit nodes=E2=80=9D thing.  If we get to =
the frozen
check, we have already confirmed that overlay_bs =3D=3D bs, so we then kn=
ow
that overlay_bs->backing works.

I can add an additional comment to make that more clear.  It took myself
quite a bit of digging to figure that out again...

(The reason for the loop is that we want to be able to recognize when
the user tries to not change the backing file.  In that case, we don=E2=80=
=99t
have to do anything, but because the user doesn=E2=80=99t know about impl=
icit
nodes, we have to skip them in order to check whether the user actually
doesn=E2=80=99t want to change anything.)

Max

>>               return -EPERM;
>>           }
>>           reopen_state->replace_backing_bs =3D true;
>> @@ -3712,7 +3734,7 @@ int bdrv_reopen_prepare(BDRVReopenState *reopen_=
state, BlockReopenQueue *queue,
>>        * its metadata. Otherwise the 'backing' option can be omitted.
>>        */
>>       if (drv->supports_backing && reopen_state->backing_missing &&
>> -        (backing_bs(reopen_state->bs) || reopen_state->bs->backing_fi=
le[0])) {
>> +        (reopen_state->bs->backing || reopen_state->bs->backing_file[=
0])) {
>>           error_setg(errp, "backing is missing for '%s'",
>>                      reopen_state->bs->node_name);
>>           ret =3D -EINVAL;
>> @@ -3857,7 +3879,7 @@ void bdrv_reopen_commit(BDRVReopenState *reopen_=
state)
>>        * from bdrv_set_backing_hd()) has the new values.
>>        */
>>       if (reopen_state->replace_backing_bs) {
>> -        BlockDriverState *old_backing_bs =3D backing_bs(bs);
>> +        BlockDriverState *old_backing_bs =3D child_bs(bs->backing);
>>           assert(!old_backing_bs || !old_backing_bs->implicit);
>>           /* Abort the permission update on the backing bs we're detac=
hing */
>>           if (old_backing_bs) {
>>
>=20
>=20



--wBQLrt8jIJs66FoHkfMQ4cEG1exKMQ6JT--

--3clvIKI2ps1QoeDEkPoDRDmbcrhCqGfiR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0DwtgACgkQ9AfbAGHV
z0B3OAf8D+nE55Gqc0rXVrl9I/StNIMR9KGCxuAAKAzbgMVymjHdPZzvHpyBzI4+
sDqKtCfsVP0slB9XuRScuq6d1Ti1j9Lajs6r41gvyYC/HYIETSNLNkt1yBa8hbO0
bYElkaylfE6DzWZrvR8qBTPmrXejFSVvekRvkjSH3/HyFYSdjLNYoppL1ByxMJYY
RT9Z8u3AlheB6efjpebPp2i2CY61BD4MX0z47UIcqEvlpmPKAUN9KB4nDiy8VCtv
fHkbuFCGpm09fV1zsp5L6wcrJryWt3+z0dF9GbHWJcrVA1oNEwl0Ke/J3MY+82rM
7b3m4LMdN0Ne2q2FG26kinxreFcgBQ==
=bbHZ
-----END PGP SIGNATURE-----

--3clvIKI2ps1QoeDEkPoDRDmbcrhCqGfiR--

