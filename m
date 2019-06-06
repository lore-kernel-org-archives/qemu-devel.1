Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BD73C04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:26:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6383D2083E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 20:26:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6383D2083E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ilande.co.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYyyP-0006SW-H8
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 16:26:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41560)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYyxH-0005vr-IM
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:25:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mark.cave-ayland@ilande.co.uk>) id 1hYyxG-0006pi-03
 for qemu-devel@nongnu.org; Thu, 06 Jun 2019 16:25:47 -0400
Received: from mail.ilande.co.uk ([46.43.2.167]:59670
 helo=mail.default.ilande.uk0.bigv.io)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hYywy-0005mA-QY; Thu, 06 Jun 2019 16:25:35 -0400
Received: from host81-158-188-206.range81-158.btcentralplus.com
 ([81.158.188.206] helo=[192.168.1.65])
 by mail.default.ilande.uk0.bigv.io with esmtpsa
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.89)
 (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1hYyte-00010S-0C; Thu, 06 Jun 2019 21:22:04 +0100
To: Laurent Vivier <lvivier@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20190108224600.23125-1-david@gibson.dropbear.id.au>
 <20190108224600.23125-10-david@gibson.dropbear.id.au>
 <759cdab3-6cf9-bb83-54f2-12d60063b15c@redhat.com>
 <6d1c8b12-0e27-b3f3-9e0e-ad68c5572ed7@ilande.co.uk>
 <09f7a354-b1be-48b4-15ea-4923386b6a77@redhat.com>
 <cc1a09a4-9045-f71f-7d60-b638f59ac824@redhat.com>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Openpgp: preference=signencrypt
Autocrypt: addr=mark.cave-ayland@ilande.co.uk; keydata=
 mQENBFQJuzwBCADAYvxrwUh1p/PvUlNFwKosVtVHHplgWi5p29t58QlOUkceZG0DBYSNqk93
 3JzBTbtd4JfFcSupo6MNNOrCzdCbCjZ64ik8ycaUOSzK2tKbeQLEXzXoaDL1Y7vuVO7nL9bG
 E5Ru3wkhCFc7SkoypIoAUqz8EtiB6T89/D9TDEyjdXUacc53R5gu8wEWiMg5MQQuGwzbQy9n
 PFI+mXC7AaEUqBVc2lBQVpAYXkN0EyqNNT12UfDLdxaxaFpUAE2pCa2LTyo5vn5hEW+i3VdN
 PkmjyPvL6DdY03fvC01PyY8zaw+UI94QqjlrDisHpUH40IUPpC/NB0LwzL2aQOMkzT2NABEB
 AAG0ME1hcmsgQ2F2ZS1BeWxhbmQgPG1hcmsuY2F2ZS1heWxhbmRAaWxhbmRlLmNvLnVrPokB
 OAQTAQIAIgUCVAm7PAIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQW8LFb64PMh9f
 NAgAuc3ObOEY8NbZko72AGrg2tWKdybcMVITxmcor4hb9155o/OWcA4IDbeATR6cfiDL/oxU
 mcmtXVgPqOwtW3NYAKr5g/FrZZ3uluQ2mtNYAyTFeALy8YF7N3yhs7LOcpbFP7tEbkSzoXNG
 z8iYMiYtKwttt40WaheWuRs0ZOLbs6yoczZBDhna3Nj0LA3GpeJKlaV03O4umjKJgACP1c/q
 T2Pkg+FCBHHFP454+waqojHp4OCBo6HyK+8I4wJRa9Z0EFqXIu8lTDYoggeX0Xd6bWeCFHK3
 DhD0/Xi/kegSW33unsp8oVcM4kcFxTkpBgj39dB4KwAUznhTJR0zUHf63LkBDQRUCbs8AQgA
 y7kyevA4bpetM/EjtuqQX4U05MBhEz/2SFkX6IaGtTG2NNw5wbcAfhOIuNNBYbw6ExuaJ3um
 2uLseHnudmvN4VSJ5Hfbd8rhqoMmmO71szgT/ZD9MEe2KHzBdmhmhxJdp+zQNivy215j6H27
 14mbC2dia7ktwP1rxPIX1OOfQwPuqlkmYPuVwZP19S4EYnCELOrnJ0m56tZLn5Zj+1jZX9Co
 YbNLMa28qsktYJ4oU4jtn6V79H+/zpERZAHmH40IRXdR3hA+Ye7iC/ZpWzT2VSDlPbGY9Yja
 Sp7w2347L5G+LLbAfaVoejHlfy/msPeehUcuKjAdBLoEhSPYzzdvEQARAQABiQEfBBgBAgAJ
 BQJUCbs8AhsMAAoJEFvCxW+uDzIfabYIAJXmBepHJpvCPiMNEQJNJ2ZSzSjhic84LTMWMbJ+
 opQgr5cb8SPQyyb508fc8b4uD8ejlF/cdbbBNktp3BXsHlO5BrmcABgxSP8HYYNsX0n9kERv
 NMToU0oiBuAaX7O/0K9+BW+3+PGMwiu5ml0cwDqljxfVN0dUBZnQ8kZpLsY+WDrIHmQWjtH+
 Ir6VauZs5Gp25XLrL6bh/SL8aK0BX6y79m5nhfKI1/6qtzHAjtMAjqy8ChPvOqVVVqmGUzFg
 KPsrrIoklWcYHXPyMLj9afispPVR8e0tMKvxzFBWzrWX1mzljbBlnV2n8BIwVXWNbgwpHSsj
 imgcU9TTGC5qd9g=
Message-ID: <3d67608e-5c14-b54c-a345-e1288a47ca74@ilande.co.uk>
Date: Thu, 6 Jun 2019 21:21:58 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <cc1a09a4-9045-f71f-7d60-b638f59ac824@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 81.158.188.206
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.uk0.bigv.io)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.43.2.167
Subject: Re: [Qemu-devel] [Qemu-ppc] [PULL 09/29] target/ppc: introduce
 get_cpu_vsr{l, h}() and set_cpu_vsr{l, h}() helpers for VSR register access
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-ppc@nongnu.org,
 Anton Blanchard <anton@ozlabs.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 06/06/2019 20:24, Laurent Vivier wrote:

