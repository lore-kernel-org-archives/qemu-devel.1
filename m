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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05E45C2D0E0
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 877FA20708
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 16:22:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfReqIWl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 877FA20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIDjG-0001M1-K3
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 12:22:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDid-0000XH-R0
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:22:11 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:43041)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kIDib-00042X-NN
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 12:22:11 -0400
Received: by mail-ot1-x342.google.com with SMTP id n61so3765063ota.10
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=UFMO/6u2LRFBCoUKu+Vq7x7mvBfrO9jqOxud8bj14xI=;
 b=dfReqIWlFErfP0Hpo7hrnSVHa5FdjOSJ5WAKXIwc52VqoL3GNCoe3rNXcrr1z7SBKj
 NGf2dPlIe21KnytvpZZistPjhL12Rn1PQtpa5lMMiFwmLsiKEmF1k+Bpv9hDXXJn06ls
 7iAa5hxAbpkKhTL6jtgSKtxMmUpHMNrF0NWmNaDOU4+NFeDTNTohM5ygfqmXre8+vf0i
 0OVCcyR7Eazsuqc5s5Bg/Y9pRnTOQBOvpIruPAcrrcB/p92tP2uTY1AxuKeFyNamDK/0
 6qI3RRcZEZPkBoq4BT3V12tePfainOARXVkRWNtn5IZ3FXjnbGht2xVQ/xdsMHi0rjDL
 B95g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=UFMO/6u2LRFBCoUKu+Vq7x7mvBfrO9jqOxud8bj14xI=;
 b=pcXsvDE9rsyG1/djUe+OveYum5bDOGLIx0AdsCnVkNgAyNoJdFVRuVR/sQJzqbzFjP
 LfMN9j6RE2zUBV1cJ74KJ0TAO6GNX7bcuwY2RAZ767nKITtU4ckRaHg84T/iZw5GKkRQ
 5wTSzFyTKB1cIwXuM1r/lDmQXRbTaql9JrpTGroI6zFTZn6dy5+cG9BqBcsHFKEq9P0T
 URBERq/MtES/9gthATEk8XLm3ZNadTNDKevgHrg+GA03Xv5biwvb1ev89VKVmZvTdgt5
 2CbN+7mbwpb1YFiBnmxon8eYP9v9TwAKQGhnEeW49VEbIpOk62XqurYxVxspBniRRegv
 zO/Q==
X-Gm-Message-State: AOAM5322gWsmp2iyr/DVWfv5R62Vy/CjjnIFWoqKQwdhiBIbYOgv6LEs
 2gBUPOmkxOlCUkjW8tKdWQkI9faF3wlOxdZwl9w=
X-Google-Smtp-Source: ABdhPJysxSCBtcLFQ872AWdkEqC+j4wGJIO//q2Qx3N08A8TsdU6n3iXArSiQs9qWvT0o5zR0v4hL26KasKZlK05xaQ=
X-Received: by 2002:a05:6830:610:: with SMTP id
 w16mr12568277oti.353.1600186928418; 
 Tue, 15 Sep 2020 09:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <1600137887-58739-1-git-send-email-zhengchuan@huawei.com>
 <1600137887-58739-7-git-send-email-zhengchuan@huawei.com>
In-Reply-To: <1600137887-58739-7-git-send-email-zhengchuan@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 16 Sep 2020 00:21:32 +0800
Message-ID: <CAKXe6SLsfUmKOqzYrWNMaiC8Yo0Soj-T0bFbdhkn3qeKdADn3w@mail.gmail.com>
Subject: Re: [PATCH v9 06/12] migration/dirtyrate: Record hash results for
 each sampled page
To: Chuan Zheng <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=liq3ea@gmail.com; helo=mail-ot1-x342.google.com
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
> Record hash results for each sampled page, crc32 is taken to calculate
> hash results for each sampled length in TARGET_PAGE_SIZE.
>
> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> Reviewed-by: David Edmondson <david.edmondson@oracle.com>

Reviewed-by: Li Qiang <liq3ea@gmail.com>

