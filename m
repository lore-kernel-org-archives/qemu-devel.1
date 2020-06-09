Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52497C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BD8B207C3
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 11:23:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w2yNi9zw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BD8B207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jicLQ-00038f-Dr
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 07:23:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35164)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jicGl-0007Bq-7Z
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:18:15 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:54417)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jicGj-00033D-Pn
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 07:18:14 -0400
Received: by mail-wm1-x344.google.com with SMTP id g10so2431872wmh.4
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2020 04:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=5mw9ZowY683CaPhjRf/2YZqKdcV7jOjuvNmtH/WJulA=;
 b=w2yNi9zw+k3Ka9xA5MFh+gc2GGvAWql1qFu9IZdNwUp+2+7ONV0r9JBortLuvmXVo8
 Oqxyi7zFhR+nWHoruR6KyUGhNJWaTdVic6rRFfxCRQjeYB82kaKENL0j/DjNO6UcQsPn
 3ntqrpIJKKkBmyF18A7ldR48Oxsnct/u+Sp1ZoiI1iYR3aaXxXgsT1VfqYJWb3z253JP
 zxj6yiDR3kv4OSBlXpZB6aSzdiNDX8L5NpPPEXO4O1wX0Eylc/puboqBLdAWLrDHlLIf
 1rjeXnIHojLd84fZ3Avhk7MtRTw522yP77RsAmVYmPICkS4eb4RAloNxxRw92ayAKs5W
 H1Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=5mw9ZowY683CaPhjRf/2YZqKdcV7jOjuvNmtH/WJulA=;
 b=ZDXEnw73oOQvEImYV5U3KLabAKori9dyYOMV25l2JTRNP8776bNyKAlLrCoGXJqbXX
 xEpg+M3DD3zkmQRGIcFtkU4xnlaWls7GgLbE7OHtLPHGwf1SI1Pi0Z8Ywf/AQWLwdwiv
 T8TljWT0xkW4V4y/c1uPpPd2esZXZ0AaiqjDyP71qaqecn+rh3ujRntLoHgVigxH2Nr0
 k1RA3Lgzf9y8dPa7GzkT7PEwlpa3PfVs09rDt2IVFM7HD+mStbQwRY7B3i8SLV3oOxDR
 SyXxm0KI5xdgeXDgiqx0NNwtm9datS4SV7GLNq5l8Uh6WbcZt6eb5KP27ij28YB9hDpJ
 lkjg==
X-Gm-Message-State: AOAM533tT9z5xmy2+pHlR3QXvKuStXP2TdU5PKXyGZ3lxSsIBFJviD0z
 YB9kL/mjKNnUqXYzdaE+vdhAhr88ZK4=
X-Google-Smtp-Source: ABdhPJw+YoD0xu+nWOSOL8BnMNbboX7BAC37JCNrpI0jMPGovYm2OvGLf6aV6rbImJ4o0HFZtw5snA==
X-Received: by 2002:a05:600c:21d3:: with SMTP id
 x19mr3747921wmj.137.1591701491098; 
 Tue, 09 Jun 2020 04:18:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id k21sm3166053wrd.24.2020.06.09.04.18.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2020 04:18:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E7E311FF7E;
 Tue,  9 Jun 2020 12:18:07 +0100 (BST)
References: <20200604134022.10564-1-alex.bennee@linaro.org>
 <20200605090334.GB59930@stefanha-x1.localdomain>
 <87o8px4xxp.fsf@linaro.org>
 <20200609111044.GD92564@stefanha-x1.localdomain>
User-agent: mu4e 1.5.2; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v2] hw/virtio/vhost: re-factor vhost-section and allow
 DIRTY_MEMORY_CODE
In-reply-to: <20200609111044.GD92564@stefanha-x1.localdomain>
Date: Tue, 09 Jun 2020 12:18:07 +0100
Message-ID: <87v9k04he8.fsf@linaro.org>
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

