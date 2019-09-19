Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B48F5C49ED7
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:27:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DEB821907
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:27:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DEB821907
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtfG-0001YD-NZ
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iAtSK-0004mL-RD
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:14:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iAtSJ-0003wH-LF
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:14:32 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:34327)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iAtSJ-0003ux-Ap; Thu, 19 Sep 2019 06:14:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MDhpZ-1iK00b2YB5-00Ajxt; Thu, 19 Sep 2019 12:14:26 +0200
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20190912184607.3507-1-eblake@redhat.com>
 <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <bd495385-af3b-d462-645d-1ef135925128@vivier.eu>
Date: Thu, 19 Sep 2019 12:14:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fRBE7v7YkaceEjaWdcL9gwcbO2VKZVJBD"
X-Provags-ID: V03:K1:aZvWtRfTtWjVnu5sUzgqpy0+HY4+AtSFt9WlkCsq0dynNfDR0PX
 6tUyrVHapy5R6fSCJYqVJjXa+53s4Kr4gM+VYmApuqeF87vD+7gm+jLOQNCmfveRrBqPyMS
 LooQhhlGjfatyMcWbR5vqpLOCp3bId2KrIXWZ1Jx3Y3wQCfskY0rReRa5AVyxYVS+NcJgtj
 sXn56wDsusrqTPxf248LQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:fIqW/NpUdX4=:tVUQBc4kZLFio+5wRRxobv
 5rFpZcVCKy1XBvFRzFiL7IbHEXmcDxdFl9D6NcZaTFWoZJQx9rU+clsXZpU6XPY1YXgtLnZu2
 pmsmQ6p1uZX4pX0csj+G3C8jkUZQLmomaTyqld1pDCNf/39GF75xLgRWwuZK0u4aelAnjlRBc
 AaLL1CQ3n+/UwE75k8C9VnrZLbaA/wK4Eh7owv26Bb3mxLtfcHeUp3kl6VvC+0WXaU4L57mly
 QRKVO0/B29nsFo+97xq++PSwca8eRAnHEKphJXN/HoVsCly6q8pfjYadlfpTN0hn1fbTIyMY/
 1fyqjE2Uye2CkgKuW1FW4fY/9uozYrUnpnBkr/NMtKVGksoi3/UZtf6pMQq1wISoQHLvmOHpm
 d/tB/PEXqbV60yypJ8ZCATi4QYXjsPPFKdx4D0X6edzMqnxyHQdaeyUvP9mobPedAAyr+aHgs
 wc2HirOCLHCjgInOT0mZDJmQKQXhqwHu+Q4GByciHt/qIBVMNOzBvY8TKI/Z7SGosyapJmWvT
 yPmzk2mJBLAQ4DLOkX3W8u/fwjnBSayPu7GGCvEP2Y1T4NBGJD+BdigHTQn+NZsS/cpTPRlW/
 3M4E7EFLburkc8h+/Pk2rmbTyGyz6jSXps/56mgN+7fJy8eGcvruLLG+dE1K4I7Hz4wCCFaSK
 mnEVIaV8iaQS7qQGN8lcV3Hb8NmiKwuQHH6Hswu+tHEhP+cghGilJB8CZnyhJ8USZygf9lGVu
 iSMaZZeJ46Nd03mdFOGwGzjoCabiRYgJdi5UCQUXkVE9YaZJFd9jKupFzV1UH2BN3i/w7KiQS
 QtRFT7B14k9Pj9SILRPbr34Izp9rzF59Bgt7Nyppt7PIx3RA8fHTyVswUnQJWxXmDoWPMZ8WY
 1xMALR7oj2kneE/dEHAw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.75
Subject: Re: [Qemu-devel] [PATCH] build: Don't ignore qapi-visit-core.c
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fRBE7v7YkaceEjaWdcL9gwcbO2VKZVJBD
Content-Type: multipart/mixed; boundary="paEE7yzaQE536hNXbUeQZkQrJUsN17Upf";
 protected-headers="v1"
From: Laurent Vivier <laurent@vivier.eu>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
 Thomas Huth <thuth@redhat.com>
Message-ID: <bd495385-af3b-d462-645d-1ef135925128@vivier.eu>
Subject: Re: [Qemu-devel] [PATCH] build: Don't ignore qapi-visit-core.c
References: <20190912184607.3507-1-eblake@redhat.com>
 <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>
In-Reply-To: <f604ebfe-0157-81df-a948-18bf9589d880@redhat.com>

--paEE7yzaQE536hNXbUeQZkQrJUsN17Upf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Le 13/09/2019 =C3=A0 13:34, Eric Blake a =C3=A9crit=C2=A0:
> cc: qemu-trivial
>=20
> On 9/12/19 1:46 PM, Eric Blake wrote:
>> This file is version-controlled, and not generated from a .json file.
>>
>> Fixes: bf582c3461b
>> Reported-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>  .gitignore | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/.gitignore b/.gitignore
>> index e9bbc006d39e..7de868d1eab4 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -41,6 +41,7 @@
>>  /qapi/qapi-types-*.[ch]
>>  /qapi/qapi-types.[ch]
>>  /qapi/qapi-visit-*.[ch]
>> +!/qapi/qapi-visit-core.c
>>  /qapi/qapi-visit.[ch]
>>  /qapi/qapi-doc.texi
>>  /qemu-doc.html
>>
>=20

Applied to my trivial-patches branch.

Thanks,
Laurent



--paEE7yzaQE536hNXbUeQZkQrJUsN17Upf--

--fRBE7v7YkaceEjaWdcL9gwcbO2VKZVJBD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEzS913cjjpNwuT1Fz8ww4vT8vvjwFAl2DVQAACgkQ8ww4vT8v
vjwi2BAAnfyF2IdCjtu458veAZg+E446Fi9TvC+rMtQ5PiP6wygt4LWr7FQjrNcm
FMhdTwR3gLzOsBJkJDCxpRpT/mtuDEczSdZ/T0Fpp5dTK+kSRBkqdve4qIlaUy2e
7c7MK5n0LCC/QdKpKy2a81s9ghd4/+Z0TCu+853mWl5s2EokXsjIMZzp/SG2LGHQ
9pjAQFXykgwPuJ5EALMH5qht73yi0dwW3tLZRhJTy+kN4Hy3VNGJkcIEXDqUoiOH
HaAJkarHcPmIlEZPwUcrM10nj6YlGxApXeZDeFIvI2Zd5APgRiCjKUsWk+NoajDA
FcZqrL43T3/biTCUd/ivZ4EE5rWdb8s7+QtDrspqeNo6SKlsYtjJ2Ht7p0dR63Ao
Vbsm3Nf0nIhVjsTYxvpNVwVYsITJRLuTG1xsy9G8fEL97zWR/vVjv7t6f/y3ohqB
4P103arU3lwYiNexbW+Eaa0EvUIemhu+d52ToTizwyo7KYCenaYiZ+Nusb8HNFm/
Tc9ZlVUvk8HjzTYYQUvhxaPCOUyQ9f65+Kbdu3ZVfq769kAHdEQw93eKASPRPTLP
NEsVev+rcyxguyLT9TlNQbyWEV/uWuzGhfmT7uAzaBJMRbGF7N+ybUzgulCQ39LK
wjhY5Ve74MqGUrYmP/JVSd7C+VUPKEtLfUf1tTgKBf0RZKIQE2c=
=onK6
-----END PGP SIGNATURE-----

--fRBE7v7YkaceEjaWdcL9gwcbO2VKZVJBD--

