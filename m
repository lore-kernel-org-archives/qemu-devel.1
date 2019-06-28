Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9347C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:28:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2AC22086D
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 16:28:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2AC22086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34066 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgtjP-0001XV-SO
	for qemu-devel@archiver.kernel.org; Fri, 28 Jun 2019 12:28:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hgsPn-0003PK-Q4
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:03:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hgsPi-0005Z2-4E
 for qemu-devel@nongnu.org; Fri, 28 Jun 2019 11:03:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hgsPd-0005VD-KA; Fri, 28 Jun 2019 11:03:41 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E590B81DEB;
 Fri, 28 Jun 2019 15:03:34 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.5])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8E8FE5DD6D;
 Fri, 28 Jun 2019 15:03:31 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
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
Message-ID: <c9e17ca7-db6a-8479-3caf-1f19fa3d7016@redhat.com>
Date: Fri, 28 Jun 2019 17:03:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="e72TcYXPN1ccLOgezAwkMJOeoUwP8kTaF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Fri, 28 Jun 2019 15:03:35 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v0 2/3] qcow2: add compression type
 processing
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
 Denis Lunev <den@virtuozzo.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e72TcYXPN1ccLOgezAwkMJOeoUwP8kTaF
Content-Type: multipart/mixed; boundary="9gIAJYw8hAwUV0V2D04OR86lNs09ruuzJ";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Denis Plotnikov <dplotnikov@virtuozzo.com>
Cc: "eblake@redhat.com" <eblake@redhat.com>,
 "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Denis Lunev <den@virtuozzo.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <c9e17ca7-db6a-8479-3caf-1f19fa3d7016@redhat.com>
Subject: Re: [PATCH v0 2/3] qcow2: add compression type processing
References: <20190528143727.10529-1-dplotnikov@virtuozzo.com>
 <20190528143727.10529-3-dplotnikov@virtuozzo.com>
 <20190628102333.GG5179@dhcp-200-226.str.redhat.com>
 <08da0859-10da-5d4b-3203-72341a166255@virtuozzo.com>
 <20190628120622.GI5179@dhcp-200-226.str.redhat.com>
 <4fef0430-5a0c-36ca-eec0-a2c0ce10cb91@virtuozzo.com>
 <20190628142437.GL5179@dhcp-200-226.str.redhat.com>
 <bf5134a7-7c5e-2b28-9acb-3b82df982e1e@virtuozzo.com>
 <20190628145419.GM5179@dhcp-200-226.str.redhat.com>
In-Reply-To: <20190628145419.GM5179@dhcp-200-226.str.redhat.com>

