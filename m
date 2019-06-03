Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8494EC04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:25:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB3527BDA
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 06:25:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB3527BDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58373 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXgP3-0008Rg-I7
	for qemu-devel@archiver.kernel.org; Mon, 03 Jun 2019 02:25:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:44672)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXgMc-0006TG-1i
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:22:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXgBW-0008OW-Jd
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:11:07 -0400
Received: from mga03.intel.com ([134.134.136.65]:46107)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hXgBW-0008LK-9s
	for qemu-devel@nongnu.org; Mon, 03 Jun 2019 02:11:06 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
	by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jun 2019 23:11:04 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by orsmga008.jf.intel.com with ESMTP; 02 Jun 2019 23:11:03 -0700
Date: Mon, 3 Jun 2019 14:10:34 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Message-ID: <20190603061034.GA18247@richard>
References: <20190507031703.856-1-richardw.yang@linux.intel.com>
	<20190531164337.GK3169@work-vm> <20190601033441.GB4958@xz-x1>
	<20190603013305.GA7784@richard> <20190603023527.GD4958@xz-x1>
	<20190603033600.GB7784@richard> <20190603054013.GE4958@xz-x1>
	<20190603060547.GA17726@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603060547.GA17726@richard>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.65
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram: leave RAMBlock->bmap blank
 on allocating
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
Reply-To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Peter Xu <peterx@redhat.com>, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 02:05:47PM +0800, Wei Yang wrote:
>On Mon, Jun 03, 2019 at 01:40:13PM +0800, Peter Xu wrote:
>>
>>Ah I see, thanks for the pointer.  Then I would agree it's fine.
>>
>>I'm not an expert of TCG - I'm curious on why all those three dirty
>>bitmaps need to be set at the very beginning.  IIUC at least the VGA
>>bitmap should not require that (so IMHO we should be fine to have all
>>zeros with VGA bitmap for ramblocks, and we only set them when the
>>guest touches them).  Migration bitmap should be special somehow but I
>>don't know much on TCG/TLB part I'd confess so I can't say.  In other
>>words, if migration is the only one that requires this "all-1"
>>initialization then IMHO we may consider to remove the other part
>>rather than here in migration because that's what we'd better to be
>>sure with.
>
>I am not sure about the background here, so I didn't make a change at this
>place.
>
>>
>>And even if you want to remove this, I still have two suggestions:
>>
>>(1) proper comment here above bmap on the above fact that although
>>    bmap is not set here but it's actually set somewhere else because
>>    we'll sooner or later copy all 1s from the ramblock bitmap
>>
>>(2) imho you can move "migration_dirty_pages = 0" into
>>    ram_list_init_bitmaps() too to let them be together
>>

I took a look into this one.

ram_list_init_bitmaps() setup bitmap for each RAMBlock, while ram_state_init()
setup RAMState. Since migration_dirty_pages belongs to RAMState, it maybe more
proper to leave it at the original place.

Do you feel good about this?

>
>I will address these two comments and send v2.
>
>Thanks.
>
>>-- 
>>Peter Xu
>
>-- 
>Wei Yang
>Help you, Help me

-- 
Wei Yang
Help you, Help me

