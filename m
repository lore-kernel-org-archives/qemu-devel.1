Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC3DDC2D0D2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AD9024679
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 10:31:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S0EqZloQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AD9024679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52904 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiFZI-0000m7-P2
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 05:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iiFYR-0000Fb-UW
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:30:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iiFYP-0001cc-Bq
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:30:43 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:42665
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>) id 1iiFYP-0001a6-18
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 05:30:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576837839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eECTAgQiqCn1FIKDTACRMGnxtY5OXrlQd0sRBnroBqw=;
 b=S0EqZloQAPYkWL9SYzBAiF6ll0S2kl60uH1kaVGuCAv+1Rm5/hFXuTvO3ipwvQTDgO90rC
 s8lsc4iTwDNhu/MKIgv/d9WaT5hTb+fFV7inpRuNqqotqAcIO5dOI5/HTGolKkriBjgbCG
 s4m8wPdIn2wDahS7PqnbtebAfby2Fcs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-385-VE_pfcYZPVSvUC8k6wRaew-1; Fri, 20 Dec 2019 05:30:37 -0500
X-MC-Unique: VE_pfcYZPVSvUC8k6wRaew-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 500EB100551D;
 Fri, 20 Dec 2019 10:30:36 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-205-117.brq.redhat.com
 [10.40.205.117])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 213EC1001B00;
 Fri, 20 Dec 2019 10:30:34 +0000 (UTC)
Subject: Re: [PATCH 00/18] block: Allow exporting BDSs via FUSE
To: Stefan Hajnoczi <stefanha@gmail.com>
References: <20191219143818.1646168-1-mreitz@redhat.com>
 <20191220100846.GC1635864@stefanha-x1.localdomain>
From: Max Reitz <mreitz@redhat.com>
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
Message-ID: <a372e742-182a-ec98-d297-ed8d43e10734@redhat.com>
Date: Fri, 20 Dec 2019 11:30:33 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220100846.GC1635864@stefanha-x1.localdomain>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="z8oCfQpqN9DZqa2vPj4G2R5lw52g7Nw1J"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--z8oCfQpqN9DZqa2vPj4G2R5lw52g7Nw1J
Content-Type: multipart/mixed; boundary="uiJ6CB61m8hu8ISaEMe9YPXaS2wrHKcrr"

