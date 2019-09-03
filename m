Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D61E4C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:56:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A930423400
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 12:56:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A930423400
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i58Ly-0003tP-TI
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 08:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i58L8-0003Da-C4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:55:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i58L7-0005a9-6C
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 08:55:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49060)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i58L4-0005ZV-Ol; Tue, 03 Sep 2019 08:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id EC17718F351C;
 Tue,  3 Sep 2019 12:55:13 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-98.brq.redhat.com
 [10.40.204.98])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C1C095C557;
 Tue,  3 Sep 2019 12:55:12 +0000 (UTC)
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
References: <20190823133552.11680-1-thuth@redhat.com>
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
Message-ID: <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>
Date: Tue, 3 Sep 2019 14:55:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190823133552.11680-1-thuth@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BiMHswwg2hWoQeBGnogmgDD0iWeWItZN1"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.63]); Tue, 03 Sep 2019 12:55:14 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Check for enabled drivers
 before testing them
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
--BiMHswwg2hWoQeBGnogmgDD0iWeWItZN1
Content-Type: multipart/mixed; boundary="K2EgOs2qutASkU3uUEVkB09uaiPQJ4KKy";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <3d606509-ffe4-eba6-3e40-2ab3e1e29607@redhat.com>
Subject: Re: [PATCH v2] iotests: Check for enabled drivers before testing them
References: <20190823133552.11680-1-thuth@redhat.com>
In-Reply-To: <20190823133552.11680-1-thuth@redhat.com>

--K2EgOs2qutASkU3uUEVkB09uaiPQJ4KKy
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.08.19 15:35, Thomas Huth wrote:
> It is possible to enable only a subset of the block drivers with the
> "--block-drv-rw-whitelist" option of the "configure" script. All other
> drivers are marked as unusable (or only included as read-only with the
> "--block-drv-ro-whitelist" option). If an iotest is now using such a
> disabled block driver, it is failing - which is bad, since at least the=

> tests in the "auto" group should be able to deal with this situation.
> Thus let's introduce a "_require_drivers" function that can be used by
> the shell tests to check for the availability of certain drivers first,=

> and marks the test as "not run" if one of the drivers is missing.
>=20
> This patch mainly targets the test in the "auto" group which should
> never fail in such a case, but also improves some of the other tests
> along the way. Note that we also assume that the "qcow2" and "file"
> drivers are always available - otherwise it does not make sense to
> run "make check-block" at all (which only tests with qcow2 by default).=

>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  v2:
>  - Update the check in _require_drivers() according to Max' suggestion
>  - Remove superfluous check in test 081
>  - Mark 120 to require "raw"
>  - Replaced the check in 162 to use the new _require_drivers() function=

>  - Mark 186 to require "null-co"
>=20
>  tests/qemu-iotests/071       |  1 +
>  tests/qemu-iotests/081       |  4 +---
>  tests/qemu-iotests/099       |  1 +
>  tests/qemu-iotests/120       |  1 +
>  tests/qemu-iotests/162       |  4 +---
>  tests/qemu-iotests/184       |  1 +
>  tests/qemu-iotests/186       |  1 +
>  tests/qemu-iotests/common.rc | 14 ++++++++++++++
>  8 files changed, 21 insertions(+), 6 deletions(-)

This patch breaks these iotests when $DISPLAY is not set.  It does work
with =E2=80=9Ciotests: Add -display none to the qemu options=E2=80=9D.

Hm.  You reviewed that one, so I suppose I=E2=80=99ll just take it into v=
2 of my
pull request as well.

(I=E2=80=99m not going to say having added the iotests to make check give=
s me as
a maintainer more trouble than I had before, but, you know.)

Max


--K2EgOs2qutASkU3uUEVkB09uaiPQJ4KKy--

--BiMHswwg2hWoQeBGnogmgDD0iWeWItZN1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1uYq8ACgkQ9AfbAGHV
z0AKMAgAnaCWSg747uih1p287wXlUP8nZU2NJCEZK+1q63IJ/HJrsl9cZFcU5U0S
dTHKvWeyEOmhxBmvWGRuENKj5F0KjSbztKZ3ii1LmYOV7FZp5ukasOVmzBFYABn9
wzKTpc5XfYDuRF1X3sq5WdT0GgKbBiDZ/P0YE1Wizyt/NZ/OsLrNg1vGrr9/Jdlc
e1YApKNrceORxly/+vrojIRpHeu+Ce6slg2+Eo5/aytqJTOK7z5l8xJSnnPSwrao
GJ0UPPTp1PpgfOcDbibmMg+0tGHo5t+/eW21S+iABurQtnJ0A95FK2nLWRPPf4KU
wx9mgeMegUWRlKP2XX69UKw7LXarwg==
=ihjm
-----END PGP SIGNATURE-----

--BiMHswwg2hWoQeBGnogmgDD0iWeWItZN1--

