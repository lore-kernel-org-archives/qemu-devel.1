Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D474DC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:03:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C2A720880
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 16:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C2A720880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPvo-0001Rv-Ud
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 12:03:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44484)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hnPvc-0000w9-G8
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:03:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hnPva-0001I9-Vb
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 12:03:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39336)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hnPvX-0001GI-Nm; Tue, 16 Jul 2019 12:03:39 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16C778553A;
 Tue, 16 Jul 2019 16:03:39 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.58])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 618315DA34;
 Tue, 16 Jul 2019 16:03:37 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-3-mreitz@redhat.com>
 <9d9af2d86805036334efd17baabf2ec2a0804615.camel@redhat.com>
 <8dddcc60d9eac5535af9390e054dbfca9c08db2f.camel@redhat.com>
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
Message-ID: <8887bb70-7e09-4d05-cbd1-5f972a4dc1a6@redhat.com>
Date: Tue, 16 Jul 2019 18:03:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <8dddcc60d9eac5535af9390e054dbfca9c08db2f.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nUsbF8kRt3OHz8qKm3PaX8FWM2kE0oVP0"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 16 Jul 2019 16:03:39 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] block: Add
 blk_truncate_for_formatting()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nUsbF8kRt3OHz8qKm3PaX8FWM2kE0oVP0
Content-Type: multipart/mixed; boundary="3C4YpYbe6zqJV2Edu6IYHrmqNUfNqH44D";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <8887bb70-7e09-4d05-cbd1-5f972a4dc1a6@redhat.com>
Subject: Re: [Qemu-block] [PATCH 2/7] block: Add blk_truncate_for_formatting()
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-3-mreitz@redhat.com>
 <9d9af2d86805036334efd17baabf2ec2a0804615.camel@redhat.com>
 <8dddcc60d9eac5535af9390e054dbfca9c08db2f.camel@redhat.com>
In-Reply-To: <8dddcc60d9eac5535af9390e054dbfca9c08db2f.camel@redhat.com>

--3C4YpYbe6zqJV2Edu6IYHrmqNUfNqH44D
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 16.07.19 17:45, Maxim Levitsky wrote:
> On Tue, 2019-07-16 at 16:08 +0300, Maxim Levitsky wrote:
>> On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>> ---
>>>  include/sysemu/block-backend.h | 12 ++++++++
>>>  block/block-backend.c          | 54 ++++++++++++++++++++++++++++++++=
++
>>>  2 files changed, 66 insertions(+)
>>>
>>> diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-ba=
ckend.h
>>> index 733c4957eb..cd9ec8bf52 100644
>>> --- a/include/sysemu/block-backend.h
>>> +++ b/include/sysemu/block-backend.h
>>> @@ -236,6 +236,18 @@ int blk_pwrite_compressed(BlockBackend *blk, int=
64_t offset, const void *buf,
>>>                            int bytes);
>>>  int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode pre=
alloc,
>>>                   Error **errp);
>>> +
>>> +/**
>>> + * Wrapper of blk_truncate() for format drivers that need to truncat=
e
>>> + * their protocol node before formatting it.
>>> + * Invoke blk_truncate() to truncate the file to @offset; if that
>>> + * fails with -ENOTSUP (and the file is already big enough), try to
>>> + * overwrite the first sector with zeroes.  If that succeeds, return=

>>> + * success.
>>> + */
>>> +int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset,
>>> +                                Error **errp);
>>> +
>>>  int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
>>>  int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
>>>                       int64_t pos, int size);
>>> diff --git a/block/block-backend.c b/block/block-backend.c
>>> index a8d160fd5d..c0e64b1ee1 100644
>>> --- a/block/block-backend.c
>>> +++ b/block/block-backend.c
>>> @@ -2041,6 +2041,60 @@ int blk_truncate(BlockBackend *blk, int64_t of=
fset, PreallocMode prealloc,
>>>      return bdrv_truncate(blk->root, offset, prealloc, errp);
>>>  }
>>> =20
>>> +int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset, E=
rror **errp)
>>> +{
>>> +    Error *local_err =3D NULL;
>>> +    int64_t current_size;
>>> +    int bytes_to_clear;
>>> +    int ret;
>>> +
>>> +    ret =3D blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err)=
;
>>> +    if (ret < 0 && ret !=3D -ENOTSUP) {
>>> +        error_propagate(errp, local_err);
>>> +        return ret;
>>> +    } else if (ret >=3D 0) {
>>> +        return ret;
>>> +    }
>>
>> What if the truncate does succeed? For example the current implementat=
ion of raw_co_truncate,
>> does return zero when you truncate to less that block device size=20
>> (and this is kind of wrong since you can't really change the block dev=
ice size)

Ah, yes, stupid me.

>> Even more, I see is that in the later patch, you call this with offset=
 =3D=3D 0 which
>> I think will always succeed on a raw block device, thus skipping the z=
eroing code.
>>
>> How about just doing the zeroing in the bdrv_create_file_fallback?

Hm.  I can try.  The block drivers that use
blk_truncate_for_formatting() write a full header to the image file, so
they don=E2=80=99t need the sector be zero.

Alternatively, I could just treat ret =3D=3D 0 the same as -ENOTSUP.  The=
n
the code would just go on to invoke blk_getlength() and see for itself
what to do.

