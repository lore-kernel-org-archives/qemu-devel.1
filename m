Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62EF1C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C556F21530
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 14:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C556F21530
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38229 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hONdg-0005yP-Qb
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 10:33:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hONcQ-0005U5-35
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:32:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hONcN-000470-Qn
	for qemu-devel@nongnu.org; Wed, 08 May 2019 10:32:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hONcI-00044h-Cr; Wed, 08 May 2019 10:32:19 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 59AEE23E6D8;
	Wed,  8 May 2019 14:32:15 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-94.brq.redhat.com
	[10.40.204.94])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 287475DD8A;
	Wed,  8 May 2019 14:32:11 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190506194753.12464-1-mreitz@redhat.com>
	<20190506194753.12464-7-mreitz@redhat.com>
	<20190508142811.GF15525@dhcp-200-226.str.redhat.com>
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
Message-ID: <1fcb5928-35de-319a-eb7a-c241b2b1f500@redhat.com>
Date: Wed, 8 May 2019 16:32:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508142811.GF15525@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1ThEAaHDuFufyFF4IPBdWswzv1wQTsDZE"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.29]);
	Wed, 08 May 2019 14:32:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH 6/7] block: Add *loosen_restrictions to
 *check*_perm()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1ThEAaHDuFufyFF4IPBdWswzv1wQTsDZE
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>
Message-ID: <1fcb5928-35de-319a-eb7a-c241b2b1f500@redhat.com>
Subject: Re: [PATCH 6/7] block: Add *loosen_restrictions to *check*_perm()
References: <20190506194753.12464-1-mreitz@redhat.com>
 <20190506194753.12464-7-mreitz@redhat.com>
 <20190508142811.GF15525@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190508142811.GF15525@dhcp-200-226.str.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08.05.19 16:28, Kevin Wolf wrote:
> Am 06.05.2019 um 21:47 hat Max Reitz geschrieben:
>> This patch makes three functions report whether the necessary permissi=
on
>> change purely loosens restrictions or not.  These functions are:
>> - bdrv_check_perm()
>> - bdrv_check_update_perm()
>> - bdrv_child_check_perm()
>>
>> Callers can use this result to decide whether a failure is fatal or no=
t
>> (see the next patch).
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block.c | 81 +++++++++++++++++++++++++++++++++++++++++++++-----------=
-
>>  1 file changed, 65 insertions(+), 16 deletions(-)
>>
>> diff --git a/block.c b/block.c
>> index 21e4514426..105866d15a 100644
>> --- a/block.c
>> +++ b/block.c
>> @@ -1686,9 +1686,12 @@ static int bdrv_fill_options(QDict **options, c=
onst char *filename,
>> =20
>>  static int bdrv_child_check_perm(BdrvChild *c, BlockReopenQueue *q,
>>                                   uint64_t perm, uint64_t shared,
>> -                                 GSList *ignore_children, Error **err=
p);
>> +                                 GSList *ignore_children,
>> +                                 bool *loosen_restrictions, Error **e=
rrp);
>>  static void bdrv_child_abort_perm_update(BdrvChild *c);
>>  static void bdrv_child_set_perm(BdrvChild *c, uint64_t perm, uint64_t=
 shared);
