Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34F36C10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:52:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF1942077C
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 14:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="zi4I18XM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF1942077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEb4R-00038l-VZ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 10:52:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38511)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hEb3f-0002pB-4a
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:52:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hEb3d-00006T-Jo
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:52:07 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hEb3d-0008Rn-1k
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:52:05 -0400
Received: by mail-ot1-x342.google.com with SMTP id m10so5497079otp.2
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 07:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=HrHI1yUQh4ijcB7YHVwA9JPy3wKlBzvWJG6Efesd/f0=;
	b=zi4I18XMGtYXeCFOI7IgUdbB0EOZdbnJeoa3l20X2Gqlcl0YR55UhU5luYmUa6cHU5
	EqcmShYr64nYFlNtn7Rd+1lIJH9XABBmZCQPUOavNMLs+0n9I8m1OuY2+KD0JtN93YcX
	3rvvNLyeug/w5aNDC5fj4CjwQPXARfaplfRzq12KFQ4x2cbAHrzA+mENqSKh1c617RSg
	xlJAToPXjpLqe1zcSJodjCgmY5dhUdHQiVkQchFEI36jgwV1c+a/Zf73ibOfskPgdlC8
	PjhIrDB/UX3hLAtfZ9Gz/P0KisQxQ6VH57FKrSFjl+UerDKSD8YHx1TPbaLhBc3i7fUT
	dpzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=HrHI1yUQh4ijcB7YHVwA9JPy3wKlBzvWJG6Efesd/f0=;
	b=h77wX4OEKAm92ILk/gAMOqbIkIs4yetZbJyMIwIUMOMR0WKcRbIkFBskLfV1ig5q/3
	7SLX7/4QDR9hoTjpEbLaNv4tI9enObQK1h4DBoM5u7JxRqLCQQ6ytbOV31ceUcC7lC1y
	83Ak7UCLO1UHlpWAbgb/kEQKdk6pbFLROhuM4F8Bls+Y6N4/CDqHmEVJhsQiXYyk5UfJ
	yPrDfv98KMFFhuALwhV/U5KuX3A/MOFQ1+ZV1YMgks5B7ZpN8+pnjlpe1hkhP1RJ7z8v
	45WVbnANhIdWXMdayeXyOM7ap9cA2Q+ZGFbh+Y7Ocx1bk+irbf2uymDUa1q51GRrSdje
	RZEQ==
X-Gm-Message-State: APjAAAU3MZTi9l5xgNamG9/iInBoVkMK0yjl+3X39tdvL/FeVxeiRFz7
	31Om6iAMuTvlp0fx3F6TVhGK4L3gKuWTxVMLQo/Bsg==
X-Google-Smtp-Source: APXvYqzmftlTRUTwhQDYzvgypbDnyLvMFUn2U/nKPouHN/rEyYp+JGo6QjH+KjaSpQBo5LMn3j6ZwzdKIOwlKbwUyTU=
X-Received: by 2002:a9d:3f4b:: with SMTP id m69mr32615377otc.246.1554994319729;
	Thu, 11 Apr 2019 07:51:59 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-2-pagupta@redhat.com>
In-Reply-To: <20190410040826.24371-2-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Apr 2019 07:51:48 -0700
Message-ID:
 <CAPcyv4i1FjBzfcWtzeCvj-giHa9xaX0dMQ==q4LZC_L8VEqkHg@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5 1/6] libnvdimm: nd_region flush callback
 support
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
	Rik van Riel <riel@surriel.com>, yuval.shaia@oracle.com,
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
Message-ID: <20190411145148.CZxf5YjJXQRN_5ZK8_0F20z9s6cKL-Nhlvu5lYRtatM@z>

On Tue, Apr 9, 2019 at 9:09 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds functionality to perform flush from guest
> to host over VIRTIO. We are registering a callback based
> on 'nd_region' type. virtio_pmem driver requires this special
> flush function. For rest of the region types we are registering
> existing flush function. Report error returned by host fsync
> failure to userspace.
>
> This also handles asynchronous flush requests from the block layer
> by creating a child bio and chaining it with parent bio.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
[..]
> diff --git a/drivers/nvdimm/region_devs.c b/drivers/nvdimm/region_devs.c
> index b4ef7d9ff22e..fb1041ab32a6 100644
> --- a/drivers/nvdimm/region_devs.c
> +++ b/drivers/nvdimm/region_devs.c
> @@ -295,7 +295,9 @@ static ssize_t deep_flush_store(struct device *dev, struct device_attribute *att
>                 return rc;
>         if (!flush)
>                 return -EINVAL;
> -       nvdimm_flush(nd_region);
> +       rc = nvdimm_flush(nd_region, NULL, false);
> +       if (rc)
> +               return rc;
>
>         return len;
>  }
> @@ -1085,6 +1087,11 @@ static struct nd_region *nd_region_create(struct nvdimm_bus *nvdimm_bus,
>         dev->of_node = ndr_desc->of_node;
>         nd_region->ndr_size = resource_size(ndr_desc->res);
>         nd_region->ndr_start = ndr_desc->res->start;
> +       if (ndr_desc->flush)
> +               nd_region->flush = ndr_desc->flush;
> +       else
> +               nd_region->flush = generic_nvdimm_flush;
> +
>         nd_device_register(dev);
>
>         return nd_region;
> @@ -1125,11 +1132,36 @@ struct nd_region *nvdimm_volatile_region_create(struct nvdimm_bus *nvdimm_bus,
>  }
>  EXPORT_SYMBOL_GPL(nvdimm_volatile_region_create);
>
> +int nvdimm_flush(struct nd_region *nd_region, struct bio *bio, bool async)
> +{

I don't quite see the point of the 'async' argument. All the usages of
this routine are either

nvdimm_flush(nd_region, bio, true)
...or:
nvdimm_flush(nd_region, NULL, false)

...so why not gate async behavior on the presence of the 'bio' argument?


> +       int rc = 0;
> +
> +       /* Create child bio for asynchronous flush and chain with
> +        * parent bio. Otherwise directly call nd_region flush.
> +        */
> +       if (async && bio->bi_iter.bi_sector != -1) {
> +
> +               struct bio *child = bio_alloc(GFP_ATOMIC, 0);
> +
> +               if (!child)
> +                       return -ENOMEM;
> +               bio_copy_dev(child, bio);
> +               child->bi_opf = REQ_PREFLUSH;
> +               child->bi_iter.bi_sector = -1;
> +               bio_chain(child, bio);
> +               submit_bio(child);

I understand how this works, but it's a bit too "magical" for my
taste. I would prefer that all flush implementations take an optional
'bio' argument rather than rely on the make_request implementation to
stash the bio away on a driver specific list.

> +       } else {
> +               if (nd_region->flush(nd_region))
> +                       rc = -EIO;

Given the common case wants to be fast and synchronous I think we
should try to avoid retpoline overhead by default. So something like
this:

if (nd_region->flush == generic_nvdimm_flush)
    rc = generic_nvdimm_flush(...);

