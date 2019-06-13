Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B4B4C31E46
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 00:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FE7220B7C
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 00:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Vd/ji4am"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FE7220B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36258 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbDMU-0004DW-9b
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 20:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46645)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <n54@gmx.com>) id 1hbDLM-0003ke-2u
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:11:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1hbDLG-0000uk-F1
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:11:48 -0400
Received: from mout.gmx.net ([212.227.15.15]:50293)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1hbDLC-0000se-OT
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 20:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1560384652;
 bh=JrxfZH1jgvbR83Hpx9WvOzPcCxou2ai6ak2cqpi6ORk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Vd/ji4amhYRHo8NCgKNjBQij8Tz069iWma/16tIvZu+GbRyP+NSpnf8UeZu2OTsck
 B5CvtbL0XnayxLG9DkPIEKEWhGy/jvD/XG03E1MRt/CpYtQZscGk8JEos1H92tlChr
 +X1AdJFMyCyBzSy80zNFXIIKgMde/fhdyGqd7vVA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx001
 [212.227.17.184]) with ESMTPSA (Nemesis) id 0Lz3nU-1if9rg1Yh6-014GLS; Thu, 13
 Jun 2019 02:10:52 +0200
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston> <87pnniemgo.fsf@zen.linaroharston>
From: Kamil Rytarowski <n54@gmx.com>
Openpgp: preference=signencrypt
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Message-ID: <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
Date: Thu, 13 Jun 2019 02:11:35 +0200
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <87pnniemgo.fsf@zen.linaroharston>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="713sQlIWb9x0TCm8kMAzBZ4V0IljzGIkR"
X-Provags-ID: V03:K1:bnU8wbbH0qVs29FOuYbRz3ILpDsDgw0rDgtKxo3IS+R7Y+yyCHf
 dF2dRWBEef4EwJ+v1Qzjp497PYaZPP8+rKtrw6XR5sFG8s/M+EylwzAkMbl+fhHfjOz/hCY
 TJFDg58kd01MDW/SS7BwTy6h/cJ6l3Ha6zpCSItYQka/jfTV3aAlkG10rFBfy80COcDxG9k
 8LTy5jDtU82p7x74X6lEQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:arZmmOfllo0=:Dbdj6MECprHDLlwck7UtnD
 c3wQ6GwWkRN3wvxhbQ9CCkGHQ3jdJN/ySYbIT1tA9NTpEF5ksB7BFQwEKCipfrVSHtvmX4IKU
 kRyOblf2/KMqO6+di/VrGFxMqAeIVDf2Wd2HmlKaRSviWXJm+b2z4wcFU3Fpuq3o1h6QP7swr
 +zctn4hxuVpDdNv9WbLiTigKze2LRdTVsqaV5NtkzGKmtRtXNG0NIP+s3Raqz17M2xlSek58t
 3JUIgVafsRZozQO74vB3resChUCXnt73YnstwCuPwRr1Tu/LN9Z3Gv7I+OjGsW6T7nN+5G/LE
 J/SoZX0LpdTQtLMjDK2mbvH2Nnnq401irXLAFeQwr/n10VzbtVaLbcnv9ZiwrTFiA1ezNNH7Z
 HEthU1TXOzsXa2A+a/ofr1bH8V8n8rF69mOPuIsjODrbnOPIIACA91vJTFNyL8aT7l7Q9MHrV
 YZUvhr/jno3wedhZTpEIr0Mq5Kfh4Hp4fT9G4weytZLJRj40VNf6PTsBD6StlZWBLxo9jfll/
 QFEaSRMdBFhumuYRMjA84wF6txnytxYam38ozZWOvCbITjbrh4pv503hkUma7aC0bM7xyucgp
 HuYge0eP10iBHdXcUkCB9z9cvy/Ott16sBwarA4VAMGMDQOBI6Zy2Bbb51wXUxZgfiTyAtm6W
 8ezZh/fr/3BSiB0zAbZ1wORSvOoJNyy2kVzglYFXBErPc0h03z/wqQap8/4RcO1p/B90Uf/9p
 6+7gWDuJCifufBlvtdf8P3gLPVZL1VJRKia5rNXXPqOe+L6Q0HrsY4tCd8vBwhSSB46HXV9iT
 xMSVXSQP8ediFf2OJmrFGY1zCNZ/JLW//IBmOYJTSh8RNL8lZOUBIfD9Q4QWA5ESIP+pPtUJz
 QqPW60bHSPPhVgWtCmWzrWBzUe7U7MGoUWSHf65lqLLrJQOBIyhi3JZcVXJ1X8sYjjBk/YSYn
 WXi3KcXMVgAmNwGJWED/z8jtTCg9+/Zk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.15.15
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
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
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--713sQlIWb9x0TCm8kMAzBZ4V0IljzGIkR
Content-Type: multipart/mixed; boundary="91o89b79Nd1kBpNUk3Plo3ntj0O0Z2fyz";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: Fam Zheng <fam@euphon.net>, Ed Maste <emaste@freebsd.org>,
 qemu-devel@nongnu.org, Kamil Rytarowski <kamil@netbsd.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Brad Smith <brad@comstyle.com>
