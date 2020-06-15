Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73453C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:34:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 388152076A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 12:34:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 388152076A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56708 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkoK7-0003p9-86
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 08:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jkoJ9-0003P2-63
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:33:47 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:45319)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jkoJ7-0002lM-1b
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 08:33:46 -0400
Received: from [192.168.100.1] ([82.252.135.106]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MGi6m-1jfqDv2KSg-00DqeO; Mon, 15 Jun 2020 14:33:41 +0200
To: Filip Bozuta <filip.bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200612164001.27405-1-filip.bozuta@syrmia.com>
 <20200612164001.27405-3-filip.bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH 2/2] linux-user: Add strace support for printing arguments
 of ioctl()
Message-ID: <f21304c6-d358-799d-cd7e-13527a1a869f@vivier.eu>
Date: Mon, 15 Jun 2020 14:33:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200612164001.27405-3-filip.bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:UhRYh9DelWjdeguNIouAIuFlP2JUei5ILuioZwdOD4WMDGpz85Y
 rtun9uTTFgeFt6hV0JZEOEBAWOjhR5OID/hPwbmhyRhw7Od2f2Aqsb+TqO+dRTnCZD3pJOw
 XaD/LzMxjdVTTPybpMIdgnDsuHImKBrSbkYWpetbtpiUGUH/olkCaRWoBlMxOX0cxRFP9mE
 ms1tdnBib1uwHScmtlGrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2acVGzucY78=:a/W+AJGCHbQiA9YBPuF5fU
 uk2ZbWvPvcC34kOm9egG/Pau22YRhwlQjlAgNRodWeD2l92/aQDVbkNQZDZp4T1LAmUGJbMVf
 kVgOPeR/jkPSiac2GSdX5UfmDNL5yS5tACh49w/J3RW/GEmMA7odc6UuMLVcckzM/fi9FRA0e
 Dh1i3btS4Vm0zhV1EyW5aBIvdZ7B66l9Avi3T49Pzl4BnhXDwZbRb0TYq8X1S8JZ9d86k08+S
 4IH/t+ct3K0Hi0OREs+huR6ldlGE8bJOo1ZnWfMbYLMVXbMfmFiyokZZebQQ0WSI7dLYXnSNU
 ngU4DD0ol2ctWqhkNcMDqC71wts+pHt0T7PW8VXOuYUgB9bsL5AoVzjo0wZFoFNRMJN/0EF8O
 IAoh8beFPpdHEjzmMTEek0rdqjq0sKMjpCOFh8SeJp/oIknAYII+3gAOMROi0U2QwBlKx0qs0
 KstXVQXx4Ax7MYJTs2/O5Osfk8qU9LwiMcs4sFSxaBe4B9ndpMEFZOURn5NSbpgy/FQ7w+eZG
 5RCcyHIfPmg9Jeu8gkigJmVaJOm+QRNEmVcQdeRbiVKRvkwOfewKsxtP8is+ouPL/3jRsHU8D
 MLskFZarcSR1Dd8M7N/WDWNLpU8wSPklHhI24JnrqigYelrLaG/1LxwAf+gqmtXSBPYdIacWM
 eTD5vlilKRW3DMmAMquXA8hZ7wFOXXcbt+1c/4PNgmP+6Pr31NMfCX5XnfGxRg3gkjXKbHEBf
 68dCshp7M+QNumBTOag9UENAas9YACACYkBZwGSKb4blm9CgQWF40rpGknV834ZosYehKNbRo
 4XfucmUjXOKMjCk35oCGOVinFVAVPw+tMayakV6nT46yiD0PJdY72rAEvMQTQdjqW2nnB0R
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/15 07:52:40
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

