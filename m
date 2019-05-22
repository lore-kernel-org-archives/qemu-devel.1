Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD98AC282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7407720881
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 18:39:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7407720881
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49498 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTW8w-0005aI-IR
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 14:39:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60501)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTW87-0005Hp-V2
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:38:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hTW81-0005x6-Re
	for qemu-devel@nongnu.org; Wed, 22 May 2019 14:38:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35308)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hTW7o-0005nc-FQ; Wed, 22 May 2019 14:38:05 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2C2EC308FBB4;
	Wed, 22 May 2019 18:37:55 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-123.brq.redhat.com
	[10.40.204.123])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id DA30F600C0;
	Wed, 22 May 2019 18:37:52 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190522170352.12020-1-mreitz@redhat.com>
	<6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
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
Message-ID: <9f198134-8739-057a-47b3-52483a428080@redhat.com>
Date: Wed, 22 May 2019 20:37:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="lw5wBgEnH4nKNuuhGXKfhfdtAMvbxhBev"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Wed, 22 May 2019 18:37:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lw5wBgEnH4nKNuuhGXKfhfdtAMvbxhBev
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Message-ID: <9f198134-8739-057a-47b3-52483a428080@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/8] block: Ignore loosening perm
 restrictions failures
References: <20190522170352.12020-1-mreitz@redhat.com>
 <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
In-Reply-To: <6c13016d-9951-775c-9c54-62e0dd676ca2@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 22.05.19 20:24, Eric Blake wrote:
> On 5/22/19 12:03 PM, Max Reitz wrote:
>> Hi,
>>
>> This series is mainly a fix for
>> https://bugzilla.redhat.com/show_bug.cgi?id=3D1703793.  The problem
>> described there is that mirroring to a gluster volume, then switching
>> off the volume makes qemu crash.  There are two problems here:
>>
>> (1) file-posix reopens the FD all the time because it thinks the FD it=

>>     has is RDONLY.  It actually isn=E2=80=99t after the first reopen, =
we just
>>     forgot to change the internal flags.  That=E2=80=99s what patch 1 =
is for.
>>
>> (2) Even then, when mirror completes, it drops its write permission on=

>>     the FD.  This requires a reopen, which will fail if the volume is
>>     down.  Mirror doesn=E2=80=99t expect that.  Nobody ever expects th=
at
>>     dropping permissions can fail, and rightfully so because that=E2=80=
=99s what
>>     I think we have generally agreed on.
>>     Therefore, the block layer should hide this error.  This is what t=
he
>>     last two patches are for.
>>
>> The penultimate patch adds two assertions: bdrv_replace_child() (for t=
he
>> old BDS) and bdrv_inactivate_recurse() assume they only ever drop
>> assertions.  This is now substantiated by these new assertions.
>> It turns out that this assumption was just plain wrong.  Patches 3 to =
5
>> make it right.
>>
>>
>> v3:
>> - Received no reply to my =E2=80=9CHm, warnings break 'make check', so=
 maybe we
>>   should just keep quiet if loosening restrictions fails?=E2=80=9D que=
stion, so
>>   I assume silence means agreement.  Changed patch 7 accordingly.
>>
>=20
> I don't know if there is an easy way to warn for normal users, but
> silence the warnings if run under test setups to keep 'make check'
> output unchanged (I know we've silenced warnings in the past when we
> detect we are running qtest, but this isn't necessarily the same setup)=
=2E
>  So not a show-stopper for me.

Hm.  That doesn=E2=80=99t sound too bad.  I don=E2=80=99t think there is =
an easy way to
silence the warning in qemu, but we might be able to just modify the test=
=2E

But I don=E2=80=99t even know whether the warnings are even useful or whe=
ther
they would just confuse users more than anything.  So far, every case I
know where loosening restrictions failed was because the file is just
gone completely.  The only purpose of a warning is to show the user that
qemu might have locks on the file that it doesn=E2=80=99t need, so they w=
ill
know what=E2=80=99s up if they try to open the file in another qemu insta=
nce in
a way that should normally work but suddenly doesn=E2=80=99t.  But if the=
 file=E2=80=99s
just gone, you can=E2=80=99t open it in another qemu, so I don=E2=80=99t =
even know
whether there=E2=80=99s actually any point in warning.

Max


--lw5wBgEnH4nKNuuhGXKfhfdtAMvbxhBev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzllv4ACgkQ9AfbAGHV
z0AWkwf+JyD38W5WYL7A6m0Wlqmp4QwePdB25R0yYr/ZzswKb9HnZi2qO2bUaW3w
mW2TXez9vHwgHO/pfOT2E8oEDc1lPYAPn9ziCE6IhJtGRUkrK0U0+MmG2nZyCpxf
wgLKvXLsfOqO0IpZq1YwBvFF1OgxDSwQ6XiHxUVv4Wl/+bQ0qZPpVDxl2a45j+q0
LnMetYnY5hkehgUMvb9eEf2FiNSkiz31K15yP//tjJhx3OqU+M+lZpMoKuOn01Sz
q/w6VgDZElCXMLzINer/6ZufJQCW3CfNPj5F1PRHE5G44k0hqL8hqWYv5lsKkK/J
MH2H/OLpR9b5vtzVt8g0e4C3X4HjJg==
=OjT8
-----END PGP SIGNATURE-----

--lw5wBgEnH4nKNuuhGXKfhfdtAMvbxhBev--

