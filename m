Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABF70C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75CC320663
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 21:07:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75CC320663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54696 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfWBb-0003WK-QN
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 17:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42847)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <laurent@vivier.eu>) id 1hfW8r-0002Q5-Cs
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:04:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1hfW8o-00016m-HY
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:04:45 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:43243)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1hfW8k-0000zj-Fj
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 17:04:39 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MTigN-1i8yIC3DYL-00U59v; Mon, 24 Jun 2019 23:04:21 +0200
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>, qemu-devel@nongnu.org
References: <1560953834-29584-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1560953834-29584-2-git-send-email-aleksandar.markovic@rt-rk.com>
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
Message-ID: <dbe26986-06b8-1ade-02f9-cfc11c6f2453@vivier.eu>
Date: Mon, 24 Jun 2019 23:04:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1560953834-29584-2-git-send-email-aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:1aKfpTDFhnVqbCNmeLcFoH8sRbiNn62kIclvdzeMbON8AobLBhv
 GdDDogM0ZLnwDJcoFUeu3XRD/zsEByx5G4dzLDIykJXQRO8Ybrm9ToC/bT4WI3bOsN9HL5g
 bRViTxyh9yY233AwybNoFv9+oW883V86tdU81Xpiau/rqp+Dxr7IatQ6zKzGLsI9p2nrGl3
 u5qxLQ7A4OvsQprMhwJbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:a573rju1kdY=:CZNddQHR0FmHZPXIwzzQwP
 IJ1l1zY+d4xTu1RQLVDoW5dGlMc03hA1EUhuvDpAx38ZKR4NkuezOll17TNbUi98Tp2E5isRW
 7/3JYSHZ0Nj6+8yKbhwzQOEwea6Pe0zHAHdvukxb4dTD85TBZuWCLaKPou3hejG4a0sc8/If+
 RfIHvIFWH+48+zMPzlj34Muq9HvZoE0nD5DkDZH7793MaUIVg2qFFOAwcIr7uMa1k+m6WEm/U
 oCaOu/Zb8El+mEw6rGJJ0Sg5bsk4N56ioNwWfGvhvhYuUoelxweJDwGOlg2GLJEUqg2KP64nH
 ye3hJnfsX62VqOv4lFvb6cTrfKNN4iRr9nnaBS3ZzZ6n6ZLjOkRGLCJ4YitTVrmW1kr4ddgo2
 DXw9B0YTyrKjTkLr3hr6ePW2z3CX8SBscRh4Xpl6efbpl9xvFoNdFU/iC3g7fCkwhSx8ui5PP
 vDCdkZ+IpfRaoUtOmE3tLYvePZIDbO5q7JIyf0hwVkQ46E2qprXBioO0pTSNLk/fZZUESU1XL
 JLTsLPWF7l72z3obX3bRAxDk/UAXvayxupXFsAnnfA183j5mMiALS8Nfv7/uOZJ/ZONEpW+kl
 IEcfDgHISlR1J+RO96MUFSndl8TYSbfrFzqDlRlohv1C3Wc/Sr79MN//VCK/cy11MFtNjI40y
 eNQuhRGko3CNVaGjT5gpAG2fq2UV9fkNYZKjB6b1ZKU8sYI+FgWIjvQfmZlsP9V3Ua92FLBF0
 WlY5CWD4YwV3ZNZtFO64bD4DuDAbBecpt2UMNTRlXLO52GxqHhkBHTq8gI0=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.13
Subject: Re: [Qemu-devel] [PATCH v12 1/5] linux-user: Add support for
 setsockopt() options IPV6_<ADD|DROP>_MEMBERSHIP
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
Cc: Neng Chen <nchen@wavecomp.com>, amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 19/06/2019 à 16:17, Aleksandar Markovic a écrit :
> From: Neng Chen <nchen@wavecomp.com>
> 
> Add support for the option IPV6_<ADD|DROP>_MEMBERSHIP of the syscall
> setsockopt(). This option controls membership in multicast groups.
> Argument is a pointer to a struct ipv6_mreq.
> 
> The glibc <netinet/in.h> header defines the ipv6_mreq structure,
> which includes the following members:
> 
>   struct in6_addr  ipv6mr_multiaddr;
>   unsigned int     ipv6mr_interface;
> 
> Whereas the kernel in its <linux/in6.h> header defines following
> members of the same structure:
> 
>   struct in6_addr  ipv6mr_multiaddr;
>   int              ipv6mr_ifindex;
> 
> POSIX defines ipv6mr_interface [1].
> 
> __UAPI_DEF_IVP6_MREQ appears in kernel headers with v3.12:
> 
>   cfd280c91253 net: sync some IP headers with glibc
> 
> Without __UAPI_DEF_IVP6_MREQ, kernel defines ipv6mr_ifindex, and
> this is explained in cfd280c91253:
> 
>   "If you include the kernel headers first you get those,
>   and if you include the glibc headers first you get those,
>   and the following patch arranges a coordination and
>   synchronization between the two."
> 
> So before 3.12, a program can't include both <netinet/in.h> and
> <linux/in6.h>.
> 
> In linux-user/syscall.c, we only include <netinet/in.h> (glibc) and
> not <linux/in6.h> (kernel headers), so ipv6mr_interface is the one
> to use.
> 
> [1] http://pubs.opengroup.org/onlinepubs/009695399/basedefs/netinet/in.h.html
> 
> Signed-off-by: Neng Chen <nchen@wavecomp.com>
> Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
> ---
>  linux-user/syscall.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index b187c12..f267ad0 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -1920,6 +1920,25 @@ static abi_long do_setsockopt(int sockfd, int level, int optname,
>                                         &pki, sizeof(pki)));
>              break;
>          }
> +        case IPV6_ADD_MEMBERSHIP:
> +        case IPV6_DROP_MEMBERSHIP:
> +        {
> +            struct ipv6_mreq ipv6mreq;
> +
> +            if (optlen < sizeof(ipv6mreq)) {
> +                return -TARGET_EINVAL;
> +            }
> +
> +            if (copy_from_user(&ipv6mreq, optval_addr, sizeof(ipv6mreq))) {
> +                return -TARGET_EFAULT;
> +            }
> +
> +            ipv6mreq.ipv6mr_interface = tswap32(ipv6mreq.ipv6mr_interface);
> +
> +            ret = get_errno(setsockopt(sockfd, level, optname,
> +                                       &ipv6mreq, sizeof(ipv6mreq)));
> +            break;
> +        }
>          default:
>              goto unimplemented;
>          }
> 

Applied to my linux-user branch.

Thanks,
Laurent

