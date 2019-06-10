Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34B9EC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:29:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F59520820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 19:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F59520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haPz7-00015M-Ml
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 15:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55336)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <msnitzer@redhat.com>) id 1haPyd-0000fa-EV
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:29:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <msnitzer@redhat.com>) id 1haPyb-0006Xa-B1
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:29:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48026)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <msnitzer@redhat.com>) id 1haPyZ-0006QR-7X
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 15:29:03 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id D9FFB120D7;
 Mon, 10 Jun 2019 19:28:23 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A734160C47;
 Mon, 10 Jun 2019 19:28:04 +0000 (UTC)
Date: Mon, 10 Jun 2019 15:28:03 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Pankaj Gupta <pagupta@redhat.com>
Message-ID: <20190610192803.GA29002@redhat.com>
References: <20190610090730.8589-1-pagupta@redhat.com>
 <20190610090730.8589-5-pagupta@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610090730.8589-5-pagupta@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.26]); Mon, 10 Jun 2019 19:28:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v11 4/7] dm: enable synchronous dax
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
Cc: cohuck@redhat.com, jack@suse.cz, kvm@vger.kernel.org, mst@redhat.com,
 jasowang@redhat.com, david@fromorbit.com, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, dm-devel@redhat.com,
 adilger.kernel@dilger.ca, zwisler@kernel.org, aarcange@redhat.com,
 dave.jiang@intel.com, jstaron@google.com, linux-nvdimm@lists.01.org,
 vishal.l.verma@intel.com, david@redhat.com, willy@infradead.org,
 hch@infradead.org, linux-acpi@vger.kernel.org, jmoyer@redhat.com,
 linux-ext4@vger.kernel.org, lenb@kernel.org, kilobyte@angband.pl,
 rdunlap@infradead.org, riel@surriel.com, yuval.shaia@oracle.com,
 stefanha@redhat.com, pbonzini@redhat.com, dan.j.williams@intel.com,
 lcapitulino@redhat.com, kwolf@redhat.com, nilal@redhat.com, tytso@mit.edu,
 xiaoguangrong.eric@gmail.com, darrick.wong@oracle.com, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 10 2019 at  5:07am -0400,
Pankaj Gupta <pagupta@redhat.com> wrote:

>  This patch sets dax device 'DAXDEV_SYNC' flag if all the target
>  devices of device mapper support synchrononous DAX. If device
>  mapper consists of both synchronous and asynchronous dax devices,
>  we don't set 'DAXDEV_SYNC' flag.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> ---
>  drivers/md/dm-table.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/drivers/md/dm-table.c b/drivers/md/dm-table.c
> index 350cf0451456..c5160d846fe6 100644
> --- a/drivers/md/dm-table.c
> +++ b/drivers/md/dm-table.c
> @@ -890,10 +890,17 @@ static int device_supports_dax(struct dm_target *ti, struct dm_dev *dev,
>  			start, len);
>  }
>  
> +static int device_synchronous(struct dm_target *ti, struct dm_dev *dev,
> +				       sector_t start, sector_t len, void *data)
> +{
> +	return dax_synchronous(dev->dax_dev);
> +}
> +
>  bool dm_table_supports_dax(struct dm_table *t, int blocksize)
>  {
>  	struct dm_target *ti;
>  	unsigned i;
> +	bool dax_sync = true;
>  
>  	/* Ensure that all targets support DAX. */
>  	for (i = 0; i < dm_table_get_num_targets(t); i++) {
> @@ -906,7 +913,14 @@ bool dm_table_supports_dax(struct dm_table *t, int blocksize)
>  		    !ti->type->iterate_devices(ti, device_supports_dax,
>  			    &blocksize))
>  			return false;
> +
> +		/* Check devices support synchronous DAX */
> +		if (dax_sync &&
> +		    !ti->type->iterate_devices(ti, device_synchronous, NULL))
> +			dax_sync = false;
>  	}
> +	if (dax_sync)
> +		set_dax_synchronous(t->md->dax_dev);
>  
>  	return true;
>  }
> -- 
> 2.20.1
> 

dm_table_supports_dax() is called multiple times (from
dm_table_set_restrictions and dm_table_determine_type).  It is strange
to have a getter have a side-effect of being a setter too.  Overloading
like this could get you in trouble in the future.

Are you certain this is what you want?

Or would it be better to refactor dm_table_supports_dax() to take an
iterate_devices_fn arg and have callers pass the appropriate function?
Then have dm_table_set_restrictions() caller do:

     if (dm_table_supports_dax(t, device_synchronous, NULL))
     	  set_dax_synchronous(t->md->dax_dev);

(NULL arg implies dm_table_supports_dax() refactoring would take a int
*data pointer rather than int type).

Mike

