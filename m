Return-Path: <SRS0=s522=46=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EB07C2BB1D
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:44:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A4A2074E
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2020 21:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A4A2074E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jCs6S-0006ne-EF
	for qemu-devel@archiver.kernel.org; Fri, 13 Mar 2020 17:44:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41512)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1jCs5A-00069h-4Z
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:43:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1jCs58-0002xr-BM
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:43:03 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:56277)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1jCs52-0002ro-Uh
 for qemu-devel@nongnu.org; Fri, 13 Mar 2020 17:43:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MILnm-1j9W2212LU-00ENuO; Fri, 13 Mar 2020 22:42:42 +0100
Subject: Re: [PATCH v2] linux-user: fix socket() strace
To: qemu-devel@nongnu.org
References: <20200312165530.53450-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <c5d806af-e3e7-346d-ebbe-70ca7e5a30bb@vivier.eu>
Date: Fri, 13 Mar 2020 22:42:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200312165530.53450-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:S0g+Rra3bXpaFlx+1cYPmnAcYZk4W2dCjemYLCoubq40RcPNj4S
 g0FibvyDRLMIl3fyqL5TFET62lbzMUUg9tIej1U3v/if9qjBz4SCENshfUcZDJHh4QGHLFa
 TIQpl9Ce5j3EK3qu8VSQMiCE3jTJciKTzFLeo6bxQNYz+kKjkQiohaZcSDWgYvAIVd9khGg
 ZJsOAII4oPFZZSca3Zlqg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:z4tuBubEGB4=:onevCJKrQoyxcCI1Igij3m
 iE980nTCKXLSYanj3P+TsH/dzaMCBRJjnhxi0oTmeioQ9/RHDKMmNACT150FBmGH7PSkvmg2j
 zIj1c7rIeaZSEdvgf1OqKK1EQrjBHTPQ1EaQn4NxoBUmwRgAawo8c+LUQWrclEt1iI7i4qLqQ
 4PmyyyRB2jpxMmLo68+PfVt6h51o0ynEr03O4D9wlILfz/YS+uaSuPaw0qnru2xHvNj+svoZY
 ygAIllVpnjw1ony7lq0g8B0addbXFza9f5+LsY8Le50iwWOYudRGrZWqu5Gy7KO4TdfUPtftl
 vHBHlHsq4+3Tv5ZRvr09wrxuYy0Gpv6cs91eFI//wNbzpw0bzs42DsWEyXx69ECq+IFHXuiSW
 wTe3Xrz94ggWJjktZCTbCu8OIMPZ4srbgyKrbRoI8SaB9i4ifhJ8eDdksnaC8PcjXS6ac47WY
 ZmWpc4ggDUTW9Y3Z8/2w2kUIiXDMoMUU2vSW4KsOqJfQ+xzJGQPTYLCsTNQPnb9X2MoCtoBDk
 z7OlpP0098EVeQHXzCL9MhyWNL5W8d0MSZvQS9SCxGN+k10tGXf3cZ5PzZFvhPkYtkSuDwHB/
 z95mjMkGLeCeJU2tP5L83Blo1q6Gn5LkdXZ42diJDucjJv3k6ey3K94VbaR5kWpKFF+wMLbac
 3o+/fOmGTPlAU2B86uI4uz3XkJmxdgj9pWgoLf8kNE5bajXZReWDliOPImPFqkEogbhSklkf9
 gs2h8J5+HJprUPbH+5NnuICNJyo29k7Mb8m/dFnZFOLVriV0YKuGwTcqt4a9VPnrTlzzrtn9U
 jdGoncJJBOmQ4LGi/b8gbi5GbLeCgtVAkiDl7C5i2JcysJJPH5mXTQ8/8puf6rpmYvax5E1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
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

Le 12/03/2020 à 17:55, Laurent Vivier a écrit :
> print_socket_type() doesn't manage flags and the correct type cannot
> be displayed
> 
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
> 
> Notes:
>     v2: replace gemu_log() by qemu_log() as it has been removed from qemu
> 
>  linux-user/strace.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 4f7130b2ff63..69232f7e27b8 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -444,7 +444,7 @@ print_socket_domain(int domain)
>  static void
>  print_socket_type(int type)
>  {
> -    switch (type) {
> +    switch (type & TARGET_SOCK_TYPE_MASK) {
>      case TARGET_SOCK_DGRAM:
>          qemu_log("SOCK_DGRAM");
>          break;
> @@ -464,6 +464,12 @@ print_socket_type(int type)
>          qemu_log("SOCK_PACKET");
>          break;
>      }
> +    if (type & TARGET_SOCK_CLOEXEC) {
> +        qemu_log("|SOCK_CLOEXEC");
> +    }
> +    if (type & TARGET_SOCK_NONBLOCK) {
> +        qemu_log("|SOCK_NONBLOCK");
> +    }
>  }
>  
>  static void
> 

Applied to my linux-user branch.

Thanks,
Laurent

