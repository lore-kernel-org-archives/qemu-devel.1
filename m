Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A97C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:10:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 696E522DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 696E522DA9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i02y0-0002MH-8c
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 08:10:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i02xC-0001ZV-Kn
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:09:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i02xA-0000jj-WA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 08:09:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44432)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i02x7-0000e2-OO; Tue, 20 Aug 2019 08:09:29 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D315E300DA7F;
 Tue, 20 Aug 2019 12:09:28 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.11])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8835D5D9D5;
 Tue, 20 Aug 2019 12:09:27 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-13-mreitz@redhat.com>
 <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>
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
Message-ID: <39066a69-e319-c3ad-7b3b-2983bb248a25@redhat.com>
Date: Tue, 20 Aug 2019 14:09:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="2XdxdbbIMRBjIaxpX0ERdDR1LKrTVsANl"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 20 Aug 2019 12:09:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 12/16] qcow2: Fix overly long snapshot
 tables
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
--2XdxdbbIMRBjIaxpX0ERdDR1LKrTVsANl
Content-Type: multipart/mixed; boundary="FzlbyzU3oVCjYdHH811GmSykL0eBNsf1Y";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <39066a69-e319-c3ad-7b3b-2983bb248a25@redhat.com>
Subject: Re: [PATCH v2 12/16] qcow2: Fix overly long snapshot tables
References: <20190819185602.4267-1-mreitz@redhat.com>
 <20190819185602.4267-13-mreitz@redhat.com>
 <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>
In-Reply-To: <272cbeba-2053-9aa6-7ceb-e1b3827de540@redhat.com>

--FzlbyzU3oVCjYdHH811GmSykL0eBNsf1Y
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 21:43, Eric Blake wrote:
> On 8/19/19 1:55 PM, Max Reitz wrote:
>> We currently refuse to open qcow2 images with overly long snapshot
>> tables.  This patch makes qemu-img check -r all drop all offending
>> entries past what we deem acceptable.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/qcow2-snapshot.c | 88 +++++++++++++++++++++++++++++++++++++----=
-
>>  1 file changed, 78 insertions(+), 10 deletions(-)
>=20
> I know I was reluctant in v1, but you also managed to convince me that
> it really takes a LOT of effort to get a table with that many entries.
> And a user has to opt-in to 'qemu-img -r' (it may discard a snapshot
> they value, but that beats not being able to use the image under qemu a=
t
> all, and we don't erase it for plain 'qemu-img check').  So I'm okay
> with this going in.  Maybe the commit message can state this sort of
> reasoning.

So maybe:

The user cannot choose which snapshots are removed.  This is fine
because we have chosen the maximum snapshot table size to be so large
(64 MB) that it cannot be reasonably reached.  If the snapshot table
exceeds this size, the image has probably been corrupted in some way; in
this case, it is most important to just make the image usable such that
the user can copy off at least the active layer.
(Also note that the snapshots will be removed only with "-r all", so a
plain "check" or "check -r leaks" will not delete any data.)

?

Max


--FzlbyzU3oVCjYdHH811GmSykL0eBNsf1Y--

--2XdxdbbIMRBjIaxpX0ERdDR1LKrTVsANl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1b4vUACgkQ9AfbAGHV
z0CHfQf4kzbh9eWijLnF7G7i1eZk7PBODtlcs1MKLzPybS6xkI+ZJQBxd4HyKksi
SHhGigOBcWlGDJeh8ET8t6/5BGRrGsBz2o6HyDn5zPSNDYCl2TYdB/qQRs3HF0gW
R0MHBFq9mHBNL0Rm5T30a6fWx/C55LC0Cy7gGCB1kK0qwMM41UTerodZ9d7io/I3
Ure0iv0/XPObHWn6/l+aMDA8zQDJQMIV9p5M9h4ffEEyKL0cKPy2aj7YAsT4KqM2
0RK1c8Bn+oKeTWCDyPNtCD/uRiBIOCrNhrbb6FYaw1/PpUOGnkVVKwYo/hr8xtlX
jNX+7LlwzgSBjRbfUdACAUaMSCZP
=OSb+
-----END PGP SIGNATURE-----

--2XdxdbbIMRBjIaxpX0ERdDR1LKrTVsANl--

