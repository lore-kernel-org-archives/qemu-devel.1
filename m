Return-Path: <SRS0=blGQ=VB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C509C0651F
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045AA218A3
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2019 14:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045AA218A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hj2hZ-0007Co-0k
	for qemu-devel@archiver.kernel.org; Thu, 04 Jul 2019 10:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58285)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hj2ge-0006T5-Rz
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:26:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hj2gd-00021B-SR
 for qemu-devel@nongnu.org; Thu, 04 Jul 2019 10:26:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60538)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hj2gb-0001y9-FJ; Thu, 04 Jul 2019 10:26:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0A09E5AFF8;
 Thu,  4 Jul 2019 14:25:57 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-93.brq.redhat.com
 [10.40.204.93])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 890D21001B23;
 Thu,  4 Jul 2019 14:25:47 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-2-jsnow@redhat.com>
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
Message-ID: <fa5ae0cd-eabe-7696-9f25-5fb6c9c365df@redhat.com>
Date: Thu, 4 Jul 2019 16:25:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190703215542.16123-2-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="lVfmctyWAYy2aNhSj9hceu7wdjkc5y9to"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 04 Jul 2019 14:26:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 01/18] qapi/block-core: Introduce
 BackupCommon
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
 vsementsov@virtuozzo.com, Juan Quintela <quintela@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--lVfmctyWAYy2aNhSj9hceu7wdjkc5y9to
Content-Type: multipart/mixed; boundary="EDBP1U9LEBJQB82pIJ5N8h8gq7wCusTPD";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Wen Congyang <wencongyang2@huawei.com>, vsementsov@virtuozzo.com,
 Xie Changlong <xiechanglong.d@gmail.com>
Message-ID: <fa5ae0cd-eabe-7696-9f25-5fb6c9c365df@redhat.com>
Subject: Re: [PATCH v2 01/18] qapi/block-core: Introduce BackupCommon
References: <20190703215542.16123-1-jsnow@redhat.com>
 <20190703215542.16123-2-jsnow@redhat.com>
In-Reply-To: <20190703215542.16123-2-jsnow@redhat.com>

--EDBP1U9LEBJQB82pIJ5N8h8gq7wCusTPD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 03.07.19 23:55, John Snow wrote:
> drive-backup and blockdev-backup have an awful lot of things in common
> that are the same. Let's fix that.
>=20
> I don't deduplicate 'target', because the semantics actually did change=

> between each structure. Leave that one alone so it can be documented
> separately.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/block-core.json | 103 ++++++++++++++-----------------------------=

>  1 file changed, 33 insertions(+), 70 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 0d43d4f37c..7b23efcf13 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -1315,32 +1315,23 @@
>    'data': { 'node': 'str', 'overlay': 'str' } }
> =20
>  ##
> -# @DriveBackup:
> +# @BackupCommon:
>  #
>  # @job-id: identifier for the newly-created block job. If
>  #          omitted, the device name will be used. (Since 2.7)
>  #
>  # @device: the device name or node-name of a root node which should be=
 copied.
>  #
> -# @target: the target of the new image. If the file exists, or if it
> -#          is a device, the existing file/device will be used as the n=
ew
> -#          destination.  If it does not exist, a new file will be crea=
ted.
> -#
> -# @format: the format of the new destination, default is to
> -#          probe if @mode is 'existing', else the format of the source=

> -#
>  # @sync: what parts of the disk image should be copied to the destinat=
ion
>  #        (all the disk, only the sectors allocated in the topmost imag=
e, from a
>  #        dirty bitmap, or only new I/O).
>  #
> -# @mode: whether and how QEMU should create a new image, default is
> -#        'absolute-paths'.
> -#
> -# @speed: the maximum speed, in bytes per second
> +# @speed: the maximum speed, in bytes per second. The default is 0,
> +#         for unlimited.
>  #
>  # @bitmap: the name of dirty bitmap if sync is "incremental".
>  #          Must be present if sync is "incremental", must NOT be prese=
nt
> -#          otherwise. (Since 2.4)
> +#          otherwise. (Since 2.4 (Drive), 3.1 (Blockdev))

s/Drive/drive-backup/, s/Blockdev/blockdev-backup/?

Other than that:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--EDBP1U9LEBJQB82pIJ5N8h8gq7wCusTPD--

--lVfmctyWAYy2aNhSj9hceu7wdjkc5y9to
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0eDGkACgkQ9AfbAGHV
z0AVDAf/WW0StTthMaZopBMQ7NzKR17cwaAXZwRkpQ+zYmWSyNQ8TI3b7Vd1Tie4
Ygh7PN1+j7SCljqKwbDWafrzVv1484/7+dvnpq3e3hHIjHdB9pETGCT2isu1bOcb
EaP6AbIJnZHaHTJ4eRoc+XyKKa0o+SYU4Z1BzpLa6U2B11wk3wda2sgdmNu4YZdB
WZe0LaEMxeVP6PeQ/Z+Q2iWn5MjwStjqrcczwMgzo6ZhEo2EE3A390pP/r6/1vqY
wuQDkqDN9TehQsZ/gjivgCcKohNo0I1JlF1yJVhr0CguznnTcmYy1FLnXfWk5EUf
sv2iDkdizP3AJ6Yzxm24h1wwVNZR0g==
=CzTR
-----END PGP SIGNATURE-----

--lVfmctyWAYy2aNhSj9hceu7wdjkc5y9to--

