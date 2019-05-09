Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53003C04A6B
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:34:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11F16216C4
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 00:34:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="tivDVgrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11F16216C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45586 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOX15-0006ub-BM
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 20:34:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOX0B-0006bd-To
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:33:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton@ozlabs.org>) id 1hOX0B-00024k-25
	for qemu-devel@nongnu.org; Wed, 08 May 2019 20:33:35 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:53911)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <anton@ozlabs.org>)
	id 1hOX09-0001rS-W4; Wed, 08 May 2019 20:33:35 -0400
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits)
	server-digest SHA256) (No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 44zvTJ5x1Sz9sBV;
	Thu,  9 May 2019 10:33:24 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
	t=1557362006; bh=EPCebIIkcGHz/E2WVS+lpT+fH3hIwzQCHX0oEVsh2e4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tivDVgrNakoHCVevQR9uKW/heZhuTtg8QYfIP4/PRagD9++T/GSHMAH+jsJ2McV9O
	KISbYyDprzDlJNoTOPRJNSku6/y7GJ0DNayB9dwJLMhEMYFglrwJ6BDhfimylG/FYH
	J0sc3bZxhGjV7jK0yds3AajqTXDPph3d8zG0NQufXpYCiCX09yiVjfM4mroelNPCW8
	tRiY19N4y2E6FITE1Z8XIldVlYo0STeIvCSDDvW4jSw1liZkHlnaL/lXjBaiF9w9oe
	BQmLIW/TRUlkP+CLUfQCS/xpdrjc98OIV7B9grLSpW8SiwKvELx7zeR1NMsOeM0dFV
	CRDSPwxvXryiw==
Date: Thu, 9 May 2019 10:33:24 +1000
From: Anton Blanchard <anton@ozlabs.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <20190509103324.7ce48de7@kryten>
In-Reply-To: <c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<20190507052815.GK7073@umbus.fritz.box>
	<c69c4513-417b-8415-c48b-61d0a05c1680@ilande.co.uk>
X-Mailer: Mutt/1.8.0 (2017-02-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	richard.henderson@linaro.org, f4bug@amsat.org,
	qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
	David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Mark,

> Following on from this I've just gone through the load/store
> operations once again and spotted two things:
> 
> 
> 1) VSX_LOAD_SCALAR_DS has an extra get_cpu_vsrh() which can be removed
> 
> diff --git a/target/ppc/translate/vsx-impl.inc.c
> b/target/ppc/translate/vsx-impl.inc.c index 11d9b75d01..004ea56c4f
> 100644 --- a/target/ppc/translate/vsx-impl.inc.c
> +++ b/target/ppc/translate/vsx-impl.inc.c
> @@ -329,7 +329,6 @@ static void gen_##name(DisasContext
> *ctx)                         \
> return;
> \ }                                                             \ xth
> = tcg_temp_new_i64();                                     \
> -    get_cpu_vsrh(xth, rD(ctx->opcode) + 32);                      \
>      gen_set_access_type(ctx, ACCESS_INT);                         \
>      EA = tcg_temp_new();                                          \
>      gen_addr_imm_index(ctx, EA, 0x03);                            \

Looks good. I also noticed we had two stores that needed to be fixed:

VSX_LOAD_SCALAR_DS(stxsd, st64_i64)
VSX_LOAD_SCALAR_DS(stxssp, st32fs)

> 2) VSX_VECTOR_LOAD_STORE is confusing and should be split into
> separate VSX_VECTOR_LOAD and VSX_VECTOR_STORE macros

Good idea. I also removed (what I assume) are redundant set_cpu_vsr*
and get_cpu_vsr* calls.

> Does that sound reasonable? I'm also thinking that we should consider
> adding a CC to stable for patches 4, 5 and 9 in this series since
> these are genuine regressions.

Fine with me. If David agrees, I'm not sure if he can rebase them or
if I can send them manually if they have been already committed.

Thanks,
Anton

