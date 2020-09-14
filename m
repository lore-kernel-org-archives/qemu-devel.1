Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E215C43461
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:26:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCB97208DB
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 11:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fv+ydcAm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCB97208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHmdC-0002jc-S6
	for qemu-devel@archiver.kernel.org; Mon, 14 Sep 2020 07:26:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHmca-0001ss-31
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:26:08 -0400
Received: from mail-oo1-xc43.google.com ([2607:f8b0:4864:20::c43]:46176)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <liq3ea@gmail.com>) id 1kHmcW-0008Vp-Ap
 for qemu-devel@nongnu.org; Mon, 14 Sep 2020 07:26:07 -0400
Received: by mail-oo1-xc43.google.com with SMTP id b12so1141134oop.13
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2020 04:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=MhB13M777nf2XP/E2EcaUuuFqy+L4663syp+F2TK57o=;
 b=Fv+ydcAm9oYvuW3jzaHFPklX2nacv583YsJMFbQoz4LL6tEhGoaqn3RU/4Rzl55tXy
 ZL7CBMUtqy3AirPjmOgaleLYd4ZRDW8vMMAtxXlW66qhFaY5Naf8fAH86qqe8sLp4Pfe
 Vjs4gEpDEq3/TlMop9qz5kxtmJp2s+V9j5x8IfJMhe1TivQgKOplgNO0OQoAHDjkaxYC
 NS3I13aDEJdRx3txwRgC7K5d2Tgxn9RNNj3EFqr6GcVZskuYgpNk+xwk7s5TzAkci/gP
 dkapNnJsamjZMFne9+KSVhBan24WvvQruPloNDtH5sFbPgpB4N7z8eCOrKY+Tp5BXm+b
 UvwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=MhB13M777nf2XP/E2EcaUuuFqy+L4663syp+F2TK57o=;
 b=HnwIYemC6Gfc9B8oM1IFpBZX7LnzYQVFPcYzQSGwdyEABbEdDocnNrvD61iImobmGl
 dCBb8NIpjECPyQj+7vCEyJdkLF/RHw0ptFSu9773oFKBTSljOptNBQO57pgA9xRrvCf0
 diATwuGEHhWGD9M74lO3vzytrDyRRaj7QpsfXBI5jFAJte5qJ42oHrERY7QMB2VrrF7q
 hCCAQ10TM5yeCLdDiH/TSsMgCdEre1UnFB+leneze2voXU3+GCH4Bqs4U+z1n3gr2H3q
 Ve3iJLG0YepLAJBc9pOB7E/E65nNh0D7O4vT5W4Bse6neoBE1wTdOtQ2G5NraSE7b8/b
 ryuQ==
X-Gm-Message-State: AOAM533pHw0ICS17ny+Bwa0qNanbnW2GmgT7tfzLQw76RiQTv8iKzdmo
 qUuRDsxLCUh3zcVryQITPZFl/nipjyAjrM02h/g=
X-Google-Smtp-Source: ABdhPJyQGLKkeKaFH4Nkui85O0xv108M5CEqHXE8ltk8xu3h8DpRJm7kZAfqJipu3xFUuxv9vLyJZTwrMidUUvZGhwk=
X-Received: by 2002:a4a:5a06:: with SMTP id v6mr9880611ooa.22.1600082762141;
 Mon, 14 Sep 2020 04:26:02 -0700 (PDT)
MIME-Version: 1.0
References: <1599661096-127913-1-git-send-email-zhengchuan@huawei.com>
 <1599661096-127913-7-git-send-email-zhengchuan@huawei.com>
 <CAKXe6SJBwKU-hFvEOCnE-N4mqT5+iBHA+220HBbxX5C-F9b0Gw@mail.gmail.com>
 <e55d6294-6449-9015-0580-33ee05ada800@huawei.com>
In-Reply-To: <e55d6294-6449-9015-0580-33ee05ada800@huawei.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Mon, 14 Sep 2020 19:25:26 +0800
Message-ID: <CAKXe6SLM6mSh3C1EM9MdK4+4WXpUOnM3FvsqciFBY9k6vnx=ew@mail.gmail.com>
Subject: Re: [PATCH v7 06/12] migration/dirtyrate: Record hash results for
 each sampled page
