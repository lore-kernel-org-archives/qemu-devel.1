Return-Path: <SRS0=vczr=7A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1763C433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:22:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F91320657
	for <qemu-devel@archiver.kernel.org>; Mon, 18 May 2020 18:22:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="azvNmURL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F91320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49534 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jakPH-0007hI-J3
	for qemu-devel@archiver.kernel.org; Mon, 18 May 2020 14:22:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45834)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jakO0-0006a6-7P
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:21:12 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30300
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1jakNx-00007A-AX
 for qemu-devel@nongnu.org; Mon, 18 May 2020 14:21:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589826066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+1bn3fD2IeMKENfeObZ50zokb2W4wxaQfxuaXKJwXbo=;
 b=azvNmURLLHtz/Dy+5BM8So+KSVG77Uw6uEv9fNlKIh2dCMqvA5rigDZgfTSQZAZ25TKZSG
 0UhoguWCH31kKrfWvrHOwH6MsEa/rMCLJo2HGXuIKFPLW3PxGlXn693wTu1hlH43gr8E74
 iW1FpsJGrLUTLHXj7LPvXKaFKyCt710=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-CAEG2ws-PTaA_Fnjwb-HKQ-1; Mon, 18 May 2020 14:21:03 -0400
X-MC-Unique: CAEG2ws-PTaA_Fnjwb-HKQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B222C19057B0;
 Mon, 18 May 2020 18:21:01 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.40.208.20])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB64C5D9DC;
 Mon, 18 May 2020 18:20:59 +0000 (UTC)
Date: Mon, 18 May 2020 20:20:56 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Subject: Re: [RFC v2] migration: Add migrate-set-bitmap-node-mapping
Message-ID: <20200518182056.GD2995787@angien.pipo.sk>
References: <20200513145610.1484567-1-mreitz@redhat.com>
 <20200518162648.GC2995787@angien.pipo.sk>
 <de0ee410-d5bd-f59a-6e20-0c10ccd54ccb@virtuozzo.com>
MIME-Version: 1.0
In-Reply-To: <de0ee410-d5bd-f59a-6e20-0c10ccd54ccb@virtuozzo.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.13.4 (2020-02-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/17 22:52:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, May 18, 2020 at 20:52:32 +0300, Vladimir Sementsov-Ogievskiy wrote:
> [add Nikolay]
> 
> 18.05.2020 19:26, Peter Krempa wrote:
> > On Wed, May 13, 2020 at 16:56:10 +0200, Max Reitz wrote:

[...]

> > Is there any difference of handling of persistent and non-persistent
> > bitmaps? Specifically I'm curious what's the correct approach to do the
> > shared storage migration case when the source and destination image is
> > the same one. Should we also instruct to migrate the active ones? or are
> > they migrated by writing them to the image and reloading them?
> 
> About migration of persistent bitmaps with shared storage: both variants are possible:
> 
> 1. if you do nothing (i.e. not enable bitmaps migration capability), persistent bitmaps are stored on inactivation of source Qemu and loaded on activation of target Qemu
> 
> 2. if you enable bitmap migration capability, then bitmaps are _NOT_ stored, they migrate through migration channel
> 
> The difference is in downtime: if we have a lot of bitmap data (big disks, small bitmap granularity, a lot of bitmaps) and/or slow shared storage, then with [1] downtime will increase, as we'll have to store all bitmaps to the disk and load them during migration downtime. With [2] bitmaps migrate in postcopy time, when target is already running, so downtime is not increased.
> 
> So, in general [2] is better, and I think we should always use it, not making extra difference between shared and non-shared migration.

Thanks for the explanation! What about the inactive bitmaps though? Are
they treated the same when opened? Should we consider them for migration
through the migration stream?

> 
> ==
> 
> And in this way, no difference between persistent and non-persistent bitmaps migration, let's always migrate them by postcopy [and we go this way (I hope ;) in Virtuozzo]

Yeah, that's probably going to be what libvirt does as well.


> > > +# @migrate-set-bitmap-node-mapping:
> > 
> > qemu-5.0 deprecated a bunch of migrate-set- specific commands in favor
> > of migrate-set-parameters. Is it worth/necessary to add a new command
> > here?
> 
> Hmm probably, we should include mapping into MigrateSetParameters structure?

IMO yes. I think it also conveniently sidesteps some of the issues that
were discussed in the other threads regarding addition/multiple calls
etc. The mapping will be set at once and any other invocation sets a new
mapping and that's it. Setting nothing will clear the mapping.


