Return-Path: <SRS0=iivN=EG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76895C388F7
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 19:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A7252065C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2020 19:18:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="Mulw5L5j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A7252065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYwOt-0004Nf-J7
	for qemu-devel@archiver.kernel.org; Sat, 31 Oct 2020 15:18:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45504)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYwO1-0003ve-8C
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 15:18:01 -0400
Received: from lizzy.crudebyte.com ([91.194.90.13]:56475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1kYwNy-0008Kj-N8
 for qemu-devel@nongnu.org; Sat, 31 Oct 2020 15:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=QxdieUAXh4gPpCpa3IOd/t2wbkNdGGRcX5NQVKdGDgw=; b=Mulw5L5jDZvIqy8Se3hVsYBSOg
 sCiQpI7rYazSHcWoAo3FcbY0a8mjDrHrLIY0FzTI+Ld4HyM0OPR7pak+AjaMvVZ0gGh8lP2aoz8Ze
 m6Zg5rgVmxoKRyQO03/GAj94ewtg4K0dFpazNGUA4trEF4Qz5+M7VYKsHkHv0VfyOwolkAW2fR+ex
 FbwDBdDrRDeA2XTHw5OOTQcy9j6JQ0B6PMshyNT7yDGH4uED7XnG2CAOY4cHnCckcqNCP50XUYZem
 sgCM2nWPjBFI3wdre16TjPTGJBixcItkgeWKuQuiriicRAgH0ZPxQsIsC1KxZuFYcWYJn2ZfcCrd9
 NjgtbYgw==;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Bihong Yu <yubihong@huawei.com>, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Subject: Re: [PULL 00/16] migration queue
Date: Sat, 31 Oct 2020 20:10:49 +0100
Message-ID: <1908851.GJEdv41Ba9@silver>
In-Reply-To: <20201031174611.GG6357@xz-x1>
References: <20201026161952.149188-1-dgilbert@redhat.com>
 <CAFEAcA-ZfZ6pLEMRj5_qhD2Lz7gQtaLaybDK+BxvJbqoDMmSfA@mail.gmail.com>
 <20201031174611.GG6357@xz-x1>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=91.194.90.13; envelope-from=qemu_oss@crudebyte.com;
 helo=lizzy.crudebyte.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/31 15:17:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Samstag, 31. Oktober 2020 18:46:11 CET Peter Xu wrote:
> On Sat, Oct 31, 2020 at 05:26:28PM +0000, Peter Maydell wrote:
> > On Sat, 31 Oct 2020 at 16:12, Christian Schoenebeck
> > 
> > <qemu_oss@crudebyte.com> wrote:
> > > On Montag, 26. Oktober 2020 17:19:36 CET Dr. David Alan Gilbert (git) 
wrote:
> > > > ----------------------------------------------------------------
> > > > migration pull: 2020-10-26
> > > > 
> > > > Another go at Peter's postcopy fixes
> > > > 
> > > > Cleanups from Bihong Yu and Peter Maydell.
> > > > 
> > > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > 
> > > May it be possible that this PR introduced a lockup of the qtests that I
> > > am
> > > encountering in this week's upstream revisions?
> > 
> > If you try the patches Peter Xu attached to this thread
> > does the lockup go away ?
> > 
> > https://lore.kernel.org/qemu-devel/20201030135350.GA588069@xz-x1/
> > 
> > (I'm also seeing intermittent hangs, for some reason almost always
> > on s390x host.)
> 
> It would be good to know exactly which test hanged.  If it's migration-test
> then it's very possible.

It's run-test-144 that does not return; according to Makefile.mtest that's 
migration-test, so chances are high that it's indeed introduced by this PR.

> The race above patch(es) tried to fix should logically be reproducable on
> all archs, not s390x only.
> 
> Thanks,

Yes, it's i386 here that locks up.

I'm running the loop with your patches now, so far so good, let's see if it's 
still alive tomorrow.

Best regards,
Christian Schoenebeck



