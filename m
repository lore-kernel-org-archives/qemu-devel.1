Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B96CCA9EB9
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 528EB214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:29:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 528EB214AE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41628 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXk6-0002tf-E4
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:29:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38434)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXiY-0001gV-8L
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXiX-0003wn-0v
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:27:26 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:44257)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXiW-0003w7-Nh
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:27:24 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue009 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M597s-1iLRml0kYG-0019UW; Mon, 21 Oct 2019 15:27:19 +0200
Subject: Re: [PATCH v8 6/9] linux-user/strace: Add print_sockfd()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-7-f4bug@amsat.org>
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
Message-ID: <92cc1cf5-98ea-51cc-ac1c-535fa1ecadb9@vivier.eu>
Date: Mon, 21 Oct 2019 15:27:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sDeef4MdxhuBamNDdM4Rfg/2cDDvndpyQ4JOHNknL7YHycXSrI4
 MCU7N36VntzoiZUFWRwgKET3GGiD5MEoblvCFP/jsyiju0mEdw9tt4nW+WwAXVONwHG6aGX
 jg+C8x90lpqOIpwehfyE6grxlHvd6flKs08DPEYLBvEN8rtbSPljdo+OBToRRAZkMPQol4G
 +0jZw7GwR24aGHazH4nnw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:w46G41wCDWw=:zbfMWUIIxDwCU73klNtPFs
 5/Gl73/Tk+3tkbcoBOb9d5CWPylEIKmmVIgcBu4xVAs8PHA6FY6DM85quVKZSXWuDCdMNCQbD
 40JoeO0nCDMQYiWqVeSGbvha0N7Q2yiMTW7AGxaKEWSTL1lxM1BHS7c2ztIntYlsUymj8tnav
 +v8Aa1OienUqEzTJEHdNsA2iXYX7WPgBqnarJ+mJUfWOhQv4LugwY4DxB93K05/KeP+X3Sf+Q
 I+YMUS3OiYDRJ2YYAs2JWq7q1Hn6eePq3yFBfxcGRnawKLAAzT9aHyihQyLkV2ML4Y7PiouB2
 dyTcVmJiapoHITRtVCm/liMUOTLO0OBQhu8JDFtOa/OScff7ZuNa8kcWNvKGTrA7BbzpjJnyI
 zXdTjHmrBzCYDhMQRlB0ddu1DOVKdCWtneo13+/8PelLow1zoQRRsttw4bI1UByKcsJzQssK7
 S8YF+S7PxIa/BAWsIYzNcOQBIm3DAHLOU73B4vUJihvdRIpL58sWcWbSoGEaMXyXXmrlxLCRF
 q7VQmTzlRedYeB4LaKiQtUZM2IIL8TfNZKFG6qdfIjFcIVVuXrod/C5GW9EpCe2+zTRFETipA
 FK5fc4LrRIDDBuwLQZ2GCR0dFJlPo6Nx+XgKXIRSMgCJUKn4kYIaca5z3P+vv/ihZmoqEiQHf
 0Bm1oZ3oD/V20vJ4m/L7dLnX5H+pFsiGNCX8Y19uuvvYx5h4njVHCQGFcTpQlGHJ0Hlwc6VOF
 F9b5Nye6A3otbUDzjghf9I0Pzm3nVqjxTZ2xWLSR6toPX9Mn1b7g5v0rU3B7Y8EFSX3X0YiW/
 r3vSNayBR0Z6VTEiyxYzxWdrfWqx2M4HW2QAxY43QOuBH0omYSX6GiBjANvVLzs4XYe8SAT2Z
 Hpk79rG3oa6ybW12OOFJsNcWKWHukmKPk+/2bCwVM=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> Extract common print_sockfd() from various socket related syscalls.
> 
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v6: use another ifdef TARGET_NR_socketcall
> ---
>  linux-user/strace.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5fa7748427..0ce2b658a5 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1709,6 +1709,15 @@ print_socket(const struct syscallname *name,
>  
>  #if defined(TARGET_NR_socketcall)
>  
> +static void print_sockfd(abi_long sockfd, int last)
> +{
> +    print_raw_param(TARGET_ABI_FMT_ld, sockfd, last);
> +}
> +
> +#endif
> +
> +#if defined(TARGET_NR_socketcall)
> +
>  #define get_user_ualx(x, gaddr, idx) \
>          get_user_ual(x, (gaddr) + (idx) * sizeof(abi_long))
>  
> @@ -1741,7 +1750,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
>      get_user_ualx(addrlen, arg1, 2);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      print_sockaddr(addr, addrlen);
>      gemu_log(")");
>  }
> @@ -1754,7 +1763,7 @@ static void do_print_listen(const char *name, abi_long arg1)
>      get_user_ualx(backlog, arg1, 1);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      print_raw_param(TARGET_ABI_FMT_ld, backlog, 1);
>      gemu_log(")");
>  }
> @@ -1789,7 +1798,7 @@ static void do_print_sendrecv(const char *name, abi_long arg1)
>      get_user_ualx(flags, arg1, 3);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      print_buf(msg, len, 0);
>      print_raw_param(TARGET_ABI_FMT_ld, len, 0);
>      print_flags(msg_flags, flags, 1);
> @@ -1808,7 +1817,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
>      get_user_ualx(addrlen, arg1, 5);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      print_buf(msg, len, 0);
>      print_raw_param(TARGET_ABI_FMT_ld, len, 0);
>      print_flags(msg_flags, flags, 0);
> @@ -1824,7 +1833,7 @@ static void do_print_shutdown(const char *name, abi_long arg1)
>      get_user_ualx(how, arg1, 1);
>  
>      gemu_log("shutdown(");
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      switch (how) {
>      case SHUT_RD:
>          gemu_log("SHUT_RD");
> @@ -1851,7 +1860,7 @@ static void do_print_msg(const char *name, abi_long arg1)
>      get_user_ualx(flags, arg1, 2);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      print_pointer(msg, 0);
>      print_flags(msg_flags, flags, 1);
>      gemu_log(")");
> @@ -1868,7 +1877,7 @@ static void do_print_sockopt(const char *name, abi_long arg1)
>      get_user_ualx(optlen, arg1, 4);
>  
>      gemu_log("%s(", name);
> -    print_raw_param(TARGET_ABI_FMT_ld, sockfd, 0);
> +    print_sockfd(sockfd, 0);
>      switch (level) {
>      case SOL_TCP:
>          gemu_log("SOL_TCP,");
> 

Applied to my linux-user branch.

Thanks,
Laurent

