Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FCB9C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:06:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF930207E0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 18:06:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF930207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42538 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbTcn-0001cJ-Ed
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 13:34:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44637)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hbSF7-0000rV-Bf
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:06:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hbSF5-0002vw-92
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 12:06:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55446)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hbSEx-0002Ir-3z; Thu, 13 Jun 2019 12:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5CF8B307D988;
 Thu, 13 Jun 2019 16:06:13 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.187])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 25A555DD7F;
 Thu, 13 Jun 2019 16:06:11 +0000 (UTC)
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20190611102720.86114-1-vsementsov@virtuozzo.com>
 <20190611102720.86114-4-vsementsov@virtuozzo.com>
 <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>
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
Message-ID: <8ce11b07-91b3-df46-53f1-7de34e9bb26e@redhat.com>
Date: Thu, 13 Jun 2019 18:06:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pl7hSGchpcG2rLGy7a0ObtostemTPGtBp"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Thu, 13 Jun 2019 16:06:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 3/3] block/nbd: merge NBDClientSession
 struct back to BDRVNBDState
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
Cc: kwolf@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pl7hSGchpcG2rLGy7a0ObtostemTPGtBp
Content-Type: multipart/mixed; boundary="fVErcUlQLI5c5KInrgBZWMgeHR9EXkML5";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com
Message-ID: <8ce11b07-91b3-df46-53f1-7de34e9bb26e@redhat.com>
Subject: Re: [PATCH 3/3] block/nbd: merge NBDClientSession struct back to
 BDRVNBDState
References: <20190611102720.86114-1-vsementsov@virtuozzo.com>
 <20190611102720.86114-4-vsementsov@virtuozzo.com>
 <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>
In-Reply-To: <c03ff39b-5e8f-ed0a-d33c-2d2d4919cd33@redhat.com>

--fVErcUlQLI5c5KInrgBZWMgeHR9EXkML5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.06.19 17:16, Eric Blake wrote:
> On 6/11/19 5:27 AM, Vladimir Sementsov-Ogievskiy wrote:
>> No reason to keep it separate, it differs from others block driver
>> behavior and therefor confuses. Instead of generic
>=20
> s/therefor/therefore/ (both spellings are valid, but the former looks
> archaic)
The things you teach me.

I will happily use =E2=80=9Ctherefor=E2=80=9D from now on whenever not to=
o inappropriate.

(I like how Wiktionary notes that =E2=80=9Ctherefor=E2=80=9D is an anagra=
m of
=E2=80=9Ctherfore=E2=80=9D.  That one looks nice, too.  I suppose I will =
just switch
between both at random.)

Max


--fVErcUlQLI5c5KInrgBZWMgeHR9EXkML5--

--pl7hSGchpcG2rLGy7a0ObtostemTPGtBp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0CdHIACgkQ9AfbAGHV
z0BUhAf+IRAhur7uqTtG6NmhubNfm6SZIwznZC/QevxdUSZ0Y+seWXbdAn8mvx2U
J+v/cujNcPBRxG3Pfhum5d9pQruJ/bXMHsXWyLINzebGTVbQd+EfuvNg7gXo7BP9
5btxEUwt64HJir2lxDelVwW081KtajE1MuyFjC3aRp1WRO1J2XjuK5QM95iKO6Ee
TkL4hPnyhJlOmpfGoFomOGh4dv0h9BHihsIyFWmBbWcnPRizqEKMP3FZhM7evY3Y
XXzVdoNH8pWfwlo9rK0H1JIh+kFyabvEFz/LthxBmg7tVKXSAnlmyBhsOOa9lLJE
S+NtrCAIxN9N/i7U0m1rzTYRlOxPFA==
=REEC
-----END PGP SIGNATURE-----

--pl7hSGchpcG2rLGy7a0ObtostemTPGtBp--

