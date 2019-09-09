Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF620C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6281206CD
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 14:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6281206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57314 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7KW1-0004HC-Rp
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 10:19:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38969)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7KSo-00023O-Vm
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:16:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7KSn-0000qK-Nu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 10:16:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45616)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7KSg-0000mi-Su; Mon, 09 Sep 2019 10:16:11 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B4D378AC6FF;
 Mon,  9 Sep 2019 14:16:04 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-179.ams2.redhat.com
 [10.36.116.179])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DB1D160BE2;
 Mon,  9 Sep 2019 14:16:01 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-17-mreitz@redhat.com>
 <b2f43475-224e-5003-2c51-3949e9fb2d42@virtuozzo.com>
 <e18b1eed-6d7a-603b-f8ad-4c56795309c2@redhat.com>
 <20190905162407.GD4911@localhost.localdomain>
 <af64f1db-c35b-351f-d65f-179775010d00@redhat.com>
 <20190909100147.GC17606@localhost.localdomain>
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
Message-ID: <bbf051b7-7ee2-3e3d-e226-feab2526a551@redhat.com>
Date: Mon, 9 Sep 2019 16:15:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190909100147.GC17606@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nt4jewN1rFFqeSQhFJPZVGG1Ouqr3TISY"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 09 Sep 2019 14:16:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 16/42] block: Flush all children in
 generic code
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
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Nt4jewN1rFFqeSQhFJPZVGG1Ouqr3TISY
Content-Type: multipart/mixed; boundary="26x3pPfWbISwqCNzhi0bgr8xP5c7FRKx8";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Message-ID: <bbf051b7-7ee2-3e3d-e226-feab2526a551@redhat.com>
Subject: Re: [PATCH v6 16/42] block: Flush all children in generic code
References: <20190809161407.11920-1-mreitz@redhat.com>
 <20190809161407.11920-17-mreitz@redhat.com>
 <b2f43475-224e-5003-2c51-3949e9fb2d42@virtuozzo.com>
 <e18b1eed-6d7a-603b-f8ad-4c56795309c2@redhat.com>
 <20190905162407.GD4911@localhost.localdomain>
 <af64f1db-c35b-351f-d65f-179775010d00@redhat.com>
 <20190909100147.GC17606@localhost.localdomain>
In-Reply-To: <20190909100147.GC17606@localhost.localdomain>

--26x3pPfWbISwqCNzhi0bgr8xP5c7FRKx8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 12:01, Kevin Wolf wrote:
> Am 09.09.2019 um 10:31 hat Max Reitz geschrieben:
>> On 05.09.19 18:24, Kevin Wolf wrote:
>>> Am 12.08.2019 um 14:58 hat Max Reitz geschrieben:
>>>> On 10.08.19 17:36, Vladimir Sementsov-Ogievskiy wrote:
>>>>> 09.08.2019 19:13, Max Reitz wrote:
>>>>>> If the driver does not support .bdrv_co_flush() so bdrv_co_flush()=

>>>>>> itself has to flush the children of the given node, it should not =
flush
>>>>>> just bs->file->bs, but in fact all children.
>>>>>>
>>>>>> In any case, the BLKDBG_EVENT() should be emitted on the primary c=
hild,
>>>>>> because that is where a blkdebug node would be if there is any.
>>>>>>
>>>>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.c=
om>
>>>>>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>>>>>> ---
>>>>>>   block/io.c | 23 +++++++++++++++++------
>>>>>>   1 file changed, 17 insertions(+), 6 deletions(-)
>>>>>>
>>>>>> diff --git a/block/io.c b/block/io.c
>>>>>> index c5a8e3e6a3..bcc770d336 100644
>>>>>> --- a/block/io.c
>>>>>> +++ b/block/io.c
>>>>>> @@ -2572,6 +2572,8 @@ static void coroutine_fn bdrv_flush_co_entry=
(void *opaque)
>>>>>>  =20
>>>>>>   int coroutine_fn bdrv_co_flush(BlockDriverState *bs)
>>>>>>   {
>>>>>> +    BdrvChild *primary_child =3D bdrv_primary_child(bs);
>>>>>> +    BdrvChild *child;
>>>>>>       int current_gen;
>>>>>>       int ret =3D 0;
>>>>>>  =20
>>>>>> @@ -2601,7 +2603,7 @@ int coroutine_fn bdrv_co_flush(BlockDriverSt=
ate *bs)
>>>>>>       }
>>>>>>  =20
>>>>>>       /* Write back cached data to the OS even with cache=3Dunsafe=
 */
