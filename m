Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400FFC433FF
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 08:44:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 165432086D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 08:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 165432086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huv4f-00025b-EO
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 04:44:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55427)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1huv4I-0001el-Jf
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 04:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1huv4H-0002Eb-FH
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 04:43:42 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:36542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1huv4H-0002EL-BD
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 04:43:41 -0400
Received: by mail-qk1-f195.google.com with SMTP id g18so62239460qkl.3
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 01:43:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BocFPi1bejeP7eSaghcwTBfuwxPlrtw31VaIzxABJ4E=;
 b=t6GFXktpG6eZ3aSw7KIfccLrdzzsgGrj8J8jIAmJaSCi2aG8q037pUoEir3L5bLIT5
 DUTPntE88Zw6eS/fDhLzGoYZm3TKigf1tMIlAjQbmqJmvGDrhsMXQMdjYYrVzr2ZEyY6
 9VwmSzoneZWDHC4RlwAg2/NrCjZA7iVX7Mtdhvnjcb1GsUTMa180uw0LHl9P8khGwjol
 gWUZWP8MU68pFiW4it6ZotRI4jmzAH7VKDV5wM0f04xxNSxZoiwhUTR/iVbH7w0y9ssU
 OAX4s2+7cM3166JhIPRMjPUKZUq5xu1e/D14E6bLIi3CeNVmJ8zGeafMKhR7zJO0NLqn
 +fxg==
X-Gm-Message-State: APjAAAX1jDsA/5BwFSaqCb98moBMQkH3MV65iQP2KqAdkhoXGv/hPpGW
 pGWRbRxYFEq2/2yyJYDEjvQthg==
X-Google-Smtp-Source: APXvYqwFysZr8yzI3GC56WwUoLvoto/sygyuEHe7e4FjeN/t71o8QBvrML04HCI3na6b0y7ukBX+dw==
X-Received: by 2002:a05:620a:16d6:: with SMTP id
 a22mr2151711qkn.414.1565081020445; 
 Tue, 06 Aug 2019 01:43:40 -0700 (PDT)
Received: from redhat.com ([147.234.38.1])
 by smtp.gmail.com with ESMTPSA id m5sm35342053qkb.117.2019.08.06.01.43.38
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 06 Aug 2019 01:43:39 -0700 (PDT)
Date: Tue, 6 Aug 2019 04:43:35 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20190806043953-mutt-send-email-mst@kernel.org>
References: <20190802150605.5880-1-jfreimann@redhat.com>
 <20190802112047-mutt-send-email-mst@kernel.org>
 <20190805131215.c6cl3lgvcpnzfx3x@jenstp.localdomain>
 <20190805102148-mutt-send-email-mst@kernel.org>
 <20190805184949.kmv7qra67jfxie2j@jenstp.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805184949.kmv7qra67jfxie2j@jenstp.localdomain>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.222.195
Subject: Re: [Qemu-devel] [PATCH v2 0/9] add failover feature for assigned
 network devices
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

On Mon, Aug 05, 2019 at 08:49:49PM +0200, Jens Freimann wrote:
> On Mon, Aug 05, 2019 at 10:22:25AM -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 05, 2019 at 03:12:15PM +0200, Jens Freimann wrote:
> > > On Fri, Aug 02, 2019 at 11:22:10AM -0400, Michael S. Tsirkin wrote:
> > > > On Fri, Aug 02, 2019 at 05:05:56PM +0200, Jens Freimann wrote:
> > > > > This is implementing the host side of the net_failover concept
> > > > > (https://www.kernel.org/doc/html/latest/networking/net_failover.html)
> > > > >
> > > > > Changes since v1:
> > > 
> > > [...]
> > > 
> > > > Didn't read this yet, one question: how do migration commands look
> > > > like?
> > > 
> > > You mean the hmp commands I think:
> > > 
> > > migrate -d tcp:host:port
> > > 
> > > and to cancel
> > > 
> > > migrate_cancel
> > > 
> > > 
> > > regards,
> > > Jens
> > 
> > Sorry, no. I mean the command line on the incoming side.
> 
> It looks the same with -incoming tcp:0:4444 added. Pci address of
> vfio-pci device can be changed.


Sounds good. And I assume one can also skip the vfio device and
hotplug it later, right?


> > 
> > -- 
> > MST
> > 

