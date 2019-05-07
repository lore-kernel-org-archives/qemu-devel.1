Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E39C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33FD92053B
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 13:27:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33FD92053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:46840 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO07s-0006CN-Ba
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 09:27:20 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO072-0005sy-JV
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:26:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hO071-0007vQ-Nl
	for qemu-devel@nongnu.org; Tue, 07 May 2019 09:26:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hO06z-0007ss-F9; Tue, 07 May 2019 09:26:25 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 550463086206;
	Tue,  7 May 2019 13:26:24 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.217])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8515161B79;
	Tue,  7 May 2019 13:26:22 +0000 (UTC)
To: Sam <shmuel.eiderman@oracle.com>, Thomas Huth <thuth@redhat.com>
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
	<20190502130822.46858-1-shmuel.eiderman@oracle.com>
	<20190502130822.46858-2-shmuel.eiderman@oracle.com>
	<8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
	<a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
	<75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
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
Message-ID: <a88eb13d-22c3-fadd-eed6-b0b505336829@redhat.com>
Date: Tue, 7 May 2019 15:26:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xUt5ENsOXCZYpRI2VIj3eUEfNeIUuFScz"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 07 May 2019 13:26:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] vmdk: Set vmdk parent backing_format to
 vmdk
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	Arbel Moshe <arbel.moshe@oracle.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xUt5ENsOXCZYpRI2VIj3eUEfNeIUuFScz
From: Max Reitz <mreitz@redhat.com>
To: Sam <shmuel.eiderman@oracle.com>, Thomas Huth <thuth@redhat.com>
Cc: kwolf@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 fam@euphon.net, Eric Blake <eblake@redhat.com>,
 Arbel Moshe <arbel.moshe@oracle.com>
Message-ID: <a88eb13d-22c3-fadd-eed6-b0b505336829@redhat.com>
Subject: Re: [PATCH v2] vmdk: Set vmdk parent backing_format to vmdk
References: <af928e13-bde2-a9ae-de74-853d9bfc5e65@redhat.com>
 <20190502130822.46858-1-shmuel.eiderman@oracle.com>
 <20190502130822.46858-2-shmuel.eiderman@oracle.com>
 <8d201096-ab9d-82e0-93cb-74bd23d93dbe@redhat.com>
 <a44ffb98-4cc2-47b9-2c9e-eeeda445a0a0@redhat.com>
 <75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
In-Reply-To: <75AB1BD6-546D-4103-8A44-BEEC2FD3FF63@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.19 14:43, Sam wrote:
> Thanks Thomas, Thanks Max
>=20
> So how do you want to proceed?
>=20
> Apply Max=E2=80=99s RFC from here
> (http://lists.nongnu.org/archive/html/qemu-block/2019-04/msg00442.html)=

> and add the commit id which is stable now?

I=E2=80=99ll do that.

Max


--xUt5ENsOXCZYpRI2VIj3eUEfNeIUuFScz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzRh3wACgkQ9AfbAGHV
z0AKgwgAiaAyQux+Z5VnFtbCAC2dkgJqBVikm8YwwSqT+w17ZxaYjzJRPTQorjye
wIICWckVp1m3TaAzpcLyNFcr27KXPpnnByrCJaXsDVQ8yZ4mdcPMCm1jbHpCqfZR
iUS0jocrOtWiq23tbIenwZmf/rcbsB+Jxj9+x3pPVWwvUkh+h07lkK4mdpfftU3q
/e8025KxlGqTVOfTw4uveZvrNOB1mbVbamIBSc4nMLU/ba00l1gNBx9PBIZVnSuP
TDdPLxXMQP2EboNJBw6cHN4nWY6QuQGCUs7MzGnq8ytRClXStRMolHzznUNSNo84
J45Y9R4Krr0jsfPbrh1NSbFlYRAOwg==
=HzsZ
-----END PGP SIGNATURE-----

--xUt5ENsOXCZYpRI2VIj3eUEfNeIUuFScz--

