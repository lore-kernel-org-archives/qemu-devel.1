Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81639ECE58C
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:39:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5909E206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 17:39:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5909E206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIFvl-0005GW-GH
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 13:39:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49373)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iI7sa-0001wr-Cu
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iI7sT-00016x-NE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:03:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50572)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iI7sT-00016E-Hd
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 05:03:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 44F50C002966;
 Wed,  9 Oct 2019 09:03:24 +0000 (UTC)
Received: from work-vm (ovpn-117-215.ams2.redhat.com [10.36.117.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 541D75D9CD;
 Wed,  9 Oct 2019 09:03:23 +0000 (UTC)
Date: Wed, 9 Oct 2019 10:03:20 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Wei Yang <richardw.yang@linux.intel.com>
Subject: Re: [PATCH 2/3] migration/postcopy: not necessary to do
 postcopy_ram_incoming_cleanup when state is ADVISE
Message-ID: <20191009090320.GC2893@work-vm>
References: <20191001100122.17730-1-richardw.yang@linux.intel.com>
 <20191001100122.17730-3-richardw.yang@linux.intel.com>
 <20191008160202.GE3441@work-vm> <20191009005511.GB26203@richard>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191009005511.GB26203@richard>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Wed, 09 Oct 2019 09:03:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-devel@nongnu.org, quintela@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Wei Yang (richardw.yang@linux.intel.com) wrote:
> On Tue, Oct 08, 2019 at 05:02:02PM +0100, Dr. David Alan Gilbert wrote:
> >* Wei Yang (richardw.yang@linux.intel.com) wrote:
> >> postcopy_ram_incoming_cleanup() does cleanup for
> >> postcopy_ram_incoming_setup(), while the setup happens only after
> >> migration enters LISTEN state.
> >> 
> >> This means there is nothing to cleanup when migration is still ADVISE
> >> state.
> >> 
> >> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> >> ---
> >>  migration/migration.c | 1 -
> >>  1 file changed, 1 deletion(-)
> >> 
> >> diff --git a/migration/migration.c b/migration/migration.c
> >> index 5f7e4d15e9..34d5e66f06 100644
> >> --- a/migration/migration.c
> >> +++ b/migration/migration.c
> >> @@ -461,7 +461,6 @@ static void process_incoming_migration_co(void *opaque)
> >>               * but managed to complete within the precopy period, we can use
> >>               * the normal exit.
> >>               */
> >> -            postcopy_ram_incoming_cleanup(mis);
> >>          } else if (ret >= 0) {
> >>              /*
> >>               * Postcopy was started, cleanup should happen at the end of the
> >
> >I think that misses the cleanup of mlock that corresponds to the
> >munlockall in postcopy_ram_supported_by_host - that's called very early
> >on; I think in the advise stage.
> >
> 
> Thanks you are right.
> 
> BTW, do we need to check enable_mlock when calling munlockall() in
> postcopy_ram_supported_by_host() ?

I don't think so; it does an extra munlock in that case when nothing
should be locked anyway, no harm.

Dave

> >Dave
> >
> >> -- 
> >> 2.17.1
> >> 
> >--
> >Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Wei Yang
> Help you, Help me
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

