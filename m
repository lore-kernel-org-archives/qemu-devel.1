Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB3DC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:34:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 195D72076C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 12:34:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=dme-org.20150623.gappssmtp.com header.i=@dme-org.20150623.gappssmtp.com header.b="jMF9UWQg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 195D72076C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=dme.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAud2-0006Dw-EE
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 08:34:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40832)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAuc6-0005gJ-3U
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:33:14 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38529)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dme@dme.org>) id 1kAuc3-0006Aa-0A
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 08:33:13 -0400
Received: by mail-wm1-x342.google.com with SMTP id t14so1597318wmi.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 05:33:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dme-org.20150623.gappssmtp.com; s=20150623;
 h=to:cc:subject:in-reply-to:references:from:date:message-id
 :mime-version; bh=+UWYFPwXMZOF13qqkzkc62QlO2r+ogjteClRM+PM/60=;
 b=jMF9UWQgeiqN+gziJ84+7BQO6+JXn+zNFrQMnFYm1DMpNm3KxM24OlGeSGW01aDvMj
 nMsY8r3hXTJUOZNaNOR7uowOoIqYLZrM4OuF90baJ04lyKBFuYToSzlAc3E0rR6izE3z
 iHjmuKU6ke1mIofCyIyJ5SCHsTXxm5OJaNS8OqPws0rv0EeeG2T9Pml8phRD6IXNOd7a
 BK4C5ZYI+iKPBS7L2SfqRK+BPbz6msTKyPKWSZFBodhWBmwrcxesZfKFkdyO2V3P1d6k
 R9OiRIO1JQ+p7I4WhWP0oFH98jy100fqTiPmCLxzHgovFuEhXDpLqyzBAjKLQ2JO878g
 e/JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:cc:subject:in-reply-to:references:from:date
 :message-id:mime-version;
 bh=+UWYFPwXMZOF13qqkzkc62QlO2r+ogjteClRM+PM/60=;
 b=HCm8jnL4roiKFAZM63Rw1IJPiHsNpRUU8PtQGGQWQqreSJc+iwMA7eP77ZX+O3VWhU
 WW/ovL2856x0dcHJfid2yHJRLiClekJ945vXFCvBAmnXXklmMYyz1KKYslh3DWqS9asW
 TQvOt8afCUfiQwHteYGscizkGg3wCnzM8UELC9MFpbpPn9AzVN/J9ArRh2f9jSYoqqNB
 0TqTcmRmD5AZy7jt/V1VBM4zSFTBLjghnbEiRnENStSgj4WAGqZL+gp+t+5e88ehG9Iv
 GLhciR24LPu1vWC5CI0ahJ7kF6yifFcFOdA4F567VTcx0M2XyQCK8PGVXTvs2CqWROil
 u0nA==
X-Gm-Message-State: AOAM531l5qyrSjvKHohoZ7SCSBccpk292G8Nb1pvlKujMEWsAPCqjB9O
 YjKFhzFDllT7/cGLFPIBm/TH/g==
X-Google-Smtp-Source: ABdhPJyOHY976zagODNRaF5DxYjdtDNTRugj0EuNNAjGMSfjFLar7n2de9iOWg8twfNIvu59Vh5MCQ==
X-Received: by 2002:a05:600c:10cf:: with SMTP id
 l15mr7012719wmd.149.1598445189341; 
 Wed, 26 Aug 2020 05:33:09 -0700 (PDT)
Received: from disaster-area.hh.sledj.net
 (8.a.e.d.0.0.0.0.0.0.0.0.4.6.0.0.0.4.1.7.1.7.b.b.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:bb71:7140:64::dea8])
 by smtp.gmail.com with ESMTPSA id q12sm4874771wrn.94.2020.08.26.05.33.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 05:33:08 -0700 (PDT)
Received: from localhost (disaster-area.hh.sledj.net [local])
 by disaster-area.hh.sledj.net (OpenSMTPD) with ESMTPA id 906820e8;
 Wed, 26 Aug 2020 12:33:07 +0000 (UTC)
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [PATCH v5 06/12] migration/dirtyrate: Record hash results for
 each sampled page
In-Reply-To: <20200826123016.GA2727@work-vm>
References: <1598260480-64862-1-git-send-email-zhengchuan@huawei.com>
 <1598260480-64862-7-git-send-email-zhengchuan@huawei.com>
 <m2eentlogl.fsf@dme.org> <20200826123016.GA2727@work-vm>
X-HGTTG: heart-of-gold
From: David Edmondson <dme@dme.org>
Date: Wed, 26 Aug 2020 13:33:07 +0100
Message-ID: <m2r1rtk2nw.fsf@dme.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: neutral client-ip=2a00:1450:4864:20::342;
 envelope-from=dme@dme.org; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, UNPARSEABLE_RELAY=0.001 autolearn=no autolearn_force=no
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
Cc: alex.chen@huawei.com, berrange@redhat.com, zhang.zhanghailiang@huawei.com,
 quintela@redhat.com, qemu-devel@nongnu.org, xiexiangyou@huawei.com,
 Chuan Zheng <zhengchuan@huawei.com>, ann.zhuangyanying@huawei.com,
 fangying1@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wednesday, 2020-08-26 at 13:30:16 +01, Dr. David Alan Gilbert wrote:

