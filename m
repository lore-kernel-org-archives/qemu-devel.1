Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB41C33C9E
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4938821739
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 11:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="d62ATCKT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4938821739
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57366 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwOrB-00047l-9s
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 06:16:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57751)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iwOne-00029D-NJ
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:12:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iwOnd-0003lF-C9
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:12:54 -0500
Received: from mout.gmx.net ([212.227.17.20]:50523)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iwOnc-0003kf-Uk
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 06:12:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1580209965;
 bh=rZtEy0WJIi1dqXAI6vyT5mr9eeafnElX5YpAJDKbKL4=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=d62ATCKTiEd4GyyUBHYeMCz3WpjX6n9OBl9kF+bqJKnNfg3Iq0OuVbHSdxuZVfx8S
 xMaWbffv2D/xdfmLFOOBnAHniT6gBCPZxAJ5XU27Ob3sy3WcXJA6G/QSkizUKcD+hs
 7lHQ1gmNFfCvcWvDDNODIGTJ6AZCKvlFEMyS8IdM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MbivG-1jZaQl29pW-00dIR1; Tue, 28
 Jan 2020 12:12:45 +0100
To: Sergio Lopez <slp@redhat.com>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200128091007.lh5re4neqhhqmr7x@dritchie>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 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
 4XSbcg==
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
Message-ID: <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
Date: Tue, 28 Jan 2020 12:11:51 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200128091007.lh5re4neqhhqmr7x@dritchie>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="s8dcsEjzijHnZjd6jEQzgIe8sSWhsuXnP"
X-Provags-ID: V03:K1:Ei50foBQjsDNKKnaTZsJYUwBK6XY9zW2DaMDg+FcMnE6CmTss19
 bl4MPjx+isv0RtCWCTNMjGtgsIdXDe+yqSfvRYkbBXZjtj9BMIUJIAwG99XqOXeyiDaoQlv
 FPmW5EIZfpgCrlHFngwE2Gsc+uaUKo3qXOPRfOSIggCb7fDTy1b7RbjBtTRN4lI9SOc3BUr
 wcysEhBKUTNoSUYDhu0+w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:s1yEgbGh45A=:UEqtk5ERTV+29zdErM3pBV
 7Ry0SJuTE5NNPuKtfOxMsKj1+Ryzss7A1NBvTZHKguRnIiYTtd94vmRQkzS8PmhPQDOR+hIB1
 CTtIm4oq0zxHh8hmA7/+bCPSxYg7NQlUgQ3g/cf5djZl5tYwOnXatKb7buA6CrgamJqIyloz+
 WSxs1EOKSU/TM/8zmDtBb7igNZZqwF8xHCceiSY1IV3cVVKA+N85ArX8RkG79OTzlOf9cJeIQ
 2y6DdcbkcTZkx5CVDAWXmsVFkQcwQUBEpwCIkzgAvX93T6eejepuZNWnb2kbAEMTeuKNmh29T
 4JIrG+pfcIfgVE0IIDBJ+GsmRbWC3KYaRQ5GX9WX1vPoyc22CJ9n5R4tdzU9bnPEwtv9cdFDv
 sTtj2G61dMUfq0vrnLSUYhv9UEjDcOB0p9ni3SekBA8wARBcNZIdj56+7RqXS2gKjRz5ccP2d
 HYbHxG+OOx0rDXEcHuRdDt3w5lwSK3Xafp1KBQTUptiGH4Ln+9aTZ/ZXqvekvPb4G3usgfVGv
 UGVwxExlsyqaTNiqW42ED/3hk4fkn/dZYqEiAnrddkFOe27uRWX6g1dGYPr6WrmVmukkTmX7c
 G0TN4IardQONdHZxQf8jYxWPZ86oZbaG7Mqm16YbrfD8OW/I3KzG6b9zLCBks4taNvX+6dmHX
 aYS4Ld9q+NEPn7ewdqWrpsWcikoLNZwLun3oL4oX89gm6Qx9TY+/0qQ36O4Y4HImQqK9blQem
 c+2RRZ60RGxFWe1lxvZjBYhWl/96nLUwhE/bVWVnPsG0rnRAtJQe33mvnTp32uAyuiVnUIA52
 N2+m0IdQXhnD98zvsITJwbLjZg8jqroiz/xzl8IuO9PrmJGF9AI4iwLimi+k38YHKCYFZmS9D
 UbhF9erq4USGzfV1vu6JGwWH+JyfP1pGsKaDbCDpW5DeKQPlHiP7VFy366lg5dCMIKvX7vQLe
 HQijo+Ng2DHtQKOrgcRtv+bkUXRlKGTTv5BcTgmVyCdtU0ebl/A2nSEylJjwAP9ij42BowXWK
 mKLaL63dUd5OF8J1l0a6NBNheQZjMRNBh9u0ao3lLsXRtQ8Avbku15BzFLlAYq/GdweV7dDKb
 dSwNR8tcdVsYRZrL/q3mKXVLg5Jm1Bd2Ca3RiEttkbciaCoYRwrTPNnIWJaAMFi6tzu4cZb1d
 6iagasc55uK1bhHtJMh4sqG5DISJxi/H637mCDWWrA2opM7WknL590Y0rA0PPlHwucq+A=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.20
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
Cc: pbonzini@redhat.com, Maxime Villard <maxv@netbsd.org>,
 qemu-devel@nongnu.org, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8dcsEjzijHnZjd6jEQzgIe8sSWhsuXnP
