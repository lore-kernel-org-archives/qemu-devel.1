Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CFCA9EB5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:52:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 887972070B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 09:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 887972070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36822 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMUMS-0005nQ-Gn
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 05:52:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMULc-0004w1-97
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMULb-0004T9-2p
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:32 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:56577)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMULa-0004SX-Pu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 05:51:31 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MLAAs-1ieZC11EXK-00IC8R; Mon, 21 Oct 2019 11:51:19 +0200
Subject: Re: [PATCH v7 6/9] linux-user/strace: Add print_sockfd()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20190915213924.22223-1-f4bug@amsat.org>
 <20190915213924.22223-7-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <8dec9333-5686-5d76-53e0-99c3e35a7050@vivier.eu>
Date: Mon, 21 Oct 2019 11:51:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20190915213924.22223-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:RuraaP+UYonMBL8TJn9lr3Dz7HoeMm5q1HEBIudMBaNjKXLYuAZ
 Ka46onOA9O34LB4hijVt0iP9YIqWEpoa2phLjSgrXNcDPLZXDc4IEPvjXKo7SBCbS0l/9dQ
 Q5yYHtZFdxQbpUqqkIR+6/ehDoNkribEFOTV6zisB57X00z/hg7Dlr+ZU8s7T58Eh2aYfHF
 eVjgUQjLv5PI5IxMzJGvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DurKzIkfttU=:nv251RUKWJ75Ww5w4HXN+d
 hi5sQKA3HzxV9g/T76GIuiDCuiKgGvWnjGUfckeliQ+6Kg0FPdlJRDnq34VEJvG2hFUNVBF1V
 2AilpdcxBV69t1Ec0w5zHFEJb9kl+Ehft0IU2O2cQJ3TgY8TC+zWLuKt+kzN+SvCIJgIZNAMy
 cBQccH86PV3+R+N71x1QqJX/k9oGuDikv4q9Cx+mk7K5lRjwqpHW56Vv5jPQJox15TqHb3vt7
 wLSdplr64l287v7pVM3ODGkLAa9wTRDTlwC77Yr3OA0q9iO4wT+oMUexRZp+De+ZqydnXYtPD
 Ptxp8OZenfCMK+CL9VJLf2kqh1N2Q+iCkNd7dcffo3vavQjOyF0e032F2oM9vkn4LHAFj6CT7
 TyOHuiaSxQe6oZnBI5DOVLMO/PPJNH9RejqZUD1N6E5KXbM6wqxACC6jtnYwGlnCUtPXvn3kU
 io3DfE6BEiWeIBCTPTZudvS/U+aItWPr04UJ+w0kiLiTeaUNgdN/yXRypY1zULJsRNC12k0V4
 DHkGFphv0h/jUUkfUJJ8dZVXg93w2IP77Ww0zizl2E8993PQ1xj4Ke/C/BIY1vl0XOLqTka9q
 xHqPQbfo4tRuyFdGHiE/5Hxsc6BF1vIhKT9B/9egWx2YJSRkMvDHV+MClgq71NttA1alRFw7B
 sYep/0q/btgv1HdcqK+QrX7gsUPMJwImz3DZh/O0R1Y+o39Klewg0MLLhs9bTVpjMXZ8RddW4
 oxu1wThpZQH06ncJ2KoL5cZxMYzdk4vt47xfLcr0SKw3rtLjnYOH58cjrNrDIHftOzoE7GXY1
 2NfMENADmloWauRszD8D9jLvaqb/0Wi3shBl2basM6l4cG8MEa7H9xkm5mZFIKkf9OdL/IQDE
 pETcpkY9PuVQFADIuPuqpTazKLkJrV4o7Bmn1ZgPs=
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

Le 15/09/2019 à 23:39, Philippe Mathieu-Daudé a écrit :
> Extract common print_sockfd() from various socket related syscalls.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
> v6: use another ifdef TARGET_NR_socketcall
> ---
>  linux-user/strace.c | 23 ++++++++++++++++-------
>  1 file changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 22dd453d26..01c802c4e3 100644
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

Reviewed-by: Laurent Vivier <laurent@vivier.eu>