>> Another idea:
>>
>> blk_truncate_for_formatting would first truncate the file to 0, then
>> check if the size of the file became zero in addition to the successfu=
l return value.
>>
>> If the file size became zero, truncate the file to the requested size =
- this should make sure that file is empty.
>> Otherwise, zero the first sector.
>>
>> It might also be nice to add a check that if the size didn't became ze=
ro, that it remained the same
>> to avoid strange situations of semi broken truncate.

Hm, I would expect the block device to handle that.  A state between
=E2=80=9Csuccessful resize=E2=80=9D and =E2=80=9Cdid not change at all, a=
s intended for this
device=E2=80=9D should always be an error.

But the device should zero the first cluster like we do here.

>> Also I would rename the function to something like blk_raw_format_file=
,
>> basically a function which tries its best to erase an existing file co=
ntents
>>
>>
>> Yet another idea would to drop the lying in the raw_co_truncate (on bl=
ock devices), and fail always,
>> unless asked to truncate to the exact file size, and let the callers d=
eal with that.
>> Callers where it is not critical for the truncate to work can just ign=
ore this failure.
>> That is probably hard to implement=20
>>
>> Or we can add a truncate 'mode' to .bdrv_co_truncate, which would let =
the caller indicate its intention,
>> that is if the caller must truncate to that size or it can accept trun=
cate ending up in bigger file that it asked for.

Hm.  That sounds interesting.  Currently, qemu-img resize tries to
inquire whether the truncate did anything useful by checking the length
post-truncate.  It prints a warning if the size didn=E2=80=99t change.

Adding a flag would simplify that and probably this, so that sounds
useful indeed.

>> As we once discussed on IRC, the fact that truncate on a block device =
'succeeds',
>> despite not really beeing able to change the block device size, causes=
 other issues,
>> like not beeing able to use preallocation=3Dfull when creating a qcow2=
 image on a block device.
>>
>> Best regards,
>> 	Maxim Levitsky
>>
>>> +
>>> +    current_size =3D blk_getlength(blk);
>>> +    if (current_size < 0) {
>>> +        error_free(local_err);
>>> +        error_setg_errno(errp, -current_size,
>>> +                         "Failed to inquire new image file's current=
 length");
>>> +        return current_size;
>>> +    }
>>> +
>>> +    if (current_size < offset) {
>>> +        /* Need to grow the image, but we failed to do that */
>>> +        error_propagate(errp, local_err);
>>> +        return -ENOTSUP;
>>> +    }
>>> +
>>> +    error_free(local_err);
>>> +    /*
>>> +     * We can deal with images that are too big.  We just need to
>>> +     * clear the first sector.
>>> +     */
>>> +
>>> +    bytes_to_clear =3D MIN(current_size, BDRV_SECTOR_SIZE) - offset;=

> Also this I think is wrong when offset !=3D0, since assuming real world=
 device, the
> MIN will be just BDRV_SECTOR_SIZE, so the result of this statement is n=
egative number.

Oh, damn, yes.  Thanks!

> I think you want just
> bytes_to_clear =3D MIN(current_size, BDRV_SECTOR_SIZE);

I don=E2=80=99t think I want that because I want to start clearing from @=
offset,
so I do need to subtract it.

But of course I don=E2=80=99t need to do anything if @offset >=3D
BDRV_SECTOR_SIZE, so there should just be an additional if () block.

Max

>>> +    if (bytes_to_clear) {
>>> +        if (!(blk->root->perm & BLK_PERM_WRITE)) {
>>> +            error_setg(errp, "Cannot clear first sector of new image=
: "
>>> +                       "Write permission missing");
>>> +            return -EPERM;
>>> +        }
>>> +
>>> +        ret =3D blk_pwrite_zeroes(blk, offset, bytes_to_clear, 0);
>>> +        if (ret < 0) {
>>> +            error_setg_errno(errp, -ret, "Failed to clear the first =
sector of "
>>> +                             "the new image");
>>> +            return ret;
>>> +        }
>>> +    }
>>> +
>>> +    return 0;
>>> +}
>>> +
>>>  static void blk_pdiscard_entry(void *opaque)
>>>  {
>>>      BlkRwCo *rwco =3D opaque;
>>
>>
>=20
>=20



--3C4YpYbe6zqJV2Edu6IYHrmqNUfNqH44D--

--nUsbF8kRt3OHz8qKm3PaX8FWM2kE0oVP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0t9VcACgkQ9AfbAGHV
z0Bt3AgAg7Wh+WteE0ZBtnSMczyn7ae8csgBlaW1c7Q6+43UkAXjBxoFGgfynTOj
d6fAQKu0t90HhvFhqidRqzN4llFyIH3/VSoJmrdjByedhZQ9Ey8TIbG/siyzQygQ
tbATxWW/fwu3mJLxvj3hDd9er3+82iwiCrtD/KCbiaUZQ8r61joDMBLImzE4JPme
rdjB1Fq7DXbkQ2CTl5qTQQ11TsAPpuPmG2WU0ANPLzqvhj9b6Jvyx5m9ENrA147n
7V7I0Afr2aLN+2iKTPAVOmTA7YFC0mE1JYjrlPq7ZohbuNFhdFF7DANTP7VbqLJQ
VZ05QAjWb0Hu7xuv9gTuntkQGEyIOw==
=SH6l
-----END PGP SIGNATURE-----

--nUsbF8kRt3OHz8qKm3PaX8FWM2kE0oVP0--

