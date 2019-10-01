Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FF69C352AA
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:52:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13E182168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 15:52:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13E182168B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFKSI-0006ev-5b
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 11:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47107)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iFK8O-00036R-VB
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:32:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iFK8N-0002CQ-N5
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:32:16 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:52447)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iFK8N-0002AY-BJ
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 11:32:15 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MKMIR-1iZLHg0th9-00LoPc; Tue, 01 Oct 2019 17:31:55 +0200
Subject: Re: [PATCH v2 2/3] tests/migration: fix a typo in comment
To: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>, qemu-devel@nongnu.org
References: <cover.1568170994.git.maozhongyi@cmss.chinamobile.com>
 <c60e8741dec930089b42ebb83b0ff15f2270078a.1568170994.git.maozhongyi@cmss.chinamobile.com>
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
Message-ID: <10eeaadf-4e5e-887b-3204-ba74349b1b00@vivier.eu>
Date: Tue, 1 Oct 2019 17:31:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <c60e8741dec930089b42ebb83b0ff15f2270078a.1568170994.git.maozhongyi@cmss.chinamobile.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VNq16pGmBrURd2H05rRu6u91fXQjYB4WYOOoSEZc+8di3ucXZN2
 ru8GgcInk5shkbFXkXYA7t1YdnXg+ga7wliNUrwJ+COuM2aJJ6hEuwzxyU8zR3odo5VKa2u
 bl4sS0Cu3hI2yNa64pTcx9H6toFiNocpzewIjbt9VyoqD/EtfyNZ71YP8v5066TcntxsCH/
 6yxGPWUY3XrQIr3Xfu4cw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Xi9zPxX95NQ=:eKPbZQhf7+/zIKVO0J9U2O
 1Mw2jFZuP4/l2zVTfbmjmGo950YFQGiUo362H/0sM/vNBqxgjj2D9SdEYMwYRuvQVs+KD2wBM
 IcEX1dJo0TbXZARmgKhSSEv1SKODp+juTHuFf7O9arLnS9yn7qU9e29A6lWGTS1S2cu4sQvP2
 MURKbIqe6gVln8dvWUHyOI2JrlCkWmIlcCRtFeoquz2bz8y79A7/KSH76jLqfNjExZzg33SsL
 p1UZAX3TXaTpowPQ/ifh1rxFlfsxUetufEyd7CgWMk4SIYKLgD5Rdw0IoRithWV1sjMr716/n
 THaRhvlr/t0mIk80UdVzn/XnFUpg5O4iXyVtlbSScNVrj3khvjQQmycvniSBTG3dLdb5NHJPV
 4rgJpoCMA/0yeaqBzSBi3CS0x6EK+tL+gars3t9uxAuZwZeJ8C0BO/V3ht0qPI95se36A8txL
 QUU+CkYMM8U/2K7jDvLNIClLsdOBk5SpjHExazHlcRajBrp9EolcfBceQJWOkGAWOIcQwoVhV
 ilRi8WS4jzunjJG9B7kLac2chwWo+Ku+rEpOR41RTpZoKBCBASpzvNegt7n5FZk9FQluJ/Nkx
 YktPkxKSl2xoEhg52ljSHwvsihS12pn1PHwhYedVo8/6dTc6eBsX0xNPQyGylOZypKyGflJyo
 saUZVq3TFydg3isGlx4yiYwdobKWUeyzdTPunbroWPtclSYydYUrJZjGvZ7KcOMaRQLrrvAkA
 CxbXuTdxF7b/gtAUZjtloiRVzvAgPDRD9FYzPS0BkpPOp9151vTAWMzBmHHLlu+TZnwMwUU0/
 oO0ysxRixy4zNCZCn63JFZo2bVGu8TmiKruV1fm/7q5TVxXPvcFrFKaKcQ9iV7o1fHzwhAx89
 +XODB5dz878vn12DGYqECyzjp91xfDP7OoaAsymyY=
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
Cc: tony.nguyen@bt.com, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 11/09/2019 à 05:31, Mao Zhongyi a écrit :
> Cc: armbru@redhat.com
> Cc: laurent@vivier.eu
> Cc: tony.nguyen@bt.com
> 
> Signed-off-by: Mao Zhongyi <maozhongyi@cmss.chinamobile.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/migration/stress.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/migration/stress.c b/tests/migration/stress.c
> index 6cbb2d49d3..19a6eff5fd 100644
> --- a/tests/migration/stress.c
> +++ b/tests/migration/stress.c
> @@ -191,7 +191,7 @@ static int stressone(unsigned long long ramsizeMB)
>  
>      /* We don't care about initial state, but we do want
>       * to fault it all into RAM, otherwise the first iter
> -     * of the loop below will be quite slow. We cna't use
> +     * of the loop below will be quite slow. We can't use
>       * 0x0 as the byte as gcc optimizes that away into a
>       * calloc instead :-) */
>      memset(ram, 0xfe, ramsizeMB * 1024 * 1024);
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

