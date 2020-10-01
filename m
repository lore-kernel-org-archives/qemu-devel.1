Return-Path: <SRS0=M6H1=DI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46209C4727C
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:47:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A26E921707
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2020 12:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RXMT8ybI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A26E921707
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46722 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNxzY-0001Xs-Qw
	for qemu-devel@archiver.kernel.org; Thu, 01 Oct 2020 08:47:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38210)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNxyt-000173-9e
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:46:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28422)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNxyr-0002wD-5d
 for qemu-devel@nongnu.org; Thu, 01 Oct 2020 08:46:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601556400;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Js563GcaR2/yt5ZRRb4g7uvZTFa1RVtXs31pHNFBFkg=;
 b=RXMT8ybI/DtCizqV42MCHXcUUePtAUW1c/V3LW7DZkpFyTq0Egzu4S3s90djEHpE1Bg1HB
 q94BFq4defsIkxQUpieyXx40F4NCbUgK2cET/UDQ6hGjATL/Pq6K+/cc5rJeC5Kk03GKow
 nLjaM83zpOCR2hgfuJ+3XXJn/fR+XVo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-jYj4gvFuO4iimFJnlOyw7A-1; Thu, 01 Oct 2020 08:46:35 -0400
X-MC-Unique: jYj4gvFuO4iimFJnlOyw7A-1
Received: by mail-wr1-f70.google.com with SMTP id w7so2031439wrp.2
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2020 05:46:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Js563GcaR2/yt5ZRRb4g7uvZTFa1RVtXs31pHNFBFkg=;
 b=t55djfL5XoTrltiBhyFAH/+nWYbvV708RgSB8GrTcDrSWsq9dVeE3hoI2sMbgJUxDP
 IxHmROjjDvqQubrBztxnLfywMxY4Ze6Y+6B9B7toC6lo+No11YlPvQBToRmcriQs5iFN
 uu0+TYtLQFWDRnLmbuxBxRJK2HN6dhcy5sLJRenn5JlBZml3ui6pwjhzmpw4vZrqu7uR
 zSy8oXnA0B0LGpClgzJui/ljx+LVGFq5bvnIF2Rhs4XI8TAVSPtNDWb/lQw6UeBC35lB
 ZFwyDsF9kT95zJyI4yV6nbo23Yaz2jke9QgYTsihggZb3oEi1Rz4l/zet6RJU82nhabY
 jsEg==
X-Gm-Message-State: AOAM533ELw4jrAGcyHRfrS3PEbaVWfmb797exaOTWrr5ZNWTMox4kSld
 GH/xbTqbOE4Db6x2yTOuceHeRqOoUzJkhirtLq5WWSNIf1IrJ70cKiGN0MF7UpxL15QycySUsjr
 VNnLuRsb2mw5GuX8=
X-Received: by 2002:a7b:c774:: with SMTP id x20mr2389456wmk.102.1601556394458; 
 Thu, 01 Oct 2020 05:46:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzH6EuErZXThHeJ05UE72wy3Fr8fkLJJnHtXxx76BlpIz/RYUHWaHYI9cBE1T6i8tXzrTOyqA==
X-Received: by 2002:a7b:c774:: with SMTP id x20mr2389421wmk.102.1601556394184; 
 Thu, 01 Oct 2020 05:46:34 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id y1sm8480045wma.36.2020.10.01.05.46.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2020 05:46:33 -0700 (PDT)
Date: Thu, 1 Oct 2020 08:46:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 0/2] vhost: Skip access checks on GIOVAs
Message-ID: <20201001084608-mutt-send-email-mst@kernel.org>
References: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
MIME-Version: 1.0
In-Reply-To: <160139701999.162128.2399875915342200263.stgit@bahia.lan>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/01 04:25:37
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org,
 Jason Wang <jasowang@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 29, 2020 at 06:30:20PM +0200, Greg Kurz wrote:
> This series addresses some misuse around vring addresses provided by
> userspace when using an IOTLB device. The misuse cause failures of
> the VHOST_SET_VRING_ADDR ioctl on POWER, which in turn causes QEMU
> to crash at migration time.
> 
> While digging some more I realized that log_access_ok() can also be 
> passed a GIOVA (vq->log_addr) even though log_used() will never log
> anything at that address. I could observe addresses beyond the end
> of the log bitmap being passed to access_ok(), but it didn't have any
> impact because the addresses were still acceptable from an access_ok()
> standpoint. Adding a second patch to fix that anyway.
> 
> Note that I've also posted a patch for QEMU so that it skips the used
> structure GIOVA when allocating the log bitmap. Otherwise QEMU fails to
> allocate it because POWER puts GIOVAs very high in the address space (ie.
> over 0x800000000000000ULL).
> 
> https://patchwork.ozlabs.org/project/qemu-devel/patch/160105498386.68108.2145229309875282336.stgit@bahia.lan/

I queued this. Jason, can you ack please?

> v2:
>  - patch 1: move the (vq->ioltb) check from vhost_vq_access_ok() to
>             vq_access_ok() as suggested by MST
>  - patch 2: new patch
> 
> ---
> 
> Greg Kurz (2):
>       vhost: Don't call access_ok() when using IOTLB
>       vhost: Don't call log_access_ok() when using IOTLB
> 
> 
>  drivers/vhost/vhost.c |   32 ++++++++++++++++++++++++--------
>  1 file changed, 24 insertions(+), 8 deletions(-)
> 
> --
> Greg


