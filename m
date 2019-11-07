Return-Path: <SRS0=+ldK=Y7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5023C5DF60
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:58:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E96A2178F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2019 17:58:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="F5w5AVki"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6E96A2178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSm34-00017R-3W
	for qemu-devel@archiver.kernel.org; Thu, 07 Nov 2019 12:58:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <n54@gmx.com>) id 1iSlzO-0007gI-BJ
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:54:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <n54@gmx.com>) id 1iSlzN-0001zT-66
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:54:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:53849)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <n54@gmx.com>) id 1iSlzM-0001yF-Rq
 for qemu-devel@nongnu.org; Thu, 07 Nov 2019 12:54:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1573149239;
 bh=hA57pYTEGYRVcSGvsg1AqMfUB51uZ0wboG6eYf9mApw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=F5w5AVkioXxkl/9EGE7QMb6bOsur1/kRAHvMQjhhKj1MhLaeYwDZsbwJVUeWl3dGk
 XVhD24iKMBowFkupCzJWHCM1huMLK6BwwPX/OkpOuJdYOjbhiVXG6h+LeD+QPJUAhO
 ub2Zs8FVRFQzBVJHU9WpU6Fan3vK9NJSwrXOUjYI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.241] ([89.71.135.231]) by mail.gmx.com (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M59GG-1iRg3908rE-001DLw; Thu, 07
 Nov 2019 18:53:59 +0100
Subject: Re: [PATCH v1 0/6] testing/next (netbsd stuff)
To: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20191104173654.30125-1-alex.bennee@linaro.org>
 <CAFEAcA9SOok49C8NS-+kEZyk7EYS10R+RNmhprk2J=KB3bJQFw@mail.gmail.com>
From: Kamil Rytarowski <n54@gmx.com>
Autocrypt: addr=n54@gmx.com; prefer-encrypt=mutual; keydata=
 mQINBFVwUF8BEADHmOg7PFLIcSDdMx5HNDYr8MY2ExGfUTrKwPndbt3peaa5lHsK+UGoPG48
 KiWkhEaMmjaXHFa7XgVpJHhFmNoJXfPgjI/sOKTMCPQ5DEHEHTibC4mta7IBAk+rmnaOF0k8
 bxHfP8Qbls66wvicrAfTRXn/1ReeNc3NP4Sq39PoVHkfQTlnQiD4eAqBdq61B7DhzjhbKAZ4
 RsNtLfB6eOv9qvmblUzs50ChYewM9hvn+c7MdDH+x2UXoSDhkBDkKcJGkX91evos8s9AuoEd
 D32X5e+bmdUGe8Cr3cAZJ8IEXR6F9828/kxzPliMsCWVRx1Fr28baCJOUGgFPNr3ips78m9+
 Iw8PdQ101jU0dvucDFxw/1SCGYEZzV+O/237oRPuLCiDX5nhQoxf6dn9ukQleLBMNy2BLI4H
 g342NhF21HLA+KlyLOHaMKQCKzlal+zVNZTRTCh/ikMhsxWQjBfnqTDbMj85DnWwtump27SI
 qhPjUnS0a6MKoS/A+hbi64k5zztkvloELfCSrX7NyBTT0jgF2IGFIxZMrKCtQ9StcGMCV9MX
 tjcBy6fj7QMontEaIDRJEMjg8UIGw1B687OhalOv1ISia4xOWvpYAM6ipgqh6tBQmFzasL9P
 h1RtcVdFpFbhwVlr1Bly8c25gBNQHL5GUjLMn45LlQz50OzrkwARAQABtCdLYW1pbCBSeXRh
 cm93c2tpIChOZXRCU0QpIDxuNTRAZ214LmNvbT6JAjwEEwEIACYCGyMHCwkIBwMCAQYVCAIJ
 CgsEFgIDAQIeAQIXgAUCVbKGFwIZAQAKCRBLswjpsC52bIVpD/9i8npieI91xMIVvAHIUMeo
 cQO0IrNb+b/PuTj2qNemdwU7dhVJ7tVU5O1H2hI2M4rHGzjzDTxYzdxka0+A8CVEuvFdf6sF
 lXlXF0wM7rC6MoaB0QLAKxkZB5OtCILxLx7Bl2Y4cTPMU9v+qSL6yrdmhxogkufa4d6O9Zl/
 FCWO2kH/BphKOiDtbyvdo2WULSLWP2IXN+0rCpNL4wbTfYLgV9JtMf8f0naGsdy7BFuDWsIE
 vtHh8dkQZP7dz6Qy67kx8negZaehSEgXwiae0HwQIn3xTQrFmBDALDsCgXuLWPTvglSkqTak
 uG+8X5fyTy0cU10TNKsU+rFBO+/xsUoIQOGrARwfWOIfJNPelzh/qigSnyNQNH8u5vFRPg9n
 fqB/AcvvAvtOYOo8EN9Ofx11gNj397NXc5HBQTrX6k5GNAeBWE3Ng1uO6scIwAS7qGnqGezU
 ABmQKLN37gmJiiGwhQAnSE6HILLBC5Z2b0S2rQsPKg8WgUmPa1YIcDkDtNB/LJcDsdU4Fm+r
 U2ksKU7tGD2ZfBt8H2nqfPKKeB+Uv/TBigjRvx/m70vjhqVxwCZA9Fqr9vkQkZroNfqP+3dp
 Z5V5fjmxO5abE2+IikSvFagwMtgx56i8Yrr2BzE8P5/S4cKq1kgyQoF+lVGDKRkUKCv1i4Fo
 aftnSxN8jTFZDbkCDQRVcFBfARAAutbzb8wAHGL5FPPWKErQ3Bsrp9RDTVqRzp7kBMOtd/14
 MrOsWWyiml4XnvBYsJuhZWomFoeulcOXAPoTJ2vTw6erWYtdOiZymfQ3GMWpxzgkOVeNjsFF
 9AQ38FCMKmIDs9dgn+KXSIXlZA34khKLd163SN5U/KHfYlnnocec31u+7rVa1hlF5DBSSpoi
 s8cs41foBYC5NsB/i+yqGIlfzHy7pC2u5kyQCuJotLH4y0rT5X+YBC7z7cqKChtILNDGw0ht
 qps29fwOGBE/FWmu8CbpSHj8pvg7uUyQcKbZbNChBfWtOJKdjnNs5VHf2ec95SwYmWl6Xz66
 G892HY4ODtvl05/kh0qtdJd2oI4gJBsBx/N1585/3JYN4k78GIHTnML3xJydRRs9wwM3AXf/
 iDGrMyY7qHQVXJLdO5nPe7LHg48vryCMkBnTMw5iNFPVCu5w1BaZyHxuS2HvpsgUtQoBa2QE
 P1jYNI+2qgoiIG4VQDhYtrD0WJaYdi/C2UVDxRy07dt73SV3RQ7ijOiUrz4g3/deFKY16/1k
 sE+N5Sc5Tjt84ChjO3nJRbHrQxd6dCOElR70e3R2yAuSB4m7LJpO20IB9CtWhlF/0AtfL91W
 O8GGGqLWB0Z04hmwRs/l8T4WWIlykLshbunWN6jsP1Y27FeilTZ+Pc9mYOEUFfEAEQEAAYkC
 HwQYAQgACQUCVXBQXwIbDAAKCRBLswjpsC52bPayD/9jE8mdNudrudSxbDB2vf8pU8r5flCq
 vIkfOdpZGV/Wx/Zx+HFHHp+b2aNBGSNyFTnph1Ku9bvg06vD0o+b7SdA1vrBgRG41t0OCIyf
 vejz65Xpin2EtCllcBM8zUCxHo43blON8fNw70P1Ec0loBp4TAal1MiXbB8kxRTRcEPVO9YF
 9NPsFxycoWl0ZSvu4ESrQlrjRbVv+W0Fy/XqcQwEtDziFQHQXNRbTy8INPD49CsB7BkKRK+f
 1vMmw7SxfsyEhyCgo9ZWfHb/+w9T5h+UhF87L/m287z7W+s4aCAPBzjbIWhtngGJJwIgiWdI
 I9J6YJLcHLvVZLw7xzA/flcjc0VfzOgJOJw3hBukHnEz7/CKgnABwyNu52P+PQbxVTiTjMKm
 06eV732u9ZLD9ZgEazfmyGDHzsuzoXwsRnmcnbwYYAiynS+vfGl5oMtMa5qzsPhlzuvRlXHm
 zr8VjF8c9RThvyZyyHtWYAqNmBecMvM0whigjMeoAMJ5LtpyZgxjbHj1XnVdNBZgfJkOzsc/
 twffi7RYphRx0d9z5UZ1Yl5Rvl05vTaJ7YhhNC7xuE8yGOQmDUsPDwWqO/eXUDErJjCOBR5b
 0yILqRPYNT0Fj/th9gtEbZy1Gp0TVBkZM3tfjDRu43Pn6iSKObO/j0rNuq1LwN/EMxDifeZO
 4XSbcg==
Message-ID: <c926f927-34d2-3efa-b721-f4036939182e@gmx.com>
Date: Thu, 7 Nov 2019 18:53:18 +0100
User-Agent: Mozilla/5.0 (X11; NetBSD amd64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9SOok49C8NS-+kEZyk7EYS10R+RNmhprk2J=KB3bJQFw@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zJQEOUZKlZWeSc4e3GQn3gZ9ZjpX7yemF"
X-Provags-ID: V03:K1:+tsJCKfyFDK1VLS6RvacH1PqI9NeNtsg+ymozMgKIN8ynQjSm0q
 ez/cje+VjPT4ZSa6lWW/OPNymQatqfNaCUcIeG6VMO+nCTVEF0A1eW3czRkqh9v5GhsyGKe
 StZSVZSauMDRZVLUjF/uXVS7/ol6kUbEfDffKI5QL6rgS4NAyd17BgZaxo+3hkR5APvh6Kc
 14iWBDJ847w6G0hv5LT5Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tDvS3XVXMpk=:QvFqPDO/CKWNVL0YIOb9xQ
 yxBqHRmJ+P282GMxeOEq6G2btm/Gh4itt8GyKpx8CeLVLkP5cOwy8r4lyv66oL/cZ9lhoVM4Q
 Zi94B/L8dk0ls1dkhjZcJ6LJBEpV4EfzxCTcyMdIuyKrvJBezhNyBv3m5p7M1p91DkLZd4x0P
 3FIycGIGTDbMxogq3+Xfa12Dc39iMCoSfuOx0CpbA9tLAEodXlvIsVDSvPAQC/oWK0iIn15EX
 dx5QH0mdb6Si4PVE2m9kfeI7IU5B/m2QOZMR2B4MN26EcN6kwoK+tiC64I0bYfURlwmkimxKT
 lcoldGlUhG9K/nwc7AK/75WF8oVZOnFKjTxM20HWdt0Yq9c56RADOarzjgIua2NPBJTk+m6KA
 ptqfJtewYb+SqaKbYhUEV4F+8t06wbgUGO+Xah3GutswOenYlbPQUwwYobkyYFKqNAPeIMOa9
 K79pikx1cYDy8UbWtNagC7Oqr/uvHrMniUOvkIF8nuWPyrIDqb2fXnGkIEdC/E+lnrEHrk9f/
 zMglh4JehTBwtVLOB2dXTywMOqmAPVt7JT2ZQORUMrTTRImJ+pTKNuA7P3Ty7+wChKh51kMGh
 yg6KF5jmKQKt7bF/w6o+eenBOmuwoPMz0klD38ACzRNQ6sYXusvY4vxCyrXOKZ6Y3TxCW4vtr
 kezfET4YwKfFXG1SECoH0W4TCQbGJwvjuxIPUjJ5JOYNuzKPXucuNOzynkLD+HMTdM4v9Re2g
 U8yjEV0IVRHanlavaM1+CxXggaNA7FWoB3mYg96YMlBp23amLXgo9UoS74Qw2e2DXeJj9LHs/
 D68Z2JnFc+/9w3idFKTpZNYvkfOiUOh4jq3MJG6kKUqC5bqS74yowrP1EiCj+QYzfKaZINs4V
 vqJOB0jPp2mXNR+miOTenyN5zvdby6KLBXPrCav9QzOU+G7KpElkoRQdc1WLUEizJQgnedFY+
 F5A9ggYtLJG6xtb6Ur/Xe34JN1k6ui6DIlNpeYvw8FervIlNUQY5pwnXwQ4U2n3OZLS/07hCO
 zWv/jKaavoVAP3DdOckpNqaSpMfqxD3IogxBrkFR1RTPwTuBPbosZWMPXqEPwzsstZCi6WeOR
 hhuoxAHP7jwC+RQyXdBx/BqrPeWJqMNEy+4Hwq6BXkVJvpTPmMy6NoUHMnX9VaUjWhDHTi9qg
 GQKpxh9llNDsgrxiqXGNITfCflQZ/nwUiLFwbAe5qdz2xuqD1uaeJe3Z5XXWC/eaNsivYnYnq
 xvxSDmdR8ubN/3JOrUcSQdNm0uBUxbS5GEVAZqw==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.22
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
Cc: Fam Zheng <fam@euphon.net>, "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>,
 "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zJQEOUZKlZWeSc4e3GQn3gZ9ZjpX7yemF
Content-Type: multipart/mixed; boundary="cbn6E0opu38ebogCjsPSVu827uv6wOYCf"

--cbn6E0opu38ebogCjsPSVu827uv6wOYCf
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 07.11.2019 18:46, Peter Maydell wrote:
> On Mon, 4 Nov 2019 at 17:39, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
>>
>> Hi,
>>
>> As we approach hard-freeze I'm trying to temper what comes in through
>> the testing/next tree. However it would be nice to get the NetBSD upto=

>> speed with the other NetBSDs. Although the serial install is working
>> well for me this has had a rocky road so if others could also give it
>> a good testing that would be great. I've also disabled one of the
>> regular failing tests for non-Linux targets. There are other tests
>> that still fail however including the tests/test-aio-multithread which=

>> asserts in the async utils around about 20% of the time:
>>
>>   assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
>>     "/home/qemu/qemu-test.nS1czd/src/util/async.c", line 279, function=

>>     "aio_ctx_finalize"
>=20
> This is unrelated to your NetBSD update in this series -- it's
> one of the persistent intermittents I see on the BSDs:
> https://lore.kernel.org/qemu-devel/20190916153312.GD25552@stefanha-x1.l=
ocaldomain/t/
>=20
> (though the failure rate I see is I think <20%, but I haven't
> really carefully measured it.)
>=20
> thanks
> -- PMM
>=20

Does this patch rely on AIO API in the kernel? If so than this is
unreliable as of today on NetBSD. We plan to fix it, but there is no
expected time of accomplishment.


--cbn6E0opu38ebogCjsPSVu827uv6wOYCf--

--zJQEOUZKlZWeSc4e3GQn3gZ9ZjpX7yemF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAl3EWg4ACgkQS7MI6bAu
dmy1pQ/9GCpwYa9EiVBj7YEYgR0LbLKq3zJjOU2u4SMVBw/RxPlYtIOIriF/Ae4E
J7bWtIRmZhpCJTnoV4BW6eT5zH1dcyDBq5Cn6LjYMTdVk/zDumsFIXuxlRYR4TiT
VU0U5fHjoWVAYoV3/JVPDe99taq6KIqT+kcxE88n0U6uFrI1f6adq0jYBYJ/ONqt
LV6O7wSioK0+qMtF3QMeZi9mIGdP7fVP+mCwcUA6pwJZjDCuSztyt7YMZ0lSXRpR
7Pf8rUZCZq/3w5kogFjq1FitEOk75Jjr3bYXL8lzW2V6T2a7rOcZyL17KZ1HLMsm
9K7gfz8gQAP6X9wIQz3KcwtpXvHGJxLtHUjgtP7J13pjDEPGDJkAegZWPXvoBuvY
GP+KhlKfeA+Xj9Q6LMECRQ4KsNizO1ZJcomXSiA7NuspFURIyImcAWqGfXsF/EEJ
FEWZL1aa+BUfwcX+BfC9QzeOzLKRcJaSpjW3DcDr7hPjN7W27u02WI2Inu0yazDe
0iJEKYtXqDFQQ916BAkDO8nltdBWVumJM4CZvsKQFMpz0CSIgWRfZcG7kbiNNvpu
AFfjhgfNwmYFTWHU+AWDuEOjb21VmeAiVIW/uOB+3eBuK6DP4YL8bCbWkeHDo4vL
ZlVIL7NiVaL8PLme+AhLAhvnNh7DpeiVYWbTAKj59j/zMoMgyZw=
=apwt
-----END PGP SIGNATURE-----

--zJQEOUZKlZWeSc4e3GQn3gZ9ZjpX7yemF--

