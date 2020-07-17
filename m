Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42886C433E3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C11F20717
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 14:49:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C11F20717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwRgA-0003vH-9N
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 10:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57620)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jwReM-0001ah-P8
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:47:46 -0400
Received: from mout.kundenserver.de ([217.72.192.74]:47725)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1jwReJ-0005kb-H1
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 10:47:46 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue107 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MwgOK-1klUo33cUM-00y6QE; Fri, 17 Jul 2020 16:47:34 +0200
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200714200439.11328-1-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Subject: Re: [PATCH] linux-user: Add strace support for printing arguments for
 ioctls used for terminals and serial lines
Message-ID: <76551f5e-ea9d-fcb9-2646-2653f110a635@vivier.eu>
Date: Fri, 17 Jul 2020 16:47:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200714200439.11328-1-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:XywwmRH+48mCmubzzhz97zPeOkzdXOp/jLEY/Kv8e5aTOgDaHT/
 +NeYZzj7+Vo37feOWHNK66jzoIE/Vjj7Hwi8xDfA3RXvkHkth0QqRPquv0aMvGqpk05mLvQ
 U7/lWAbpOwHtiCWPESmZhcgunx8eNX+p0809RBiIXTGNL9lmdoQoxkpkRiW8K3kwEH2+vdZ
 iHoaza/+6mA7iURZUDJYA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AKAw4TPY3Wo=:onfwamqzsq2kEglxWJSSn+
 irC+71C0fWmnG4rAqhMkKv40/+1NYDKbozvrligOXarOksailiiiVPxusksyk86xhkXpHVLCF
 08UIJWEY5Vwdx9tlJA6uLkQo0hutVvnZpA93v50LhQbFiayVcFxb8Jn3bujmQ+lCYkjcHGMCq
 qCAdW5TzHNAYSiEKUpGryyA9/F0c3dHfqzHUIPTxcexp9c8RntcIGlDTpS2/OyvYKplBVNkqi
 bm9jkhlb06Q0REvmnuWIiP6+enUcpyYp2nVy59G89Y5Wjk5fMn9wDoG9v3qtnHhpkbooPowCO
 I0VMJG7WaxvBdpKDyIjtcLbQxRGKPLIIR5kJlqDNhgnbAQti6xDVD8BbwuetxklFGyhQtODdn
 FVIF3N6lmxhaHStW1QPsjQMM4jdkYUIZOJPif0SP0o+5M3GcxS5BqzqAUJ+eqrPHnq096h7Px
 4WfcEP8q7L2kHroSCNEQrymx7RjMMjx/h35nycSZ6eE5cZlHQH92zlPc6PZgtvNdRm3ZAG++H
 sd4oYQ9TWaTLSvMcGLEJUYk3sneRt0AJM60L6d2KWAeFkN+hiLAapLVww4PPO0X1qfewzttSs
 Syqqa9hLpcSYEiZ42YSFNmDwL1iyoM9E3BMjTFI7sFKY/ZTOt6hy2pzdShV/4nuWIND2uam8q
 NZPOYcSoDEP3ZFV3b9BWFgxKGhdz4OsoCCLHfed+pTrjKY9DvWsg4zS6+BTCERKJtwwAvFMcL
 FN57vftIt8+B/ghA31q30XdDyj5UnJT6bSHhil9rYZ749gxjtxv2aur03ijczj9dPq1q1Yn7f
 AB12+nyXjna1yK9s9R3nOlMeL73kYRz2MitGr5lGAiXcvXqtx6AMXeD51Om9YLDCVzpxKxw
