Return-Path: <SRS0=6NMj=TN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ADEDC04AB1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4C869208CA
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="MeRY+QdG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4C869208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:32864 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQF9B-0007HU-Kq
	for qemu-devel@archiver.kernel.org; Mon, 13 May 2019 13:53:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hQF8F-0006sQ-K4
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:53:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hQF8D-0006yj-EO
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:52:59 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hQF8B-0006uE-F7
	for qemu-devel@nongnu.org; Mon, 13 May 2019 13:52:56 -0400
Received: by mail-oi1-x242.google.com with SMTP id t187so6704608oie.10
	for <qemu-devel@nongnu.org>; Mon, 13 May 2019 10:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Y9X01Pkq0XXte5z0O4rYu6NU6lcDo0STfPmFKCJpwI4=;
	b=MeRY+QdGFjfDKUSuf7dAOysOfrk9IX/j0cXEQeRSHYHXItna9fFtGcb80/8yDKWYkg
	kEPTsia824fjKznGv99pekCCmDAbBmu8zC8ES2wNtrw9iGNZzpMC40Dc0waTtukABlou
	DiMjy3wekDMZv+rEku5zj5N9lua8h+E9NR26CrKLNtsmzHWBp5Dk25a7+ZFTFlXvp5bn
	CKgC360dEZCMTiYCVvVNHBz83ANXriwcLt3Kp71GNpJ+aE+ylpXoUdrY8187QZo8pUjo
	MSFx+LZTKoW3yj60OEeZpgD+/UaXJIXSDimXFG17gPEeJljKEDt4VY/2RYHjnGTmH4Sh
	vvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Y9X01Pkq0XXte5z0O4rYu6NU6lcDo0STfPmFKCJpwI4=;
	b=QPxKW58jo7gv1o5S+bblaCbTF7QNahphLhQs8gk4YpaoYOlRbIpGDILp+D7qJQJnmA
	YhHuiWWX9nMPcJfIqAtYm1C4tyEm2nUd+Yo1G5fMgS5pMsccKYxofrjU4jetz2vcaHwV
	4IUMMqyx+jVD7lJKp203BUgebfiaIFNVVRdvUs19FBwy9STMDOkLMxOo1kSbPX8jb2cK
	hSSQ/wS1irXEpt8QIfJV3/5Py0+yKIv212sXWLDPrDwIbXyAlghycC8JJv3AGB04QDn2
	Cmn7zVCOFaTBRWbX5buiIW2dO/aBmfAihxFp+rNveFJVqrbwH0dAqnY6pns9Ezf4JCjj
	F5ig==
X-Gm-Message-State: APjAAAWUJQCh4shgZga7MrYc//muPJnd3K4vh80HriYTbk5/32+OWV8d
	twd0/v4SOtI+xlptxK/tUzYgjkWhnlxs5YE1NrwjGw==
X-Google-Smtp-Source: APXvYqyHlb4HK4pDjcMSgSQt8NqfXMPz+kR7QQEkSBVnAow9XkYo/o3V5df/EMWF1DvMzRr9ptTlw2tfnEJV3YCdJtY=
X-Received: by 2002:aca:dfc4:: with SMTP id w187mr254128oig.70.1557769970924; 
	Mon, 13 May 2019 10:52:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-4-pagupta@redhat.com>
	<CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
	<864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
	<CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
	<2003480558.28042237.1557537797923.JavaMail.zimbra@redhat.com>
	<116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
In-Reply-To: <116369545.28425569.1557768748009.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 13 May 2019 10:52:39 -0700
Message-ID: <CAPcyv4genJtCt6dp6N07_6RfPTwC6xXMhLp-dr0GWQy5q52YoA@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::242
Subject: Re: [Qemu-devel] [PATCH v8 3/6] libnvdimm: add dax_dev sync flag
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>, jstaron@google.com,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, Adam Borowski <kilobyte@angband.pl>,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>, cohuck@redhat.com,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 13, 2019 at 10:32 AM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
> Hi Dan,
>
> While testing device mapper with DAX, I faced a bug with the commit:
>
> commit ad428cdb525a97d15c0349fdc80f3d58befb50df
> Author: Dan Williams <dan.j.williams@intel.com>
> Date:   Wed Feb 20 21:12:50 2019 -0800
>
> When I reverted the condition to old code[1] it worked for me. I
> am thinking when we map two different devices (e.g with device mapper), will
> start & end pfn still point to same pgmap? Or there is something else which
> I am missing here.
>
> Note: I tested only EXT4.
>
> [1]
>
> -               if (pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX)
> +               end_pgmap = get_dev_pagemap(pfn_t_to_pfn(end_pfn), NULL);
> +               if (pgmap && pgmap == end_pgmap && pgmap->type == MEMORY_DEVICE_FS_DAX
> +                               && pfn_t_to_page(pfn)->pgmap == pgmap
> +                               && pfn_t_to_page(end_pfn)->pgmap == pgmap
> +                               && pfn_t_to_pfn(pfn) == PHYS_PFN(__pa(kaddr))
> +                               && pfn_t_to_pfn(end_pfn) == PHYS_PFN(__pa(end_kaddr)))

Ugh, yes, device-mapper continues to be an awkward fit for dax (or
vice versa). We would either need a way to have a multi-level pfn to
pagemap lookup for composite devices, or a way to discern that even
though the pagemap is different that the result is still valid / not
an indication that we have leaked into an unassociated address range.
Perhaps a per-daxdev callback for ->dax_supported() so that
device-mapper internals can be used for this validation.

We need to get that fixed up, but I don't see it as a blocker /
pre-requisite for virtio-pmem.

