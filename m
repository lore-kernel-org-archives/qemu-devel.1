Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAE58C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB15A2081B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 11:31:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB15A2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbxu-00030G-RV
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 07:31:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49574)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hqbxa-0002Jf-Td
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:30:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hqbxZ-0006rl-Mw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:30:58 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:45196)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hqbxZ-0006r5-Fb
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 07:30:57 -0400
Received: by mail-wr1-f67.google.com with SMTP id f9so50338184wre.12
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 04:30:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=C5Rni6xcppwQX73lDjX1/8naB0Nngge1M5Zl3vPa2Hw=;
 b=h0pn1CGq5h55mne43++V0zrBRETxRfywQVfQyn0z74fTXsJ9iGgGflDcqk8i+sAfCx
 ul2MNVp5ORHSoUxrEIX9KKrxhX1W+V5Cel4qkXgmUrOqhp1rXvAmXXO0Gr76e72HLsvQ
 qrvb/ZvrYjiQPMD+vIhPtUx5c/IIJ/q+4YoD8fGyRDozzD8St53c0QRn+UQNLcCo19m5
 1DUFdgH2gGLd93wC+HEApk1iw8AGvx0lK8AFXV79s6I4sDdsSF7sPFscG6EM5utsNzsH
 AcO5bZgWu/rzIiuQSscH2cyLkf/5WIOigZ3NDoWy4xH/cJ+rCxm98II/QMjtsu1RE+iY
 wflw==
X-Gm-Message-State: APjAAAXSgJStKdXZoRYseJzJiUdT89wIkvebxnJ3sm4I5ilGlEPQhDMF
 ACKFPLLdWw23u0HtS3giA8UQpw==
X-Google-Smtp-Source: APXvYqzXKptF2ItXdnbMo74/0CD3YScRSU601Zj6Z6ISFGBv6dNCtLQyYj+Hc0YeYO9TPdSC6DPJ1Q==
X-Received: by 2002:a5d:6ccd:: with SMTP id c13mr91459552wrc.4.1564054256478; 
 Thu, 25 Jul 2019 04:30:56 -0700 (PDT)
Received: from [192.168.1.37] (190.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.190])
 by smtp.gmail.com with ESMTPSA id d10sm40553394wrx.34.2019.07.25.04.30.51
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Thu, 25 Jul 2019 04:30:55 -0700 (PDT)
To: tony.nguyen@bt.com, qemu-devel@nongnu.org
References: <45d1ebe4b2ed4c039c9da20a738652df@tpw09926dag18e.domain1.systemhost.net>
 <1564048377976.39897@bt.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Openpgp: id=89C1E78F601EE86C867495CBA2A3FD6EDEADC0DE;
 url=http://pgp.mit.edu/pks/lookup?op=get&search=0xA2A3FD6EDEADC0DE
Message-ID: <e9b26c03-6fac-122a-ff50-74ea976e7ee8@redhat.com>
Date: Thu, 25 Jul 2019 13:30:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <1564048377976.39897@bt.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.67
Subject: Re: [Qemu-devel] [PATCH v4 03/15] target/mips: Access MemoryRegion
 with MemOp
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
Cc: peter.maydell@linaro.org, walling@linux.ibm.com, sagark@eecs.berkeley.edu,
 david@redhat.com, palmer@sifive.com, mark.cave-ayland@ilande.co.uk,
 Alistair.Francis@wdc.com, edgar.iglesias@gmail.com, alex.williamson@redhat.com,
 arikalo@wavecomp.com, pasic@linux.ibm.com, borntraeger@de.ibm.com,
 rth@twiddle.net, atar4qemu@gmail.com, ehabkost@redhat.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, stefanha@redhat.com,
 shorne@gmail.com, david@gibson.dropbear.id.au, qemu-riscv@nongnu.org,
 kbastian@mail.uni-paderborn.de, cohuck@redhat.com, laurent@vivier.eu,
 qemu-ppc@nongnu.org, amarkovic@wavecomp.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/25/19 11:52 AM, tony.nguyen@bt.com wrote:
> Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
> ---
>  target/mips/op_helper.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
> index 9e2e02f..dccb8df 100644
> --- a/target/mips/op_helper.c
> +++ b/target/mips/op_helper.c
> @@ -24,6 +24,7 @@
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> +#include "exec/memop.h"
>  #include "sysemu/kvm.h"
> 
>  /*****************************************************************************/
> @@ -4740,11 +4741,11 @@ void helper_cache(CPUMIPSState *env, target_ulong addr, uint32_t op)
>      if (op == 9) {
>          /* Index Store Tag */
>          memory_region_dispatch_write(env->itc_tag, index, env->CP0_TagLo,
> -                                     8, MEMTXATTRS_UNSPECIFIED);
> +                                     SIZE_MEMOP(8), MEMTXATTRS_UNSPECIFIED);
>      } else if (op == 5) {
>          /* Index Load Tag */
>          memory_region_dispatch_read(env->itc_tag, index, &env->CP0_TagLo,
> -                                    8, MEMTXATTRS_UNSPECIFIED);
> +                                    SIZE_MEMOP(8), MEMTXATTRS_UNSPECIFIED);
>      }
>  #endif
>  }
> --
> 1.8.3.1
> 
> 

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

