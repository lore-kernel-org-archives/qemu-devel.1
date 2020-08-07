Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A3AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:19:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E04142086A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 13:19:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E04142086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47026 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k42Hh-0004oG-6N
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 09:19:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50740)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k42H6-0004Ng-PT
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:19:08 -0400
Received: from mout.kundenserver.de ([217.72.192.75]:42617)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k42H4-000564-DG
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 09:19:08 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MhlCg-1khkjf0uVk-00dnYj; Fri, 07 Aug 2020 15:18:55 +0200
Subject: Re: [PATCH v2 3/3] linux-user: Add strace support for printing
 arguments for ioctls used for terminals and serial lines
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200723210233.349690-1-Filip.Bozuta@syrmia.com>
 <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <9af4ab5c-a47d-d7ce-de29-b740d627498f@vivier.eu>
Date: Fri, 7 Aug 2020 15:18:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200723210233.349690-4-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:KlhjdXAe4F/5F5yqyoryA1AvTymi/Isuip6buFQkWlsWjUiUPAt
 CiTrpG8WdYxN1eP/DVcfTrLPh+ma8SkVckzLSNK8oi2UZ0kAE0u6FydlBGCQMB9KipXchSc
 owSoGiu+DvJ+Em5KyULsH937ldIKzXdo+/rrzxdlZxr+uQN/hhliUkyphhDjV9kExYJZBE2
 D8MTsZND2B8J93SIX+j3g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rfeXg8Q1c9c=:C+lRXPLergOUtH5BKClvCv
 j12QUhS1tYI2w908sv7kGE0/Ld669vtMCmPtZ9FsrpKPfhNVt4vw7P0Ula3gd6n4ZLwtPCn42
 wyK1kMYDUBiok2HUGiJLk45qT3VjqQ1+QQWZTDdz9tD1QvdgbGNjaVXAzJKlwhCH6CA/4DFLW
 MKFe0HROrVLdPF0GAazyrsrIH0KG+g7hPpnDDQeZtm1gvCpjUJvoAX/fKwd94X6kiYQtxBCxy
 O0sdcgqEk/kUGRdKLgYc4ul4nUUTNr28qq7FmgoeO24YckBgh7Q0rMF9chBxcHfbM16cPyI/J
 VR65+JKx354TFjxo3NBhNifLO7KWYACxXbHhMGImBGWwdFPqMVC0JGpDL4J+PaSOjley/s6HU
 2NMCVd0PONZoYivel9rIBaD4WvVzmhoC9EicYeLYwV0Y1tUmiUNuDemliD6hZIkdywI+rDZW1
 u1z3utZWJLPf//h5UPdFavbg+dxcvvbhlFS9F5kAZJmMLF3+X+guE/s176MnDDHZSfi2cprmA
 dX2lyQeOY8ZMtexpupFMrS5pmsR10qb9yOWmDLBMm8uuOPxDDsmgq6CZAaATnTorKTxj0rH62
 1vKXPhX0z1Cfaiflfua5SiJA3W162W30+cwWSFinMCx5ATl159mvKYWIeU3Da/fRFub2JHS8b
 LLQQfekMRsAGfGPSc+BnedjQGP1KS2KkxHB6S7uCuRKRWu84wd3z//3LANxjyn3qOvXUqvMvo
 Bd3FrnGsWy+AL9DfRG7ZSXwd2wxwvoc5yzMITiyZuHSDeJOHfopzFnwlKZSSkZvh8p5S8InuL
 qJXy+Gkn6+S2AgUVKS2QYPphdW/1EfVA/WR+gwUdSpVC/WfuTXBwGN+fvocqlfzYcxUaIAw
Received-SPF: none client-ip=217.72.192.75; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 09:19:04
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

