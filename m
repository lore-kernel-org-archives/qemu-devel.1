Return-Path: <SRS0=huOX=VG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C524C606B0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:46:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43177214AF
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jul 2019 09:46:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43177214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48173 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkmhK-0001TF-90
	for qemu-devel@archiver.kernel.org; Tue, 09 Jul 2019 05:46:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48188)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hkmgm-00010j-5c
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:45:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hkmgj-0008Hb-Sl
 for qemu-devel@nongnu.org; Tue, 09 Jul 2019 05:45:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43808)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hkmgb-0007uJ-W6; Tue, 09 Jul 2019 05:45:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C44648F917;
 Tue,  9 Jul 2019 09:45:20 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-52.brq.redhat.com
 [10.40.204.52])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 777B35DA9B;
 Tue,  9 Jul 2019 09:45:11 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: dillaman@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
 <20190705104318.dngmmu3lpuvbe2nh@steredhat>
 <CA+aFP1AgNGJMdAG_E23Q-rf2Gt1rpeKjDfrk1PLA3f4XiUkGtw@mail.gmail.com>
 <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>
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
Message-ID: <9438ac63-949b-9e08-42a2-4b4ff2c778f8@redhat.com>
Date: Tue, 9 Jul 2019 11:45:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RDHRwO9TAgVW4zTZ06mtcvzbe1P52H1lN"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Tue, 09 Jul 2019 09:45:20 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
 John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RDHRwO9TAgVW4zTZ06mtcvzbe1P52H1lN
Content-Type: multipart/mixed; boundary="YB0Mtu7fdg1qAkIJyScqrwkAlI4uLcMpL";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: dillaman@redhat.com, Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Josh Durgin <jdurgin@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 John Snow <jsnow@redhat.com>
Message-ID: <9438ac63-949b-9e08-42a2-4b4ff2c778f8@redhat.com>
Subject: Re: [PATCH v3] block/rbd: implement .bdrv_get_allocated_file_size
 callback
References: <20190705093258.47856-1-sgarzare@redhat.com>
 <dcc9f3dc-78b4-4216-2791-b7e90f6d79ff@redhat.com>
 <20190705104318.dngmmu3lpuvbe2nh@steredhat>
 <CA+aFP1AgNGJMdAG_E23Q-rf2Gt1rpeKjDfrk1PLA3f4XiUkGtw@mail.gmail.com>
 <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>
In-Reply-To: <754459cc-08c7-6cce-02c6-10f765cb9d00@redhat.com>

