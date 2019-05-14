Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A2C04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:19:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20982208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 14:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20982208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48815 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQYGj-00049A-Bl
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 10:19:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQYEa-0002kv-Ho
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hQY3l-0004ct-Dq
	for qemu-devel@nongnu.org; Tue, 14 May 2019 10:05:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43312)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>)
	id 1hQY3k-0004bx-VA; Tue, 14 May 2019 10:05:37 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2D47A3086233;
	Tue, 14 May 2019 14:05:36 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 55B59608A7;
	Tue, 14 May 2019 14:05:35 +0000 (UTC)
To: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-devel@nongnu.org
References: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
From: Eric Blake <eblake@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=eblake@redhat.com; keydata=
	xsBNBEvHyWwBCACw7DwsQIh0kAbUXyqhfiKAKOTVu6OiMGffw2w90Ggrp4bdVKmCaEXlrVLU
	xphBM8mb+wsFkU+pq9YR621WXo9REYVIl0FxKeQo9dyQBZ/XvmUMka4NOmHtFg74nvkpJFCD
	TUNzmqfcjdKhfFV0d7P/ixKQeZr2WP1xMcjmAQY5YvQ2lUoHP43m8TtpB1LkjyYBCodd+LkV
	GmCx2Bop1LSblbvbrOm2bKpZdBPjncRNob73eTpIXEutvEaHH72LzpzksfcKM+M18cyRH+nP
	sAd98xIbVjm3Jm4k4d5oQyE2HwOur+trk2EcxTgdp17QapuWPwMfhaNq3runaX7x34zhABEB
	AAHNHkVyaWMgQmxha2UgPGVibGFrZUByZWRoYXQuY29tPsLAegQTAQgAJAIbAwULCQgHAwUV
	CgkICwUWAgMBAAIeAQIXgAUCS8fL9QIZAQAKCRCnoWtKJSdDahBHCACbl/5FGkUqJ89GAjeX
	RjpAeJtdKhujir0iS4CMSIng7fCiGZ0fNJCpL5RpViSo03Q7l37ss+No+dJI8KtAp6ID+PMz
	wTJe5Egtv/KGUKSDvOLYJ9WIIbftEObekP+GBpWP2+KbpADsc7EsNd70sYxExD3liwVJYqLc
	Rw7so1PEIFp+Ni9A1DrBR5NaJBnno2PHzHPTS9nmZVYm/4I32qkLXOcdX0XElO8VPDoVobG6
	gELf4v/vIImdmxLh/w5WctUpBhWWIfQDvSOW2VZDOihm7pzhQodr3QP/GDLfpK6wI7exeu3P
	pfPtqwa06s1pae3ad13mZGzkBdNKs1HEm8x6zsBNBEvHyWwBCADGkMFzFjmmyqAEn5D+Mt4P
	zPdO8NatsDw8Qit3Rmzu+kUygxyYbz52ZO40WUu7EgQ5kDTOeRPnTOd7awWDQcl1gGBXgrkR
	pAlQ0l0ReO57Q0eglFydLMi5bkwYhfY+TwDPMh3aOP5qBXkm4qIYSsxb8A+i00P72AqFb9Q7
	3weG/flxSPApLYQE5qWGSXjOkXJv42NGS6o6gd4RmD6Ap5e8ACo1lSMPfTpGzXlt4aRkBfvb
	NCfNsQikLZzFYDLbQgKBA33BDeV6vNJ9Cj0SgEGOkYyed4I6AbU0kIy1hHAm1r6+sAnEdIKj
	cHi3xWH/UPrZW5flM8Kqo14OTDkI9EtlABEBAAHCwF8EGAEIAAkFAkvHyWwCGwwACgkQp6Fr
	SiUnQ2q03wgAmRFGDeXzc58NX0NrDijUu0zx3Lns/qZ9VrkSWbNZBFjpWKaeL1fdVeE4TDGm
	I5mRRIsStjQzc2R9b+2VBUhlAqY1nAiBDv0Qnt+9cLiuEICeUwlyl42YdwpmY0ELcy5+u6wz
	mK/jxrYOpzXKDwLq5k4X+hmGuSNWWAN3gHiJqmJZPkhFPUIozZUCeEc76pS/IUN72NfprZmF
	Dp6/QDjDFtfS39bHSWXKVZUbqaMPqlj/z6Ugk027/3GUjHHr8WkeL1ezWepYDY7WSoXwfoAL
	2UXYsMAr/uUncSKlfjvArhsej0S4zbqim2ZY6S8aRWw94J3bSvJR+Nwbs34GPTD4Pg==
