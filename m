Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E324C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:24:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34B9820663
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:24:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34B9820663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv43t-0008Ey-I6
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:24:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv43I-0007i1-VJ
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:23:49 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:60073)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jv43H-0006hB-97
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:23:48 -0400
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MQ5f4-1kH79E0m6S-00M1d1; Mon, 13 Jul 2020 21:23:44 +0200
Subject: Re: [PATCH] linux-user: Fix Coverity CID 1430271 / CID 1430272
To: qemu-devel@nongnu.org
References: <20200709200010.1016741-1-laurent@vivier.eu>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <cc4420a7-96ec-0342-2689-32e5196fa823@vivier.eu>
Date: Mon, 13 Jul 2020 21:23:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709200010.1016741-1-laurent@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:35czsbEJcac9DVPl3+vnLUWDD9ZDObAXdKSLYzad+3p1uaBXrZL
 v5960jK12YfzD9nEIUpS4mMDanhbmCtaV4nTCBYDOZasl3dQ0DRXO286IRrd0qVc+WjzNAq
 s0VabYLkh3ksv3wm93uSqShiFrTNbdp2vYzHw2Ens/ZYRhRWj9RqP4nMFqg5CLtv1T86CZ1
 XUGlqYObxJPRWtvAnANTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l84p6Qzo5Oo=:vWU5wz4ApWqvhFI1gPtjOI
 h/+h4ajFrzNN8Yw+bkPw7llBZjTeDtSbPqiWOkfFGqMNFuYtBUlRelBRi1c95MaJNBeP4yt3X
 86YinhqvLJXFSYm9HPXgdFn3dC3IkrPzP0y9v75eLP4t5oubu5nWpgfZtwwsHg5CzvLYgUoQk
 RBLVreEBwLgGhXCOIEPYhrtVNnUH+EtcAyl12vgCxJqvPt7QmfZpqodDofVSUrxRNXxswNd+Q
 sV7rQ7SvTSlK9O0AeoWwGn/HWONdN+n5tksea24emOiaQ6bwLFD5vrbOXf56Q5BID8oEs36UO
 +GqRB1+hOM0xwiXvlP5PRo9jAZlQJeiKsazyy7+CiZ/Iqw55IU92CNNjbKodkBqfLfWheIOvG
 rcAdwD6RvDMVoRtbcL7DsbViHqLIA2/AWrvyo7CrjG5ekOIomvha93o1PnU43iHcXoBsOG5g+
 HtZEgqpEAi2hUWnWFPVEVNUE8B5OZBkjKGMp1KQ2xXDFfJ1NRCZB7BJ03zrbft8Xucy0C5FCV
 2LkJFw/LQaOEt43JworRDpM4c2yD/X3unmrlXjcdoVbqVX/SkCwc4fCA8A0dgCqdv0UDwJmUS
 KOZz8nqa0o2yeyyUKU5NCBg10A3AG6l30fA88zpAW0RR2nqizxUu2URytl4F1XW8xJtFCGU5A
 G03ZhiCXGUKoYkIsP21fTt0wu941TrLz1TjXIG2m8xpu0EiUI+SSyyaiq+013i1MzWYPwTInE
 Nmy1KseSS+km3RCmtXSOu6i7WbAgLyteAeHuvNzJxLLHO5zdO68TUu/wvQscuw0XBTrAbcYGR
 iGmz1TYM9RrOlIQ90ukZz9pW+SET1R7L0CcQlvHvLbUo8KHmws3EMZBUuFF+DA40BxilKFV
Received-SPF: none client-ip=212.227.17.13; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 15:23:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Filip Bozuta <Filip.Bozuta@syrmia.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 09/07/2020 à 22:00, Laurent Vivier a écrit :
> In new functions print_ioctl() and print_syscall_ret_ioctl(), we don't
> check if lock_user() returns NULL and this would cause a segfault in
> thunk_print().
> 
> If lock_user() returns NULL don't call thunk_print() but prints only the
> value of the (invalid) pointer.
> 
> Tested with:
> 
>     # cat ioctl.c
>     #include <unistd.h>
>     #include <sys/ioctl.h>
> 
>     int main(void)
>     {
>         int ret;
> 
>         ret = ioctl(STDOUT_FILENO, TCGETS, 0xdeadbeef);
>         ret = ioctl(STDOUT_FILENO, TCSETSF, 0xdeadbeef);
>         return 0;
>     }
>     # QEMU_STRACE= ./ioctl
>     ...
>     578 ioctl(1,TCGETS,0xdeadbeef) = -1 errno=2 (Bad address)
>     578 ioctl(1,TCSETSF,0xdeadbeef) = -1 errno=2 (Bad address)
>     ...
>     # QEMU_STRACE= passwd
>     ...
>     623 ioctl(0,TCGETS,0x3fffed04) = 0 ({})
>     623 ioctl(0,TCSETSF,{}) = 0
>     ...
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 79482e5987c8 ("linux-user: Add strace support for printing arguments of ioctl()")
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
> ---
>  linux-user/strace.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5235b2260cdd..39554d903911 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -889,8 +889,12 @@ print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
>              arg_type++;
>              target_size = thunk_type_size(arg_type, 0);
>              argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> -            thunk_print(argptr, arg_type);
> -            unlock_user(argptr, arg2, target_size);
> +            if (argptr) {
> +                thunk_print(argptr, arg_type);
> +                unlock_user(argptr, arg2, target_size);
> +            } else {
> +                print_pointer(arg2, 1);
> +            }
>              qemu_log(")");
>          }
>      }
> @@ -3119,8 +3123,12 @@ print_ioctl(const struct syscallname *name,
>                      arg_type++;
>                      target_size = thunk_type_size(arg_type, 0);
>                      argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> -                    thunk_print(argptr, arg_type);
> -                    unlock_user(argptr, arg2, target_size);
> +                    if (argptr) {
> +                        thunk_print(argptr, arg_type);
> +                        unlock_user(argptr, arg2, target_size);
> +                    } else {
> +                        print_pointer(arg2, 1);
> +                    }
>                      break;
>                  }
>                  break;
> 

Applied to my linux-user-for-5.1 branch.

Thanks,
Laurent

