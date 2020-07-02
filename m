Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8012C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A1DC420760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 09:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="SE+kXzBv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1DC420760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yadro.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36500 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqvfj-0000tm-Vk
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 05:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqvem-00007H-5k
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:37:24 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:49618 helo=mta-01.yadro.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.bolshakov@yadro.com>)
 id 1jqvek-0002DZ-40
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 05:37:23 -0400
Received: from localhost (unknown [127.0.0.1])
 by mta-01.yadro.com (Postfix) with ESMTP id D84304C8B5;
 Thu,  2 Jul 2020 09:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
 in-reply-to:content-disposition:content-type:content-type
 :mime-version:references:message-id:subject:subject:from:from
 :date:date:received:received:received; s=mta-01; t=1593682638;
 x=1595497039; bh=e04Fn1i1HTJ10VcYY1aJEDkEZq4GuP/OxxmZr322UJA=; b=
 SE+kXzBvCyu9woK3LAV0kOXNr1CG3HNS3QO2DqkNUOLj4sOC5AsoiinJWXnC4iO+
 fuvkz91tvFXUbdicTZSaw7855MfeqvGtto7+/QGoiWcGl2kosyeelEDjq3VWT9+s
 Q6dw8eBe/XB14qwbNLYu4g55KDer9JShcgy4zo068Xg=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
 by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QzeXvJimaJcH; Thu,  2 Jul 2020 12:37:18 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com
 [172.17.10.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by mta-01.yadro.com (Postfix) with ESMTPS id 49E83499B7;
 Thu,  2 Jul 2020 12:37:18 +0300 (MSK)
Received: from localhost (172.17.204.212) by T-EXCH-02.corp.yadro.com
 (172.17.10.102) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id 15.1.669.32; Thu, 2 Jul
 2020 12:37:18 +0300
Date: Thu, 2 Jul 2020 12:37:17 +0300
From: Roman Bolshakov <r.bolshakov@yadro.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] target/i386: implement undocumented "smsw r32" behavior
Message-ID: <20200702093717.GD78555@SPB-NB-133.local>
References: <20200626104419.15504-2-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20200626104419.15504-2-pbonzini@redhat.com>
X-Originating-IP: [172.17.204.212]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
Received-SPF: pass client-ip=89.207.88.252; envelope-from=r.bolshakov@yadro.com;
 helo=mta-01.yadro.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 05:37:20
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jun 26, 2020 at 06:44:19AM -0400, Paolo Bonzini wrote:
> In 32-bit mode, the higher 16 bits of the destination
> register are undefined.  In practice CR0[31:0] is stored,
> just like in 64-bit mode, so just remove the "if" that
> currently differentiates the behavior.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Hi Paolo,

It seems to be a follow-up to the kvm-unit-tests patch:
https://patchwork.kernel.org/patch/11590445/

Could you please add:
Reported-by: Roman Bolshakov <r.bolshakov@yadro.com>

> ---
>  target/i386/translate.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/target/i386/translate.c b/target/i386/translate.c
> index 4d808a6f93..60eac03498 100644
> --- a/target/i386/translate.c
> +++ b/target/i386/translate.c
> @@ -7579,12 +7579,13 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
>          CASE_MODRM_OP(4): /* smsw */
>              gen_svm_check_intercept(s, pc_start, SVM_EXIT_READ_CR0);
>              tcg_gen_ld_tl(s->T0, cpu_env, offsetof(CPUX86State, cr[0]));
> -            if (CODE64(s)) {
> -                mod = (modrm >> 6) & 3;
> -                ot = (mod != 3 ? MO_16 : s->dflag);
> -            } else {
> -                ot = MO_16;
> -            }
> +            /*
> +             * In 32-bit mode, the higher 16 bits of the destination
> +             * register are undefined.  In practice CR0[31:0] is stored
> +             * just like in 64-bit mode.
> +             */
> +            mod = (modrm >> 6) & 3;
> +            ot = (mod != 3 ? MO_16 : s->dflag);
>              gen_ldst_modrm(env, s, modrm, ot, OR_TMP0, 1);
>              break;
>          case 0xee: /* rdpkru */
> -- 
> 2.26.2
> 
> 

Reviewed-by: Roman Bolshakov <r.bolshakov@yadro.com>

Regards,
Roman