Received-SPF: none client-ip=217.72.192.74; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 10:47:41
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
Cc: Riku Voipio <riku.voipio@iki.fi>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/07/2020 à 22:04, Filip Bozuta a écrit :
> Functions "print_ioctl()" and "print_syscall_ret_ioctl()" are used
> to print arguments of "ioctl()" with "-strace". These functions
> use "thunk_print()", which is defined in "thunk.c", to print the
> contents of ioctl's third arguments that are not basic types.
> However, this function doesn't handle ioctls of group ioctl_tty which
> are used for terminals and serial lines. These ioctls use a type
> "struct termios" which thunk type is defined in a non standard
> way using "STRUCT_SPECIAL()". This means that this type is not decoded
> regularly using "thunk_convert()" and uses special converting functions
> "target_to_host_termios()" and "host_to_target_termios()", which are defined
> in "syscall.c" to decode it's values. For simillar reasons, this type is
> also not printed regularly using "thunk_print()". That is the reason
> why a separate printing function "print_termios()" is defined in
> file "strace.c". This function decodes and prints flag values of the
> "termios" structure.
> 
> Implementation notes:
> 
>     Function "print_termios()" was implemented in "strace.c" using
>     an existing function "print_flags()" to print flag values of
>     "struct termios" fields. These flag values were defined
>     using an existing macro "FLAG_TARGET()" that generates aproppriate
>     target flag values and string representations of these flags.
>     This function was declared in "qemu.h" so that it can be accessed
>     in "syscall.c". Type "StructEntry" defined in "exec/user/thunk.h"
>     contains information that is used to decode structure values.
>     Field "void print(void *arg)" was added in this structure as a
>     special print function. Also, function "thunk_print()" was changed
>     a little so that it uses this special print function in case
>     it is defined. This printing function was instantiated with the
>     defined "print_termios()" in "syscall.c" in "struct_termios_def".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  include/exec/user/thunk.h |   1 +
>  linux-user/qemu.h         |   2 +
>  linux-user/strace.c       | 193 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c      |   1 +
>  thunk.c                   |  23 +++--
>  5 files changed, 211 insertions(+), 9 deletions(-)
> 
> diff --git a/include/exec/user/thunk.h b/include/exec/user/thunk.h
> index 7992475c9f..a5bbb2c733 100644
> --- a/include/exec/user/thunk.h
> +++ b/include/exec/user/thunk.h
> @@ -55,6 +55,7 @@ typedef struct {
>      int *field_offsets[2];
>      /* special handling */
>      void (*convert[2])(void *dst, const void *src);
> +    void (*print)(void *arg);
>      int size[2];
>      int align[2];
>      const char *name;
> diff --git a/linux-user/qemu.h b/linux-user/qemu.h
> index 5c964389c1..e51a0ededb 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -706,6 +706,8 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>  }
>  #endif /* TARGET_ABI_BITS != 32 */
>  
> +extern void print_termios(void *arg);
> +
>  /**
>   * preexit_cleanup: housekeeping before the guest exits
>   *
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 5235b2260c..7b5408cf4a 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1193,6 +1193,138 @@ UNUSED static struct flags falloc_flags[] = {
>  #endif
>  };
>  
> +UNUSED static struct flags termios_iflags[] = {
> +    FLAG_TARGET(IGNBRK),
> +    FLAG_TARGET(BRKINT),
> +    FLAG_TARGET(IGNPAR),
> +    FLAG_TARGET(PARMRK),
> +    FLAG_TARGET(INPCK),
> +    FLAG_TARGET(ISTRIP),
> +    FLAG_TARGET(INLCR),
> +    FLAG_TARGET(IGNCR),
> +    FLAG_TARGET(ICRNL),
> +    FLAG_TARGET(IUCLC),
> +    FLAG_TARGET(IXON),
> +    FLAG_TARGET(IXANY),
> +    FLAG_TARGET(IXOFF),
> +    FLAG_TARGET(IMAXBEL),

IUTF8 is missing

> +    FLAG_END,
> +};
> +
> +UNUSED static struct flags termios_oflags[] = {
> +    FLAG_TARGET(OPOST),
> +    FLAG_TARGET(OLCUC),
> +    FLAG_TARGET(ONLCR),
> +    FLAG_TARGET(OCRNL),
> +    FLAG_TARGET(ONOCR),
> +    FLAG_TARGET(ONLRET),
> +    FLAG_TARGET(OFILL),
> +    FLAG_TARGET(OFDEL),
> +    FLAG_END,
> +};
> +

the following entries are not flags: flags are bits, while we have
enumerated values in these cases.

NL0, NL1 = 0,1

> +UNUSED static struct flags termios_oflags_NLDLY[] = {
> +    FLAG_TARGET(NL0),
> +    FLAG_TARGET(NL1),
> +    FLAG_END,
> +};

CR0, CR1, CR2, CR3 = 0, 1, 2, 3

> +UNUSED static struct flags termios_oflags_CRDLY[] = {
> +    FLAG_TARGET(CR0),
> +    FLAG_TARGET(CR1),
> +    FLAG_TARGET(CR2),
> +    FLAG_TARGET(CR3),
> +    FLAG_END,
> +};
>

TAB0 is 0 so it cannot be detected

> +UNUSED static struct flags termios_oflags_TABDLY[] = {
> +    FLAG_TARGET(TAB0),
> +    FLAG_TARGET(TAB1),
> +    FLAG_TARGET(TAB2),
> +    FLAG_TARGET(TAB3),
> +    FLAG_END,
> +};

VT0 is 0

> +UNUSED static struct flags termios_oflags_VTDLY[] = {
> +    FLAG_TARGET(VT0),
> +    FLAG_TARGET(VT1),
> +    FLAG_END,
> +};

FF0 is 0

> +UNUSED static struct flags termios_oflags_FFDLY[] = {
> +    FLAG_TARGET(FF0),
> +    FLAG_TARGET(FF1),
> +    FLAG_END,
> +};

BS0 is 0

> +UNUSED static struct flags termios_oflags_BSDLY[] = {
> +    FLAG_TARGET(BS0),
> +    FLAG_TARGET(BS1),
> +    FLAG_END,
> +};

ditto: these are not bits but enumerated values (B0 is 0).

> +UNUSED static struct flags termios_cflags_CBAUD[] = {
> +    FLAG_TARGET(B0),
> +    FLAG_TARGET(B50),
> +    FLAG_TARGET(B75),
> +    FLAG_TARGET(B110),
> +    FLAG_TARGET(B134),
> +    FLAG_TARGET(B150),
> +    FLAG_TARGET(B200),
> +    FLAG_TARGET(B300),
> +    FLAG_TARGET(B600),
> +    FLAG_TARGET(B1200),
> +    FLAG_TARGET(B1800),
> +    FLAG_TARGET(B2400),
> +    FLAG_TARGET(B4800),
> +    FLAG_TARGET(B9600),
> +    FLAG_TARGET(B19200),
> +    FLAG_TARGET(B38400),
> +    FLAG_TARGET(B57600),
> +    FLAG_TARGET(B115200),
> +    FLAG_TARGET(B230400),
> +    FLAG_TARGET(B460800),
> +    FLAG_END,
> +};

CS5 is 0

> +UNUSED static struct flags termios_cflags_CSIZE[] = {
> +    FLAG_TARGET(CS5),
> +    FLAG_TARGET(CS6),
> +    FLAG_TARGET(CS7),
> +    FLAG_TARGET(CS8),
> +    FLAG_END,
> +};

These ones are ok:

> +UNUSED static struct flags termios_cflags[] = {
> +    FLAG_TARGET(CSTOPB),
> +    FLAG_TARGET(CREAD),
> +    FLAG_TARGET(PARENB),
> +    FLAG_TARGET(PARODD),
> +    FLAG_TARGET(HUPCL),
> +    FLAG_TARGET(CLOCAL),
> +    FLAG_TARGET(CRTSCTS),
> +    FLAG_END,
> +};

These ones too:

> +UNUSED static struct flags termios_lflags[] = {
> +    FLAG_TARGET(ISIG),
> +    FLAG_TARGET(ICANON),
> +    FLAG_TARGET(XCASE),
> +    FLAG_TARGET(ECHO),
> +    FLAG_TARGET(ECHOE),
> +    FLAG_TARGET(ECHOK),
> +    FLAG_TARGET(ECHONL),
> +    FLAG_TARGET(NOFLSH),
> +    FLAG_TARGET(TOSTOP),
> +    FLAG_TARGET(ECHOCTL),
> +    FLAG_TARGET(ECHOPRT),
> +    FLAG_TARGET(ECHOKE),
> +    FLAG_TARGET(FLUSHO),
> +    FLAG_TARGET(PENDIN),
> +    FLAG_TARGET(IEXTEN),

missing EXTPROC

> +    FLAG_END,
> +};
> +
>  /*
>   * print_xxx utility functions.  These are used to print syscall
>   * parameters in certain format.  All of these have parameter
> @@ -1420,6 +1552,67 @@ print_timezone(abi_ulong tz_addr, int last)
>      }
>  }
>  
> +void
> +print_termios(void *arg)
> +{
> +    const struct target_termios *target = arg;
> +
> +    abi_long iflags = tswap32(target->c_iflag);
> +    abi_long oflags = tswap32(target->c_oflag);
> +    abi_long cflags = tswap32(target->c_cflag);
> +    abi_long lflags = tswap32(target->c_lflag);

You should use target_tcflag_t here, rather than abi_long.
To be able to do that we need some cleanup before:
- define target_tcflag_t, target_cc_t, target_speed_t in a new file
  linux-user/generic/termbits.h
- update all the existing target_termios to use them

> +
> +    qemu_log("{");
> +
> +    qemu_log("c_iflag = ");
> +    print_flags(termios_iflags, iflags, 0);
> +
> +    qemu_log("c_oflag = ");
> +    abi_long oflags_clean =  oflags & ~(TARGET_NLDLY) & ~(TARGET_CRDLY) &
> +                                      ~(TARGET_TABDLY) & ~(TARGET_BSDLY) &
> +                                      ~(TARGET_VTDLY) & ~(TARGET_FFDLY);

I think would simpler to write:

oflags & ~(TARGET_NLDLY | TARGET_CRDLY | TARGET_TABDLY | TARGET_BSDLY |
TARGET_VTDLY | TARGET_FFDLY)

> +    print_flags(termios_oflags, oflags_clean, 0);
> +    if (oflags & TARGET_NLDLY) {

NL0 is 0 so you never display it.

> +        print_flags(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
> +    }
> +    if (oflags & TARGET_CRDLY) {

CR0 is 0, same comment for the following ones.

> +        print_flags(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
> +    }
> +    if (oflags & TARGET_TABDLY) {
> +        print_flags(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
> +    }
> +    if (oflags & TARGET_BSDLY) {
> +        print_flags(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
> +    }
> +    if (oflags & TARGET_VTDLY) {
> +        print_flags(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
> +    }
> +    if (oflags & TARGET_FFDLY) {
> +        print_flags(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
> +    }
> +
> +    qemu_log("c_cflag = ");
> +    if (cflags & TARGET_CBAUD) {
> +        print_flags(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
> +    }
> +    if (cflags & TARGET_CSIZE) {
> +        print_flags(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
> +    }
> +    abi_long cflags_clean = cflags & ~(TARGET_CBAUD) & ~(TARGET_CSIZE);
> +    print_flags(termios_cflags, cflags_clean, 0);
> +
> +    qemu_log("c_lflag = ");
> +    print_flags(termios_lflags, lflags, 0);
> +
> +    qemu_log("c_cc = ");
> +    qemu_log("\"%s\",", target->c_cc);
> +
> +    qemu_log("c_line = ");
> +    print_raw_param("\'%c\'", target->c_line, 1);
> +
> +    qemu_log("}");
> +}
> +
>  #undef UNUSED
>  
>  #ifdef TARGET_NR_accept

Thanks,
Laurent

