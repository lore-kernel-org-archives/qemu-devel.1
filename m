Return-Path: <SRS0=u80H=ZS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D31C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:14:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 403CB2073F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Nov 2019 08:14:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 403CB2073F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZVzJ-0001hd-Dv
	for qemu-devel@archiver.kernel.org; Tue, 26 Nov 2019 03:14:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iZVyN-00010e-76
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:13:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iZVtb-0000tx-8c
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:08:28 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:36305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iZVta-0000tX-Vj
 for qemu-devel@nongnu.org; Tue, 26 Nov 2019 03:08:27 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mum2d-1hjKwt0uWZ-00rmoU; Tue, 26 Nov 2019 09:08:24 +0100
Subject: Re: [PATCH] linux-user: Improve strace output for read() and getcwd()
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Helge Deller <deller@gmx.de>
References: <20191121201448.GA3133@ls3530.fritz.box>
 <CAL1e-=ia9kmSUOztiGD=Mk4e8+r3oh2P3j_bAR2971FEGvAFyw@mail.gmail.com>
 <bc2a9dfb-cc5b-0916-38c7-6e07287b1080@gmx.de>
 <CAL1e-=h1Os3YK=c1oStG1c0fBhvp4XX-SqfRMo3U0oxjBsg9_A@mail.gmail.com>
 <e547f389-7281-4091-5bfb-a0aea265128d@gmx.de>
 <CAL1e-=ig8j+omFrdRGB1uf1mE8_9nJbt87=oAX3brbr34_cDMA@mail.gmail.com>
 <CAL1e-=hBvL0a8CDuD2Ok0U7vh8t0f-VQmi671OoudXnqLagFsg@mail.gmail.com>
 <d4815598-954b-4b4f-61cd-24611de04c56@gmx.de>
 <CAL1e-=itFFWZW9b2B=oL3ZOKOgKq6+TO+f0WU9vWh8pjNY9k0g@mail.gmail.com>
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
Message-ID: <66b00f4f-10df-cb1e-b339-49236ad71bee@vivier.eu>
Date: Tue, 26 Nov 2019 09:08:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=itFFWZW9b2B=oL3ZOKOgKq6+TO+f0WU9vWh8pjNY9k0g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:psZpud9mUcVC9zEDFecuRAhcLfug0+tcyptqzmTYjoqHnC/BJG3
 tnwi+ijdQLTKqmfJdb3F8wiQ/bxGbQ4Oeg+VoAWVFICGK46LgFXw0HA63XRPF2DBavAaA94
 E5Lgo+SigAjAvJ69GjJ9o8iProXDxckseyZQLHSSTuY7BbTv4HBpkdIZsE1XxendJk9Q4WO
 3VUV9Ch3GBGgNyt/Dyp0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DdVIkyKJml0=:Co74T5eOqYe6d/S7UjgGkq
 0nolJEVYmcnOcINwTpUOjvdnYUyYOTiXMLeZA/wviVYExvfwNMfH/3k0UzKvz8lGyrZPEiNHh
 HEG07/hi9dex5A+rvlKYur1A9gCUHJBtAPZ9tbRXpYtWu/GzjoYBsGTfwCe8NRhKF2a99Gl5k
 d1I1cvGO+KEo116iooe/iuVx+7aHjPNyRW6jw1NNGwlM5fn6NlQjto7chysLYOqDLzBNAJn0a
 mH5n+BsS1YMODZqfhMhVFZTqvLxXAoHT8jp4P45DnkKelWfniOy0Urgkq81TpP/fJaFZAy/FY
 gM3HZ9U3p4QCediVawoRuii7kig+H6FA7fQ8WemRP4AnlEGoIs6BXoe0T35Vf+Gd7zMwj2zO5
 8V9dvVCpsVr6KbEImJe3O6Sfw0krlUbB7J24A/skuasLcBbJLLkxJlVYq4gvgJ4C6O4Q/Rrm/
 WqDis5+KWTtIm8fDKRig24aEUTJn+kaWkWdKKeso5Or6ixhjwLLdJyvLvMasgoh1uMFz5M48p
 pcNtVlZnmf3cIjF6wDEnCKYtq1JR3zluJ6mJzOlSkhy89habWH+7Vo1cQybfHI4pYRsXmcPZj
 Y765/BtwIX8edHHHKxN5X2veuF+FuVOv+Bf3COBVF7kNuXvk8RYRYrWU0D89KjRuO6LRKfer1
 D3A5RpS5k6A/HVprfRPuz1h0tJPSLswpG/KiPKZ6y+6v4do4RhZF9MAscruggU5INTFh87wyL
 PSUQcVvCkz12KFd9BNl39mFwPg0GjEmJxZctI0ljtVEH7eI+HfmdYv4jLH64fwJo49TbTRNru
 emrFrFtgLRMPMbeLgbUJdq2Mk76l/usVEpfHcgGQK7lE6dweuDVTx4u3AGzLNh17PD5x2sQYa
 7tk47ym38LQyLpRyanEA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.187
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/11/2019 à 21:54, Aleksandar Markovic a écrit :
>>> 4. NEW PROPOSAL :
>>>
>>> early: read(3,0xff80038c,512)
>>> late: = 512  [(3,"\177ELF\1\2\1\3\0\0\0\0\0\0\0\0\0\3\0\17\0\0\0\1\0\2bl\0\0\04"...,512)]
>>> early: getcwd(0x18180,4096)
>>> late: = 9  [("/usr/bin",4096)]
>>>
>>> In other words, we would print for (selected) system calls content of
>>> the parameters both before and after actual ioctl
>>> translation/execution.
>> I don't like this.
>> IMHO it just adds unnecessary noise and differs from what a native strace shows.
>>
> QEMU strace doesn't have to be the same as native strace. Actually,
> they could be used even at the same time: QEMU provides info on target
> syscall, strace on host syscall. Do not forget that not all syscalls
> are implemeted as one-to-one-correspondence between target and host
> syscalls - combination of QEMU strace and native strace is precious at
> some moments.
> 
> In any case, I think that requiring QEMU strace to look exactly like
> native strace is a self-imposed limitation, that does not have enough
> justification. Think of it, wouldn't it be nice to surpass strace,
> like in these cases above?

I'd like to have a QEMU_STRACE formatting similar to the host strace
formatting because it makes debugging easier: we can run the same
program in guest and host and compare the strace output to see where it
differs and thus where the problem appears.

Thanks,
Laurent