Organization: Red Hat, Inc.
Message-ID: <4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com>
Date: Tue, 14 May 2019 09:05:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zoi4VR71U73liYNrJ09bCUUgUXrVhftFB"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Tue, 14 May 2019 14:05:36 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH RESEND] monitor: Fix return type of
 monitor_fdset_dup_fd_find
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
Cc: qemu-trivial@nongnu.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zoi4VR71U73liYNrJ09bCUUgUXrVhftFB
From: Eric Blake <eblake@redhat.com>
To: Yury Kotov <yury-kotov@yandex-team.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, armbru@redhat.com
Message-ID: <4e2eabbd-f404-fa61-f23b-e862d7f20b3e@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RESEND] monitor: Fix return type of
 monitor_fdset_dup_fd_find
References: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
In-Reply-To: <20190514131552.15832-1-yury-kotov@yandex-team.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 5/14/19 8:15 AM, Yury Kotov wrote:
> monitor_fdset_dup_fd_find_remove() and monitor_fdset_dup_fd_find()
> returns mon_fdset->id which is int64_t. Downcast from int64_t to int le=
ads to
> a bug with removing fd from fdset which id >=3D 2^32.
> So, fix return types for these function.

fd's cannot exceed 2^32. We should instead be fixing anything that uses
int64_t with an fd to be properly limited to 32 bits.  That is, I think
the real problem is in qapi/misc.json:

 { 'struct': 'AddfdInfo', 'data': {'fdset-id': 'int', 'fd': 'int'} }
instead of 'fd':'int32'.  For that matter, 'fdset-id' larger than 32
bits is unlikely to be useful (there's no reason to have more fdsets
than you can have possible fds to put in those sets).

NACK to this version, but a v2 that addresses the real problem is
worthwhile.

> +++ b/include/monitor/monitor.h
> @@ -46,7 +46,7 @@ AddfdInfo *monitor_fdset_add_fd(int fd, bool has_fdse=
t_=3D
> id, int64_t fdset_id,
>  int monitor_fdset_get_fd(int64_t fdset_id, int flags);
>  int monitor_fdset_dup_fd_add(int64_t fdset_id, int dup_fd);
>  void monitor_fdset_dup_fd_remove(int dup_fd);
> -int monitor_fdset_dup_fd_find(int dup_fd);
> +int64_t monitor_fdset_dup_fd_find(int dup_fd);
> =3D20

Your patch came through corrupted. You may want to double-check how you
are sending them, to ensure they are not mangled.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--zoi4VR71U73liYNrJ09bCUUgUXrVhftFB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzayy4ACgkQp6FrSiUn
Q2p+qQgAnRWs7TBV5nIGTavtSHoT8iOh9U4hu/eobKmmpE5qPrq3YAZrAigmd3PZ
3fY7Nzwdk0lIaEYI6ban9VRG2874JTzK5Q2oMTi9o3ILQZk5pvOekMt2LGMlRqbS
WOYrz9e3PZFwn6FBrk8xmMKO16cjtlcWeIodclnIZ5cPLm0FD1gy+nI+IJUqHjk7
7l28eNmPhTSL63gIO0lldY9r0jWBExD78EiSrUFTRjC8F0TH3F2gl1SxAX9grIew
5dFRKg+BMcGXT46Nk8DSK7pADGpl7/zous11CDC4xzhskX+0L2qj3FzyjGNrnJMS
1BuyS/ny8RRKZfMb2QLVYs+93R6FrA==
=jsNO
-----END PGP SIGNATURE-----

--zoi4VR71U73liYNrJ09bCUUgUXrVhftFB--

