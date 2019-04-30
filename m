Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F58C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:31:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A25B20835
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 18:31:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A25B20835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLXXp-0007ol-Br
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 14:31:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXWo-0007O9-3a
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hLXWn-0003pt-3v
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1hLXWm-0003pJ-RF
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 14:30:53 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A34163087950;
	Tue, 30 Apr 2019 18:30:51 +0000 (UTC)
Received: from [10.3.116.15] (ovpn-116-15.phx2.redhat.com [10.3.116.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9291001284;
	Tue, 30 Apr 2019 18:30:50 +0000 (UTC)
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
References: <20190430181343.1362-1-driver1998@foxmail.com>
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
Message-ID: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
Date: Tue, 30 Apr 2019 13:30:49 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430181343.1362-1-driver1998@foxmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.45]);
	Tue, 30 Apr 2019 18:30:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430183049.PA_LUCx96DbJWswZ3bUDPwa8yHEpc4Dd1c0N9NKEFoE@z>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3
From: Eric Blake <eblake@redhat.com>
To: Cao Jiaxi <driver1998@foxmail.com>, qemu-devel@nongnu.org
Message-ID: <141080f9-8374-1d16-7b40-a4848a455086@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 4/4] include/qemu/osdep.h: Move the
 __USE_MINGW_ANSI_STDIO define up to avoid confliction.
References: <20190430181343.1362-1-driver1998@foxmail.com>
In-Reply-To: <20190430181343.1362-1-driver1998@foxmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/30/19 1:13 PM, Cao Jiaxi wrote:
> Signed-off-by: Cao Jiaxi <driver1998@foxmail.com>

Your entire series is missing 'In-Reply-To:' and 'References:' headers,
making each message show up as individual new threads rather than
properly threaded to a 0/4 cover letter. You'll want to fix your sending
habits to avoid that problem in future submissions.

It's unusual to use a trailing '.' in the subject line. Also, your
subject is very long; commit message summaries should typically be
around 60-70 characters because 'git log' shows them with further
indentation, where an 80-column terminal window makes it hard to see the
tail at a glance.  Better might be a short subject line explaining the
"what", and then a non-empty commit message explaining the "why",
perhaps looking like:

osdep: Fix mingw compilation regarding stdio formats

I encountered the following compilation error on mingw:
=2E.. PASTE SOMETHING HERE

It turns out that __USE_MINGW_ANSI_STDIO must be set before any system
headers are included, not just before <stdio.h>.

Signed-off-by:...

> =20
> +/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or late=
r) */
> +#ifdef __MINGW32__
> +#define __USE_MINGW_ANSI_STDIO 1
> +#endif
> +
>  #include <stdarg.h>
>  #include <stddef.h>
>  #include <stdbool.h>
>  #include <stdint.h>
>  #include <sys/types.h>
>  #include <stdlib.h>
> -
> -/* enable C99/POSIX format strings (needs mingw32-runtime 3.15 or late=
r) */
> -#ifdef __MINGW32__
> -#define __USE_MINGW_ANSI_STDIO 1
> -#endif

Question - does it hurt to make the define of __USE_MINGW_ANSI_STDIO
unconditional?  In other words, we're unlikely to break any non-mingw
platform if we drop the #ifdef __MINGW32__ line.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlzIlFoACgkQp6FrSiUn
Q2qsLAf7BKrNA+pbzKmsmL8HdJ9SHauWc3MZG3US/HRC6jJP7izlSLIIMPYAvLsf
LwLWbw5UahmwDhLZUXGELLnVLp1dCBUCwi3cv+DdfR7Z8gnp5KzTIgYgUOdurl5p
T1J0Jv6KLm7uZTrLQ1egqMleZt6RnLyR41QE3dtXQNF4pWWdQk9+IMhCm9Vzx4yu
9i7t5CiFFJAoCdi/JMXrxFDBBuoivNGxafwMYbrkx2WlXicyr7jzgRQ/N8oDN+Jb
Cehgms1pxEQrrSnOtawkNSGFHWCesB6HaELzyRrGREVfuzYZyUe2ECH14YZFX7NY
/RHTDxei6kRudVKJMac7RhRE9IlfbA==
=43lk
-----END PGP SIGNATURE-----

--D5znanzGLs8VqY6uYfzs3jAPpjiNkETT3--

