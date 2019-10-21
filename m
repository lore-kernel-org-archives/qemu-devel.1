Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F64BCA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:34:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 594FF20873
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:34:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 594FF20873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMXp8-0006gd-6U
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:34:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iMXjy-000300-0Y
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iMXjw-0004TS-Pk
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:53 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:34515)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1iMXjw-0004TF-G6
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:28:52 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue011 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MlwJv-1heeDK2RYB-00iykt; Mon, 21 Oct 2019 15:28:41 +0200
Subject: Re: [PATCH v8 8/9] linux-user/strace: Let print_sockaddr() have a
 'last' argument
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20191021114857.20538-1-f4bug@amsat.org>
 <20191021114857.20538-9-f4bug@amsat.org>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <e210a127-6e2b-8f32-01b6-e09c36ba31a4@vivier.eu>
Date: Mon, 21 Oct 2019 15:28:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20191021114857.20538-9-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yOY2KcwYtBtilH9wfIOLu28fwx2wgTZ2kDMRxvZySWUhA9OGuu3
 96boMNhSLR+Z+fBh55uvHb7Q8HKvKVwWySeUJKqZ1xnb6qrYlv1AhddH3y9tCR/6wpPK4/b
 8MTmfXHohz1/KILMxVMLKHSxugv8jbHqmYDlix8uiSRIxWFtTWeaDbEvd3ZyUc74vqHVVTM
 +v6LtriiMGDPFyoFcE8Ng==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b+0CHg9XuTo=:a0ZdVTIMR5RNcUbm2o07xE
 7SBnwaZbdY69mWv6p8WBl9FafBxMnlLaaGSoejW4lnJp87fHhlUwAX+Gvm5dgGj77ucHDJ1iH
 IrMV7+OcMJt703g3anKbPMueeOqbNiz/KXTb8yjVv46M7SuA7634OagZcHeensOGwTH/FZ4JO
 KH1OE18hMMmE7XwknRsby9SDpU4qX7s5t3mUZFg01aW8nU6sjq6EI2pTwfC2xrEwj/ZdhW0aN
 ZmbpWuNx5nETUi0pFuN+B4UkcBHSxyJq4f4n8O/5hOrzkqwdoX8aG0lg8A1mpH8Y9m3wPq0WL
 PUlL2FhbgSTJxChDynpJgAMMbwRISl6OlmlO0LAuhsMvg2uDcqOJ/Ux9gKudtdJ0ubBMQ6rBj
 X46usjEXTrF/qBPbB2HrJ4dpVMtArJAz6BHKfWCLS1SNv1M9KsHMVaO8afghto6ebbAOlx7Dr
 pQIXDBN80AVg4chMfYJdJ3VRQMoUOZllhtKm4xLaxRRXkWDwd0rxEAQwWT75p4fZJaYFQsRUc
 1mVYwdMoSN4YSI2XSuxKyiEdldTeCKRwx8heBSqG6kE+02OmmkzkposeIg+HU/LKzsSN0ocuS
 vnIEyEAl9lIQLWXpA3WjQkunHtjvfyBZ0LcDQXyaN+R7kolbmLq0ef6l5Ggrp3NXLD5S5XCtx
 3+AbchMuqTKd5GSI4h7XyCwuLWJsQxeEOMHfzamZ8YFHvQ1KT0LLFflZG4kkrphqFhWL3RElS
 jW8gE4Xua7saCJK8rVQtXrtoCnxz0jWOQnSagyQZSeRGnIiwemBlrsPmWayg1Sc/0PnEX0HXH
 r/cgtkLj4xCKSI+9xrFkklhKUkDycIQAQTOlytA0l/qn4Mh5YJ7eyOXfK3j6DPqaUpaXBED8n
 1y1SVaX1/8tW42UDeuC6nPOAgzeod62UsD33EKBTE=
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 21/10/2019 à 13:48, Philippe Mathieu-Daudé a écrit :
> If the format is not the syscall last argument, a comma is append.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Reviewed-by: Laurent Vivier <laurent@vivier.eu>
> ---
> v8: do not name prototype arguments
> 
> checkpatch error:
>  ERROR: storage class should be at the beginning of the declaration
>  #10: FILE: linux-user/strace.c:70:
>  +UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
> ---
>  linux-user/strace.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index cd92c77d33..3d4d684450 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -67,7 +67,7 @@ UNUSED static void print_timeval(abi_ulong, int);
>  UNUSED static void print_timezone(abi_ulong, int);
>  UNUSED static void print_number(abi_long, int);
>  UNUSED static void print_signal(abi_ulong, int);
> -UNUSED static void print_sockaddr(abi_ulong addr, abi_long addrlen);
> +UNUSED static void print_sockaddr(abi_ulong, abi_long, int);
>  UNUSED static void print_socket_domain(int domain);
>  UNUSED static void print_socket_type(int type);
>  UNUSED static void print_socket_protocol(int domain, int type, int protocol);
> @@ -336,7 +336,7 @@ static void print_siginfo(const target_siginfo_t *tinfo)
>  }
>  
>  static void
> -print_sockaddr(abi_ulong addr, abi_long addrlen)
> +print_sockaddr(abi_ulong addr, abi_long addrlen, int last)
>  {
>      struct target_sockaddr *sa;
>      int i;
> @@ -418,7 +418,7 @@ print_sockaddr(abi_ulong addr, abi_long addrlen)
>      } else {
>          print_raw_param("0x"TARGET_ABI_FMT_lx, addr, 0);
>      }
> -    gemu_log(", "TARGET_ABI_FMT_ld, addrlen);
> +    gemu_log(", "TARGET_ABI_FMT_ld"%s", addrlen, get_comma(last));
>  }
>  
>  static void
> @@ -1751,7 +1751,7 @@ static void do_print_sockaddr(const char *name, abi_long arg1)
>  
>      gemu_log("%s(", name);
>      print_sockfd(sockfd, 0);
> -    print_sockaddr(addr, addrlen);
> +    print_sockaddr(addr, addrlen, 0);
>      gemu_log(")");
>  }
>  
> @@ -1821,7 +1821,7 @@ static void do_print_msgaddr(const char *name, abi_long arg1)
>      print_buf(msg, len, 0);
>      print_raw_param(TARGET_ABI_FMT_ld, len, 0);
>      print_flags(msg_flags, flags, 0);
> -    print_sockaddr(addr, addrlen);
> +    print_sockaddr(addr, addrlen, 0);
>      gemu_log(")");
>  }
>  
> 

Applied to my linux-user branch.

Thanks,
Laurent

