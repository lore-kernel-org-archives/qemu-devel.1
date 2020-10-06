Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F540C41604
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:24:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 472C420674
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 20:24:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfnw7EWr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 472C420674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPtVU-0005PI-UI
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 16:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50146)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kPtUj-00050D-UH
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:57641)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kPtUh-00027x-Os
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 16:23:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602015809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/bIujT4UIKi7Q0C0HWxi7iUl87stl4J+iwi3jf320fU=;
 b=bfnw7EWrTsao3RIIrO+Lah35G9x27nX2PDHaNh+DoOdjt26jYmCnm+9W1lXVCxkkX2PrUG
 5TpEB7UwbbKdGKFU0IYfFutKoGjkGx89X0c3z7MmmpwZdXRXZOX8fyBUUOj+K723RzsZ1X
 bwGi/BnJKAPfEsu/2Ft+dxDsbN+fMr8=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-OaPd2At7PPKfpUQ8YXEmKg-1; Tue, 06 Oct 2020 16:23:27 -0400
X-MC-Unique: OaPd2At7PPKfpUQ8YXEmKg-1
Received: by mail-qk1-f198.google.com with SMTP id w189so2280969qkd.6
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 13:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=/bIujT4UIKi7Q0C0HWxi7iUl87stl4J+iwi3jf320fU=;
 b=FVzYK99WYpMd2Qc3CABoYuenGXq80fmY08VvITuup+Ru1TyKxk6tmZdZIg9D2Z3Gno
 S9711PeNFmuMicFZg8pOaHQR26RndOTj1phcfGzRWijs+s+4sDfWtW+Q0PQQELYYP8r8
 OnDW22DpSS9BaIaRyWymdeplgmm8Lde4EceBBN5a+sDH56geDkCtyyBN+zlUZp5wskDA
 dnEcdh5wR8d5HXscG8rAFRl5u+ixgodcERNrSoGJJ7lZ6pzA5nmnZJuxq+fh51XgPLz2
 QRtxgBtsCKUKFkqgA7Ly5PUu8y8Tz+PQ+jQt+geGutmd++9/gvb1yLoJBxVTYDRvxDoT
 mFXQ==
X-Gm-Message-State: AOAM5326ytouNUBSDkqiq2g4qnlqHR/OexwsvOq6tT/OKd+ZQib8aJ+4
 1jdDGyzvekOFa0FqPb06NIWcKjiLueln3eO5xl7RVB8oVA2FCGlY64Hs3HEBm0Z5XGulxqxP4ku
 UVfKqWACxqILI0kw=
X-Received: by 2002:a0c:ba85:: with SMTP id x5mr6402084qvf.7.1602015807343;
 Tue, 06 Oct 2020 13:23:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyH9gCb14Q8AvKFFyGtg3zoy+SAv/mwiN3YlCC4HSTfr52Pj1qwCgokMqlUnRl5D0hsAGia2A==
X-Received: by 2002:a0c:ba85:: with SMTP id x5mr6402068qvf.7.1602015807094;
 Tue, 06 Oct 2020 13:23:27 -0700 (PDT)
Received: from xz-x1 (toroon474qw-lp130-09-184-147-14-204.dsl.bell.ca.
 [184.147.14.204])
 by smtp.gmail.com with ESMTPSA id f33sm3184471qtb.45.2020.10.06.13.23.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2020 13:23:26 -0700 (PDT)
Date: Tue, 6 Oct 2020 16:23:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Alok Prasad <prasadalok77@gmail.com>
Subject: Re: Fwd: Enable IOMMU Inside QEMU
Message-ID: <20201006202325.GB6026@xz-x1>
References: <CAJPzGv1Vd1V2a_7n2GW4RBUDgpsdyAH-8NMvW+368gigtYWd0g@mail.gmail.com>
 <CAJPzGv0bFatmLJ_dy83KgZbyMS5zM0_pAqTynkSAHXNUST_JHg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJPzGv0bFatmLJ_dy83KgZbyMS5zM0_pAqTynkSAHXNUST_JHg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/06 01:55:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.733,
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Oct 06, 2020 at 11:26:08PM +0530, Alok Prasad wrote:
> root@beta-hp-p70:/home/fastlinq/alok/KVM-VM# /usr/bin/qemu-system-x86_64
> --version
> QEMU emulator version 4.2.1
> Copyright (c) 2003-2019 Fabrice Bellard and the QEMU Project developers
> 
> I am missing here something,? Is there seperate Branch for the same in qemu.

No, it should always be in mainline.

I didn't see anything obviously wrong in your setup.  A simplest QEMU cmdline
to boot a guest with vIOMMU should be:

$QEMU -machine q35,kernel-irqchip=split,accel=kvm -smp 4 -m 2G \
      -device intel-iommu ~/images/default.qcow2

May worth try this directly.  Also feel free to compile the latest QEMU.  The
default configuration should work.

-- 
Peter Xu


