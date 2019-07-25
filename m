Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5727AC761A8
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FC9A22C97
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:43:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2FC9A22C97
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbDX-0000Uo-Dg
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:43:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36581)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mst@redhat.com>) id 1hqbDN-000051-Lw
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:43:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1hqbDL-0005Fn-Vz
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:43:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43460)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1hqbDL-0005Dk-NP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:43:11 -0400
Received: by mail-qt1-f193.google.com with SMTP id w17so4231071qto.10
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 03:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=TrS86SE0qjd0OZbSrgVZc7yMtYGXrfuajj37GFGFZ+4=;
 b=BSEqz86Byw955cH6AJqOwqmHx0kYmVqXHFwrh4G222IHrmqlQwpcvPocAbf/GCbItm
 +9+oTWWmguG54LWlRV7XrS3ixM/KynPhlZvzUCvuS4F7VNpSOrIL/fNQcWiYK81KrHnw
 Hkepr9CtwMmntdT7LZHIE+GqHsQrzg1JCiotkxG70t9F7yNSuqlrDjW9nuMBo3IUZfuU
 dfWC21S0fjpCszwFhnXVAyBuu3oMu9yI+Afllnx5+s8SfnkC95jXnFNXrP1V4mmpeRG+
 Nqp6ooY7eBVvGJL9qMIlWSNpd3SOp0j7a3xmiTj0uaToTlYD9G8tz4PHqLI0BNBCnXML
 /gKg==
X-Gm-Message-State: APjAAAUvhLgV0U/SubfArDKwT2xm6cX+HywgJ9FzHZqyjg7oToWyuau4
 okm0V4gmRmP7NqlqnDuwiie+jQ==
X-Google-Smtp-Source: APXvYqwA+5g1qJ3R6lEiYJzRBv4MsHAV7NrXbI/S0bqzmstvX/EX4wC7ub79rlSRyNeBmHEoR1Nk1A==
X-Received: by 2002:a05:6214:1312:: with SMTP id
 a18mr62529587qvv.241.1564051389528; 
 Thu, 25 Jul 2019 03:43:09 -0700 (PDT)
Received: from redhat.com (bzq-79-181-91-42.red.bezeqint.net. [79.181.91.42])
 by smtp.gmail.com with ESMTPSA id
 r17sm22755065qtf.26.2019.07.25.03.43.06
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 03:43:08 -0700 (PDT)
Date: Thu, 25 Jul 2019 06:43:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <zhexu@redhat.com>
Message-ID: <20190725064244-mutt-send-email-mst@kernel.org>
References: <155364082689.15803.7062874513041742278.stgit@gimli.home>
 <20190329104904.450fefef@x1.home>
 <dbe614f5-47c8-b05d-dd73-2fbcd1579ae3@amd.com>
 <20190723112618.0efafa8d@x1.home> <20190724071439.GB18771@xz-x1>
 <20190724040837-mutt-send-email-mst@kernel.org>
 <20190724100331.GA14454@xz-x1> <20190724084355.627d44cf@x1.home>
 <20190725063733.GH14454@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725063733.GH14454@xz-x1>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.160.193
Subject: Re: [Qemu-devel] [RFC PATCH] pci: Use PCI aliases when determining
 device IOMMU address space
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
Cc: "Singh, Brijesh" <brijesh.singh@amd.com>, "Suthikulpanit,
 Suravee" <Suravee.Suthikulpanit@amd.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 25, 2019 at 02:37:33PM +0800, Peter Xu wrote:
> After re-read Michael's reply, I feel like what Michael suggested is
> that we can simply ignore the bus-number-change case by the guest OS
> for now, but I might be wrong.
That's what I suggested, yes.

