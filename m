Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF5AECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:47:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E49712089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 11:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E49712089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL4Fn-0003Je-3R
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 07:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49060)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1iL4Ef-0002o6-7E
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:46:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1iL4Ee-0003vR-8e
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 07:46:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38004)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1iL4Ec-0003us-2V; Thu, 17 Oct 2019 07:46:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E8347BDA6;
 Thu, 17 Oct 2019 11:46:25 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-3.ams2.redhat.com
 [10.36.117.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E73861001DC0;
 Thu, 17 Oct 2019 11:46:23 +0000 (UTC)
Subject: Re: [PATCH v2 1/3] iotests: Fix 173
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20191015193503.25591-1-eblake@redhat.com>
 <20191015193503.25591-2-eblake@redhat.com>
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
Message-ID: <4aa107c6-db84-006c-962a-81c90933c3a4@redhat.com>
Date: Thu, 17 Oct 2019 13:46:21 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191015193503.25591-2-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="KMrMsm5FRKFelttDDAgOm8LIjeg0RKCDq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Thu, 17 Oct 2019 11:46:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KMrMsm5FRKFelttDDAgOm8LIjeg0RKCDq
Content-Type: multipart/mixed; boundary="JHgGW6wlTaPGAaizqWmG13V7eGOmxJWyv"

--JHgGW6wlTaPGAaizqWmG13V7eGOmxJWyv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.10.19 21:35, Eric Blake wrote:
> This test has been broken since 3.0.  It used TEST_IMG to influence
> the name of a file created during _make_test_img, but commit 655ae6bb
> changed things so that the wrong file name is being created, which
> then caused _launch_qemu to fail.  In the meantime, the set of events
> issued for the actions of the test has increased.
>=20
> Why haven't we noticed the failure? Because the test rarely gets run:
> './check -qcow2 173' is insufficient (that defaults to using file proto=
col)
> './check -nfs 173' is insufficient (that defaults to using raw format)
> so the test is only run with:
> ./check -qcow2 -nfs 173
>=20
> Note that we already have a number of other problems with -nfs:
> ./check -nfs (fails 18/30)
> ./check -qcow2 -nfs (fails 45/76 after this patch)
> and it's not on my priority list to fix those.  Rather, I found this
> because of my next patch's work on tests using _send_qemu_cmd.
>=20
> Fixes: 655ae6b
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>  tests/qemu-iotests/173     | 4 ++--
>  tests/qemu-iotests/173.out | 6 +++++-
>  2 files changed, 7 insertions(+), 3 deletions(-)

On second thought, I wonder whether this test actually does anything
with NFS.  It doesn=E2=80=99t look like it to me.

I wonder because for some reason I can=E2=80=99t get NFS to work with qem=
u at
all.  I don=E2=80=99t think the iotests are at fault why so many tests fa=
il,
actually.

Max


--JHgGW6wlTaPGAaizqWmG13V7eGOmxJWyv--

--KMrMsm5FRKFelttDDAgOm8LIjeg0RKCDq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl2oVI0ACgkQ9AfbAGHV
z0CPNAf/YbkpXl9FJUzrMf5xKDF1t59zztZEZxqjvFvD/OkST07z3Ivr8W81E06F
4dIprVZtNBaMCjbRIsT96zZPYZma9+wOgZ+Lnbwz5d8prpASsM4Vjc72ilemqVzr
NCo9tdLj6Qt4TRMLPYNQ0gW6ypobgtpyD9Z0XmWo2zeKD77FushTk6DiqIyZ0kGv
ueSqN3SoH5dWQ5TD4NO0Wfoiw65Wy/7f7y19a9Kl01e411F/aLXYaRK4f+Xdw8MN
dxqpiCIkd3cHck+sUKaXFVIitVUbHRcW2c0Ilw33/0Ja5aBXj2CQnlZyTbTDmBUV
I1hIkywWp7yVylIXrzBo6AhePb1kwA==
=I9mo
-----END PGP SIGNATURE-----

--KMrMsm5FRKFelttDDAgOm8LIjeg0RKCDq--

