Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB1CBC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:20:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4950206A2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 10:20:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tR9RXouG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4950206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52362 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jh9Sh-0002CI-RT
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 06:20:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh9Rq-0001a1-0g
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:19:38 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:50738)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jh9Rn-0005gq-9X
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 06:19:37 -0400
Received: by mail-wm1-x344.google.com with SMTP id v19so7931742wmj.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 03:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=jFYM978QgIz+AkKa8HM23JV4ymrzemmdJ/QaqjLwjq8=;
 b=tR9RXouGO4TS28Z2ETB7Lylp1d0wr/ydqXo2ofjdPUpJxiaSMgsC2LGUEjJLyeou/5
 5EjFekhjBJSM3V6GgIT2YVrErdFDt/lbDGcrNhuvlOca86YPsWbqNKIW4kPj4M522GOx
 t4RwBUhytBXE+Fod37lilfLECZ3PnuCLu1nsNT/24Qq8thlQYa3nX3d9AmMlqBIHXVB8
 S14lALDGhN4IBNTpdnhrAulXRIXOLds61ioQ68/3VZY63u/7mmx0kcFi9rmbgl9a4/oT
 VYDVwMkMtOV/+4CoHFw8TYpzY9u5l3vAy1jkfSYsivBmn+RsReU0mSEjjXSzJjprsGc+
 d3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=jFYM978QgIz+AkKa8HM23JV4ymrzemmdJ/QaqjLwjq8=;
 b=ImIbBhcNz7oAbBY0moF7S6LQlik0orcnXkDQa2gnMo37UjcBG5jzLIN4gMYrhCyizy
 0HRX42kjdL+JRvUjp14mpTgesT2QmAmPxKvMRSenWh93KAtL4uVPFnHi8BSpRl3MZ/2A
 KI05AmSuhjbDKfoC7CjJboDVkcp10no7XOlNbRmzp7NJ86mBseMmgeL3sWeSpRxIfe89
 ai1G5eNobUHtJAJWEpaLKIclDRyuHbVEe/ekaWL1aFDg/+PnoV1FP6/ty45J4V4QBwhI
 gUIr0py83X4nAKx/9rvpNJM7AgxCHdRsq8Q8qEqQ1Is7qE98URYGJBxv065Ak7wp8iId
 Jh0A==
X-Gm-Message-State: AOAM532meq/1+HYS99Q1P8sXcWx13GZNNCKC0OBQGTOo4AuBQUVQF5TX
 3XWgd32l1KQVgJwslrp6xPYjGck94cc=
X-Google-Smtp-Source: ABdhPJwySfUvVF/iEQlI9Y2555rjVGDmj8bt5Tu6JVCcHQ4+XQz1bYgBwn5osgP4tD2WIA5DzJ9xSw==
X-Received: by 2002:a1c:9802:: with SMTP id a2mr1894095wme.64.1591352372747;
 Fri, 05 Jun 2020 03:19:32 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id p1sm11250618wrx.44.2020.06.05.03.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2020 03:19:31 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 5DBAA1FF7E;
 Fri,  5 Jun 2020 11:19:30 +0100 (BST)
References: <20200604134022.10564-1-alex.bennee@linaro.org>
 <20200605090334.GB59930@stefanha-x1.localdomain>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <20200605090334.GB59930@stefanha-x1.localdomain>
Date: Fri, 05 Jun 2020 11:19:30 +0100
Message-ID: <87o8px4xxp.fsf@linaro.org>
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
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Stefan Hajnoczi <stefanha@redhat.com> writes:

> On Thu, Jun 04, 2020 at 02:40:22PM +0100, Alex Benn=C3=A9e wrote:
>> The purpose of vhost_section is to identify RAM regions that need to
>> be made available to a vhost client. However when running under TCG
>> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>> down the line.
>>=20
>> Re-factor the code so:
>>=20
>>   - steps are clearer to follow
>>   - reason for rejection is recorded in the trace point
>>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>>=20
>> We expand the comment to explain that kernel based vhost has specific
>> support for migration tracking.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Cc: Michael S. Tsirkin <mst@redhat.com>
>> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>>=20
>> ---
>> v2
>>   - drop enum, add trace_vhost_reject_section
>>   - return false at any fail point
>>   - unconditionally add DIRTY_MEMORY_CODE to handled cases
>>   - slightly re-word the explanatory comment and commit message
>> ---
>>  hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++------------
>>  hw/virtio/trace-events |  3 ++-
>>  2 files changed, 41 insertions(+), 17 deletions(-)
>>=20
>> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> index aff98a0ede5..120c0cc747b 100644
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
>> @@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vhost=
_dev *dev,
>>      return r;
>>  }
>>=20=20
>> +/*
>> + * vhost_section: identify sections needed for vhost access
>> + *
>> + * We only care about RAM sections here (where virtqueue can live). If
>
> It's not just the virtqueue. Arbitrary guest RAM buffers can be placed
> into the virtqueue so we need to pass all guest RAM to the vhost device
> backend.
>
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
>> +    MemoryRegion *mr =3D section->mr;
>> +
>> +    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
>> +        uint8_t handled_dirty;
>> +
>> +        /*
>> +         * Kernel based vhost doesn't handle any block which is doing
>> +         * dirty-tracking other than migration for which it has
>> +         * specific logging support. However for TCG the kernel never
>> +         * gets involved anyway so we can also ignore it's
>> +         * self-modiying code detection flags.
>> +         */
>> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>> +        handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>
> Wait, how is vhost going to support TCG self-modifying code detection?
>
> It seems like this change will allow vhost devices to run, but now QEMU
> will miss out on self-modifying code. Do we already enable vhost dirty
> memory logging for DIRTY_MEMORY_CODE memory somehwere?

Well any guest code running will still trigger the SMC detection. It's
true we currently don't have a mechanism if the vhost-user client
updates an executable page.

> Or is there some cross-architectural reason why we can be sure that
> allowing the vhost backend to DMA to guest RAM without marking pages
> dirty is safe?

Hmm, for devices just updating guest queues we should be fine because
the guest won't look until signalled. If we map executable pages in
virtiofsd will the guest kernel still go through it's mprotect setup
once the pages are DMA'ed?

> For example, maybe the CPU needs to explicitly flush the
> icache after DMA because this was a DMA operation not a regular
> self-modifying code memory store?

We don't care about cache ops in TCG, only page protections and write to
pages that already have code that has been translated in them.

> But is this true across all
> architectures?
>
> Stefan


--=20
Alex Benn=C3=A9e