--9gIAJYw8hAwUV0V2D04OR86lNs09ruuzJ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.06.19 16:54, Kevin Wolf wrote:
> Am 28.06.2019 um 16:40 hat Denis Plotnikov geschrieben:
>>
>>
>> On 28.06.2019 17:24, Kevin Wolf wrote:
>>> Am 28.06.2019 um 14:56 hat Denis Plotnikov geschrieben:
>>>>
>>>>
>>>> On 28.06.2019 15:06, Kevin Wolf wrote:
>>>>> Am 28.06.2019 um 13:24 hat Denis Plotnikov geschrieben:
>>>>>>
>>>>>>
>>>>>> On 28.06.2019 13:23, Kevin Wolf wrote:
>>>>>>> Am 28.05.2019 um 16:37 hat Denis Plotnikov geschrieben:
>>>>>>>> With the patch, qcow2 is able to process image compression type
>>>>>>>> defined in the image header and choose the corresponding method
>>>>>>>> for clusters compressing.
>>>>>>>>
>>>>>>>> Also, it rework the cluster compression code for adding more
>>>>>>>> compression types.
>>>>>>>>
>>>>>>>> Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
>>>>>>>> ---
>>>>>>>>     block/qcow2.c | 103 ++++++++++++++++++++++++++++++++++++++++=
++++------
>>>>>>>>     1 file changed, 92 insertions(+), 11 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/block/qcow2.c b/block/qcow2.c
>>>>>>>> index c4b5b93408..90f15cc3c9 100644
>>>>>>>> --- a/block/qcow2.c
>>>>>>>> +++ b/block/qcow2.c
>>>>>>>> @@ -400,11 +400,39 @@ static int qcow2_read_extensions(BlockDriv=
erState *bs, uint64_t start_offset,
>>>>>>>>                 break;
>>>>>>>>    =20
>>>>>>>>             case QCOW2_EXT_MAGIC_COMPRESSION_TYPE:
>>>>>>>> +            /* Compression type always goes with the compressio=
n type bit set */
>>>>>>>> +            if (!(s->incompatible_features & QCOW2_INCOMPAT_COM=
PRESSION_TYPE)) {
>>>>>>>> +                error_setg(errp,
>>>>>>>> +                           "compression_type_ext: "
>>>>>>>> +                           "expect compression type bit set");
>>>>>>>> +                return -EINVAL;
>>>>>>>> +            }
>>>>>>>> +
>>>>>>>> +            ret =3D bdrv_pread(bs->file, offset, &s->compressio=
n_type, ext.len);
>>>>>>>> +            s->compression_type =3D be32_to_cpu(s->compression_=
type);
>>>>>>>> +
>>>>>>>> +            if (ret < 0) {
>>>>>>>> +                error_setg_errno(errp, -ret,
>>>>>>>> +                                 "ERROR: Could not read compres=
sion type");
>>>>>>>> +                return ret;
>>>>>>>> +            }
>>>>>>>> +
>>>>>>>>                 /*
>>>>>>>> -             * Setting compression type to BDRVQcow2State->comp=
ression_type
>>>>>>>> -             * from the image header is going to be here
>>>>>>>> +             * The default compression type is not allowed when=
 the extension
>>>>>>>> +             * is present. ZLIB is used as the default compress=
ion type.
>>>>>>>> +             * When compression type extension header is presen=
t then
>>>>>>>> +             * compression_type should have a value different f=
rom the default.
>>>>>>>>                  */
>>>>>>>> -             break;
>>>>>>>> +            if (s->compression_type =3D=3D QCOW2_COMPRESSION_TY=
PE_ZLIB) {
>>>>>>>> +                error_setg(errp,
>>>>>>>> +                           "compression_type_ext:"
>>>>>>>> +                           "invalid compression type %d",
>>>>>>>> +                           QCOW2_COMPRESSION_TYPE_ZLIB);
>>>>>>>> +            }
>>>>>>>
>>>>>>> This is a restriction that the spec doesn't make, so strictly spe=
aking
>>>>>>> this implementation wouldn't be compliant to the spec.
>>>>>> The idea is that ZLIB shouldn't appear in the compression type
>>>>>> extension. This allows image backward compatibility with an older =
qemu
>>>>>> if zlib is used.
>>>>>>
>>>>>> There is no reason to set ZLIB in the extension because an older q=
emu
>>>>>> knows how to tread ZLIB compressed clusters.
>>>>>>
>>>>>> The restriction aims to guarantee that.
>>>>>>
>>>>>> I tried to describe this case in the specification:
>>>>>> ...
>>>>>> When the compression type bit is not set, and the compression type=

>>>>>> header extension is absent, ZLIB compression is used for compresse=
d
>>>>>> clusters.
>>>>>>
>>>>>> Qemu versions older than 4.1 can use images created with compressi=
on
>>>>>> type ZLIB without any additional preparations and cannot use image=
s
>>>>>> created with compression types !=3D ZLIB.
>>>>>> ...
>>>>>>
>>>>>> Does it makes sense?
>>>>>
>>>>> This text says that using zlib in the extension is not necessary be=
cause
>>>>> it's the default. But it doesn't say that using zlib in the extensi=
on is
>>>>> illegal.
>>>>>
>>>>> I agree that there is no good reason to create a compression type
>>>>> extension if you have zlib. But is there a good reason to forbid it=
?
>>>> I think yes, if we create image with the extension set to zlib we
>>>> prevent an older qemu from using that image. Furthermore, to allow o=
lder
>>>> qemu using such images we need to create special conversion procedur=
e
>>>> which has to remove the extension header.
>>>>
>>>> If zlib is a "special compression type" which is always set by defau=
lt
>>>> without the extension header we'll get rid of such image conversion
>>>> procedure and an older qemu could use it "as is"
>>>>
>>>> Might it work as a good reason?
>>>>
>>>>> It
>>>>> only requires us to add artificial restrictions to code that would =
work
>>>>> fine without them.
>>>>>
>>>>> Either way, if we want to reject such extensions, the spec needs to=
 say
>>>>> that it's illegal. And if the spec allows such images, we must acce=
pt
>>>>> them.
>>>> Yes, it's true
>>>>
>>>> The only reasons that zlib compression type even exists in the
>>>> enumeration is to avoid ambiguity for users.
>>>> For them it may be hard to understand why they can set zstd and cann=
ot
>>>> set zlib as compression type and to really set zlib they have to set=
 no
>>>> compression type to make the default zlib to apply.
>>>>
>>>> When a user set zlib as compression type the image is created as bef=
ore
>>>> the extension header were introduced.
>>>>
>>>> Reasonable?
>>>>>
>>>>>>> We can discuss whether the code or the spec should be changed. At=
 the
>>>>>>> moment, I don't see a good reason to make the restriction
>>>>>>>
>>>>>>>> +#ifdef DEBUG_EXT
>>>>>>>> +            printf("Qcow2: image compression type %s\n", s->com=
pression_type);
>>>>>>>> +#endif
>>>>>>>> +            break;
>>>>>>>>    =20
>>>>>>>>             case QCOW2_EXT_MAGIC_DATA_FILE:
>>>>>>>>             {
>>>>>>>
>>>>>>> We would save most of this code if we added a new field to the he=
ader
>>>>>>> instead of adding a header extension. Not saying that we should
>>>>>>> definitely do this, but let's discuss it at least.
>>>>>>
>>>>>> If we add the new field to the header will the older qemu be able =
to use
>>>>>> it. Or we will add the header only if needed, i.e. if compression_=
type
>>>>>> !=3D zlib
>>>>>
>>>>> Increasing the header size is backwards compatible. Older qemu vers=
ions
>>>>> should handle such images correctly. They would store the unknown p=
art
>>>>> of the header in s->unknown_header_fields and keep it unmodified wh=
en
>>>>> updating the image header.
>>>>>
>>>>> We would still add the incompatible feature flag for non-zlib, of
>>>>> course.
>>>> so, we basically need to do the same: store compression type and for=
bid
>>>> to use because of flag if not zlib.
>>>>
>>>> Sounds like it doesn't differ that much from the extension header ap=
proach.
>>>
>>> It provides more or less the same functionality, but would probably m=
ake
>>> this patch half the size because all of the code related to reading a=
nd
>>> checking the header extension would go away. It also saves a few byte=
s
>>> in the header cluster (4 bytes vs. 16 bytes).
>> ok, will re-do it that way.
>>
>> Do you agree in general with how zlib compression type is treated?
>=20
> As I said, I think both ways are justifiable as long as we stay
> consistent between qemu and spec.
>=20
> I'd prefer to allow zlib in the extension, you'd prefer to forbid it.
> So I'd like to hear opinions from some more people on which way they
> prefer.

I don=E2=80=99t think it=E2=80=99s any better to completely forbid it tha=
n to just
recommend in the spec that software should not set this field to zlib to
ensure backwards compatibility.

I see the point of forbidding it, but if I were to know nothing of qcow2
and read the spec, I guess I=E2=80=99d find it a bit weird to read =E2=80=
=9CIf this
field is not present, the compression type is zlib; if it is, it is not
zlib, but the specified value.=E2=80=9D  I=E2=80=99d ask myself why it is=
n=E2=80=99t simply =E2=80=9CThe
compression type is given by this field, it defaults to zlib.=E2=80=9D

Max


--9gIAJYw8hAwUV0V2D04OR86lNs09ruuzJ--

--e72TcYXPN1ccLOgezAwkMJOeoUwP8kTaF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0WLEEACgkQ9AfbAGHV
z0CKxgf8Ca9VtMwDGip9kdjPcYbHiY17GPETQeR0X6ZMiUZaZE9lRxmXad39pzoV
OpHl2BeWW0UqHJnZyGLSvBa6M2om+pXLGcDvE4g9SOkWFib+ddx10XpwItfCCh8C
TlKgeEPD0ur7z+Blqz3nEEIth9h3VfZxy6Wgcp19id71wSl2a076340AkGVL6XwT
daSnphBycEWTKVPc4Gxq9TTg2CwSPRFnX13Iz7settqhlfcPWIGV3IDEb3J9Na8t
HosGxiunrPUxsB7yOQ+5MnTgjXlsNdCmF2QAyQ4kceQ4kdPSi7HhLazCNgzdg82p
zo57gBqw0KLKA8rPqCr0P/8SYn5v8A==
=1aYe
-----END PGP SIGNATURE-----

--e72TcYXPN1ccLOgezAwkMJOeoUwP8kTaF--