>>>>>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_OS);
>>>>>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_OS);
>>>>>>       if (bs->drv->bdrv_co_flush_to_os) {
>>>>>>           ret =3D bs->drv->bdrv_co_flush_to_os(bs);
>>>>>>           if (ret < 0) {
>>>>>> @@ -2611,15 +2613,15 @@ int coroutine_fn bdrv_co_flush(BlockDriver=
State *bs)
>>>>>>  =20
>>>>>>       /* But don't actually force it to the disk with cache=3Dunsa=
fe */
>>>>>>       if (bs->open_flags & BDRV_O_NO_FLUSH) {
>>>>>> -        goto flush_parent;
>>>>>> +        goto flush_children;
>>>>>>       }
>>>>>>  =20
>>>>>>       /* Check if we really need to flush anything */
>>>>>>       if (bs->flushed_gen =3D=3D current_gen) {
>>>>>> -        goto flush_parent;
>>>>>> +        goto flush_children;
>>>>>>       }
>>>>>>  =20
>>>>>> -    BLKDBG_EVENT(bs->file, BLKDBG_FLUSH_TO_DISK);
>>>>>> +    BLKDBG_EVENT(primary_child, BLKDBG_FLUSH_TO_DISK);
>>>>>>       if (!bs->drv) {
>>>>>>           /* bs->drv->bdrv_co_flush() might have ejected the BDS
>>>>>>            * (even in case of apparent success) */
>>>>>> @@ -2663,8 +2665,17 @@ int coroutine_fn bdrv_co_flush(BlockDriverS=
tate *bs)
>>>>>>       /* Now flush the underlying protocol.  It will also have BDR=
V_O_NO_FLUSH
>>>>>>        * in the case of cache=3Dunsafe, so there are no useless fl=
ushes.
>>>>>>        */
>>>>>> -flush_parent:
>>>>>> -    ret =3D bs->file ? bdrv_co_flush(bs->file->bs) : 0;
>>>>>> +flush_children:
>>>>>> +    ret =3D 0; > +    QLIST_FOREACH(child, &bs->children, next) {=

>>>>>> +        int this_child_ret;
>>>>>> +
>>>>>> +        this_child_ret =3D bdrv_co_flush(child->bs);
>>>>>> +        if (!ret) {
>>>>>> +            ret =3D this_child_ret;
>>>>>> +        }
>>>>>> +    }
>>>>>
>>>>> Hmm, you said that we want to flush only children with write-access=
 from parent..
>>>>
>>>> Good that you remember it, I must have overlooked it (when reading t=
he
>>>> replies to the previous version). :-)
>>>>
>>>>> Shouldn't we check it? Or we assume that it's always safe to call b=
drv_co_flush on
>>>>> a node?
>>>>
>>>> I think it=E2=80=99s always safe.  But checking it seems like a nice=
 touch, yes.
>>>
>>> I'm not sure why we would unconditionally flush all children anyway. =
The
>>> only drivers I can think of that really need to flush more than one
>>> child are blkverify and quorum, and both of them already implement th=
is.
>>> blkverify implements .bdrv_co_flush, so it's not affected by the chan=
ge
>>> anyway, but quorum children will be flushed twice now.
>>>
>>> But more than this, I'm worried about the overhead of needlessly
>>> recursing through the whole backing chain and calling flush on every
>>> node there.  Maybe bs->write_gen saves us so that at least this doesn=
't
>>> result in an fdatasync() call for each, but still... Without a use ca=
se,
>>> I'd rather not do this.
>>>
>>> Oh, well, after having written all of this, I see that qcow2 with an
>>> external data file is buggy... This could be fixed in the qcow2 drive=
r,
>>> but maybe restricting the recursion to read-only is actually good eno=
ugh
>>> then. Can you mention this case in the commit message and maybe build=
 a
>>> test for it?
>>
>> And I should thus probably drop vmdk=E2=80=99s .bdrv_co_flush_to_disk(=
)
>> implementation.
>>
>> I will indeed try to write a test, but to be completely honest, I feel=

>> like this series is long enough.
>=20
> I guess I could already merge patch 1 to give you space for another tes=
t
> patch. ;-)

Don=E2=80=99t forget the mirror-top patch.  And AFAIR, there was some com=
ment
from Vladimir that also required an additional patch.  So it would need
to be three!

(Or I just start squashing from the back?)

Max


--26x3pPfWbISwqCNzhi0bgr8xP5c7FRKx8--

--Nt4jewN1rFFqeSQhFJPZVGG1Ouqr3TISY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl12Xp8ACgkQ9AfbAGHV
z0BiCgf6AolUlNgvWp1zT6dLVUww2V9aQzlLaGhZEC2e61rXKpXX3vAOoGQn3DPm
fCAPIT1d+/Cm4MWmTpF9nlvK4FmtYiN7Og4C3BqKQ53zseR9mo24aSqgR8izjQfH
ONWsBPGuI2p1hU6A7Bvf525rMJ0jAXhwOqlsu0eUo3oJAAyBOHq1IPe04j5zEWIq
OA+IMex8aiRJ43UdLDH6mg1P1bpLQKWq2TmQgWg5hiRC+yTIZ99CdJD/xW3Gxa1D
QXsu/j5OjOOibr9C9VMAwI3C4CHRTFyFjIG+YthvSlmj7Z42la6iscxovjEP/IHo
e/N/iYo/QALNovKTllNz+OSPfqDlzw==
=v8hJ
-----END PGP SIGNATURE-----

--Nt4jewN1rFFqeSQhFJPZVGG1Ouqr3TISY--

