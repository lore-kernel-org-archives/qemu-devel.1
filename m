Return-Path: <SRS0=PAXx=ST=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00918C282DA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:17:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7582206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2019 17:17:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7582206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56956 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hGoBF-00033L-0Z
	for qemu-devel@archiver.kernel.org; Wed, 17 Apr 2019 13:17:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59581)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGo62-000824-Tr
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGo61-00080E-Q9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 13:11:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44030)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hGo5u-0007pH-Se; Wed, 17 Apr 2019 13:11:36 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 822E1307E059;
	Wed, 17 Apr 2019 17:11:32 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-140.brq.redhat.com
	[10.40.204.140])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6E9AC5D6A6;
	Wed, 17 Apr 2019 17:11:30 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190401145741.28322-1-eblake@redhat.com>
	<d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
	<39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
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
Message-ID: <51b3fd92-4515-0288-9553-243e9619cde2@redhat.com>
Date: Wed, 17 Apr 2019 19:11:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Wed, 17 Apr 2019 17:11:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH for-4.1 v2] qemu-img: Saner printing of
 large file sizes
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
Cc: kwolf@redhat.com, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
	Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org,
	"Richard W . M . Jones" <rjones@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190417171128.N8a2tHgjKCfW-T-xZ0UT180kDXVRpwZmydH-e6lTmyM@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <51b3fd92-4515-0288-9553-243e9619cde2@redhat.com>
Subject: Re: [PATCH for-4.1 v2] qemu-img: Saner printing of large file sizes
References: <20190401145741.28322-1-eblake@redhat.com>
 <d62dd532-2da4-40ee-7054-616c87907dd4@redhat.com>
 <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
In-Reply-To: <39599f7c-c3c6-73c9-7f74-0e70270c49de@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 18:58, Eric Blake wrote:
> On 4/10/19 2:28 PM, Max Reitz wrote:
>> On 01.04.19 16:57, Eric Blake wrote:
>>> Disk sizes close to INT64_MAX cause overflow, for some pretty
>>> ridiculous output:
>>>
>>>   $ ./nbdkit -U - memory size=3D$((2**63 - 512)) --run 'qemu-img info=
 $nbd'
>>>   image: nbd+unix://?socket=3D/tmp/nbdkitHSAzNz/socket
>>>   file format: raw
>>>   virtual size: -8388607T (9223372036854775296 bytes)
>>>   disk size: unavailable
>>>
>=20
>>
>> There are more iotests this breaks.  First, there is 059 for vmdk, whi=
ch
>> looks just like the rest.
>=20
> Easy enough; I was able to reproduce.
>=20
>>
>> But for -m32, it gets a bit more difficult.  Every size above 999 GB
>> (1000 GB gets rounded to 1 TB, which is 2^31 * 512) gets printed as
>> "inf [unit]":
>=20
> Ouch - pre-existing bug in size_to_str(); I'll have to fix that, then
> send a v3.
>=20
> Kevin, do you want to unqueue this from block-next until then?
>=20
>>
>> But regardless of the iotests, we shouldn=E2=80=99t show the size as i=
nfinite
>> just because of -m32.
>=20
> Is there an easy docker setup for building -m32?

I don=E2=80=99t know.  In theory it's as simple as (on Fedora):

$ export PKG_CONFIG_LIBDIR=3D/usr/lib/pkgconfig
$ ../configure --target-list=3Dx86_64-softmmu --extra-cflags=3D-m32
$ make

In practice, Fedora 29 has a broken glib2-devel.i686 package, which you
cannot install alongside the x86_64 version, so it doesn=E2=80=99t work
(https://bugzilla.redhat.com/show_bug.cgi?id=3D1651231).

I had hoped it was fixed by now... :-/

(In case you=E2=80=99re wondering, I=E2=80=99m building the 32-bit versio=
n on Arch.)

Max


--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3XkAACgkQ9AfbAGHV
z0BQfAgAhWM99gCK8coLL1gL3BG1IITzdYbsMpY8bGyc8s4iwkw3MBpdDMmLNxhd
xv0a9YcDi0smUpMt4RjA7MmES7xOUSpVGxmKK9+L50FY+6t9ngL6DMOIrJUHcKCT
pHauirv8pTmpPYzJxZcfLt5dj63xEV3ygSG8QLwiJv2lSjq/HjLalatpEnNpOY9/
ELXaceLAZzqeKnfaAfPFIL1VC9hRI8dZmtyL7ADzv08sBQjbtSjOjSB1x5yHh7Uy
MVtIry9KChBQ2L5opVU1v0/x12IxIv7kj0XVeLB//5j1oeuLvLps1ifmBgFk03lT
ZR0E/cYVwrRrAB9UVcRIcLPsJ/Tf6w==
=Z0gE
-----END PGP SIGNATURE-----

--daMEIdKZkebe1r5Laq0TBaJtiTx5N9ebH--

