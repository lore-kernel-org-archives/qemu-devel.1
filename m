Return-Path: <SRS0=QiA4=7D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9022BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:08:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45FCA2072C
	for <qemu-devel@archiver.kernel.org>; Thu, 21 May 2020 15:08:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UAiywxsH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45FCA2072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbmnh-00023C-HK
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 11:08:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37828)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jbmn3-0001Zc-ON
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:07:21 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56368
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1jbmn2-00077e-II
 for qemu-devel@nongnu.org; Thu, 21 May 2020 11:07:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590073639;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zQJETzXyz/V9p2J0hvFtxedZlf6GFP+iOHyQJ1Hy8jY=;
 b=UAiywxsHX+a+ul4+7+JWDzHtfEcfOi2tVgW/yreGklBJ5cnjBKuA7bhkA8EIUFxMeH+Xop
 KM8XMPqec7ivFyHGtvdqJiW2j1haqrriXge8IBJEK6w5iHGon4XqQfsSc6yErAxDvHj7s1
 oetMRBZWUcG4n7zxNspo0mow+5UuL8A=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-364-DqLHJmuqN4uJDPhhqhr-Xw-1; Thu, 21 May 2020 11:07:13 -0400
X-MC-Unique: DqLHJmuqN4uJDPhhqhr-Xw-1
Received: by mail-wm1-f69.google.com with SMTP id l26so1961077wmh.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 08:07:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=zQJETzXyz/V9p2J0hvFtxedZlf6GFP+iOHyQJ1Hy8jY=;
 b=GJT7sC49VjE3XUFaJMZ+iXCKu41ByJsfdKTG11EoU0YGWRrvQgLuAqLziqdLZbG1l9
 HCzuDVCZCRVZ0//z/BlJmhPENaovmP3h8XIg7Paoi0IAnQ0ljv34KZ/CZ9tEqWbABw9e
 NDfyJLHHHUT1cJjtDpMFzpkqyLQMEXLk4AKIDNiRi6lO/vQTLdWaV3ZVokLp2fFKbwuk
 5ZrMuMJOwJP+f+7BWVgIcju67IKamlmps+5lniZ3b8ye4VqMz4m4ujkOMnG9RkfnCLJy
 0KtEsSZIfBXpBYDVf/VSNekfqKsu77WC0cuu8tzp4iC8/ARH43zrhufK8XhNZwvpcOF7
 eMlw==
X-Gm-Message-State: AOAM530W9vlE6a/gtwYc0aeLr+xviEfVbrcOPWoS+2UYpPpq/57YKCgv
 4nyoXCm83owp/2apUb68EQIEiwkYQgFBsdowX3UUM/Wjccyj4rTgA+Lguq7FTId9U9CpVBKdpcu
 LHKxb/TQQL1FVr48=
X-Received: by 2002:a1c:4c3:: with SMTP id 186mr9195750wme.5.1590073632598;
 Thu, 21 May 2020 08:07:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGlalNsYKq8otYGjH5lvfVqlZ9wE8Nu2EgnTlWzCcsOCjjJOojr5mKx83tk3x0PcY2NFinyA==
X-Received: by 2002:a1c:4c3:: with SMTP id 186mr9195724wme.5.1590073632253;
 Thu, 21 May 2020 08:07:12 -0700 (PDT)
Received: from steredhat ([79.49.207.108])
 by smtp.gmail.com with ESMTPSA id h133sm7090442wmf.25.2020.05.21.08.07.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2020 08:07:11 -0700 (PDT)
Date: Thu, 21 May 2020 17:07:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 0/3] virtio: add vhost-user-vsock device
Message-ID: <20200521150709.fg3xjbkuhnyd7fbx@steredhat>
References: <20200515152110.202917-1-sgarzare@redhat.com>
 <20200521143559.GL251811@stefanha-x1.localdomain>
MIME-Version: 1.0
In-Reply-To: <20200521143559.GL251811@stefanha-x1.localdomain>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=sgarzare@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/21 01:47:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Julio Montes <julio.montes@intel.com>,
 Sebastien Boeuf <sebastien.boeuf@intel.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 21, 2020 at 03:35:59PM +0100, Stefan Hajnoczi wrote:
> On Fri, May 15, 2020 at 05:21:07PM +0200, Stefano Garzarella wrote:
> > This series add vhost-user-vsock base device and its PCI version
> > (vhost-user-vsock-pci).
> > The vhost-user-vsock device can be used to implement the virtio-vsock
> > device emulation in user-space.
> > An use case might be Kata, where they prefer to emulate devices
> > in user-space.
> 
> Looks good.
> 
> My main concern is live migration. If it hasn't been tested, please
> remove the live migration code.
> 

Right, I didn't test live migration with vhost-user-vsock.
I'll give it a try. If it doesn't work, I'll remove it.

Thanks for the review,
Stefano


