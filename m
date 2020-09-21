Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB765C43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:40:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D2A20756
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 12:40:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O4fAofs2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D2A20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKL7O-0000sK-7p
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 08:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60940)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKL6Z-0000P7-J6
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:39:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKL6W-000214-LK
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 08:39:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600691975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=f9dliV9ndd1n3HUA+w5UU7NRE+MuIjWhID2u4zI175o=;
 b=O4fAofs2JSv1JxI4sgTKSbWZn9csp4WqBesRY1BtZBJdsVd83afMTSMOTbwA+7j+0ifFBu
 yoc7tqV35sSzT5RcMP9unApxXhyXW2ScZv22iYRm4oTsBvlirlsd9g7ZvNvCHmJVbd8OIz
 qiRwqShMoyHQKRZb7b9LOxYC0Eprhmw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-265-7pH-ssAqMyaHBdGJRdVWwQ-1; Mon, 21 Sep 2020 08:39:34 -0400
X-MC-Unique: 7pH-ssAqMyaHBdGJRdVWwQ-1
Received: by mail-wr1-f69.google.com with SMTP id v5so5761855wrs.17
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 05:39:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=f9dliV9ndd1n3HUA+w5UU7NRE+MuIjWhID2u4zI175o=;
 b=n6JL6zB9EATXfj66XRe6OEWh5y6gRq05/rAb0fS0QIqhMQH/fKfM67iM2GgjbPWYcM
 prKGy1wz+eYIjfylOVxkjXwpsQgFaj0HWDMhtE+YgRs7WaQzD8EwfoyEtHwQ2XbT99rY
 z/jR8UXoJu9PzoA8nJ2Q6orgqH1DEbckVV+UyGeJIu9U0YPCskYMTMG3H1xdQ0Awo8Cl
 HJtrX+Ik3yxAZL4rKSsBRsa6+VQ3yVCyFk+dpLPnHY9wYwlnvfW1h+Zl9gxkECtUSSkJ
 hhiOzCUzlNj5G690Q4wc0sFW16lmWVMA3YgoTE3q+AjeAO8yd95EHJ84ueQEilUOKcBF
 9yZg==
X-Gm-Message-State: AOAM532RiTyEiTWmj9bZNmMbUWoeK/fzEpvyZvsoceG+U6tdSpEOn3Yx
 YX1mMcg3LofQjuSC9XBAkOb9SALevLD/LyvfNs/vXmpv4Lr4m3vFxnwxBoctFxfP8oQzRqymP6+
 4uID34rntWpSrU60=
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr29095838wmi.36.1600691973252; 
 Mon, 21 Sep 2020 05:39:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxpdWooLVDqN0SW1uJHSan0ABwdhWcEqfvqO++lU7xrW79DY64OUVc9ySAXnDYRniCBoetMqQ==
X-Received: by 2002:a05:600c:4104:: with SMTP id
 j4mr29095818wmi.36.1600691973019; 
 Mon, 21 Sep 2020 05:39:33 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id k5sm19497949wmb.19.2020.09.21.05.39.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 05:39:32 -0700 (PDT)
Date: Mon, 21 Sep 2020 08:39:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [PATCH 2/2] microvm: add pcie support
Message-ID: <20200921083751-mutt-send-email-mst@kernel.org>
References: <20200918121911.5194-1-kraxel@redhat.com>
 <20200918121911.5194-3-kraxel@redhat.com>
 <20200918083533-mutt-send-email-mst@kernel.org>
 <20200921113347.mrdrxwskh5dzkosv@sirius.home.kraxel.org>
MIME-Version: 1.0
In-Reply-To: <20200921113347.mrdrxwskh5dzkosv@sirius.home.kraxel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Eduardo Habkost <ehabkost@redhat.com>, Sergio Lopez <slp@redhat.com>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Sep 21, 2020 at 01:33:47PM +0200, Gerd Hoffmann wrote:
> On Fri, Sep 18, 2020 at 08:36:14AM -0400, Michael S. Tsirkin wrote:
> > On Fri, Sep 18, 2020 at 02:19:11PM +0200, Gerd Hoffmann wrote:
> > > Uses the existing gpex device which is also used as pcie host bridge on
> > > arm/aarch64.  For now only a 32bit mmio window and no ioport support.
> > > 
> > > It is disabled by default, use "-machine microvm,pcie=on" to enable.
> > > ACPI support must be enabled too because the bus is declared in the
> > > DSDT table.
> > > 
> > > Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> > 
> > Can we do the reverse and only support a 64 bit window?
> > 32 bit resources are a pain, we support them on x86 for purposes
> > of legacy guests ...
> 
> 32bit pci bars too, right?
> I suspect we can't that easily take away the 32bit window ...
> 
> take care,
>   Gerd


Yes I forgot, in their wisdom pci sig declared that non prefetcheable
memory windows in bridges are always 32 bit :(

-- 
MST


