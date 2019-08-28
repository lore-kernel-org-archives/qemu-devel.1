Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58B55C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:53:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F1CE214DA
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 08:53:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F1CE214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2ti0-00027f-7g
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 04:53:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34872)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i2tgm-0001BI-MB
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i2tgl-0008E8-Ab
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 04:52:24 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:58237)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i2tgl-0008DI-1n; Wed, 28 Aug 2019 04:52:23 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MV5KC-1haoyM05x8-00S5C6; Wed, 28 Aug 2019 10:52:00 +0200
To: Josh Kunz <jkz@google.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 milos.stojanovic@rt-rk.com
References: <CADgy-2vznasvwaUwNSi96Sy=ucPC=-3e=O9irqc5DSpV_uhWUg@mail.gmail.com>
 <abf5f3b6-7c05-a85b-051f-9905b8f50041@vivier.eu>
 <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
From: Laurent Vivier <laurent@vivier.eu>
Openpgp: preference=signencrypt
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
Message-ID: <6542ac57-6b06-1337-825b-dd1187accd15@vivier.eu>
Date: Wed, 28 Aug 2019 10:51:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CADgy-2va2xVmO_a1gDwg+zkpNcLJTW5D1j=2kk1TnRMxyPaLMg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ouwgNHkEAdYnh26o4raLwgwve0Rfx7STJELe3f4l5nEOdhbLxZL
 NpQFBaonTNc6f8Z3iStbSe3mVk7LoUY116TTgcQ5F/6RoOP7oy6FlInqVV6FpNWAAtNuA4X
 2jv/6xrvBqHkIpfy4bPXfFy7/9QegJXiEX4LNk5NANPRKqyhpuVT+elAut3l8udpDx0MHiw
 XTAEcZ8OuUrCKNEEXrW0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HRqXxs8DNuU=:SL49YzSzc+Z5DpAsk9vu1a
 WYVYGflMcGfwRrxDzFrfv+JzOzDzSCM3lgTbmOniqxm+pxv1aA1Erbfl1sHlhqNYjMTqqCbnK
 ufOBUadgdhqbMtZ6HTNzgUrICBXrzbOKQ4Y6FwgBGRpTeJ1jKu9NfzCSM77/jL9zft1UIMc+p
 RlzghEDC1EYi15V+3gUJpNzNfMqwQlQS0TK4tEz4gWF80lnLafYucx4uf9il5yQhScNBjvXwc
 aTcwXCMZbN08XnfsNH0vZHZ8KUXTz93/dGVTgWNxOMn6ZXZzlvyfp6Ex2gmd1MBdsMsLuk8qE
 Uo/KiWrMONt45cTpNsdm5puZwyE7ZPSTjbBM1uvyQrW7xbsFQgzLmNuqRUHOdcoCll4jiLh9R
 1k40WmRjdRIHxroGb0hwxtPesKz89YKcgkkNoPrQaRYX5il3xXmRdyPg0PTjGUlr7BLbX0h3k
 RwW+XykTy4vQLzv33plCeFyTT48Rd4fH5UXbgAgwZQvGgRQusZIfaZP75YBENR1lTp0+Llf8k
 jKltc2FWV9H6HPJkoUkuqaLUhweardIuSEEmZCy6OMA1kHfsI8XYeBw5Dop2sBr0NItU71A1O
 qOSNiYRnjYYVEo9Psc+Bwx1PF9jcemFH70wIQ9WOhNZdKXGKeXAomz+y0O4jgLRrVcQptvZHK
 EnEWfrpwKrFvvP/22NI9wkG02Tgi0cHCWBirv+Q5y1GCFRixyUSaBcrJAd/0b+k8dKYxPCasZ
 F6JYElGN/jA+WWrAnWnVvEjYtlbk6mBlAJ5c4SPudHfE0qbMAHnFvJdjPSA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.10
Subject: Re: [Qemu-devel] patch to swap SIGRTMIN + 1 and SIGRTMAX - 1
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org,
 riku.voipio@iki.fi, qemu-devel@nongnu.org, marlies.ruck@gmail.com,
 Aleksandar Markovic <amarkovic@wavecomp.com>, Shu-Chun Weng <scw@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 26/08/2019 à 23:10, Josh Kunz a écrit :
> On Wed, Aug 21, 2019 at 2:28 AM Laurent Vivier <laurent@vivier.eu
> <mailto:laurent@vivier.eu>> wrote:
> 
>     Le 19/08/2019 à 23:46, Josh Kunz via Qemu-devel a écrit :
>     > Hi all,
>     >
>     > I have also experienced issues with SIGRTMIN + 1, and am interested in
>     > moving this patch forwards. Anything I can do here to help? Would the
>     > maintainers prefer myself or Marli re-submit the patch?
>     >
>     > The Go issue here seems particularly sticky. Even if we update the Go
>     > runtime, users may try and run older binaries built with older
>     versions of
>     > Go for quite some time (months? years?). Would it be better to
>     hide this
>     > behind some kind of build-time flag
>     (`--enable-sigrtmin-plus-one-proxy` or
>     > something), so that some users can opt-in, but older binaries
>     still work as
>     > expected?
>     >
>     > Also, here is a link to the original thread this message is in
>     reply to
>     > in-case my mail-client doesn't set up the reply properly:
>     > https://lists.nongnu.org/archive/html/qemu-devel/2019-07/msg01303.html
> 
>     The problem here is we break something to fix something else.
> 
>     I'm wondering if the series from Aleksandar Markovic, "linux-user:
>     Support signal passing for targets having more signals than host" [1]
>     can fix the problem in a better way?
> 
> 
> That patch[1] (which I'll refer to as the MUX patch to avoid confusion)
> does not directly fix the issue addressed by this patch (re-wiring
> SIGRTMIN+1), but since it basically implements generic signal
> multiplexing, it could be re-worked to address this case as well. The
> way it handles `si_code` spooks me a little bit. It could easily be
> broken by a kernel version change, and such a breakage could be hard to
> detect or lead to surprising results. Other than that, it looks like a
> reasonable implementation.
> 
> That said, overall, fixing the SIGRTMIN+1 issue using a more-generic
> signal-multiplexing mechanism doesn't seem *that* much better to me. It
> adds a lot of complexity, and only saves a single signal (assuming glibc
> doesn't add more reserved signals). The "big win" is additional
> emulation features, like those introduced in MUX patch (being able to
> utilize signals outside of the host range). If having those features in
> QEMU warrants the additional complexity, then re-working this patch
> on-top of that infrastructure seems like a good idea.
> 
> If the maintainers want to go down that route, then I would be happy to
> re-work this patch utilizing the infrastructure from the MUX patch.
> Unfortunately it will require non-trivial changes, so it may be best to
> wait until that patch is merged. I could also provide a patch "on top
> of" the MUX patch, if that's desired/more convenient.
> 
> Just one last note, if you do decide to merge the MUX patch, then it
> would be best to use SIGRTMAX (instead of SIGRTMAX-1) as the
> multiplexing signal if possible, to avoid breaking go binaries.
> 

Personally, I prefer a solution that breaks nothing.

Aleksandar, Milos,

do you have an updated version of you series "Support signal passing for
targets having more signals than host"?

Thanks,
Laurent

