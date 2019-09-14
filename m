Return-Path: <SRS0=fVwN=XJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC609C4CEC9
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 19:41:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8ECD4206CD
	for <qemu-devel@archiver.kernel.org>; Sat, 14 Sep 2019 19:41:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8ECD4206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9DvY-0002ed-K8
	for qemu-devel@archiver.kernel.org; Sat, 14 Sep 2019 15:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59998)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1i9Duf-0001kQ-6N
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1i9Duc-0005eo-Ho
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:40:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36156)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1i9Duc-0005e1-Ct
 for qemu-devel@nongnu.org; Sat, 14 Sep 2019 15:40:50 -0400
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 572BBC057F88
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 19:40:48 +0000 (UTC)
Received: by mail-qt1-f200.google.com with SMTP id p56so10363013qtj.14
 for <qemu-devel@nongnu.org>; Sat, 14 Sep 2019 12:40:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bWyMGnIhqHppP3/mJiC/n+N5R0HC/vxhwnt6qngL+p8=;
 b=E79SnAXIJRnfJomyJQZZJeyVD6NcRDYJLiGQ8yJ9CMhkJz3h5VUSaWIeUVbxov3hX3
 462WvJ2b5MAdMh80KYeQNsEcPJKN2IvKn7A5IVh1M0ic9ut6ufqPMzcTdSDPLP+oHXlX
 YAmMYzXGiopDUWasNttKHBdlVeQD1okZIwb7gWPKrDx3AOWEqPzGbdtrljNpksPTgn5s
 EMJzNHEKGYZAuHc91bJ0uS1hhZb/xoLAhQw1lk99rgfm7/09DC0s+dRyJtohb9mmzeI2
 JJXX9ujD/aOon9Asl8mCupC9U06YyzI6V8LWPZFIq1By3k2BnylMSLkDC806xProkdoO
 RweQ==
X-Gm-Message-State: APjAAAWjaj0Tmd21IfOVMWtGuNGfAlAQyLF6G98jhwDEFZuBUSNeohL8
 BzBZ9MZNJJN6qtzWbBDBzu/WNIdFCYcX6a6e1rwvjPSEYn3DEuw05gIpa65DQO4cckIKuEubYtB
 akM30YrWB2DtwT/I=
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr14600415qkg.81.1568490047613; 
 Sat, 14 Sep 2019 12:40:47 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyYmoYDv3w/h2hoJtWIb81PD4qGFiPNW+RMRhmaXGrlkuwcs7Hd4N3idH/ACxJA8Biqg7KGmQ==
X-Received: by 2002:ae9:ed89:: with SMTP id c131mr14600408qkg.81.1568490047467; 
 Sat, 14 Sep 2019 12:40:47 -0700 (PDT)
Received: from redhat.com (bzq-79-176-40-226.red.bezeqint.net. [79.176.40.226])
 by smtp.gmail.com with ESMTPSA id k199sm15862445qke.45.2019.09.14.12.40.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Sep 2019 12:40:46 -0700 (PDT)
Date: Sat, 14 Sep 2019 15:40:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Wei Yang <richard.weiyang@gmail.com>
Message-ID: <20190914154026-mutt-send-email-mst@kernel.org>
References: <20190730003740.20694-1-richardw.yang@linux.intel.com>
 <20190913234746.jb5a5vlwl6cebudz@master>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190913234746.jb5a5vlwl6cebudz@master>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 0/2] refine memory_device_get_free_addr
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
Cc: imammedo@redhat.com, david@redhat.com,
 Wei Yang <richardw.yang@linux.intel.com>, ehabkost@redhat.com,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Sep 13, 2019 at 11:47:46PM +0000, Wei Yang wrote:
> On Tue, Jul 30, 2019 at 08:37:38AM +0800, Wei Yang wrote:
> >When we iterate the memory-device list to get the available range, it is not
> >necessary to iterate the whole list.
> >
> >1) no more overlap for hinted range if tmp exceed it
> >
> >v2:
> >   * remove #2 as suggested by Igor and David
> >   * add some comment to inform address assignment stay the same as before
> >     this change 
> >
> >Wei Yang (2):
> >  memory-device: not necessary to use goto for the last check
> >  memory-device: break the loop if tmp exceed the hinted range
> >
> > hw/mem/memory-device.c | 3 ++-
> > 1 file changed, 2 insertions(+), 1 deletion(-)
> >
> 
> Would someone take this patch set?

yes looks good to me too.
Eduardo?

> >-- 
> >2.17.1
> >
> 
> -- 
> Wei Yang
> Help you, Help me