Message-ID: <d32b4c47-4f46-474c-3c4d-54250a29960a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/14] tests/vm: serial console
 autoinstall, misc fixes.
References: <20190520124716.30472-1-kraxel@redhat.com>
 <878suo5ls0.fsf@zen.linaroharston> <87pnniemgo.fsf@zen.linaroharston>
In-Reply-To: <87pnniemgo.fsf@zen.linaroharston>

--91o89b79Nd1kBpNUk3Plo3ntj0O0Z2fyz
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12.06.2019 19:35, Alex Benn=C3=A9e wrote:
>=20
> Alex Benn=C3=A9e <alex.bennee@linaro.org> writes:
>=20
>> Gerd Hoffmann <kraxel@redhat.com> writes:
>>
>>> This patch series changes the way virtual machines for test builds ar=
e
>>> managed.  They are created locally on the developer machine now.  The=

>>> installer is booted on the serial console and the scripts walks throu=
gh
>>> the dialogs to install and configure the guest.
>>>
>>> That takes the download.patchew.org server out of the loop and makes =
it
>>> alot easier to tweak the guest images (adding build dependencies for
>>> example).
>>>
>>> The install scripts take care to apply host proxy settings (from *_pr=
oxy
>>> environment variables) to the guest, so any package downloads will be=

>>> routed through the proxy and can be cached that way.  This also makes=

>>> them work behind strict firewalls.
>>>
>>> There are also a bunch of smaller tweaks for tests/vm to fix issues I=

>>> was struggling with.  See commit messages of individual patches for
>>> details.
>>
>> Queued to testing/next, thanks.
>>
>> One of the machines I'm testing on seems to have problems with getting=

>> the installer working over the serial link but it works on my main dev=

>> box and others have it working as well so I suspect it might be a loca=
l
>> problem.
> <snip>
>=20
> OK I had to drop this series due to persistent problems with the serial=

> link on one of the boxes Peter uses to do his merge testing. Some of it=

> seems to be QEMU specific (Ubuntu 18.04 system qemu just hangs) but I
> suspect there is also an issue with BSDs and our serial emulation
> generally.
>=20
> --
> Alex Benn=C3=A9e
>=20

What version of NetBSD did you test? There was recently a short lived
regression in curses(3) that affected sysinst(8) (installer) in HEAD,
but it was fixed.


--91o89b79Nd1kBpNUk3Plo3ntj0O0Z2fyz--

--713sQlIWb9x0TCm8kMAzBZ4V0IljzGIkR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl0BlLgACgkQS7MI6bAu
dmwXqg//VhTQdJJU6NOD86QbQDBc1PfVqL1CPo7TxJY6HlfC3Si1fjJJoXH7xojT
E65FuJ8WQhbhKUV/uWUEuClVHFzKdVAKVWTlYvNxKUGOBOax6HE13m4F7ymFvPl9
eJbmIGqqUUUgcIpQkW0vTbe8TqoQmwbdSIao6Vr2i3cxWvFLHtU6pW6IOlfkRt9N
IdFm86eNPyvASu+haSPwnyik4FFO8sITwADelIa+oQA9GRw7ymmmV+56sOGd56Pv
XOwbf3Xgp0DVB/aSQYnfnWh2ywqk+cYYX83FYzPL6D+ntyWvayJC8k9Wuq+uIMbX
g7sb9cmOB8mhCLXxirPsWF+zreJvM6B47n1dabfOMFZjX98m9Jmdn/2rUjYPNVc7
xt+4MLUs15m3zZipqzBZtcC2xsW6te4kFk8QrCLEHxgE4SS7RzF4HsBXwEWczajs
+f1ceZFCUS0kllupWKp50D3z4iGlj/0WpzWs61MuBVCZfHw0i5FRMr7UQR7HXL0c
JdJnGoHEvVoOcXcVIm4T1j4YEyuvIoi+NwISr85vlJnRcpEfI1wcSLc09CCTOjLs
u6ExG1icofnf5+rLERBDbc3XpI1nNdXHI3pEN/M37T1JEb3a+1mEDoLXhKwTh2BK
DL1HivkDFX575kC6aYDVs+yFRZM7wGz9PiLyySkDRZVHGcMGX/o=
=ud8G
-----END PGP SIGNATURE-----

--713sQlIWb9x0TCm8kMAzBZ4V0IljzGIkR--

