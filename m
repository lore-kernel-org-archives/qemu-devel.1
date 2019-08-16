Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B931C3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 02:10:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 677262086C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 02:10:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 677262086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyRh2-00063a-Hm
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 22:10:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hyRgB-0005ZV-HL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 22:09:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hyRgA-0003vv-A7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 22:09:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45856)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hyRg7-0003uW-Dm; Thu, 15 Aug 2019 22:09:19 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A43FF30821A1;
 Fri, 16 Aug 2019 02:09:18 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-21.brq.redhat.com
 [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F07FF17156;
 Fri, 16 Aug 2019 02:09:16 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
 <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
 <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>
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
Message-ID: <10daecff-15b4-88f0-9fe8-f5c5547fde70@redhat.com>
Date: Fri, 16 Aug 2019 04:09:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oOfEOPGoqtLVaIFcxkHnCe54g1Mkxs8yB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.47]); Fri, 16 Aug 2019 02:09:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.2 02/13] qcow2: Keep unknown extra
 snapshot data
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
--oOfEOPGoqtLVaIFcxkHnCe54g1Mkxs8yB
Content-Type: multipart/mixed; boundary="crjVhCdzBBWLu1FXZGCBCfN57WAUXsWtu";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <10daecff-15b4-88f0-9fe8-f5c5547fde70@redhat.com>
Subject: Re: [PATCH for-4.2 02/13] qcow2: Keep unknown extra snapshot data
References: <20190730172508.19911-1-mreitz@redhat.com>
 <20190730172508.19911-3-mreitz@redhat.com>
 <9f7db4bc-d66a-2069-9f9a-20da842829f3@redhat.com>
 <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>
In-Reply-To: <60b73760-9ffd-aedf-afc0-9c58c804236c@redhat.com>

--crjVhCdzBBWLu1FXZGCBCfN57WAUXsWtu
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 31.07.19 10:54, Max Reitz wrote:
> On 30.07.19 19:56, Eric Blake wrote:
>> On 7/30/19 12:24 PM, Max Reitz wrote:

[...]

>>> +        if (sn->extra_data_size > sizeof(extra)) {
>>> +            /* Store unknown extra data */
>>> +            size_t unknown_extra_data_size =3D
>>> +                sn->extra_data_size - sizeof(extra);
>>> +
>>> +            sn->unknown_extra_data =3D g_malloc(unknown_extra_data_s=
ize);
>>> +            ret =3D bdrv_pread(bs->file, offset, sn->unknown_extra_d=
ata,
>>> +                             unknown_extra_data_size);
>>
>> We're doing two separate bdrv_pread()s. Would it be better to do a
>> single bdrv_preadv into a vector composed of &extra and
>> &unknown_extra_data, for less I/O?  (Then again, this micro-optimizati=
on
>> is probably in the noise in the long run)
>=20
> Interesting idea, we could even add the ID and name string into that
> vector.  But I=E2=80=99m not sure whether it=E2=80=99s really useful.
>=20
> (I=E2=80=99ll take a look anyway, because it sounds interesting.)

I did, and it was actually really nice.  I liked it.  (I don=E2=80=99t hi=
nk the
performance is important, but it was actually just simpler.)

But then it turned out that it won=E2=80=99t work with patch 8, because a=
fter
that we may want to skip parts of the unknown extra data =E2=80=93 and sk=
ipping
doesn=E2=80=99t work with bdrv_preadv()...

(So all the simplicity is lost, and that=E2=80=99s what I was interested =
in.)

But it was indeed quite cool. :-/

Max


--crjVhCdzBBWLu1FXZGCBCfN57WAUXsWtu--

--oOfEOPGoqtLVaIFcxkHnCe54g1Mkxs8yB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1WEEoACgkQ9AfbAGHV
z0AF7gf/ZGh5qy5yB7cNFE2I16nJR6Uc7C4aU6kl4mO9UiHnyUnLa4rMPuXDki58
oq29udvNAbwbO94GVru2Bgf5lZaDSlmwaxhgEs62N0El+gBecVEBT9XpBZihSC4T
piXa85Y6EsUudW1YUuWKoM0Oc83P5h5F/doVL9DlDcxWNhSmmC1pjJ5tbYcPpRqg
/Zl/8LnrcD6YgpPMFafPBzsR7g1RDOHegmazkNmTGKBQ4UQs1p3ksWH6Dunbg+ye
UcMw1I9oNBPf69SuCG7HcyY9WjSb/YfJ8LjcBTpNSCY6Qo7tU/qq5n5etHisBQYO
pxr19C4JobuEub4W1+dtB1iUrRuQuw==
=5fUC
-----END PGP SIGNATURE-----

--oOfEOPGoqtLVaIFcxkHnCe54g1Mkxs8yB--

