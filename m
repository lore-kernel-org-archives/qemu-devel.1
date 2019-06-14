Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A23EC31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:28:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 259F220851
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 13:28:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ym8h1rvM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 259F220851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbmFP-0007RX-EV
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 09:28:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41269)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmAm-0004jy-QS
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:23:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbmAl-0002ds-Ot
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:23:16 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44599)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbmAl-0002bZ-H3
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 09:23:15 -0400
Received: by mail-oi1-x243.google.com with SMTP id e189so1912968oib.11
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 06:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nJDunLpsvIlcVSIbOOPB2qcWugmuhPqWH2k8AZJxHOc=;
 b=ym8h1rvMNTnGYKTOqQvXJv8HT+z/+OSfPBYXOApJ3PEaZbuorifK5/mEzqzBQULkFL
 R8lcjZgBTsVioUQExfxbaxykRXZjaBu9/7noGID84ID66RfH2Fuq4dyLQDEthZKuQ68p
 VEoumyFJW+dnAYkJ6E/CaF7/0r4UfHHlCeubUVLY4L7mtzpWYK/My3EB09CJzOJvodDi
 IwK4LTsjdqMHzR9+tYcT61cuMMVDUswzE1r+8cG2gn3xqL3v8kw5Ucq1mV1oXur7a5JQ
 O1lbAmftW0wuvAuY7TC+kD0FzyClPBf98YB1H2mkt2QGeoqWc1JsteYDa6wJIx5egmRp
 toQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nJDunLpsvIlcVSIbOOPB2qcWugmuhPqWH2k8AZJxHOc=;
 b=eIm7bPyMWCyroGP+/rZ9ok88wE+ZdOkD7Yqq6SVZVtVN87qCtQlnBDyfAoNxazrTE7
 q3bbx3lJpOYaQhdebNMgf4HBh7ZlNY0kkt3Db9PBMV315PX4m4FF23UArZoCqpYNiDfx
 v7sjJCyNS5xWDB1HwEZzfLnB1ou6wzqcpuzmuZwlJBdrmU/WYpjigroVRvxxMos3asME
 QvSCIFxvqi0fju+zf1vXK6NMZcQ2eLybrJQ64J0jraOfJ5ENViWq5dKZLKBqfdItfoc7
 xjrdum2Rh0pHN5seeiGmIMApegqTsHcg4kQp+14FKJSZ+cS90Z0IEQKtBk32T/jOG314
 4coQ==
X-Gm-Message-State: APjAAAXWSN7Mh+hlmw3J+ba5njpl0ZP8jp0Jj0DcqVWCtoDODvlbj/qe
 OJxQGnhlriteZ4o9uo/2e5ikWIvpWLZWOsqJ9Xj/nQ==
X-Google-Smtp-Source: APXvYqyX7vKNCMt/VGUQXUI6lhg7qTHuuRLtRUpMsgqP66FserLHqRz9PWZSW/dwq3DRBNYuEKOvAHAIB5QVPm8zHf8=
X-Received: by 2002:aca:845:: with SMTP id 66mr1840159oii.163.1560518593672;
 Fri, 14 Jun 2019 06:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190611142821.3874-1-eric.auger@redhat.com>
 <20190611142821.3874-2-eric.auger@redhat.com>
In-Reply-To: <20190611142821.3874-2-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 14:23:02 +0100
Message-ID: <CAFEAcA8N_uaq9kbS2MWDtdy1wz-j33OVo4wQbFZxvc-2uyMd0A@mail.gmail.com>
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
Subject: Re: [Qemu-devel] [PATCH 1/2] hw/arm/smmuv3: Remove spurious error
 messages on IOVA invalidations
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Jun 2019 at 15:29, Eric Auger <eric.auger@redhat.com> wrote:
>
> An IOVA/ASID invalidation is notified to all IOMMU Memory Regions
> through smmuv3_inv_notifiers_iova/smmuv3_notify_iova.
>
> When the notification occurs it is possible that some of the
> PCIe devices associated to the notified regions do not have a
> valid stream table entry. In that case we output a LOG_GUEST_ERROR
> message.
>
> invalid sid=<SID> (L1STD span=0)
> "smmuv3_notify_iova error decoding the configuration for iommu mr=<MR>
>
> This is unfortunate as the user gets the impression that there
> are some translation decoding errors whereas there are not.
>
> This patch adds a new field in SMMUEventInfo that tells whether
> the detction of an invalid STE msut lead to an error report.
> invalid_ste_allowed is set before doing the invalidations and
> kept unset on actual translation.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> I also experimented to pass Error handles to all the subfunctions
> and handle the Error at top level but that's intricate to sort
> out the various kinds of errors, whether they need to be logged,
> and if so if they match LOG_GUEST_ERRoR mask or unimplemented
> mask. So I think just passing this boolean has a lesser impact on
> the code base.
> ---
>  hw/arm/smmuv3-internal.h |  1 +
>  hw/arm/smmuv3.c          | 11 +++++------
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/hw/arm/smmuv3-internal.h b/hw/arm/smmuv3-internal.h
> index b160289cd1..d190181ef1 100644
> --- a/hw/arm/smmuv3-internal.h
> +++ b/hw/arm/smmuv3-internal.h
> @@ -381,6 +381,7 @@ typedef struct SMMUEventInfo {
>      uint32_t sid;
>      bool recorded;
>      bool record_trans_faults;
> +    bool inval_ste_allowed;
>      union {
>          struct {
>              uint32_t ssid;
> diff --git a/hw/arm/smmuv3.c b/hw/arm/smmuv3.c
> index fd8ec7860e..e2f07d2864 100644
> --- a/hw/arm/smmuv3.c
> +++ b/hw/arm/smmuv3.c
> @@ -404,7 +404,7 @@ static int smmu_find_ste(SMMUv3State *s, uint32_t sid, STE *ste,
>
>          span = L1STD_SPAN(&l1std);
>
> -        if (!span) {
> +        if (!span && !event->inval_ste_allowed) {
>              /* l2ptr is not valid */
>              qemu_log_mask(LOG_GUEST_ERROR,
>                            "invalid sid=%d (L1STD span=0)\n", sid);

Why is this specific qemu_log_mask() the only one we need
to suppress ?

thanks
-- PMM