Content-Type: multipart/mixed; boundary="MuENwN51CuoP4NKTT7O8RZjYloDinu4uK";
 protected-headers="v1"
From: Kamil Rytarowski <n54@gmx.com>
To: Sergio Lopez <slp@redhat.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, peter.maydell@linaro.org,
 Maxime Villard <maxv@netbsd.org>
Message-ID: <d6078248-b6ca-1c9b-16a4-1e9eaccafa53@gmx.com>
Subject: Re: [PATCH 0/4] Implements the NetBSD Virtual Machine Monitor
 accelerator
References: <20200107125401.18126-1-n54@gmx.com>
 <20200128091007.lh5re4neqhhqmr7x@dritchie>
In-Reply-To: <20200128091007.lh5re4neqhhqmr7x@dritchie>

--MuENwN51CuoP4NKTT7O8RZjYloDinu4uK
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 28.01.2020 10:10, Sergio Lopez wrote:
> On Tue, Jan 07, 2020 at 01:53:57PM +0100, Kamil Rytarowski wrote:
>> Hello QEMU Community!
>>
>> Over the past year the NetBSD team has been working hard on a new user=
-mode API
>> for our hypervisor that will be released as part of the upcoming NetBS=
D 9.0.
>> This new API adds user-mode capabilities to create and manage virtual =
machines,
>> configure memory mappings for guest machines, and create and control e=
xecution
>> of virtual processors.
>>
>> With this new API we are now able to bring our hypervisor to the QEMU
>> community! The following patches implement the NetBSD Virtual Machine =
Monitor
>> accelerator (NVMM) for QEMU on NetBSD 9.0 and newer hosts.
>>
>> When compiling QEMU for x86_64 passing the --enable-nvmm flag will com=
pile the
>> accelerator for use. At runtime using the '-accel nvmm' should see a
>> significant performance improvement over emulation, much like when usi=
ng 'hax'
>> on NetBSD.
>>
>> The documentation for this new API is visible at https://man.netbsd.or=
g under
>> the libnvmm(3) and nvmm(4) pages.
>>
>> NVMM was designed and implemented by Maxime Villard.
>>
>> Thank you for your feedback.
>=20
> Thank you for working on this, it's nice to see that QEMU will gain
> HW-assisted acceleration on NetBSD 9.0. A couple things:
>=20

Thank you for the review!

>  - Are you and/or Maxime willing to step up as maintainers for the
>    NVMM support in QEMU?
>=20

NVMM (as of today) is part of the NetBSD support and I am the maintainer
for the NetBSD code (noted in MAINTAINERS).

In case of non-trivial changes I will reach Maxime for his feedback.

>  - In the next version of the patch series, please use
>    "scripts/get_maintainer.pl" to get the list of people you need to
>    CC for the patch series.
>=20

I've submitted a fixup patch '[PATCH v2 2/4] Add the NetBSD Virtual
Machine Monitor accelerator.' instead of the full series.

I have rechecked the maintainers with the patch and I don't see anybody
else as a candidate for review.

I don't maintain a merge queue on my own. Please put the reviewed
patches on a merge queue yourself.


Thank you in advance,

> Thanks,
> Sergio.
>=20



--MuENwN51CuoP4NKTT7O8RZjYloDinu4uK--

--s8dcsEjzijHnZjd6jEQzgIe8sSWhsuXnP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl4wFvcACgkQS7MI6bAu
dmzCkQ//cmn+pbQPpYayPjaz3+P2YJ9IAItHbsJ/2ZMMqgRCzUe3I26Sc0Qt+7rY
ct72qjuQgKfxCCd2TdWMLFnYzQMMZ+gEtyeTnpJYRSMdjKnJ7ciZK9Va5PtzUFRT
83L9HnvyP7DBVQ4mmCgA0Ak5p93t6Hp9yLw9EDKydlNjkOXYKG4RddlPr8w8T/qy
XAznCstHhdkkU/pg6z7mYjScR0GYkNLIXEynW05GJIY+HRkBM3K/yf5OYl69ISYW
bRQhBjm+AhPfYkNYjM0lgMfOXdSzsu/lY/CkUao+MvGsovOSp3K2ValysjfTlbzL
T3a1Lnz6pEy1D14bLfPYRbmELfUPrqTSCea5vQ2Bf7KXClzk8+PF396CoaASuNEu
ZLgUcSXZOUuRB++RhFHNXRlAT9EPI+IyRM0KURlhDk9P4LBuEbXfqG61IdsAjP2J
r7rssizy1/P8beBzWoljZ4kBJdgm+UsKrAu3ZDeck4S4A/WHphDwYCi68zmS7Ve2
VIrnGkC7BtzEquMGWPCRjjT8ijndC3XeeKJKl9gb6rvy53IHLr4P7NFoWL99Wi1c
5gl+AxUAyfj6cbtWZtt2PWhh5O1Qr8Tp9jZKd76JzyAIzp1COx7rZUgs5qp4Bpls
6WeVAN5UtUbS7DFEfAKbI6XJyBRTGZ7nCUmTWFSdT2zGM9uSUy0=
=Uren
-----END PGP SIGNATURE-----

--s8dcsEjzijHnZjd6jEQzgIe8sSWhsuXnP--

