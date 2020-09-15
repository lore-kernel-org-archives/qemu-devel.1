Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0264EC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55E5D20715
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lp9O2IVd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55E5D20715
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDux-0000ua-Al
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDrJ-0005JH-LP
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:31:09 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:32778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDrA-0005ZV-SV
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:31:04 -0400
Received: by mail-oi1-x242.google.com with SMTP id m7so4601784oie.0
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=AXZV9z/1yeneNtKIQ2lkVfpMNFgiuD6CZmtFFG4ZcKQ=;
 b=lp9O2IVd+kP990tC7aNtMC6oj/835L8Uc+MEg7uygGN1wbBJz16vaQKuGNqxOt9AaC
 AyPPaxjWC38+8Rm6nKhJPhp1P5/b4pDW51PIj5pvSdKQvqOwxdwPBRQ4cymAz6l3hQUc
 VKDAe84EfMsXB61Vwqxfaqd2Isk7i0WzuvyhG9c++eKM8fwqRnLkrtr4Wd3HrtkNXAK9
 rYO69seRBIZX4mS+L/KY6jVzsiXVaQEMoCZO8LD3+JVbkVDGfL9zuoSZkUoR/D0Ls/A8
 O3/lRTM4AwUdnf6+qvd7yUdEnHAMFt2fDOJzvmewTcjrK/h3L3UFZmElHD1Ky1TG+KpF
 jgpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AXZV9z/1yeneNtKIQ2lkVfpMNFgiuD6CZmtFFG4ZcKQ=;
 b=DEE0BkUUgmThk9EHkONOzVNUQmCi3ypLMfAtVRaXQqp1Y1QVfbSPXJaEOZ+3eQMqws
 k0dTN69Xe+wjHCKHnnnnM0n3YKaRlwKIu2rcN8GTZXQo6wVv8+/yeWtD58PtU4Et7Wuw
 yXLRrZ/ziZZbX9MfGDGuke+O7/a/fSbJ5gz0PavOasM7f4qq3zIKTUJI82ObbhvcXXjD
 +fgDIQBCfeo8GkOhCSyJs2vU/hChGt1VPYpXnMg+o4EKUHRgMaCozTZ6k5E7ibkEv63T
 /FVP9fqEGSxG0axq1u3KVWmT7mPx+XjNYUFsk9/gR7Ix3GVs7k92AnrRC7UeYjyLIJJ1
 yPUg==
X-Gm-Message-State: AOAM532qOBuQEK0qdChIL9tnNZo6eGhRkW9ST7YAVa4HhkuaDRRFNaVe
 QlbPWx2sm9IbVWsqWCHTTpqM6IzsAcWzEqoYD38=
X-Google-Smtp-Source: ABdhPJzYdA9I+keXEctfPzYtroeezXq2cxR2Mt4nx14fgXPha9hvAV/W90Ozfc+QDX3K2FU5NaquZh4CASuRye0J1Q0=
X-Received: by 2002:aca:904:: with SMTP id 4mr153414oij.97.1600187457214; Tue,
 15 Sep 2020 09:30:57 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-8-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-8-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:30:21 +0800
Message-ID: <CAKXe6SLR1X+O-GCJYXtBZ4Vz17o4gSK3WUYaCc6hD0h0OfbCwg@mail.gmail.com>
Subject: Re: [PATCH v9 07/12] migration/dirtyrate: Compare page hash results
 for recorded sampled page
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=liq3ea@gmail.com; helo=mail-oi1-x242.google.com
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 zhanghailiang <zhang.zhanghailiang@huawei.com>,
 Juan Quintela <quintela@redhat.com>, yuxiating@huawei.com,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 jinyan12@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8A=E5=8D=8810:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Compare page hash results for recorded sampled page.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> ---
>  migration/dirtyrate.c | 63 +++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 63 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 5e6eedf..2d48eb8 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -177,6 +177,69 @@ out:
>      return ret;
>  }
>
> +static void calc_page_dirty_rate(struct RamblockDirtyInfo *info)
> +{
> +    uint32_t crc;
> +    int i;
> +
> +    for (i =3D 0; i < info->sample_pages_count; i++) {
> +        crc =3D get_ramblock_vfn_hash(info, info->sample_page_vfn[i]);
> +        if (crc !=3D info->hash_result[i]) {
> +            info->sample_dirty_count++;
> +        }
> +    }
> +}
> +
> +static struct RamblockDirtyInfo *
> +find_page_matched(RAMBlock *block, int count,
> +                  struct RamblockDirtyInfo *infos)
> +{
> +    int i;
> +    struct RamblockDirtyInfo *matched;
> +
> +    for (i =3D 0; i <=3D count; i++) {

'i < count'?

> +        if (!strcmp(infos[i].idstr, qemu_ram_get_idstr(block))) {
> +            break;
> +        }
> +    }
> +
> +    if (i =3D=3D count) {
> +        return NULL;
> +    }
> +
> +    if (infos[i].ramblock_addr !=3D qemu_ram_get_host_addr(block) ||
> +        infos[i].ramblock_pages !=3D
> +            (qemu_ram_get_used_length(block) >> TARGET_PAGE_BITS)) {
> +        return NULL;
> +    }
> +
> +    matched =3D &infos[i];
> +
> +    return matched;
> +}
> +
> +static bool compare_page_hash_info(struct RamblockDirtyInfo *info,
> +                                  int block_count)
> +{
> +    struct RamblockDirtyInfo *block_dinfo =3D NULL;
> +    RAMBlock *block =3D NULL;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        block_dinfo =3D find_page_matched(block, block_count, info);
> +        if (block_dinfo =3D=3D NULL) {
> +            continue;
> +        }
> +        calc_page_dirty_rate(block_dinfo);
> +        update_dirtyrate_stat(block_dinfo);
> +    }
> +
> +    if (DirtyStat.total_sample_count =3D=3D 0) {
> +        return false;
> +    }
> +
> +    return true;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> --
> 1.8.3.1
>

