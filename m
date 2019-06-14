Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85BFBC31E44
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:57:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB8D20449
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 05:57:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB8D20449
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48602 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbfDN-0001uy-5Q
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 01:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47035)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hbfBv-0001CF-2B
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hbfBs-00075M-W0
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:55:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40606)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hbfBs-00073u-MP
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 01:55:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id p11so1123080wre.7
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 22:55:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=NGxJcQkiZI4Z5IeOaXrU830KSQEASsfugNW424I6zCk=;
 b=ezUeMrD4b/ub8RzSKMZGrP9DmgCmcJ2Zp5a3riTcjo12NhVpn+QyZTGGIIJYyEfsrr
 nisnF/yYc2esDa76IQk4IwZUjfajXhCqLgNkMbKTY6o9pK6g/idebeGMq1I5mlZQeOW9
 tsRVUWoozJjmm89a1elGE4f7YAtoka8Wt21eH86QEfslIMrCtb13WBU2DdYAeUURM9Jt
 1FtqhT3luT1bSasyp1DlefD7pdMjRTDsZxDqZgle5rCiXiNrharTue9VGLDJZcf8GzW5
 f6AsnxgGZ0i9ab2t/uXJiH1xDGUXhaoIhaPZI9F0VS7AJDzOn2aislUUfKu/fOKyZDCN
 h8Og==
X-Gm-Message-State: APjAAAWAaRrWXDZENJR2OiQfAh9lruW/4n8zw1ZVGWb5d+g7MYPbQDKz
 7LCeG/tRDgGYI4REkfu2Rls8Pw==
X-Google-Smtp-Source: APXvYqwmGuJPocPkk0hNMfiWWoITi4YPwbdAG/HzP64YEI7wKcTzEJUPuyUW16t0F28oRqiyreAFsQ==
X-Received: by 2002:adf:efcb:: with SMTP id i11mr12471670wrp.188.1560491755441; 
 Thu, 13 Jun 2019 22:55:55 -0700 (PDT)
Received: from [192.168.1.103] (183.red-88-21-202.staticip.rima-tde.net.
 [88.21.202.183])
 by smtp.gmail.com with ESMTPSA id g2sm1982138wmh.0.2019.06.13.22.55.54
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 22:55:54 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
 <20190613060728.26955-3-david@gibson.dropbear.id.au>
 <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
 <20190614014056.GD11158@umbus.fritz.box>
 <20190614015329.GE11158@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <b1f9e994-debe-8de0-d032-9be4400d2cdd@redhat.com>
Date: Fri, 14 Jun 2019 07:55:53 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614015329.GE11158@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="a01eVNLudI7nrNbPdF3ZHvb6rKbkav6ag"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host
 arch correctly
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
Cc: arikalo@wavecomp.com, ehabkost@redhat.com, qemu-devel@nongnu.org,
 aurelien@aurel32.net, crosa@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--a01eVNLudI7nrNbPdF3ZHvb6rKbkav6ag
Content-Type: multipart/mixed; boundary="iv5YfjfJP7w3cSGWnzeRgwJmu3gynB8Eo";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: crosa@redhat.com, qemu-devel@nongnu.org, arikalo@wavecomp.com,
 aurelien@aurel32.net, ehabkost@redhat.com
Message-ID: <b1f9e994-debe-8de0-d032-9be4400d2cdd@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/3] tests/acceptance: Handle ppc64le host
 arch correctly
References: <20190613060728.26955-1-david@gibson.dropbear.id.au>
 <20190613060728.26955-3-david@gibson.dropbear.id.au>
 <617a8179-7dcc-7c51-1239-6e4893090d43@redhat.com>
 <20190614014056.GD11158@umbus.fritz.box>
 <20190614015329.GE11158@umbus.fritz.box>
In-Reply-To: <20190614015329.GE11158@umbus.fritz.box>

