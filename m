Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 431C1C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:20:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 167C624655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 14:20:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 167C624655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42834 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuGs5-0004Hw-Ub
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 09:20:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58294)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iuGoC-0000oJ-2X
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iuGo9-00043h-N6
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:38 -0500
Received: from mout.kundenserver.de ([212.227.17.13]:42383)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iuGny-0003ve-HX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 09:16:37 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1M4sD3-1iwCTe3vc7-0020qQ; Wed, 22 Jan 2020 15:16:10 +0100
Subject: Re: [PATCH 10/12] configure: Detect kcov support and introduce
 CONFIG_KCOV
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1579214991-19602-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1579214991-19602-11-git-send-email-aleksandar.markovic@rt-rk.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCJMYXVyZW50IFZp
 dmllciA8bGF1cmVudEB2aXZpZXIuZXU+iQI4BBMBAgAiBQJWBTDeAhsDBgsJCAcDAgYVCAIJ
 CgsEFgIDAQIeAQIXgAAKCRDzDDi9Py++PCEdD/oD8LD5UWxhQrMQCsUgLlXCSM7sxGLkwmmF
 ozqSSljEGRhffxZvO35wMFcdX9Z0QOabVoFTKrT04YmvbjsErh/dP5zeM/4EhUByeOS7s6Yl
 HubMXVQTkak9Wa9Eq6irYC6L41QNzz/oTwNEqL1weV1+XC3TNnht9B76lIaELyrJvRfgsp9M
 rE+PzGPo5h7QHWdL/Cmu8yOtPLa8Y6l/ywEJ040IoiAUfzRoaJs2csMXf0eU6gVBhCJ4bs91
 jtWTXhkzdl4tdV+NOwj3j0ukPy+RjqeL2Ej+bomnPTOW8nAZ32dapmu7Fj7VApuQO/BSIHyO
 NkowMMjB46yohEepJaJZkcgseaus0x960c4ua/SUm/Nm6vioRsxyUmWd2nG0m089pp8LPopq
 WfAk1l4GciiMepp1Cxn7cnn1kmG6fhzedXZ/8FzsKjvx/aVeZwoEmucA42uGJ3Vk9TiVdZes
 lqMITkHqDIpHjC79xzlWkXOsDbA2UY/P18AtgJEZQPXbcrRBtdSifCuXdDfHvI+3exIdTpvj
 BfbgZAar8x+lcsQBugvktlQWPfAXZu4Shobi3/mDYMEDOE92dnNRD2ChNXg2IuvAL4OW40wh
 gXlkHC1ZgToNGoYVvGcZFug1NI+vCeCFchX+L3bXyLMg3rAfWMFPAZLzn42plIDMsBs+x2yP
 +bkCDQRWBSYZARAAvFJBFuX9A6eayxUPFaEczlMbGXugs0mazbOYGlyaWsiyfyc3PStHLFPj
 rSTaeJpPCjBJErwpZUN4BbpkBpaJiMuVO6egrC8Xy8/cnJakHPR2JPEvmj7Gm/L9DphTcE15
 92rxXLesWzGBbuYxKsj8LEnrrvLyi3kNW6B5LY3Id+ZmU8YTQ2zLuGV5tLiWKKxc6s3eMXNq
 wrJTCzdVd6ThXrmUfAHbcFXOycUyf9vD+s+WKpcZzCXwKgm7x1LKsJx3UhuzT8ier1L363RW
 ZaJBZ9CTPiu8R5NCSn9V+BnrP3wlFbtLqXp6imGhazT9nJF86b5BVKpF8Vl3F0/Y+UZ4gUwL
 d9cmDKBcmQU/JaRUSWvvolNu1IewZZu3rFSVgcpdaj7F/1aC0t5vLdx9KQRyEAKvEOtCmP4m
 38kU/6r33t3JuTJnkigda4+Sfu5kYGsogeYG6dNyjX5wpK5GJIJikEhdkwcLM+BUOOTi+I9u
 tX03BGSZo7FW/J7S9y0l5a8nooDs2gBRGmUgYKqQJHCDQyYut+hmcr+BGpUn9/pp2FTWijrP
 inb/Pc96YDQLQA1q2AeAFv3Rx3XoBTGl0RCY4KZ02c0kX/dm3eKfMX40XMegzlXCrqtzUk+N
 8LeipEsnOoAQcEONAWWo1HcgUIgCjhJhBEF0AcELOQzitbJGG5UAEQEAAYkCHwQYAQIACQUC
 VgUmGQIbDAAKCRDzDDi9Py++PCD3D/9VCtydWDdOyMTJvEMRQGbx0GacqpydMEWbE3kUW0ha
 US5jz5gyJZHKR3wuf1En/3z+CEAEfP1M3xNGjZvpaKZXrgWaVWfXtGLoWAVTfE231NMQKGoB
 w2Dzx5ivIqxikXB6AanBSVpRpoaHWb06tPNxDL6SVV9lZpUn03DSR6gZEZvyPheNWkvz7bE6
 FcqszV/PNvwm0C5Ju7NlJA8PBAQjkIorGnvN/vonbVh5GsRbhYPOc/JVwNNr63P76rZL8Gk/
 hb3xtcIEi5CCzab45+URG/lzc6OV2nTj9Lg0SNcRhFZ2ILE3txrmI+aXmAu26+EkxLLfqCVT
 ohb2SffQha5KgGlOSBXustQSGH0yzzZVZb+HZPEvx6d/HjQ+t9sO1bCpEgPdZjyMuuMp9N1H
 ctbwGdQM2Qb5zgXO+8ZSzwC+6rHHIdtcB8PH2j+Nd88dVGYlWFKZ36ELeZxD7iJflsE8E8yg
 OpKgu3nD0ahBDqANU/ZmNNarBJEwvM2vfusmNnWm3QMIwxNuJghRyuFfx694Im1js0ZY3LEU
 JGSHFG4ZynA+ZFUPA6Xf0wHeJOxGKCGIyeKORsteIqgnkINW9fnKJw2pgk8qHkwVc3Vu+wGS
 ZiJK0xFusPQehjWTHn9WjMG1zvQ5TQQHxau/2FkP45+nRPco6vVFQe8JmgtRF8WFJA==
