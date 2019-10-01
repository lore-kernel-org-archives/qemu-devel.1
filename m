Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E954C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:20:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73AB321906
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 11:20:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73AB321906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40492 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFGCr-0002BR-Ig
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 07:20:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iFGBj-0001fw-Gy
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:19:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iFGBi-00061s-EE
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:19:27 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:60897)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iFGBi-0005zZ-5B
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 07:19:26 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MdwRi-1hgkBJ0UT8-00b0rl; Tue, 01 Oct 2019 13:19:15 +0200
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20190930192931.20509-1-richard.henderson@linaro.org>
 <ec1ace6c-49db-e769-e43e-6b0e059d6705@linaro.org>
 <CAFEAcA9r+N5Q076kWYyu0a+_VvnzU0FRXZK7hZ4t52JO=a3qTA@mail.gmail.com>
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
Subject: Re: [PATCH] user-exec: Do not filter the signal on si_code
Message-ID: <7315e0ed-0d33-e998-1dc4-01664c300723@vivier.eu>
Date: Tue, 1 Oct 2019 13:19:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9r+N5Q076kWYyu0a+_VvnzU0FRXZK7hZ4t52JO=a3qTA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VTiI2Bza76VQqwRAmzPuxahPOQKiN+u1Yb1ZZDEZQ66xepS683s
 nI7XtqY0/SNUKj2K/F9rri9ir9RXnKWbwkv690fKM5ui5z45ZcFnNYSv/eN0xvk5/9mv/Yy
 UIbQSr3xMK06Fc5KmINtybJdbSxxui+6ItQnGejmAk2IOj+yX+b3IQSKa0xFqZJrS9mB7ne
 10ZKjvBO51BBPXWYy6EQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:S08u5k6I3tw=:ipAVjeI3qLFwRgppQQR+uO
 JkcBqYsgIvsDP9ZvQwagtf9fLrLKnoUMJt7gKkbFHFpRl+LmtZ+QKOw5ltutyVaqYZVG9T099
 WXosd7X9mYxPgDLSdtckYfoFxL82BTw5EK+qHv2QMVFei+rcxuAaDLvZHaeSK7TqpxxmR17SN
 3fVqDvG3Y6RRzWE+A5cUdZ+bmHgSyY5YZ6IVeV/gVU3/bA2SFS/O912JLneH85psnshJPU7TU
 0dkgxw4I1pyzCLUn567dpGVZe2cXY/ScgeJWCHOmawMQGrlaHF079ACNaQR33Aj5RFFIVgyIv
 1QCrtK6OgZHUnehgZN48khqUuL+if63XwncwLasEiuPi6EBfM/nA7UjFrN1CTt73kWir6Lmcl
 oDiLskSCW0jba+Ky1uSuz1nYGiPtrjAkc4zgI8v303p4hjZLyWPddRCIYj4yga7p8Lz4n+xYW
 BRU938WY3dTHgpjr7EWXlhyAQG7sSUSQd/CbwP8eGLV8pCADxMEtCB2mVb+xzV4dF0HSisXJs
 Qp7kVjj329Ps8awfvARuLnjw2rkxZ1aaWh4+6mKKsQ+y1W4eOeAFig7f3vj1yKCCAnInjRwjE
 JzGOo7xBdCeUftXxsJAgyhbm0IuMI8JiZeSz0P+0ZlmBWH7LAhDOW+1OuB0+LwJQwSS+fYvUB
 C5kdB8aIjNf7kXQ40wmAdE3mHikfYxXsfSmJzH53M/+vQXAte589qiHlftynzLzRRoSlyH69G
 4JaJmpiyTp7V2l93V8Ug3dWdl8BRvCjHwBecfGdsU/ZUQcgxEIHs8NvdnZxeh3nMVoRfK22/4
 lyxcaYaF70yPZjL8vR+PaXzQTCmT7rgQI2KQLvyaZ1VWjQmD954IHpDHm0wbovd153PhgxpoY
 0zN5/t+YmyTkAtlJbVvAfchgJxKjHRins8+g9dEuE=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 01/10/2019 à 12:34, Peter Maydell a écrit :
> On Mon, 30 Sep 2019 at 22:01, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 9/30/19 12:29 PM, Richard Henderson wrote:
>>> This is a workaround for a ppc64le host kernel bug.
> 
>>> However, the host kernel has supplied si_code == SEGV_MAPERR,
>>> which is obviously incorrect.
> 
>> It is disappointing about the kernel bug.  But since this affects Centos 7,
>> which is what *all* of the gcc compile farm ppc64 machines use, I think we need
>> to work around it somehow.
> 
> We knew about the ppc kernel bug in 2018:
> https://lists.gnu.org/archive/html/qemu-devel/2018-03/msg06049.html
> and the decision at that time was to say "kernel bug, update your
> kernel" :-)

Is it possible to update the farm to Centos 8?

Or as the kernel involved is specifically for POWER9, is it possible to
use only POWER8?

Thanks,
Laurent

