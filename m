Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C90D1C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:24:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A4D221D56
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 03:24:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E23py1SZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A4D221D56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41454 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8yA4-0000Lb-Nl
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 22:24:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60702)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhangfei.gao@gmail.com>) id 1j8y9T-0008CO-6P
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:23:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhangfei.gao@gmail.com>) id 1j8y9S-0002OZ-4Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 22:23:23 -0500
Received: from mail-io1-xd43.google.com ([2607:f8b0:4864:20::d43]:46842)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <zhangfei.gao@gmail.com>)
 id 1j8y9R-0002OR-Uj; Mon, 02 Mar 2020 22:23:22 -0500
Received: by mail-io1-xd43.google.com with SMTP id x21so1892854iox.13;
 Mon, 02 Mar 2020 19:23:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0ou9io8uf3VKDbGKlHf2x7eRKMOVTLIyuGgxw2ob+co=;
 b=E23py1SZEh9w5zXhNH8E8Awsbd5qwG6oheW3LQqnOEgVUE76VOeNhImNk6crl8ycW5
 3eXRXgLNRlDwRSMaglEMzQa1Lkjqzzz0elubCIWL5ZkDbNHk2ZH10K5pjdyGQN4L09IY
 Ux2YetF7NL6R/eHa5EGPrUKeFhQeUL41aGPODZAQ1DMD4F1YDNY8+KNpA+PxMFIgJC07
 6qA3W4KG8WlMAI92MEy/ru+Jh4wXKVTeptNEAB6cnNN2ANe9VBl267X43OFYHTJ1G8O3
 O1ugo2Y0vC5UWSWrbeU6eSXZgUi8cM2JqVo4TEf6glKPibrrnUfj6xxWpYn/aZtJuCEE
 gYnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0ou9io8uf3VKDbGKlHf2x7eRKMOVTLIyuGgxw2ob+co=;
 b=nQ4StbkQgMs7gGWi4ubXkWw0426IwIW7tJczJ4Zhi6l55bRjUpoCI1mqaU27PB/uJD
 oPUN+ytS5q29OmBCi/GRibfts2H33wl1YGi+ZTijj4sDR/yATp6ID60RjXhLrGFyqD7u
 jOSOmog1A4mGzoBysua88lsj41xKrVpnPme0ioWW8hw2v5+uboieMhRvaLEwG5StE8pe
 PouH7fieslik4OsIim4iUcX6lSUrklFbl6zrqcpFEqjXl/xOV8eMfIOPKXW9XT4HpNql
 H6Sl/Vf/6qMu4jiQD8NOAx8CouMh32cHALTNl01ojzMEoZTPbu/HCgWOrGJvsFgZVAwH
 YQcg==
X-Gm-Message-State: ANhLgQ10mGQBsRQYZYUQXXEPu1DdIL8jtL0285UZJQFky5A+33UYyYd8
 B45hCG1Yjm+tfGv9lqyHFqrtB0gedCLveebgQe4=
X-Google-Smtp-Source: ADFU+vvqDUZ8NzvS7rgMQP3FDX4PFSBnMvSyD3tfYbwvc/9u+ToEgKA0dlyhS9S1GKqSwbTsBRx00T7asjCalrNhy/U=
X-Received: by 2002:a5d:80d6:: with SMTP id h22mr2222820ior.129.1583205800885; 
 Mon, 02 Mar 2020 19:23:20 -0800 (PST)
MIME-Version: 1.0
References: <20200214132745.23392-1-eric.auger@redhat.com>
 <20200227111717.GG1645630@redhat.com>
 <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
In-Reply-To: <431cb39d-833c-6d02-d7b3-02b3e90446e2@redhat.com>
From: Zhangfei Gao <zhangfei.gao@gmail.com>
Date: Tue, 3 Mar 2020 11:23:10 +0800
Message-ID: <CAMj5Bkib3CTzCB02ScueFR84r28LGowF7uxYO8Ygmnj9X7oNOg@mail.gmail.com>
Subject: Re: [PATCH v16 00/10] VIRTIO-IOMMU device
To: Auger Eric <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d43
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
Cc: Peter Maydell <peter.maydell@linaro.org>, kevin.tian@intel.com,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 kenneth-lee-2012@foxmail.com, tnowicki@marvell.com,
 "Michael S. Tsirkin" <mst@redhat.com>, quintela@redhat.com,
 zhangfei.gao@foxmail.com, qemu-devel@nongnu.org, peterx@redhat.com,
 dgilbert@redhat.com, bharatb.linux@gmail.com, qemu-arm@nongnu.org,
 "Wangzhou \(B\)" <wangzhou1@hisilicon.com>, jean-philippe@linaro.org,
 eric.auger.pro@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Eric

On Thu, Feb 27, 2020 at 9:50 PM Auger Eric <eric.auger@redhat.com> wrote:
>
> Hi Daniel,
>
> On 2/27/20 12:17 PM, Daniel P. Berrang=C3=A9 wrote:
> > On Fri, Feb 14, 2020 at 02:27:35PM +0100, Eric Auger wrote:
> >> This series implements the QEMU virtio-iommu device.
> >>
> >> This matches the v0.12 spec (voted) and the corresponding
> >> virtio-iommu driver upstreamed in 5.3. All kernel dependencies
> >> are resolved for DT integration. The virtio-iommu can be
> >> instantiated in ARM virt using:
> >>
> >> "-device virtio-iommu-pci".
> >
> > Is there any more documentation besides this ?
>
> not yet in qemu.
> >
> > I'm wondering on the intended usage of this, and its relation
> > or pros/cons vs other iommu devices
>
> Maybe if you want to catch up on the topic, looking at the very first
> kernel RFC may be a good starting point. Motivation, pros & cons were
> discussed in that thread (hey, April 2017!)
> https://lists.linuxfoundation.org/pipermail/iommu/2017-April/021217.html
>
> on ARM we have SMMUv3 emulation. But the VFIO integration is not
> possible because SMMU does not have any "caching mode" and my nested
> paging kernel series is blocked. So the only solution to integrate with
> VFIO is looming virtio-iommu.
>
> In general the pros that were put forward are: virtio-iommu is
> architecture agnostic, removes the burden to accurately model complex
> device states, driver can support virtualization specific optimizations
> without being constrained by production driver maintenance. Cons is perf
> and mem footprint if we do not consider any optimization.
>
> You can have a look at
>
> http://events17.linuxfoundation.org/sites/events/files/slides/viommu_arm.=
pdf
>
Thanks for the patches.

Could I ask one question?
To support vSVA and pasid in guest, which direction you recommend,
virtio-iommu or vSMMU (your nested paging)

Do we still have any obstacles?
Would you mind give some breakdown.
Jean mentioned PASID still not supported in QEMU.

Thanks

