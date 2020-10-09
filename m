Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE0FC433E7
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:32:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF2A6215A4
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 07:32:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g48YsXHg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF2A6215A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQmtK-0007ov-Lo
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 03:32:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36968)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQms8-0006gb-U0
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:31:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:43438)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kQms6-0006uB-Vn
 for qemu-devel@nongnu.org; Fri, 09 Oct 2020 03:31:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602228682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IAAgyDf8lsJ4HJgwL3qtS60L+U8ipZ66WzUSnd1eGVk=;
 b=g48YsXHgvO93/2XPyn6ql2Hp2VNyhIWuHpm+ctnmfohPOKMokxypF4QD2/0a8S5A9MKxjb
 yeqfUWfYwpZTE37lNrA3R1e1dkXjnLMpiDRhP5+tNXNkDjpsbq4hUyTxIo/JQZD/pHElww
 HxZtqV8mTqBtPvvHhKu6iL6r3G0chNE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-tvo74Dh3OUqBTM5wFZuoAQ-1; Fri, 09 Oct 2020 03:31:18 -0400
X-MC-Unique: tvo74Dh3OUqBTM5wFZuoAQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E9F1418A076E;
 Fri,  9 Oct 2020 07:31:16 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-47.ams2.redhat.com [10.36.112.47])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 61A5860CD0;
 Fri,  9 Oct 2020 07:31:15 +0000 (UTC)
Subject: Re: [PATCH V2 07/14] s390x/: fix some comment spelling errors
To: zhaolichang <zhaolichang@huawei.com>, qemu-trivial@nongnu.org
References: <20201009064449.2336-1-zhaolichang@huawei.com>
 <20201009064449.2336-8-zhaolichang@huawei.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <937308f7-a861-0930-4fd1-ecf815463012@redhat.com>
Date: Fri, 9 Oct 2020 09:31:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20201009064449.2336-8-zhaolichang@huawei.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/09 02:34:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.214, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: David Edmondson <david.edmondson@oracle.com>,
 qemu-s390x <qemu-s390x@nongnu.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/2020 08.44, zhaolichang wrote:
