Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAF8C17460
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:51:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87A6B21882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 12:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87A6B21882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iRyIn-000526-Hz
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 07:51:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33046)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peterx@redhat.com>) id 1iRyHe-00046h-1U
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:50:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peterx@redhat.com>) id 1iRyHd-0001o8-3J
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:50:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50460)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <peterx@redhat.com>) id 1iRyHc-0001ni-Tn
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 07:50:05 -0500
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BFBCD59465
 for <qemu-devel@nongnu.org>; Tue,  5 Nov 2019 12:50:03 +0000 (UTC)
Received: by mail-qk1-f198.google.com with SMTP id 125so21072270qkj.12
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 04:50:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=EdlBg8P4PzJeKJFbp0I86fI5VuI9JKDso5/u4JeQ6D4=;
 b=GttFxQBZlxFTXxWBkMqVyrE6rAh7V3RFElvli6L8AeuDdPq/YbOdNk3w4QhWV3s3Xg
 IIX+eg4U36oPVx27PLuuE/QKMPP6wJ4CpS1K+oZbA9t8Os11ftCb9rYy6HncBVGFPKgI
 S0iNmhxxxHv61Fbe74al2tjyqQbguqZ9ap0KbyVTATV24Kj6cj2Amo5PMMtx2hryliZq
 YOT19z+3cXirMZVpPXiZ6JP4v3QkRzrcAX24q7fP/bdVydz3SrQlYQ/G38zu/ccH4AQe
 ZoK9rjnhuXMgCVjezdA/DgFxWIj6MvOmDpy56KT8bOCcFcaAMiLmy0981FViJZptK8vI
 cEGA==
X-Gm-Message-State: APjAAAVbrbHEMenKY64z7fXW68hNX+hfzm2W9nZRZyX96ywxlbijz/lO
 k/qvXYsbbs9gszejpDXKimyrzq2jE//mdhxKHK9wpFYxYZedoOQvqL6TOgZT23sBwD2hafD0WiA
 49J1W4r9rh+L3wCc=
X-Received: by 2002:a37:5645:: with SMTP id k66mr22949996qkb.368.1572958203023; 
 Tue, 05 Nov 2019 04:50:03 -0800 (PST)
X-Google-Smtp-Source: APXvYqxNgDCdQhbyW5Bg3iAlgavvicLqR0KlhK13lkvdyXE46MczwtzIs7/LQPhvcX0Ad3wZNod/ag==
X-Received: by 2002:a37:5645:: with SMTP id k66mr22949975qkb.368.1572958202779; 
 Tue, 05 Nov 2019 04:50:02 -0800 (PST)
Received: from xz-x1 ([104.156.64.74])
 by smtp.gmail.com with ESMTPSA id o201sm9375290qka.17.2019.11.05.04.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Nov 2019 04:50:02 -0800 (PST)
Date: Tue, 5 Nov 2019 07:50:00 -0500
From: Peter Xu <peterx@redhat.com>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Subject: Re: [RFC v2 03/22] intel_iommu: modify x-scalable-mode to be string
 option
Message-ID: <20191105125000.GE12619@xz-x1>
References: <1571920483-3382-1-git-send-email-yi.l.liu@intel.com>
 <1571920483-3382-4-git-send-email-yi.l.liu@intel.com>
 <20191101145753.GC8888@xz-x1.metropole.lan>
 <A2975661238FB949B60364EF0F2C25743A0EE30A@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C25743A0EE30A@SHSMSX104.ccr.corp.intel.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: "Tian, Kevin" <kevin.tian@intel.com>,
 "jacob.jun.pan@linux.intel.com" <jacob.jun.pan@linux.intel.com>,
 Yi Sun <yi.y.sun@linux.intel.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>, "Tian, Jun J" <jun.j.tian@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Sun, Yi Y" <yi.y.sun@intel.com>,
 "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Nov 05, 2019 at 09:14:08AM +0000, Liu, Yi L wrote:
> > Something like:
> > 
> >   - s->scalable_mode_str to keep the string
> >   - s->scalable_mode still as a bool to cache the global enablement
> >   - s->scalable_modern as a bool to keep the mode
> > 
> > ?
> 
> So x-scalable-mode is still a string option, just to have a new field to store it?

Yep.  I'd say maybe we should start to allow to define some union-ish
properties, but for now I think string is ok.

-- 
Peter Xu

