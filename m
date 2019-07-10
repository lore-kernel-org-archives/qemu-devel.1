Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543E5C74A36
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF6F2064A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 20:18:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF6F2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlJ2s-0006tm-F2
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 16:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55159)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlJ26-0006S9-P2
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:17:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlJ25-0003Li-F1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 16:17:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlJ21-0003EJ-IZ; Wed, 10 Jul 2019 16:17:37 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A4D681111;
 Wed, 10 Jul 2019 20:17:36 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A0BF60BFB;
 Wed, 10 Jul 2019 20:17:32 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-4-jsnow@redhat.com>
 <b8e70883-2e64-aa6a-6a70-dd0aedd63f17@redhat.com>
 <7f302053-b624-8beb-840c-a467b6862e08@redhat.com>
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
Message-ID: <38f5bb4d-3646-a088-733e-ea6d0bc0036a@redhat.com>
Date: Wed, 10 Jul 2019 22:17:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <7f302053-b624-8beb-840c-a467b6862e08@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SycMdYbYz00WtFoi5uiZfCLoU8Z7B16FI"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Wed, 10 Jul 2019 20:17:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/8] iotests/257: Refactor backup helpers
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
Cc: Kevin Wolf <kwolf@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SycMdYbYz00WtFoi5uiZfCLoU8Z7B16FI
Content-Type: multipart/mixed; boundary="hWX64bFbZXz2jxBhxQGZeDJCioaEp0svm";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <38f5bb4d-3646-a088-733e-ea6d0bc0036a@redhat.com>
Subject: Re: [PATCH 3/8] iotests/257: Refactor backup helpers
References: <20190710010556.32365-1-jsnow@redhat.com>
 <20190710010556.32365-4-jsnow@redhat.com>
 <b8e70883-2e64-aa6a-6a70-dd0aedd63f17@redhat.com>
 <7f302053-b624-8beb-840c-a467b6862e08@redhat.com>
In-Reply-To: <7f302053-b624-8beb-840c-a467b6862e08@redhat.com>

--hWX64bFbZXz2jxBhxQGZeDJCioaEp0svm
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.07.19 19:52, John Snow wrote:
>=20
>=20
> On 7/10/19 12:04 PM, Max Reitz wrote:
>> On 10.07.19 03:05, John Snow wrote:
>>> This test needs support for non-bitmap backups and missing or
>>> unspecified bitmap sync modes, so rewrite the helpers to be a little
>>> more generic.
>>>
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>>  tests/qemu-iotests/257     |  46 +++++----
>>>  tests/qemu-iotests/257.out | 192 ++++++++++++++++++-----------------=
--
>>>  2 files changed, 124 insertions(+), 114 deletions(-)
>>>
>>> diff --git a/tests/qemu-iotests/257 b/tests/qemu-iotests/257
>>> index 2ff4aa8695..2eb4f26c28 100755
>>> --- a/tests/qemu-iotests/257
>>> +++ b/tests/qemu-iotests/257
>>
>> [...]
>>
>>> -def bitmap_backup(drive, n, filepath, bitmap, bitmap_mode):
>>> -    log("--- Bitmap Backup #{:d} ---\n".format(n))
>>> -    target_id =3D "bitmap_target_{:d}".format(n)
>>> -    job_id =3D "bitmap_backup_{:d}".format(n)
>>> +def backup(drive, n, filepath, bitmap, bitmap_mode, sync=3D'bitmap')=
:
>>> +    log("--- Test Backup #{:d} ---\n".format(n))
>>> +    target_id =3D "backup_target_{:d}".format(n)
>>> +    job_id =3D "backup_{:d}".format(n)
>>>      target_drive =3D Drive(filepath, vm=3Ddrive.vm)
>>> =20
>>>      target_drive.create_target(target_id, drive.fmt, drive.size)
>>> -    drive.vm.qmp_log("blockdev-backup", job_id=3Djob_id, device=3Ddr=
ive.name,
>>> -                     target=3Dtarget_id, sync=3D"bitmap",
>>> -                     bitmap_mode=3Dbitmap_mode,
>>> -                     bitmap=3Dbitmap,
>>> -                     auto_finalize=3DFalse)
>>> +
>>> +    kwargs =3D {
>>> +        'job_id': job_id,
>>> +        'auto_finalize': False,
>>> +        'bitmap': bitmap,
>>> +        'bitmap_mode': bitmap_mode,
>>> +    }
>>> +    kwargs =3D {key: val for key, val in kwargs.items() if val is no=
t None}
>>
>> I suppose this is to remove items that are None?
>>
>> Very cute, but why not just
>>
>>   kwargs =3D {
>>     'job_id': job_id,
>>     'auto_finalize': False,
>>   }
>>   if bitmap is not None:
>>     kwargs['bitmap'] =3D bitmap
>>     kwargs['bitmap_mode'] =3D bitmap_mode
>>
>> Exactly the same number of lines, but immediately makes it clear what=E2=
=80=99s
>> going on.  Not as cute, I admit.
>>
>> (Yes, I am indeed actively trying to train you not to write cute code.=
)
>>
>=20
> It sneaks in. I genuinely struggle with understanding what other people=

