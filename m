Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E649AC04AA7
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:10:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B4C2B2084E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 13:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B4C2B2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57097 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQAj4-0001S2-QR
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 09:10:42 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQAbZ-0003Zw-4O
	for qemu-devel@nongnu.org; Mon, 13 May 2019 09:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1hQANl-0000qH-Qh
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:48:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36992)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1hQANl-0000pw-Kp
	for qemu-devel@nongnu.org; Mon, 13 May 2019 08:48:41 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4C66D307D854;
	Mon, 13 May 2019 12:48:40 +0000 (UTC)
Received: from [10.40.204.20] (ovpn-204-20.brq.redhat.com [10.40.204.20])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5A05B5C206;
	Mon, 13 May 2019 12:48:38 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190510173049.28171-1-richard.henderson@linaro.org>
	<20190510173049.28171-25-richard.henderson@linaro.org>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <837325fe-a3db-14fb-4b61-2eaaa63829aa@redhat.com>
Date: Mon, 13 May 2019 14:48:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20190510173049.28171-25-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Mon, 13 May 2019 12:48:40 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v6 24/25] target/ppc: Use gen_io_start/end
 around DARN
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
Cc: David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/05/2019 19:30, Richard Henderson wrote:
> Generating a random number counts as I/O, as it cannot be
> replayed and produce the same results.
> 
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/ppc/translate.c | 21 +++++++++++++++------
>   1 file changed, 15 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8d08625c33..76628df6dd 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -1847,13 +1847,22 @@ static void gen_darn(DisasContext *ctx)
>   {
>       int l = L(ctx->opcode);
>   
> -    if (l == 0) {
> -        gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
> -    } else if (l <= 2) {
> -        /* Return 64-bit random for both CRN and RRN */
> -        gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
> -    } else {
> +    if (l > 2) {
>           tcg_gen_movi_i64(cpu_gpr[rD(ctx->opcode)], -1);
> +    } else {
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_start();
> +        }
> +        if (l == 0) {
> +            gen_helper_darn32(cpu_gpr[rD(ctx->opcode)]);
> +        } else {
> +            /* Return 64-bit random for both CRN and RRN */
> +            gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
> +        }
> +        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
> +            gen_io_end();
> +            gen_stop_exception(ctx);
> +        }
>       }
>   }
>   #endif
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