>> +static void bdrv_get_cumulative_perm(BlockDriverState *bs, uint64_t *=
perm,
>> +                                     uint64_t *shared_perm);
>> =20
>>  typedef struct BlockReopenQueueEntry {
>>       bool prepared;
>> @@ -1759,18 +1762,37 @@ static void bdrv_child_perm(BlockDriverState *=
bs, BlockDriverState *child_bs,
>>   * permissions of all its parents. This involves checking whether all=
 necessary
>>   * permission changes to child nodes can be performed.
>>   *
>> + * Will set *loosen_restrictions to true if and only if no new permis=
sions have
>> + * to be taken and no existing shared permissions are to be unshared.=
  In this
>> + * case, errors are not fatal, as long as the caller accepts that the=

>> + * restrictions remain tighter than they need to be.  The caller stil=
l has to
>> + * abort the transaction.
>> + *
>>   * A call to this function must always be followed by a call to bdrv_=
set_perm()
>>   * or bdrv_abort_perm_update().
>>   */
>>  static int bdrv_check_perm(BlockDriverState *bs, BlockReopenQueue *q,=

>>                             uint64_t cumulative_perms,
>>                             uint64_t cumulative_shared_perms,
>> -                           GSList *ignore_children, Error **errp)
>> +                           GSList *ignore_children,
>> +                           bool *loosen_restrictions, Error **errp)
>>  {
>>      BlockDriver *drv =3D bs->drv;
>>      BdrvChild *c;
>>      int ret;
>> =20
>> +    if (loosen_restrictions) {
>> +        uint64_t current_perms, current_shared;
>> +        uint64_t added_perms, removed_shared_perms;
>> +
>> +        bdrv_get_cumulative_perm(bs, &current_perms, &current_shared)=
;
>> +
>> +        added_perms =3D cumulative_perms & ~current_perms;
>> +        removed_shared_perms =3D current_shared & ~cumulative_shared_=
perms;
>> +
>> +        *loosen_restrictions =3D !added_perms && !removed_shared_perm=
s;
>> +    }
>=20
> (loosen_restrictions is a misnomer, just not changing permissions will
> make it true, too)

Naming things is hard. :-)

Should I name it tighten_restrictions and invert its value?

>>      /* Write permissions never work with read-only images */
>>      if ((cumulative_perms & (BLK_PERM_WRITE | BLK_PERM_WRITE_UNCHANGE=
D)) &&
>>          !bdrv_is_writable_after_reopen(bs, q))
>     {
>         error_setg(errp, "Block node is read-only");
>         return -EPERM;
>     }
>=20
> This is an interesting case in the context of reopen. It could happen
> that we're actually not taking any new permissions, but the node become=
s
> read-only in reopen, so we fail here while maintaining the old set of
> options.
>=20
> If this happens, we want the reopen operation to fail, so should we set=

> *loosen_restrictions =3D false here even though we're not literally tak=
ing
> new permissions?

Well, I had that at one point, yes.  I decided this case would always
imply that the restrictions are tightened somewhere, so I dropped it --
but I forgot about reopen, for some reason (even though it says =E2=80=9C=
reopen=E2=80=9D
right there).

> Hm, or actually, loosen_restrictions should always be NULL during
> reopen, so it will never make a different. Maybe what we want then is
> assert(!q || !loosen_restrictions) at the start of the function?

And add a note that we cannot return this information when reopening?
That sounds good to me.

Max


--1ThEAaHDuFufyFF4IPBdWswzv1wQTsDZE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzS6GoACgkQ9AfbAGHV
z0BRmQf7BTZI28ultIFtnOu0jMtPPPksAm9F+PehSSDfotx/0Wl6OWflS9eXpVH/
bSwfKVULU9aC4cn+PFzSH07s7vcZYRZ7oS6rSEyEewqKXbulQnzbs5NaT03UeQV8
c/jnoAREl/5J0vbajA7vET+6eQNNcns5waMcRP+F0xvL0MuY7Y6iYuKQ3kcOl799
2atTFWkDUaOJo2DqkEpG/YVYNNTVJVfacL5Txp2N09OliJmFx7H2K7PanqYCvjnh
2fTWRxUHpXDfzYrR4829vXRd+Ic7W7StQBX3j2HbB6mRx9wIYsL4dktOkdQz5aIk
fuk0MHpRxAxqLg0DFyqYnFIvWDV+Zw==
=L6pN
-----END PGP SIGNATURE-----

--1ThEAaHDuFufyFF4IPBdWswzv1wQTsDZE--

