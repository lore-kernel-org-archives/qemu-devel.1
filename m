Received: from eggs.gnu.org ([2001:4830:134:3::10]:58436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1die40-0006qy-5N
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1die3v-0003YM-9Z
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:59:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55020)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1die3v-0003Xc-0D
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 05:59:31 -0400
References: <20170817092225.4264-1-david@redhat.com>
	<20170817092225.4264-2-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <69dfd14d-ace7-9413-509f-a43ccdccc6ef@redhat.com>
Date: Fri, 18 Aug 2017 11:59:24 +0200
MIME-Version: 1.0
In-Reply-To: <20170817092225.4264-2-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1 for-2.11 01/10] target/s390x: move
 cc_name() to cc_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, borntraeger@de.ibm.com

On 17.08.2017 11:22, David Hildenbrand wrote:
> While at it, move the translations into the function.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/cc_helper.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
>  target/s390x/cpu.h       | 48 +-----------------------------------------------
>  2 files changed, 49 insertions(+), 47 deletions(-)
> 
> diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
> index 1cf8551..a4562e5 100644
> --- a/target/s390x/cc_helper.c
> +++ b/target/s390x/cc_helper.c
> @@ -31,6 +31,54 @@
>  #define HELPER_LOG(x...)
>  #endif
>  
> +const char *cc_name(int cc_op)
> +{
> +    static const char *cc_names[] = {
> +        [CC_OP_CONST0]    = "CC_OP_CONST0",
> +        [CC_OP_CONST1]    = "CC_OP_CONST1",
> +        [CC_OP_CONST2]    = "CC_OP_CONST2",
> +        [CC_OP_CONST3]    = "CC_OP_CONST3",
> +        [CC_OP_DYNAMIC]   = "CC_OP_DYNAMIC",
> +        [CC_OP_STATIC]    = "CC_OP_STATIC",
> +        [CC_OP_NZ]        = "CC_OP_NZ",
> +        [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
> +        [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
> +        [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
> +        [CC_OP_LTUGTU_64] = "CC_OP_LTUGTU_64",
> +        [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
> +        [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
> +        [CC_OP_ADD_64]    = "CC_OP_ADD_64",
> +        [CC_OP_ADDU_64]   = "CC_OP_ADDU_64",
> +        [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
> +        [CC_OP_SUB_64]    = "CC_OP_SUB_64",
> +        [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
> +        [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
> +        [CC_OP_ABS_64]    = "CC_OP_ABS_64",
> +        [CC_OP_NABS_64]   = "CC_OP_NABS_64",
> +        [CC_OP_ADD_32]    = "CC_OP_ADD_32",
> +        [CC_OP_ADDU_32]   = "CC_OP_ADDU_32",
> +        [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
> +        [CC_OP_SUB_32]    = "CC_OP_SUB_32",
> +        [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
> +        [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
> +        [CC_OP_ABS_32]    = "CC_OP_ABS_32",
> +        [CC_OP_NABS_32]   = "CC_OP_NABS_32",
> +        [CC_OP_COMP_32]   = "CC_OP_COMP_32",
> +        [CC_OP_COMP_64]   = "CC_OP_COMP_64",
> +        [CC_OP_TM_32]     = "CC_OP_TM_32",
> +        [CC_OP_TM_64]     = "CC_OP_TM_64",
> +        [CC_OP_NZ_F32]    = "CC_OP_NZ_F32",
> +        [CC_OP_NZ_F64]    = "CC_OP_NZ_F64",
> +        [CC_OP_NZ_F128]   = "CC_OP_NZ_F128",
> +        [CC_OP_ICM]       = "CC_OP_ICM",
> +        [CC_OP_SLA_32]    = "CC_OP_SLA_32",
> +        [CC_OP_SLA_64]    = "CC_OP_SLA_64",
> +        [CC_OP_FLOGR]     = "CC_OP_FLOGR",
> +    };
> +
> +    return cc_names[cc_op];
> +}
> +
>  static uint32_t cc_calc_ltgt_32(int32_t src, int32_t dst)
>  {
>      if (src == dst) {
> diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
> index 29fdd5d..3e798ef 100644
> --- a/target/s390x/cpu.h
> +++ b/target/s390x/cpu.h
> @@ -744,53 +744,7 @@ enum cc_op {
>      CC_OP_MAX
>  };
>  
> -static const char *cc_names[] = {
> -    [CC_OP_CONST0]    = "CC_OP_CONST0",
> -    [CC_OP_CONST1]    = "CC_OP_CONST1",
> -    [CC_OP_CONST2]    = "CC_OP_CONST2",
> -    [CC_OP_CONST3]    = "CC_OP_CONST3",
> -    [CC_OP_DYNAMIC]   = "CC_OP_DYNAMIC",
> -    [CC_OP_STATIC]    = "CC_OP_STATIC",
> -    [CC_OP_NZ]        = "CC_OP_NZ",
> -    [CC_OP_LTGT_32]   = "CC_OP_LTGT_32",
> -    [CC_OP_LTGT_64]   = "CC_OP_LTGT_64",
> -    [CC_OP_LTUGTU_32] = "CC_OP_LTUGTU_32",
> -    [CC_OP_LTUGTU_64] = "CC_OP_LTUGTU_64",
> -    [CC_OP_LTGT0_32]  = "CC_OP_LTGT0_32",
> -    [CC_OP_LTGT0_64]  = "CC_OP_LTGT0_64",
> -    [CC_OP_ADD_64]    = "CC_OP_ADD_64",
> -    [CC_OP_ADDU_64]   = "CC_OP_ADDU_64",
> -    [CC_OP_ADDC_64]   = "CC_OP_ADDC_64",
> -    [CC_OP_SUB_64]    = "CC_OP_SUB_64",
> -    [CC_OP_SUBU_64]   = "CC_OP_SUBU_64",
> -    [CC_OP_SUBB_64]   = "CC_OP_SUBB_64",
> -    [CC_OP_ABS_64]    = "CC_OP_ABS_64",
> -    [CC_OP_NABS_64]   = "CC_OP_NABS_64",
> -    [CC_OP_ADD_32]    = "CC_OP_ADD_32",
> -    [CC_OP_ADDU_32]   = "CC_OP_ADDU_32",
> -    [CC_OP_ADDC_32]   = "CC_OP_ADDC_32",
> -    [CC_OP_SUB_32]    = "CC_OP_SUB_32",
> -    [CC_OP_SUBU_32]   = "CC_OP_SUBU_32",
> -    [CC_OP_SUBB_32]   = "CC_OP_SUBB_32",
> -    [CC_OP_ABS_32]    = "CC_OP_ABS_32",
> -    [CC_OP_NABS_32]   = "CC_OP_NABS_32",
> -    [CC_OP_COMP_32]   = "CC_OP_COMP_32",
> -    [CC_OP_COMP_64]   = "CC_OP_COMP_64",
> -    [CC_OP_TM_32]     = "CC_OP_TM_32",
> -    [CC_OP_TM_64]     = "CC_OP_TM_64",
> -    [CC_OP_NZ_F32]    = "CC_OP_NZ_F32",
> -    [CC_OP_NZ_F64]    = "CC_OP_NZ_F64",
> -    [CC_OP_NZ_F128]   = "CC_OP_NZ_F128",
> -    [CC_OP_ICM]       = "CC_OP_ICM",
> -    [CC_OP_SLA_32]    = "CC_OP_SLA_32",
> -    [CC_OP_SLA_64]    = "CC_OP_SLA_64",
> -    [CC_OP_FLOGR]     = "CC_OP_FLOGR",
> -};
> -
> -static inline const char *cc_name(int cc_op)
> -{
> -    return cc_names[cc_op];
> -}
> +const char *cc_name(int cc_op);
>  
>  static inline void setcc(S390CPU *cpu, uint64_t cc)
>  {
> 

Just compiled with --disable-tcg

s390_cpu_dump_state() needs cc_name. I suggest moving it to helper.c
instead. Opinions?

-- 

Thanks,

David