> ---
>  migration/dirtyrate.c | 109 ++++++++++++++++++++++++++++++++++++++++++++=
++++++
>  1 file changed, 109 insertions(+)
>
> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> index 7366bf3..5e6eedf 100644
> --- a/migration/dirtyrate.c
> +++ b/migration/dirtyrate.c
> @@ -10,6 +10,7 @@
>   * See the COPYING file in the top-level directory.
>   */
>
> +#include <zlib.h>
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "cpu.h"
> @@ -68,6 +69,114 @@ static void update_dirtyrate(uint64_t msec)
>      DirtyStat.dirty_rate =3D dirtyrate;
>  }
>
> +/*
> + * get hash result for the sampled memory with length of TARGET_PAGE_SIZ=
E
> + * in ramblock, which starts from ramblock base address.
> + */
> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> +                                      uint64_t vfn)
> +{
> +    uint32_t crc;
> +
> +    crc =3D crc32(0, (info->ramblock_addr +
> +                vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
> +
> +    return crc;
> +}
> +
> +static bool save_ramblock_hash(struct RamblockDirtyInfo *info)
> +{
> +    unsigned int sample_pages_count;
> +    int i;
> +    GRand *rand;
> +
> +    sample_pages_count =3D info->sample_pages_count;
> +
> +    /* ramblock size less than one page, return success to skip this ram=
block */
> +    if (unlikely(info->ramblock_pages =3D=3D 0 || sample_pages_count =3D=
=3D 0)) {
> +        return true;
> +    }
> +
> +    info->hash_result =3D g_try_malloc0_n(sample_pages_count,
> +                                        sizeof(uint32_t));
> +    if (!info->hash_result) {
> +        return false;
> +    }
> +
> +    info->sample_page_vfn =3D g_try_malloc0_n(sample_pages_count,
> +                                            sizeof(uint64_t));
> +    if (!info->sample_page_vfn) {
> +        g_free(info->hash_result);
> +        return false;
> +    }
> +
> +    rand  =3D g_rand_new();
> +    for (i =3D 0; i < sample_pages_count; i++) {
> +        info->sample_page_vfn[i] =3D g_rand_int_range(rand, 0,
> +                                                    info->ramblock_pages=
 - 1);
> +        info->hash_result[i] =3D get_ramblock_vfn_hash(info,
> +                                                     info->sample_page_v=
fn[i]);
> +    }
> +    g_rand_free(rand);
> +
> +    return true;
> +}
> +
> +static void get_ramblock_dirty_info(RAMBlock *block,
> +                                    struct RamblockDirtyInfo *info,
> +                                    struct DirtyRateConfig *config)
> +{
> +    uint64_t sample_pages_per_gigabytes =3D config->sample_pages_per_gig=
abytes;
> +
> +    /* Right shift 30 bits to calc ramblock size in GB */
> +    info->sample_pages_count =3D (qemu_ram_get_used_length(block) *
> +                                sample_pages_per_gigabytes) >> 30;
> +    /* Right shift TARGET_PAGE_BITS to calc page count */
> +    info->ramblock_pages =3D qemu_ram_get_used_length(block) >>
> +                           TARGET_PAGE_BITS;
> +    info->ramblock_addr =3D qemu_ram_get_host_addr(block);
> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> +}
> +
> +static bool record_ramblock_hash_info(struct RamblockDirtyInfo **block_d=
info,
> +                                      struct DirtyRateConfig config,
> +                                      int *block_count)
> +{
> +    struct RamblockDirtyInfo *info =3D NULL;
> +    struct RamblockDirtyInfo *dinfo =3D NULL;
> +    RAMBlock *block =3D NULL;
> +    int total_count =3D 0;
> +    int index =3D 0;
> +    bool ret =3D false;
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        total_count++;
> +    }
> +
> +    dinfo =3D g_try_malloc0_n(total_count, sizeof(struct RamblockDirtyIn=
fo));
> +    if (dinfo =3D=3D NULL) {
> +        goto out;
> +    }
> +
> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> +        if (index >=3D total_count) {
> +            break;
> +        }
> +        info =3D &dinfo[index];
> +        get_ramblock_dirty_info(block, info, &config);
> +        if (!save_ramblock_hash(info)) {
> +            goto out;
> +        }
> +        index++;
> +    }
> +    ret =3D true;
> +
> +out:
> +    *block_count =3D index;
> +    *block_dinfo =3D dinfo;
> +    return ret;
> +}
> +
>  static void calculate_dirtyrate(struct DirtyRateConfig config)
>  {
>      /* todo */
> --
> 1.8.3.1
>

