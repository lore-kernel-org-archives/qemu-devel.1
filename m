Return-Path: <SRS0=2JTU=UU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDADFC43613
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:57:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A0DB720679
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Jun 2019 21:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0DB720679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38091 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1heRXc-00018h-Pg
	for qemu-devel@archiver.kernel.org; Fri, 21 Jun 2019 17:57:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49812)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1heRQN-0007tG-Cw
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:50:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1heRQG-0006oq-SH
 for qemu-devel@nongnu.org; Fri, 21 Jun 2019 17:50:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57720)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1heRPd-0005MC-A8; Fri, 21 Jun 2019 17:49:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B26B6308624B;
 Fri, 21 Jun 2019 21:48:43 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-30.brq.redhat.com
 [10.40.204.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 266F319C4F;
 Fri, 21 Jun 2019 21:48:38 +0000 (UTC)
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
 <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
 <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
 <460b3bf5-23e6-15f5-eb9e-1451ef246af9@virtuozzo.com>
 <341981f8-9900-2349-023c-ab9b6cf0e6c1@redhat.com>
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
Message-ID: <0556a380-a2ba-0893-ed22-e6698fea84d7@redhat.com>
Date: Fri, 21 Jun 2019 23:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <341981f8-9900-2349-023c-ab9b6cf0e6c1@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="UYqT1MO4xtFaYF8hy7FQwdHzoHd4U8kcR"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Fri, 21 Jun 2019 21:48:44 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap
 sync policy
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--UYqT1MO4xtFaYF8hy7FQwdHzoHd4U8kcR
Content-Type: multipart/mixed; boundary="xZ820jWvhMIIJw0yTDWROEvGwy2QUmMxz";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <0556a380-a2ba-0893-ed22-e6698fea84d7@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/12] block/backup: add 'always' bitmap sync
 policy
References: <20190620010356.19164-1-jsnow@redhat.com>
 <20190620010356.19164-8-jsnow@redhat.com>
 <8fde15e1-9693-9e46-b5c8-0f657b1eebed@virtuozzo.com>
 <0eba7f8d-d1ed-fd4d-c417-346083cbed9c@virtuozzo.com>
 <05fd79a3-1828-f65b-118a-952aef26642a@virtuozzo.com>
 <460b3bf5-23e6-15f5-eb9e-1451ef246af9@virtuozzo.com>
 <341981f8-9900-2349-023c-ab9b6cf0e6c1@redhat.com>
In-Reply-To: <341981f8-9900-2349-023c-ab9b6cf0e6c1@redhat.com>

--xZ820jWvhMIIJw0yTDWROEvGwy2QUmMxz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 21.06.19 22:58, John Snow wrote:
>=20
>=20
> On 6/21/19 9:44 AM, Vladimir Sementsov-Ogievskiy wrote:

[...]

Just chiming in on this:

>> "So on cancel and abort you synchronize bitmap too?"
>=20
> I will concede that this means that if you ask for a bitmap backup with=

> the 'always' policy and, for whatever reason change your mind about
> this, there's no way to "cancel" the job in a manner that does not edit=

> the bitmap at this point.
>=20
> I do agree that this seems to go against the wishes of the user, becaus=
e
> we have different "kinds" of cancellations:
>=20
> A) Cancellations that actually represent failures in transactions
> B) Cancellations that represent genuine user intention
>=20
> It might be nice to allow the user to say "No wait, please don't edit
> that bitmap, I made a mistake!"

So that =E2=80=9Calways=E2=80=9D doesn=E2=80=99t mean =E2=80=9Calways=E2=80=
=9D?  To me, that seems like not so
good an idea.

If the user uses always, they have to live with that.  I had to live
with calling =E2=80=9Crm=E2=80=9D on the wrong file before.  Life=E2=80=99=
s tough.

In all seriousness: =E2=80=9CAlways=E2=80=9D is not something a user woul=
d use, is it?
It=E2=80=99s something for management tools.  Why would they cancel becau=
se
=E2=80=9CThey made a mistake=E2=80=9D?

Second, what=E2=80=99s the worst thing that may come out of such a mistak=
e?
Having to perform a full backup?  If so, that doesn=E2=80=99t seem so bad=
 to me.
 It certainly doesn=E2=80=99t seem so bad to make an unrelated mechanic h=
ave an
influence on whether =E2=80=9Calways=E2=80=9D means =E2=80=9Calways=E2=80=
=9D.

Also, this cancel idea would only work for jobs where the bitmap mode
does not come into play until the job is done, i.e. backup.  I suppose
if we want to have bitmap modes other than 'always' for mirror, that too
would have to make a copy of the user-supplied bitmap, so there the
bitmap mode would make a difference only at the end of the job, too, but
who knows.

And if it only makes a difference at the end of the job, you might as
well just add a way to change a running job=E2=80=99s bitmap-mode.

Max


--xZ820jWvhMIIJw0yTDWROEvGwy2QUmMxz--

--UYqT1MO4xtFaYF8hy7FQwdHzoHd4U8kcR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0NULUACgkQ9AfbAGHV
z0CGBwgAucM5Cr+czTFbEwniaLHvecS5nlyxzl06RoK5EQvUZ5GaLstrXS4qPSlA
/IcRSgevMPZin99L5ZbvpPYeioI9PxYots1VHCgfv96veqlq68sR8n96HCTTCruk
pQN6ivEWRntwSpbjijW3r0mp88taP4TV552p5MqYh/bLZvaJiXabHVuyugMuW/C1
asLVqfboNPm2mq5xuT54xfJ2wpG/bOwqwvu5XOPQ6/6LXmySFgyo2NTwb1QPzcFf
10EHQ1RK3sK3TKK1Zwqv3jqRuP46QsgLeVkEJ8uZ/lETbIYFM+tRvq14rhX9/otu
bDnKAUQ8QgM9KdVwUg5tlZlCHPzqAQ==
=LFIk
-----END PGP SIGNATURE-----

--UYqT1MO4xtFaYF8hy7FQwdHzoHd4U8kcR--

