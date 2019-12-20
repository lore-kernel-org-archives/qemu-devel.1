Return-Path: <SRS0=uEni=2K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB9EC43603
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8174D21D7E
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2019 16:40:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FC0p15st"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8174D21D7E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iiLKB-0004ug-Dz
	for qemu-devel@archiver.kernel.org; Fri, 20 Dec 2019 11:40:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32886)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1iiLGg-0001V2-Rt
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:36:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1iiLGf-0004qF-Fa
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:36:46 -0500
Received: from mout.gmx.net ([212.227.17.21]:60899)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1iiLGf-0004o5-1C
 for qemu-devel@nongnu.org; Fri, 20 Dec 2019 11:36:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1576859798;
 bh=UulfeaTG/5XKpOht6kx3Vxa6Juks3wbJUwoM0W+jonw=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=FC0p15stv5aO5Y8wa2icHUB6lXTnAxd1wGYjyA2RS0nKIE7jeG9P508EI2Bhijz4V
 WlSr1+RnAv2jxoEd62y6kgql8JKiJ0uIiOF63bSpI6o20rlxA/6W7amZPju9fmbES2
 ez2qUwpGNK25uPRpMrY48ce2NeYA9T47Thbb53jM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.172.235]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mqb1c-1hvkuM0cXQ-00mbSt; Fri, 20
 Dec 2019 17:36:38 +0100
Subject: Re: [PATCH v4 5/6] hppa: Add emulation of Artist graphics
From: Helge Deller <deller@gmx.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Sven Schnelle <svens@stackframe.org>, Richard Henderson <rth@twiddle.net>
References: <20191103205607.6590-1-svens@stackframe.org>
 <20191103205607.6590-6-svens@stackframe.org>
 <8a34a5a3-eb8f-c600-b17e-f9b448ea0925@linaro.org>
 <e8efe083-eed1-d7e8-8513-b26d2878bfdd@gmx.de>
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
Message-ID: <237c693d-944c-8641-87d9-6bbd52736e5a@gmx.de>
Date: Fri, 20 Dec 2019 17:36:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <e8efe083-eed1-d7e8-8513-b26d2878bfdd@gmx.de>
Content-Type: multipart/mixed; boundary="------------76010FA2B11BDECFEE005E82"
Content-Language: en-US
X-Provags-ID: V03:K1:XT8mrELfPLAG++tTnkJhRjmbtVr0Tmx85WY5Q55HcNtdNlcL3Pg
 XXlQZvnhLTIZUDz2AF8idqtyQmqIwNM1ElU960KenaPUFRqLIPNQ/z4rWXNjw7j0Cn9SMH/
 9e8tmctx41TcmiPxkGlMvnT5UbFnMOhfbyWBMNzmsN7Ksm6a0QPm5ooAjguSCUnmqGhjlwN
 bHrm4l70XjKoRF1HA9jWQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ixKHUAKOAWI=:Mv4seFGXcrSt9lu+kviEIu
 tyJqzNdkGY2fJxu3RBu6u+YJcUxHpM2WdbBkO1w+CuGFr47C9uX6+B8swtKsOVlCi+5s7cdGw
 mQsgo0iaoWy2FWIUBjO/bx3gkN8jCy8DGQUFHBDFEbF9gfqkmR+yYea/FvoROYOx0Gg91zGnD
 Jt/3QmoXfDnV5DXPniE5wAf/6F+DHs5Wi3bTYZ90dWiqomx74J8i1YBqSlv9eXLbwkPW8TS7P
 Bk4EpxCu9lI2WO7O6wPbhni5cy0NTVeSxGrx9PF9V3gBBERHp1CZABXe8ViKVMUc2FC1yus7e
 Xyg92UMoHHtpYeXNPiUnzDotYUB9YutWyQ55DN3iG3J8ngl8Oh5SFhwv9DNpS7IWkw736VI8+
 yoGX+MTNSvp6FcVXeyrZaC9y3LiKi5qiGDrGnhbax06S8xvQT5D/m+7s2SNHvedIPr8ZxCWsO
 a3vzEbt5d8KbZel6gNcb20gy6JNlB6EoAXPMn2I0/HuJLpOMkZSJO3Fu2oiWC2u5G2WmJkBEQ
 +PH/2lWvyrMOARaDI39mNxg8CBgoQAgP8GIiKkjOQg71ohMMK8t5KGsTN9p9qBYh3MdlYWrpY
 A4IU/vdGh7YEdzL84VTaCqdZsqvDhN5B/4rNwvlD33caVoCs0dlnjYCOqGbpKcLrooQ0Hfj2a
 zY241EAFJg9mkp+x2XqpFXuhN5Qj69mGtrtSWp3b2LUkCzZUqKGjFXB8CxSJcSANks3wrKtr/
 sQG8z/X1c+x1i9+HM47TaCmtPfwF2WF/kQUU4pMHOp3HaixNLINU4VHPnAWr8yaS9AbaSiDIk
 CKOvrW2XsFTGNtesivKw77dKbL7nhYL1JA7EDEdKips3YB38NxMEomhywJt40IamU4vHG1nd0
 ZLmhxKEgsRvwQsBtmBYSmbLYhVx4h2yws5gG43HaPzVFeW9mU9U8PGuQTL/ZcMn4gXH45rSZN
 ZHbvV4xEyQxzYSAQ6q3+TdFudR3GhiOeXPKsDv08mbuz40KXf6OqPhPp/CV+QJX6iRViqFq22
 tzK8wZ5rKKLjFwySwy+itX7Xt/5LFzZcFBkgVzF0/HCnaXIP3kOZy97rKP/+vqpb8l2cnZ52T
 7z6343z+Z5Xq+dx7gQKsxe993UPheQW9Cxwtl7//b6EAROJh2tCzE/ENnAFwHRN1QeExwqebW
 tJEEv4dYrR7pp8dNcYh48H3Uy+4m5AAk0GYfmNV1nYkp1G5HazU93Zg8ziN2CbUtnVG6BqI/U
 wMJMd7gaSAAv3nrlXoHhZbMQow+6j3XB6BFxOKA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.21
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is a multi-part message in MIME format.
--------------76010FA2B11BDECFEE005E82
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 20.12.19 08:26, Helge Deller wrote:
> On 19.12.19 01:28, Richard Henderson wrote:
>> On 11/3/19 10:56 AM, Sven Schnelle wrote:
>>> This adds emulation of Artist graphics good enough
>>> to get a Text console on both Linux and HP-UX. The
>>> X11 server from HP-UX also works.
>>>
>>> Signed-off-by: Sven Schnelle <svens@stackframe.org>
>>> ---
>>>  hw/display/Kconfig       |    4 +
>>>  hw/display/Makefile.objs |    1 +
>>>  hw/display/artist.c      | 1449 +++++++++++++++++++++++++++++++++++++=
+
>>>  hw/display/trace-events  |    9 +
>>>  hw/hppa/Kconfig          |    1 +
>>>  hw/hppa/hppa_hardware.h  |    1 +
>>>  hw/hppa/machine.c        |    9 +
>>>  7 files changed, 1474 insertions(+)
>>>  create mode 100644 hw/display/artist.c
>>
>> Seems to have some problems rebased upon master:
>>
>> ...
>
> Richard, the attached patch (for seabios-hppa) fixes it for me.
> Can you test as well?
> It fixes the sti text column to go out-of-range and thus outside the fra=
mebuffer memory.

