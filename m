Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8666BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 527E2207D8
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 12:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SZO8cWG0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 527E2207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgpDb-0005pC-I8
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 08:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53044)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgpA4-0000CG-Mt
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:39:56 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36470)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgpA3-0001mC-7f
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 08:39:56 -0400
Received: by mail-wm1-x344.google.com with SMTP id d128so5458260wmc.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 05:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=I2wUcuGnnpxSNhMK2HDZKzcqf7rViADS4Ulwk8BlJho=;
 b=SZO8cWG0DubpEVpdmaYhtnfwihRBEmG2NSqM5ROubn5kIfegeJpSoJHbBIdfxtYtLD
 Iim799lU8K8j8O6+FH6KSsVBjtIX6f5KZVTmAnxnsCPJcE1hkYCLuG3sOcBXFiC89myx
 EXMUfRt+63myc5eeM9hp1Z/zx10ubrG/QW2NdzdWB6p/KR/zw0ELH5XZK7kXAxxTLpzH
 Cvx/REuYej7PcAsin7o9MW9WO4Jai3/27OfBCKv/Q83DQicwFjIt8rPDxOOa2C1UfVFj
 +NbJs6BQv8sfl9hamQ++99V3SEW+yuosS/y8aocgA88MfCf4FTwfLoe67T/DRR/3z5pg
 xmlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=I2wUcuGnnpxSNhMK2HDZKzcqf7rViADS4Ulwk8BlJho=;
 b=CDhrjO12VImzncP9O4ceRMlUjoAJ8yWwIo4ON5pHR0P6j37bGHr5sPe+pc1TGgPS8U
 oK3r4jYYpHnwwrAoKUz/5Tpa66BdC5dn+n7g/kNpF6a64wXm7zpZaWrio1Lvs5pAxuPr
 cDQviqcr6f0MPGp5Vw2DWbwVYSYyuPJ2mo0qp/Yk99M/KeUjYZnQ6Fa0KFNYXhIZWfQ8
 7BjuCFygMS41rHUXw+SwTVrgBTAqU1RpFuwz5PfF7IiCJr56zVvVlO2/TgOWsFjmzE3L
 XFD6Z086hQagWCHs5GbiHcBnBUb6H08tbi9qNLtXpzOOQzFNOg6OhmOoSDEkEGUdH9SU
 6yLg==
X-Gm-Message-State: AOAM531TBZeSIA2ULAiCPjqJgsCTO8++XuHnUysZ0rLxHojtywSM+IAX
 HsvMXEg5dKKM8Ps8w/SkEyIsaWFxkjg=
X-Google-Smtp-Source: ABdhPJxXfw80HHyYpXjX5Y3Ci4BGVbaihjY1gDICoO6zU2qdQ4MkMffGezGv3MD2zU7v2BEQO2aPNA==
X-Received: by 2002:a7b:c212:: with SMTP id x18mr3811212wmi.119.1591274392416; 
 Thu, 04 Jun 2020 05:39:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id 5sm10679516wrr.5.2020.06.04.05.39.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 05:39:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 38C651FF7E;
 Thu,  4 Jun 2020 13:39:50 +0100 (BST)
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604071504-mutt-send-email-mst@kernel.org>
 <87ftbb59vm.fsf@linaro.org>
 <20200604075020-mutt-send-email-mst@kernel.org>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <20200604075020-mutt-send-email-mst@kernel.org>
Date: Thu, 04 Jun 2020 13:39:50 +0100
Message-ID: <87d06f57jd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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


Michael S. Tsirkin <mst@redhat.com> writes:

> On Thu, Jun 04, 2020 at 12:49:17PM +0100, Alex Benn=C3=83=C2=A9e wrote:
>>=20
>> Michael S. Tsirkin <mst@redhat.com> writes:
>>=20
>> > On Thu, Jun 04, 2020 at 12:13:23PM +0100, Alex Benn=C3=83=C2=83=C3=82=
=C2=A9e wrote:
>> >> The purpose of vhost_section is to identify RAM regions that need to
>> >> be made available to a vhost client. However when running under TCG
>> >> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>> >> down the line. The original comment implies VGA regions are a problem
>> >> but doesn't explain why vhost has a problem with it.
>> >>=20
>> >> Re-factor the code so:
>> >>=20
>> >>   - steps are clearer to follow
>> >>   - reason for rejection is recorded in the trace point
>> >>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>> >>=20
>> >> Signed-off-by: Alex Benn=C3=83=C2=83=C3=82=C2=A9e <alex.bennee@linaro=
.org>
>> >> Cc: Michael S. Tsirkin <mst@redhat.com>
>> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> >> ---
>> >>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>> >>  1 file changed, 32 insertions(+), 14 deletions(-)
>> >>=20
>> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> >> index aff98a0ede5..f81fc87e74c 100644
>> >> --- a/hw/virtio/vhost.c
>> >> +++ b/hw/virtio/vhost.c
>> >> @@ -27,6 +27,7 @@
>> >>  #include "migration/blocker.h"
>> >>  #include "migration/qemu-file-types.h"
>> >>  #include "sysemu/dma.h"
>> >> +#include "sysemu/tcg.h"
>> >>  #include "trace.h"
>> >>=20=20
>> >>  /* enabled until disconnected backend stabilizes */
>> >> @@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vh=
ost_dev *dev,
>> >>      return r;
>> >>  }
>> >>=20=20
>> >> +/*
>> >> + * vhost_section: identify sections needed for vhost access
>> >> + *
>> >> + * We only care about RAM sections here (where virtqueue can live). =
If
>> >> + * we find one we still allow the backend to potentially filter it o=
ut
>> >> + * of our list.
>> >> + */
>> >>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection=
 *section)
