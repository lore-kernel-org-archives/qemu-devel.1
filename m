Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214AFC4363A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:32:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E5E246C6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 11:32:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NDtZF3tW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5E246C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXjgR-0007u1-Lc
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 07:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49840)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXjfa-0007J9-Mw
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46835)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kXjfW-0004mh-UT
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 07:31:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603884661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=35+8XpEhiBzAcqTRMxXgOAJkP51u07bMPpxjJhHGR+o=;
 b=NDtZF3tW3Ic/Elwy6Z5iMMxOrqmCQNRUL33i/lQhuJf1/+o0pR4AP53bPV4wsQC3wmTX7/
 Zq6SdkILUQPAwcPdyBEKxK3dY5/QieTG8vXoup+ok1dZFNg3bciTeyQlPNFxixSzdtE8nb
 bcAdH+RQZK5dO1YXBJWJyL4USi1FWhc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-CY1QtzXVPnuFvFvsmaSARg-1; Wed, 28 Oct 2020 07:31:00 -0400
X-MC-Unique: CY1QtzXVPnuFvFvsmaSARg-1
Received: by mail-wm1-f70.google.com with SMTP id l17so889026wmb.0
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 04:31:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=35+8XpEhiBzAcqTRMxXgOAJkP51u07bMPpxjJhHGR+o=;
 b=PL5OJg3x5rxTvnsDsBRsh5m/KaCI6l9Io60lpVgVKtK+pcMThKuPPGVwdBmxNOUdNv
 x0Zo8vxtBrLqAFwLVpa4D70qBXmR9t0aX9vZmaYJMZxIOJIDaiIv8+JLTFrG8j3w3vjJ
 ikic1NqZcxEij6fpMpfS8FEl1lK9+5E3qpLe6/ynIqiCTprY+4I75OhR6T/bDmVdMaFn
 Jl+13qaQmpC5pZv+mVYK62l+3kKN9LW9XnJRAGnBWaN9He3AiIqQOBZIYl6/O43ZZ2cc
 dwvrZNWpFl/WJEHWeE10BPinaAKNrKjjmM8J6fP5kiM0xl/VtYWj+xblIPMOfhQ2axnt
 Ahwg==
X-Gm-Message-State: AOAM532y8fuNlThFswNOQnpijT5oZHIWQ9+BdKJeOfRydjmMcNRSD4dZ
 fCusqiNlRemNsgijPAuAwV2ZoYvSnog23HWjTsrlizF+XraD0QuCVMx7a1M0pu0pOq8KwtzMh40
 3yi7NG3XCMr3WXng=
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr7612234wmi.59.1603884659045; 
 Wed, 28 Oct 2020 04:30:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoDvij9vpE30FEKkrHffWg6Hreb91GhghNA0FMar7kxEHU5fWzHxyGj+FCYllhH9eMZ8BlGA==
X-Received: by 2002:a7b:cb8d:: with SMTP id m13mr7612205wmi.59.1603884658859; 
 Wed, 28 Oct 2020 04:30:58 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id t5sm7123624wrb.21.2020.10.28.04.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2020 04:30:58 -0700 (PDT)
Date: Wed, 28 Oct 2020 07:30:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH] virtio: skip guest index check on device load
Message-ID: <20201028072812-mutt-send-email-mst@kernel.org>
References: <20201026151328.77611-1-felipe@nutanix.com>
 <20201027113049.GH79063@stefanha-x1.localdomain>
 <20201027082337-mutt-send-email-mst@kernel.org>
 <12146644-5D22-4CAC-9B4F-F16E84ED56AE@nutanix.com>
 <20201027085447-mutt-send-email-mst@kernel.org>
 <AE57D4EC-2C3C-4C22-9203-38A61D87B31F@nutanix.com>
 <20201027090420-mutt-send-email-mst@kernel.org>
 <20201028110038.GE221115@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20201028110038.GE221115@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 01:51:10
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>, Felipe Franciosi <felipe@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Oct 28, 2020 at 11:00:38AM +0000, Stefan Hajnoczi wrote:
> On Tue, Oct 27, 2020 at 09:04:46AM -0400, Michael S. Tsirkin wrote:
> > It's not a waste of time, it's just a lot of work
> > within guests.
> 
> Luckily it does no harm to set the NEEDS_RESET bit even if the guest
> doesn't handle it.
> 
> If the guest driver is unaware it may continue to submit requests to the
> device for a while. The device emulation code stops accepting new
> requests though. This means the device will become unresponsive until
> reset, which is not ideal but okay in the case where the device was put
> into an invalid state.

There is no actual rule that device must stop processing requests.
Driver can only assume that is the case after it started the
actual reset.


> I agree that supporting NEEDS_RESET transparently inside guests is
> difficult. The driver needs to reset and resume the device without
> reporting errors to applications. In some cases drivers may not have
> enough state in order to do that. It's also tricky to test all code
> paths. I guess this is why no one has done it: drivers shouldn't enter
> the NEEDS_RESET state anyway and handling it is complex.
> 
> Stefan



