Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E50C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0CCDC2332A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 09:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0CCDC2332A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0MZ2-0002d4-4j
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 05:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59774)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0MSE-0001cM-UE
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:58:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0MSD-0006gN-Rr
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 04:58:54 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:37111)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0MSD-0006fh-J6; Wed, 21 Aug 2019 04:58:53 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MdwRi-1iZ8hm3l3e-00b3Yi; Wed, 21 Aug 2019 10:58:45 +0200
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190719131425.10835-1-philmd@redhat.com>
 <20190719131425.10835-7-philmd@redhat.com>
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
Message-ID: <1caf10c7-21cc-4a42-8529-c85d99fbdf63@vivier.eu>
Date: Wed, 21 Aug 2019 10:58:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190719131425.10835-7-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:b9dwMaRGJLov6JL+qmefz/mmNLNIaPNM88CP5ZmKH53I9dHyiQb
 2ts4vsVkFMjV1hC6L7KHknaFrSSOTXjpQft5z3Dut1reI+Ic2Ymyd4ZjsbNujbEuZGaG5n6
 dkZiBleuzKZ6y4xny3OyeGizMznmlmqUlG1SSm3XMEYTtT7To+i64Yig+Ty+r8hepmKEvNx
 X3atShzWbv+Y0wh1Ap6pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:P8x7mnaMoyI=:+w80Tyo5YDIWjn3hPwXbPv
 oMCbAjnMHD8cfwmYIRmlT0pC2eHNDqUeseu5+XV77iK8g3tza1kdFcVGhbc5Y4r4HLNHVOxSM
 A9D/kMQOJACky4IsiPN2EjIgK6NvpkisA3oDvZRnl6EKbxknLvPOv5OnEt+Fpx5UMzhRdoj1D
 FMtMR1BE7RvIF3NIFgwE+ilzVNLzWaivjYT8R6JYdQffhWBgPP5xMTHQU285rPNiTjnnwjBzG
 KRMdrjSIW2NtKg6ooZACyHfUzJAAz5tEyqfijqAUSnxkhCOl8l7YzVdvsXfcat6i44al65vyz
 j0IILrxpLHdHP83DLrcR9I0T8Nu4BOALn9UECrZFECevzQbVfoTpObvzBDIXN3JjGnCMavO9H
 3YCKu1AYr+6m++g1vaFxywnilJ5VKhj/3/aqnW0OGgySMZhY8vxymkrZqCHKJPsneO7Kd+afM
 JEUpVx42EdguC4oxWztlmF/VJ4Yhic+maiKPjhTJMlCEgbDBTFOEBbIClYxsUzW/PyWJsEhec
 sC7/rowYENeeW3xiJ67A5ZzkFcEPQ/+DKz4+hDqTDIgq2V4cK4Yyh5n6ZmbqsyAbSpPjnaTki
 ov1oYaM5fDYLkOFUvukMBvQDrcSGLAgAbOWSejkKznja6D9Vu0LslnRm/6IOHRl4T94rpuASu
 oZIJKEj520whrcYr3qrrWgRjvSRD18+FuvLOTu6kBvxydenLUH5NoJjiKj1Bt45IKVFWIo9Qy
 DCksaI1xJbbLmKXnHBg853YimzswlwTdsdwJTNlGMNlV56HmmfZ6A+Rk7Qg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.133
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH-for-4.1? 6/7] vl: Rewrite a
 fall through comment
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Corey Minyard <minyard@acm.org>,
 qemu-trivial@nongnu.org, Stefan Weil <sw@weilnetz.de>,
 Michael Tokarev <mjt@tls.msk.ru>, Markus Armbruster <armbru@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/07/2019 à 15:14, Philippe Mathieu-Daudé a écrit :
> GCC9 is confused by this comment when building with CFLAG
> -Wimplicit-fallthrough=2:
> 
>   vl.c: In function ‘qemu_ref_timedate’:
>   vl.c:773:15: error: this statement may fall through [-Werror=implicit-fallthrough=]
>     773 |         value -= rtc_realtime_clock_offset;
>         |         ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   vl.c:775:5: note: here
>     775 |     case QEMU_CLOCK_VIRTUAL:
>         |     ^~~~
>   cc1: all warnings being treated as errors
> 
> Rewrite the comment using 'fall through' which is recognized by
> GCC and static analyzers.
> 
> Reported-by: Stefan Weil <sw@weilnetz.de>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  vl.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/vl.c b/vl.c
> index a5808f9a02..f5cf71e3b4 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -771,7 +771,7 @@ static time_t qemu_ref_timedate(QEMUClockType clock)
>      switch (clock) {
>      case QEMU_CLOCK_REALTIME:
>          value -= rtc_realtime_clock_offset;
> -        /* no break */
> +        /* fall through */
>      case QEMU_CLOCK_VIRTUAL:
>          value += rtc_ref_start_datetime;
>          break;
> 

Applied to my trivial-patches branch.

Thanks,
Laurent

