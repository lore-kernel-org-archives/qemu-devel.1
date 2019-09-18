Return-Path: <SRS0=w+gu=XN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C44ADC4CEC4
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:14:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FC9C218AF
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Sep 2019 11:14:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FC9C218AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAXv3-0006VX-Ii
	for qemu-devel@archiver.kernel.org; Wed, 18 Sep 2019 07:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iAXtz-0005vX-BY
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:13:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iAXtw-0007iU-R6
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:13:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38750)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iAXtw-0007fa-IV
 for qemu-devel@nongnu.org; Wed, 18 Sep 2019 07:13:36 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 08A10C058CB8
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 11:13:34 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id v13so2212319wrq.23
 for <qemu-devel@nongnu.org>; Wed, 18 Sep 2019 04:13:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to;
 bh=07EB7bW7j0WVCVdJ7PH0kq192efvFfF3Gd08XmEJlJE=;
 b=B6aiRQcGZMVuMeEYhQh7yHQJL4/B3ET+NnFGUCdC164VLI6hA5Ca9ZFQI22P5siwg1
 NveNvsD79t6aXKaBaV6vZZj00wKS/K8vo4A0ZjitcuT3tEc0kSa7pztigcz648B3TD19
 zoSiYRZzKBLf3qVzZsuKHBhL5q3tVg3uUdJ8xFpDO/GVJGtvzHscsaYXZRHODz3J0xTx
 SA4HiUuZc1L1hUmt8+sewwZK3+tkWHS+qOx6mdN+05p8nEzZ1xX5/KKkYV7943hQ3DiK
 40T9Fl3H5DwXXPykd7TW38Ac153ydyDu8nsoTzhZCR8pJNrlEsVsEkblr//XZh9BRJ9R
 zFrw==
X-Gm-Message-State: APjAAAXpKYBUeTUPuN/BD3l0QS1Px27uH2xYi+sz0k6RUNO8/zBG3Sep
 c4MMxlJilTjLS1ar+aw44WyRGYZxr6B8qj+UGJ7Vqcn5OhlMvbfMM+Atz0audPhyVnqZHoy8qsc
 Hfo//v8srET15S2s=
X-Received: by 2002:adf:dbce:: with SMTP id e14mr2782181wrj.56.1568805212802; 
 Wed, 18 Sep 2019 04:13:32 -0700 (PDT)
X-Google-Smtp-Source: APXvYqz2rtRlAKbv6SCzVtFYJ3tUGiGD5TnUBVXn37e5z+pbBrYZgATAA48RYaX4NDeIiOHZw+rkjg==
X-Received: by 2002:adf:dbce:: with SMTP id e14mr2782161wrj.56.1568805212624; 
 Wed, 18 Sep 2019 04:13:32 -0700 (PDT)
Received: from [10.201.33.84] ([195.166.127.210])
 by smtp.gmail.com with ESMTPSA id z142sm4029405wmc.24.2019.09.18.04.13.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Sep 2019 04:13:31 -0700 (PDT)
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com,
 crosa@redhat.com
References: <20190918071654.GK2440@umbus.fritz.box>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <75f4117b-5c87-bd7c-25e9-c7777e51b298@redhat.com>
Date: Wed, 18 Sep 2019 13:13:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190918071654.GK2440@umbus.fritz.box>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="uJEDgD2gCBBGyc3tTMUdU3xmoBprx2y6K"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Problems with MIPS Malta SSH tests in make
 check-acceptance
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--uJEDgD2gCBBGyc3tTMUdU3xmoBprx2y6K
Content-Type: multipart/mixed; boundary="gtGHJQ7nbk0ELoJ45Ar4qunV4qvbaVyEk";
 protected-headers="v1"
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
To: David Gibson <david@gibson.dropbear.id.au>, ehabkost@redhat.com,
 crosa@redhat.com
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Message-ID: <75f4117b-5c87-bd7c-25e9-c7777e51b298@redhat.com>
Subject: Re: Problems with MIPS Malta SSH tests in make check-acceptance
References: <20190918071654.GK2440@umbus.fritz.box>
In-Reply-To: <20190918071654.GK2440@umbus.fritz.box>

