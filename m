Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56434C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:24:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC4E2075A
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 16:24:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CSPVS2ss"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC4E2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGPN1-0005li-TD
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 12:24:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kGPMT-0005Kx-BP
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:23:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:49355)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1kGPMR-0007uG-UN
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 12:23:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599755026;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YY3Q6jiBbVXI1tMBsbOoQ88Afurax1DW0qfqFoBBwkQ=;
 b=CSPVS2ssEfvcuDJhMwjM2Tab6sF8UVzLZcD6V/ljlXVcsVl92Kbe8GyZ5G8DHIOLadXVeU
 P2wNuTiThCRDPPJlF69X5Ty0vH01S6kzl7Duvat7JvmRZJioXYkJMrr8N9w98LsAEHqzeU
 NCSVqcr1JaVvRbpR4vn2SpFIqBTeBhM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-PvpSNfFdM9qYQHAWKPyq7A-1; Thu, 10 Sep 2020 12:23:44 -0400
X-MC-Unique: PvpSNfFdM9qYQHAWKPyq7A-1
Received: by mail-qt1-f198.google.com with SMTP id t11so4508972qtn.8
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 09:23:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=YY3Q6jiBbVXI1tMBsbOoQ88Afurax1DW0qfqFoBBwkQ=;
 b=YqysMnBML568299fAMFZConnx0sbPNFQhmaAGsgXvleCry60v4GXjTLx7h7W0XNMJC
 QUiaZOHE/6sVNyNeZXUOuN53PEiuXuZCNABa2L2RhL6yW/V6wE0ATnqtrcuAnFNzP0/G
 IXk2FplBtaNSplGYEkmdLFvBCf889QysoecQXFsG4DbAHvFxKZ7J25vrSb58CzHvvOll
 X2xt6jikwy2Vy0DvvrhAnl5giLOVy+ZM8WAWw+ciMGo3X7TpFae+B9iXSMG+sOg9+IQ2
 Pm8f2j+K8j2mE6ChVz75+5ey9kchStNholl1dKDVESLh2TAn1Xqj7xOCumUfuv4vRJZy
 s/aA==
X-Gm-Message-State: AOAM531Ly+t47f3Bvy3eBld068eKnH7p/HydJ8OC73eoBZBew5v0q4hw
 T3HBMV/m+0LHH8IneOkirxeDZdrpWx2jMXffkgOxEOIzKN/kQvaHtsyTXya8/5ilV93T2KPdP/3
 0o3Tdl1fX1tj1XDA=
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr8873719qvw.25.1599755024141; 
 Thu, 10 Sep 2020 09:23:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxJdIHaNT1rwpMbyI0RNYGiF0MUJ6qA/YtXP+aZ5Fvl1Gl5PtTJ1WymrfHN9r60nYCjxMR3Rw==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr8873701qvw.25.1599755023851; 
 Thu, 10 Sep 2020 09:23:43 -0700 (PDT)
Received: from xz-x1 (bras-vprn-toroon474qw-lp130-11-70-53-122-15.dsl.bell.ca.
 [70.53.122.15])
 by smtp.gmail.com with ESMTPSA id h18sm6867296qkl.12.2020.09.10.09.23.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 09:23:42 -0700 (PDT)
Date: Thu, 10 Sep 2020 12:23:41 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] pci: advertise a page aligned ATS
Message-ID: <20200910162341.GD247092@xz-x1>
References: <20200909081731.24688-1-jasowang@redhat.com>
 <20200909154329.GB247092@xz-x1>
 <b343fea6-ecf2-7605-9340-decdd1b95149@redhat.com>
MIME-Version: 1.0
In-Reply-To: <b343fea6-ecf2-7605-9340-decdd1b95149@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 09:16:38
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: eperezma@redhat.com, qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 09:53:03AM +0800, Jason Wang wrote:
> > Maybe it would be good too that vhost provides real 4k-aligned addresses (in
> > vhost_iotlb_miss)?  My understanding is that PCI_ATS_CAP_PAGE_ALIGNED will be
> > more compatible than without the bit set.
> 
> 
> Yes, I've considered this. But the problem is that:
> 
> 1) vhost itself can generate unaligned request (since its IOTLB doesn't have
> any alignment requirement)
> 2) the IOTLB miss processing in qemu doesn't do anything with ATS, we
> shortcut PCI by calling the address_space_get_iotlb_entry()
> 
> So I'm not quite sure it's worth to do that consider we don't emulate ATS
> via PCI actually :)

True. :) Though we still need to make sure e.g. each translate() iommu op will
drop those bits properly, but I agree that should be trivial.

-- 
Peter Xu