> I found that there are many spelling errors in the comments of qemu/target/s390x.
> I used spellcheck to check the spelling errors and found some errors in the folder.
> 
> Signed-off-by: zhaolichang <zhaolichang@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> ---
>  target/s390x/cpu_models.h       | 4 ++--
>  target/s390x/excp_helper.c      | 2 +-
>  target/s390x/fpu_helper.c       | 2 +-
>  target/s390x/insn-data.def      | 2 +-
>  target/s390x/misc_helper.c      | 2 +-
>  target/s390x/translate.c        | 4 ++--
>  target/s390x/translate_vx.c.inc | 2 +-
>  7 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/target/s390x/cpu_models.h b/target/s390x/cpu_models.h
> index 74d1f87e4f..15c0f0dcfe 100644
> --- a/target/s390x/cpu_models.h
> +++ b/target/s390x/cpu_models.h
> @@ -24,13 +24,13 @@ struct S390CPUDef {
>      uint8_t gen;            /* hw generation identification */
>      uint16_t type;          /* cpu type identification */
>      uint8_t ec_ga;          /* EC GA version (on which also the BC is based) */
> -    uint8_t mha_pow;        /* Maximum Host Adress Power, mha = 2^pow-1 */
> +    uint8_t mha_pow;        /* Maximum Host Address Power, mha = 2^pow-1 */
>      uint32_t hmfai;         /* hypervisor-managed facilities */
>      /* base/min features, must never be changed between QEMU versions */
>      S390FeatBitmap base_feat;
>      /* used to init base_feat from generated data */
>      S390FeatInit base_init;
> -    /* deafault features, QEMU version specific */
> +    /* default features, QEMU version specific */
>      S390FeatBitmap default_feat;
>      /* used to init default_feat from generated data */
>      S390FeatInit default_init;
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 0adfbbda27..36ab5c7c43 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -538,7 +538,7 @@ try_deliver:
>          /* don't trigger a cpu_loop_exit(), use an interrupt instead */
>          cpu_interrupt(CPU(cpu), CPU_INTERRUPT_HALT);
>      } else if (cs->halted) {
> -        /* unhalt if we had a WAIT PSW somehwere in our injection chain */
> +        /* unhalt if we had a WAIT PSW somewhere in our injection chain */
>          s390_cpu_unhalt(cpu);
>      }
>  }
> diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> index f155bc048c..3e609b7fd0 100644
> --- a/target/s390x/fpu_helper.c
> +++ b/target/s390x/fpu_helper.c
> @@ -89,7 +89,7 @@ static void handle_exceptions(CPUS390XState *env, bool XxC, uintptr_t retaddr)
>      /*
>       * invalid/divbyzero cannot coexist with other conditions.
>       * overflow/underflow however can coexist with inexact, we have to
> -     * handle it separatly.
> +     * handle it separately.
>       */
>      if (s390_exc & ~S390_IEEE_MASK_INEXACT) {
>          if (s390_exc & ~S390_IEEE_MASK_INEXACT & env->fpc >> 24) {
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index d3bcdfd67b..2469415319 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -526,7 +526,7 @@
>  /* LOAD LOGICAL HALFWORD RELATIVE LONG */
>      C(0xc402, LLHRL,   RIL_b, GIE, 0, ri2, new, r1_32, ld16u, 0)
>      C(0xc406, LLGHRL,  RIL_b, GIE, 0, ri2, r1, 0, ld16u, 0)
> -/* LOAD LOGICAL IMMEDATE */
> +/* LOAD LOGICAL IMMEDIATE */
>      D(0xc00e, LLIHF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 32)
>      D(0xc00f, LLILF,   RIL_a, EI, 0, i2_32u_shl, 0, r1, mov2, 0, 0)
>      D(0xa50c, LLIHH,   RI_a,  Z,  0, i2_16u_shl, 0, r1, mov2, 0, 48)
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 58dbc023eb..929e509519 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -312,7 +312,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>              /* same as machine type number in STORE CPU ID, but in EBCDIC */
>              snprintf(type, ARRAY_SIZE(type), "%X", cpu->model->def->type);
>              ebcdic_put(sysib.sysib_111.type, type, 4);
> -            /* model number (not stored in STORE CPU ID for z/Architecure) */
> +            /* model number (not stored in STORE CPU ID for z/Architecture) */
>              ebcdic_put(sysib.sysib_111.model, "QEMU            ", 16);
>              ebcdic_put(sysib.sysib_111.sequence, "QEMU            ", 16);
>              ebcdic_put(sysib.sysib_111.plant, "QEMU", 4);
> diff --git a/target/s390x/translate.c b/target/s390x/translate.c
> index ac10f42f10..4395455e0a 100644
> --- a/target/s390x/translate.c
> +++ b/target/s390x/translate.c
> @@ -433,7 +433,7 @@ static void gen_program_exception(DisasContext *s, int code)
>  {
>      TCGv_i32 tmp;
>  
> -    /* Remember what pgm exeption this was.  */
> +    /* Remember what pgm exception this was.  */
>      tmp = tcg_const_i32(code);
>      tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUS390XState, int_pgm_code));
>      tcg_temp_free_i32(tmp);
> @@ -489,7 +489,7 @@ static TCGv_i64 get_address(DisasContext *s, int x2, int b2, int d2)
>  
>      /*
>       * Note that d2 is limited to 20 bits, signed.  If we crop negative
> -     * displacements early we create larger immedate addends.
> +     * displacements early we create larger immediate addends.
>       */
>      if (b2 && x2) {
>          tcg_gen_add_i64(tmp, regs[b2], regs[x2]);
> diff --git a/target/s390x/translate_vx.c.inc b/target/s390x/translate_vx.c.inc
> index eb767f5288..983da56b9d 100644
> --- a/target/s390x/translate_vx.c.inc
> +++ b/target/s390x/translate_vx.c.inc
> @@ -789,7 +789,7 @@ static DisasJumpType op_vpk(DisasContext *s, DisasOps *o)
>          }
>          break;
>      case 0x94:
> -        /* If sources and destination dont't overlap -> fast path */
> +        /* If sources and destination don't overlap -> fast path */
>          if (v1 != v2 && v1 != v3) {
>              const uint8_t src_es = get_field(s, m4);
>              const uint8_t dst_es = src_es - 1;
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>


