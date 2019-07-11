Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59926C74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:55:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31DAA21019
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 12:55:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31DAA21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYbm-0005wi-D8
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 08:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60013)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mreitz@redhat.com>) id 1hlYah-0005OS-Ly
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:54:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1hlYag-00008E-Ll
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 08:54:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48434)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1hlYae-0008Vh-1k; Thu, 11 Jul 2019 08:54:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6491308792C;
 Thu, 11 Jul 2019 12:54:22 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.198])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 851F419C69;
 Thu, 11 Jul 2019 12:54:21 +0000 (UTC)
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <20190711092031.GB11930@redhat.com>
 <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
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
Message-ID: <88398739-0fe7-2a8e-f6fd-debf23aaa5d9@redhat.com>
Date: Thu, 11 Jul 2019 14:54:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="05Ioi1yq2DXNcpwmWDcq2sj68ylMu3YRn"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Thu, 11 Jul 2019 12:54:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Maxim Levitsky <mlevitsk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--05Ioi1yq2DXNcpwmWDcq2sj68ylMu3YRn
Content-Type: multipart/mixed; boundary="FTaEXKGXS3wh31n4mQDg0fWIfycbL0bPd";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <88398739-0fe7-2a8e-f6fd-debf23aaa5d9@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] LUKS: support preallocation in qemu-img
References: <20190710170349.1548-1-mlevitsk@redhat.com>
 <84232589-627a-8151-a3d5-84c053d9a257@redhat.com>
 <20190711092031.GB11930@redhat.com>
 <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>
In-Reply-To: <4af9b328-f74b-50db-f130-3ce551239e14@redhat.com>

--FTaEXKGXS3wh31n4mQDg0fWIfycbL0bPd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11.07.19 14:23, Max Reitz wrote:
> On 11.07.19 11:20, Daniel P. Berrang=C3=A9 wrote:
>> On Wed, Jul 10, 2019 at 11:24:46PM +0200, Max Reitz wrote:

[...]

>>> Hm.  I would expect a preallocated image to read 0.  But if you just
>>> pass this through to the protocol layer, it won=E2=80=99t read 0.
>>
>> Yes, it will be zeros at the physical layer, but unintelligble
>> garbage from POV of the virtual disk.
>>
>> I don't think this is really a problem though - this is what you
>> get already if you create a LUKS volume on top of a block device
>> today.
>=20
> Which is why we have BlockDriver.bdrv_has_zero_init(), which the LUKS
> driver does not implement, hence it being treated as false.
>=20
> But if you are preallocating, you have a choice of what you write, and
> why not make that zeroes?
>=20
>> AFAIK, we've not documented that preallocation guarantees future
>> reads will return zeros. Preallocation simply ensures that all
>> required space is allocated upfront. We do mention that it might
>> be achieved by writing zeros to the underlying storage but never
>> said you'll get zeros back.
>=20
> But we have, as I wrote in my second reply.  PreallocMode's
> documentation says that at least =E2=80=9Cfull=E2=80=9D is writing zero=
es, and to say
> those zeroes can be anywhere in the stack is cheating, from my POV.

I should add that I don=E2=80=99t mind changing the current documentation=
 too much:

>> IOW I think its at most a docs problem to more clearly explain
>> that preallocation !=3D guaranteed zeros for reads.

If there is a good reason to do that, sure.  But it needs to be done
explicitly, with an accompanying justification.  I don=E2=80=99t like jus=
t
ignoring the documentation we have.

(And yes, if something says =E2=80=9Cthis writes zeroes=E2=80=9D, I perso=
nally will
always interpret that as =E2=80=9Cit will read as zeroes=E2=80=9D.)

Max


--FTaEXKGXS3wh31n4mQDg0fWIfycbL0bPd--

--05Ioi1yq2DXNcpwmWDcq2sj68ylMu3YRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl0nMXsACgkQ9AfbAGHV
z0BqsQf7BXNGTUBn+adeuK1cNzmTrBbFZ6SDNOcHUMuxuqB3Roon0l81dto4HPRM
Qlkd8pyrCaViHTombbcBGtCCxBs2FLAvX6Kfi/avGYYBSh9R69ulZ6Co55Ljtv9z
r6938FZ6PMjFI957CDG9oBgi/iJoI17O3dAZwdV09RTEsVK0QtZVH9RJ9Zo17JbJ
CJYQ8xuu687R75co0tswWgj2PYI9oEvNQ9fHfoVUgQzq1sFyekoXa4YESR696Y8c
EB4Ei2iaGIgX8/Mv8932zGu82b5DYbB1KGPx9up2n9ktIAUX6bjzLiCkA3zr+ehy
18nCU6ULY+xDCadl7vPvjJSG9PJHUA==
=3RuN
-----END PGP SIGNATURE-----

--05Ioi1yq2DXNcpwmWDcq2sj68ylMu3YRn--

