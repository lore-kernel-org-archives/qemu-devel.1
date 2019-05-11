Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC8CC04A6B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 01:01:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276F3217D7
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 01:01:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="JR3F2drF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276F3217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52154 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPGO7-0005FW-9s
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 21:01:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:48378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hPGMi-0004Y8-Pa
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:59:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dan.j.williams@intel.com>) id 1hPGMG-00038D-5p
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:59:25 -0400
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:42673)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <dan.j.williams@intel.com>)
	id 1hPGMF-00037J-Nc
	for qemu-devel@nongnu.org; Fri, 10 May 2019 20:59:24 -0400
Received: by mail-oi1-x243.google.com with SMTP id k9so5776032oig.9
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 17:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=intel-com.20150623.gappssmtp.com; s=20150623;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=cl42dZaKPdWPXIrbH2C5qTFgM5gCSynPhXLIFVqa36M=;
	b=JR3F2drFoXseIQNDe33GWiE73pjKGHV2B+ZvDgnMGVjCLxOFIDvA+J2M/UovbYCnvV
	YcuxiRV4p1HMaTBSOYebaH3fsVxx/ol7Wtq6ZpE6/Gk1IBXROdqbBeu5MDQMRwwVcRah
	m9Qjvj1EU8HgsmsPflXbrp5Vw906510cI+DXtJRIWjFfNagGxWdGiXAeQF1hyIkdtmMT
	32kIvIJCS08/uOxfO80bXjH93DKhiS1SMnc1m4KGF7ma2My4ftVxbek5TCV+Tx8pP9Eg
	MJhTlP53ahTMQYspd6lsWtec5GjwwOjEr4TA+HSjHeNVwNiPPO4FWDnfuEaCMgG0/X9d
	2Zaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=cl42dZaKPdWPXIrbH2C5qTFgM5gCSynPhXLIFVqa36M=;
	b=BR3mEShJlj0lttkCAXsOGYmHhtJ3/LPuCZ8/9xaZ2g92naqi5KrJT8uh5vJAXZrWIb
	1UaiPipjG6lKkWvC5Kmz8lpGruCmolZ4TMT/+eOl0/ee+SigExFhehq1NX6VUgvGWkcY
	vvI6AOwMhg4DWqR6V/5h/xbtUu65XnsGTM2I5zI7fWpfTSGZwK0MOSQNDryRmUHdV3AY
	adfHPXoiPUZufUliEid/4x/YS1/fL3wLCJvEPrvkcogTMPEvqyhHbGKw1T4bgxjZzzhz
	y/RRl5krTvuDcsFYgx1weQQtSn6fFS1jSK4AiWIZRGhbWP3tig7VZzUSnDP7EjRFXqwH
	fwkg==
X-Gm-Message-State: APjAAAVkfZ5KojHmbmByRzyvTxFGiVz+lrNxbAq9uFBr4X961Wcfm+5P
	AA8v2TQF/A9jqBTIqhukfPAOzP7Sm8N4/Y6SjtaPmA==
X-Google-Smtp-Source: APXvYqxd5L2Nvbw7B4301QM480ldUecZ6yt4es0ATqbCcPph8SnTzi7vakiTbRG5uoFRT6lPjWaHfX+1q4uJu4AYewU=
X-Received: by 2002:aca:f512:: with SMTP id t18mr3998026oih.0.1557536360283;
	Fri, 10 May 2019 17:59:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190510155202.14737-1-pagupta@redhat.com>
	<20190510155202.14737-4-pagupta@redhat.com>
	<CAPcyv4hbVNRFSyS2CTbmO88uhnbeH4eiukAng2cxgbDzLfizwg@mail.gmail.com>
	<864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
In-Reply-To: <864186878.28040999.1557535549792.JavaMail.zimbra@redhat.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Fri, 10 May 2019 17:59:08 -0700
Message-ID: <CAPcyv4gL3ODfOr52Ztgq7BM4gVf1cih6cj0271gcpVvpi9aFSA@mail.gmail.com>
To: Pankaj Gupta <pagupta@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, May 10, 2019 at 5:45 PM Pankaj Gupta <pagupta@redhat.com> wrote:
>
>
>
> > >
> > > This patch adds 'DAXDEV_SYNC' flag which is set
> > > for nd_region doing synchronous flush. This later
> > > is used to disable MAP_SYNC functionality for
> > > ext4 & xfs filesystem for devices don't support
> > > synchronous flush.
> > >
> > > Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> > > ---
> > >  drivers/dax/bus.c            |  2 +-
> > >  drivers/dax/super.c          | 13 ++++++++++++-
> > >  drivers/md/dm.c              |  3 ++-
> > >  drivers/nvdimm/pmem.c        |  5 ++++-
> > >  drivers/nvdimm/region_devs.c |  7 +++++++
> > >  include/linux/dax.h          |  8 ++++++--
> > >  include/linux/libnvdimm.h    |  1 +
> > >  7 files changed, 33 insertions(+), 6 deletions(-)
> > [..]
> > > diff --git a/drivers/md/dm.c b/drivers/md/dm.c
> > > index 043f0761e4a0..ee007b75d9fd 100644
> > > --- a/drivers/md/dm.c
> > > +++ b/drivers/md/dm.c
> > > @@ -1969,7 +1969,8 @@ static struct mapped_device *alloc_dev(int minor)
> > >         sprintf(md->disk->disk_name, "dm-%d", minor);
> > >
> > >         if (IS_ENABLED(CONFIG_DAX_DRIVER)) {
> > > -               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops);
> > > +               dax_dev = alloc_dax(md, md->disk->disk_name, &dm_dax_ops,
> > > +                                                        DAXDEV_F_SYNC);
> >
> > Apologies for not realizing this until now, but this is broken.
> > Imaging a device-mapper configuration composed of both 'async'
> > virtio-pmem and 'sync' pmem. The 'sync' flag needs to be unified
> > across all members. I would change this argument to '0' and then
> > arrange for it to be set at dm_table_supports_dax() time after
> > validating that all components support synchronous dax.
>
> o.k. Need to set 'DAXDEV_F_SYNC' flag after verifying all the target
> components support synchronous DAX.
>
> Just a question, If device mapper configuration have composed of both
> virtio-pmem or pmem devices, we want to configure device mapper for async flush?

If it's composed of both then, yes, it needs to be async flush at the
device-mapper level. Otherwise MAP_SYNC will succeed and fail to
trigger fsync on the host file when necessary for the virtio-pmem
backed portion of the device-mapper device.

