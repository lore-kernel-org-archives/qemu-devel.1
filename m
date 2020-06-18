Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBD7C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B581A20773
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 14:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B581A20773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlvf5-0000SL-0u
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 10:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jlve6-00082g-J4
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:36:02 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:43119)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jlve4-0003TY-G7
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 10:36:02 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MiZof-1jHWiA1AIR-00fgpp; Thu, 18 Jun 2020 16:35:57 +0200
Subject: Re: [PATCH v4 1/6] linux-user: Extend strace support to enable
 argument printing after syscall execution
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200616103927.20222-1-filip.bozuta@syrmia.com>
 <20200616103927.20222-2-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <d9ea1b26-505c-c228-9a43-9684c11a9c4f@vivier.eu>
Date: Thu, 18 Jun 2020 16:35:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616103927.20222-2-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T4oRJBIe/0m6Oipz8VDMOIcIlBGLNRZjX0jurGOrC6PMrXSjkuJ
 wWYpnzNLhOvGW/X6Varq8UXKVAgXSJYerXxNVpNBfwBOIDVdUij60mgnnQ5kgk8Je3vogqp
 BQqzlqFKq/yGGYi0OuVvO/kliKo/wpiTc9WPqauGyFfTwOxmU4NTr1jM7JKeWBojaYMcgrV
 EnKdG92UTZuLErPSvBr6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3sBXw6x6f3U=:xYv+fn+fecLIjpHBZM/+rR
 J2Dznfr7EeVH2dZB9LNkW5y2QzkJSg/RDV46jgw/PD5RxsVLN5LxP6xwLRpEFqZNWZCPkybRX
 zG4X/F3C/xQPoLAgR8eYZKuIT3O2/4yucLUBaQvDePZdyHFrYc1Yk32Ea7dtQh/4y5Vclat/7
 iF+sP/M+FNqaZPPfJpqggTEgWLLukBga9jTaOmjmzYfUVanNO7Hk89YdfcU+ZIPx+PBlwkuR1
 5yUDewlkWXDYvygD4n0JgK5A9cp8t9pZxh7qZ7abSuJhFlJCu6GsWibqrkqNJ6z2wZm6I+wCs
 UDMbjel+vvtaxWdz0c5ZsbFcZBS1FMTP1RCDvL2iS/8TSwNWp4WNIVfEQpEdHI8sHbnf8AFzM
 Ja1c9Tq7yQr2gggErkSYv33X5azUut+GwgcSr+X8QxJLYhWLum4Fu9Z/V4Xjf6nZovnXDGFTk
 Blm4zp70qyDFupkeIxEHVMXrVtWlazgFr31ggQT4ctOU5IALOL60mFSYpkO7I2SfIjT+es8PL
 Ql9esy5zSVWAHQTDNAG++RIAzOdL19dgKkH8MN4kzVtK2uprHanjxehypKeRpC4bQHhjSzD1P
 zgk0xNOhDQwtCyY3DeJhYvPpS/VGsy5WNt2Lz/sK0UpvhmlV+xJU0B9l2AhUh0z4aaZOvlG83
 LABQxOVvSu7A8txr7BZATMRnpZXkE6TksBC75RvbwLINDgD/Cm38vtcYoMdpEIZ2igfZigLiE
 cpSY1sPX1BYmHpQ257YGQKTKis3fGKkrlfAzGXf6SjDJ27hL/o7uftsml/37IAj9UN3s4dPF+
 OV/Gfac8Sca1DMrPsEPuBHKwRExTHYuW984eBkyWYMAcBHrHRg=
Received-SPF: none client-ip=212.227.17.10; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/18 10:35:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=_AUTOLEARN
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

