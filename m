Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1F3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:56:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B88D20738
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 11:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vu7oRjBJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B88D20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgoUQ-00058Z-EP
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 07:56:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46396)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoTj-0004ci-6w
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:56:11 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:48266
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jgoTh-000764-IW
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 07:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591271767;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WYwDLZoaV6EnQsWcC9IAXNp2jZipf5TRb6Vq5GeqyqI=;
 b=Vu7oRjBJsc3r3YarGVN75Oyc8HTFBsJV/CgKjE/fRxnZwPaRA4OZmZEW9GonPRZCzm8o+5
 jYfDdPo3/ENUKSas+Hy7mBHuJt3450JuFYmD4kPvAbiCt1cQDnuGhEuExtogW1wPn3hzzj
 YV4czi2jzrbCG2/DZu41MxxJT2WGUhY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-h9dZcaZOM9SaXxteXZ9Eyg-1; Thu, 04 Jun 2020 07:56:04 -0400
X-MC-Unique: h9dZcaZOM9SaXxteXZ9Eyg-1
Received: by mail-wr1-f71.google.com with SMTP id w16so2327443wru.18
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 04:56:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nSn0WcFrFNhvO1HQY9en3Fqf/jjwkBolf/xs5w1Cfgw=;
 b=VoQSmlB3AJyR6h0V2W6TDvb2d/QNu/+6ebPbzWvRTIA7hlCIZVKCO3IhhIJ0LX0Nd0
 pQvlqs4/zWbti6zEqw+T/8d+CjBXteF+3kBpqONifvB5rVdDfIhNr6Hh9me8ZqOI3aTG
 7enpvlKblFU+tJkxuH3/QeDnB9rwEmS18FgRVGea4gD3MlHZwK+L8IMMSiCbO2FIib12
 GF9RFUa8jcR//TC/K1w4W9+HVoqPdXxJ8MBtTK/rMC7qkIAQOuwZax6EW9YbZ83Rm7T0
 QzSazuAXDynF3R+Soq7zNGV5/uaC0n7dj3kLTO4R3IoS3OsrN2+oyol7MKFDwEj7jtp1
 kYvA==
X-Gm-Message-State: AOAM5335LIXgmyZgrLQufyEp3vtSU8+coYULCISeTx03lgygPoYMSgCk
 NCtf6P83GcxqBIg5Jyo+/clVxIdmC/ERulEvNQskKex0jAsv3JKF8aivuf8wA92X8M1oGNWWdyP
 o95/Z+Ugb+P+q55I=
X-Received: by 2002:adf:fec3:: with SMTP id q3mr4001583wrs.123.1591271763738; 
 Thu, 04 Jun 2020 04:56:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw26ohIkqb17cIRZDHPvAZ0q0c78T29ZWdiMNtr/NHkGz+gZYU7g11R3n/Ufz4W0Q4QycI4Jw==
X-Received: by 2002:adf:fec3:: with SMTP id q3mr4001565wrs.123.1591271763468; 
 Thu, 04 Jun 2020 04:56:03 -0700 (PDT)
Received: from redhat.com ([2a00:a040:185:f65:9a3b:8fff:fed3:ad8d])
 by smtp.gmail.com with ESMTPSA id d15sm8245770wrq.30.2020.06.04.04.56.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 04:56:02 -0700 (PDT)
Date: Thu, 4 Jun 2020 07:55:59 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
Message-ID: <20200604075020-mutt-send-email-mst@kernel.org>
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604071504-mutt-send-email-mst@kernel.org>
 <87ftbb59vm.fsf@linaro.org>
MIME-Version: 1.0
In-Reply-To: <87ftbb59vm.fsf@linaro.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 01:31:23
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 04, 2020 at 12:49:17PM +0100, Alex Bennée wrote:
> 
> Michael S. Tsirkin <mst@redhat.com> writes:
> 
> > On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex BennÃ©e wrote:
> >> The purpose of vhost_section is to identify RAM regions that need to
> >> be made available to a vhost client. However when running under TCG
> >> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
> >> down the line. The original comment implies VGA regions are a problem
> >> but doesn't explain why vhost has a problem with it.
> >> 
> >> Re-factor the code so:
> >> 
> >>   - steps are clearer to follow
> >>   - reason for rejection is recorded in the trace point
> >>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
> >> 
> >> Signed-off-by: Alex BennÃ©e <alex.bennee@linaro.org>
> >> Cc: Michael S. Tsirkin <mst@redhat.com>
> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
> >> ---
> >>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
> >>  1 file changed, 32 insertions(+), 14 deletions(-)
> >> 
> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> >> index aff98a0ede5..f81fc87e74c 100644
> >> --- a/hw/virtio/vhost.c
> >> +++ b/hw/virtio/vhost.c
> >> @@ -27,6 +27,7 @@
> >>  #include "migration/blocker.h"
> >>  #include "migration/qemu-file-types.h"
> >>  #include "sysemu/dma.h"
> >> +#include "sysemu/tcg.h"
> >>  #include "trace.h"
> >>  
> >>  /* enabled until disconnected backend stabilizes */
> >> @@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vhost_dev *dev,
> >>      return r;
> >>  }
> >>  
> >> +/*
> >> + * vhost_section: identify sections needed for vhost access
> >> + *
> >> + * We only care about RAM sections here (where virtqueue can live). If
> >> + * we find one we still allow the backend to potentially filter it out
> >> + * of our list.
> >> + */
> >>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *section)
> >>  {
> >> -    bool result;
> >> -    bool log_dirty = memory_region_get_dirty_log_mask(section->mr) &
> >> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
> >> -    result = memory_region_is_ram(section->mr) &&
> >> -        !memory_region_is_rom(section->mr);
> >> -
> >> -    /* Vhost doesn't handle any block which is doing dirty-tracking other
> >> -     * than migration; this typically fires on VGA areas.
> >> -     */
> >> -    result &= !log_dirty;
> >> +    enum { OK = 0, NOT_RAM, DIRTY, FILTERED } result = NOT_RAM;
> >
> > I'm not sure what does this enum buy us as compared to bool.
> 
> The only real point of the enum is to give a little more detailed
> information to the trace point to expose why a section wasn't included.
> In a previous iteration I just had the tracepoint at the bottom before a
> return true where all other legs had returned false. We could switch to
> just having the tracepoint hit for explicit inclusions?

I didn't notice.  Yes, ok more tracepoints IMHO.

> > Also why force OK to 0?
> 
> Personal preference where 0 indicates success and !0 indicates failure
> of various kinds. Again we can drop if we don't want the information in
> the tracepoint.

So in that case we need to set all values so people can decode them
from the trace. But I think it's best to just have more trace points
or drop it from the trace.

> > And I prefer an explicit "else result = NOT_RAM" below
> > instead of initializing it here.
> 
> Ok.
> 
> >
> >> +
> >> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(section->mr)) {
> >> +        uint8_t dirty_mask = memory_region_get_dirty_log_mask(section->mr);
> >> +        uint8_t handled_dirty;
> >>  
> >> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
> >> -        result &=
> >> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, section);
> >> +        /*
> >> +         * Vhost doesn't handle any block which is doing dirty-tracking other
> >> +         * than migration; this typically fires on VGA areas. However
> >> +         * for TCG we also do dirty code page tracking which shouldn't
> >> +         * get in the way.
> >> +         */
> >> +        handled_dirty = (1 << DIRTY_MEMORY_MIGRATION);
> >> +        if (tcg_enabled()) {
> >> +            handled_dirty |= (1 << DIRTY_MEMORY_CODE);
> >> +        }
> >
> > So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
> > we can just allow this unconditionally.
> 
> Which actually makes the test:
> 
>   if (dirty_mask & DIRTY_MEMORY_VGA) {
>      .. fail ..
>   }
> 
> which is more in line with the comment although wouldn't fail if we
> added additional DIRTY_MEMORY flags. This leads to the question what
> exactly is it about DIRTY tracking that vhost doesn't like.

vhost does not know how to track writes to specific regions. It can either
track all writes to memory (which slows it down quite a bit)
or no writes. It never actually *needs* to write to VGA,
so we do a hack and just skip these and then if that's the
only thing we need to track then we don't need to enable
its dirty tracking.

I don't really know what is DIRTY_MEMORY_CODE and when it's set.


> Is it really
> only avoiding having virtqueue in video RAM? Does this ever actually
> happen?

No to both.

> I assume boards with unified memory models where video ram is shared
> with system ram just end up partitioning the memory regions?

That's the assumption I think.

> 
> -- 
> Alex Bennée