Le 12/06/2020 à 18:40, Filip Bozuta a écrit :
> From: Filip Bozuta <Filip.Bozuta@syrmia.com>
> 
> This patch implements functionality for strace argument printing for ioctls.
> When running ioctls through qemu with "-strace", they get printed in format:
> 
>     "ioctl(fd_num,0x*,0x*) = ret_value"
> 
> where the request code an the ioctl's third argument get printed in a hexadicemal
> format. This patch changes that by enabling strace to print both the request code
> name and the contents of the third argument. For example, when running ioctl
> RTC_SET_TIME with "-strace", with changes from this patch, it gets printed in
> this way:
> 
>     "ioctl(3,RTC_SET_TIME,{12,13,15,20,10,119,0,0,0}) = 0"
> 
> In case of IOC_R type ioctls, the contents of the third argument get printed
> after the return value, and the argument inside the ioctl call gets printed
> as pointer in hexadecimal format. For example, when running RTC_RD_TIME with
> "-strace", with changes from this patch, it gets printed in this way:
> 
>     "ioctl(3,RTC_RD_TIME,0x40800374) = 0 ({22,9,13,11,5,120,0,0,0})"
> 
> In case of IOC_RW type ioctls, the contents of the third argument get printed
> both inside the ioctl call and after the return value.
> 
> Implementation notes:
> 
>     Functions "print_ioctl()" and "print_syscall_ret_ioctl()", that are defined
>     in "strace.c", are listed in file "strace.list" as "call" and "result"
>     value for ioctl. Structure definition "IOCTLEntry" as well as predefined
>     values for IOC_R, IOC_W and IOC_RW were cut and pasted from file "syscall.c"
>     to file "qemu.h" so that they can be used by these functions to print the
>     contents of the third ioctl argument. Also, the "static" identifier for array
>     "ioctl_entries[]" was removed and this array was declared as "extern" in "qemu.h"
>     so that it can also be used by these functions. To decode the structure type
>     of the ioctl third argument, function "thunk_print()" was defined in file
>     "thunk.c" and its definition is somewhat simillar to that of function
>     "thunk_convert()".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  include/exec/user/thunk.h |   1 +
>  linux-user/qemu.h         |  20 +++++
>  linux-user/strace.c       | 120 +++++++++++++++++++++++++++++
>  linux-user/strace.list    |   3 +-
>  linux-user/syscall.c      |  20 +----
>  thunk.c                   | 154 ++++++++++++++++++++++++++++++++++++++
>  6 files changed, 298 insertions(+), 20 deletions(-)
> 
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index eae2c27f99..7992475c9f 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -73,6 +73,7 @@ void thunk_register_struct_direct(int id, const char *name,
>                                    const StructEntry *se1);
>  const argtype *thunk_convert(void *dst, const void *src,
>                               const argtype *type_ptr, int to_host);
> +const argtype *thunk_print(void *arg, const argtype *type_ptr);
>  
>  extern StructEntry *struct_entries;
>  
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index be67391ba4..5c964389c1 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -184,6 +184,26 @@ struct linux_binprm {
>          int (*core_dump)(int, const CPUArchState *); /* coredump routine */
>  };
>  
> +typedef struct IOCTLEntry IOCTLEntry;
> +
> +typedef abi_long do_ioctl_fn(const IOCTLEntry *ie, uint8_t *buf_temp,
> +                             int fd, int cmd, abi_long arg);
> +
> +struct IOCTLEntry {
> +    int target_cmd;
> +    unsigned int host_cmd;
> +    const char *name;
> +    int access;
> +    do_ioctl_fn *do_ioctl;
> +    const argtype arg_type[5];
> +};
> +
> +extern IOCTLEntry ioctl_entries[];
> +
> +#define IOC_R 0x0001
> +#define IOC_W 0x0002
> +#define IOC_RW (IOC_R | IOC_W)
> +
>  void do_init_thread(struct target_pt_regs *regs, struct image_info *infop);
>  abi_ulong loader_build_argptr(int envc, int argc, abi_ulong sp,
>                                abi_ulong stringp, int push_ptr);
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5f370256e3..8de8f242ae 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -869,6 +869,51 @@ print_syscall_ret_listxattr(const struct syscallname *name, abi_long ret,
>  #define print_syscall_ret_flistxattr     print_syscall_ret_listxattr
>  #endif
>  
> +#ifdef TARGET_NR_ioctl
> +static void
> +print_syscall_ret_ioctl(const struct syscallname *name, abi_long ret,
> +                        abi_long arg0, abi_long arg1, abi_long arg2,
> +                        abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    const char *errstr = NULL;
> +
> +    qemu_log(" = ");
> +    if (ret < 0) {
> +        qemu_log("-1 errno=%d", errno);
> +        errstr = target_strerror(-ret);
> +        if (errstr) {
> +            qemu_log(" (%s)", errstr);
> +        }

You should use the error function you used in your provious series.
You can explain it is based on it by adding a Based-on: tag with the
mail message id:

Based-on: <20200611155109.3648-1-filip.bozuta@syrmia.com>

> +    } else {
> +        qemu_log(TARGET_ABI_FMT_ld, ret);
> +
> +        const IOCTLEntry *ie;
> +        const argtype *arg_type;
> +        void *argptr;
> +        int target_size;
> +
> +        for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
> +            if (ie->target_cmd == arg1) {
> +                break;
> +            }
> +        }
> +
> +        if (ie->target_cmd == arg1 &&
> +           (ie->access == IOC_R || ie->access == IOC_RW)) {
> +            arg_type = ie->arg_type;
> +            qemu_log(" (");
> +            arg_type++;
> +            target_size = thunk_type_size(arg_type, 0);
> +            argptr = lock_user(VERIFY_READ, arg2, target_size, 1);
> +            thunk_print(argptr, arg_type);
> +            unlock_user(argptr, arg2, target_size);
> +            qemu_log(")");
> +        }
> +    }
> +    qemu_log("\n");
> +}
> +#endif
> +
>  UNUSED static struct flags access_flags[] = {
>      FLAG_GENERIC(F_OK),
>      FLAG_GENERIC(R_OK),
> @@ -3008,6 +3053,81 @@ print_statx(const struct syscallname *name,
>  }
>  #endif
>  
> +#ifdef TARGET_NR_ioctl
> +static void
> +print_ioctl(const struct syscallname *name,
> +            abi_long arg0, abi_long arg1, abi_long arg2,
> +            abi_long arg3, abi_long arg4, abi_long arg5)
> +{
> +    print_syscall_prologue(name);
> +    print_raw_param("%d", arg0, 0);
> +
> +    const IOCTLEntry *ie;
> +    const argtype *arg_type;
> +    void *argptr;
> +    int target_size;
> +
> +    for (ie = ioctl_entries; ie->target_cmd != 0; ie++) {
> +        if (ie->target_cmd == arg1) {
> +            break;
> +        }
> +    }
> +
> +    if (ie->target_cmd == 0) {
> +        print_raw_param("%#x", arg1, 0);
> +        print_raw_param("%#x", arg2, 1);
> +    } else {
> +        qemu_log("%s", ie->name);
> +        arg_type = ie->arg_type;
> +
> +        if (arg_type[0] != TYPE_NULL) {
> +            qemu_log(",");
> +
> +            switch (arg_type[0]) {
> +            case TYPE_PTRVOID:
> +                print_pointer(arg2, 1);
> +                break;
> +            case TYPE_CHAR:
> +            case TYPE_SHORT:
> +            case TYPE_INT:
> +                print_raw_param("%d", arg2, 1);
> +                break;
> +            case TYPE_LONG:
> +                print_raw_param(TARGET_ABI_FMT_ld, arg2, 1);
> +                break;
> +            case TYPE_ULONG:
> +                print_raw_param(TARGET_ABI_FMT_lu, arg2, 1);
> +                break;
> +            case TYPE_LONGLONG:
> +                print_raw_param("%lld", arg2, 1);
> +                break;
> +            case TYPE_ULONGLONG:
> +                print_raw_param("%llu", arg2, 1);
> +                break;

I think the ULONGLONG and LONGLONG are not possible because arg2 is an
abi_long and is not read from memory.

Thanks,
Laurent

