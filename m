Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3957C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:28:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B821921479
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 13:28:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B821921479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:54582 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOj6M-0005GQ-Ux
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 09:28:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49044)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOj5a-0004vn-TV
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:28:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hOj5Z-0004U9-R9
	for qemu-devel@nongnu.org; Thu, 09 May 2019 09:27:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46948)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mreitz@redhat.com>)
	id 1hOj5X-0004TO-83; Thu, 09 May 2019 09:27:55 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3EF927DCC1;
	Thu,  9 May 2019 13:27:54 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-168.brq.redhat.com
	[10.40.204.168])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 00ECF8162;
	Thu,  9 May 2019 13:27:51 +0000 (UTC)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190507151819.17401-1-mreitz@redhat.com>
	<CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
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
Message-ID: <3e1ce4b4-9a1e-eb97-c39e-066e231af28e@redhat.com>
Date: Thu, 9 May 2019 15:27:49 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Z8KujYpHIgULrX6gkL24tJIg0dg8MUoWA"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Thu, 09 May 2019 13:27:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL 00/11] Block patches
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
	Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z8KujYpHIgULrX6gkL24tJIg0dg8MUoWA
From: Max Reitz <mreitz@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3e1ce4b4-9a1e-eb97-c39e-066e231af28e@redhat.com>
Subject: Re: [PULL 00/11] Block patches
References: <20190507151819.17401-1-mreitz@redhat.com>
 <CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
In-Reply-To: <CAFEAcA-qq2CTF-K8Ag8AuKRVzp4VbEYHa_rkW=NzUQ5EEt4wKQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09.05.19 10:49, Peter Maydell wrote:
> On Tue, 7 May 2019 at 16:18, Max Reitz <mreitz@redhat.com> wrote:
>>
>> The following changes since commit 19eb2d4e736dc895f31fbd6b520e514f10c=
c08e0:
>>
>>   Merge remote-tracking branch 'remotes/thibault/tags/samuel-thibault'=
 into staging (2019-05-07 10:43:32 +0100)
>>
>> are available in the Git repository at:
>>
>>   https://git.xanclic.moe/XanClic/qemu.git tags/pull-block-2019-05-07
>>
>> for you to fetch changes up to 1278dce7927301bf3d004a40061dbd2c1e0846a=
8:
>>
>>   iotests: Fix iotests 110 and 126 (2019-05-07 17:14:21 +0200)
>=20
> Attempting to fetch from this remote hangs:
>=20
> $ git fetch -v xanclic
> POST git-upload-pack (gzip 1798 to 966 bytes)
> POST git-upload-pack (gzip 1798 to 965 bytes)
> POST git-upload-pack (gzip 2648 to 1393 bytes)
> POST git-upload-pack (gzip 4248 to 2201 bytes)
> POST git-upload-pack (gzip 7498 to 3833 bytes)
> POST git-upload-pack (gzip 13998 to 7092 bytes)
> POST git-upload-pack (gzip 27648 to 13930 bytes)
> POST git-upload-pack (gzip 55148 to 27782 bytes)
> POST git-upload-pack (gzip 108948 to 54371 bytes)
> POST git-upload-pack (gzip 215798 to 107233 bytes)
> [no further output]

Hm, that's unfortunate.  It works for me.  (At least now.)

I've pushed the tag to Github:

https://github.com/XanClic/qemu.git tags/pull-block-2019-05-07

I hope that works better.


Sorry for the inconvenience,

Max


--Z8KujYpHIgULrX6gkL24tJIg0dg8MUoWA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzUKtUACgkQ9AfbAGHV
z0Au0ggAwStfaiCWrbZ6GztR7hBcRtdzyBfG6ctP+JtmxCBAe8u6jGfUq9UFreRU
7736ONMVwZGrR88gXeMKc3sZnKoW0WUAK9i76iFRm/eQKUPb933SuVBXVIznyRcg
ABQIqn6E9wy662xlB3IhOMCfTPz3r6E3OmZ1yJn1Ejob9EH2yDxOBkpWs844H0qE
R5rIJ80kzRfnkzGdL9YWOrmndZWj75v4Ee5bnVmNI0xaH7ERsul2mmHyZIgDemp6
bAOpugtYFlqxP6wJByP4uuMiZCOw4558d2X0PFBZmenB0+N6wxCq0FueqQcXZ70Y
VHAiZM03s5RrUcbfM0D3SSiJrH9nrg==
=Ncxh
-----END PGP SIGNATURE-----

--Z8KujYpHIgULrX6gkL24tJIg0dg8MUoWA--