> On 05/06/2019 09:43, Laurent Vivier wrote:
>> On 05/06/2019 08:32, Mark Cave-Ayland wrote:
>>> On 04/06/2019 22:23, Laurent Vivier wrote:
>>>
>>>> This patch breaks something in the libcrypto.
>>>>
>>>> I've been able to reproduce the problem with Fedora 29:
>>>>
>>>> dnf install 'dnf-command(download)'
>>>> dnf download --source coreutils-single
>>>> rpm --verify coreutils-8.30-7.fc29.src.rpm
>>>> error: coreutils-8.30-7.fc29.src.rpm: Header V3 RSA/SHA256 Signature, key ID 429476b4: BAD
>>>> error: coreutils-8.30-7.fc29.src.rpm: Header SHA256 digest: BAD (Expected fa042669e74ac435bd5defaa8c2e4efe779a0329c24f2b6377591c53b38aa280 != d6e22527412fafc4aa12882432d0d157e5427097710eeb2d5fce8fbc52a47be6)
>>>> error: coreutils-8.30-7.fc29.src.rpm: not an rpm package (or package manifest)
>>>>
>>>> See https://bugzilla.redhat.com/show_bug.cgi?id=1715017
>>>>
>>>> I've tested with origin/master (47fbad45d47af8af784bb12a5719489edcd89b4c) and all the 
>>>> merged fixes for this patch don't fix this problem.
>>>>
>>>> We should be able to reproduce it on Debian Sid too: it breaks ssh (this is one of the rare binaries using libcrypto on debian).
>>>>
>>>> I've been able to reproduce it with qemu linux-user if I enable PPC_FEATURE2_VEC_CRYPTO in linux-user/elfload.c
>>>> (git clone -b linux-user-ppc64-hwcap git@github.com:vivier/qemu.git).
>>>>
>>>> To ease debugging, you can install a Fedora 29 chroot with something like:
>>>>
>>>> curl -o container.tar.xz http://download-ib01.fedoraproject.org/pub/fedora-secondary/releases/29/Container/ppc64le/images/Fedora-Container-Base-29-1.2.ppc64le.tar.xz
>>>> tar Jxvf container.tar.xz '*/layer.tar'
>>>> mkdir -p chroot/ppc64le/29
>>>> cd chroot/ppc64le/29
>>>> tar xf $OLDPWD/*/layer.tar
>>>> cd -
>>>> cp ~/qemu/ppc64le-linux-user/qemu-ppc64le chroot/ppc64le/29/
>>>> [use "configure --target-list=ppc64le-linux-user --static --disable-tools" and don't forget to run scripts/qemu-binfmt-conf.sh]
>>>
>>> One of Anton's VSX patches hasn't landed in master yet and is still queued in
>>> ppc-for-4.1: "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x".
>>>
>>> Can you try David's ppc-for-4.1 branch first and let me know if that solves the
>>> issue? If not, I'll take a look at it later in the week when I have a bit more time.
>>
>> Thank you Mark.
>>
>> Anton's patch fixes the problem.
> 
> But there are two problems remaining with Fedora 29:
> 
> - in libssl (openssl-libs-1.1.1-3.fc29.ppc64le):
> 
>   $ curl -o /dev/null https://www.google.com
>   ...
>   curl: (35) error:1408F119:SSL routines:ssl3_get_record:decryption failed or bad record mac
> 
> - in the kernel (4.18.16-300.fc29.ppc64le):
> 
> [   39.742120] crypto_register_alg 'aes' = 0
> [   39.919286] crypto_register_alg 'cbc(aes)' = 0
> [   40.053942] crypto_register_alg 'ctr(aes)' = 0
> [   40.372764] alg: skcipher: Test 1 failed (invalid result) on encryption for p8_aes_xts
> [   40.373458] 00000000: 91 7c f6 9e bd 68 b2 ec 9b 9f e9 a3 ea dd a6 92
> [   40.373568] 00000010: 98 10 35 57 5e dc 36 1e 9a f7 bc ba 39 f2 5c eb
> [   40.374139] crypto_register_alg 'xts(aes)' = 0
> [   40.389241] alg: hash: Test 2 failed for p8_ghash
> [   40.389422] 00000000: 5f 89 ab f7 20 57 20 57 20 57 20 57 20 57 20 57
> 
> My qemu is on top of 
> 
> 0d74f3b427 Merge remote-tracking branch 'remotes/vivier2/tags/trivial-branch-pull-request' into staging
> + "target/ppc: Fix lxvw4x, lxvh8x and lxvb16x"

Hmmm and this is definitely a regression introduced by the same patch as given in the
subject?


ATB,

Mark.

