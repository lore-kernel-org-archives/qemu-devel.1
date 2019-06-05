Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66999C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:35:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 406B82075C
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 10:35:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 406B82075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38854 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYTG3-0006zA-Bf
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 06:35:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYTFF-0006gD-2g
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:34:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1hYTFE-00036E-44
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:34:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1hYTFD-0002i8-Ut
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 06:34:12 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 11CBB3001E7E;
	Wed,  5 Jun 2019 10:33:51 +0000 (UTC)
Received: from redhat.com (ovpn-117-164.ams2.redhat.com [10.36.117.164])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9EB455D9CD;
	Wed,  5 Jun 2019 10:33:42 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: Peter Xu <peterx@redhat.com>
In-Reply-To: <20190605093819.GL15459@xz-x1> (Peter Xu's message of "Wed, 5 Jun
	2019 17:38:19 +0800")
References: <20190605010828.6969-1-richardw.yang@linux.intel.com>
	<20190605064108.GH15459@xz-x1> <20190605085207.GA1804@richard>
	<20190605093819.GL15459@xz-x1>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
Date: Wed, 05 Jun 2019 12:33:39 +0200
Message-ID: <87d0js5njw.fsf@trasno.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 05 Jun 2019 10:33:51 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] migratioin/ram.c: reset complete_round
 when we gets a queued page
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
Reply-To: quintela@redhat.com
Cc: Wei Yang <richardw.yang@linux.intel.com>, dgilbert@redhat.com,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter Xu <peterx@redhat.com> wrote:
> On Wed, Jun 05, 2019 at 04:52:07PM +0800, Wei Yang wrote:
>> On Wed, Jun 05, 2019 at 02:41:08PM +0800, Peter Xu wrote:
>> >On Wed, Jun 05, 2019 at 09:08:28AM +0800, Wei Yang wrote:
>> >> In case we gets a queued page, the order of block is interrupted. We may
>> >> not rely on the complete_round flag to say we have already searched the
>> >> whole blocks on the list.
>> >> 
>> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
>> >> ---
>> >>  migration/ram.c | 6 ++++++
>> >>  1 file changed, 6 insertions(+)
>> >> 
>> >> diff --git a/migration/ram.c b/migration/ram.c
>> >> index d881981876..e9b40d636d 100644
>> >> --- a/migration/ram.c
>> >> +++ b/migration/ram.c
>> >> @@ -2290,6 +2290,12 @@ static bool get_queued_page(RAMState *rs, PageSearchStatus *pss)
>> >>           */
>> >>          pss->block = block;
>> >>          pss->page = offset >> TARGET_PAGE_BITS;
>> >> +
>> >> +        /*
>> >> +         * This unqueued page would break the "one round" check, even is
>> >> +         * really rare.
>> >


> Ah I see your point, but I don't think there is a problem - note that
> complete_round will be reset for each ram_find_and_save_block(), so
> even if we have that iteration of ram_find_and_save_block() to return
> we'll still know we have dirty pages to migrate and in the next call
> we'll be fine, no?

Reviewed-by: Juan Quintela <quintela@redhat.com>

I *think* that peter is perhaps right, but it is not clear at all, and
it is easier to be safe.  I think that the only case that this could
matter is if:
- all pages are clean (so complete_round will get as true)
- we went a queue_page request

Is that possible?  I am not completely sure after looking at the code.
It *could* be if the page that got queued is the last page remaining,
but ......  I fully agree that the case that _almost all_ pages are
clean and we get a request for a queued page is really rare, so it
should not matter in real life, but ....

Later, Juan.

