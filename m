Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00698C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:32:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB77020720
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 21:32:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=braap-org.20150623.gappssmtp.com header.i=@braap-org.20150623.gappssmtp.com header.b="bVViTTp6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB77020720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=braap.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juN6L-0008C8-TN
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 17:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46696)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juN52-0007jr-5G
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:30:44 -0400
Received: from mail-ua1-x942.google.com ([2607:f8b0:4864:20::942]:34803)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cota@braap.org>) id 1juN50-0002AK-85
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 17:30:43 -0400
Received: by mail-ua1-x942.google.com with SMTP id o25so2909566uar.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 14:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=braap-org.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nVs6PB+Evl8tJV/lV5dAfyvOrx9yLdikJXAgX4bot14=;
 b=bVViTTp6cbgIQ8PAFpUa2Cdte60lwXJ0cNJih8k98An8pnfniixuvR0D1A9GnDnkNn
 xns5UgwoAZpM3v17krlZ0mSyP0TOwJTfeyd9zGW1fzkLz31j8SSjZXZWm2eeWlbKPuC1
 qYPVOuBIVfifL06QlBuhQLqU/jIhjSKqFuPFrLflFvytccVmR+k9hNh2B4+35nhlwt5u
 ACES9gIw5jdH7etTslAMomWND+8Ex00TRvTRvsbbQywExcIRxGz5ZmX64iMQ0cXQG48i
 XYWcml1/JMkCHW/oiFyeex/Cr2P5QZ+sIu4Bu5rItvst9Y/6kqKiLgXXIbRuUytECud2
 WQCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nVs6PB+Evl8tJV/lV5dAfyvOrx9yLdikJXAgX4bot14=;
 b=jdjIyQqc7xnMO7pngG8AwkZgLoArM7NOn2U+ndcYISNWPxmINOguZc1EzYvcgG3d6D
 Tt56tTI9TKtH3Hk+yZe/rQa0QZTdAKlLRt+SI0S+7y7T4EZhiX+AK13yiK0gjC5x8W99
 AOGEufkWgdLkeDOjGjrUCCgupjQqJy8Be6rw+KUg+zny7Dp9ik2W++yNf+Fv7ok83aXY
 8lduQnyYwW56INai69W7TvuKPRPisy6N+HsCwxmwt0LOsWk2EawuSTk7bXEQ2O8UecnA
 RFveR6WN5rSEU/FhxLGMlqLNBwlX4YSaVVK5JOPOE05Px643UHbX4A3d3MOAn8SRyz/4
 ncIQ==
X-Gm-Message-State: AOAM530pyoRNHkDB14jRDvJWnXvQyAwUAo4biDiyXNUQPs9mkjzvZ7r7
 M/fAqbIttZLp5d0g2yV9FqpfHA==
X-Google-Smtp-Source: ABdhPJxtA99b16v2DMOjZNk1DW4ce1CJOIrG7TTtBfwOpRXBuUrhnvVdJhTbO+fccyvVFPF56K8Dvw==
X-Received: by 2002:ab0:65c7:: with SMTP id n7mr55455787uaq.30.1594503040891; 
 Sat, 11 Jul 2020 14:30:40 -0700 (PDT)
Received: from localhost ([37.120.215.156])
 by smtp.gmail.com with ESMTPSA id q5sm1171697uam.9.2020.07.11.14.30.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Jul 2020 14:30:40 -0700 (PDT)
Date: Sat, 11 Jul 2020 17:30:39 -0400
From: "Emilio G. Cota" <cota@braap.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v1 04/13] cputlb: ensure we save the IOTLB data in case
 of reset
Message-ID: <20200711213039.GD807960@sff>
References: <20200709141327.14631-1-alex.bennee@linaro.org>
 <20200709141327.14631-5-alex.bennee@linaro.org>
 <7ebfe683-5c6b-064b-7bab-3b9624f0a3f8@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ebfe683-5c6b-064b-7bab-3b9624f0a3f8@linaro.org>
Received-SPF: softfail client-ip=2607:f8b0:4864:20::942;
 envelope-from=cota@braap.org; helo=mail-ua1-x942.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -11
