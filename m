Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46395C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:37:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11FE8206D8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 17:37:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="PQu9S31R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11FE8206D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jz1dF-0002wi-41
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 13:37:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41796)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jz1aR-0001pB-Gb
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:34:23 -0400
Received: from mout.gmx.net ([212.227.15.15]:54757)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1jz1aP-00024W-C9
 for qemu-devel@nongnu.org; Fri, 24 Jul 2020 13:34:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1595612056;
 bh=SuRmNPLf7vxHa6SsPSKGumS3E5Nuhiej7LgwF/yDqkY=;
 h=X-UI-Sender-Class:Subject:To:References:From:Date:In-Reply-To;
 b=PQu9S31RQVUgJTgivHz/iIW14z7GV4kXA5K8vMv2ylleAsr3VITokwSpx6EeYgqCw
 ss+l/UJUYvWQNrBpO7Zf8OMqzxz8TcGwDVFeZRTUuUkPYZNofWHkynwyxnDC8iC04q
 ix4BTQ0O6Bq0SXcWTdZp91AV3EHMGTZcsR5zwhWU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.174.101]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbzuH-1kWQWl1mJz-00dShy; Fri, 24
 Jul 2020 19:34:16 +0200
Subject: Re: roms/seabios-hppa can't be built with gcc-10: -fno-ipa-sra
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
References: <9614340c-8a36-3e2e-40db-61ac9273661e@msgid.tls.msk.ru>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 mQINBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABtBxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+iQJRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2ju5Ag0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAGJAjYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLrgzBF3IbakWCSsGAQQB2kcP
 AQEHQNdEF2C6q5MwiI+3akqcRJWo5mN24V3vb3guRJHo8xbFiQKtBBgBCAAgFiEERUSCKCzZ
 ENvvPSX4Pl89BKeiRgMFAl3IbakCGwIAgQkQPl89BKeiRgN2IAQZFggAHRYhBLzpEj4a0p8H
 wEm73vcStRCiOg9fBQJdyG2pAAoJEPcStRCiOg9fto8A/3cti96iIyCLswnSntdzdYl72SjJ
 HnsUYypLPeKEXwCqAQDB69QCjXHPmQ/340v6jONRMH6eLuGOdIBx8D+oBp8+BGLiD/9qu5H/
 eGe0rrmE5lLFRlnm5QqKKi4gKt2WHMEdGi7fXggOTZbuKJA9+DzPxcf9ShuQMJRQDkgzv/VD
 V1fvOdaIMlM1EjMxIS2fyyI+9KZD7WwFYK3VIOsC7PtjOLYHSr7o7vDHNqTle7JYGEPlxuE6
 hjMU7Ew2Ni4SBio8PILVXE+dL/BELp5JzOcMPnOnVsQtNbllIYvXRyX0qkTD6XM2Jbh+xI9P
 xajC+ojJ/cqPYBEALVfgdh6MbA8rx3EOCYj/n8cZ/xfo+wR/zSQ+m9wIhjxI4XfbNz8oGECm
 xeg1uqcyxfHx+N/pdg5Rvw9g+rtlfmTCj8JhNksNr0NcsNXTkaOy++4Wb9lKDAUcRma7TgMk
 Yq21O5RINec5Jo3xeEUfApVwbueBWCtq4bljeXG93iOWMk4cYqsRVsWsDxsplHQfh5xHk2Zf
 GAUYbm/rX36cdDBbaX2+rgvcHDTx9fOXozugEqFQv9oNg3UnXDWyEeiDLTC/0Gei/Jd/YL1p
 XzCscCr+pggvqX7kI33AQsxo1DT19sNYLU5dJ5Qxz1+zdNkB9kK9CcTVFXMYehKueBkk5MaU
 ou0ZH9LCDjtnOKxPuUWstxTXWzsinSpLDIpkP//4fN6asmPo2cSXMXE0iA5WsWAXcK8uZ4jD
 c2TFWAS8k6RLkk41ZUU8ENX8+qZx/Q==