> On Fri, Jun 05, 2020 at 11:19:30AM +0100, Alex Benn=C3=A9e wrote:
>>=20
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > On Thu, Jun 04, 2020 at 02:40:22PM +0100, Alex Benn=C3=A9e wrote:
>> >> The purpose of vhost_section is to identify RAM regions that need to
>> >> be made available to a vhost client. However when running under TCG
>> >> all RAM sections have DIRTY_MEMORY_CODE set which leads to problems
>> >> down the line.
>> >>=20
>> >> Re-factor the code so:
>> >>=20
>> >>   - steps are clearer to follow
>> >>   - reason for rejection is recorded in the trace point
>> >>   - we allow DIRTY_MEMORY_CODE when TCG is enabled
>> >>=20
>> >> We expand the comment to explain that kernel based vhost has specific
>> >> support for migration tracking.
>> >>=20
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> Cc: Michael S. Tsirkin <mst@redhat.com>
>> >> Cc: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> Cc: Stefan Hajnoczi <stefanha@redhat.com>
>> >>=20
>> >> ---
>> >> v2
>> >>   - drop enum, add trace_vhost_reject_section
>> >>   - return false at any fail point
>> >>   - unconditionally add DIRTY_MEMORY_CODE to handled cases
>> >>   - slightly re-word the explanatory comment and commit message
>> >> ---
>> >>  hw/virtio/vhost.c      | 55 ++++++++++++++++++++++++++++++----------=
--
>> >>  hw/virtio/trace-events |  3 ++-
>> >>  2 files changed, 41 insertions(+), 17 deletions(-)
>> >>=20
>> >> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
>> >> index aff98a0ede5..120c0cc747b 100644
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
>> >> @@ -403,26 +404,48 @@ static int vhost_verify_ring_mappings(struct vh=
ost_dev *dev,
>> >>      return r;
>> >>  }
>> >>=20=20
>> >> +/*
>> >> + * vhost_section: identify sections needed for vhost access
>> >> + *
>> >> + * We only care about RAM sections here (where virtqueue can live). =
If
>> >
>> > It's not just the virtqueue. Arbitrary guest RAM buffers can be placed
>> > into the virtqueue so we need to pass all guest RAM to the vhost device
>> > backend.
>> >
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
>> >> +    MemoryRegion *mr =3D section->mr;
>> >> +
>> >> +    if (memory_region_is_ram(mr) && !memory_region_is_rom(mr)) {
>> >> +        uint8_t dirty_mask =3D memory_region_get_dirty_log_mask(mr);
>> >> +        uint8_t handled_dirty;
>> >> +
>> >> +        /*
>> >> +         * Kernel based vhost doesn't handle any block which is doing
>> >> +         * dirty-tracking other than migration for which it has
>> >> +         * specific logging support. However for TCG the kernel never
>> >> +         * gets involved anyway so we can also ignore it's
>> >> +         * self-modiying code detection flags.
>> >> +         */
>> >> +        handled_dirty =3D (1 << DIRTY_MEMORY_MIGRATION);
>> >> +        handled_dirty |=3D (1 << DIRTY_MEMORY_CODE);
>> >
>> > Wait, how is vhost going to support TCG self-modifying code detection?
>> >
>> > It seems like this change will allow vhost devices to run, but now QEMU
>> > will miss out on self-modifying code. Do we already enable vhost dirty
>> > memory logging for DIRTY_MEMORY_CODE memory somehwere?
>>=20
>> Well any guest code running will still trigger the SMC detection. It's
>> true we currently don't have a mechanism if the vhost-user client
>> updates an executable page.
>
> Seems like a problem. If it didn't matter we could get rid of
> DIRTY_MEMORY_CODE entirely.
>
> If an exception is being made here because I/O devices aren't expected
> to trigger SMC in real-world guests, please document it.

In the comment here or somewhere in the docs?

--=20
Alex Benn=C3=A9e

