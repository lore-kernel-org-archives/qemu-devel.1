Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FB7C04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:15:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A0E32182B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 20:15:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="yf8U/Vwd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A0E32182B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49405 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPBvG-0002Jc-HO
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 16:15:14 -0400
Received: from eggs.gnu.org ([209.51.188.92]:36190)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hPBuV-000203-Fs
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:14:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hPBuU-0002nc-KH
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:14:27 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35128)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hPBuT-0002Oq-UB
	for qemu-devel@nongnu.org; Fri, 10 May 2019 16:14:26 -0400
Received: by mail-oi1-x241.google.com with SMTP id a132so5455734oib.2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 13:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=glYXor0GQ9DfKpghbnKPKxe+zUzoJeb7GoYJ26Vk6ps=;
	b=yf8U/VwdNl5tfgFPEKe5qh3THkRWZb9un60SOgkfJ/5LhvAwk90OALPbQmqH8NGPZg
	Cr23IQd+McBJGud2E9ep2+5K3niud5mH6fhTcdytKwGg0ifP80vvI1KiLl0J9xx4xwjq
	TEllzhY/P52SG7Zgqu0zO0TcVHYyKzcfJiA7uwMKIIPnUXohIrhjvrd+s0fzp7fbWFpQ
	y62fi/8hXK8LlUhb+lV4PauDhwTsmzrWQoEzPH1EBWKu2DNHNpcM/c0ugQiTxq1CS/Pn
	ELZfOgWViQuoOxYDdqZ2L8n4KiCZbfdn+ONJLYDNxFTBB6M7dS0ALwRsezeWWJXIVakV
	lNVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=glYXor0GQ9DfKpghbnKPKxe+zUzoJeb7GoYJ26Vk6ps=;
	b=uZoQmQUvVUsOi5TWgzWcIwfMsIkfNxIZhA79i4DdQ38p34GLekekOCTMr7O1kIlSeF
	GH5ivaasYj362/iZnmjge37Mwqe/KrLaPMeO2e+va+rhgJ9kuvgJx0pLbbIIXaYQB4FR
	UU+ZxH8slMyWjI5CQVw21JUwpio7XBzGrYwWmFodpbNceS8Wyt2rQbfsD8vWiJnse6wN
	s1zjZ3WiGAWtSHEEvPrYlOBomRAxneAEFE92M9WHev2ToFf68+zgoGhoR3m3hUPFH1V1
	6C5WKAg0poPcJVYVYtcjW/Yhl/Lz0zOOrvttum/5MBgOvyQMc+38VbPzqKmviXrPXXOP
	th3Q==
X-Gm-Message-State: APjAAAXp0jQ0NmzyujTLzkgvwbdWKYtVpL/kXLVUYbPz4ftwknUEHZTC
	8PDX7lOz5LZ3RTfhoyLH0UEUz2ZSlvcXe1+tGOtJdw==
X-Google-Smtp-Source: APXvYqx7Iy3DOMIV9DNLu2fGaxr7KgtVySuDwyKCLAPX5/jruFRFKJ7CbI+68cxoMCTMjkHKJ+jW3/SnCYNqZpzsnJI=
X-Received: by 2002:aca:4208:: with SMTP id p8mr6821131oia.105.1557519257995; 
	Fri, 10 May 2019 13:14:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-4-pagupta@redhat.com>
In-Reply-To: <20190510155202.14737-4-pagupta@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 13:14:07 -0700
Message-ID: <CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: cohuck@redhat.com, Jan Kara <jack@suse.cz>, KVM list <kvm@vger.kernel.org>,
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

On Fri, May 10, 2019 at 8:53 AM Pankaj Gupta <pagupta@redhat.com> wrote:
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
>  drivers/md/dm.c              |  3 ++-
>  drivers/nvdimm/pmem.c        |  5 ++++-
>  drivers/nvdimm/region_devs.c |  7 +++++++
>  include/linux/dax.h          |  8 ++++++--
>  include/linux/libnvdimm.h    |  1 +
>  7 files changed, 33 insertions(+), 6 deletions(-)
[..]
> diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> index 043f0761e4a0..ee007b75d9fd 100644
> --- a/drivers/md/dm.c
> +++ b/drivers/md/dm.c
> @@ -1969,7 +1969,8 @@ static struct mapped_device *alloc_dev(int minor)
>         sprintf(md->disk->disk_name, "dm-%d", minor);
>
>         if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> -               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
> +               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops,
> +                                                        DAXDEV_F_SYNC);

Apologies for not realizing this until now, but this is broken.
Imaging a device-mapper configuration composed of both 'async'
virtio-pmem and 'sync' pmem. The 'sync' flag needs to be unified
across all members. I would change this argument to '0' and then
arrange for it to be set at dm_table_supports_dax() time after
validating that all components support synchronous dax.

