Return-Path: <SRS0=TBk9=V5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B631C433FF
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:18:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DBF720665
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2019 08:18:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DBF720665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ht6IT-0005zo-B2
	for qemu-devel@archiver.kernel.org; Thu, 01 Aug 2019 04:18:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50169)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <cohuck@redhat.com>) id 1ht6I6-0005Zu-E7
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:18:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ht6I5-00017L-Fo
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:18:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49074)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ht6I5-000172-8P
 for qemu-devel@nongnu.org; Thu, 01 Aug 2019 04:18:25 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A21A77E424;
 Thu,  1 Aug 2019 08:18:23 +0000 (UTC)
Received: from gondolin (dhcp-192-181.str.redhat.com [10.33.192.181])
 by smtp.corp.redhat.com (Postfix) with ESMTP id ED405600D1;
 Thu,  1 Aug 2019 08:18:15 +0000 (UTC)
Date: Thu, 1 Aug 2019 10:18:13 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190801101813.75391e35.cohuck@redhat.com>
In-Reply-To: <20190731150448-mutt-send-email-mst@kernel.org>
References: <20190729125755.45008-1-slp@redhat.com>
 <a43acc8541c7ae811d65eb4d08e1a08333781282.camel@redhat.com>
 <20190730133546.056f8b19.cohuck@redhat.com>
 <09e5ceb5e7c03f74f05307a3b9f9a4df035ff74f.camel@redhat.com>
 <20190730151400.20686a5b.cohuck@redhat.com>
 <20190730160605-mutt-send-email-mst@kernel.org>
 <20190731155551.4bb57ec3.cohuck@redhat.com>
 <20190731150448-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.27]); Thu, 01 Aug 2019 08:18:23 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] virtio-mmio: implement modern (v2)
 personality (virtio-1)
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
Cc: peter.maydell@linaro.org, Andrea Bolognani <abologna@redhat.com>,
 Sergio Lopez <slp@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 15:06:11 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 31, 2019 at 03:55:51PM +0200, Cornelia Huck wrote:
> > On Tue, 30 Jul 2019 16:18:52 -0400
> > "Michael S. Tsirkin" <mst@redhat.com> wrote:

> > > Make sure your guests
> > > are all up to date in preparation to the day when legacy will go away.  
> > 
> > If legacy goes away, legacy guests will be busted anyway :)  
> 
> It'll take a while for it to go away. But we can try to
> push guests in the direction of coding up modern
> support e.g. by forcing modern by default.

Actually, ccw defaulted to transitional devices right back when we
introduced support for virtio-1 - starting with QEMU 2.5.

I'm not sure how many (if any) supported guest OSs (various variants of
Linux) support virtio-ccw devices in legacy mode only. We can probably
neglect that issue, but I would not really complain if someone
submitted a patch to optionally turn off legacy support for ccw.

