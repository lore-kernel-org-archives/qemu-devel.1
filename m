Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63821C742D7
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:33:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29557205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 18:33:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29557205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hm0Ma-0007vW-4Z
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 14:33:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57454)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hm0MI-0007Jv-Te
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:33:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hm0ME-0001pU-Mj
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 14:33:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50294)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hm0MB-0001ns-3K; Fri, 12 Jul 2019 14:33:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0595A8762F;
 Fri, 12 Jul 2019 18:33:18 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.208])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 752031F8;
 Fri, 12 Jul 2019 18:33:16 +0000 (UTC)
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190711132935.13070-1-mreitz@redhat.com>
 <20190712102735.ea5f4aqqgok7qdxa@steredhat>
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
Message-ID: <b77578d8-3da7-e0c7-75db-69f078cfcbda@redhat.com>
Date: Fri, 12 Jul 2019 20:33:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190712102735.ea5f4aqqgok7qdxa@steredhat>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7sRMgQkiwau2DWpIftrvkujfrL7HZZZco"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Fri, 12 Jul 2019 18:33:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] doc: Preallocation does not
 require writing zeroes
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7sRMgQkiwau2DWpIftrvkujfrL7HZZZco
Content-Type: multipart/mixed; boundary="n1NRKKs5uUEUqqJEv0jawCciiF1AGTEmz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Message-ID: <b77578d8-3da7-e0c7-75db-69f078cfcbda@redhat.com>
Subject: Re: [Qemu-block] [PATCH] doc: Preallocation does not require writing
 zeroes
References: <20190711132935.13070-1-mreitz@redhat.com>
 <20190712102735.ea5f4aqqgok7qdxa@steredhat>
In-Reply-To: <20190712102735.ea5f4aqqgok7qdxa@steredhat>

--n1NRKKs5uUEUqqJEv0jawCciiF1AGTEmz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.07.19 12:27, Stefano Garzarella wrote:
> On Thu, Jul 11, 2019 at 03:29:35PM +0200, Max Reitz wrote:
>> When preallocating an encrypted qcow2 image, it just lets the protocol=

>> driver write data and then does not mark the clusters as zero.
>> Therefore, reading this image will yield effectively random data.
>>
>> As such, we have not fulfilled the promise of always writing zeroes wh=
en
>> preallocating an image in a while.  It seems that nobody has really
>> cared, so change the documentation to conform to qemu's actual behavio=
r.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  qapi/block-core.json         | 9 +++++----
>>  docs/qemu-block-drivers.texi | 4 ++--
>>  qemu-img.texi                | 4 ++--
>>  3 files changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/qapi/block-core.json b/qapi/block-core.json
>> index 0d43d4f37c..a4363b84d2 100644
>> --- a/qapi/block-core.json
>> +++ b/qapi/block-core.json
>> @@ -5167,10 +5167,11 @@
>>  # @off: no preallocation
>>  # @metadata: preallocate only for metadata
>>  # @falloc: like @full preallocation but allocate disk space by
>> -#          posix_fallocate() rather than writing zeros.
>> -# @full: preallocate all data by writing zeros to device to ensure di=
sk
>> -#        space is really available. @full preallocation also sets up
>> -#        metadata correctly.
>> +#          posix_fallocate() rather than writing data.
>> +# @full: preallocate all data by writing it to the device to ensure
>> +#        disk space is really available. This data may or may not be
>> +#        zero, depending on the image format and storage.
>> +#        @full preallocation also sets up metadata correctly.
>>  #
>>  # Since: 2.2
>>  ##
>> diff --git a/docs/qemu-block-drivers.texi b/docs/qemu-block-drivers.te=
xi
>> index 91ab0eceae..c02547e28c 100644
>> --- a/docs/qemu-block-drivers.texi
>> +++ b/docs/qemu-block-drivers.texi
>> @@ -31,8 +31,8 @@ Supported options:
>>  @item preallocation
>>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{=
full}).
>>  @code{falloc} mode preallocates space for image by calling posix_fall=
ocate().
>> -@code{full} mode preallocates space for image by writing zeros to und=
erlying
>> -storage.
>> +@code{full} mode preallocates space for image by writing data to unde=
rlying
>> +storage.  This data may or may not be zero, depending on the storage =
location.
>>  @end table
>> =20
>>  @item qcow2
>> diff --git a/qemu-img.texi b/qemu-img.texi
>> index c8e9bba515..b5156d6316 100644
>> --- a/qemu-img.texi
>> +++ b/qemu-img.texi
>> @@ -666,8 +666,8 @@ Supported options:
>>  @item preallocation
>>  Preallocation mode (allowed values: @code{off}, @code{falloc}, @code{=
full}).
>>  @code{falloc} mode preallocates space for image by calling posix_fall=
ocate().
>> -@code{full} mode preallocates space for image by writing zeros to und=
erlying
>> -storage.
>> +@code{full} mode preallocates space for image by writing data to unde=
rlying
>> +storage.  This data may or may not be zero, depending on the storage =
location.
>>  @end table
>> =20
>>  @item qcow2
>=20
> Just a question:

But a very good one, actually.

