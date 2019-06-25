Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BE6C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:18:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2CF12133F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2CF12133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32982 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnDI-0003RC-RQ
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:18:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53284)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hfmtY-0003kI-6O
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:58:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hfmtW-0002i7-Mv
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 10:58:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56930)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hfmtS-0002bR-6F; Tue, 25 Jun 2019 10:57:58 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 18CC08830C;
 Tue, 25 Jun 2019 14:57:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-156.brq.redhat.com
 [10.40.204.156])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8851819C6F;
 Tue, 25 Jun 2019 14:57:55 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190509145927.293369-1-sgarzare@redhat.com>
 <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
 <20190625144710.xvlwcqcbp5bipbku@steredhat>
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
Message-ID: <b02a2b04-4955-c341-8639-b03d3a125927@redhat.com>
Date: Tue, 25 Jun 2019 16:57:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190625144710.xvlwcqcbp5bipbku@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lSVgjTJc3v0zwcaHOcW2VSxiqwtUguOBz"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Tue, 25 Jun 2019 14:57:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: increase dynamically the
 image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lSVgjTJc3v0zwcaHOcW2VSxiqwtUguOBz
Content-Type: multipart/mixed; boundary="ykgFLyaq93psLZsY9d3tSikgoTA50RrgQ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Dillaman <jdillama@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Josh Durgin <jdurgin@redhat.com>
Message-ID: <b02a2b04-4955-c341-8639-b03d3a125927@redhat.com>
Subject: Re: [PATCH v3] block/rbd: increase dynamically the image size
References: <20190509145927.293369-1-sgarzare@redhat.com>
 <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
 <20190625144710.xvlwcqcbp5bipbku@steredhat>
In-Reply-To: <20190625144710.xvlwcqcbp5bipbku@steredhat>

--ykgFLyaq93psLZsY9d3tSikgoTA50RrgQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.06.19 16:47, Stefano Garzarella wrote:
> On Tue, Jun 25, 2019 at 04:02:04PM +0200, Max Reitz wrote:
>> On 09.05.19 16:59, Stefano Garzarella wrote:
>>> RBD APIs don't allow us to write more than the size set with
>>> rbd_create() or rbd_resize().
>>> In order to support growing images (eg. qcow2), we resize the
>>> image before write operations that exceed the current size.
>>>
>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>> ---
>>> v3:
>>>   - add 'image_size' field in the BDRVRBDState to keep track of the
>>>     current size of the RBD image [Jason, Kevin]
>>> ---
>>>  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
>>>  1 file changed, 39 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/block/rbd.c b/block/rbd.c
>>> index 0c549c9935..b0355a2ce0 100644
>>> --- a/block/rbd.c
>>> +++ b/block/rbd.c
>>
>> [...]
>>
>>> @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)=

>>>      rados_shutdown(s->cluster);
>>>  }
>>> =20
>>> +/* Resize the RBD image and update the 'image_size' with the current=
 size */
>>> +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
>>> +{
>>> +    BDRVRBDState *s =3D bs->opaque;
>>> +    int r;
>>> +
>>> +    r =3D rbd_resize(s->image, size);
>>> +    if (r < 0) {
>>> +        return r;
>>> +    }
>>> +
>>> +    s->image_size =3D size;
>>
>> I think this should update bs->total_sectors, too.  In fact, I=E2=80=99=
m
>> wondering why you don=E2=80=99t just use bs->total_sectors (or bdrv_ge=
tlength(),
>> which returns bs->total_sectors * 512) instead of adding this new fiel=
d?
>>
>=20
> Hi Max,
> thanks for taking a look!
>=20
> I used bs->total_sectors in the v2, but Jason pointed out a possible
> issue with this, so I proposed to add a variable in the BDRVRBDState to=

> track the latest resize and Kevin acked [1].
>=20
> IIUC what Kevin said on his comment, the 'bs->total_sectors' should be
> updated by bdrv_co_write_req_finish(), for this reason I didn't update
> it.
>=20
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg615195.html

Ah, right!  Yeah, sure, now that I think about it, the block layer must
have general code for successful writes beyond EOF...  (Read: Now that
I=E2=80=99m pointed towards it...)

OK then; thanks for the patch, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--ykgFLyaq93psLZsY9d3tSikgoTA50RrgQ--

--lSVgjTJc3v0zwcaHOcW2VSxiqwtUguOBz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0SNnIACgkQ9AfbAGHV
z0AVSAf/dKPS1JUQEjCWS6OgFH8fCI5kCSXFSDRG97n2VzhozPK49s+7GN7BH7rH
wX/H8ULpyBVFk0rHsIbX5bC7CGzWH206vX/5v6reaMSwY1F/7JvajiJC1wans/Dw
z5Egzg397avw1MtwtlYOXVQjkd8rRsdL1iCwpQl8EMjanv/8cy2cRoOIULtT1LIw
wIJTs82tKZqDgwcZrY5VHVLyrMPMxo3C0sGecBuZr8yHygLhUz+YMB7GIzYN4AhF
tw7ZTUKyrqnFia6O7yUNw30Z41XR6vlMXlNMUaYebf5UsiIUV8UcvyK8a9eAY6Q6
mXD3hOWNFKg0ncJb6riuTAdL2osqjQ==
=inKg
-----END PGP SIGNATURE-----

--lSVgjTJc3v0zwcaHOcW2VSxiqwtUguOBz--

