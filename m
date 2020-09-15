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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E553C43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20EF206BE
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:34:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VeE0sy57"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20EF206BE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDu4-0007k0-EU
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:34:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35276)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDsV-0006H3-FD
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:32:25 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:35286)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDsT-0005nv-8S
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:32:23 -0400
Received: by mail-oi1-x242.google.com with SMTP id w16so4595268oia.2
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=t7rLNPuehrKEXXXTNCUjiTRZvemGF9Q43u8COIYZuXA=;
 b=VeE0sy57idSAvum7XKzYLZgBQTJX3vT2DNIEku2IlvhLKiAnSd+CfyqTbzFPcPf+wV
 YhTme/AookloL+hbrsv6fevSPe1YluMI4N6xLM1d4d4e10nAHSGhIGFsJocJO3C1uqA8
 rTeG2RWFqFuk5m7/FtVVDcQEKMUE2yaturBmALvpJpwepY8ovNiwS03Lnk16DaJKE5O9
 6xp7U6z24HRgrvopwm+mPwBNi0an32hBuhDADTE6jZJg5rueN98otLu3gqzICpDXpkLg
 RjPw9W/d6Illnv5zToyoGxFUcqPuXL5miP2nZi/bjbdtldhTLWqPL6LX3SaMgdzuzRp1
 kx+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=t7rLNPuehrKEXXXTNCUjiTRZvemGF9Q43u8COIYZuXA=;
 b=CbPl+9zpfZZy/k04ajvFz3quZESvcje0/LtxtGAxT2svDOHimHQAwc4JCdAnpkIH+O
 OBTAcDd25f8gVYcOTPnv2OhSCEn1eUZgsOa+RwEnD7ygg0DeGfiLyHPwFmsWVPCT1y7N
 ju4f9L2seZ1CWnt3ncsoJd04eruUqjmas5ENj74Bpn2XMw/UPffzNzK9v71tBiaMXxlU
 HN+U5F/51DbjGmKdo0gBQzlAwRuIR2YrNyouifYvItqVbpXjLJSMGuCABf7VC4H2+5yM
 n531Xh7neVWg/Snh4IJBMguIcsPNco0+AsrErn5VNEE8jRg6+1+XyDHY0SUiKelOCgzw
 xVHg==
X-Gm-Message-State: AOAM530dbBJCC9MjbFhUkoDCMTyG+hGe4fMH2Yaxrb5gM91mMtGYaQ8t
 5SbL8yX/rh8OxY9uCS5LVPCRDFdanvb5ranwkVs=
X-Google-Smtp-Source: ABdhPJz2WocPF0QkoiSPydD5fhGutyiMML6/9JTyhN1zTznF9wPhsMu7muopgO6Zre8l/jEgLZo+480h/U/Trx3OgGc=
X-Received: by 2002:aca:e155:: with SMTP id y82mr205556oig.56.1600187539195;
 Tue, 15 Sep 2020 09:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-9-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-9-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:31:43 +0800
Message-ID: <CAKXe6S+8J+PuaEHKfrVC-g=gb0+AFrVmM9_qLcZDusQJZ8pr3w@mail.gmail.com>
Subject: Re: [PATCH v9 08/12] migration/dirtyrate: skip sampling ramblock with
 size below MIN_RAMBLOCK_SIZE
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
> In order to sample real RAM, skip ramblock with size below MIN_RAMBLOCK_S=
IZE
> which is set as 128M.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>
> ---
>  migration/dirtyrate.c | 21 +++++++++++++++++++++
>  migration/dirtyrate.h |  5 +++++
>  2 files changed, 26 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 2d48eb8..903f728 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -138,6 +138,18 @@ static void get_ramblock_dirty_info(RAMBlock *block,
>      strcpy(info->idstr, qemu_ram_get_idstr(block));
>  }
>
> +static bool skip_sample_ramblock(RAMBlock *block)
> +{
> +    /*
> +     * Sample only blocks larger than MIN_RAMBLOCK_SIZE.
> +     */
> +    if (qemu_ram_get_used_length(block) < (MIN_RAMBLOCK_SIZE << 10)) {
> +        return true;
> +    }
> +
> +    return false;
> +}
> +
>  static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_d=
info,
>                                        struct DirtyRateConfig config,
>                                        int *block_count)
> @@ -150,6 +162,9 @@ static bool record_ramblock_hash_info(struct Ramblock=
DirtyInfo **block_dinfo,
>      bool ret =3D false;
>
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block)) {
> +            continue;
> +        }
>          total_count++;
>      }
>
> @@ -159,6 +174,9 @@ static bool record_ramblock_hash_info(struct Ramblock=
DirtyInfo **block_dinfo,
>      }
>
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block)) {
> +            continue;
> +        }
>          if (index >=3D total_count) {
>              break;
>          }
> @@ -225,6 +243,9 @@ static bool compare_page_hash_info(struct RamblockDir=
tyInfo *info,
>      RAMBlock *block =3D NULL;
>
>      RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (skip_sample_ramblock(block)) {
> +            continue;
> +        }
>          block_dinfo =3D find_page_matched(block, block_count, info);
>          if (block_dinfo =3D=3D NULL) {
>              continue;
> diff --git a/migration/dirtyrate.h b/migration/dirtyrate.h
> index a3ee305..faaf9da 100644
> --- a/migration/dirtyrate.h
> +++ b/migration/dirtyrate.h
> @@ -24,6 +24,11 @@
>   */
>  #define RAMBLOCK_INFO_MAX_LEN                     256
>
> +/*
> + * Minimum RAMBlock size to sample, in megabytes.
> + */
> +#define MIN_RAMBLOCK_SIZE                         128
> +
>  struct DirtyRateConfig {
>      uint64_t sample_pages_per_gigabytes; /* sample pages per GB */
>      int64_t sample_period_seconds; /* time duration between two sampling=
 */
> --
> 1.8.3.1
>