> * David Edmondson (dme@dme.org) wrote:
>> On Monday, 2020-08-24 at 17:14:34 +08, Chuan Zheng wrote:
>> 
>> > Record hash results for each sampled page, crc32 is taken to calculate
>> > hash results for each sampled 4K-page.
>> >
>> > Signed-off-by: Chuan Zheng <zhengchuan@huawei.com>
>> > Signed-off-by: YanYing Zhuang <ann.zhuangyanying@huawei.com>
>> > ---
>> >  migration/dirtyrate.c | 136 ++++++++++++++++++++++++++++++++++++++++++++++++++
>> >  migration/dirtyrate.h |  15 ++++++
>> >  2 files changed, 151 insertions(+)
>> >
>> > diff --git a/migration/dirtyrate.c b/migration/dirtyrate.c
>> > index f6a94d8..66de426 100644
>> > --- a/migration/dirtyrate.c
>> > +++ b/migration/dirtyrate.c
>> > @@ -10,6 +10,7 @@
>> >   * See the COPYING file in the top-level directory.
>> >   */
>> >  
>> > +#include <zlib.h>
>> >  #include "qemu/osdep.h"
>> >  #include "qapi/error.h"
>> >  #include "crypto/hash.h"
>> > @@ -66,6 +67,141 @@ static void update_dirtyrate(uint64_t msec)
>> >      DirtyStat.dirty_rate = dirtyrate;
>> >  }
>> >  
>> > +/*
>> > + * get hash result for the sampled memory with length of 4K byte in ramblock,
>> > + * which starts from ramblock base address.
>> > + */
>> > +static uint32_t get_ramblock_vfn_hash(struct RamblockDirtyInfo *info,
>> > +                                      uint64_t vfn)
>> > +{
>> > +    struct iovec iov_array;
>> 
>> There's no need for an iovec now that crc32() is being used.
>> 
>> > +    uint32_t crc;
>> > +
>> > +    iov_array.iov_base = info->ramblock_addr +
>> > +                         vfn * DIRTYRATE_SAMPLE_PAGE_SIZE;
>> > +    iov_array.iov_len = DIRTYRATE_SAMPLE_PAGE_SIZE;
>> > +
>> > +    crc = crc32(0, iov_array.iov_base, iov_array.iov_len);
>> > +
>> > +    return crc;
>> > +}
>> > +
>> > +static int save_ramblock_hash(struct RamblockDirtyInfo *info)
>> > +{
>> > +    unsigned int sample_pages_count;
>> > +    int i;
>> > +    int ret = -1;
>> 
>> There's no need to initialise "ret".
>> 
>> > +    GRand *rand = g_rand_new();
>> 
>> Calling g_rand_new() when the result may not be used (because of the
>> various conditions immediately below) seems as though it might waste
>> entropy. Could this be pushed down just above the loop? It would even
>> get rid of the gotos ;-)
>> 
>> > +    sample_pages_count = info->sample_pages_count;
>> > +
>> > +    /* ramblock size less than one page, return success to skip this ramblock */
>> > +    if (unlikely(info->ramblock_pages == 0 || sample_pages_count == 0)) {
>> > +        ret = 0;
>> > +        goto out;
>> > +    }
>> > +
>> > +    info->hash_result = g_try_malloc0_n(sample_pages_count,
>> > +                                        sizeof(uint32_t));
>> > +    if (!info->hash_result) {
>> > +        ret = -1;
>> > +        goto out;
>> > +    }
>> > +
>> > +    info->sample_page_vfn = g_try_malloc0_n(sample_pages_count,
>> > +                                            sizeof(uint64_t));
>> > +    if (!info->sample_page_vfn) {
>> > +        g_free(info->hash_result);
>> > +        ret = -1;
>> > +        goto out;
>> > +    }
>> > +
>> > +    for (i = 0; i < sample_pages_count; i++) {
>> > +        info->sample_page_vfn[i] = g_rand_int_range(rand, 0,
>> > +                                                    info->ramblock_pages - 1);
>> > +        info->hash_result[i] = get_ramblock_vfn_hash(info,
>> > +                                                     info->sample_page_vfn[i]);
>> > +    }
>> > +    ret = 0;
>> > +
>> > +out:
>> > +    g_rand_free(rand);
>> > +    return ret;
>> > +}
>> > +
>> > +static void get_ramblock_dirty_info(RAMBlock *block,
>> > +                                    struct RamblockDirtyInfo *info,
>> > +                                    struct DirtyRateConfig *config)
>> > +{
>> > +    uint64_t sample_pages_per_gigabytes = config->sample_pages_per_gigabytes;
>> > +
>> > +    /* Right shift 30 bits to calc block size in GB */
>> > +    info->sample_pages_count = (qemu_ram_get_used_length(block) *
>> > +                                sample_pages_per_gigabytes) >>
>> > +                                DIRTYRATE_PAGE_SHIFT_GB;
>> 
>> Doing the calculation this way around seems odd. Why was it not:
>> 
>>     info->sample_pages_count = (qemu_ram_get_used_length(block) >>
>>                                 DIRTYRATE_PAGE_SHIFT_GB) *
>>                                 sample_pages_per_gigabytes;
>> 
>> ?
>
> Because that would give 0 for a 0.5GB block

Ouch, obviously :-) Thanks.

dme.
-- 
And removed his hat, in respect of her presence.