> if a protocol driver returns 1 with the .bdrv_has_zero_init callback, i=
s it
> expected that the preallocation will fill the image with zeroes?

Yes.

> IIUC, for example, the qcow2 returns 1 with the .bdrv_has_zero_init. bu=
t during
> the qcow2_co_truncate() it calls bdrv_co_truncate() and, depending on t=
he
> backend driver, it should fill the image with zeroes (or not?).

Yes.

> Maybe I miss something related to the metadata...

Well.  If the image isn=E2=80=99t preallocated, all will be well because =
nothing
of the added range is entered into the metadata, so it returns zero when
read (unless there is a backing file, but that is handled independently
of has_zero_init).

But you were asking about preallocation.  As I wrote in the commit
message, the qcow2 driver lets the protocol driver preallocate the data
and then enters it as normal data clusters into its metadata.  If the
image is encrypted, it will appears as random data (or if the protocol
dirver writes non-zero data).  But then it shouldn=E2=80=99t report
has_zero_init as 1.

Let=E2=80=99s test it.

$ qemu-img create -f qcow2 src.qcow2 64M
Formatting 'src.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65536
lazy_refcounts=3Doff refcount_bits=3D16
$ qemu-img convert -O qcow2 \
    -o \
    encrypt.format=3Dluks,encrypt.key-secret=3Dpass,preallocation=3Dmetad=
ata \
    --object secret,id=3Dpass,data=3D123456 \
    src.qcow2 dest.qcow2
$ qemu-img compare --image-opts \
    file.filename=3Dsrc.qcow2 \
    file.filename=3Ddest.qcow2,encrypt.key-secret=3Dpass \
    --object secret,id=3Dpass,data=3D123456
Content mismatch at offset 0!

Oops.


So.  We can do two things here.

(A) We drop this patch and actually make sure that preallocation always
writes zeroes, and if that cannot be done efficiently, then too bad.

Note that for qcow2, we cannot just mark all clusters as zero clusters
because that would kind of defeat the purpose of metadata preallocation.
 One of its main purposes is to prevent COW when you write to a new
image, i.e. that the qcow2 driver needs to do a read-modify-write cycle
just to zero a new cluster.  If we kept preallocating potentially random
data and hooked it up as preallocated zero clusters, those RMW cycles
would remain, thus defeating the point of metadata preallocation.  So
even for qcow2, if there is a chance that the data stored is not zero,
it needs to explicitly store zeroes then.

But the good thing here is that the protocol driver would always
guarantee that it preallocates pure zeroes.

The bad thing is that I don=E2=80=99t think we could support pure metadat=
a or
falloc preallocation together with encryption any longer, which would
definitely be an incompatible change.  Well, because we wouldn=E2=80=99t =
want to
break this support, I suppose we would in this case (encryption) resort
to linking the data clusters as preallocated zero clusters.  Which is
bad because of RMW. but well.  That=E2=80=99s life.


(B) We keep this patch and audit our use of bdrv_has_zero_init().  So
for qcow2, we need to return 0 for encrypted images.  That is suboptimal
for non-preallocated encrypted images, but again, that=E2=80=99s life.

Also, we need to return 0 if the protocol layer does not preallocate the
data to be zero -- which we can see from its setting of
bdrv_has_zero_init(), I=E2=80=99d suppose.  So for preallocated unencrypt=
ed
images, qcow2 would need to return bdrv_has_zero_init(s->data_file->bs).

But here=E2=80=99s the problem: How do we know whether an image has been
preallocated or not?  And that is a problem.  I don=E2=80=99t know a solu=
tion
off the top of my head.  We could add a parameter to
bdrv_has_zero_init() for that, but what would blockdev-mirror assume?
It doesn=E2=80=99t know.

Hm.  I suppose qcow2=E2=80=99s implementation could sift through its L2 t=
ables
and if there are any links to data clusters, it is by definition in some
way preallocated.


So I suppose B seems like the better solution if there is a way for all
format drivers to determine whether their image has been preallocated or
not?

Max


--n1NRKKs5uUEUqqJEv0jawCciiF1AGTEmz--

--7sRMgQkiwau2DWpIftrvkujfrL7HZZZco
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0o0moACgkQ9AfbAGHV
z0BLrAf9GpCg1Cx9Qq1zWYOUjxW1x2f7EBsEtWet+aJm31PT1CJYmd8gNRNJyOZJ
NHNVrcKxFX6c/xZSWOWzaGztcGipbwie9buo6N7qhmu/p3inkc+iXPDnu2XLYbzs
xj5BU7fXku2QrooVUCOT9zA53C9/i1BOoAs5BCP0Mw95+fneyOWfstHlPCiEuEiJ
4UIKgTsALnbcXIBlTgZHlNsbB9QJT7qEBaWVaYwfuQGdItBYOnVoKNsn4/yHphG/
rXhIbQGL7zPZ5KPX3Mg8OfjBZ4Y+V3JSA3h3OsnI1L+z7Mq91pussO1bbTTLLUmf
DgStZ4YN5kBPmGmtia2L1SZjLA5/cQ==
=m4ap
-----END PGP SIGNATURE-----

--7sRMgQkiwau2DWpIftrvkujfrL7HZZZco--

