Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D8DC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6292620885
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 15:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WlEvnjRA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6292620885
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr1Py-0005ND-N2
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 11:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jr1PK-0004wb-JP
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:45:50 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50455
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1jr1PH-0003IX-3a
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 11:45:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593704745;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KERfCJPX8Xpwv3CIVOz74GuJ/tFpQ+OLN608kByojBE=;
 b=WlEvnjRAUTlF3ouoPwMWXWD3TjsjcRZ/O7QU2yJvQ9daaHxLSveZEtiJ1q/9dy+I7vKwOY
 p0/GD5T04pWVRJj9+wAORFTRD1HcNfH7p3UuR7DM/eDjWBc3pjc/NdDmOrgjHnNogV9vmz
 HzYLjAc2LoVObId3rjHnd3v6PHlxly0=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-3k7YBLgyODmtRBtwYQhKEQ-1; Thu, 02 Jul 2020 11:45:43 -0400
X-MC-Unique: 3k7YBLgyODmtRBtwYQhKEQ-1
Received: by mail-qt1-f198.google.com with SMTP id 71so11586216qte.5
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2020 08:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=KERfCJPX8Xpwv3CIVOz74GuJ/tFpQ+OLN608kByojBE=;
 b=KSNBYMQwF/EdEOrHdQ7gI94/QlzGtuFldMR4sMI+C+TN64wc5IrtZ0ZMKwkUh4xriB
 DjdYd7rtdEARbktdvwUach6Qpf1+7jpQ5jkWLu1o6q8IC6GLuiZmy7z8jda60ed3AUSH
 aPK0TUfh+Vj+l//7jZ+PsJcztqqQsvYyzY+3XoQ6QfZZrv+zc/fEC0a4cTL0HTfNa3Ff
 zRNGuzZVmXy2scL7UGmjR2JV3Dk924kHGHMlFVPCJ/Yi0lDli+VWSk7nySytiuiIk1vC
 wjIzv7utE70Q7s4kLNRQMK1bKSV/b7zxt6mJg7PmK9ja2xCfJn1x8RdXSC4BoSFPEqPq
 SYaQ==
X-Gm-Message-State: AOAM5315Tk02uu2UsoMh2vl+xYvh4xkPBpPlFvUej2Dc6r8FV10x9Adw
 YQkJSS7LYgdp7ZqvprHd1/5C7Cs0VRsMHHFznqSc9NNPPocJXle3yfA10GfD9bj8qfkjehzsk4A
 esU6WBAkbGsMUDn4=
X-Received: by 2002:a37:a758:: with SMTP id q85mr29468723qke.301.1593704743076; 
 Thu, 02 Jul 2020 08:45:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwf5gu7UwG4Dlhr41vbJtpDIYlNchQpcmzvymWPNUsWyZoRszin42Oqzkpe09NR10OFZUu4Bw==
X-Received: by 2002:a37:a758:: with SMTP id q85mr29468699qke.301.1593704742784; 
 Thu, 02 Jul 2020 08:45:42 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::2])
 by smtp.gmail.com with ESMTPSA id d53sm6807257qtc.47.2020.07.02.08.45.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2020 08:45:42 -0700 (PDT)
Date: Thu, 2 Jul 2020 11:45:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC v2 1/1] memory: Delete assertion in
 memory_region_unregister_iommu_notifier
Message-ID: <20200702154540.GI40675@xz-x1>
References: <20200626064122.9252-2-eperezma@redhat.com>
 <20200626212917.GD175520@xz-x1>
 <8cf25190-53e6-8cbb-372b-e3d4ec714dc5@redhat.com>
 <20200628144746.GA239443@xz-x1>
 <54d2cdfd-97b8-9e1d-a607-d7a5e96be3a1@redhat.com>
 <20200629133403.GA266532@xz-x1>
 <2589d0e9-cc5b-a4df-8790-189b49f1a40e@redhat.com>
 <20200630153911.GD3138@xz-x1>
 <69f6d6e7-a0b1-abae-894e-4e81b7e0cc90@redhat.com>
 <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ff9e7af0-18c4-57e8-fc94-904fdce1123a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=peterx@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:42:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Yan Zhao <yan.y.zhao@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 02, 2020 at 11:01:54AM +0800, Jason Wang wrote:
> So I think we agree that a new notifier is needed?

Good to me, or a new flag should be easier (IOMMU_NOTIFIER_DEV_IOTLB)?

-- 
Peter Xu


