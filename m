Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6942C49EAB
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:47:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F4DF20869
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 09:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F4DF20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRvQu-0001Jy-GM
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 04:47:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49753)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iRvPN-0000KO-8W
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:45:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iRvPM-0005cC-3X
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:45:53 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:53087)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iRvPL-0005bk-Qk
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 04:45:52 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1Mj8a5-1hy6RD3p3d-00fF0f; Tue, 05 Nov 2019 10:45:47 +0100
Subject: Re: [PATCH v2 03/12] target/sparc: Define an enumeration for
 accessing env->regwptr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20191025113921.9412-1-richard.henderson@linaro.org>
 <20191025113921.9412-4-richard.henderson@linaro.org>
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
Message-ID: <551d9156-0217-9468-3c9c-9ade78ebe872@vivier.eu>
Date: Tue, 5 Nov 2019 10:45:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191025113921.9412-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:ZetPxgALX13+OwsFvNzKPvbI9kxocjcf7cqTTPENtjqdd+6k7uA
 yN3h41JuWVYO5jG6rOr0mgRz72YMEKsk2V7lE25/KdYZKEiNBWhoYcSnYe8wPGCOpweb2ZG
 9EkWHTyQTGyGnsyV7d9BnUwh4IhgwkSwaUVoh/IAdni8YwpgvYO04WhU8+N2Mv5myT+e2Vt
 qAnp0BOiBe8Jg0Xazj47Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:eK6evf3PSeM=:lM5FYv5hreMhaANwwWNRo6
 cwOWcfi9Uv5NMM4iJxtm/zzXEvR3KoJ+Ohj0dpIP3cDHAKfmDO8BhSL4QpmGCpUajK/jsZ4H4
 PLCBOTOqSOPR7dX2U825ucHbXkrA4joj7SedoFgdlKmvmvj8aBNIEgaR0n/oU6R1qUZL/Qr9l
 wTbVlRRjpVtL+MHA7UNG5Zeh8QiyTWW83IsovctNC8i/X1023D+ARS2mKFMyKxFVpc5oT3SJe
 mk167X6g/IN0LVj+b+xe1M4eYR5ex71uSFGbwCQsqVU/l+1fFs3jPSZgKEfhTs/RU1Oa2cKbS
 lgLtWu6Cz2dBccNLg/LCAUvN2ahF3+GAjqZ4AFaIoFdzFM3nu9Kz323cK9i7CCeEIuNlftXlR
 Ckc4k8NxHwh8nhffwhbwU8F9q7IqNVdbzQx5hiGE/DbkNl1uac2j42vXMQkK9Zd8aw4L3Sben
 wQy0rNMou0G4Fb1Y2fUzrejRaNtG/5/iNZNP/zjtaRqw1OI1QnNjYjm88uVCn18ybEhyxRhtz
 Osb6IChs7HDZMsj55+Pckak3LGybvGcrbT4WWC/4O9Hu7H3gJK8hrBA3bjoFkTMDhGQMzfgkt
 1liSHixwXAtaQiL2X83paDLDng9szBrarqHdwRWXdiB5hpyFN1JzJTTF3DNogVuGv16QPdkJ1
 pi5GSic379gkGStJJqyTd3pWALXJACqLeBK9ECBnktIhPMi11PNUlvW6n7HnGk3A8r7ukVTMI
 9KBePsRZzv833jgxgHWyXHE6+6pjypHi47XIFkKHYhJxcoJY3iy5zpZ5hfNBh+buwn0uUFCCF
 vCWTQSyngyjApE688Wy7/s2lhjFjWib7OzuKQHbg6pcrhns5g41GOdDI2kNCfUOnzQD7pnZk4
 Ya4yXB8rzlEqLjIT1vbR8lHBpQ73SOLAdb66DvcbA=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 25/10/2019 à 13:39, Richard Henderson a écrit :
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/sparc/cpu.h | 33 +++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
> 
> diff --git a/target/sparc/cpu.h b/target/sparc/cpu.h
> index 778aa8e073..ae97c7d9f7 100644
> --- a/target/sparc/cpu.h
> +++ b/target/sparc/cpu.h
> @@ -13,6 +13,39 @@
>  
>  /*#define EXCP_INTERRUPT 0x100*/
>  
> +/* Windowed register indexes.  */
> +enum {
> +    WREG_O0,
> +    WREG_O1,
> +    WREG_O2,
> +    WREG_O3,
> +    WREG_O4,
> +    WREG_O5,
> +    WREG_O6,
> +    WREG_O7,
> +
> +    WREG_L0,
> +    WREG_L1,
> +    WREG_L2,
> +    WREG_L3,
> +    WREG_L4,
> +    WREG_L5,
> +    WREG_L6,
> +    WREG_L7,
> +
> +    WREG_I0,
> +    WREG_I1,
> +    WREG_I2,
> +    WREG_I3,
> +    WREG_I4,
> +    WREG_I5,
> +    WREG_I6,
> +    WREG_I7,
> +
> +    WREG_SP = WREG_O6,
> +    WREG_FP = WREG_I6,
> +};
> +
>  /* trap definitions */
>  #ifndef TARGET_SPARC64
>  #define TT_TFAULT   0x01
> 

Applied to my linux-user branch.

Thanks,
Laurent

