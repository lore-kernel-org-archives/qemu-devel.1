Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E834C4360C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:01:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E366206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 03:01:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E366206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJqbo-0003CP-6n
	for qemu-devel@archiver.kernel.org; Sun, 13 Oct 2019 23:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45499)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iJqak-0002Xx-Iu
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:00:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iJqai-0005fI-94
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:00:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iJqai-0005cA-17
 for qemu-devel@nongnu.org; Sun, 13 Oct 2019 23:00:12 -0400
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 876F13CA04
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:00:09 +0000 (UTC)
Received: by mail-pl1-f197.google.com with SMTP id g7so9420219plo.5
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2019 20:00:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=lHDXXDnYm3T8zKIvXR2xTjTgzp4EFEaxT9kpH2TNGIQ=;
 b=OifKMhFaiU2C7TOq/RK16M9cJdoay+fTdRRdZLfpxIP81WD376Mlnxd9ddmkSYnFRK
 CKXm01EBrQrKhSJM9gy5QO7gDfsSU/lyJijMzbEfrPhl5Fy2Og8UmTFdAYWREt6CzE9n
 BHR6o7OVygiGA9gTg8SBsGcvWEaFs8mAXTi8FTJmS9fFp4I3MBmWX8B3jsRa9oJcnZKb
 k0FU8FNi/jvEnCZG0P//V6TqGwHD66my87xIln10YzCnhEJTlHDhmBwERU1vjycG887E
 0FMbTeAMzgIpH3mGo840tCaq+R/vo6BvCoQ3ynmcq4IuiLWByR1SA/r84F/pDwzMTtHo
 1LIQ==
X-Gm-Message-State: APjAAAVdiL5PKxnPhtLbhILHIF6XSuKCevEmwfCFF1c7fN8OfF8d9QiV
 9+iAeWGySa+zhwGbauwPcRzNTu/WtQZkH9Qn3aEBxUmH8m67nCAEG8kzOb5ZLeuxf4+IgIh0TYT
 mBxdvmk8jO+0snGU=
X-Received: by 2002:a17:902:9888:: with SMTP id
 s8mr18806029plp.193.1571022008920; 
 Sun, 13 Oct 2019 20:00:08 -0700 (PDT)
X-Google-Smtp-Source: APXvYqw/kdkW0G4p5ryOTez2X0ebHiQC/3+nZRJ2d8izkQ07QEbENLdvtpe/j9i67gomFycnaLeeHQ==
X-Received: by 2002:a17:902:9888:: with SMTP id
 s8mr18805992plp.193.1571022008549; 
 Sun, 13 Oct 2019 20:00:08 -0700 (PDT)
Received: from xz-x1 ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j128sm16889019pfg.51.2019.10.13.20.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Oct 2019 20:00:07 -0700 (PDT)
Date: Mon, 14 Oct 2019 10:59:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [for-4.2 PATCH 0/2] PCI DMA alias support
Message-ID: <20191014025957.GA8666@xz-x1>
References: <156418830210.10856.17740359763468342629.stgit@gimli.home>
 <20190729151504-mutt-send-email-mst@kernel.org>
 <20190819152316.232bf1e5@x1.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190819152316.232bf1e5@x1.home>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: brijesh.singh@amd.com, Suravee.Suthikulpanit@amd.com,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, zhexu@redhat.com,
 eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 19, 2019 at 03:23:16PM -0600, Alex Williamson wrote:
> On Mon, 29 Jul 2019 15:15:29 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Jul 26, 2019 at 06:55:27PM -0600, Alex Williamson wrote:
> > > Please see patch 1/ for the motivation and utility of this series.
> > > This v1 submission improves on the previous RFC with revised commit
> > > logs, comments, and more testing, and the missing IVRS support for DMA
> > > alias ranges is now included.  Testing has been done with Linux guests
> > > with both SeaBIOS and OVMF with configurations of intel-iommu and
> > > amd-iommu.  Intel-iommu testing includes device assignment, amd-iommu
> > > is necessarily limited to emulated devices with interrupt remapping
> > > disabled and iommu=pt in the guest (enabling interrupt remapping or
> > > disabling guest passthrough mode fails to work regardless of this
> > > series).  This series is NOT intended for QEMU v4.1.  Thanks,
> > > 
> > > Alex  
> > 
> > 
> > series looks good to me.
> > pls ping when 4.1 is out and I'll queue it.
> 
> Here's the requested ping :)  If you'd like a re-posting or comment
> update, just say so.  I think Peter was ultimately satisfied enough to
> not request a re-spin for comments alone.  Thanks,

Hi, Michael,

Do you plan to merge this series?  Or do you still wait for an ack?

In all cases:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu

