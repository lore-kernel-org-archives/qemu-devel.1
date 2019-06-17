Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55671C31E57
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:37:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 18FD720861
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 12:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 18FD720861
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46986 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcqtI-000194-Mm
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 08:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40140)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hcqhy-0001lf-2c
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:25:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hcqhv-0004Ig-4R
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 08:25:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35226)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hcqhp-00046h-28; Mon, 17 Jun 2019 08:25:49 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 83DC830C1AD7;
 Mon, 17 Jun 2019 12:25:41 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30F39619DB;
 Mon, 17 Jun 2019 12:25:38 +0000 (UTC)
To: qemu-block@nongnu.org, Keith Busch <keith.busch@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
References: <20190606092530.14206-1-klaus@birkelund.eu>
 <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
 <20190617065419.GA15574@apples.localdomain>
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
Message-ID: <2151e0c9-6245-7164-31a5-50415d375e89@redhat.com>
Date: Mon, 17 Jun 2019 14:25:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617065419.GA15574@apples.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2bvv9lMAQks8Um67Zi2xlb1XOQFTfM4DF"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 17 Jun 2019 12:25:41 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] nvme: do not advertise support for
 unsupported arbitration mechanism
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2bvv9lMAQks8Um67Zi2xlb1XOQFTfM4DF
Content-Type: multipart/mixed; boundary="7cgtFLflGbOQDo1Xo8kVuA5iHqWLZtAuS";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org, Keith Busch <keith.busch@intel.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <2151e0c9-6245-7164-31a5-50415d375e89@redhat.com>
Subject: Re: [PATCH] nvme: do not advertise support for unsupported
 arbitration mechanism
References: <20190606092530.14206-1-klaus@birkelund.eu>
 <639bcbb8-fabc-9bb8-b11d-909af4ed9cdc@redhat.com>
 <20190617065419.GA15574@apples.localdomain>
In-Reply-To: <20190617065419.GA15574@apples.localdomain>

--7cgtFLflGbOQDo1Xo8kVuA5iHqWLZtAuS
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 17.06.19 08:54, Klaus Birkelund wrote:
> On Fri, Jun 14, 2019 at 10:39:27PM +0200, Max Reitz wrote:
>> On 06.06.19 11:25, Klaus Birkelund Jensen wrote:
>>> The device mistakenly reports that the Weighted Round Robin with Urge=
nt
>>> Priority Class arbitration mechanism is supported.
>>>
>>> It is not.
>>
>> I believe you based on the fact that there is no =E2=80=9Cweight=E2=80=
=9D or =E2=80=9Cpriority=E2=80=9D
>> anywhere in nvme.c, and that it does not evaluate the Arbitration
>> Mechanism Selected field.
>>
>=20
> Not sure if you want me to change the commit message? Feel free to
> change it if you want to ;)

Oh, no, no.  It=E2=80=99s just that I have no idea how the NVMe interface=
 works
(well, I did download the spec then, but...), so this was basically just
my excuse for =E2=80=9CI can review this!!=E2=80=9D.

>>> Signed-off-by: Klaus Birkelund Jensen <klaus.jensen@cnexlabs.com>
>>> ---
>>>  hw/block/nvme.c | 1 -
>>>  1 file changed, 1 deletion(-)
>>>
>>> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
>>> index 30e50f7a3853..415b4641d6b4 100644
>>> --- a/hw/block/nvme.c
>>> +++ b/hw/block/nvme.c
>>> @@ -1383,7 +1383,6 @@ static void nvme_realize(PCIDevice *pci_dev, Er=
ror **errp)
>>>      n->bar.cap =3D 0;
>>>      NVME_CAP_SET_MQES(n->bar.cap, 0x7ff);
>>>      NVME_CAP_SET_CQR(n->bar.cap, 1);
>>> -    NVME_CAP_SET_AMS(n->bar.cap, 1);
>>
>> I suppose the better way would be to pass 0, so it is more explicit, I=

>> think.
>>
>> (Just removing it looks like it may have just been forgotten.)
>>
>=20
> Not explicitly setting it to zero aligns with how the other fields in
> CAP are also left out if kept at zero. If we explicitly set it to zero =
I
> think we should also set all the other fields that way (DSTRD, NSSRS,
> etc.).

OK then.

Thanks, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--7cgtFLflGbOQDo1Xo8kVuA5iHqWLZtAuS--

--2bvv9lMAQks8Um67Zi2xlb1XOQFTfM4DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0HhsAACgkQ9AfbAGHV
z0DctggAgT4cxPrzD4TdBzWjvqExa7s200CEg6QG2fAynvVl99rRiu/+IM8ojoE+
7UIQ3kS4BRqcCZ2pOZXp+nTh7iCHMBPpFv4/YjdQaCl7mTfIe+qu201FnGbv0epv
V93YkgEA0xcbbKqrjLKOxymgC5q1cKaLgD4nwOu8x5kU3qQ1e0sE1f/g0dbHw2eb
WzVL3myYgf5pfo6VFjdNv5OGmFaWeNrIGUm1tuWDc8AvDAfJ545SoK/LliV+6Bab
WFfRHXnjDVN73pE8z8m3vgPCFQUWU5FpvlG+oVl5MjD0GcvYJTNbic5/SZwjoxBI
tB+4LiQvyVaK0wcFrW5kpt+aCtPRhQ==
=fgRf
-----END PGP SIGNATURE-----

--2bvv9lMAQks8Um67Zi2xlb1XOQFTfM4DF--

