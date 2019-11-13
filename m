Return-Path: <SRS0=QD06=ZF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E87BFC432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:06:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D304120409
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Nov 2019 17:06:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D304120409
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUw6P-0004id-TX
	for qemu-devel@archiver.kernel.org; Wed, 13 Nov 2019 12:06:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47532)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iUw3C-0001wW-GK
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:03:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iUw3B-0007mm-Ft
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:03:26 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:48967)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iUw3B-0007ky-6r
 for qemu-devel@nongnu.org; Wed, 13 Nov 2019 12:03:25 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MuV3i-1hetQN2yG2-00rXuw; Wed, 13 Nov 2019 18:03:09 +0100
To: Filip Bozuta <Filip.Bozuta@rt-rk.com>, qemu-devel@nongnu.org
References: <1573663271-31519-1-git-send-email-Filip.Bozuta@rt-rk.com>
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
Subject: Re: [PATCH for 5.0 0/6] linux-user: Add support for real time clock
 ioctls
Message-ID: <8cb29095-b4cc-5d1c-df30-93fd2fbd4c1b@vivier.eu>
Date: Wed, 13 Nov 2019 18:03:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1573663271-31519-1-git-send-email-Filip.Bozuta@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KpucoAeOUL9xUHkxh24NU0PQA8tFxpruSvqF6QWwSK1lLdUS7Nj
 QLoNzsMwm69awz8rHAhuPkcEF4Yy4o0QXwuvXHVtpO6BfEcHeVBuTfm/NBAL1T4sG5IGUzf
 +FTHZ1d3TxpUWwBVfv7XQhDbF71mFpaEnc5ImokzkCchjYOFgolLWq33U6rKnQPJbpnuP0L
 m43GvCjIH4cO+B+M+/jHQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:6CCFugVN4rA=:Gt3ben5aYIM3MOVzJwp3VN
 9lRumzPj6v5WGGggmbxJHGj4G7yXUPNUNkTKDFgIFa4ovn2IvCo6epoZp1BXcEIsRfGNuw/Uv
 Z1txxwTScMz4vVbaxMcoOIMSm59UK+k6E9sDSyQE66JHOZEdaTvbmkkszhkOFosfAe+308E9+
 g6qC9ndnwHctm8VRQaKG69M2hmTWpnbTSDyBrlZ/RJht9E6kQViD9GhPyoNHIfLmYLOi2DFj2
 uCu5K4cukYIUQJsZa94UNrlq31SLTG6yOt1I5ihn3+g7A8FR9NGLvGUVVw8bLB+rrTt/CV3pI
 OwpOk0TWE5kiLqRwzeYq9mEuccKqKPP/V/QEJHeHhcRnnlZakPP0yJgjg+iP51G16+0Rg9FM6
 ayyjrzCqTu8KYpPvpjmSDPl/DuNQ45cofeiAL5M667zO9RvF5vQK8GRnMcoignJUek0T21A5r
 Jju7eFnIV5dFpxqKIL0wyqDbAZwDJhmU/mb2/z81VkM2pj4MrVQ0EJga00yVb7Bht+DF2aEII
 RcgZMn3f2q2h3V+DzmsoSW+e/FGrk+iO4aadnHvrv2rgCIcBLxaj9MyZC6pr4pYrMcHB9BQAb
 7L4PORWqszBbH3kkdHpDyA/ynv4R02z49dTyHDHdTdaNiN7Yg3LFcHxo6u0amBuYuMTf3mGR/
 GP0NBsRrgOGVBWTEmRQ35I4JcY4rQHdBRrDLyj3afxuvDBgpWCEYskDPxvm4ID8SreFOO3IDQ
 1TjPcQaKzj9CBgEmr89USW8zRqOKyUL4+bVG2Lwg4VZUz/DtiFjhBj0ESShiwGe8N4IAA2ZDI
 VOcUWj+10uKn51+Y9MsHYoNqMQI8WmD5jdXz9JDBcw5tTwhRDhgbi0fwnfgsz2VqoxwVzbOXJ
 O+QhT/RO6U7vp260iyaA==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.133
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
Cc: laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Filip,

Le 13/11/2019 à 17:41, Filip Bozuta a écrit :
> Add ioctls for all rtc features that are currently supported in linux kernell.
> 
> Filip Bozuta (6):
>   linux-user: Add support for enabling/disabling rtc features using
>     ioctls
>   linux-user: Add set and read for rtc time and alarm using ioctls
>   linux-user: Add read and set for rtc periodic interrupt and epoch
>     using ioctls
>   linux-user: Add get and set for rtc wakeup alarm using ioctls
>   linux-user: Add get and set for rtc pll correction using ioctls
>   linux-user: Add rtc voltage low detector read and clear using ioctls
> 
>  linux-user/ioctls.h        | 23 +++++++++++++++++++++++
>  linux-user/syscall.c       |  1 +
>  linux-user/syscall_defs.h  | 36 ++++++++++++++++++++++++++++++++++++
>  linux-user/syscall_types.h | 25 +++++++++++++++++++++++++
>  4 files changed, 85 insertions(+)
> 

Could you add in the description of each patch the name the ioctls it
implements, their purpose (you can cut&paste from man(rtc)) and how you
have tested them?

Thanks,
Laurent