--gtGHJQ7nbk0ELoJ45Ar4qunV4qvbaVyEk
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 9/18/19 9:16 AM, David Gibson wrote:
> Hi,
>=20
> I'm finding make check-acceptance is currently useless for me as a
> pre-pull test, because a bunch of the tests are not at all reliable.
> There are a bunch which I'm still investigating, but for now I'm
> looking at the MIPS Malta SSH tests.
>=20
> There seem to be at least two problems here.  First, the test includes
> a download of a pretty big guest disk image.  This can easily exhaust
> the 2m30 timeout on its own.

Gerd raised this issue few months ago:

https://www.mail-archive.com/qemu-devel@nongnu.org/msg615619.html

> Even without the timeout, it makes the test really slow, even on
> repeated runs.  Is there some way we can make the image download part
> of "building" the tests rather than actually running the testsuite, so
> that a) the test themselves go faster and b) we don't include the
> download in the test timeout - obviously the download speed is hugely
> dependent on factors that aren't really related to what we're testing
> here.
>=20
> In the meantime, I tried hacking it by just increasing the timeout to
> 10m.  That got several of the tests working for me, but one still
> failed.  Specifically 'LinuxSSH.test_mips_malta32eb_kernel3_2_0' still
> timed out for me, but now after booting the guest, rather than during
> the image download.  Looking at the avocado log file I'm seeing a
> bunch of soft lockup messages from the guest console, AFAICT.  So it
> looks like we have a real bug here, which I suspect has been
> overlooked precisely because the download problems mean this test
> isn't reliable.
>=20
> Any thoughts on how to improve the situation?

Maybe we should disable this test and run it manually...


--gtGHJQ7nbk0ELoJ45Ar4qunV4qvbaVyEk--

--uJEDgD2gCBBGyc3tTMUdU3xmoBprx2y6K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEicHnj2Ae6GyGdJXLoqP9bt6twN4FAl2CEVoACgkQoqP9bt6t
wN47aQ/9H34XK66Ete0L5rINL4jeiXZW7vuc1muGaoS67H5SY/o5Mn+ehkmiKrzR
YlI3nAqx9MVTQvk4WdXCpfD9cEg7ZYOUn9ZOuXmnoFo61CQfKk8knnXx3CMvJvTS
UZosmZOdMyCtKpG0HzHqfcl8XLhz0HRZ3kzMzQg7ysZfRm5wHVIkFg6IsHYTmMev
NwKcYwW+aFe5Yzkrq3DBWBJ7rFPI4jfkoIkrBG7BXX/62BWfx+rzlNGg+D0mPASD
8Fm/hFVFI4yhpgt4x/EpqizvZv9ZiBLyKmj1WlHIIlTwLYOz79m5nOq+IGkwa8pP
LqyJji/WiXG9fEDlFRiIxgYbxxj7NND7hhSoSJxsoqXCHsdZFmE/GnHVvphvq2VS
DeQK6A1JP843hH/mTCDscgfBivZfbd1bZPeipDNTPpjHr08eYU9Xw4wD8q82aYVT
op3ec7+Teq120VSbAaPyXA8fjFoMqhxTOJMH2kWnZxIfLzO++0i4x3tfzyKFOl49
tVXGaSce5zRY9AyMk/qQinM63jkr+TAEB1tZI4m8qNGsKT9VTNhbNYkRgtvD+ehm
BkPEAQhU6MvEl7Wz5Nksa83UqkJlAhzEcW4QMD8eBqHbSA/Z7ETF204mhXQNYJz1
cew2ZyvqL5Nq3y9BVrYNZe6BTp3BN6y/u6NYz2/J2lPYXmfqBFA=
=UgPo
-----END PGP SIGNATURE-----

--uJEDgD2gCBBGyc3tTMUdU3xmoBprx2y6K--

