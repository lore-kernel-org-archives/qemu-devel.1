Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2472C32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A7502206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 14:05:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7502206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxXQi-0007pu-0o
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 10:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36181)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peterx@redhat.com>) id 1hxXPt-0006sL-3i
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1hxXPr-0004EZ-Q6
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:04:48 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35704)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1hxXPq-0004DW-TK
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 10:04:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id l2so1566117wmg.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 07:04:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=LZGsJdv8TTubV6jlGisFQe+cAbHq47gaW5sP8Xrxxuc=;
 b=m4vXacjNbf04lKMYhgfP5iWzzjQ7SbkWftrzOu3ep3qFJx4I4CBVFcgqhPiqAW/R0Z
 315bOhBdTqaotMK9+mdEVSp5aSIsgfR6wQVlZD2LdmkQ6QwpknXidliZsT60dwRoIwB+
 nSKeC46r0Ac4wjkI8EZS9MQR8VznydTqWvoS/koCibYAAyh2f8crVwQldCwuiBu8VNpo
 6OSdU9uA5goz7ZDQ7lLHP4SSuIPQXaveu/zrDjwE5e4ZcDphkIv4gk4qIHSNFCrLh/tw
 mG+H/oxpEZjw5fUlJ3K1haAcaZCtjL4M3JPJbAU0BFKxJmRMyPtawBAMW3QL0edsNEaq
 r2vA==
X-Gm-Message-State: APjAAAU8yVcr9nAWB54+S+SjdKXCIblAZJSf2/QNAKi8JjQeGmUKBhpT
 +AW7xfozVx9zQBSw7Du38aoOCQ==
X-Google-Smtp-Source: APXvYqybff26QqavMRPxto7o3qIXe5nTprqYad81F0V5uN2f4idUkK1Ho8/uI4YQJjTvd7GZiICRlQ==
X-Received: by 2002:a7b:c85a:: with SMTP id c26mr3308709wml.77.1565705084356; 
 Tue, 13 Aug 2019 07:04:44 -0700 (PDT)
Received: from xz-x1 ([195.112.86.171])
 by smtp.gmail.com with ESMTPSA id c8sm4468559wrn.50.2019.08.13.07.04.42
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 13 Aug 2019 07:04:43 -0700 (PDT)
Date: Tue, 13 Aug 2019 16:04:42 +0200
From: Peter Xu <peterx@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Message-ID: <20190813140442.GA8677@xz-x1>
References: <20190812074531.28970-1-peterx@redhat.com>
 <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <319f1d6a-ef55-cc1b-98d6-f99b365bd88a@redhat.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.66
Subject: Re: [Qemu-devel] [PATCH RFC 0/4] intel_iommu: Do sanity check of
 vfio-pci earlier
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
Cc: Alex Williamson <alex.williamson@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, Bandan Das <bsd@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 04:41:49PM +0800, Jason Wang wrote:
> Do we need a generic solution other than an Intel specific one?

I assume you're asking about ARM not AMD, right? :)

Yes I think we should have a generic solution.  Though I'd like to see
whether this idea can be accepted first, then we can expand to ARM or
other IOMMUs.  After all we've got some existing duplications already
between at least x86 and arm on vIOMMU so we can actually do more
things like that when time comes.

Thanks,

-- 
Peter Xu