To: Zheng Chuan <zhengchuan@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c43;
 envelope-from=liq3ea@gmail.com; helo=mail-oo1-xc43.google.com
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
 zhanghailiang <zhang.zhanghailiang@huawei.com>, David Edmondson <dme@dme.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, xiexiangyou@huawei.com,
 Qemu Developers <qemu-devel@nongnu.org>, AlexChen <alex.chen@huawei.com>,
 ann.zhuangyanying@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Zheng Chuan <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=8813=E6=
=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8A=E5=8D=8810:59=E5=86=99=E9=81=93=EF=BC=9A
>
>
>
> On 2020/9/10 21:51, Li Qiang wrote:
> > Chuan Zheng <zhengchuan@huawei.com> =E4=BA=8E2020=E5=B9=B49=E6=9C=889=
=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=8810:14=E5=86=99=E9=81=93=EF=BC=
=9A
> >>
> >> Record hash results for each sampled page, crc32 is taken to calculate
> >> hash results for each sampled length in TARGET_PAGE_SIZE.
> >>
> >> Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
> >> Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
> >> Reviewed-by: David Edmondson <david.edmondson@oracle.com>
> >> ---
> >>  migration/dirtyrate.c | 125 +++++++++++++++++++++++++++++++++++++++++=
+++++++++
> >>  1 file changed, 125 insertions(+)
> >>
> >> diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
> >> index d56cd93..bc87269 100644
> >> --- a/migration/dirtyrate.c
> >> +++ b/migration/dirtyrate.c
> >> @@ -10,6 +10,7 @@
> >>   * See the COPYING file in the top-level directory.
> >>   */
> >>
> >> +#include <zlib.h>
> >>  #include "qemu/osdep.h"
> >>  #include "qapi/error.h"
> >>  #include "cpu.h"
> >> @@ -68,6 +69,130 @@ static void update_dirtyrate(uint64_t msec)
> >>      DirtyStat.dirty_rate =3D dirtyrate;
> >>  }
> >>
> >> +/*
> >> + * get hash result for the sampled memory with length of TARGET_PAGE_=
SIZE
> >> + * in ramblock, which starts from ramblock base address.
> >> + */
> >> +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
> >> +                                      uint64_t vfn)
> >> +{
> >> +    uint32_t crc;
> >> +
> >> +    crc =3D crc32(0, (info->ramblock_addr +
> >> +                vfn * TARGET_PAGE_SIZE), TARGET_PAGE_SIZE);
> >> +
> >> +    return crc;
> >> +}
> >> +
> >> +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
> >> +{
> >> +    unsigned int sample_pages_count;
> >> +    int i;
> >> +    GRand *rand;
> >> +
> >> +    sample_pages_count =3D info->sample_pages_count;
> >> +
> >> +    /* ramblock size less than one page, return success to skip this =
ramblock */
> >> +    if (unlikely(info->ramblock_pages =3D=3D 0 || sample_pages_count =
=3D=3D 0)) {
> >> +        return 0;
> >> +    }
> >> +
> >> +    info->hash_result =3D g_try_malloc0_n(sample_pages_count,
> >> +                                        sizeof(uint32_t));
> >> +    if (!info->hash_result) {
> >> +        return -1;
> >> +    }
> >> +
> >> +    info->sample_page_vfn =3D g_try_malloc0_n(sample_pages_count,
> >> +                                            sizeof(uint64_t));
> >> +    if (!info->sample_page_vfn) {
> >> +        g_free(info->hash_result);
> >> +        return -1;
> >> +    }
> >> +
> >> +    rand  =3D g_rand_new();
> >> +    for (i =3D 0; i < sample_pages_count; i++) {
> >> +        info->sample_page_vfn[i] =3D g_rand_int_range(rand, 0,
> >> +                                                    info->ramblock_pa=
ges - 1);
> >> +        info->hash_result[i] =3D get_ramblock_vfn_hash(info,
> >> +                                                     info->sample_pag=
e_vfn[i]);
> >> +    }
> >> +    g_rand_free(rand);
> >> +
> >> +    return 0;
> >> +}
> >> +
> >> +static void get_ramblock_dirty_info(RAMBlock *block,
> >> +                                    struct RamblockDirtyInfo *info,
> >> +                                    struct DirtyRateConfig *config)
> >> +{
> >> +    uint64_t sample_pages_per_gigabytes =3D config->sample_pages_per_=
gigabytes;
> >> +
> >> +    /* Right shift 30 bits to calc ramblock size in GB */
> >> +    info->sample_pages_count =3D (qemu_ram_get_used_length(block) *
> >> +                                sample_pages_per_gigabytes) >> 30;
> >> +    /* Right shift TARGET_PAGE_BITS to calc page count */
> >> +    info->ramblock_pages =3D qemu_ram_get_used_length(block) >>
> >> +                           TARGET_PAGE_BITS;
> >> +    info->ramblock_addr =3D qemu_ram_get_host_addr(block);
> >> +    strcpy(info->idstr, qemu_ram_get_idstr(block));
> >> +}
> >> +
> >> +static struct RamblockDirtyInfo *
> >> +alloc_ramblock_dirty_info(int *block_index,
> >> +                          struct RamblockDirtyInfo *block_dinfo)
> >> +{
> >> +    struct RamblockDirtyInfo *info =3D NULL;
> >> +    int index =3D *block_index;
> >> +
> >> +    if (!block_dinfo) {
> >> +        index =3D 0;
> >> +        block_dinfo =3D g_try_new(struct RamblockDirtyInfo, 1);
> >> +    } else {
> >> +        index++;
> >> +        block_dinfo =3D g_try_realloc(block_dinfo, (index + 1) *
> >> +                                    sizeof(struct RamblockDirtyInfo))=
;
> >> +    }
> >> +    if (!block_dinfo) {
> >> +        return NULL;
> >
> > What if this case happens the 'index' has been increased?  but the
> > allocation is failed.
> >
> >> +    }
> >> +
> >> +    info =3D &block_dinfo[index];
> >> +    *block_index =3D index;
> >> +    memset(info, 0, sizeof(struct RamblockDirtyInfo));
> >> +
> >> +    return block_dinfo;
> >> +}
> >> +
> >> +static int record_ramblock_hash_info(struct RamblockDirtyInfo **block=
_dinfo,
> >> +                                     struct DirtyRateConfig config,
> >> +                                     int *block_index)
> >> +{
> >> +    struct RamblockDirtyInfo *info =3D NULL;
> >> +    struct RamblockDirtyInfo *dinfo =3D NULL;
> >> +    RAMBlock *block =3D NULL;
> >> +    int index =3D 0;
> >> +
> >> +    RAMBLOCK_FOREACH_MIGRATABLE(block) {
> >> +        dinfo =3D alloc_ramblock_dirty_info(&index, dinfo);
> >
> > Here for every migratable block, you call 'alloc_ramblock_dirty_info'.
> > This also complicates the 'alloc_ramblock_dirty_info' itself as:
> > 1. you need to differentiate the first and other element.
> > 2. you need to use two out parameter which seems can make confusion.
> >
> > Could we allocates this array at onetime.  This maybe two iteration
> > the ram block list.
> > But I think may make the code more simple and clean.
> >
> > Thank,s
> > Li Qiang
> >
> Hi, Qiang.
> Thank you for your review.
> I am not sure if i fully understand what's you mean:)
> You mean we first record total index by first iteration
> the ram block list and allocate array at onetime=EF=BC=9F

Hi Chuan,

Yes, this is what I mean.
I have just see your new patches, will review asap.

Thanks,
Li Qiang

>
> >> +        if (dinfo =3D=3D NULL) {
> >> +            return -1;
> >> +        }
> >> +        info =3D &dinfo[index];
> >> +        get_ramblock_dirty_info(block, info, &config);
> >> +        if (save_ramblock_hash(info) < 0) {
> >> +            *block_dinfo =3D dinfo;
> >> +            *block_index =3D index;
> >
> > As the first comment, here 'index' seems not right?
> >
> >
> > Thanks,
> > Li Qiang
> >> +            return -1;
> >> +        }
> >> +    }
> >> +
> >> +    *block_dinfo =3D dinfo;
> >> +    *block_index =3D index;
> >> +
> >> +    return 0;
> >> +}
> >> +
> >>  static void calculate_dirtyrate(struct DirtyRateConfig config)
> >>  {
> >>      /* todo */
> >> --
> >> 1.8.3.1
> >>
> >>
> >
> > .
> >