Le 23/07/2020 à 23:02, Filip Bozuta a écrit :
> Functions "print_ioctl()" and "print_syscall_ret_ioctl()" are used
> to print arguments of "ioctl()" with "-strace". These functions
> use "thunk_print()", which is defined in "thunk.c", to print the
> contents of ioctl's third arguments that are not basic types.
> 
> However, this function doesn't handle ioctls of group ioctl_tty which
> are used for terminals and serial lines. These ioctls use a type
> "struct termios" which thunk type is defined in a non standard
> way using "STRUCT_SPECIAL()". This means that this type is not decoded
> regularly using "thunk_convert()" and uses special converting functions
> "target_to_host_termios()" and "host_to_target_termios()", which are defined
> in "syscall.c" to decode it's values.
> 
> For simillar reasons, this type is also not printed regularly using
> "thunk_print()". That is the reason why a separate printing function
> "print_termios()" is defined in file "strace.c". This function decodes
> and prints flag values of the "termios" structure.
> 
> Implementation notes:
> 
>     Function "print_termios()" was implemented in "strace.c" using
>     an existing function "print_flags()" to print flag values of
>     "struct termios" fields. Also, recently implemented function
>     "print_enums()" was also used to print enumareted values which
>     are contained in the fields of 'struct termios'.
> 
>     These flag values were defined using an existing macro "FLAG_TARGET()"
>     that generates aproppriate target flag values and string representations
>     of these flags. Also, the recently defined macro "ENUM_TARGET()" was
>     used to generate aproppriate enumarated values and their respective
>     string representations.
> 
>     Function "print_termios()" was declared in "qemu.h" so that it can
>     be accessed in "syscall.c". Type "StructEntry" defined in
>     "exec/user/thunk.h" contains information that is used to decode
>     structure values. Field "void print(void *arg)" was added in this
>     structure as a special print function. Also, function "thunk_print()"
>     was changed a little so that it uses this special print function
>     in case it is defined. This printing function was instantiated with
>     the defined "print_termios()" in "syscall.c" in "struct_termios_def".
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  include/exec/user/thunk.h |   1 +
>  linux-user/qemu.h         |   1 +
>  linux-user/strace.c       | 195 ++++++++++++++++++++++++++++++++++++++
>  linux-user/syscall.c      |   1 +
>  thunk.c                   |  23 +++--
>  5 files changed, 212 insertions(+), 9 deletions(-)
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
> index f431805e57..a69a0bd347 100644
> --- a/linux-user/qemu.h
> +++ b/linux-user/qemu.h
> @@ -706,6 +706,7 @@ static inline uint64_t target_offset64(uint64_t word0, uint64_t word1)
>  }
>  #endif /* TARGET_ABI_BITS != 32 */
>  
> +void print_termios(void *arg);
>  
>  /* ARM EABI and MIPS expect 64bit types aligned even on pairs or registers */
>  #ifdef TARGET_ARM
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 3f16bb2c53..b9ba39ce6e 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -1284,6 +1284,140 @@ UNUSED static struct flags falloc_flags[] = {
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
> +    FLAG_TARGET(IUTF8),
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
> +UNUSED static struct enums termios_oflags_NLDLY[] = {
> +    ENUM_TARGET(NL0),
> +    ENUM_TARGET(NL1),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_oflags_CRDLY[] = {
> +    ENUM_TARGET(CR0),
> +    ENUM_TARGET(CR1),
> +    ENUM_TARGET(CR2),
> +    ENUM_TARGET(CR3),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_oflags_TABDLY[] = {
> +    ENUM_TARGET(TAB0),
> +    ENUM_TARGET(TAB1),
> +    ENUM_TARGET(TAB2),
> +    ENUM_TARGET(TAB3),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_oflags_VTDLY[] = {
> +    ENUM_TARGET(VT0),
> +    ENUM_TARGET(VT1),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_oflags_FFDLY[] = {
> +    ENUM_TARGET(FF0),
> +    ENUM_TARGET(FF1),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_oflags_BSDLY[] = {
> +    ENUM_TARGET(BS0),
> +    ENUM_TARGET(BS1),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_cflags_CBAUD[] = {
> +    ENUM_TARGET(B0),
> +    ENUM_TARGET(B50),
> +    ENUM_TARGET(B75),
> +    ENUM_TARGET(B110),
> +    ENUM_TARGET(B134),
> +    ENUM_TARGET(B150),
> +    ENUM_TARGET(B200),
> +    ENUM_TARGET(B300),
> +    ENUM_TARGET(B600),
> +    ENUM_TARGET(B1200),
> +    ENUM_TARGET(B1800),
> +    ENUM_TARGET(B2400),
> +    ENUM_TARGET(B4800),
> +    ENUM_TARGET(B9600),
> +    ENUM_TARGET(B19200),
> +    ENUM_TARGET(B38400),
> +    ENUM_TARGET(B57600),
> +    ENUM_TARGET(B115200),
> +    ENUM_TARGET(B230400),
> +    ENUM_TARGET(B460800),
> +    ENUM_END,
> +};
> +
> +UNUSED static struct enums termios_cflags_CSIZE[] = {
> +    ENUM_TARGET(CS5),
> +    ENUM_TARGET(CS6),
> +    ENUM_TARGET(CS7),
> +    ENUM_TARGET(CS8),
> +    ENUM_END,
> +};
> +
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
> +
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
> +    FLAG_TARGET(EXTPROC),
> +    FLAG_END,
> +};
> +
>  UNUSED static struct flags mlockall_flags[] = {
>      FLAG_TARGET(MCL_CURRENT),
>      FLAG_TARGET(MCL_FUTURE),
> @@ -1579,6 +1713,67 @@ print_itimerval(abi_ulong it_addr, int last)
>      }
>  }
>  
> +void
> +print_termios(void *arg)
> +{
> +    const struct target_termios *target = arg;
> +
> +    target_tcflag_t iflags = tswap32(target->c_iflag);
> +    target_tcflag_t oflags = tswap32(target->c_oflag);
> +    target_tcflag_t cflags = tswap32(target->c_cflag);
> +    target_tcflag_t lflags = tswap32(target->c_lflag);
> +
> +    qemu_log("{");
> +
> +    qemu_log("c_iflag = ");
> +    print_flags(termios_iflags, iflags, 0);
> +
> +    qemu_log("c_oflag = ");
> +    target_tcflag_t oflags_clean =  oflags & ~(TARGET_NLDLY | TARGET_CRDLY |
> +                                               TARGET_TABDLY | TARGET_BSDLY |
> +                                               TARGET_VTDLY | TARGET_FFDLY);
> +    print_flags(termios_oflags, oflags_clean, 0);
> +    if (oflags & TARGET_NLDLY) {
> +        print_enums(termios_oflags_NLDLY, oflags & TARGET_NLDLY, 0);
> +    }
> +    if (oflags & TARGET_CRDLY) {
> +        print_enums(termios_oflags_CRDLY, oflags & TARGET_CRDLY, 0);
> +    }
> +    if (oflags & TARGET_TABDLY) {
> +        print_enums(termios_oflags_TABDLY, oflags & TARGET_TABDLY, 0);
> +    }
> +    if (oflags & TARGET_BSDLY) {
> +        print_enums(termios_oflags_BSDLY, oflags & TARGET_BSDLY, 0);
> +    }
> +    if (oflags & TARGET_VTDLY) {
> +        print_enums(termios_oflags_VTDLY, oflags & TARGET_VTDLY, 0);
> +    }
> +    if (oflags & TARGET_FFDLY) {
> +        print_enums(termios_oflags_FFDLY, oflags & TARGET_FFDLY, 0);
> +    }
> +
> +    qemu_log("c_cflag = ");
> +    if (cflags & TARGET_CBAUD) {
> +        print_enums(termios_cflags_CBAUD, cflags & TARGET_CBAUD, 0);
> +    }
> +    if (cflags & TARGET_CSIZE) {
> +        print_enums(termios_cflags_CSIZE, cflags & TARGET_CSIZE, 0);
> +    }
> +    target_tcflag_t cflags_clean = cflags & ~(TARGET_CBAUD | TARGET_CSIZE);
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
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e815f14bac..6dc230cd0b 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -5669,6 +5669,7 @@ static const StructEntry struct_termios_def = {
>      .convert = { host_to_target_termios, target_to_host_termios },
>      .size = { sizeof(struct target_termios), sizeof(struct host_termios) },
>      .align = { __alignof__(struct target_termios), __alignof__(struct host_termios) },
> +    .print = print_termios,
>  };
>  
>  static bitmask_transtbl mmap_flags_tbl[] = {
> diff --git a/thunk.c b/thunk.c
> index c5d9719747..0718325d86 100644
> --- a/thunk.c
> +++ b/thunk.c
> @@ -404,19 +404,24 @@ const argtype *thunk_print(void *arg, const argtype *type_ptr)
>              const int *arg_offsets;
>  
>              se = struct_entries + *type_ptr++;
> -            a = arg;
>  
> -            field_types = se->field_types;
> -            arg_offsets = se->field_offsets[0];
> +            if (se->print != NULL) {
> +                se->print(arg);
> +            } else {
> +                a = arg;
>  
> -            qemu_log("{");
> -            for (i = 0; i < se->nb_fields; i++) {
> -                if (i > 0) {
> -                    qemu_log(",");
> +                field_types = se->field_types;
> +                arg_offsets = se->field_offsets[0];
> +
> +                qemu_log("{");
> +                for (i = 0; i < se->nb_fields; i++) {
> +                    if (i > 0) {
> +                        qemu_log(",");
> +                    }
> +                    field_types = thunk_print(a + arg_offsets[i], field_types);
>                  }
> -                field_types = thunk_print(a + arg_offsets[i], field_types);
> +                qemu_log("}");
>              }
> -            qemu_log("}");
>          }
>          break;
>      default:
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