Message-ID: <43efd755-911a-a196-12a1-4a8ffd31b571@vivier.eu>
Date: Wed, 22 Jan 2020 15:16:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <1579214991-19602-11-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KmzGdACzBvETrTjWpvRvxE2ud4zubMdoNrEt3q8/Hwr5zevPii0
 6cJ8EUPIaqC1WxhGIoHx1LQdHFVemGvkh+ePTWpGunZ7rPIcoAkQ9YsDmcytV3r8fYV/+5X
 9ZuHtYIFK2qLMz1odi8cEZS6ux2LlG48s1vSddPQuIIGF/A0b2hipvSwvCvXxdaADc8nn6D
 zsQm70J0RFHrvR3Z9vk9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qfcMAthq+PA=:kqwpDNlq4mOthb5cgQVeaW
 sg8Pn+hsqtWAhX3xYCl9OpKQsUAGXQbrvbNV2v9R7l3ybk0bLwFAUjei/j6PFemSp3omZihAS
 BwOW42shF6eJIz7NjOH6glVC26oy6mWw8Bn3IO0Du7xeoRSmwmCZdJ9UUnnNGdPmDMyya/59T
 QhdLmoEwaMDFNTSJ9TA/As8IhVXa7VxrQzo1dTHj+R3K/6EeOCWbjHL9P2hd5NwIw8V8CBohh
 GEQRiIj6iivF3kTio8uoIt5ZZgkwBnnZsBQPyx7DILF0GR0wZz4F9qef8NiOuyy5CNRrt8t7P
 kOwrgDpaonD6nOnheF1MRIUaysCJXezqxpFXsQ5NHOmDkQvOv7Ow0l4lA2HfdbLYWNx61u951
 sPpxKfPeNPvfZPEGDfv3Gr4Now7m1BX5YiK5V9JFsHWFAthxDpc5AFAP5+uZybis8148SzFcB
 7+HuL6u169KWZ+AsXJ0/bt798RlP1PbzBNOJ1jZ6qeVrFVKMH+PJd2bzX0EvFg1BrCBPjZGXM
 pIUyM4ovBCSjJEEwtHau/nxHN/f8Qzh+JAOIHYKfAKbMdbX7Pn7Y69xuMpPQxw3EGk3fjgom+
 DlrydakZfBkXW1PAxyXBm31J4093qb/Mc9gzTGvEb77LNGJELe8QDe1WrUH34mSniKCM1Dwnc
 4q7HXwvx5E5lNDJr3N6qLULXX4OwrL62IcK1J098ovegRRQA6eAfm2OAY7ALm0pXrN2Dc9BHF
 gcEQvlN3uuMjQwEM+wAyA6FyEEWZxyh/ruj7VoDo+5JxYl/510+s0v8cH8PRTp7+Y/rYNg2US
 nutL51xqBXKyvpo3Rf0zjDhle5AuiO3XW+lXldovSFA+AJOxjM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.13
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
Cc: amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 16/01/2020 à 23:49, Aleksandar Markovic a écrit :
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
> 
> kcov is kernel code coverage tracing tool. It requires kernel 4.4+
> compiled with certain kernel options.
> 
> This patch checks if kcov header "sys/kcov.h" is present on build
> machine, and stores the result in variable CONFIG_KCOV, meant to
> be used in linux-user code related to the support for three ioctls
> that were introduced at the same time as the mentioned header
> (their definition was a part of the first version of that header).
> 
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  configure | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/configure b/configure
> index 940bf9e..57e6eba 100755
> --- a/configure
> +++ b/configure
> @@ -4752,6 +4752,12 @@ if compile_prog "" "" ; then
>    syncfs=yes
>  fi
>  
> +# check for kcov support (kernel must be 4.4+, compiled with certain options)
> +kcov=no
> +if check_include sys/kcov.h ; then
> +    kcov=yes
> +fi
> +
>  # Check we have a new enough version of sphinx-build
>  has_sphinx_build() {
>      # This is a bit awkward but works: create a trivial document and
> @@ -6874,6 +6880,9 @@ fi
>  if test "$syncfs" = "yes" ; then
>    echo "CONFIG_SYNCFS=y" >> $config_host_mak
>  fi
> +if test "$kcov" = "yes" ; then
> +  echo "CONFIG_KCOV=y" >> $config_host_mak
> +fi
>  if test "$inotify" = "yes" ; then
>    echo "CONFIG_INOTIFY=y" >> $config_host_mak
>  fi
> 

Applied to my linux-user branch.

Thanks,
Laurent

