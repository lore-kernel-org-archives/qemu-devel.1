Return-Path: <SRS0=e5mL=UC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FFD6C04AB6
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 03:50:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2706727B21
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Jun 2019 03:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2706727B21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57241 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXdzA-0001JJ-Lp
	for qemu-devel@archiver.kernel.org; Sun, 02 Jun 2019 23:50:12 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXdyL-0000yL-Tt
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 23:49:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richardw.yang@linux.intel.com>) id 1hXdlx-0004VT-NM
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 23:36:34 -0400
Received: from mga09.intel.com ([134.134.136.24]:54743)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <richardw.yang@linux.intel.com>)
	id 1hXdlx-0004Tm-Dp
	for qemu-devel@nongnu.org; Sun, 02 Jun 2019 23:36:33 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	02 Jun 2019 20:36:30 -0700
X-ExtLoop1: 1
Received: from richard.sh.intel.com (HELO localhost) ([10.239.159.54])
	by fmsmga004.fm.intel.com with ESMTP; 02 Jun 2019 20:36:29 -0700
Date: Mon, 3 Jun 2019 11:36:00 +0800
From: Wei Yang <richardw.yang@linux.intel.com>
To: Peter Xu <peterx@redhat.com>
Message-ID: <20190603033600.GB7784@richard>
References: <20190507031703.856-1-richardw.yang@linux.intel.com>
	<20190531164337.GK3169@work-vm> <20190601033441.GB4958@xz-x1>
	<20190603013305.GA7784@richard> <20190603023527.GD4958@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190603023527.GD4958@xz-x1>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 134.134.136.24
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com,
	Wei Yang <richardw.yang@linux.intel.com>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 03, 2019 at 10:35:27AM +0800, Peter Xu wrote:
>On Mon, Jun 03, 2019 at 09:33:05AM +0800, Wei Yang wrote:
>> On Sat, Jun 01, 2019 at 11:34:41AM +0800, Peter Xu wrote:
>> >On Fri, May 31, 2019 at 05:43:37PM +0100, Dr. David Alan Gilbert wrote:
>> >> * Wei Yang (richardw.yang@linux.intel.com) wrote:
>> >> > During migration, we would sync bitmap from ram_list.dirty_memory to
>> >> > RAMBlock.bmap in cpu_physical_memory_sync_dirty_bitmap().
>> >> > 
>> >> > Since we set RAMBlock.bmap and ram_list.dirty_memory both to all 1, this
>> >> > means at the first round this sync is meaningless and is a duplicated
>> >> > work.
>> >> > 
>> >> > Leaving RAMBlock->bmap blank on allocating would have a side effect on
>> >> > migration_dirty_pages, since it is calculated from the result of
>> >> > cpu_physical_memory_sync_dirty_bitmap(). To keep it right, we need to
>> >> > set migration_dirty_pages to 0 in ram_state_init().
>> >> > 
>> >> > Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> 
>> >> I've looked at this for a while, and I think it's OK, so
>> >> 
>> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>> >> 
>> >> Peter, Juan: Can you just see if there's arny reason this would be bad,
>> >> but I think it's actually more sensible than what we have.
>> >
>> >I really suspect it will work in all cases...  Wei, have you done any
>> >test (or better, thorough tests) with this change?  My reasoning of
>> >why we should need the bitmap all set is here:
>> >
>> 
>> I have done some migration cases, like migrate a linux guest through tcp.
>
>When did you start the migration?  Have you tried to migrate during
>some workload?
>

I tried kernel build in guest.

>> 
>> Other cases suggested to do?
>
>Could you also help answer the question I raised below in the link?
>
>Thanks,
>
>> >https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg07361.html
>

I took a look into this link, hope my understanding is correct.

You concern is this thread/patch is based on one prerequisite -- dirty all the
bitmap at start.

My answer is we already did it in ram_block_add() for each RAMBlock. And then
the bitmap is synced by migration_bitmap_sync_precopy() from
ram_list.dirty_memory to RAMBlock.bmap.


>-- 
>Peter Xu

-- 
Wei Yang
Help you, Help me

