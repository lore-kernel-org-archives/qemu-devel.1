Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2B4C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D6BB020768
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 22:48:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XH5l59Yw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D6BB020768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5GaV-0005VB-3K
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 18:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56310)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GZp-00051s-QH; Mon, 10 Aug 2020 18:47:33 -0400
Received: from mail-io1-xd41.google.com ([2607:f8b0:4864:20::d41]:35064)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1k5GZo-00009Z-BY; Mon, 10 Aug 2020 18:47:33 -0400
Received: by mail-io1-xd41.google.com with SMTP id s189so10705047iod.2;
 Mon, 10 Aug 2020 15:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Dxc546p/XTjL0jg8GPPGX9kFHD8YVGDZwJnCXYzvNm8=;
 b=XH5l59YwrDapFwBZMNPnhwJj4Gi075lXLv468KDIvVEqnJ1XEIn8PXIPnu4yo+NPF5
 pK0y6XlCQUU093MhaJ45PZbF7FqZwWbTFnEI6fmY9eUWU/fgFEtxsDSvLHpPX3F06JkC
 j79cZ30huZgVVaSQcE+DPd00xS0hkO8Tb6vyAvejg9dwYt9Q7shF+MmAOI7uB9olHNNo
 9pmcwlCK77U6Xg67kFSupM5gogU9yAzmxSLTxVRWCWWBPQ8QhUOTnAiGHuQ3gVeDQw5Z
 fc8I5i2UM7bhZdOq30gPv/GtmZ2nnEVx+uBaccSse6DPWta8dr84ePtozzqIjEfqeE9r
 GaCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Dxc546p/XTjL0jg8GPPGX9kFHD8YVGDZwJnCXYzvNm8=;
 b=mQvZpDv9wsuIevCufGTDN1uJZ3bcAkzQZjQtUyoLuBfXI68fpBX245K5TmBJBvMnVj
 Sq6RGR1WCLzl5JtTJZKjSMWqj6ykxR+UIzQ72cbyGkxuhHgsuGbE9fLBYBJNDBWAcGTA
 03xbMixJcL6lli1pFlQK6oKdQY1rOfEIQAGwxPIwHehUG136qmZ1uXcEzjd4Ci5qtmxg
 YSsWaX1dlA5CttGbbRHp48+mydQ3WCmc2Mt3xwUiXgPXKnLrfzEmiw89fNcKVQdZeqy8
 BN9a8KcgowEEqL2smqTgjKlqCSB1eWMJ5IsCg55OKvfDWk4zOLtYUUAM4frz2pyD5yRb
 DU1g==
X-Gm-Message-State: AOAM5307khvwppHAe1cMDkEJr9jrHDTx/eGrsULZ9fpCtbJAFPVGQR2y
 EjIuZ2ql/PA1OVmGR3btN7HwWgYvwlmdargugmA=
X-Google-Smtp-Source: ABdhPJx7AYTEHUAb39AWIK2s3wvIww3TNlQkO2gDr8eV/mGBhN2f1c3rL40AzAi9N74Joy8hV44Os1m8qii0KkwwamA=
X-Received: by 2002:a02:84c1:: with SMTP id f59mr22676456jai.106.1597099650822; 
 Mon, 10 Aug 2020 15:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200729112801.108985-1-anup.patel@wdc.com>
 <20200729112801.108985-3-anup.patel@wdc.com>
In-Reply-To: <20200729112801.108985-3-anup.patel@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 10 Aug 2020 15:37:06 -0700
Message-ID: <CAKmqyKNaXpYt21PdX3EwwDXQEjcTD5_+Vpi3J3f2CNywjX8_OQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] target/riscv: Fix write_htinst() implementation
To: Anup Patel <anup.patel@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d41;
 envelope-from=alistair23@gmail.com; helo=mail-io1-xd41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, Anup Patel <anup@brainfault.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Atish Patra <atish.patra@wdc.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jul 29, 2020 at 4:30 AM Anup Patel <anup.patel@wdc.com> wrote:
>
> The htinst CSR is writeable from M-mode and HS-mode so
> we should not ignore writes to htinst CSR.
>
> Signed-off-by: Anup Patel <anup.patel@wdc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/csr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index f985b85de4..99fcb7f67d 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -943,6 +943,7 @@ static int read_htinst(CPURISCVState *env, int csrno, target_ulong *val)
>
>  static int write_htinst(CPURISCVState *env, int csrno, target_ulong val)
>  {
> +    env->htinst = val;
>      return 0;
>  }
>
> --
> 2.25.1
>
>

