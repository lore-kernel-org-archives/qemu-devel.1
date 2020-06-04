Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6EEDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B609207D0
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 14:03:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="udvXsLKc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B609207D0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgqTG-0004Ct-MJ
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 10:03:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36084)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgqSB-0003jz-6E
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:02:43 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38755)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jgqSA-0002v5-1H
 for qemu-devel@nongnu.org; Thu, 04 Jun 2020 10:02:42 -0400
Received: by mail-wr1-x441.google.com with SMTP id e1so6256889wrt.5
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2020 07:02:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=faFiY8kdVg7lLJO0SD+SBHbaMSEuxa91KGzQ5lpv8Is=;
 b=udvXsLKcApB0h0OevCA7DBphrEJh+tLyF4gxHJbJhDdElEfGV28/jjzSofVMGC/6RA
 A/f/B8SA/ZFsiPZ1wnBcVuHILFfGfh8DkyzamOzRkNUfNhrbmc4zCgmKr/bBLd9LJmH5
 LjfGK4H1nHwCLRenBbbSPGz93ESZBEBTAKpmwQffVGLv+oSkKXlpwcoDSzg+2TkP3V4i
 70yRsvSd7CffJw6EzLly7lJfT/S3pczdDTuoTU5Fdk2M+K9ehGhCHf4MYrrXi81ee3ow
 ymYVrq2CWBBU1JNQgbhhv6DL+WccE1E/qh8HKCw7TM7yqrkRUfBhQKKve1z78v2BvL5c
 E3eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=faFiY8kdVg7lLJO0SD+SBHbaMSEuxa91KGzQ5lpv8Is=;
 b=HM4A/LAxI1h2CLJsmjghPoVWCRBuaClYJfVDWqMdNujxXeTumrJ2yWLGV+Pe2EtdRM
 rprVT70rdTtcqD6GOrqLzQppHL5taNzp2abdrkgaOnK/d+i/A6GJHelhYE+qThJ1lCjQ
 CAmh+o6WBsHyuSegy+6P9quNsk5rik0BSeCWUFqn0Fz3IKbwEwFyLSon/71oo0EuGNtc
 LSrj0lQ6v0j/5tUMa9nt5cIEhKnvwpz+aOVUOawVtu1t4PqCO952Y/+NKADYlSMoI3Ce
 VT9coXA2f2vY8zpc5rTI2XeCC5tsFBeZ8M1jOc4JA6zpbM6xMPMAFXiOJtCnHRcykNid
 qHPQ==
X-Gm-Message-State: AOAM5327O70T9aPQhISJssFvah7TH6Jsa543XdzyQ9cfOW8OS3Mm+15b
 W1XLqhpnidc0BsnnDPeWjZGengq9gvw=
X-Google-Smtp-Source: ABdhPJy9FOK/wFoGQLPdkxtjE7NmFKp/+f9+NAAy5lZdbUXb87onzRl9XMlV7K0yrgPAtXbAiPbJbg==
X-Received: by 2002:a05:6000:d:: with SMTP id h13mr4438267wrx.17.1591279359366; 
 Thu, 04 Jun 2020 07:02:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m24sm7361411wmi.14.2020.06.04.07.02.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jun 2020 07:02:37 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 728AB1FF7E;
 Thu,  4 Jun 2020 15:02:36 +0100 (BST)
References: <20200604111323.7458-1-alex.bennee@linaro.org>
 <20200604132635.GG2851@work-vm>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: [RFC PATCH] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <20200604132635.GG2851@work-vm>
Date: Thu, 04 Jun 2020 15:02:36 +0100
Message-ID: <875zc753pf.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x441.google.com
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
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Dr. David Alan Gilbert <dgilbert@redhat.com> writes:

> * Alex Benn=C3=83=C2=A9e (alex.bennee@linaro.org) wrote:
>> The purpose of vhost_section is to identify RAM regions that need to
>> be made available to a vhost client. However when running under TCG
>> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>> down the line. The original comment implies VGA regions are a problem
>> but doesn't explain why vhost has a problem with it.
>>=20
>> Re-factor the code so:
>>=20
>>   - steps are clearer to follow
>>   - reason for rejection is recorded in the trace point
>>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>
> The problem with VGA is that a VGA page can become mapped and unmapped
> under the control of the guest; somewhere in a low address.  This tends
> to break hugepage mappings.
> For vhost-user, and in particular vhost-user-postcopy this means it
> fails the mapping on the vhost-user client.
>
> However the other problem is that with vhost-user, the vhost-user client
> is changing memory; and won't mark the pages as dirty - except for
> migration (I'm not clear if vhost kernel does this).

For virtio this shouldn't be a problem because whatever the vhost-user
client writes to should never be read by the guest until it gets kicked
by the client to signal the virtqueue is done.

I guess migration is a fairly moot point given I haven't seen anything
outside of a test declare VHOST_F_LOG_ALL support.

> So TCG won't notice a page that's been changed by the driver; now in
> most cases it's rare for a device to be writing directly into a page
> you're going to execute out of, but it's not unknown.

Not unknown outside of bugs?

So stage 2 of this exercise is limiting the amount of exposed RAM to the
client to just the virtqueues themselves (which is all vhost-user-rpmb
should need).

> So, as it is, any area that's expecting to get non-migration dirty
> notifications is going to be disappointed by a vhost-user backend.

It's not outside the realms of possibility that we could implement
feedback to the softmmu/migration information from a vhost-user client
but for now I think it's safe to assume we are eliding over the issue.

>
> Dave
>
>> Signed-off-by: Alex Benn=C3=83=C2=A9e <alex.bennee@linaro.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  hw/virtio/vhost.c | 46 ++++++++++++++++++++++++++++++++--------------
>>  1 file changed, 32 insertions(+), 14 deletions(-)
>>=20
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index aff98a0ede5..f81fc87e74c 100644
>> --- a/hw/virtio/vhost.c
>> +++ b/hw/virtio/vhost.c
>> @@ -27,6 +27,7 @@
>>  #include "migration/blocker.h"
>>  #include "migration/qemu-file-types.h"
>>  #include "sysemu/dma.h"
>> +#include "sysemu/tcg.h"
>>  #include "trace.h"
>>=20=20
>>  /* enabled until disconnected backend stabilizes */
>> @@ -403,26 +404,43 @@ static int vhost_verify_ring_mappings(struct vhost=
_dev *dev,
>>      return r;
>>  }
>>=20=20
>> +/*
>> + * vhost_section: identify sections needed for vhost access
>> + *
>> + * We only care about RAM sections here (where virtqueue can live). If
>> + * we find one we still allow the backend to potentially filter it out
>> + * of our list.
>> + */
>>  static bool vhost_section(struct vhost_dev *dev, MemoryRegionSection *s=
ection)
>>  {
>> -    bool result;
>> -    bool log_dirty =3D memory_region_get_dirty_log_mask(section->mr) &
>> -                     ~(1 << DIRTY_MEMORY_MIGRATION);
>> -    result =3D memory_region_is_ram(section->mr) &&
>> -        !memory_region_is_rom(section->mr);
>> -
>> -    /* Vhost doesn't handle any block which is doing dirty-tracking oth=
er
>> -     * than migration; this typically fires on VGA areas.
>> -     */
>> -    result &=3D !log_dirty;
>> +    enum { OK =3D 0, NOT_RAM, DIRTY, FILTERED } result =3D NOT_RAM;
>> +
>> +    if (memory_region_is_ram(section->mr) && !memory_region_is_rom(sect=
ion->mr)) {
>> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(section=
->mr);
>> +        uint8_t handled_dirty;
>>=20=20
>> -    if (result && dev->vhost_ops->vhost_backend_mem_section_filter) {
>> -        result &=3D
>> -            dev->vhost_ops->vhost_backend_mem_section_filter(dev, secti=
on);
>> +        /*
>> +         * Vhost doesn't handle any block which is doing dirty-tracking=
 other
>> +         * than migration; this typically fires on VGA areas. However
>> +         * for TCG we also do dirty code page tracking which shouldn't
>> +         * get in the way.
>> +         */
>> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>> +        if (tcg_enabled()) {
>> +            handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>> +        }
>> +        if (dirty_mask & ~handled_dirty) {
>> +            result =3D DIRTY;
>> +        } else if (dev->vhost_ops->vhost_backend_mem_section_filter &&
>> +            !dev->vhost_ops->vhost_backend_mem_section_filter(dev, sect=
ion)) {
>> +            result =3D FILTERED;
>> +        } else {
>> +            result =3D OK;
>> +        }
>>      }
>>=20=20
>>      trace_vhost_section(section->mr->name, result);
>> -    return result;
>> +    return result =3D=3D OK;
>>  }
>>=20=20
>>  static void vhost_begin(MemoryListener *listener)
>> --=20
>> 2.20.1
>>=20


--=20
Alex Benn=C3=A9e