--iv5YfjfJP7w3cSGWnzeRgwJmu3gynB8Eo
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 6/14/19 3:53 AM, David Gibson wrote:
> On Fri, Jun 14, 2019 at 11:40:56AM +1000, David Gibson wrote:
>> On Thu, Jun 13, 2019 at 11:01:19AM +0200, Philippe Mathieu-Daud=E9 wro=
te:
>>> On 6/13/19 8:07 AM, David Gibson wrote:
>>>> ppc64 and ppc64le are different archs from the host kernel point of =
view
>>>> and are advertised as such in uname.  But these cover the same set o=
f CPUs,
>>>> just in different endianness modes.  qemu-system-ppc64 handles both =
modes,
>>>> so make sure we select the correct binary when running on ppc64le ho=
st
>>>> architecture.
>>>>
>>>> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
>>>> ---
>>>>  tests/acceptance/avocado_qemu/__init__.py | 2 ++
>>>>  1 file changed, 2 insertions(+)
>>>>
>>>> diff --git a/tests/acceptance/avocado_qemu/__init__.py b/tests/accep=
tance/avocado_qemu/__init__.py
>>>> index 2b236a1cf0..0ba9c536f4 100644
>>>> --- a/tests/acceptance/avocado_qemu/__init__.py
>>>> +++ b/tests/acceptance/avocado_qemu/__init__.py
>>>> @@ -39,6 +39,8 @@ def pick_default_qemu_bin(arch=3DNone):
>>>>      """
>>>>      if arch is None:
>>>>          arch =3D os.uname()[4]
>>>> +        if arch =3D=3D 'ppc64le':
>>>> +            arch =3D 'ppc64'
>>>
>>> I prefer the generic patch from Cleber:
>>> https://lists.gnu.org/archive/html/qemu-devel/2018-10/msg03418.html
>>> (I guess remember another version with a json file)
>>
>> I hadn't seen that, that does indeed look better.
>=20
> Hrm.  Well, it is better but it's been outstanding for like 8 months.
> I'd just like to get this working on a ppc host in the near future.

True :S I wanted you to know Cleber was working on this, but I don't
have any problem to get your fix merged and Cleber work added on top of
it, so:
Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>



--iv5YfjfJP7w3cSGWnzeRgwJmu3gynB8Eo--

--a01eVNLudI7nrNbPdF3ZHvb6rKbkav6ag
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl0DNukACgkQoqP9bt6t
wN6UBA/+M7ORP03Hz5uRQGcw1xNWCL6mnbWwvIilSF+SGdBs92/MttQa5+85Y2Zd
o1GgSZ7gumgriDwoOVAu3mMkjQCsNPMLetzohWRa95hfh/laQQPuiaxtfs4Xw45b
uNnH/523cZ4bngk+4a+sCRI1PLL8TfS4nuEh6BH4DJ7evCF2CJ+yMdPoaeTvtMyv
3L2+n0C97RO+6nC8Lo8AolZKqyqqCJ3zMh+FreBSdOmf2OtMFDIXpybZ4q0tZDz3
eJcyrvDtCZzWckA1BVzINzAjvz0PAP5aHlXw5lm1plJEoUxT1udmgv4yk6f+rqRs
+1BBmcVgrIBiCnxcNJn8baZa2nY0Pa81oRsEddeuf820YY4iy0F6gt6GKDZjVvQh
5RwmkC9uPX9jB7ucdtKplZBb05VhHFVmKn7xcu95MdmJWyXx9hrvdUVAKpAMjsDi
6C4fdiyhD6uGbophB9AbpTxdBVegQwNI4J69HDD7bEGygEQlaDdWjz5KaMjxr50q
yviQVqD4P2j2G+tFQcpZcMeZQAVLyzjX7VO/KZATy5VoHOYqKZpgabXkPhWpd1i0
ZwAWWW71+igqcdJ55MEoR773LhX4P3F3RQPJQ8n+XinsT732PEo3o5M93RA5ut0i
a7FwTkooBcznpmgITTdmIwCvNgjLGYTVs8BPvdwrSVXS+4oZgxk=
=Mr8p
-----END PGP SIGNATURE-----

--a01eVNLudI7nrNbPdF3ZHvb6rKbkav6ag--

