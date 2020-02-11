Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB757C35242
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:19:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F26D20708
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 20:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F9DEVE7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F26D20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1c0U-0001Bk-SU
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 15:19:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1j1byV-0008HG-8C
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1j1byT-0007rU-MT
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:17:38 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53846
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1j1byT-0007pR-8y
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 15:17:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581452256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NTvEuZSA3B0nadze0YvBWzv0QAqBQfRUw/3RF8G30MM=;
 b=F9DEVE7Gu+PV7x2dp/z5S8Dixk0ERVh6qTVbIZjNTomvlq6ToiAyYHWGo/am0rAQhHKPVT
 W4Nd8fsKt1g7gNWTaQ/uQ9dbculraYZbgpT0A28RUmE1o+e7q/3zWuh5ubCJIPwQQEuzvx
 +y9IFhl3OWlb/h/av/riGw7LpYwTmtc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-211-vymaQ6DpNJ-O4shMwnQR2A-1; Tue, 11 Feb 2020 15:17:32 -0500
Received: by mail-qt1-f197.google.com with SMTP id b5so7466255qtt.10
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2020 12:17:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2n1XuFh1TfPRhW8BtVWDxws+sMTjPmhnwZU8q2safFI=;
 b=XbXqRhtZwoDFMO+TMUYdgBtPlcoTEF6wwAOuNqVtS3rV/LixfdB7vGYiPH76McclJn
 JVhRt+msNrNXSvCyJFdRLHRRZm7i0zUqzUHQiiV86qcbNcihYB+2Oru/pnlo5UGTHuv7
 Wv9KaPW114vCjL6rdUnHEZmEidpicJ4591ehoPuuqBFQlmDsxFtUIsdSPXnnwGZEazws
 5U2ELtCuAZ5Qp65seMZwAO1lq0yZ/oWE0XaWjcu7XDLQXuXVUS4Rk5mWkG+DBNHHE1tf
 ZUnPZcwCW3ZGdXmHjv+TCcEkbjK56wzYbaZGMXP+4s4cEiNnf5uenPPDZvIUKQdBwi/h
 ydog==
X-Gm-Message-State: APjAAAWU7l7B3F4N3+LszIVRh2AIFAEnH6C19lRVdX0Tgeuegh9QJ0Iu
 TbJZqNnNSoiaDwhmCvxqOwdINCWFEI8EWLBbOylYN9zA1bYGrKZMjLSTBEfeEZxZxRe6EAcyZN2
 aS7C1deEiYcBhn1s=
X-Received: by 2002:ac8:70d5:: with SMTP id g21mr16029175qtp.46.1581452251962; 
 Tue, 11 Feb 2020 12:17:31 -0800 (PST)
X-Google-Smtp-Source: APXvYqzPgOox0hoFSqBwyM/SG+T29FHEd69AnhPYMbf1Hp8+R4QUO+KGBpbRLIGWBg/HA0g58mdBtg==
X-Received: by 2002:ac8:70d5:: with SMTP id g21mr16029153qtp.46.1581452251773; 
 Tue, 11 Feb 2020 12:17:31 -0800 (PST)
Received: from xz-x1 ([2607:9880:19c8:32::2])
 by smtp.gmail.com with ESMTPSA id 8sm2582400qkm.92.2020.02.11.12.17.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2020 12:17:30 -0800 (PST)
Date: Tue, 11 Feb 2020 15:17:28 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v3 15/25] intel_iommu: process pasid cache invalidation
Message-ID: <20200211201728.GM984290@xz-x1>
References: <1580300216-86172-1-git-send-email-yi.l.liu@intel.com>
 <1580300216-86172-16-git-send-email-yi.l.liu@intel.com>
MIME-Version: 1.0
In-Reply-To: <1580300216-86172-16-git-send-email-yi.l.liu@intel.com>
X-MC-Unique: vymaQ6DpNJ-O4shMwnQR2A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: kevin.tian@intel.com, Jacob Pan <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, Eduardo Habkost <ehabkost@redhat.com>,
 kvm@vger.kernel.org, mst@redhat.com, jun.j.tian@intel.com,
 qemu-devel@nongnu.org, eric.auger@redhat.com, alex.williamson@redhat.com,
 pbonzini@redhat.com, hao.wu@intel.com, yi.y.sun@intel.com,
 Richard Henderson <rth@twiddle.net>, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jan 29, 2020 at 04:16:46AM -0800, Liu, Yi L wrote:
> From: Liu Yi L <yi.l.liu@intel.com>
>=20
> This patch adds PASID cache invalidation handling. When guest enabled
> PASID usages (e.g. SVA), guest software should issue a proper PASID
> cache invalidation when caching-mode is exposed. This patch only adds
> the draft handling of pasid cache invalidation. Detailed handling will
> be added in subsequent patches.
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