>> >>  {
>> >> -    bool result;
>> >> -    bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr)=
 &
>> >> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
>> >> -    result =3D memory_region_is_ram(section->mr) &&
>> >> -        !memory_region_is_rom(section->mr);
>> >> -
>> >> -    /* Vhost doesn't handle any block which is doing dirty-tracking =
other
>> >> -     * than migration; this typically fires on VGA areas.
>> >> -     */
>> >> -    result &=3D !log_dirty;
>> >> +    enum { OK =3D 0, NOT_RAM, DIRTY, FILTERED } result =3D NOT_RAM;
>> >
>> > I'm not sure what does this enum buy us as compared to bool.
>>=20
>> The only real point of the enum is to give a little more detailed
>> information to the trace point to expose why a section wasn't included.
>> In a previous iteration I just had the tracepoint at the bottom before a
>> return true where all other legs had returned false. We could switch to
>> just having the tracepoint hit for explicit inclusions?
>
> I didn't notice.  Yes, ok more tracepoints IMHO.

I can simplify to two:

  trace_vhost_section(mr->name)
  trace_vhost_reject_section(mr->name, int reason)

Not sure if it's worth defining a enum outside just for the purposes of
the trace though. Do we have the concept of per-trace event enum codes?

>> > Also why force OK to 0?
>>=20
>> Personal preference where 0 indicates success and !0 indicates failure
>> of various kinds. Again we can drop if we don't want the information in
>> the tracepoint.
>
> So in that case we need to set all values so people can decode them
> from the trace. But I think it's best to just have more trace points
> or drop it from the trace.
>
>> > And I prefer an explicit "else result =3D NOT_RAM" below
>> > instead of initializing it here.
>>=20
>> Ok.
>>=20
>> >
>> >> +
>> >> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(s=
ection->mr)) {
>> >> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(sect=
ion->mr);
>> >> +        uint8_t handled_dirty;
>> >>=20=20
>> >> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
>> >> -        result &=3D
>> >> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, se=
ction);
>> >> +        /*
>> >> +         * Vhost doesn't handle any block which is doing dirty-track=
ing other
>> >> +         * than migration; this typically fires on VGA areas. However
>> >> +         * for TCG we also do dirty code page tracking which shouldn=
't
>> >> +         * get in the way.
>> >> +         */
>> >> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>> >> +        if (tcg_enabled()) {
>> >> +            handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>> >> +        }
>> >
>> > So DIRTY_MEMORY_CODE is only set by TCG right? Thus I'm guessing
>> > we can just allow this unconditionally.
>>=20
>> Which actually makes the test:
>>=20
>>   if (dirty_mask & DIRTY_MEMORY_VGA) {
>>      .. fail ..
>>   }
>>=20
>> which is more in line with the comment although wouldn't fail if we
>> added additional DIRTY_MEMORY flags. This leads to the question what
>> exactly is it about DIRTY tracking that vhost doesn't like.
>
> vhost does not know how to track writes to specific regions. It can either
> track all writes to memory (which slows it down quite a bit)
> or no writes.

So can vhost interfere with dirty tracking itself in the kernel by
trapping the writes? I guess there is no way this can happen with
vhost-user?

(I wonder what would happen if a vhost-user daemon did an mprotect() on
RAM from it's shared view?)

> It never actually *needs* to write to VGA,
> so we do a hack and just skip these and then if that's the
> only thing we need to track then we don't need to enable
> its dirty tracking.
>
> I don't really know what is DIRTY_MEMORY_CODE and when it's set.

We use it softmmu do any pages that have code in them always force the
slow-path into cputlb for writes to those pages. This allows us to
detect self-modifying code. The kernel would never get involved but I
don't think vhost and TCG is compatible anyway. I'm only really
interested in vhost-user and it's interaction with TCG.

I'll spin a v2 now.

--=20
Alex Benn=C3=A9e

