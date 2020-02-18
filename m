Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE35EC34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:20:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5E6C20801
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 19:20:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5E6C20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j48QQ-0002cM-VV
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 14:20:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36869)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1j48Ov-0000ty-Kz
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1j48Ou-00014g-FH
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 14:19:21 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:54617)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1j48Ou-00012M-2U; Tue, 18 Feb 2020 14:19:20 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MAchM-1jAgu30sYK-00B1iK; Tue, 18 Feb 2020 20:19:15 +0100
Subject: Re: [PATCH] hw/net/rocker: Report unimplemented feature with
 qemu_log_mask(UNIMP)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200217101637.27558-1-philmd@redhat.com>
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
Message-ID: <717af333-5c4b-1316-60f0-77c68e6c4e68@vivier.eu>
Date: Tue, 18 Feb 2020 20:19:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217101637.27558-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:nuNpeY9gq75ylCN9gJNR/wBGDK9aFGlxdT+nU+WB/rlNcnOFByd
 cFU3FKsRcOcwIRPWjC2Hmwu1BNce833FWg8R7UppaJADvx1MXUCtbi2dVJJ7pYGnvurtaQZ
 SwQ9W5E8xl0V372jILEvavKhvBSm4FVZI+3Alh2TSm9tUcghqWcmoD8AE3abhYKcthScV9e
 c/ffjNETlJfH11l4bxTgg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:N9MEMTmWfOI=:CreDNS0PvnO7TRjueQdso+
 zUGGtvmQOhBxVE2C3Kte2WfInCPePRPDPknzg4vd647T7l2iZRgaQw4m0px8nNkl0JUuS5zD5
 mxUHLcds2or/rIcnCoNZ4z16wlDX+lXB/w6ZLkjZW0k+FK6fnm7PA47+7qcdOEP9SzX1WppKv
 J79BH6G7f3IfCp+71P3mag025tDW6D3sRIssxNtHEddllAiy9zK8wEUvbdtlqiMuhs/1tLNXo
 cht9jimWJEYBwt5loEyslDGnDRVX7y9m5RJFREHytSBhLsgV1skXcrUR3pVe2Loc7IyPGZz4F
 8TkgncpBJRLr8tOTvQoEaVngN8v52WcEIAKV8rXrrdsQaZVU1hoMDIEbMvx4L2TeHznuDE9sa
 1x7/1zId0z/Qd531n1ibi502ubTc22sT1vNYfmQ8KDf5Mjp7jzF43gPgpY5ff9xpzgoi29848
 Bhwk9nMKw73C7vU/P8j5epksIUwEI63pZ/KmM04Ppmp/dOopT4H2fO4n0aY5Ryx+i8qrnVpck
 p8nkmXPp0zfNtV06ADD2gq1NpKR234ecvn9h7daXSojLy4iY2NtApe4A67kS+WyaELtaUNGHf
 vhMFLN0yGr7sxxdPIaO9Bu3GXsKnljaN0oUcNtjWdLUwVXgeS+NzbRTbjs5gIskQXjlmpeT0n
 rcLI5NtYMHnNeDd+QEikAgBrprtToqdFRlBe01tVTeifuu14qkEJu0wfI1GHoYfL65Epng0H0
 1vqhNFPJdFjdQ7G8uaOlVck4lItRRV/v80Aj478tHzS8n9syIhiKrfMzfiSdHcMoiPAPUv8v9
 8/fmiXR/kGatTCfFWl40WbU9tll7SsHrJGt9RQluoHhWXG5K1SgHlBaY6jFRQU1uymJPAzq
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: qemu-trivial@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Jiri Pirko <jiri@resnulli.us>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 17/02/2020 à 11:16, Philippe Mathieu-Daudé a écrit :
> Fix warnings reported by Clang static code analyzer:
> 
>     CC      hw/net/rocker/rocker.o
>   hw/net/rocker/rocker.c:213:9: warning: Value stored to 'tx_tso_mss' is never read
>           tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
>           ^            ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/net/rocker/rocker.c:217:9: warning: Value stored to 'tx_tso_hdr_len' is never read
>           tx_tso_hdr_len = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]);
>           ^                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   hw/net/rocker/rocker.c:255:9: warning: Value stored to 'tx_l3_csum_off' is never read
>           tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
>           ^                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> Fixes: dc488f888
> Reported-by: Clang Static Analyzer
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/net/rocker/rocker.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
> index 81dd3b5f14..15d66f6cbc 100644
> --- a/hw/net/rocker/rocker.c
> +++ b/hw/net/rocker/rocker.c
> @@ -27,6 +27,7 @@
>  #include "qemu/iov.h"
>  #include "qemu/module.h"
>  #include "qemu/bitops.h"
> +#include "qemu/log.h"
>  
>  #include "rocker.h"
>  #include "rocker_hw.h"
> @@ -207,14 +208,22 @@ static int tx_consume(Rocker *r, DescInfo *info)
>  
>      if (tlvs[ROCKER_TLV_TX_L3_CSUM_OFF]) {
>          tx_l3_csum_off = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_L3_CSUM_OFF]);
> +        qemu_log_mask(LOG_UNIMP, "rocker %s: L3 not implemented"
> +                                 " (cksum off: %u)\n",
> +                      __func__, tx_l3_csum_off);
>      }
>  
>      if (tlvs[ROCKER_TLV_TX_TSO_MSS]) {
>          tx_tso_mss = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_MSS]);
> +        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented (MSS: %u)\n",
> +                      __func__, tx_tso_mss);
>      }
>  
>      if (tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]) {
>          tx_tso_hdr_len = rocker_tlv_get_le16(tlvs[ROCKER_TLV_TX_TSO_HDR_LEN]);
> +        qemu_log_mask(LOG_UNIMP, "rocker %s: TSO not implemented"
> +                                 " (hdr length: %u)\n",
> +                      __func__, tx_tso_hdr_len);
>      }
>  
>      rocker_tlv_for_each_nested(tlv_frag, tlvs[ROCKER_TLV_TX_FRAGS], rem) {
> @@ -249,12 +258,6 @@ static int tx_consume(Rocker *r, DescInfo *info)
>          iovcnt++;
>      }
>  
> -    if (iovcnt) {
> -        /* XXX perform Tx offloads */
> -        /* XXX   silence compiler for now */
> -        tx_l3_csum_off += tx_tso_mss = tx_tso_hdr_len = 0;
> -    }
> -
>      err = fp_port_eg(r->fp_port[port], iov, iovcnt);
>  
>  err_too_many_frags:
> 

Applied to my trivial-patches branch.

Thanks,
Laurent


