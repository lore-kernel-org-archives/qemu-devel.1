Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24031C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:25:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C39E62082F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 16:25:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C39E62082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55008 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiLbB-00025A-Vf
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 12:25:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35705)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hiKiT-00046p-1R
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:29:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hiKiR-0007ut-T3
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 11:29:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39352)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hiKiP-0007qp-AC; Tue, 02 Jul 2019 11:29:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 945B3A96F1;
 Tue,  2 Jul 2019 15:29:00 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-120.brq.redhat.com
 [10.40.204.120])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 297E72E043;
 Tue,  2 Jul 2019 15:28:39 +0000 (UTC)
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-2-mreitz@redhat.com>
 <w51v9wk5ybk.fsf@maestria.local.igalia.com>
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
Message-ID: <07be76c5-fea9-96b7-e50b-eddc04a38e42@redhat.com>
Date: Tue, 2 Jul 2019 17:28:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <w51v9wk5ybk.fsf@maestria.local.igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="SiKOJDYftHuyiaw2HU36MQDLkGiujRTDf"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Tue, 02 Jul 2019 15:29:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/5] block: Add BDS.never_freeze
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--SiKOJDYftHuyiaw2HU36MQDLkGiujRTDf
Content-Type: multipart/mixed; boundary="8hBmlz7ywDQEFoWWzKPzczD5o8rcEYv2d";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Andrey Shinkevich
 <andrey.shinkevich@virtuozzo.com>, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <07be76c5-fea9-96b7-e50b-eddc04a38e42@redhat.com>
Subject: Re: [PATCH 1/5] block: Add BDS.never_freeze
References: <20190627223255.3789-1-mreitz@redhat.com>
 <20190627223255.3789-2-mreitz@redhat.com>
 <w51v9wk5ybk.fsf@maestria.local.igalia.com>
In-Reply-To: <w51v9wk5ybk.fsf@maestria.local.igalia.com>

--8hBmlz7ywDQEFoWWzKPzczD5o8rcEYv2d
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 02.07.19 16:02, Alberto Garcia wrote:
> On Fri 28 Jun 2019 12:32:51 AM CEST, Max Reitz wrote:
>> @@ -4416,6 +4416,14 @@ int bdrv_freeze_backing_chain(BlockDriverState =
*bs, BlockDriverState *base,
>>          return -EPERM;
>>      }
>> =20
>> +    for (i =3D bs; i !=3D base; i =3D backing_bs(i)) {
>> +        if (i->backing && backing_bs(i)->never_freeze) {
>> +            error_setg(errp, "Cannot freeze '%s' link to '%s'",
>> +                       i->backing->name, backing_bs(i)->node_name);
>> +            return -EPERM;
>> +        }
>> +    }
>=20
> How about adding this to bdrv_is_backing_chain_frozen() instead?

But that=E2=80=99s the wrong place.  For example, that function is called=
 by
bdrv_set_backing_hd() to check whether the backing BDS can be changed.
But the point of never_freeze is to ensure that links to the BDS can be
changed.

never_freeze only becomes relevant when trying to freeze the backing
chain, in that it should prevent it.  So I think putting the check here
is correct.

Max


--8hBmlz7ywDQEFoWWzKPzczD5o8rcEYv2d--

--SiKOJDYftHuyiaw2HU36MQDLkGiujRTDf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0beCYACgkQ9AfbAGHV
z0Du3Af/XG1iUmRdIDRs9OpDSfVfg7ow8iMyMwDrkMcxEjKwPpJhjExgMhh419gW
ur0tL4wgnPvrKj8JlZm/8z8PsEFP3edXESWSGpYXGTGeNbn1WhhyKrAeCQTRbVP5
wLq7p5wjX4eLJyShDbmZQ3nma7daboaMtvAy3Y9aUk6o+xvOwdIjIlgn7YLPPTmt
/xwDX+vXO3Gsa+xlV5M0/fPqk6ffJjGcBJlRz4jfndg3BvTKxYK7DCu9qcxHAYDb
QXuuc6q00fH7OBNF2cB2LOSSgmNhhtp2xsjUC7KAc4FsswG/y2EzIURDKQR9uVJv
KP0WQa265d1DhJrTzFM3SqVDNVW9ww==
=AW1P
-----END PGP SIGNATURE-----

--SiKOJDYftHuyiaw2HU36MQDLkGiujRTDf--