--YB0Mtu7fdg1qAkIJyScqrwkAlI4uLcMpL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.07.19 10:55, Max Reitz wrote:
> On 09.07.19 05:08, Jason Dillaman wrote:
>> On Fri, Jul 5, 2019 at 6:43 AM Stefano Garzarella <sgarzare@redhat.com=
> wrote:
>>>
>>> On Fri, Jul 05, 2019 at 11:58:43AM +0200, Max Reitz wrote:
>>>> On 05.07.19 11:32, Stefano Garzarella wrote:
>>>>> This patch allows 'qemu-img info' to show the 'disk size' for
>>>>> the RBD images that have the fast-diff feature enabled.
>>>>>
>>>>> If this feature is enabled, we use the rbd_diff_iterate2() API
>>>>> to calculate the allocated size for the image.
>>>>>
>>>>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>>>>> ---
>>>>> v3:
>>>>>   - return -ENOTSUP instead of -1 when fast-diff is not available
>>>>>     [John, Jason]
>>>>> v2:
>>>>>   - calculate the actual usage only if the fast-diff feature is
>>>>>     enabled [Jason]
>>>>> ---
>>>>>  block/rbd.c | 54 +++++++++++++++++++++++++++++++++++++++++++++++++=
++++
>>>>>  1 file changed, 54 insertions(+)
>>>>
>>>> Well, the librbd documentation is non-existing as always, but while
>>>> googling, I at least found that libvirt has exactly the same code.  =
So I
>>>> suppose it must be quite correct, then.
>>>>
>>>
>>> While I wrote this code I took a look at libvirt implementation and a=
lso
>>> at the "rbd" tool in the ceph repository: compute_image_disk_usage() =
in
>>> src/tools/rbd/action/DiskUsage.cc
>>>
>>>>> diff --git a/block/rbd.c b/block/rbd.c
>>>>> index 59757b3120..b6bed683e5 100644
>>>>> --- a/block/rbd.c
>>>>> +++ b/block/rbd.c
>>>>> @@ -1084,6 +1084,59 @@ static int64_t qemu_rbd_getlength(BlockDrive=
rState *bs)
>>>>>      return info.size;
>>>>>  }
>>>>>
>>>>> +static int rbd_allocated_size_cb(uint64_t offset, size_t len, int =
exists,
>>>>> +                                 void *arg)
>>>>> +{
>>>>> +    int64_t *alloc_size =3D (int64_t *) arg;
>>>>> +
>>>>> +    if (exists) {
>>>>> +        (*alloc_size) +=3D len;
>>>>> +    }
>>>>> +
>>>>> +    return 0;
>>>>> +}
>>>>> +
>>>>> +static int64_t qemu_rbd_get_allocated_file_size(BlockDriverState *=
bs)
>>>>> +{
>>>>> +    BDRVRBDState *s =3D bs->opaque;
>>>>> +    uint64_t flags, features;
>>>>> +    int64_t alloc_size =3D 0;
>>>>> +    int r;
>>>>> +
>>>>> +    r =3D rbd_get_flags(s->image, &flags);
>>>>> +    if (r < 0) {
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    r =3D rbd_get_features(s->image, &features);
>>>>> +    if (r < 0) {
>>>>> +        return r;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * We use rbd_diff_iterate2() only if the RBD image have fast-=
diff
>>>>> +     * feature enabled. If it is disabled, rbd_diff_iterate2() cou=
ld be
>>>>> +     * very slow on a big image.
>>>>> +     */
>>>>> +    if (!(features & RBD_FEATURE_FAST_DIFF) ||
>>>>> +        (flags & RBD_FLAG_FAST_DIFF_INVALID)) {
>>>>> +        return -ENOTSUP;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * rbd_diff_iterate2(), if the source snapshot name is NULL, i=
nvokes
>>>>> +     * the callback on all allocated regions of the image.
>>>>> +     */
>>>>> +    r =3D rbd_diff_iterate2(s->image, NULL, 0,
>>>>> +                          bs->total_sectors * BDRV_SECTOR_SIZE, 0,=
 1,
>>>>> +                          &rbd_allocated_size_cb, &alloc_size);
>>>>
>>>> But I have a question.  This is basically block_status, right?  So i=
t
>>>> gives us information on which areas are allocated and which are not.=

>>>> The result thus gives us a lower bound on the allocation size, but i=
s it
>>>> really exactly the allocation size?
>>>>
>>>> There are two things I=E2=80=99m concerned about:
>>>>
>>>> 1. What about metadata?
>>>
>>> Good question, I don't think it includes the size used by metadata an=
d I
>>> don't know if there is a way to know it. I'll check better.
>>
>> It does not include the size of metadata, the "rbd_diff_iterate2"
>> function is literally just looking for touched data blocks within the
>> RBD image.
>>
>>>>
>>>> 2. If you have multiple snapshots, this will only report the overall=

>>>> allocation information, right?  So say there is something like this:=

>>>>
>>>> (=E2=80=9CA=E2=80=9D means an allocated MB, =E2=80=9C-=E2=80=9D is a=
n unallocated MB)
>>>>
>>>> Snapshot 1: AAAA---
>>>> Snapshot 2: --AAAAA
>>>> Snapshot 3: -AAAA--
>>>>
>>>> I think the allocated data size is the number of As in total (13 MB)=
=2E
>>>> But I suppose this API will just return 7 MB, because it looks on
>>>> everything an it sees the whole image range (7 MB) to be allocated. =
 It
>>>> doesn=E2=80=99t report in how many snapshots some region is allocate=
d.
>>
>> It should return 13 dirty data blocks (multipled by the size of the
>> data block) since when you don't provide a "from snapshot" name, it
>> will iterate from the first snapshot to the HEAD revision.
>=20
> Have you tested that?
>=20
> I=E2=80=98m so skeptical because the callback function interface has no=
 way of
> distinguishing between different layers of snapshots.
>=20
> And also because we have the bdrv_block_status_above() function which
> just looks strikingly similar (with the difference that it does not
> invoke a callback but just returns the next allocated range).  If you
> pass base=3DNULL to it, it will also =E2=80=9Cinterpret that as the beg=
inning of
> time and return all allocated regions of the image=E2=80=9D (or rather =
image
> chain, in our case).  But it would just return 7 MB as allocated.  (Eve=
n
> though it does in fact return layer information, i.e. where a given
> continuous chunk of data is allocated.)
>=20
> Sure, there is no good reason for why our interface should by chance be=

> the same as librbd=E2=80=99s interface.  But without having tested it, =
the fact
> that the callback cannot detect which layer a chunk is allocated on jus=
t
> makes me wary.

And the librbd code doesn=E2=80=99t alleviate my concerns.

=46rom what I can see, it first creates a bitmap (two bits per entry) tha=
t
covers the whole image and says which objects are allocated and which
aren=E2=80=98t.  Through the whole chain, that is.  So in the above examp=
le, the
bitmap would report everything as allocated.  (Or rather =E2=80=9Cupdated=
=E2=80=9C in
librbd=E2=80=98s terms.)

Then it has this piece:

>   uint64_t off =3D m_offset;
>   uint64_t left =3D m_length;
>=20
>   while (left > 0) {
>     uint64_t period_off =3D off - (off % period);                      =
                                                                         =
   =20
>     uint64_t read_len =3D min(period_off + period - off, left);
>=20
>     // map to extents
>     map<object_t,vector<ObjectExtent> > object_extents;
>     Striper::file_to_extents(cct, m_image_ctx.format_string,
>                              &m_image_ctx.layout, off, read_len, 0,
>                              object_extents, 0);
>=20
>     // get snap info for each object
>     for (map<object_t,vector<ObjectExtent> >::iterator p =3D
>            object_extents.begin();
>          p !=3D object_extents.end(); ++p)=20
[...]
>           for (std::vector<ObjectExtent>::iterator q =3D p->second.begi=
n();
>                q !=3D p->second.end(); ++q) {
>             r =3D m_callback(off + q->offset, q->length, updated, m_cal=
lback_arg);
[...]
>           }
[...]
>     }
>>     left -=3D read_len;
>     off +=3D read_len;
>   }

So that iterates over the whole image (in our case, because m_offset is
0 and m_length is the image length), then picks out a chunk of read_len
length, converts that to objects, and then iterates over all of those
objects and all of their extents.

file_to_extents looks like it=E2=80=99s just an arithmetic operation.  So=
 it
doesn=E2=80=98t look like that function returns extents in multiple snaps=
hots.
It just converts a range into subranges called =E2=80=9Cobjects=E2=80=9D =
and =E2=80=9Cextents=E2=80=9D
(at least that=E2=80=99s the way it looks to me).

So overall, this looks awfully like it simply iterates over the whole
image and then returns allocation information gathered as a top-down
view through all of the snapshots, but not for each snapshot individually=
=2E

Max


--YB0Mtu7fdg1qAkIJyScqrwkAlI4uLcMpL--

--RDHRwO9TAgVW4zTZ06mtcvzbe1P52H1lN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0kYiUACgkQ9AfbAGHV
z0BLCQgApq4AyGqixdoo43fOj0rrvd7FpW3ywO5wSj6nfDzSZyH+FK6tY/xMbbd2
iC8j2yxV4gwudvbrcbcIsybHpP8/v8vKYOKAJ7WILfui9jGp3LFGOAQCfXnQL+cN
mPSJIs8Qfkz3J9z/heEf5cgE1pZyuZGY31lHIur3i6lPfK3lRSFPfqJ85ckIxX1t
Pe3UpLo+gHEIW6NJ6O9Eic98tfwpAPoU0++7VmF61gOwxafbp59v+nh2ntleT/Po
6NXeoqe77CFLI2fXk8Vb/WOa+VWrFknaUAPDN9dceSF964uFNq8TGB973wVUTdrE
N5vw0w8OIsm/3/DXGIImNQvsDb686A==
=5ERq
-----END PGP SIGNATURE-----

--RDHRwO9TAgVW4zTZ06mtcvzbe1P52H1lN--

