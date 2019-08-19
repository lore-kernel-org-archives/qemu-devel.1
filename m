Return-Path: <SRS0=e4Up=WP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F41C3A5A0
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:40:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ADB222CEB
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2019 20:40:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ADB222CEB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57626 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzoST-0005I0-D6
	for qemu-devel@archiver.kernel.org; Mon, 19 Aug 2019 16:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46330)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1hzoAs-00072W-QI
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:22:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hzoAq-0005cY-L9
 for qemu-devel@nongnu.org; Mon, 19 Aug 2019 16:22:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52126)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hzoAW-0005Zk-8G; Mon, 19 Aug 2019 16:22:20 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 7E69836887;
 Mon, 19 Aug 2019 20:22:19 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-64.brq.redhat.com
 [10.40.204.64])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E2D515C686;
 Mon, 19 Aug 2019 20:22:15 +0000 (UTC)
To: qemu-block@nongnu.org
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-3-mreitz@redhat.com>
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
Message-ID: <ca574f30-157c-88ef-db73-f96e16846f11@redhat.com>
Date: Mon, 19 Aug 2019 22:22:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190819201851.24418-3-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hwdNeyiRroGeZKSPelsnGMWC5nV84Ulxj"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.30]); Mon, 19 Aug 2019 20:22:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 2/8] iotests: Prefer null-co over
 null-aio
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hwdNeyiRroGeZKSPelsnGMWC5nV84Ulxj
Content-Type: multipart/mixed; boundary="X1YydFFVwv1gPEYlyZQo9W7KMDdx24lEi";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <ca574f30-157c-88ef-db73-f96e16846f11@redhat.com>
Subject: Re: [PATCH v3 2/8] iotests: Prefer null-co over null-aio
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-3-mreitz@redhat.com>
In-Reply-To: <20190819201851.24418-3-mreitz@redhat.com>

--X1YydFFVwv1gPEYlyZQo9W7KMDdx24lEi
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.08.19 22:18, Max Reitz wrote:
> We use null-co basically everywhere in the iotests.  Unless we want to
> test null-aio specifically, we should use it instead (for consistency).=

>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Reviewed-by: John Snow <jsnow@redhat.com>

Hm, sorry, I just noticed that I probably should have dropped this R-b. :=
-/

(I mean, apart from the rebase conflict, nothing has changed, but still.)=


Max

> ---
>  tests/qemu-iotests/093 | 7 +++----
>  tests/qemu-iotests/245 | 2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
>=20
> diff --git a/tests/qemu-iotests/093 b/tests/qemu-iotests/093
> index 3c4f5173ce..50c1e7f2ec 100755
> --- a/tests/qemu-iotests/093
> +++ b/tests/qemu-iotests/093
> @@ -267,13 +267,12 @@ class ThrottleTestCoroutine(ThrottleTestCase):
>      test_img =3D "null-co://"
> =20
>  class ThrottleTestGroupNames(iotests.QMPTestCase):
> -    test_img =3D "null-aio://"
>      max_drives =3D 3
> =20
>      def setUp(self):
>          self.vm =3D iotests.VM()
>          for i in range(0, self.max_drives):
> -            self.vm.add_drive(self.test_img,
> +            self.vm.add_drive("null-co://",
>                                "throttling.iops-total=3D100,file.read-z=
eroes=3Don")
>          self.vm.launch()
> =20
> @@ -376,10 +375,10 @@ class ThrottleTestRemovableMedia(iotests.QMPTestC=
ase):
> =20
>      def test_removable_media(self):
>          # Add a couple of dummy nodes named cd0 and cd1
> -        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
> +        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
>                               read_zeroes=3DTrue, node_name=3D"cd0")
>          self.assert_qmp(result, 'return', {})
> -        result =3D self.vm.qmp("blockdev-add", driver=3D"null-aio",
> +        result =3D self.vm.qmp("blockdev-add", driver=3D"null-co",
>                               read_zeroes=3DTrue, node_name=3D"cd1")
>          self.assert_qmp(result, 'return', {})
> =20
> diff --git a/tests/qemu-iotests/245 b/tests/qemu-iotests/245
> index bc1ceb9792..ae169778b0 100644
> --- a/tests/qemu-iotests/245
> +++ b/tests/qemu-iotests/245
> @@ -598,7 +598,7 @@ class TestBlockdevReopen(iotests.QMPTestCase):
>          ##################
>          ###### null ######
>          ##################
> -        opts =3D {'driver': 'null-aio', 'node-name': 'root', 'size': 1=
024}
> +        opts =3D {'driver': 'null-co', 'node-name': 'root', 'size': 10=
24}
> =20
>          result =3D self.vm.qmp('blockdev-add', conv_keys =3D False, **=
opts)
>          self.assert_qmp(result, 'return', {})
>=20



--X1YydFFVwv1gPEYlyZQo9W7KMDdx24lEi--

--hwdNeyiRroGeZKSPelsnGMWC5nV84Ulxj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1bBPYACgkQ9AfbAGHV
z0BuKQf9EeAprQ5Q90R5NSSgVBw0yuucY3MtYgEXT35cxJy4ln3ZGuCbERdRNpDM
zaqpZB1QV+UqUfbM4mTePcuImkd4LRsshP/Affg5Ug6RfHVW423jGF7h2dmDVHJ2
zV8vPnlsL2wd5Db++/1YUhUUeXdURBVuOByzwskjwLbiUADG7VnQ0hw6How52b/w
qn/5Snb0EYrJu3JQ6BsdhC1WkCUDAQOUDz6YSdUYRNU43Qtw4sp4dfEBxeVGxen0
7n9DyBtKYzdJ6PhzGynogy8C1qIrkbEoCOIo9s2RVyzoQVzTeuqL9VGiIMNSb0Dc
HznZ7ocMSR4Get0pen6/CLQkamS9zA==
=teGj
-----END PGP SIGNATURE-----

--hwdNeyiRroGeZKSPelsnGMWC5nV84Ulxj--

