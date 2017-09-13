Received: from eggs.gnu.org ([2001:4830:134:3::10]:59466)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsC0j-0007CK-2l
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:03:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1dsC0g-00072j-0c
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:03:41 -0400
Received: from mail-qk0-x233.google.com ([2607:f8b0:400d:c09::233]:47178)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1dsC0f-00072R-Tb
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 14:03:37 -0400
Received: by mail-qk0-x233.google.com with SMTP id b82so2396326qkc.4
	for <qemu-devel@nongnu.org>; Wed, 13 Sep 2017 11:03:37 -0700 (PDT)
References: <150505986682.19604.11937392314067517230.stgit@frigg.lan>
	<150506156146.19604.7064966029596517363.stgit@frigg.lan>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <07d31da3-65cf-f7ad-708b-b635afe5936c@linaro.org>
Date: Wed, 13 Sep 2017 11:03:32 -0700
MIME-Version: 1.0
In-Reply-To: <150506156146.19604.7064966029596517363.stgit@frigg.lan>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 7/7] trace: Add event
 "guest_inst_info_after"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Llu=c3=ads_Vilanova?= <vilanova@ac.upc.edu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefan Hajnoczi <stefanha@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

On 09/10/2017 09:39 AM, Lluís Vilanova wrote:
>          if (TRACE_GUEST_INST_AFTER_ENABLED && translated_insn) {
>              trace_guest_inst_after_tcg(cpu, tcg_ctx.tcg_env, pc_insn);
>          }
> +        if (TRACE_GUEST_INST_INFO_AFTER_ENABLED && translated_insn) {
> +            trace_guest_inst_info_after_tcg(
> +                cpu, tcg_ctx.tcg_env, pc_insn, insn_size);
> +        }

Same comments re guest_inst + guest_inst_info, really.


r~