--uiJ6CB61m8hu8ISaEMe9YPXaS2wrHKcrr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.12.19 11:08, Stefan Hajnoczi wrote:
> On Thu, Dec 19, 2019 at 03:38:00PM +0100, Max Reitz wrote:
>> Preamble: This series is based on a combination of my (current) block
>> branch and =E2=80=9Ciotests: Minor fixes=E2=80=9D.  I=E2=80=99ve pushed =
it here:
>>
>>   https://git.xanclic.moe/XanClic/qemu fuse-exports-v1
>>
>> (The base is on fuse-exports-v1-base.)
>>
>>
>> Hi,
>>
>> Ever since I found out that you can mount FUSE filesystems on regular
>> files (not just directories), I had the idea of adding FUSE block
>> exports to qemu where you can export block nodes as raw images.  The
>> best thing is that you=E2=80=99d be able to mount an image on itself, so
>> whatever format it may be in, qemu lets it appear as a raw image (and
>> you can then use regular tools like dd on it).
>>
>> I started with some concept of a qemu-blkfuse daemon (similar to
>> qemu-nbd), but never sent patches, for two reasons: (1) Performance was
>> not good, (2) it didn=E2=80=99t seem right, for some reason.
>>
>> Now Kevin is proposing a storage daemon for multiple export types like
>> NBD, and he also mentioned FUSE (while knowing of my previous attempts).
>> Now it does seem right to add FUSE exports to qemu, but only in the form
>> of some module with a proper QAPI/QMP binding.
>>
>> Performance is still quite bad, but who cares.  We can always improve
>> it, if the need arises.
>>
>>
>> This series does the following:
>>
>> First, add the FUSE export module (block/fuse.c) that implements the
>> basic file access functions.  (Note that you need libfuse 3.8.0 or later
>> for SEEK_HOLE/SEEK_DATA.)
>>
>> Second, it allows using FUSE exports as a protocol in the iotests and
>> makes many iotests work with it.  (The file node is exported by a
>> background qemu instance to $SOCK_DIR.)
>> Note that I only ran raw and qcow2 on it; I=E2=80=99m sure other formats
>> currently have some failing tests.
>>
>> This gives us a lot of coverage for, well, not free (it does take ten
>> patches), but for cheap; but there are still some more specialized
>> things we want to test, so third and last, this series adds an iotest
>> dedicated to FUSE exports.
>>
>>
>> Final rather important notice: I didn=E2=80=99t really run the iotests w=
ith this
>> yet.  I wanted to, but they appear rather broken on current master,
>> actually.  I=E2=80=99m not yet sure whether that=E2=80=99s because somet=
hing in my setup
>> broke in the last two weeks, or because there=E2=80=99s quite something =
broken
>> in master (it does look like there are a couple things broken in master
>> currently).
>>
>>
>> Max Reitz (18):
>>   configure: Detect libfuse
>>   fuse: Allow exporting BDSs via FUSE
>>   fuse: Implement standard FUSE operations
>>   fuse: Add fuse-export-remove
>>   fuse: Allow growable exports
>>   fuse: (Partially) implement fallocate()
>>   fuse: Implement hole detection through lseek
>>   iotests: Do not needlessly filter _make_test_img
>>   iotests: Do not pipe _make_test_img
>>   iotests: Use convert -n in some cases
>>   iotests: Avoid renaming images
>>   iotests: Derive image names from $TEST_IMG
>>   iotests/091: Use _cleanup_qemu instad of "wait"
>>   iotests: Restrict some Python tests to file
>>   iotests: Let _make_test_img guess $TEST_IMG_FILE
>>   iotests: Allow testing FUSE exports
>>   iotests: Enable fuse for many tests
>>   iotests/281: Add test for FUSE exports
>>
>>  block.c                          |   4 +
>>  block/Makefile.objs              |   3 +
>>  block/fuse.c                     | 668 +++++++++++++++++++++++++++++++
>>  configure                        |  68 ++++
>>  include/block/fuse.h             |  24 ++
>>  qapi/block.json                  |  42 ++
>>  tests/qemu-iotests/013           |   9 +-
>>  tests/qemu-iotests/013.out       |   3 +-
>>  tests/qemu-iotests/018           |   5 +-
>>  tests/qemu-iotests/018.out       |   1 +
>>  tests/qemu-iotests/020           |   2 +-
>>  tests/qemu-iotests/025           |   2 +-
>>  tests/qemu-iotests/026           |   2 +-
>>  tests/qemu-iotests/028           |  16 +-
>>  tests/qemu-iotests/028.out       |   3 +
>>  tests/qemu-iotests/031           |   2 +-
>>  tests/qemu-iotests/034           |   2 +-
>>  tests/qemu-iotests/036           |   2 +-
>>  tests/qemu-iotests/037           |   2 +-
>>  tests/qemu-iotests/038           |   2 +-
>>  tests/qemu-iotests/039           |   2 +-
>>  tests/qemu-iotests/046           |   7 +-
>>  tests/qemu-iotests/046.out       |   2 +-
>>  tests/qemu-iotests/050           |   2 +-
>>  tests/qemu-iotests/054           |   2 +-
>>  tests/qemu-iotests/060           |   2 +-
>>  tests/qemu-iotests/071           |  21 +-
>>  tests/qemu-iotests/072           |   5 +-
>>  tests/qemu-iotests/072.out       |   1 +
>>  tests/qemu-iotests/079           |   2 +-
>>  tests/qemu-iotests/080           |   2 +-
>>  tests/qemu-iotests/089           |   5 +-
>>  tests/qemu-iotests/089.out       |   1 +
>>  tests/qemu-iotests/090           |   2 +-
>>  tests/qemu-iotests/091           |   5 +-
>>  tests/qemu-iotests/095           |   2 +-
>>  tests/qemu-iotests/097           |   2 +-
>>  tests/qemu-iotests/098           |   2 +-
>>  tests/qemu-iotests/102           |   2 +-
>>  tests/qemu-iotests/103           |   2 +-
>>  tests/qemu-iotests/106           |   2 +-
>>  tests/qemu-iotests/107           |   2 +-
>>  tests/qemu-iotests/108           |   2 +-
>>  tests/qemu-iotests/111           |   2 +-
>>  tests/qemu-iotests/112           |   2 +-
>>  tests/qemu-iotests/115           |   2 +-
>>  tests/qemu-iotests/117           |   2 +-
>>  tests/qemu-iotests/120           |   2 +-
>>  tests/qemu-iotests/121           |   2 +-
>>  tests/qemu-iotests/127           |   2 +-
>>  tests/qemu-iotests/133           |   2 +-
>>  tests/qemu-iotests/137           |   2 +-
>>  tests/qemu-iotests/138           |   2 +-
>>  tests/qemu-iotests/140           |   2 +-
>>  tests/qemu-iotests/154           |   2 +-
>>  tests/qemu-iotests/161           |  14 +-
>>  tests/qemu-iotests/171           |   2 +-
>>  tests/qemu-iotests/174           |  10 +-
>>  tests/qemu-iotests/175           |   8 +-
>>  tests/qemu-iotests/176           |   2 +-
>>  tests/qemu-iotests/177           |   2 +-
>>  tests/qemu-iotests/179           |   2 +-
>>  tests/qemu-iotests/183           |   2 +-
>>  tests/qemu-iotests/186           |   2 +-
>>  tests/qemu-iotests/187           |   2 +-
>>  tests/qemu-iotests/191           |   2 +-
>>  tests/qemu-iotests/195           |   2 +-
>>  tests/qemu-iotests/200           |   5 +-
>>  tests/qemu-iotests/200.out       |   4 +-
>>  tests/qemu-iotests/204           |   2 +-
>>  tests/qemu-iotests/206           |   1 +
>>  tests/qemu-iotests/214           |   2 +-
>>  tests/qemu-iotests/217           |   2 +-
>>  tests/qemu-iotests/220           |   2 +-
>>  tests/qemu-iotests/221           |   2 +-
>>  tests/qemu-iotests/229           |   5 +-
>>  tests/qemu-iotests/229.out       |   6 +-
>>  tests/qemu-iotests/242           |   1 +
>>  tests/qemu-iotests/247           |   2 +-
>>  tests/qemu-iotests/249           |   8 +-
>>  tests/qemu-iotests/250           |   2 +-
>>  tests/qemu-iotests/252           |   2 +-
>>  tests/qemu-iotests/265           |   2 +-
>>  tests/qemu-iotests/268           |   2 +-
>>  tests/qemu-iotests/272           |   2 +-
>>  tests/qemu-iotests/273           |   2 +-
>>  tests/qemu-iotests/279           |   2 +-
>>  tests/qemu-iotests/281           | 328 +++++++++++++++
>>  tests/qemu-iotests/281.out       |  92 +++++
>>  tests/qemu-iotests/check         |   6 +
>>  tests/qemu-iotests/common.filter |   5 +-
>>  tests/qemu-iotests/common.rc     | 190 ++++++++-
>>  tests/qemu-iotests/group         |   1 +
>>  93 files changed, 1571 insertions(+), 120 deletions(-)
>>  create mode 100644 block/fuse.c
>>  create mode 100644 include/block/fuse.h
>>  create mode 100755 tests/qemu-iotests/281
>>  create mode 100644 tests/qemu-iotests/281.out
>=20
> A lot of qemu-iotests changes but the actual FUSE code is small and well
> worth it for the flexibility and convenience that this feature brings.
> Nice!

