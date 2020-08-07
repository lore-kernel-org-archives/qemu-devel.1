Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D03C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0AE2075D
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 11:23:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0AE2075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49502 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k40T5-000186-Jc
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 07:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40SH-0000DR-RM
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:22:33 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:36681)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1k40SG-00082g-0D
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 07:22:33 -0400
Received: from [192.168.100.1] ([82.252.135.186]) by mrelayeu.kundenserver.de
 (mreue109 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MtwQk-1krhnT3jLQ-00uLAF; Fri, 07 Aug 2020 13:22:28 +0200
Subject: Re: [PATCH v3 4/5] linux-user: Add an api to print enumareted
 argument values with strace
To: Filip Bozuta <Filip.Bozuta@syrmia.com>, qemu-devel@nongnu.org
References: <20200722200437.312767-1-Filip.Bozuta@syrmia.com>
 <20200722200437.312767-5-Filip.Bozuta@syrmia.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <113934c1-dcff-8a38-40a4-d42b89fd0b97@vivier.eu>
Date: Fri, 7 Aug 2020 13:22:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722200437.312767-5-Filip.Bozuta@syrmia.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nf3WH+Kz4CtQ5DFOffFfvqtSmIEBwZYHzxMdKZk5/leSjdPEVHB
 QbPEBxSsnW+85IxrYrfAJDCPQ8I1sSqeF1vTenMVBjDK6GOBeD7jjCMjr9zkXjvvZ7eoHxS
 BC2AnXP/TewdGZBORTKNHk1UOcAVgTt4HKLXZ2RyKu3TFmfV/TQKB5HDafiByYcm3azNSxh
 lUyk9ohjTEjZ2K0O4kuYg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ihv0Cr/Q+6w=:ZGAhZl7Nt4riI4wrq29ck9
 P2Sd924G5by2dTfUy2UJDaIRA1tTHATPmIkn1I1npBt3bIsMZeNbtY97C5XJPWTkLPVN50zsk
 u6TdOGvEvaBWXX55tPbQzIaO7nSMe4dtfGOVL7RdRNYHcL2LUqdPQvTXANbbXPE9MZTk9cMYh
 kL+/bqObFdtpSjLEyIACUhHTg8SUrkS1YguVUpmxnC8axPfw4QyLrY7b9o/LJ5tIBs4fPiV8+
 RCMWI+OXEfLeNTYPmjWuVsFJgmnYLdEci4Z7hTYidt6cxJ952kLHt6aPUppSudF7rILID760Z
 t6sEIlIJzCqS7onMG0M3CjzYKb/GnhW9bpba+HCO55/YQamzo6csuNj12Uwu2l4DtHil/ZzNo
 1pA1BPFtgbtSQv+/9sgFdqQ8iUtYd1guNq1jSAl7sEYPoykvwayJT0xk9mjHC6bZ+5tWdv/pr
 aQvliHNAGskIBxgLaPl3lqVLCvu274LwP1yuI7Y6GVU6BSSGy/rld5/cCTqKUd17TElUzb3Tf
 V0bLB/ApdXY59dULNvCAKjWc3E9+SxQl4ZFXyavBv864MRPlISdeaGdmbVEz2mL+GyGT8IkJ+
 vFDgDXTMJLa6u6lXhdB54q6tVxdnk+HePiC1bUNd6eIIe2fysB8EbffmRoAHJunZZHneQipiC
 IIsiYG0pIPJtJW2AupR7t5bqqo7rreN3LGJZ4Arjyx4oC61x63byttVb2P+6J6CWXKHllqBXY
 TXEWEZX5frUnIfY4iH2Gl+JsuE7zPVKiH4nqCDVhuEtiuqTDp5NPOatHOKh0krejt/7yUFDxU
 HFtcYw6fMmoK71pFsjHGkZsCuKRf42Hk5EOlai/1zezq5OqknzK899qsRedYkWFYmXpScs4
Received-SPF: none client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 07:22:30
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 22/07/2020 à 22:04, Filip Bozuta a écrit :
> This patch introduces a type 'struct enums' and function 'print_enums()'
> that can be used to print enumerated argument values of some syscalls
> in strace. This can be used in future strace implementations.
> 
> Also, macros 'ENUM_GENERIC()', 'ENUM_TARGET()' and 'ENUM_END', are
> introduced to enable automatic generation of aproppriate enumarated
> values and their repsective string representations (these macros are
> exactly the same as 'FLAG_GENERIC()', 'FLAG_TARGET()' and 'FLAG_END').
> 
> Future patches are planned to modify all existing print functions in
> 'strace.c' that print arguments of syscalls with enumerated values to
> use this new api.
> 
> Signed-off-by: Filip Bozuta <Filip.Bozuta@syrmia.com>
> ---
>  linux-user/strace.c | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/linux-user/strace.c b/linux-user/strace.c
> index 40f863c6e2..def92c4d73 100644
> --- a/linux-user/strace.c
> +++ b/linux-user/strace.c
> @@ -52,9 +52,23 @@ struct flags {
>  /* end of flags array */
>  #define FLAG_END           { 0, NULL }
>  
> +/* Structure used to translate enumerated values into strings */
> +struct enums {
> +    abi_long    e_value;   /* enum value */
> +    const char  *e_string; /* stringified enum */
> +};
> +
> +/* common enums for all architectures */
> +#define ENUM_GENERIC(name) { name, #name }
> +/* target specific enums */
> +#define ENUM_TARGET(name)  { TARGET_ ## name, #name }
> +/* end of enums array */
> +#define ENUM_END           { 0, NULL }
> +
>  UNUSED static const char *get_comma(int);
>  UNUSED static void print_pointer(abi_long, int);
>  UNUSED static void print_flags(const struct flags *, abi_long, int);
> +UNUSED static void print_enums(const struct enums *, abi_long, int);
>  UNUSED static void print_at_dirfd(abi_long, int);
>  UNUSED static void print_file_mode(abi_long, int);
>  UNUSED static void print_open_flags(abi_long, int);
> @@ -1248,6 +1262,23 @@ print_flags(const struct flags *f, abi_long flags, int last)
>      }
>  }
>  
> +static void
> +print_enums(const struct enums *e, abi_long enum_arg, int last)
> +{
> +    for (; e->e_string != NULL; e++) {
> +        if (e->e_value == enum_arg) {
> +            qemu_log("%s", e->e_string);
> +            break;
> +        }
> +    }
> +
> +    if (e->e_string == NULL) {
> +        qemu_log("%#x", (unsigned int)enum_arg);
> +    }
> +
> +    qemu_log("%s", get_comma(last));
> +}
> +
>  static void
>  print_at_dirfd(abi_long dirfd, int last)
>  {
> 

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

