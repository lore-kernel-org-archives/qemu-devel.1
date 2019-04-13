Return-Path: <SRS0=HErD=SP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D387C10F11
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 12:40:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9B3220818
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2019 12:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkKZfNnH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9B3220818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51408 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hFHxH-0004WE-0e
	for qemu-devel@archiver.kernel.org; Sat, 13 Apr 2019 08:40:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFHwP-0004Cp-KW
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:39:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hFHwN-0007us-59
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:39:29 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39125)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hFHwM-0007u0-Pj
	for qemu-devel@nongnu.org; Sat, 13 Apr 2019 08:39:27 -0400
Received: by mail-ot1-x344.google.com with SMTP id f10so10732972otb.6
	for <qemu-devel@nongnu.org>; Sat, 13 Apr 2019 05:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=SY/M10rHCdiyg6FDqU4D7tAIG3JwX4V+ckPXXYM9nbI=;
	b=mkKZfNnHVT9rVhUYpCGM7DJQDx18zqCZV/bChLrseDAw73xFverSQS8t4GNp/+YV80
	zBG0dLmcHxR+bCEs3uqIhsfTJSpRNEmpkGe5nBcjABuSL8Ri4yyq/r4yE+YPFR8pQdRD
	NtKIC7XbEDCYJZqkqcC31jGlqZJVLdPppX9B0dd14j2BnoOlq1BsFAQ+XTBf8ei0itGt
	q+W3YiC8KFTyd0zfK9cpM8RrpzhOWUwtQP3o01oKbgumnOcw1VbBcXMog63bd3yltG5s
	0uKxA+zZajyN25Z0NyWv2DvJtJibfNTwUPIa47j846LzEOaejhRcK7n75s2qVobPloIV
	DaNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=SY/M10rHCdiyg6FDqU4D7tAIG3JwX4V+ckPXXYM9nbI=;
	b=fZCRS1mcG7OO5OmXRyQrvXhyegKLXO9DFJXN8mE7gvoEyTHUKbC+FWpkKMm+o3cmrF
	aB3WuGaitIPwXdfd14jqX0ruSFykraFZDGi3x7oQ6rRlsIaPLKyYZVjdFSnrSoXpVLJD
	6LyveZr1cIMWCDivL+z1lHvLku4999hOqHOaeFvv5ZpFgg3lkv7J6jeI9YnhVc+V3R5p
	T9qnqPO9Ph71d/3PIDcJmSNd0jXtZVQRFbWEyuVJMIpbtMEHts+tBWK2QZl5tm3aD144
	P/p1FleGFisqKHWtHkfXrMF1B8FzEB6nHXuQ7wD1qYpE0DaEHFmScfv9uJKVBcEMuj3H
	yeDg==
X-Gm-Message-State: APjAAAWZ09UtgM9SMQvdIHld3whHDe0aAot+9POgxZPutoPRDCV+qsvp
	dI+xJlDmt35HUPEpomCXJZCbbS3RYcnCxQPHz1s=
X-Google-Smtp-Source: APXvYqyHGlQtpnNohikoB3aozJKcnYw4RxotktqNvOtrDaW1EWn4hUj8PkHqb9XsP/cn0PiXQkiRd0UExeitoPVaAD4=
X-Received: by 2002:a9d:6f8b:: with SMTP id h11mr39183305otq.58.1555159163818; 
	Sat, 13 Apr 2019 05:39:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP; Sat, 13 Apr 2019 05:39:22
	-0700 (PDT)
Received: by 2002:a9d:220e:0:0:0:0:0 with HTTP; Sat, 13 Apr 2019 05:39:22
	-0700 (PDT)
In-Reply-To: <20190413011302.6610-2-jbi.octave@gmail.com>
References: <20190413011302.6610-1-jbi.octave@gmail.com>
	<20190413011302.6610-2-jbi.octave@gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 13 Apr 2019 14:39:22 +0200
Message-ID:
 <CAL1e-=jYKXU4XFX5CLibztk87pehZ3dDH+sU4dpq5Om=_9kPHQ@mail.gmail.com>
To: Jules Irenge <jbi.octave@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v4 1/3] target/mips: add or remove space to
 fix checkpatch errors
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: arikalo@wavecomp.com, aurelien@aurel32.net, qemu-devel@nongnu.org,
	amarkovic@wavecomp.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190413123922.Am7QZlZVDxL7tjgovFXYrASY5l_hGK_gAKeb2v08_WY@z>

