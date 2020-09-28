Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A484CC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:08:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E56C520757
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 17:08:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swxdpPzo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E56C520757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMwdP-0007oI-Mw
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 13:08:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43874)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kMwc2-0006tT-4a
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:06:54 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:38361)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1kMwc0-0004zE-1f
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 13:06:53 -0400
Received: by mail-wm1-x342.google.com with SMTP id v12so1902921wmh.3
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 10:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=rXMVHk49nFHuJjxOUAr1bU28spoOdRyOodFXEN5Zs8c=;
 b=swxdpPzonRwdMr1qsinOGSniERrXi7+4wK10mrtjzPrzCpdaXpSa4l30j48Omw8Lc/
 nb6HpSq7mfwJjxWFfhrmOQxATWbTOpvcTjhR0SW1FLIgRfJ/574fQho3VCPMMggp/SRp
 4pBwM/XTFN/8PBP3INlR/hpU7rb/pG3L3cFp4yEKnSg6FwYRcOj1lFhgNRzIfFMHYSki
 WQon6952b5xGQ0FroYwZsz6XvAa35+TI9+x+1FiCO4+a1MAAxNw+eyt6HQ/LbV935rQE
 Sp3fU5duAV9RsZR7V/EqzetICMxoGYR+N27IH/K7PM/0gM8lNzMP0Nw4PBevQan4QHGh
 +lNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rXMVHk49nFHuJjxOUAr1bU28spoOdRyOodFXEN5Zs8c=;
 b=uoOyvjuWR/Z6H7PTJe+ExE9MdIDtOGFL8zO2wSxoiLWE9gKLO2znqWFEE1qMWLHm8S
 daUYXn2+2Q7Es9q23uSmwoN2b+y3eoYtGKLBAbUy8dVKyTVey9zShHSCexwJrDhgOUN9
 x2u/2CwmDXMHJ4pcKJ0ukZnQShZrvQLz6XWI+FxVqq/bvdcLdvwGQ+C9n87erfITK5Fe
 mmpeJXb2knS626+PTaU246nE6rxAAzK6EF1I/TAtItw1SzA2m5OpDseLj04hLGAoepfu
 GDVnIbfdSrnAZO8OM2mI9ML3ZuUgktd9PbbCGsETRir4LoYB95grZlLmesNl9pWeokp+
 t7/A==
X-Gm-Message-State: AOAM531/e/81rr91VBEqHcyQzxJspMHTqt419oEB6scNu1u7ZXlIeSbo
 ifh/1HJgc7L2mtQmrCrpZUM=
X-Google-Smtp-Source: ABdhPJw0k4ExqIfzum4efV9QQr94tJ4QcOOfTEcgeWtDiWkuZfxUUetylS1mrCTZiHZxM8gd0Ostog==
X-Received: by 2002:a7b:cbcb:: with SMTP id n11mr163372wmi.5.1601312810279;
 Mon, 28 Sep 2020 10:06:50 -0700 (PDT)
Received: from localhost ([51.15.41.238])
 by smtp.gmail.com with ESMTPSA id 91sm2373985wrq.9.2020.09.28.10.06.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2020 10:06:48 -0700 (PDT)
Date: Mon, 28 Sep 2020 18:06:47 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
To: Kirti Wankhede <kwankhede@nvidia.com>
Subject: Re: [PATCH Kernel v24 4/8] vfio iommu: Add ioctl definition for
 dirty pages tracking
Message-ID: <20200928170647.GB176159@stefanha-x1.localdomain>
References: <1590697854-21364-1-git-send-email-kwankhede@nvidia.com>
 <1590697854-21364-5-git-send-email-kwankhede@nvidia.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="OwLcNYc0lM97+oe1"
Content-Disposition: inline
In-Reply-To: <1590697854-21364-5-git-send-email-kwankhede@nvidia.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::342;
 envelope-from=stefanha@gmail.com; helo=mail-wm1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cjia@nvidia.com, kvm@vger.kernel.org, aik@ozlabs.ru,
 Zhengxiao.zx@alibaba-inc.com, shuangtai.tst@alibaba-inc.com,
 qemu-devel@nongnu.org, eauger@redhat.com, yi.l.liu@intel.com,
 eskultet@redhat.com, ziye.yang@intel.com, mlevitsk@redhat.com,
 pasic@linux.ibm.com, felipe@nutanix.com, Ken.Xue@amd.com, kevin.tian@intel.com,
 yan.y.zhao@intel.com, dgilbert@redhat.com, alex.williamson@redhat.com,
 changpeng.liu@intel.com, cohuck@redhat.com, zhi.a.wang@intel.com,
 jonathan.davies@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--OwLcNYc0lM97+oe1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, May 29, 2020 at 02:00:50AM +0530, Kirti Wankhede wrote:
> + * Calling the IOCTL with VFIO_IOMMU_DIRTY_PAGES_FLAG_GET_BITMAP flag set
> + * returns the dirty pages bitmap for IOMMU container for a given IOVA range.
> + * The user must specify the IOVA range and the pgsize through the structure
> + * vfio_iommu_type1_dirty_bitmap_get in the data[] portion. This interface
> + * supports getting a bitmap of the smallest supported pgsize only and can be
> + * modified in future to get a bitmap of any specified supported pgsize. The
> + * user must provide a zeroed memory area for the bitmap memory and specify its
> + * size in bitmap.size. One bit is used to represent one page consecutively

Does "user must provide a zeroed memory area" actually means "the vendor
driver sets bits for pages that are dirty and leaves bits unchanged for
pages that were not dirtied"? That is more flexible and different from
requiring userspace to zero memory.

For example, if userspace doesn't actually have to zero memory then it
can accumulate dirty pages from multiple devices by passing the same
bitmap buffers to multiple VFIO devices.

If that's the intention, then the documentation shouldn't say "must"
zero memory, because applications will need to violate that :). Instead
the documentation should describe the behavior (setting dirty bits,
leaving clean bits unmodified).

> +struct vfio_iommu_type1_dirty_bitmap_get {
> +	__u64              iova;	/* IO virtual address */
> +	__u64              size;	/* Size of iova range */
> +	struct vfio_bitmap bitmap;
> +};

Can the user application efficiently seek to the next dirty bit or does
this API force it to scan the entire iova space each time?

--OwLcNYc0lM97+oe1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl9yGCcACgkQnKSrs4Gr
c8iAiwf/T3SOKjt5I+60nMpQL/j9/X879c9B+2SOJdp7IgVUheVZ67VMcG64j7fJ
pOV2bSPN3fufzEmBS9HrXCrKPFzG0Kq/OFl9ceC3Gsm8BIVTgK4KB/laENDEfMzd
bCQWxthkGGbMmFTfWNhJCKyrXCjou3XSDiN0308OzKYYhkIvue+65Qlu10ae50Vm
oXvd5ZyMwLXLoJLTLT7p6Lnszpw6VHS3U8t6Oa0d5c3hA7OdffYzCfZBcBasbuTR
T8uwFPBjjhMP/nKAH3SKi9ILjyPc0+pZAq5hIOlmrkZuBWoZpJA5haD2ouaj3BLA
Soyyd00/vJUTLGw+xUcaVBB/JM/mlg==
=DWPv
-----END PGP SIGNATURE-----

--OwLcNYc0lM97+oe1--

