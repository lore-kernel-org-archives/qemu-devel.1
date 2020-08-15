Return-Path: <SRS0=PlQC=BZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C115C433E1
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:18:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD6232310F
	for <qemu-devel@archiver.kernel.org>; Sat, 15 Aug 2020 15:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IckwC/8X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD6232310F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59064 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6xwb-00034V-22
	for qemu-devel@archiver.kernel.org; Sat, 15 Aug 2020 11:18:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55748)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6xrW-00040d-2j; Sat, 15 Aug 2020 11:12:50 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41693)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>)
 id 1k6xrU-0000iT-6O; Sat, 15 Aug 2020 11:12:49 -0400
Received: by mail-ot1-x343.google.com with SMTP id a65so9920432otc.8;
 Sat, 15 Aug 2020 08:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=9kLxRkTN0kt8bAx6tDCmMfExdOIUYccVgus6RbjzPc4=;
 b=IckwC/8X3pmMQFc21rs5AX3l+hPmY0bDumcNELUZti0Mjb3SgID/O+8oVO2DLI6t62
 jz/aglpOCMXwNtW4Ap4Y7yUCWzawWu/ySfNvq94R/eWKRPMjIHX13chVSiGEkMvRmXHg
 rgGzVg4SesA90cKHBSOSYG63bb4xGSfcdP9XWANGNfp2/966gt1cUU4V4xMmZRSGw4VZ
 7Dl/BtkbD6OS74azdHeJsmYSYGq6J+ZfSa/jle57YLkkfPkdrkKaKk3tc+Nx+JUnUZTf
 /7R1RjtuItP9Y14qly5TO14dhxTc8O8MeO8+8jkO6oW9jmOo6su1cmJHErbGqiD58g5c
 eIsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=9kLxRkTN0kt8bAx6tDCmMfExdOIUYccVgus6RbjzPc4=;
 b=HNE7dFMGF79Iulh3SJQgTV2GB8d23LpY6QvvkfWYHwQvdHLYOrInhq8SUWWc5ED/O5
 QxslqVgyo1JODYMz8IIPdrCGh38dy+xqXLMXLPNomsL9IKQjrXWu8WBWeDSenUREFAHm
 bsT53EXFEVVSLRvFe1+Os9BHm+c5wr6MwDAAyGO0ufMHXYdnh1Eca4D0d9dDL/1iir4B
 JqErogt4d5x75YHERaBiXeYPklO4KZmZNMoty8PTjJXNs1vjR+DgYj9uGGPCa7EUj0r0
 GskbIrX3Y5IbrY6KnIjfvR5dqUH9GGKH3nVCIH+iA5aTKWn9ZqIxH5nqEHr8HGFh7uKc
 rVog==
X-Gm-Message-State: AOAM530yZFukOa+h6MOUGrbZXGKN0jZkaJIVXs2eJQDwigqi//fqFpJH
 Y7aPSZTQ+ehUYWnpjfMk00RDJx7juHrN9GlHYxa+PKRh8AU=
X-Google-Smtp-Source: ABdhPJx46NrV7+VMVPeHgYZA3yKeYBlQCqW0oDrOVRijhtugZpjn6MZDL2zKCATKw3VcANWeuQqburI/jxHFCPrzpms=
X-Received: by 2002:a05:6830:796:: with SMTP id
 w22mr5009945ots.353.1597501361463; 
 Sat, 15 Aug 2020 07:22:41 -0700 (PDT)
MIME-Version: 1.0
References: <20200815141940.44025-1-liq3ea@163.com>
 <20200815141940.44025-3-liq3ea@163.com>
In-Reply-To: <20200815141940.44025-3-liq3ea@163.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Sat, 15 Aug 2020 22:22:04 +0800
Message-ID: <CAKXe6SK9if2JpWrrcabcRZCAbBNH0rHC-YdYz6_QvMCavU+vow@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw: megasas: consider 'iov_count=0' is an error in
 megasas_map_sgl
To: Li Qiang <liq3ea@163.com>, Alexander Bulekov <alxndr@bu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::343;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Paolo Bonzini <pbonzini@redhat.com>,
 hare@suse.com, Qemu Developers <qemu-devel@nongnu.org>, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Oh, sorry to forget to CC Alexander Bulekov.

Thanks,
Li Qiang

Li Qiang <liq3ea@163.com> =E4=BA=8E2020=E5=B9=B48=E6=9C=8815=E6=97=A5=E5=91=
=A8=E5=85=AD =E4=B8=8B=E5=8D=8810:20=E5=86=99=E9=81=93=EF=BC=9A
>
> Currently in 'megasas_map_sgl' when 'iov_count=3D0' will just return
> success however the 'cmd' doens't contain any iov. This will cause
> the assert in 'scsi_dma_complete' failed. This is because in
> 'dma_blk_cb' the 'dbs->sg_cur_index =3D=3D dbs->sg->nsg' will be true
> and just call 'dma_complete'. However now there is no aiocb returned.
>
> This fixes the LP#1878263:
>
> -->https://bugs.launchpad.net/qemu/+bug/1878263
>
> Reported-by: Alexander Bulekov <alxndr@bu.edu>
> Signed-off-by: Li Qiang <liq3ea@163.com>
> ---
>  hw/scsi/megasas.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
> index d6c9680c36..9562c58a2d 100644
> --- a/hw/scsi/megasas.c
> +++ b/hw/scsi/megasas.c
> @@ -278,7 +278,7 @@ static int megasas_map_sgl(MegasasState *s, MegasasCm=
d *cmd, union mfi_sgl *sgl)
>
>      cmd->flags =3D le16_to_cpu(cmd->frame->header.flags);
>      iov_count =3D cmd->frame->header.sge_count;
> -    if (iov_count > MEGASAS_MAX_SGE) {
> +    if (!iov_count || iov_count > MEGASAS_MAX_SGE) {
>          trace_megasas_iovec_sgl_overflow(cmd->index, iov_count,
>                                           MEGASAS_MAX_SGE);
>          return -1;
> --
> 2.17.1
>

