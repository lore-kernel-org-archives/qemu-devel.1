Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5077DC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:43:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7CD20850
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 20:43:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7CD20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43591 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOTPB-00046v-07
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 16:43:09 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51188)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hOTOL-0003mo-U7
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:42:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@dabbelt.com>) id 1hOTOJ-0000hT-SV
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:42:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34685)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1hOTOJ-0000gC-Gn
	for qemu-devel@nongnu.org; Wed, 08 May 2019 16:42:15 -0400
Received: by mail-pl1-f194.google.com with SMTP id w7so1450319plz.1
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 13:42:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
	:mime-version:content-transfer-encoding;
	bh=VgyXF7ytFjodUj+gOQnaY7QDddkV2VcxBgtSMevZxes=;
	b=ipXE34B7pSmMWAZut83cIkbozvC5U0NctitMp3BYcgM7pusRhq9Dcu2Dh0xFzrBMLx
	aSyIYVnNmTOuUgqrFLdwKqNWeRLTx3bb4urjStv7sSiREcHhtMtg4ncabMCmz6pXyCt/
	E73Yx2E5SRLwfkwdQSIa7jiqq39InNxYSZslK5lyx6xG4Ghf7Nl19NsZ37+GKaLk5DBQ
	CBdXlyrM9gE2+2ypDcCqnfmU3ylS83NFXDUXLHRfFUTUVJcZP3yo/D7omjhLPgjhbM5m
	hP/LIUSRqPWXL0YbWKdfbZr5E/k/ik7Tn9i0RNZ+POvvunbpBhmkWf6ebu2PXIMKBuX+
	E7Ow==
X-Gm-Message-State: APjAAAVzSAaXs0cZJCwUZXUyQ19YQhXRyk5zfaMiMzyQEC/Jq7Fq9nYN
	380H+CJUNaOS+YROComP5K5yJR9STZo=
X-Google-Smtp-Source: APXvYqzX1CSL1eBLsWHRghkkaBK8mhiYxSRkPCTUQ+BE4pndbij8Kv1gJwmv9RDqLbbVveLv82OFiA==
X-Received: by 2002:a17:902:ba8e:: with SMTP id
	k14mr50786062pls.80.1557348132885; 
	Wed, 08 May 2019 13:42:12 -0700 (PDT)
Received: from localhost ([12.206.222.5]) by smtp.gmail.com with ESMTPSA id
	t65sm129557pfa.175.2019.05.08.13.42.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 08 May 2019 13:42:12 -0700 (PDT)
Date: Wed, 08 May 2019 13:42:12 -0700 (PDT)
X-Google-Original-Date: Wed, 08 May 2019 13:30:52 PDT (-0700)
In-Reply-To: <20190508173835.14528-1-jonathan@fintelia.io>
From: Palmer Dabbelt <palmer@sifive.com>
To: jonathan@fintelia.io
Message-ID: <mhng-80bf675e-e5bd-4102-9ecc-484829735eb8@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.214.194
Subject: Re: [Qemu-devel] [PATCH] target/riscv: Only flush TLB if SATP.ASID
 changes
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
Cc: jonathan@fintelia.io, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
	sagark@eecs.berkeley.edu, fintelia@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 08 May 2019 10:38:35 PDT (-0700), jonathan@fintelia.io wrote:
> There is an analogous change for ARM here:
> https://patchwork.kernel.org/patch/10649857
>
> Signed-off-by: Jonathan Behrens <jonathan@fintelia.io>
> ---
>  target/riscv/csr.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index 6083c782a1..1ec1222da1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -732,7 +732,9 @@ static int write_satp(CPURISCVState *env, int csrno, target_ulong val)
>          if (env->priv == PRV_S && get_field(env->mstatus, MSTATUS_TVM)) {
>              return -1;
>          } else {
> -            tlb_flush(CPU(riscv_env_get_cpu(env)));
> +            if((val ^ env->satp) & SATP_ASID) {
> +                tlb_flush(CPU(riscv_env_get_cpu(env)));
> +            }
>              env->satp = val;
>          }
>      }

Thanks!  I've taken this into my for-master branch, pending some testing I'll
send it up.

