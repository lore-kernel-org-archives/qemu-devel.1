Return-Path: <SRS0=PbUj=XF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BE52C49ED8
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E32A82089F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2019 15:34:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E32A82089F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7i9d-0006ve-U7
	for qemu-devel@archiver.kernel.org; Tue, 10 Sep 2019 11:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34806)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i7i8z-0006UB-QF
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:33:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i7i8y-0001OH-Ko
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:33:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:11593)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i7i8y-0001Nj-F3
 for qemu-devel@nongnu.org; Tue, 10 Sep 2019 11:33:24 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 5C94B6B
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 15:33:23 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id i9so20305693qtj.2
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2019 08:33:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mHZ8wNCQffS67q3H8gs6AeaXRC7rq28AUBP9+WBL0QY=;
 b=q0R//iIvd8R6ljVkl78krPTX/pJl0TF7BVbLR+MmE8ZXJYj9OmUIvhs+cBnTc6zQDT
 SRDYrXP/e6E33oAHcFtu/NP+MhGr2k2Ytw3G1lUZseK9DRT3QIhMnjhpBtS7TcBKD6aE
 GWz2Piib3LzOqvUT8oHrLLwBhQs0u9CrHFbH5UsCyUqYMfG3/0PBFYg4RD/j+aVav+0x
 4F69ymgOBFr0seQotcnDcbiGW+IG83fRBUNKN36OCqxe8v546yKQiMg7k5EbhqYVJRAx
 2+pEXb50SFdATttRrsNwFUAcyVf6ZfQN8gTQ0AuJ0Mgfvf6LbueX/40fd9E3ERGjjgaw
 R10g==
X-Gm-Message-State: APjAAAUp+TjomPBrBsEe/zuvmEUQyFhVq54BkJ4I6wenYy3xEcIpgmbU
 O90jSMk7lW4UwhvkUR4gNDLerw3G6dRK4ZFMRP7/rAoXD/+66CUEf2Vpgl24v2TfBEygSNYTyYL
 FJSa5dThDt/MvV0c=
X-Received: by 2002:a37:a411:: with SMTP id n17mr30325697qke.216.1568129602740; 
 Tue, 10 Sep 2019 08:33:22 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxdzVauc45z3hbnTbIe6f5uJtLSfd3X+K5OCsYPmjg+TpiA15lHk07BisMyIe2zSMN16yWDfw==
X-Received: by 2002:a37:a411:: with SMTP id n17mr30325687qke.216.1568129602608; 
 Tue, 10 Sep 2019 08:33:22 -0700 (PDT)
Received: from redhat.com ([80.74.107.118])
 by smtp.gmail.com with ESMTPSA id o38sm6132971qtc.39.2019.09.10.08.33.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Sep 2019 08:33:21 -0700 (PDT)
Date: Tue, 10 Sep 2019 11:33:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190910112937-mutt-send-email-mst@kernel.org>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
 <20190909160039.GC20875@stefanha-x1.localdomain>
 <d095bafedcd4bcc5d76279785e5bd523aef62b58.camel@sipsolutions.net>
 <20190910150319.GB31674@stefanha-x1.localdomain>
 <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e114b68dffecd9b4c4666327b15a28098c83f7ec.camel@sipsolutions.net>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 10, 2019 at 05:14:36PM +0200, Johannes Berg wrote:
> Is any of you familiar with the process of getting a virtio device ID
> assigned, and if so, do you think it'd be feasible? Without that, it'd
> probably be difficult to upstream the patch to support this protocol to
> user-mode Linux.

Sure, subscribe then send a patch to virtio-comment@lists.oasis-open.org

We do expect people to eventually get around to documenting the device
and upstreaming it though. If there's no plan to do it at all, you might
still be able to reuse the virtio code, in that case let's talk.

-- 
MST

