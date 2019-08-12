Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB23AC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:09:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88C83206C2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 21:09:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88C83206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxHZb-0004qf-Qt
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 17:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40503)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hxHYw-00046r-Nj
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:09:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hxHYv-0003hN-KT
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 17:09:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44822)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hxHYt-0003e2-2L; Mon, 12 Aug 2019 17:09:03 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3D2733082124;
 Mon, 12 Aug 2019 21:09:02 +0000 (UTC)
Received: from dresden.str.redhat.com (ovpn-204-161.brq.redhat.com
 [10.40.204.161])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 30AFD1001281;
 Mon, 12 Aug 2019 21:09:00 +0000 (UTC)
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
 <20190729110830.GA5757@localhost.localdomain>
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
Message-ID: <3cea1759-3c6d-c78f-dd93-37fde0acd076@redhat.com>
Date: Mon, 12 Aug 2019 23:08:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190729110830.GA5757@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="kowUoJzTmxHJZrswvpAa8Y4SUfbfahtCq"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 12 Aug 2019 21:09:02 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: pkrempa@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, rjones@redhat.com,
 Pino Toscano <ptoscano@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--kowUoJzTmxHJZrswvpAa8Y4SUfbfahtCq
Content-Type: multipart/mixed; boundary="NK109kDGKK6Y5BUzJsjrsLZK9VbK5Up5r";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: Pino Toscano <ptoscano@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, pkrempa@redhat.com, rjones@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Message-ID: <3cea1759-3c6d-c78f-dd93-37fde0acd076@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726140954.31921-3-ptoscano@redhat.com>
 <549f94df-5d31-3dfe-0693-72a2861ddd7f@redhat.com>
 <20190729110830.GA5757@localhost.localdomain>
In-Reply-To: <20190729110830.GA5757@localhost.localdomain>

--NK109kDGKK6Y5BUzJsjrsLZK9VbK5Up5r
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 29.07.19 13:08, Kevin Wolf wrote:
> Am 26.07.2019 um 16:24 hat Eric Blake geschrieben:
>> On 7/26/19 9:09 AM, Pino Toscano wrote:
>>> Add a 'private-key' option which represents the path of a private key=

>>> to use for authentication, and 'private-key-secret' as the name of an=

>>> object with its passphrase.
>>>
>>> Signed-off-by: Pino Toscano <ptoscano@redhat.com>
>>
>>> +++ b/qapi/block-core.json
>>> @@ -3226,6 +3226,11 @@
>>>  # @password-secret:     ID of a QCryptoSecret object providing a pas=
sword
>>>  #                       for authentication (since 4.2)
>>>  #
>>> +# @private-key:         path to the private key (since 4.2)
>>> +#
>>> +# @private-key-secret:  ID of a QCryptoSecret object providing the p=
assphrase
>>> +#                       for 'private-key' (since 4.2)
>>
>> Is password-secret intended to be mutually-exclusive with
>> private-key/private-key-secret?  If so, this should probably utilize a=
n
>> enum for a discriminator
>> { 'enum': 'SshAuth', 'data': ['ssh-agent', 'password', 'private'key'] =
}
>>
>> then update BlockdevOptionsSsh to be a union type with an optional
>> discriminator (defaulting to ssh-agent) for back-compat, where
>> 'auth':'ssh-agent' needs no further fields, 'auth':'password' adds in =
a
>> 'secret' field for use as password, or where 'auth':'private-key' adds=

>> in both 'key-file' and 'secret' for use as the two pieces needed for
>> private key use.
>=20
> Can we actually support optional discriminators when we don't have
> defaults in the QAPI schema yet?

Just chiming in here, because I wanted to throw in that v4 of my =E2=80=9C=
block:
Try to create well-typed json:{} filenames=E2=80=8B=E2=80=9D series adds =
that.

>> On a different topic, how much of this work overlaps with the nbdkit s=
sh
>> plugin? Should we be duplicating efforts with both projects supporting=

>> ssh natively, or is it worth considering getting qemu out of the ssh
>> business and instead connecting to an nbd device provided by nbdkit
>> connecting to ssh?
>=20
> ssh behaves essentially like a filesystem whereas NBD behaves like a
> block device. This is especially relevant for everything related to the=

> file size. As far as I know, using an image format like qcow2 that want=
s
> to grow the image file isn't possible over NBD, whereas I expect it to
> work with the ssh block driver.

Just using sshfs and file-posix would seem simpler to me, by the way.

Max


--NK109kDGKK6Y5BUzJsjrsLZK9VbK5Up5r--

--kowUoJzTmxHJZrswvpAa8Y4SUfbfahtCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1R1WoACgkQ9AfbAGHV
z0A4IAf/b2FJeoGXQeL1a5hcXtUOxRX4EEgK91B3YZILRV07GNDLfHoYduVZxOCJ
NM1P71Yf23wF2vxSImyo9bM4KU5ub/23HXgJHcS7nH2BIRwMFLNvrjrwFYXyzANl
JEI1GAe1gds8nFQ7QN4DgeXYUbba4Rw3hchlSza7mXe2/vHS3rgxmtA4uY6/qLpO
WgmoMI7n+YqqtgGEUone2rQY96vsYsnbY45eUcmX+47H+F4DrkxlsyuvaLS5KUb8
yY38c75FzqBOdpfyYpQvKajSBSrkYZ8kVYdPLC1XcgeDsY4EqxZZdP+aL80TkLDw
NhaUNfT7W3Bd0zh3k/fi/GQ0euQaIw==
=tXio
-----END PGP SIGNATURE-----

--kowUoJzTmxHJZrswvpAa8Y4SUfbfahtCq--

