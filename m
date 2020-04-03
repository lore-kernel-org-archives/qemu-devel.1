Return-Path: <SRS0=URa6=5T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56196C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FFB62078C
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2020 14:48:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OLUweKiG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FFB62078C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56536 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jKNcP-0001DR-Ae
	for qemu-devel@archiver.kernel.org; Fri, 03 Apr 2020 10:48:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44570)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1jKNbU-0000nK-JE
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:47:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1jKNbT-0003YF-Jw
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:47:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42319
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1jKNbT-0003Xv-Fz
 for qemu-devel@nongnu.org; Fri, 03 Apr 2020 10:47:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585925247;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0onV65pO7g4ctY9BUIxWgvI1+AxNmjeClJyHqumUo1Q=;
 b=OLUweKiG0hWHbqclmg4pk+GwCNBJpS69etpwgsWgCDUu1I4sBK69VmLMfmDghzln7to2rN
 nREtKKgvfyqjKrURMvO0yPim8BsmLZDbV7XsuC6lKs7O9hwb2bXS5gVpd3IZ4hxEMQ6zMS
 dQOumaRLT27/+SdT3+/UpHr3j6Y+AUg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-yYGvnmBRPxmAbGhTmwOxNg-1; Fri, 03 Apr 2020 10:47:25 -0400
X-MC-Unique: yYGvnmBRPxmAbGhTmwOxNg-1
Received: by mail-wr1-f71.google.com with SMTP id 91so2327805wro.1
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2020 07:47:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pIMdHeam2Dd57E1ij8qf+M+ClKnpGrmjjcDtBAmNnvM=;
 b=QPeFs/O+Wk+C4+B6onFFafVFWJTudrPiEP+4fWg4cVv0vsXkcrrleqNrWedfIEWCnj
 NTtQC/iSrmreia1hMHoGTGQcYfhYTGTxWmG7LP+tuLz+IIT6YVz/8cNMw83sAleNKOU7
 7hgX0ydmre50kRd5rLX39w1MFH1FbdK+l+x5MHD8RmMOu/5A70uaE70SA5FX9EjdxAvC
 6OcMTzGnVvzH6wFyzJTmCPxFfEs1MW4JwR4Jj0klC8GvzTecOcr0+Fom/4NVMai5drn2
 uHPRjZCSE7CLnxhsNKt9DZwha/Gnnplv+RhAo4rGl0/U3NPVRJcnnSsTgJjCGpEiI0j3
 SaDw==
X-Gm-Message-State: AGi0Pub5S+w+vX02JoLR+S1ubTppbxtSgynlT9V+DV5mTfdP/hC/BlTy
 8rS8sVtnVknTxOXH+ghBQeTW4/+aJFUDvZbWTUMeuZTsdwC06+5JXDizNq3g9WqWWSn0FjeC/7U
 4QXmt6BN7Du0vRlQ=
X-Received: by 2002:a7b:c148:: with SMTP id z8mr8859436wmi.31.1585925244255;
 Fri, 03 Apr 2020 07:47:24 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ/slyncg9POzbP4k32yikwz4uR//iAykjMgD1RX8ERy9OxRDOu6M5CxkUlQ8AKnuQ1Xi3O1w==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr8859410wmi.31.1585925244062;
 Fri, 03 Apr 2020 07:47:24 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
 by smtp.gmail.com with ESMTPSA id n6sm12456186wrp.30.2020.04.03.07.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Apr 2020 07:47:23 -0700 (PDT)
Date: Fri, 3 Apr 2020 10:47:19 -0400
From: Peter Xu <peterx@redhat.com>
To: Liu Yi L <yi.l.liu@intel.com>
Subject: Re: [PATCH v2 19/22] intel_iommu: process PASID-based iotlb
 invalidation
Message-ID: <20200403144719.GL103677@xz-x1>
References: <1585542301-84087-1-git-send-email-yi.l.liu@intel.com>
 <1585542301-84087-20-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1585542301-84087-20-git-send-email-yi.l.liu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: jean-philippe@linaro.org, kevin.tian@intel.com,
 Jacob Pan <jacob.jun.pan@linux.intel.com>, Yi Sun <yi.y.sun@linux.intel.com>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org, mst@redhat.com,
 jun.j.tian@intel.com, qemu-devel@nongnu.org, eric.auger@redhat.com,
 alex.williamson@redhat.com, pbonzini@redhat.com, hao.wu@intel.com,
 yi.y.sun@intel.com, Richard Henderson <rth@twiddle.net>,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Mar 29, 2020 at 09:24:58PM -0700, Liu Yi L wrote:
> This patch adds the basic PASID-based iotlb (piotlb) invalidation
> support. piotlb is used during walking Intel VT-d 1st level page
> table. This patch only adds the basic processing. Detailed handling
> will be added in next patch.
>=20
> Cc: Kevin Tian <kevin.tian@intel.com>
> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Yi Sun <yi.y.sun@linux.intel.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Cc: Richard Henderson <rth@twiddle.net>
> Cc: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Liu Yi L <yi.l.liu@intel.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

--=20
Peter Xu