Good that you like it! :-)

> Please send a follow-up patch that adds a qemu(1) -blockdev
> 'Driver-specific options for "fuse"' documentation section.

What exactly do you mean?  This is not a block driver, so it doesn=E2=80=99=
t
work as part of -blockdev.  Currently, it can only be used through QMP
(fuse-export-add/fuse-export-remove).

I placed it into block/ because that just seemed like the least bad
place to me (apart from creating a new top-level directory like nbd has)
=E2=80=93 and also because we already have quite some few non-driver files =
in
block/ (io.c, the jobs (where some got drivers only rather recently),
accounting.c, ...).

Max


--uiJ6CB61m8hu8ISaEMe9YPXaS2wrHKcrr--

--z8oCfQpqN9DZqa2vPj4G2R5lw52g7Nw1J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl38oskACgkQ9AfbAGHV
z0ClQgf7BKbyW8eY5Mx2u1hDhxO3w0JtivY2DuDV8ZdN/1djq7l9i4KMuGZJeHlY
dLsVPVx884CFq8FsFoKKOppwVU67kIfcTtuktuZc9U2tdSpaT5cFPB5PjVpTFP/v
tdt5CJdHnaRvk2xnFsYg7s2C06BjES565CfSvCZ8HoJ4bSueYM+gYW2m6V5MhcKT
ZuAkcYNATJU5XVYkJuVVl0bpMXPmNwh7qLm5KVzZKKCxnbCvkr+PDjSM4wPrCK/F
ICSxCZmZUzEtyT9+e6r5aLXc7V+8GQOAgDNNp5lwcDey70Lg99h+Ul+Ha35s/QBY
asCyQh0zQnVevhkEyoE7n7m2PlXTww==
=duJu
-----END PGP SIGNATURE-----

--z8oCfQpqN9DZqa2vPj4G2R5lw52g7Nw1J--


