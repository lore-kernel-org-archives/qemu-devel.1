Return-Path: <SRS0=7PPA=SN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB1EFC10F13
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:01:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906AA2073F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2019 15:01:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Q3uBcTGn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906AA2073F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:50290 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEbCM-0001r9-NQ
	for qemu-devel@archiver.kernel.org; Thu, 11 Apr 2019 11:01:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hEb8J-0006vs-M8
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:56:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hEb8F-0002zf-RG
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:56:54 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:46887)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hEb8C-0002yF-2a
	for qemu-devel@nongnu.org; Thu, 11 Apr 2019 10:56:50 -0400
Received: by mail-ot1-x342.google.com with SMTP id s24so5452413otk.13
	for <qemu-devel@nongnu.org>; Thu, 11 Apr 2019 07:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=Q39WY1QwbNiopzjiE9clWXmypKuvpRyCVeYXAVT0ZNM=;
	b=Q3uBcTGnIjZa7/KTp2qiPOTYOZa2YOHA6wen6rcf4+KfoSQ0dYkzRF2BB3Hh9J2hV5
	1WBEO7/TSq9DfFY0FU6SEBYDgiByc7D+9QK6Os47nmX4kd7vSs5p0pZVuhMDKFPnhkVp
	oD4wLyF6G1hd93q1lXUNEZYVQVdvlRk1We0zXgcvjD2Ot+YWI9AjPTndAx7YBokeV1fZ
	ctpp4sE7+T/qGAEjWerHgwvW+3YBraMDq/4HNGPh7AtRvvMtqu1zk5yP07hribDH8Jb+
	nyZtJUGLAAxZcI9GzgiobzP4HXPPNL+stbL0F3dlu1oxNrRIZqBzxUp5n1X0A+I5ZFl8
	B6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=Q39WY1QwbNiopzjiE9clWXmypKuvpRyCVeYXAVT0ZNM=;
	b=a2rlNBzEenjJTCLDXQj5CYuLToxvTyCoj0CnrZ6YWukWbgMPcJfE3nMTWdaLH/7ExY
	hsJogPWy5yWUaqmIDKsLQ/PLRNLO0h8wpLYReDPOyPkKpalu3GcPZvQTN2/1T7Pscaya
	LmiTVvRsM9NR2+JBXdA2RKAxs67KPPyblXZMxnIA+5d+JkzwedAPdePYUCvP9SzQHSnH
	7czW6WaBrjq7Zbxt+/day0blU0qx+xCjom1ywf2TCB23M8qQ+87991SYq4zHRpzWt1uS
	Oe36xQJqwNf6hobvZJ8EAE6BvkKfC4GipOMtfDwTdXr7sImHf7LWnagT77BFWsaZcFTs
	bnLA==
X-Gm-Message-State: APjAAAWseCHd90JYTa4gLU3f4+GccOTQHS/17zl5KW+isPqQRgP/EK4Y
	KGmdo33v4CVlqIu6DhZn1ADmkhO5EZA6ORRZdcwXFw==
X-Google-Smtp-Source: APXvYqzvG/DsITk24XWD/XR4qg9tvxLhxXa18JIum6UEPT4QFmqdzUuqxzJ5VPbogGv+LebEcpWY095S2YoG/n/LrP8=
X-Received: by 2002:a9d:6a88:: with SMTP id l8mr32863157otq.260.1554994607197; 
	Thu, 11 Apr 2019 07:56:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190410040826.24371-1-pagupta@redhat.com>
	<20190410040826.24371-4-pagupta@redhat.com>
In-Reply-To: <20190410040826.24371-4-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 11 Apr 2019 07:56:36 -0700
Message-ID:
 <CAPcyv4gXwE2k3JU94GPav0xn2LEgR6-7ZEVYyTHFRjCfTYjerw@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v5 3/6] libnvdimm: add dax_dev sync flag
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
Message-ID: <20190411145636.JToK06a0kgg_Ri_Pzkcd7rdigSNo3AvDTLJ3axuw9fQ@z>

On Tue, Apr 9, 2019 at 9:10 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
> This patch adds 'DAXDEV_SYNC' flag which is set
> for nd_region doing synchronous flush. This later
> is used to disable MAP_SYNC functionality for
> ext4 & xfs filesystem for devices don't support
> synchronous flush.
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/dax/bus.c            |  2 +-
>  drivers/dax/super.c          | 13 ++++++++++++-
>  drivers/md/dm.c              |  2 +-
>  drivers/nvdimm/pmem.c        |  3 ++-
>  drivers/nvdimm/region_devs.c |  7 +++++++
>  include/linux/dax.h          |  9 +++++++--
>  include/linux/libnvdimm.h    |  1 +
>  7 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index 2109cfe80219..431bf7d2a7f9 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -388,7 +388,7 @@ struct dev_dax *__devm_create_dev_dax(struct dax_region *dax_region, int id,
>          * No 'host' or dax_operations since there is no access to this
>          * device outside of mmap of the resulting character device.
>          */
> -       dax_dev = alloc_dax(dev_dax, NULL, NULL);
> +       dax_dev = alloc_dax(dev_dax, NULL, NULL, true);

I find apis that take a boolean as unreadable. What does 'true' mean?
It wastes time to go look at the function definition vs something
like:

    alloc_dax(dev_dax, NULL, NULL, DAXDEV_F_SYNC);