X-Spam_score: -1.2
X-Spam_bar: -
X-Spam_report: (-1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_SOFTFAIL=0.665 autolearn=no autolearn_force=no
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
Cc: fam@euphon.net, berrange@redhat.com, robert.foley@linaro.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 robhenry@microsoft.com, f4bug@amsat.org, aaron@os.amperecomputing.com,
 Paolo Bonzini <pbonzini@redhat.com>, kuhn.chenqun@huawei.com,
 peter.puhov@linaro.org, Eduardo Habkost <ehabkost@redhat.com>,
 aurelien@aurel32.net, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 10, 2020 at 14:03:27 -0700, Richard Henderson wrote:
> On 7/9/20 7:13 AM, Alex Bennée wrote:
> > Any write to a device might cause a re-arrangement of memory
> > triggering a TLB flush and potential re-size of the TLB invalidating
> > previous entries. This would cause users of qemu_plugin_get_hwaddr()
> > to see the warning:
> > 
> >   invalid use of qemu_plugin_get_hwaddr
> > 
> > because of the failed tlb_lookup which should always succeed. To
> > prevent this we save the IOTLB data in case it is later needed by a
> > plugin doing a lookup.
> > 
> > Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> > 
> > ---
> > v2
> >   - save the entry instead of re-running the tlb_fill.
> > v3
> >   - don't abuse TLS, use CPUState to store data
> >   - just use g_free_rcu() to avoid ugliness
> >   - verify addr matches before returning data
> >   - ws fix
> > ---
> >  include/hw/core/cpu.h   |  4 +++
> >  include/qemu/typedefs.h |  1 +
> >  accel/tcg/cputlb.c      | 57 +++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 60 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
> > index b3f4b7931823..bedbf098dc57 100644
> > --- a/include/hw/core/cpu.h
> > +++ b/include/hw/core/cpu.h
> > @@ -417,7 +417,11 @@ struct CPUState {
> >  
> >      DECLARE_BITMAP(plugin_mask, QEMU_PLUGIN_EV_MAX);
> >  
> > +#ifdef CONFIG_PLUGIN
> >      GArray *plugin_mem_cbs;
> > +    /* saved iotlb data from io_writex */
> > +    SavedIOTLB *saved_iotlb;
> > +#endif
> >  
> >      /* TODO Move common fields from CPUArchState here. */
> >      int cpu_index;
> > diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
> > index 15f5047bf1dc..427027a9707a 100644
> > --- a/include/qemu/typedefs.h
> > +++ b/include/qemu/typedefs.h
> > @@ -116,6 +116,7 @@ typedef struct QObject QObject;
> >  typedef struct QString QString;
> >  typedef struct RAMBlock RAMBlock;
> >  typedef struct Range Range;
> > +typedef struct SavedIOTLB SavedIOTLB;
> >  typedef struct SHPCDevice SHPCDevice;
> >  typedef struct SSIBus SSIBus;
> >  typedef struct VirtIODevice VirtIODevice;
> > diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> > index 1e815357c709..8636b66e036a 100644
> > --- a/accel/tcg/cputlb.c
> > +++ b/accel/tcg/cputlb.c
> > @@ -1073,6 +1073,42 @@ static uint64_t io_readx(CPUArchState *env, CPUIOTLBEntry *iotlbentry,
> >      return val;
> >  }
> >  
> > +#ifdef CONFIG_PLUGIN
> > +
> > +typedef struct SavedIOTLB {
> > +    struct rcu_head rcu;
> > +    hwaddr addr;
> > +    MemoryRegionSection *section;
> > +    hwaddr mr_offset;
> > +} SavedIOTLB;
> > +
> > +/*
> > + * Save a potentially trashed IOTLB entry for later lookup by plugin.
> > + *
> > + * We also need to track the thread storage address because the RCU
> > + * cleanup that runs when we leave the critical region (the current
> > + * execution) is actually in a different thread.
> > + */
> > +static void save_iotlb_data(CPUState *cs, hwaddr addr, MemoryRegionSection *section, hwaddr mr_offset)
> 
> Overlong line.
> 
> > +{
> > +    SavedIOTLB *old, *new = g_new(SavedIOTLB, 1);
> > +    new->addr = addr;
> > +    new->section = section;
> > +    new->mr_offset = mr_offset;
> > +    old = atomic_rcu_read(&cs->saved_iotlb);
> > +    atomic_rcu_set(&cs->saved_iotlb, new);
> > +    if (old) {
> > +        g_free_rcu(old, rcu);
> > +    }
> > +}
> 
> I'm a bit confused by this.  Why all the multiple allocation?  How many
> consumers are you expecting, and more are you expecting multiple memory
> operations in flight at once?
> 
> If multiple memory operations in flight, then why aren't we chaining them
> together, so that you can search through multiple alternatives.
> 
> If only one memory operation in flight, why are you allocating memory at all,
> much less managing it with rcu?  Just put one structure (or a collection of
> fields) into CPUState and be done.

Oh I just saw this reply. I subscribe all of the above, please shelve my R-b
tag until these are resolved.

An alternative is to emit the hwaddr directly in the mem_cb -- IIRC this is
how I did it originally. The API is a larger/uglier (plugins can subscribe
to either hwaddr or vaddr callbacks) but there is no state to keep and
no overhead of calling several functions in a hot path.

Thanks,
		E.