> will find readable; I have an authentically hard time reviewing other
> people's patches too. I'm earnestly not sure how I can help improve
> this, but I would like to.
>=20
> I wasn't sure what the easiest way to avoid sending the "None" over the=

> wire was, so I went with a general thing, but yes: it's because bitmap
> and bitmap_mode are set to None sometimes and I need to omit such keys.=

>=20
> In this case, though, I do test bitmap and bitmap_mode separately, so
> for the purposes of testing intentionally bad combinations you do need:=

>=20
> if bitmap is not None:
>     kwargs['bitmap'] =3D bitmap
> if bitmap_mode is not None:
>     kwargs['bitmap_mode'] =3D bitmap_mode
>=20
> And I just looked at this and it did not spark joy; so I went with a
> generic filter to remove nulled keys. I admit it's /slightly/ cute and
> not immediately obvious why it needs to be done.
>=20
>=20
> This is even cuter, so maybe I am traveling in the wrong direction:
>=20
> def backup(drive, n, filepath, sync, **kwargs):
>     log("--- Test Backup #{:d} ---\n".format(n))
>     target_id =3D "backup_target_{:d}".format(n)
>     job_id =3D "backup_{:d}".format(n)
>     target_drive =3D Drive(filepath, vm=3Ddrive.vm)
>=20
>     target_drive.create_target(target_id, drive.fmt, drive.size)
>     kwargs.setdefault('auto_finalize', False)
>     # Strip any arguments explicitly nulled by the caller:
>     kwargs =3D {key: val for key, val in kwargs.items()
>               if val is not None}
>     blockdev_backup(drive.vm, drive.name, target_id, sync, **kwargs)
>     return job_id
>=20
> It's quite a bit shorter and also makes backup() more flexible by
> omitting the bitmap and bitmap_mode arguments entirely, allowing the
> caller to override the auto_finalize default, etc. In this permutation,=

> we don't know the full extent of kwargs so it makes sense to genericall=
y
> filter it.
>=20
> Manually conditionally setting arguments is probably also fine.
> Do you still have a preference for the more static approach?

It=E2=80=99s OK with the comment.
Although it needs a kwargs.setdefault('job_id', job_id), too.

(Hm.  Shouldn=E2=80=99t 'auto-finalize' and 'job-id' work just fine?  It=E2=
=80=99s not
like the QMP scripts swap - and _.  They just replace _  by -.)

Max

>> The rest looks good to me:
>>
>> Reviewed-by: Max Reitz <mreitz@redhat.com>
>>
>=20
> Thanks for reviewing, as always!
>=20



--hWX64bFbZXz2jxBhxQGZeDJCioaEp0svm--

--SycMdYbYz00WtFoi5uiZfCLoU8Z7B16FI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0mR9oACgkQ9AfbAGHV
z0CYwwf+KKU28HqdR7ZJMUYX2R67swW4BcfqQvLhawxC9M6C4dK6z27nOGvT7JmN
alObS5BTNo+Vhr9kGIkdeQGWh5kDD05vU89bajkhT32NSU3FGjsEzXNYypHlsIBa
GrYCnuqdVcnOW2qBSPC5ou02ESbJD4hskmpabQWu1Xsm3ylpp+5AXjlON0lnuvma
lJPUco9T1C5PG8jsO3NyqBZrtxryxento65TLdVaqOrdKApzMO6fuZT1kGmVV3TK
ztFxUABie1tn+WMnDknjhCxw9GNJaatn1RDBpPbMt86a6CJIdX6f5qVEI7V204Vg
eHiaC7WykKkhuoFvZSvbU1dgX3hjpg==
=7oLH
-----END PGP SIGNATURE-----

--SycMdYbYz00WtFoi5uiZfCLoU8Z7B16FI--

