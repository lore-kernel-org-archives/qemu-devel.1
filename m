Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5507C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:36:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DBC2076D
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 09:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EXpT9F5b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DBC2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33320 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIqLQ-0004YV-FV
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 05:36:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIqJg-0003DC-6A
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:35:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:53574)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kIqJd-00071q-0p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 05:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600335295;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qWn6sFZbO+JuYb64w0YPz1HODwPlqlgSzxv/ujAJY6Y=;
 b=EXpT9F5bc4oZi1zQWmQCh1klGwqTHoq8V9hmDd5y++pyG5dbBIti2cI4hg56fEQNFvR/qo
 8T15BJXWYG6fllo1Na0I6N4Jd3ESaJhENTLUP3b3SKXjEcLKwDVb3JK09TzmaOGpD64cQ0
 crtZWtkJHS2oo6GA67Swx4O9l8mKC/g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-h3kgIYctOcuOweTZZVV8zQ-1; Thu, 17 Sep 2020 05:34:50 -0400
X-MC-Unique: h3kgIYctOcuOweTZZVV8zQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C624D100746D
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2020 09:34:49 +0000 (UTC)
Received: from redhat.com (ovpn-114-29.ams2.redhat.com [10.36.114.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67A791002D64;
 Thu, 17 Sep 2020 09:34:45 +0000 (UTC)
Date: Thu, 17 Sep 2020 10:34:42 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: Use patchew to push successfully applied series to GitLab
Message-ID: <20200917093442.GB1568038@redhat.com>
References: <22951108-74c2-a98b-9316-b17c4d8188e0@redhat.com>
 <f90ee77c-11f8-e025-8f4f-38e78e0fe618@redhat.com>
MIME-Version: 1.0
In-Reply-To: <f90ee77c-11f8-e025-8f4f-38e78e0fe618@redhat.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/16 20:51:18
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: patchew-devel@redhat.com, Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 17, 2020 at 10:53:14AM +0200, Paolo Bonzini wrote:
> On 17/09/20 10:16, Philippe Mathieu-Daudé wrote:
> > patchew is currently pushing successfully applied series
> > (using the cover Message-ID as tag) to GitHub.
> > This is very handy (no need to apply patches manually):
> > https://github.com/patchew-project/qemu/tags
> > 
> > Can we push the same that to an equivalent GitLab account?
> > We could then have a script replying to the series if the
> > series fails CI. Doing so would save reviewer/tester time
> > (I'd rather have a series not failing on our CI tests before
> > starting to review/test it).
> 
> Yes, we could.  Indeed we could also look at the pipeline result instead
> of needing Patchew's custom testers (using a webhook).  It would be a
> bit on the heavy side for GitLab's resources; while right now they're
> still providing unlimited CI time, in principle the "gold" tier provides
> "only" 833 hours and a full CI run takes more or less 1.

Yep, this is a limitation of the patchew model where we have a central
service testing each contributors patches, instead of having the CI jobs
running in context of a user's fork and thus havin the CI usage cost
ammoritized across all user's accounts.

In a merge request workflow, this pretty much "just works" because the
CI jobs alwas run in the user's fork before the merge request is opened,
or when force-pushed.

Assuming we're not adopting a merge request workflow in the near term,
I wonder if we could do something clever to improve our mailing list
workflow CI to get jobs running mostly in user's forks.

A large number of contributors use "git-publish" to send patches. That
is already capable of optionally pushing to a public git server for
pull requests.

What if we used git-publish to always push to gitlab when submitting
patches, and have it include the gitlab ref in the cover letter.

That would trigger CI jobs in the user's fork, and patchew would not
have to run anything itself. It would merely monitor the user's fork
and report back to the list if the job failed. Patchew would ony then
have to run stuff in its own shared fork if the user didn't include
a gitlab ref in their cover letter.  At least this works for x86
Linux stuff. Doesn't work for any scenario needing custom runners.

Still if our regular contributors went this way, the shared fork
could have much lower build job load than we see today.

> So it would work great but we would have to set up our own runners,
> and/or have a cheaper pipeline for this gating CI.  Is that possible to
> configure in Gitlab?

The ideal situation is that we have one set of defined jobs that are
used universally by the person merging to git master, by patchew, by
any contributors before posting.

In terms of traditional build jobs, we have a huge number defined in
GitLab CI but it is only a partially overlapping set vs patchew,
principally because the GitLab jobs are x86 only. For the non-x86 stuff we would have to define
jobs that target custom runners and then have custom runners registered
against Patchew's account. If quota becomes a problem, we'd nede x86 custom
runners too.

The other useful part of patchew is the "checkpatch.pl" validation.
We should really create a job in GitLab CI that covers this, as it
is something that's useful for developers to get right before posting.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


