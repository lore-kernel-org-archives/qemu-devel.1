Return-Path: <SRS0=Q/S9=2X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB31C2D0C2
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:26:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 470BF20866
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2020 20:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="OshAv3Pw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 470BF20866
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1in735-0002Kf-4a
	for qemu-devel@archiver.kernel.org; Thu, 02 Jan 2020 15:26:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57223)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <deller@gmx.de>) id 1in6z6-0001O3-Ql
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:22:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <deller@gmx.de>) id 1in6z5-000097-Bl
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:22:20 -0500
Received: from mout.gmx.net ([212.227.15.18]:33335)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <deller@gmx.de>) id 1in6z5-00006K-1y
 for qemu-devel@nongnu.org; Thu, 02 Jan 2020 15:22:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1577996533;
 bh=T+JeQqdnB2RuMtWhGmk4nXTWNBLpesKJ5UD07VvHDy4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=OshAv3PwXro2aYg+pZ2KGdtaeguZxw6nOJ7HHPRlgOE44WcfksGZV+ZoiKu4muZqE
 V8T1s0cH2YpHf3d6Y7j4+ZGlI4MUGqbkUlSwNMBtR0MZ1oY0V8T6MknrR9+2Sg8G3m
 hZVQZTWA1J5CezOeQ4yXQU5oTstVKsarIMpq0H94=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.20.60] ([92.116.183.77]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MFsUv-1iwlkQ1L83-00HPWK; Thu, 02
 Jan 2020 21:22:13 +0100
Subject: Re: [PATCH v2] hppa: allow max ram size upto 4Gb
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <27c3e31d-82ae-e62f-caba-a0a3fbd55e7c@redhat.com>
 <1577987162-150529-1-git-send-email-imammedo@redhat.com>
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
Message-ID: <2f226aa4-5f61-6e6d-d6b9-a98685a79e8c@gmx.de>
Date: Thu, 2 Jan 2020 21:22:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <1577987162-150529-1-git-send-email-imammedo@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OvlBDMr0YBImvfihtYHNc78ei/oBUFqIvlEHbBg+37p/whFHNZn
 Q8aHbf6NAICBb1vdkbDdkZrFXKKm0GiJ5rLsHJiXQYKR+/pwejR78nCkQk2O//j26w3yiEy
 B4e9U0eKU1UlfBUJ8tjWFsD+MRHa/0mmzrf6AkIkZBxBw6Fet3OVxBgKfYW5R8KivfCy9IB
 8BM3VcTfsQW6cJH+gDemg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aisv5GslM5s=:fgdqq2vOUBkskFLzUK4HbK
 mdYaBqtyzBy5eomyTBJSSVuIA1S50aIhrpfX9/gPchivsZiKRuQL0FiScPfL1q6CulLZc+I+d
 jAgGCw+bby+1uDM9JtijQzPEmGNc5hOMgzkpJsPivHM/idCEeL/vDHlgir1zmp6floMhLIY13
 8CQVEMYyLItR93xNNDVDWo+8B7EVnPuQyfHtCFpvgyFW5tQaDXFyQHpvKQNqIBRCWyzJs1RNl
 aXIEXzMG3ENa8ABAmc84D0Fl5x0xq02+WuXfMqHaZcR6+s9vL/xDAfE0rVkuOhnLeg+xwS1pV
 Magg3Dm6wnP9NYIvJZRwgTqEhx+uxeDl2+8fE8StLT3waI+qf9xX90m1npzGuffzaoQYmRVWG
 y2b0b6xnbo1MAso1ThoyWM870/sYErCKC3SGVpyYC4QyVqd7dpnBlDxWoIzOX5CGZHl+kbw0q
 fTJiu2WEwKrcBCPRGoTe1IwiGL8dpGs15ry2tLKiRCVzX4wnPmloohjI3MkQZBQNd4BUQmlPF
 6Gd+jty8s1xplsJx64+FsRKCzrcr4dYNSIe2/L3mI7Gbd2uZ5AmK1+lNJw5abpqq141dDNBeV
 +YSXOzpBmtY0W8d7ugbh8yAbQx0lwZOEe9m8s4wkBI2uVB7SPLT4vYS3PCtZ6IrXa6Qdl3CPo
 MEGlSX1EPBOpztQmyAkCi1yeNIhZmH2zYqOSg/yS5KQYB2ok/gWeNvuT9z5MWjYXT0RSZPTko
 npH8dH8kEEOrVGJ00QK5iSufVKVljmlTrD3dARxExYqtTFfbW0PG11YeCxfXl9iD0MYT4RV+N
 /ZSk1CpuCw24Be+Ao3sJ6dRCrKUAHk0KvaJVzJD40qWt/aBySgHcmEG0Ixo7qmF0cT2tGlelj
 ucKoiK9DdY6O+eUGBt7wy6yL4aWwtJjFfP/p5acMc7AxTObR5jUVzam5oDiaAPrMQs8k4b3R4
 uXzf62o4XNr3lINd6KU1VQUhiWQAzDU+dk2fbVQsZk5v25/Eo13L/EKwje62ftgRg/4RrfxHy
 wP9fNQL4QdpW2Qbo/CLSFoA5i/aVGiZCLzIZX3YM2GjIP9A2HLdbyKkjrrDMWZiyNbP2ujPbr
 HMgi3r/SVrVvV0kPY8+aAv5XrfGtmn13G6NIrEc3codXTMazluT11qNDc0quoWmLbbxSlCsqA
 3ee7xMMgELD8+d3av9Lm1pc5msF/CIn9aqUZi9hxBPxAc2rOIcUNoi3UNMRLkqqUykg7aTrFh
 itJQW6wj1uyBKN7uWZaxeG0gECyxOjjo9H8XRRg==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.15.18
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.01.20 18:46, Igor Mammedov wrote:
> Previous patch drops silent ram_size fixup and makes
> QEMU error out with:
>
>  "RAM size more than 3840m is not supported"
>
> when user specified -m X more than supported value.
>
> User shouldn't be bothered with starting QEMU with valid CLI,
> so for the sake of user convenience allow using -m 4G vs -m 3840M.
>
> Requested-by: Helge Deller <deller@gmx.de>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v2:
>   - make main ram -1 prio, so it wouldn't conflict with other regions
>     starting from 0xf9000000
>
> I dislike it but if you feel it's really necessary feel free to ack it.
>
> should be applied on top of:
>   "hppa: drop RAM size fixup"

Hello Igor,
I appreciate that you are trying to make it more cleaner.
But, can't you merge both of your patches to one patch?
Right now you have one patch "hppa: drop RAM size fixup", which is
what I think is wrong. Then you add another one which somehow
fixes it up again and adds other stuff.
Having everything in one single patch makes your full change more
understandable.

Is it necessary to introduce clamped_ram_size and not continue with
ram_size (even if you would add it as static local variable)?

Helge


> ---
>  hw/hppa/machine.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
>
> diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
> index ebbf44f..0302983 100644
> --- a/hw/hppa/machine.c
> +++ b/hw/hppa/machine.c
> @@ -54,6 +54,7 @@ static uint64_t cpu_hppa_to_phys(void *opaque, uint64_=
t addr)
>
>  static HPPACPU *cpu[HPPA_MAX_CPUS];
>  static uint64_t firmware_entry;
> +static ram_addr_t clamped_ram_size;
>
>  static void machine_hppa_init(MachineState *machine)
>  {
> @@ -74,8 +75,6 @@ static void machine_hppa_init(MachineState *machine)
>      long i;
>      unsigned int smp_cpus =3D machine->smp.cpus;
>
> -    ram_size =3D machine->ram_size;
> -
>      /* Create CPUs.  */
>      for (i =3D 0; i < smp_cpus; i++) {
>          char *name =3D g_strdup_printf("cpu%ld-io-eir", i);
> @@ -90,12 +89,14 @@ static void machine_hppa_init(MachineState *machine)
>      }
>
>      /* Limit main memory. */
> -    if (ram_size > FIRMWARE_START) {
> -        error_report("RAM size more than %d is not supported", FIRMWARE=
_START);
> +    if (machine->ram_size > 4 * GiB) {
> +        error_report("RAM size more than 4Gb is not supported");
>          exit(EXIT_FAILURE);
>      }
> +    clamped_ram_size =3D machine->ram_size > FIRMWARE_START ?
> +        FIRMWARE_START : machine->ram_size;
>
> -    memory_region_add_subregion(addr_space, 0, machine->ram);
> +    memory_region_add_subregion_overlap(addr_space, 0, machine->ram, -1=
);
>
>      /* Init Dino (PCI host bus chip).  */
>      pci_bus =3D dino_init(addr_space, &rtc_irq, &serial_irq);
> @@ -151,7 +152,7 @@ static void machine_hppa_init(MachineState *machine)
>      qemu_log_mask(CPU_LOG_PAGE, "Firmware loaded at 0x%08" PRIx64
>                    "-0x%08" PRIx64 ", entry at 0x%08" PRIx64 ".\n",
>                    firmware_low, firmware_high, firmware_entry);
> -    if (firmware_low < ram_size || firmware_high >=3D FIRMWARE_END) {
> +    if (firmware_low < clamped_ram_size || firmware_high >=3D FIRMWARE_=
END) {
>          error_report("Firmware overlaps with memory or IO space");
>          exit(1);
>      }
> @@ -204,7 +205,7 @@ static void machine_hppa_init(MachineState *machine)
>                 (1) Due to sign-extension problems and PDC,
>                 put the initrd no higher than 1G.
>                 (2) Reserve 64k for stack.  */
> -            initrd_base =3D MIN(ram_size, 1 * GiB);
> +            initrd_base =3D MIN(clamped_ram_size, 1 * GiB);
>              initrd_base =3D initrd_base - 64 * KiB;
>              initrd_base =3D (initrd_base - initrd_size) & TARGET_PAGE_M=
ASK;
>
> @@ -232,7 +233,7 @@ static void machine_hppa_init(MachineState *machine)
>       * various parameters in registers. After firmware initialization,
>       * firmware will start the Linux kernel with ramdisk and cmdline.
>       */
> -    cpu[0]->env.gr[26] =3D ram_size;
> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>      cpu[0]->env.gr[25] =3D kernel_entry;
>
>      /* tell firmware how many SMP CPUs to present in inventory table */
> @@ -255,11 +256,11 @@ static void hppa_machine_reset(MachineState *ms)
>      }
>
>      /* already initialized by machine_hppa_init()? */
> -    if (cpu[0]->env.gr[26] =3D=3D ram_size) {
> +    if (cpu[0]->env.gr[26] =3D=3D clamped_ram_size) {
>          return;
>      }
>
> -    cpu[0]->env.gr[26] =3D ram_size;
> +    cpu[0]->env.gr[26] =3D clamped_ram_size;
>      cpu[0]->env.gr[25] =3D 0; /* no firmware boot menu */
>      cpu[0]->env.gr[24] =3D 'c';
>      /* gr22/gr23 unused, no initrd while reboot. */
>


