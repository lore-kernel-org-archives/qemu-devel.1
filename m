Return-Path: <SRS0=wgY8=XI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E0C49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A01820830
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2019 11:50:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A01820830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8k5p-0001NS-DE
	for qemu-devel@archiver.kernel.org; Fri, 13 Sep 2019 07:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48639)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i8k4A-0008TP-Co
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:48:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i8k49-00053D-5z
 for qemu-devel@nongnu.org; Fri, 13 Sep 2019 07:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59516)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i8k46-00051y-C6; Fri, 13 Sep 2019 07:48:38 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A5F27C010925;
 Fri, 13 Sep 2019 11:48:37 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-116-81.ams2.redhat.com
 [10.36.116.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D9049600CE;
 Fri, 13 Sep 2019 11:48:32 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190910124136.10565-1-mreitz@redhat.com>
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
Message-ID: <9029d621-0b48-9a65-5699-7c55151e6b81@redhat.com>
Date: Fri, 13 Sep 2019 13:48:31 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MGGTposjemt39S0EnSri9tK0Odgi1DG70"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 13 Sep 2019 11:48:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/7] block/curl: Fix hang and potential
 crash
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MGGTposjemt39S0EnSri9tK0Odgi1DG70
Content-Type: multipart/mixed; boundary="dEJ6YMG357DKtGuMaNsZEEoddL3hM1Mwx";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-stable@nongnu.org
Message-ID: <9029d621-0b48-9a65-5699-7c55151e6b81@redhat.com>
Subject: Re: [PATCH v2 0/7] block/curl: Fix hang and potential crash
References: <20190910124136.10565-1-mreitz@redhat.com>
In-Reply-To: <20190910124136.10565-1-mreitz@redhat.com>

--dEJ6YMG357DKtGuMaNsZEEoddL3hM1Mwx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 10.09.19 14:41, Max Reitz wrote:
> Hi,
>=20
> As reported in https://bugzilla.redhat.com/show_bug.cgi?id=3D1740193, o=
ur
> curl block driver can spontaneously hang.  This becomes visible e.g.
> when reading compressed qcow2 images:
>=20
> $ qemu-img convert -p -O raw -n \
>   https://download.cirros-cloud.net/0.4.0/cirros-0.4.0-x86_64-disk.img =
\
>   null-co://
>=20
> (Hangs at 74.21 %, usually.)
>=20
> A more direct way is:
>=20
> $ qemu-img bench -f raw http://download.qemu.org/qemu-4.1.0.tar.xz \
>     -d 1 -S 524288 -c 2
>=20
> (Which simply performs two requests, and the second one hangs.  You can=

> use any HTTP resource (probably FTP, too) you=E2=80=99d like that is at=
 least
> 1 MB in size.)
>=20
> It turns out that this is because cURL 7.59.0 has added a protective
> feature against some misuse we had in our code: curl_multi_add_handle()=

> must not be called from within a cURL callback, but in some cases we
> did.  As of 7.59.0, this fails, our new request is not registered and
> the I/O request stalls.  This is fixed by patch 6.
>=20
> Patch 7 makes us check for curl_multi_add_handle()=E2=80=99s return cod=
e,
> because if we had done that before, debugging would have been much
> simpler.
>=20
>=20
> On the way to fixing it, I had a look over the whole cURL code and foun=
d
> a suspicious QLIST_FOREACH_SAFE() loop that actually does not seem very=

> safe at all.  I think this may lead to crashes, although I have never
> seen any myself.  https://bugzilla.redhat.com/show_bug.cgi?id=3D1744602=
#c5
> shows one in exactly the function in question, so I think it actually i=
s
> a problem.
>=20
> This is fixed by patch 5, patches 1, 2, and 4 prepare for it.
>=20
> (Patch 3 is kind of a misc patch that should ensure that we always end
> up calling curl_multi_check_completion() whenever a request might have
> been completed.)

Thanks for the review, applied to my block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--dEJ6YMG357DKtGuMaNsZEEoddL3hM1Mwx--

--MGGTposjemt39S0EnSri9tK0Odgi1DG70
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl17gg8ACgkQ9AfbAGHV
z0A6iAf+OWuzCyaWNXk0mrwFwcwfRefl76baF5j7yqlWfV9nz96y5ZP41khBDWL7
1eGebNGaO2vdM3pzFBP0Ps590C8/tyNhPs5bFP6k6QQ5EPs+vHgAngv8Znev2MTO
20Wku6Io5AWSABM/uiQ9VpC+f1rrLkZJf6fGQf3SskFqtOWSWPfTRzWIbErSw1ZM
g0+Pyi93QfyFtDu8/SD9evGVyEws0ELaQZu2hbmthilvURlvYzA7+zKKGh04osjY
7/jvZViKA32YNG8M+FR0gyi8eMXH/1eBW8y652goYB3VEEYWNgULR+5s7iPAV85E
WZQCPWYbrL46UmbRuMKavJwAdYM1DA==
=h9u1
-----END PGP SIGNATURE-----

--MGGTposjemt39S0EnSri9tK0Odgi1DG70--

