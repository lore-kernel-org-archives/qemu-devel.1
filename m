Return-Path: <SRS0=HiY9=4H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BE33C34056
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DB62207FD
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Feb 2020 19:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DB62207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4VDw-00023j-65
	for qemu-devel@archiver.kernel.org; Wed, 19 Feb 2020 14:41:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j4VDB-0001XB-ET
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:40:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j4VDA-00064P-Hc
 for qemu-devel@nongnu.org; Wed, 19 Feb 2020 14:40:45 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:55927)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j4VDA-00060s-95; Wed, 19 Feb 2020 14:40:44 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N8onW-1jYjAd1c9u-015ohS; Wed, 19 Feb 2020 20:40:01 +0100
Subject: Re: [PATCH 21/22] linux-user,mips: move content of mips_syscall_args
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20200217223558.863199-1-laurent@vivier.eu>
 <20200217223558.863199-22-laurent@vivier.eu>
 <CAL1e-=hxuExGBLhy=mYvM3ZfXeZA2KpA6z-5=X6xta5WcM+p5A@mail.gmail.com>
 <CAL1e-=j1R1Sd-Y8Wc56SHKZf1QLjhNq5KpY2RHD3wkQf0QKeaQ@mail.gmail.com>
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
Message-ID: <9f0e6f56-1a0e-9dc5-8608-e9928ff27cba@vivier.eu>
Date: Wed, 19 Feb 2020 20:39:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=j1R1Sd-Y8Wc56SHKZf1QLjhNq5KpY2RHD3wkQf0QKeaQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:5KBncYfKkcPiwI05jcDcEW/r9Ed2Kb0ctiP5+i3oRSEi+c+lE/U
 PzS+dq+Bmcxc8PtLxPdfO0bb8yUU0MU3KgKjR13HHuprpfoI0pCT1efT70erXPcC46WINTH
 BymqEcFyVLQq/QSSErOjbH4uiLK/+oF7YHuB99iUsYO1ryBnf+ZyfW44/zaeZh4OnBrDjIJ
 vO+akMUo5i1zINjINw9Tg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HM1omNQzdYA=:RArtzOhVlnjxR2u9oCuzBP
 IOr5HKC+ht+ggZF/wNJgt88KlGgMe5iCSe0YfRVdzreQvuZEtRhCn090puShhVOneCbNdYGiN
 B6d1wuAZqlAUg+DgPMbPQ13mH5X+9yMTsRjqASNn7wRSZU6Hq6myAx7Ej+WykCtTzktlqhrmp
 g5ee7+H/++EQsI+jNqRNGnDoxl3xTPuGQjwXeWkc0PjQY+aJroalKwRMj6EPBkvvx9Z0W8Yus
 jLlvqVc8N6AvQdZDn6FgvthwT6Y0ECRlVNEiyGz1mf5JosNsRdyWpH92EuwJfLkOXXvkLk0qz
 TMb1c7jbuWbXADy/m4vcYFbVHlSpLInbicwEnG94eFGdH51+nll008ctBWo9t/5N1oR1/SfDZ
 RAGzYaQzzLZCI77Jecigb3fZ88SSknoU//WYRR72tqHeTw9tJymVh/XOutwliFOD1qNcDpwFJ
 pF+qvxlRGeyy7wC1SKkyhHZinWDctBaNuB1Ftlh8z1qHito5HrbIlnj/YrLChiGb6OVr6Zk7m
 RCgSG8nRlRKNogByfFR9NVd0J06tQwOXBoRmGOHolqnJENIQRu/zJ3hdoc8IBLpTChFmuNjuf
 C8IGGcYpPZTrl2ijiap4cPuyOSPXlKJze0W4fLNKKw9n/tbjOYvqZhsMcRE4KSinxM8syBbsN
 BNEsO3WbJSKdaOTjPRIlFYA4M+6cmn/Qiv7nY3nUTHLTJ/3VMBxSlLlyyaRa1KAkx4FW6BSqt
 4chmL4626t3D66tRohIroNG1EtRforjUvAqD3ZPVoM6pPI7slEIjSmlQeEumEv5zysi+AlldR
 AK3pqUCnuVKQkFDzbzQmOBLta9qcJkjVOmyfGoIRNcc9ewJRR1fw0OX2oVK7tRrTPfke5Fb
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.135
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/02/2020 à 19:58, Aleksandar Markovic a écrit :
> 
> 
> On Tuesday, February 18, 2020, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
> 
> 
> 
>     On Monday, February 17, 2020, Laurent Vivier <laurent@vivier.eu
>     <mailto:laurent@vivier.eu>> wrote:
> 
>         Move content of mips_syscall_args to mips-syscall-args-o32.c.inc to
>         ease automatic update. No functionnal change
> 
>         Signed-off-by: Laurent Vivier <laurent@vivier.eu
>         <mailto:laurent@vivier.eu>>
>         ---
> 
> 
> 
> Laurent,
> 
> Many thanks for implementing this series, and a special thank you for
> mips parts! I conceptually agree with the whole content (but I looked in
> details only mips-related stuff), however I will take a closer look at
> the entire series in next few days.

I plan to send a v2 to remove the syscall32_nr.h and syscall64_nr and
use everywhere syscall_nr.h (because it is generated by target). files
because they are not needed. Wait the v2 to take a closer look, except
if you see any obvious issue.

Thanks,
Laurent