The attached patch is even better.
It always wraps to the next line (or scrolls the screen if necessary) if
the end of the line has been reached.

Helge

--------------76010FA2B11BDECFEE005E82
Content-Type: text/plain; charset=UTF-8;
 name="p1"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="p1"

ZGlmZiAtLWdpdCBhL3NyYy9wYXJpc2Mvc3RpLmMgYi9zcmMvcGFyaXNjL3N0aS5jCmluZGV4
IDc5MzU3NzAuLjYxZTcwMDIgMTAwNjQ0Ci0tLSBhL3NyYy9wYXJpc2Mvc3RpLmMKKysrIGIv
c3JjL3BhcmlzYy9zdGkuYwpAQCAtMTY4LDUgKzE2OCwxMCBAQCB2b2lkIHN0aV9wdXRjKGNv
bnN0IGNoYXIgYykKICAgICAgICAgfQogICAgICAgICByZXR1cm47CiAgICAgfQorCisgICAg
Lyogd3JhcCB0byBuZXh0IGxpbmUgb3Igc2Nyb2xsIHNjcmVlbiBpZiBFT0wgcmVhY2hlZCAq
LworICAgIGlmIChjb2wgPj0gKChzdGlfZ2xvYl9jZmcub25zY3JlZW5feCAvIGZvbnQtPndp
ZHRoKSAtIDEpKQorCXN0aV9wdXRjKCdcbicpOworCiAgICAgc3RpX3B1dGNoYXIocm9tLCBy
b3csIGNvbCsrLCBjKTsKIH0K
--------------76010FA2B11BDECFEE005E82--