On Apr 13, 2019 3:16 AM, "Jules Irenge" <jbi.octave@gmail.com> wrote:
>
> Add or remove space to fix errors issued by checkpatch.pl tool
> "ERROR: spaces required around that..."
> "ERROR: space required after that..."
> "ERROR: space required before the open parenthesis"
> "ERROR: space required after that..."
> "ERROR: space prohibited between function name and open parenthesis"
> "ERROR: code indent should never use tabs"
> within "target/mips/cpu.h" file.
>
> Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> ---

Hello, Jules,

Thanks for the new version. However, I'm afraid you didn't merge the
patches 2 and 3 from v3, and now we have the same problem with this series
- checkpatch reports warnings for this series. You need to merge =E2=80=9Cs=
pace=E2=80=9C
patch and =E2=80=9Cline over 90 charcters=E2=80=9D patch to avoid that. a p=
atch series
can't be accepted without that.

Sincerely,
Aleksandar

>  target/mips/cpu.h | 162 +++++++++++++++++++++++-----------------------
>  1 file changed, 81 insertions(+), 81 deletions(-)
>
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index a10eeb0de3..4bfa24bda0 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -22,10 +22,10 @@ typedef struct CPUMIPSTLBContext CPUMIPSTLBContext;
>
>  typedef union wr_t wr_t;
>  union wr_t {
> -    int8_t  b[MSA_WRLEN/8];
> -    int16_t h[MSA_WRLEN/16];
> -    int32_t w[MSA_WRLEN/32];
> -    int64_t d[MSA_WRLEN/64];
> +    int8_t  b[MSA_WRLEN / 8];
> +    int16_t h[MSA_WRLEN / 16];
> +    int32_t w[MSA_WRLEN / 32];
> +    int64_t d[MSA_WRLEN / 64];
>  };
>
>  typedef union fpr_t fpr_t;
> @@ -71,16 +71,16 @@ struct CPUMIPSFPUContext {
>  #define FCR31_FS 24
>  #define FCR31_ABS2008 19
>  #define FCR31_NAN2008 18
> -#define SET_FP_COND(num,env)     do { ((env).fcr31) |=3D ((num) ? (1 <<
((num) + 24)) : (1 << 23)); } while(0)
> -#define CLEAR_FP_COND(num,env)   do { ((env).fcr31) &=3D ~((num) ? (1 <<
((num) + 24)) : (1 << 23)); } while(0)
> +#define SET_FP_COND(num, env)     do { ((env).fcr31) |=3D ((num) ? (1 <<
((num) + 24)) : (1 << 23)); } while (0)
> +#define CLEAR_FP_COND(num, env)   do { ((env).fcr31) &=3D ~((num) ? (1 <=
<
((num) + 24)) : (1 << 23)); } while (0)
>  #define GET_FP_COND(env)         ((((env).fcr31 >> 24) & 0xfe) |
(((env).fcr31 >> 23) & 0x1))
>  #define GET_FP_CAUSE(reg)        (((reg) >> 12) & 0x3f)
>  #define GET_FP_ENABLE(reg)       (((reg) >>  7) & 0x1f)
>  #define GET_FP_FLAGS(reg)        (((reg) >>  2) & 0x1f)
> -#define SET_FP_CAUSE(reg,v)      do { (reg) =3D ((reg) & ~(0x3f << 12)) =
|
((v & 0x3f) << 12); } while(0)
> -#define SET_FP_ENABLE(reg,v)     do { (reg) =3D ((reg) & ~(0x1f <<  7)) =
|
((v & 0x1f) << 7); } while(0)
> -#define SET_FP_FLAGS(reg,v)      do { (reg) =3D ((reg) & ~(0x1f <<  2)) =
|
((v & 0x1f) << 2); } while(0)
> -#define UPDATE_FP_FLAGS(reg,v)   do { (reg) |=3D ((v & 0x1f) << 2); }
while(0)
> +#define SET_FP_CAUSE(reg, v)      do { (reg) =3D ((reg) & ~(0x3f << 12))=
 |
((v & 0x3f) << 12); } while (0)
> +#define SET_FP_ENABLE(reg, v)     do { (reg) =3D ((reg) & ~(0x1f <<  7))=
 |
((v & 0x1f) << 7); } while (0)
> +#define SET_FP_FLAGS(reg, v)      do { (reg) =3D ((reg) & ~(0x1f <<  2))=
 |
