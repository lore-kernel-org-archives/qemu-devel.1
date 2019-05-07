Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993EFC004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61BBC20825
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 15:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="P0NmBCU8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61BBC20825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48862 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hO2E5-0000qD-Lu
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 11:41:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36396)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hO2D0-0000Gw-7z
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:40:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hO2Cz-0001sK-4x
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:40:46 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43483)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hO2Cy-0001qX-W0
	for qemu-devel@nongnu.org; Tue, 07 May 2019 11:40:45 -0400
Received: by mail-ot1-x344.google.com with SMTP id i8so5628350oth.10
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 08:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
	b=P0NmBCU8zUOfaF8xaYZsuZ8crvxFB33fl7wDNB9MZv5fgE9bufZ9uXOFacVBRIyhyk
	7jy7cEut0ZZu1RaoDtrr50BVaB/CX/skGeBOtXxoGAGKW89ZemgDpFwl6g0BCyZNTY71
	c96Bv/+lzcoe4YYcd5EMePUR4gTK7GrAqK6itLr2obeqWzYKb3Dql3mDDHzIv1x+/JnT
	zIvYGvdBDonXfV8sEZV0PvMIvA63l1OoRV+8kWQPCfuhVRSXMOb+jYMxWFhFzCGAXSHH
	RES21PeWYeTfPIbRNgVP3JVS3PVW0F6JNq0X1vpUrTbfXgSQ4Ev5ZlVumch1kGRMghci
	mHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=eDjq30ddseBaIw6socWxfPv6NTtk+5QW4X1Ug5iEyJk=;
	b=UhpAG/hV6fbn/qzf1wtAzLPzAtYRTA1NeKymDqIua5FTrj3yG/HVStUIPei69egYoO
	NVpURAvQlpdwzudqcXRU6OxpDtOkD0Ip4WtgU7hkSn380T+d5AwNq2mavtSzvNQQrx6V
	wxbI5ORcN68WfNQD7FtsutcHKGFqFjL7EAOg6TyWBcRBWlB/wIXNd9NUWUw5PTFqid4r
	2BPVDG2L3PwGVXnHy9+prhMteZiJ1bOZFgwuuKNMgDiGZscYfKm967CA77dd2Q5n1zMp
	/2G0Hj1EkcNmS2HRmbwB+vDk/1a9B43mGxCs2lw+9hrxyEc6tiG8VcS1LeHH5Aj/A649
	R32g==
X-Gm-Message-State: APjAAAWzK+J91EHrL0rgawHlKAcgkuDyYKDUCpYBN6jV5T+xUsOxZ/YH
	4A+tTr89rMsRdyICp+yTl3kSvnEBajc5D6URMFh9Tg==
X-Google-Smtp-Source: APXvYqxgIWANkc/KHq9kAogc8tqlkqRrOccsWEIKbqAeeZcNH5LiQg3MPoGwMh9hdCCYG0LuKCXgqpIi0akzNLzuZFI=
X-Received: by 2002:a9d:222c:: with SMTP id o41mr22033787ota.353.1557243640877;
	Tue, 07 May 2019 08:40:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190426050039.17460-1-pagupta@redhat.com>
	<20190426050039.17460-4-pagupta@redhat.com>
In-Reply-To: <20190426050039.17460-4-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Tue, 7 May 2019 08:40:30 -0700
Message-ID: <CAPcyv4hRdvypEj4LBTMfUFm80BdpRYbOugrkkj-3Kk_LErXPqQ@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v7 3/6] libnvdimm: add dax_dev sync flag
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
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>, david <david@fromorbit.com>,
	Qemu Developers <qemu-devel@nongnu.org>,
	virtualization@lists.linux-foundation.org,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Ross Zwisler <zwisler@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
	Dave Jiang <dave.jiang@intel.com>,
	linux-nvdimm <linux-nvdimm@lists.01.org>,
	Vishal L Verma <vishal.l.verma@intel.com>,
	David Hildenbrand <david@redhat.com>, Matthew Wilcox <willy@infradead.org>,
	Christoph Hellwig <hch@infradead.org>,
	Linux ACPI <linux-acpi@vger.kernel.org>, jmoyer <jmoyer@redhat.com>,
	linux-ext4 <linux-ext4@vger.kernel.org>,
	Len Brown <lenb@kernel.org>, kilobyte@angband.pl,
	Rik van Riel <riel@surriel.com>, yuval shaia <yuval.shaia@oracle.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Paolo Bonzini <pbonzini@redhat.com>, lcapitulino@redhat.com,
	Kevin Wolf <kwolf@redhat.com>, Nitesh Narayan Lal <nilal@redhat.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
	"Darrick J. Wong" <darrick.wong@oracle.com>,
	"Rafael J. Wysocki" <rjw@rjwysocki.net>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-xfs <linux-xfs@vger.kernel.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Apr 25, 2019 at 10:02 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_SYNC' flag which is set
> for nd_region doing synchronous flush. This later
> is used to disable MAP_SYNC functionality for
> ext4 & xfs filesystem for devices don't support
> synchronous flush.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
[..]
> diff --git a/include/linux/dax.h b/include/linux/dax.h
> index 0dd316a74a29..c97fc0cc7167 100644
> --- a/include/linux/dax.h
> +++ b/include/linux/dax.h
> @@ -7,6 +7,9 @@
>  #include <linux/radix-tree.h>
>  #include <asm/pgtable.h>
>
> +/* Flag for synchronous flush */
> +#define DAXDEV_F_SYNC true

I'd feel better, i.e. it reads more canonically, if this was defined
as (1UL << 0) and the argument to alloc_dax() was changed to 'unsigned
long flags' rather than a bool.