Le 16/06/2020 à 12:39, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
>     Structure "struct syscallname" in file "strace.c" is used for "-strace"
>     to print arguments and return values of syscalls. The last field of
>     this structure "result" represents the calling function that prints the
>     return values. This field was extended in this patch so that this function
>     takes all syscalls arguments beside the return value. In this way, it enables
>     "-strace" to print arguments of syscalls that have changed after the syscall
>     execution. This extension will be useful as there are many syscalls that
>     return values inside their arguments (i.e. listxattr() that returns the list
>     of extended attributes inside the "list" argument).
> 
> Implementation notes:
> 
>     Since there are already three existing "print_syscall_ret*" functions inside
>     "strace.c" ("print_syscall_ret_addr()", "print_syscall_ret_adjtimex()",
>     "print_syscall_ret_newselect()"), they were changed to have all syscall arguments
>     beside the return value. This was done so that these functions don't cause build
>     errors (even though syscall arguments are not used in these functions).
>     There is code repetition in these functions for checking the return value
>     and printing the approppriate error message (this code is also located in
>     print_syscall_ret() at the end of "strace.c"). That is the reason why a
>     function "syscall_print_err()" was added for this code and put inside these
>     functions.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/qemu.h    |  4 ++-
>  linux-user/strace.c  | 67 ++++++++++++++++++++++++++------------------
>  linux-user/syscall.c |  2 +-
>  3 files changed, 43 insertions(+), 30 deletions(-)
> 
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index ce902f5132..8f938b8105 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -383,7 +383,9 @@ int host_to_target_waitstatus(int status);
>  void print_syscall(int num,
>                     abi_long arg1, abi_long arg2, abi_long arg3,
>                     abi_long arg4, abi_long arg5, abi_long arg6);
> -void print_syscall_ret(int num, abi_long arg1);
> +void print_syscall_ret(int num, abi_long ret,
> +                       abi_long arg1, abi_long arg2, abi_long arg3,
> +                       abi_long arg4, abi_long arg5, abi_long arg6);
>  /**
>   * print_taken_signal:
>   * @target_signum: target signal being taken
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 0d9095c674..805fcb9fd1 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -19,7 +19,9 @@ struct syscallname {
>      void (*call)(const struct syscallname *,
>                   abi_long, abi_long, abi_long,
>                   abi_long, abi_long, abi_long);
> -    void (*result)(const struct syscallname *, abi_long);
> +    void (*result)(const struct syscallname *, abi_long,
> +                   abi_long, abi_long, abi_long,
> +                   abi_long, abi_long, abi_long);
>  };
>  
>  #ifdef __GNUC__
> @@ -736,17 +738,29 @@ print_ipc(const struct syscallname *name,
>   */
>  
>  static void
> -print_syscall_ret_addr(const struct syscallname *name, abi_long ret)
> +print_syscall_err(abi_long ret)
>  {
>      const char *errstr = NULL;
>  
> +    qemu_log(" = ");
>      if (ret < 0) {
> +        qemu_log("-1 errno=%d", errno);
>          errstr = target_strerror(-ret);
> +        if (errstr) {
> +            qemu_log(" (%s)", errstr);
> +        }
>      }
> -    if (errstr) {
> -        qemu_log(" = -1 errno=%d (%s)\n", (int)-ret, errstr);
> -    } else {
> -        qemu_log(" = 0x" TARGET_ABI_FMT_lx "\n", ret);
> +}
> +
> +static void
> +print_syscall_ret_addr(const struct syscallname *name, abi_long ret,
> +                       abi_long arg0, abi_long arg1, abi_long arg2,
> +                       abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_err(ret);
> +
> +    if (ret >= 0) {
> +        qemu_log("0x" TARGET_ABI_FMT_lx "\n", ret);
>      }
>  }
>  
> @@ -760,7 +774,9 @@ print_syscall_ret_raw(struct syscallname *name, abi_long ret)
>  
>  #ifdef TARGET_NR__newselect
>  static void
> -print_syscall_ret_newselect(const struct syscallname *name, abi_long ret)
> +print_syscall_ret_newselect(const struct syscallname *name, abi_long ret,
> +                            abi_long arg0, abi_long arg1, abi_long arg2,
> +                            abi_long arg3, abi_long arg4, abi_long arg5)
>  {
>      qemu_log(" = 0x" TARGET_ABI_FMT_lx " (", ret);
>      print_fdset(newselect_arg1,newselect_arg2);

print_syscall_ret_newselect() was already displaying arg1...arg5 by
storing them before the call in some global variables.
Now, you can remove these global variables and use the value from the
function parameters.

Thanks,
Laurent