((v & 0x1f) << 2); } while (0)
> +#define UPDATE_FP_FLAGS(reg, v)   do { (reg) |=3D ((v & 0x1f) << 2); }
while (0)
>  #define FP_INEXACT        1
>  #define FP_UNDERFLOW      2
>  #define FP_OVERFLOW       4
> @@ -95,25 +95,25 @@ struct CPUMIPSFPUContext {
>  typedef struct CPUMIPSMVPContext CPUMIPSMVPContext;
>  struct CPUMIPSMVPContext {
>      int32_t CP0_MVPControl;
> -#define CP0MVPCo_CPA   3
> -#define CP0MVPCo_STLB  2
> -#define CP0MVPCo_VPC   1
> -#define CP0MVPCo_EVP   0
> +#define CP0MVPCo_CPA    3
> +#define CP0MVPCo_STLB   2
> +#define CP0MVPCo_VPC    1
> +#define CP0MVPCo_EVP    0
>      int32_t CP0_MVPConf0;
> -#define CP0MVPC0_M     31
> -#define CP0MVPC0_TLBS  29
> -#define CP0MVPC0_GS    28
> -#define CP0MVPC0_PCP   27
> -#define CP0MVPC0_PTLBE 16
> -#define CP0MVPC0_TCA   15
> -#define CP0MVPC0_PVPE  10
> -#define CP0MVPC0_PTC   0
> +#define CP0MVPC0_M      31
> +#define CP0MVPC0_TLBS   29
> +#define CP0MVPC0_GS     28
> +#define CP0MVPC0_PCP    27
> +#define CP0MVPC0_PTLBE  16
> +#define CP0MVPC0_TCA    15
> +#define CP0MVPC0_PVPE   10
> +#define CP0MVPC0_PTC    0
>      int32_t CP0_MVPConf1;
> -#define CP0MVPC1_CIM   31
> -#define CP0MVPC1_CIF   30
> -#define CP0MVPC1_PCX   20
> -#define CP0MVPC1_PCP2  10
> -#define CP0MVPC1_PCP1  0
> +#define CP0MVPC1_CIM    31
> +#define CP0MVPC1_CIF    30
> +#define CP0MVPC1_PCX    20
> +#define CP0MVPC1_PCP2   10
> +#define CP0MVPC1_PCP1   0
>  };
>
>  typedef struct mips_def_t mips_def_t;
> @@ -481,44 +481,44 @@ struct CPUMIPSState {
>   */
>      int32_t CP0_Random;
>      int32_t CP0_VPEControl;
> -#define CP0VPECo_YSI   21
> -#define CP0VPECo_GSI   20
> -#define CP0VPECo_EXCPT 16
> -#define CP0VPECo_TE    15
> -#define CP0VPECo_TargTC        0
> +#define CP0VPECo_YSI    21
> +#define CP0VPECo_GSI    20
> +#define CP0VPECo_EXCPT  16
> +#define CP0VPECo_TE     15
> +#define CP0VPECo_TargTC 0
>      int32_t CP0_VPEConf0;
> -#define CP0VPEC0_M     31
> -#define CP0VPEC0_XTC   21
> -#define CP0VPEC0_TCS   19
> -#define CP0VPEC0_SCS   18
> -#define CP0VPEC0_DSC   17
> -#define CP0VPEC0_ICS   16
> -#define CP0VPEC0_MVP   1
> -#define CP0VPEC0_VPA   0
> +#define CP0VPEC0_M      31
> +#define CP0VPEC0_XTC    21
> +#define CP0VPEC0_TCS    19
> +#define CP0VPEC0_SCS    18
> +#define CP0VPEC0_DSC    17
> +#define CP0VPEC0_ICS    16
> +#define CP0VPEC0_MVP    1
> +#define CP0VPEC0_VPA    0
>      int32_t CP0_VPEConf1;
> -#define CP0VPEC1_NCX   20
> -#define CP0VPEC1_NCP2  10
> -#define CP0VPEC1_NCP1  0
> +#define CP0VPEC1_NCX    20
> +#define CP0VPEC1_NCP2   10
> +#define CP0VPEC1_NCP1   0
>      target_ulong CP0_YQMask;
>      target_ulong CP0_VPESchedule;
>      target_ulong CP0_VPEScheFBack;
>      int32_t CP0_VPEOpt;
> -#define CP0VPEOpt_IWX7 15
> -#define CP0VPEOpt_IWX6 14
> -#define CP0VPEOpt_IWX5 13
> -#define CP0VPEOpt_IWX4 12
> -#define CP0VPEOpt_IWX3 11
> -#define CP0VPEOpt_IWX2 10
> -#define CP0VPEOpt_IWX1 9
> -#define CP0VPEOpt_IWX0 8
> -#define CP0VPEOpt_DWX7 7
> -#define CP0VPEOpt_DWX6 6
> -#define CP0VPEOpt_DWX5 5
> -#define CP0VPEOpt_DWX4 4
> -#define CP0VPEOpt_DWX3 3
> -#define CP0VPEOpt_DWX2 2
> -#define CP0VPEOpt_DWX1 1
> -#define CP0VPEOpt_DWX0 0
> +#define CP0VPEOpt_IWX7  15
> +#define CP0VPEOpt_IWX6  14
> +#define CP0VPEOpt_IWX5  13
> +#define CP0VPEOpt_IWX4  12
> +#define CP0VPEOpt_IWX3  11
> +#define CP0VPEOpt_IWX2  10
> +#define CP0VPEOpt_IWX1  9
> +#define CP0VPEOpt_IWX0  8
> +#define CP0VPEOpt_DWX7  7
> +#define CP0VPEOpt_DWX6  6
> +#define CP0VPEOpt_DWX5  5
> +#define CP0VPEOpt_DWX4  4
> +#define CP0VPEOpt_DWX3  3
> +#define CP0VPEOpt_DWX2  2
> +#define CP0VPEOpt_DWX1  1
> +#define CP0VPEOpt_DWX0  0
>  /*
>   * CP0 Register 2
>   */
> @@ -625,33 +625,33 @@ struct CPUMIPSState {
>  #define CP0PC_PSN       0     /*  5..0  */
>      int32_t CP0_SRSConf0_rw_bitmask;
>      int32_t CP0_SRSConf0;
> -#define CP0SRSC0_M     31
> -#define CP0SRSC0_SRS3  20
> -#define CP0SRSC0_SRS2  10
> -#define CP0SRSC0_SRS1  0
> +#define CP0SRSC0_M      31
> +#define CP0SRSC0_SRS3   20
> +#define CP0SRSC0_SRS2   10
> +#define CP0SRSC0_SRS1   0
>      int32_t CP0_SRSConf1_rw_bitmask;
>      int32_t CP0_SRSConf1;
> -#define CP0SRSC1_M     31
> -#define CP0SRSC1_SRS6  20
> -#define CP0SRSC1_SRS5  10
> -#define CP0SRSC1_SRS4  0
> +#define CP0SRSC1_M      31
> +#define CP0SRSC1_SRS6   20
> +#define CP0SRSC1_SRS5   10
> +#define CP0SRSC1_SRS4   0
>      int32_t CP0_SRSConf2_rw_bitmask;
>      int32_t CP0_SRSConf2;
> -#define CP0SRSC2_M     31
> -#define CP0SRSC2_SRS9  20
> -#define CP0SRSC2_SRS8  10
> -#define CP0SRSC2_SRS7  0
> +#define CP0SRSC2_M      31
> +#define CP0SRSC2_SRS9   20
> +#define CP0SRSC2_SRS8   10
> +#define CP0SRSC2_SRS7   0
>      int32_t CP0_SRSConf3_rw_bitmask;
>      int32_t CP0_SRSConf3;
> -#define CP0SRSC3_M     31
> -#define CP0SRSC3_SRS12 20
> -#define CP0SRSC3_SRS11 10
> -#define CP0SRSC3_SRS10 0
> +#define CP0SRSC3_M      31
> +#define CP0SRSC3_SRS12  20
> +#define CP0SRSC3_SRS11  10
> +#define CP0SRSC3_SRS10  0
>      int32_t CP0_SRSConf4_rw_bitmask;
>      int32_t CP0_SRSConf4;
> -#define CP0SRSC4_SRS15 20
> -#define CP0SRSC4_SRS14 10
> -#define CP0SRSC4_SRS13 0
> +#define CP0SRSC4_SRS15  20
> +#define CP0SRSC4_SRS14  10
> +#define CP0SRSC4_SRS13  0
>  /*
>   * CP0 Register 7
>   */
> @@ -1065,7 +1065,7 @@ static inline MIPSCPU
*mips_env_get_cpu(CPUMIPSState *env)
>
>  #define ENV_OFFSET offsetof(MIPSCPU, env)
>
> -void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf);
> +void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf);
>
>  #define cpu_signal_handler cpu_mips_signal_handler
>  #define cpu_list mips_cpu_list
> @@ -1090,7 +1090,7 @@ static inline int hflags_mmu_index(uint32_t hflags)
>      }
>  }
>
> -static inline int cpu_mmu_index (CPUMIPSState *env, bool ifetch)
> +static inline int cpu_mmu_index(CPUMIPSState *env, bool ifetch)
>  {
>      return hflags_mmu_index(env->hflags);
>  }
> @@ -1182,7 +1182,7 @@ void cpu_mips_soft_irq(CPUMIPSState *env, int irq,
int level);
>  void itc_reconfigure(struct MIPSITUState *tag);
>
>  /* helper.c */
> -target_ulong exception_resume_pc (CPUMIPSState *env);
> +target_ulong exception_resume_pc(CPUMIPSState *env);
>
>  static inline void restore_snan_bit_mode(CPUMIPSState *env)
>  {
> --
> 2.20.1
>
>
