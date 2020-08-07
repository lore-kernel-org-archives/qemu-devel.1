Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87A51C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D43822C9F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:38:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D43822C9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40hJ-00010t-IW
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:38:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40ge-0000aI-20
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:37:24 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:42709)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40gb-0001Z1-T4
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:37:23 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MsZif-1kt58P47WF-00u3Wk; Fri, 07 Aug 2020 13:37:19 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
 <20200722200437.312767-6-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH v3 5/5] linux-user: Add strace support for printing
 arguments of some clock and time functions
Message-ID: <0b446c40-ae48-d07c-35e3-bca0ababb83c@vivier.eu>
Date: Fri, 7 Aug 2020 13:37:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722200437.312767-6-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:+zAwput3GU/yxbhWC9WDPqKiftF0xgYKdnJqYtETup2EnBJRVB/
 NCvvSCZGIfiyG6DbMcgAtZTR1p1a54YY/JfgdsJVRhqipHnFtYpw14Qsu6m+K1uE3PK3SIj
 q5jZRVeldc08ocW8ecS+TDDxjrAHZMeVIyATH1YbMSJ5Uu6oSX3Uc4W9bVZALtQxL4TxFtL
 4+CLDsuLR/hlSr1cbnIBQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:saZW4oHmY9U=:l3quKQczJCO/mtqxwQ1e81
 OIgU5AovfA66iCJnUOoS9LjynsxvW5I0kshaQfzq/6LhNSBkbWaWVEgzzV49t3N51NCwN5G0A
 IgLQgywqy4wEQ+1W80OhYeFeyMQ+EVjPncCtoGjUEaCXypHhz5ZuzP4l5NoG4Nyl2QbAsq5Z9
 b1lj9TEq9h8yfZiMj5hC3E6n3uPjdeHdlxFVsDw/R5dq+h5IZq/zFeBRG/jRAjgbaKHfI3oLL
 GTL0CsLn/NL5aeoYn4Dyh0MXtzz/YjwOIEa3eY1oU0O/Is9LkJ9wenX3fzs7NxwVKFUuswZin
 NKGRc0u3xcp2kzv3UFHOjwmmIS8xiaUiVKfuDePT2Dmdt9nu27fLAHTQFj1aWW7cq0GIYNoT1
 9M4cNO1sNisylTq7W8OwXs7YP4AjP6B/k2E0EEl/IiwEYqt4YBrSTSIyL7hwLDjEY0tHQZUA+
 42Tu/lPqTzrk5CoQSXyb5ZTsFqeyVG9NxelImezhHAEIibvm9spXNiGjQePcCXJMJCWalowmG
 KEUq0dspqYRMvsn1w78tWs2POIirLpYFMmdxppgkSsWQJR4tnHMs8V/xUzXC6W6UTn9UC2EGd
 Xwhul1s65KxP3ftQnJecsC6nAJ1ivAg+oDXSW1QSAWGg/qzPxHGoSMto/TIe8hR9NSSsvJqVW
 wiToXbz0lFqI3vwDNwEBAFn2icjqwqbA21bE7OsV3pQbo3VufQwiUHCNpWzC3CbLKnp4ac7fe
 hef6tCK7HiX1FlLbmgp6o5l/ZpFIHd+PGG0Q7zgYbTiSS/uFmyJQ08QAeJHdP9Fy3moaEevWA
 qfblX6DoAUa0bul2Mt49mQ9rDWPwZHErEMc5J7A0o2CXyjKJycmIZbYWWlIJQBkspeatJBx
Received-SPF: none client-ip=217.72.192.73; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:37:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/07/2020 à 22:04, Filip Bozuta a écrit :
> This patch implements strace argument printing functionality for following syscalls:
> 
>     * clock_getres, clock_gettime, clock_settime - clock and time functions
> 
>         int clock_getres(clockid_t clockid, struct timespec *res)
>         int clock_gettime(clockid_t clockid, struct timespec *tp)
>         int clock_settime(clockid_t clockid, const struct timespec *tp)
>         man page: https://man7.org/linux/man-pages/man2/clock_getres.2.html
> 
>     * gettimeofday - get time
> 
>         int gettimeofday(struct timeval *tv, struct timezone *tz)
>         man page: https://man7.org/linux/man-pages/man2/gettimeofday.2.html
> 
>     * getitimer, setitimer - get or set value of an interval timer
> 
>         int getitimer(int which, struct itimerval *curr_value)
>         int setitimer(int which, const struct itimerval *new_value,
>                       struct itimerval *old_value)
>         man page: https://man7.org/linux/man-pages/man2/getitimer.2.html
> 
> Implementation notes:
> 
>     All of the syscalls have some structue types as argument types and thus
>     a separate printing function was stated in file "strace.list" for each
>     of them. All of these functions use existing functions for their
>     appropriate structure types ("print_timeval()" and "print_timezone()").
> 
>     Functions "print_timespec()" and "print_itimerval()" were added in this
>     patch so that they can be used to print types "struct timespec" and
>     "struct itimerval" used by some of the syscalls. Function "print_itimerval()"
>     uses the existing function "print_timeval()" to print fields of the
>     structure "struct itimerval" that are of type "struct timeval".
> 
>     Function "print_enums()", which was introduced in the previous patch, is used
>     to print the interval timer type which is the first argument of "getitimer()"
>     and "setitimer()". Also, this function is used to print the clock id which
>     is the first argument of "clock_getres()" and "clock_gettime()". For that
>     reason, the existing function "print_clockid()" was removed in this patch.
>     Existing function "print_clock_adjtime()" was also changed for this reason
>     to use "print_enums()".
> 
>     The existing function "print_timeval()" was changed a little so that it
>     prints the field names beside the values.
> 
>     Syscalls "clock_getres()" and "clock_gettime()" have the same number
>     and types of arguments and thus their print functions "print_clock_getres"
>     and "print_clock_gettime" share a common definition in file "strace.c".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c    | 285 +++++++++++++++++++++++++++++++----------
>  linux-user/strace.list |  17 ++-
>  2 files changed, 230 insertions(+), 72 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index def92c4d73..aa5539f468 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
...
> @@ -1461,6 +1533,20 @@ print_timezone(abi_ulong tz_addr, int last)
>      }
>  }
>  
> +static void
> +print_itimerval(abi_ulong it_addr, int last)
> +{
> +    if (it_addr) {
> +        qemu_log("{it_interval=");
> +        print_timeval(it_addr, 0);
> +        qemu_log("it_value=");
> +        print_timeval(it_addr + sizeof(struct target_timeval), 1);
> +        qemu_log("}%s", get_comma(last));

You should use "target_timeval *it = lock_user(...);" and then
print_timeval(&it->it_interval, 0) and print_timeval(&i->it_value, 1)

> +    } else {
> +        qemu_log("NULL%s", get_comma(last));
> +    }
> +}
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept

Thanks,
Laurent