Message-ID: <b8544039-0934-25ef-138b-ad6da978c154@gmx.de>
Date: Fri, 24 Jul 2020 19:34:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <9614340c-8a36-3e2e-40db-61ac9273661e@msgid.tls.msk.ru>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:18f7REPhXT4oZk6RWtxklWbDNWRM1YB/IlFILSg/wkvnzexpYFN
 uBcti1XonvBVjqrfgfIr61J+c/uT4MLASuoaFDy4JPp33Tl7pZU7Zj9gNP3k5CDLIqKDbye
 mxJ2evdOUXp3q+OjhG5qQkm7Qyc8DrVcxw4m9U27yThCc1SIiYafHfDRN1Caw95Sa1FUiZ0
 7t2NPNujBT5ZfgaPFRbTg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mZ5z64HvLLM=:Z9FwYPWszZEcCiAy5q5hVs
 zdN3zKBfqNIwRNhfSbnfski3gZtVAHoPBs8qiPYkYSSxjky4vOVzWTZ92pff91tp6EIEfeB9h
 r2TRKTcI6AXyHMGzbd3OZIvPKdH4LPp+8Hsz8W7e8ExsCBMvGXB8HrRlyO16Pca7dWUQXgzP0
 xyuRB5c/Y5MKb1/Mz/vZ/VNC443/3rvukDgzQQXcthZN+woH/SNBu6rBm+81ftVNnj6e9GXcP
 MR9eEb6sEHHALEKl3muMOTXu5unP+krxCthsrt0zeRmB0HSaNoDSOvP07SgkiOtMx8EewWzzH
 csm4faPsHDZKCOcgjV6pTp5tkZeUuiMwvFAu22BcAo/1m06eVeIB/IVH9j4Gh5Ln/fGUWEMeX
 nqrYUViF3qtgGIk4c/oClV2zp+a6GY6pTDzRrL0Zcdy/xFjE95Hblh3yphxTQ0Yvk3a6Y7bOd
 mNnEuCqfV9BMyYH9KLHNHZqWja+rYud++64WlKTDAU4OlTq2Vk9V5Xz27iBxa49PxGGW662d9
 ec0rBBiVvF9qwrqMyH2+92jALog+yYFIN0ZED2RgRpFcBZd7uGD6xOJP/Ao+6RscAD8kXSZB4
 qXVGFaM2ghD0r44S9N3zvcN905jhkwOoRnozqdkTogFQF9OU7Z5od1ajCa5o280wpWmSKbjBT
 DXtN4rY+DMJHz3vdYBIpozGPbbK7GuB9XVOzXayLprQ+Upsrv6+OkzBcWx4qeR/Vkc67b2Z2b
 YtWXh1FI3hihLrNFbqQ8QLnPWydTvFDDqm1Bn9MXH4VCqRnRqfmVIPv8Uhx5mlL7mZxT5q46O
 pCccX2WlGx/EkBslwx18vaELqkgbWO2ZB5/pRDgtD6b87bIBfRbBw4rMIjyTHWxA+7CefRUWq
 6GtDmYqttGK9h4cqiQImPTy/jQxnFyoRXf8J3hqkzlOzCmHIUEXD4hy8QQGkjLXxBWJolhkmv
 jzWlTIUnbWzzcHjJSUj1KfIdCGOIN3DTlEAg2KuIhi5MITYuLnKRM5U3BvQCNpc2gdvijrunJ
 3ZEXNHaMTzBCvEDm9GOh+Pbf46/7xBteTR25QUf1mL/xAXXspk6EcwQ0MNqR28UExCzd9art3
 yGoShNslLyWKlzumOVXurzMint9AR3mvrYJSO4/obR6Pg/Ew8LF8q7Jlz/SGNrQqgreTtDZQC
 ThsbWu4s3qjNfQPI8dcQtEStFYlUBcn8IeTz9xEeckmOCZwH4DigA8fxvuFmZi2GMR9duYj28
 eLrv+JCx6UYya5LI1
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 13:34:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 22.07.20 21:11, Michael Tokarev wrote:
> Switching to gcc-10 makes seabios-hppa unbuildable.
> It fails at the final linking step with a lot of
> missing references to memcpy & memcmp all over the
> places.
>
> The notable difference between gcc-10 and previous
> gcc is that ccode32flat.o does _not_ have the text
> for these two functions but have two .isra.0:
>
> $ hppa-linux-gnu-nm ccode32flat.o | grep mem[sc]
> 000003e0 t memcmp
>          U memcpy
> 00002f38 t memcpy.isra.0
>          U memset
> 00003a84 t memset.isra.0
>
>
> while previous version of the compiler did have them:
>
> $ hppa-linux-gnu-nm ccode32flat.o | grep mem[sc]
> 000002fc t memcmp
> 0000370c t memcpy
> 0000036c t memset

I believe this is a compiler bug in gcc-10.
Adding other flags like -fno-builtin or similiar doesn't fix the issue.

> After adding -fno-ipa-sra to the gcc flags, the firmware
> is built successfully.
>
> I don't know what to make out of this. Previous versions
> of gcc apparently accepts -fno-ipa-sra too, for quite some
> time.  So maybe add this to the flags unconditionally?

I think this is currently the best way forward.
Do you want to send a patch, or should I just add this upstream
to seabios-hppa?

Helge

