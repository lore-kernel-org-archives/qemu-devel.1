Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C00C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:55:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EC7F2078D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 15:55:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KHistFr+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EC7F2078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAxlW-0002Nd-I7
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 11:55:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41798)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxkf-0001iJ-H9
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:54:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25027
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kAxkd-0001sG-VN
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 11:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598457254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UC9RQr9mgbHg1iufnazAZQaDYmD//qufqDi9sj6lVP0=;
 b=KHistFr+77+Z+nJ3JD6qPoUabWCkuU1QOxB9x4B5CnCaK0EmBertioisheR01urhWEt4VS
 2qj6OHmltOgStFW9m3HWUv5lIQ8Bswxj2FQq0BIWBmpIqAJGginbJjfhvmwLMRk6a+HF2I
 OEiF7urMNjkL0DEXoknWihGyM9dAnQI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-528-L167m-RlNQGH9cK2waQ8Sg-1; Wed, 26 Aug 2020 11:54:13 -0400
X-MC-Unique: L167m-RlNQGH9cK2waQ8Sg-1
Received: by mail-qt1-f199.google.com with SMTP id z16so2038444qtq.16
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2020 08:54:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UC9RQr9mgbHg1iufnazAZQaDYmD//qufqDi9sj6lVP0=;
 b=Hrdm9HqwL1rYLNrGvHLZDAbGT2z4AREQqxya3MmfxF0ujJB3F+JSPPtmbrkd392dmq
 AAe6wes0KTFEXFAvG+rmHPC4tFxcLs1OIn0dfYuAwPmwILLeFxy/2BXvVPvo0leVfWPH
 MABa8OB2jnduF37k/sv/1LhM/f/79IObwOJc0AF8TxJ5lpBH70GjW1g3dezcLZCynwU7
 1vo/dBiduSW61RFKeK3hSC+5RtTrBKtbZ5rz+r41lJD9ZCloAEJRjIgh1xhlJP0m7goe
 LaCiRje2mfgkRkUzM3S/VdLSqueouKdsb7+KubPPxE1o0rdHYNIGRZuAHSwbe/6u167N
 Q3+g==
X-Gm-Message-State: AOAM532/GDsGvupTOtRHvKM/U5iyvUPcMbEzFyrujUWKhRfo1SPUnp8M
 QeSLG91vyvIwRuMU9ZysDi8QD0vyc1qf1/s65nnBjJAbQv2cWbd0LPFI3YyyvksRSGac3YQBjqN
 94JVOpjIRGX1pFWY=
X-Received: by 2002:a37:7f47:: with SMTP id a68mr14299584qkd.163.1598457252586; 
 Wed, 26 Aug 2020 08:54:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpba5yIF4xS8Ne8GLd98dSOppM+SQNkUAN/p8HvupTd6v8BdqjT+c8ySmt5gArBgL5qY3xfQ==
X-Received: by 2002:a37:7f47:: with SMTP id a68mr14299557qkd.163.1598457252327; 
 Wed, 26 Aug 2020 08:54:12 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id y3sm1979374qkd.132.2020.08.26.08.54.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2020 08:54:11 -0700 (PDT)
Date: Wed, 26 Aug 2020 11:54:09 -0400
From: Peter Xu <peterx@redhat.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Subject: Re: [RFC v6 00/13] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200826155409.GG8235@xz-x1>
References: <20200625191651.5817-1-eperezma@redhat.com>
 <20200826143651.7915-1-eperezma@redhat.com>
 <CAJaqyWf5vgSNvix99aWzrm2kDZ5xHQ_binRkpTe7WifDrLCjyw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf5vgSNvix99aWzrm2kDZ5xHQ_binRkpTe7WifDrLCjyw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=peterx@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 01:10:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Yan Zhao <yan.y.zhao@intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org,
 Eric Auger <eric.auger@redhat.com>, qemu-arm@nongnu.org,
 =?utf-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>,
 Avi Kivity <avi@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Aug 26, 2020 at 05:00:30PM +0200, Eugenio Perez Martin wrote:
> Hi!
> 
> Sending v6 to see if that is on the same page as what you meant.
> Making each setting of "type" explicitly IOMMU_IOTLB_NONE if not used
> in notifications. This is done in different commits in case this helps
> review of different architectures.

I've also proposed IOMMUTLBEvent in the other reply, that might help too.

Since at it, there's also another trick to use - we don't need to touch those
"type" as long as the default type is "zero", so as long as we make sure the
default type (IOMMU_NOTIFIER_NONE) is zero, then we don't need to set it
everywhere either.

> 
> I think that this way we have too much freedom between entry flags
> (currently only access type, RW) and notification type. Since not all
> of them are valid nor used in the same context, I think this adds
> complexity. I'm wondering if:
> 
> Option a) We could make it private to memory.c, and make it a flag of
> memory_region_notify_iommu (like "bool deviotlb_type)". IOW, instead
> of making it a member of IOMMUTLBEntry, wrap the "entry" parameter of
> memory_region_notify_iommu in a new private structure defined in
> memory.c that adds that flag.

No strong preference from me.  But since you posted the series before you
provide the options... Maybe continue with what we have can be easier. :)

> 
> Option b) We could keep the IOMMUTLBNotificationType enum (open to
> suggestions for a better name :)), but not embed it in the struct,
> like:
> 
> diff --git a/include/exec/memory.h b/include/exec/memory.h
> index 477c3af24c..d9150e7b7e 100644
> --- a/include/exec/memory.h
> +++ b/include/exec/memory.h
> @@ -72,7 +72,8 @@ typedef enum {
>      IOMMU_RO   = 1,
>      IOMMU_WO   = 2,
>      IOMMU_RW   = 3,
> -} IOMMUAccessFlags;
> +    IOMMU_DEVIOTLB = 4,
> +} IOMMUEntryFlags;

Just in case you didn't notice - IOMMUAccessFlags is actaully a bitmap. :)

IMHO we can keep the IOMMUAccessFlags scemantics, since it's still correct for
a general translated IOMMUTLBEntry object.

Thanks,

-- 
Peter Xu


