Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31419C3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:33:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6E022082F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 14:33:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6E022082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0o9p-0006SN-VB
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 10:33:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58602)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mreitz@redhat.com>) id 1i0o8W-0005gn-4L
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:32:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mreitz@redhat.com>) id 1i0o8U-0005Kg-U7
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 10:32:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55128)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mreitz@redhat.com>)
 id 1i0o8S-0005Ik-32; Thu, 22 Aug 2019 10:32:20 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68B1A18C4264;
 Thu, 22 Aug 2019 14:32:19 +0000 (UTC)
Received: from dresden.str.redhat.com (unknown [10.40.205.206])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6D903600CD;
 Thu, 22 Aug 2019 14:32:14 +0000 (UTC)
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
 <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>
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
Message-ID: <c594d9e7-95c2-aba4-11b7-3433f5a74ca5@redhat.com>
Date: Thu, 22 Aug 2019 16:32:13 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GHAaKdM5dRiTKwQxXlNDjeCe7sjDkDpdh"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Thu, 22 Aug 2019 14:32:19 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 02/13] qcrypto-luks: misc refactoring
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
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GHAaKdM5dRiTKwQxXlNDjeCe7sjDkDpdh
Content-Type: multipart/mixed; boundary="IDbmjASx0CarKlxTd2Woupehch5aB5sG2";
 protected-headers="v1"
From: Max Reitz <mreitz@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <c594d9e7-95c2-aba4-11b7-3433f5a74ca5@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/13] qcrypto-luks: misc refactoring
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <4d242249-f823-7465-4b31-64fce484679f@redhat.com>
 <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>
In-Reply-To: <98bce17338318a95b94e053731864ce1caaeab4c.camel@redhat.com>

--IDbmjASx0CarKlxTd2Woupehch5aB5sG2
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.08.19 01:59, Maxim Levitsky wrote:
> On Tue, 2019-08-20 at 19:36 +0200, Max Reitz wrote:
>> On 14.08.19 22:22, Maxim Levitsky wrote:
>>> This is also a preparation for key read/write/erase functions
>>>
>>> * use master key len from the header
>>> * prefer to use crypto params in the QCryptoBlockLUKS
>>>   over passing them as function arguments
>>> * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
>>> * Add comments to various crypto parameters in the QCryptoBlockLUKS
>>>
>>> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
>>> ---
>>>  crypto/block-luks.c | 213 ++++++++++++++++++++++--------------------=
--
>>>  1 file changed, 105 insertions(+), 108 deletions(-)


[...]

>>> @@ -410,21 +430,15 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherAl=
gorithm cipher,
>>>   */
>>>  static int
>>>  qcrypto_block_luks_load_key(QCryptoBlock *block,
>>> -                            QCryptoBlockLUKSKeySlot *slot,
>>> +                            uint slot_idx,
>>
>> Did you use uint on purpose or do you mean a plain =E2=80=9Cunsigned=E2=
=80=9D?
> Well there are just 8 slots, but yea I don't mind to make this an unsig=
ned int.

My point was that =E2=80=9Cuint=E2=80=9D is not a standard C type.

[...]

>>> @@ -930,6 +922,17 @@ qcrypto_block_luks_create(QCryptoBlock *block,
>>>              luks_opts.has_ivgen_hash_alg =3D true;
>>>          }
>>>      }
>>> +
>>> +    luks =3D g_new0(QCryptoBlockLUKS, 1);
>>> +    block->opaque =3D luks;
>>> +
>>> +    luks->cipher_alg =3D luks_opts.cipher_alg;
>>> +    luks->cipher_mode =3D luks_opts.cipher_mode;
>>> +    luks->ivgen_alg =3D luks_opts.ivgen_alg;
>>> +    luks->ivgen_hash_alg =3D luks_opts.ivgen_hash_alg;
>>> +    luks->hash_alg =3D luks_opts.hash_alg;
>>> +
>>> +
>>
>> Why did you pull this up?  Now @luks is leaked in both of the next err=
or
>> paths.
>=20
> This is because the purpose of these fields changed. As Daniel explaine=
d to me
> they were initially added after the fact to serve as a cache of into to=
 present in qemu-img info callback.
> But now I use these everywhere in the code so I won't them to be correc=
t as soon as possible to minimize
> the risk of calling some function that uses these and would read garbag=
e.

I get that, but I was wondering why you pulled the allocation of @luks
up above the next two conditional blocks.  Allocating and initializing
there should have worked just fine.

Max


--IDbmjASx0CarKlxTd2Woupehch5aB5sG2--

--GHAaKdM5dRiTKwQxXlNDjeCe7sjDkDpdh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAl1ep20ACgkQ9AfbAGHV
z0DMHgf/VphuTz01CWZN+BxL6HUf2BCwOft28lNWrjm/GPyXx/g7qWNV6rO5fcqr
Co2caUHpnUTnVqFrmdR7Uxu5rjGkI8a8Zcc1qoMnzJLERpwwZyxhr31sMM7rXRMJ
AOCtQ9f++YVLmADOAS8UfGefLBbllrQmANPJ62lcY33jnRG7q3I4+qsOgDnBYRvl
gECCOpbn/upjdBoUDt8hxX4ZmZH5WhraWgPI/iK22R94R8SEkzfblmEQazrcl98O
0DcXeemLXyqq3liWpiTFqmKsXYO8lXkpZhPau16MToChMCXFNP10ge9oDz6cCpwN
aRU0hbMFPKP8+OhvzQJHqJyhqnQRZQ==
=qsXC
-----END PGP SIGNATURE-----

--GHAaKdM5dRiTKwQxXlNDjeCe7sjDkDpdh--

