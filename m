Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8DAEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:50:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD55B20863
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 08:50:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD55B20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7bqq-0008T3-Ij
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 04:50:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i7bju-0002XM-Rr
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i7bjs-00060R-QW
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 04:43:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33824)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i7bi9-00053l-Ps; Tue, 10 Sep 2019 04:42:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C27A10C093F;
 Tue, 10 Sep 2019 08:41:17 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-117-90.ams2.redhat.com
 [10.36.117.90])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 137FF5D9D6;
 Tue, 10 Sep 2019 08:41:12 +0000 (UTC)
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
References: <20190729213559.20913-1-jsnow@redhat.com>
 <20190729213559.20913-2-jsnow@redhat.com>
 <b7cf5a8e-9199-8405-8a32-470cd5437b9e@redhat.com>
 <2eec15be-b631-0a7c-3bbe-3e47e4d0c06f@redhat.com>
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
Message-ID: <c1818aa9-f0bd-5f42-5ded-1939704474db@redhat.com>
Date: Tue, 10 Sep 2019 10:41:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <2eec15be-b631-0a7c-3bbe-3e47e4d0c06f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="jQJYJu9G6aJuEiWixHUFzsvzBZm54bE8c"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 10 Sep 2019 08:41:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 1/3] iotests: add script_initialize
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
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--jQJYJu9G6aJuEiWixHUFzsvzBZm54bE8c
Content-Type: multipart/mixed; boundary="66T0HA99yT6CalJwYmGRUXZqTJN3by2rd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, ehabkost@redhat.com
Message-ID: <c1818aa9-f0bd-5f42-5ded-1939704474db@redhat.com>
Subject: Re: [PATCH v2 1/3] iotests: add script_initialize
References: <20190729213559.20913-1-jsnow@redhat.com>
 <20190729213559.20913-2-jsnow@redhat.com>
 <b7cf5a8e-9199-8405-8a32-470cd5437b9e@redhat.com>
 <2eec15be-b631-0a7c-3bbe-3e47e4d0c06f@redhat.com>
In-Reply-To: <2eec15be-b631-0a7c-3bbe-3e47e4d0c06f@redhat.com>

--66T0HA99yT6CalJwYmGRUXZqTJN3by2rd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 09.09.19 20:25, John Snow wrote:
>=20
>=20
> On 9/9/19 6:06 AM, Max Reitz wrote:
>> On 29.07.19 23:35, John Snow wrote:
>>> Like script_main, but doesn't require a single point of entry.
>>> Replace all existing initialization sections with this drop-in replac=
ement.
>>>
>>> This brings debug support to all existing script-style iotests.
>>>
>>> Note: supported_oses=3D['linux'] was omitted, as it is a default argu=
ment.
>>> Signed-off-by: John Snow <jsnow@redhat.com>
>>> ---
>>
>> Looks good to me, but I=E2=80=99m afraid I looked at this series too l=
ate (that
>> is, now), so I sent my own version of your 2/3, sorry. :-/
>>
>=20
> You're replying to v2; there was a v3.

Yes, I noticed later, sorry.  Still, my (vpc) series is in Kevin=E2=80=99=
s
branch already, so I then thought to myself =E2=80=9CWell, the comment ab=
out
some rebasing still applies, in a sense=E2=80=9D.

Max

> I'll rebase V3 and re-send, especially if your version of 2/3 already
> hit master.


--66T0HA99yT6CalJwYmGRUXZqTJN3by2rd--

--jQJYJu9G6aJuEiWixHUFzsvzBZm54bE8c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl13YacACgkQ9AfbAGHV
z0D9vAgAwqk0avPdTH2vIADlrcnK8skatwAcs/P+fJODuYU/Hlom5Msuqjr3yMqF
PMNpUEL8O4Vqw0+NIwpEsU1tp/d/KUj40FpSvRsJIJx1t7ANn8O0WgCfeBIDeDQP
7xFYWRB9dhfBrzzCaSLmaA0m07YcBksLb1WofaQJXGJ4LbdX5cQoMdHd3OqY0cP/
L3QJaOxtPGbX7N2uISgNcst6cFb9FjvJ4nOjR7fQB88VfoVTWKBhCcZS7pPM/3d4
LNEzRT+9W7JtK4126SChBnh4zgg3NQnVa8H4i9m5fTS6Web9e1BWbpGIMzTebbKy
4HGkgVwN74BPFyphkoqEn6+NayccHA==
=UT6G
-----END PGP SIGNATURE-----

--jQJYJu9G6aJuEiWixHUFzsvzBZm54bE8c--

