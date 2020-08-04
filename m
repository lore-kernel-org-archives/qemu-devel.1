Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1324DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 009992086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 09:24:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bbf2peXX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 009992086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2tBT-0004AJ-1L
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 05:24:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42610)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tAu-0003k7-Ra
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:24:00 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:23635
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k2tAr-0007t1-R7
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 05:24:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596533036;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFOa8JsAcj9cDHhEwdNztNB1sXmkEh18XQ4cDbJce88=;
 b=bbf2peXXHXB22ex7LWTii5X+jJygrl5PZ47hQWcJKrHhYe9RGRoRQ93u2Q3lrw+Zu1SRW2
 s2XPwOSuWxZ8ICtWN/1BBj9irKJK4x4UOs58KZvOpBAyKwj9rK4dWrqNM90MHhB6nyNEOX
 jbayO0FWKQmK74Ku+bQAH+YI6o7nnPQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-XxM3pXLVPaikQc9T2_ZiBA-1; Tue, 04 Aug 2020 05:23:52 -0400
X-MC-Unique: XxM3pXLVPaikQc9T2_ZiBA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22A9F1083E80;
 Tue,  4 Aug 2020 09:23:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.43])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A87AB61176;
 Tue,  4 Aug 2020 09:23:47 +0000 (UTC)
Date: Tue, 4 Aug 2020 10:23:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v2 0/3] testing: Build WHPX enabled binaries
Message-ID: <20200804092344.GC4020825@redhat.com>
References: <324f5002-be0a-563e-b5a6-e08ee5e1ddad@redhat.com>
 <SN4PR2101MB0880AF5A5D752F06DB94A15FC04E0@SN4PR2101MB0880.namprd21.prod.outlook.com>
 <b8afd626-b6ae-d6fa-c8b7-5e5778574c07@redhat.com>
 <82fa39b2-676c-e8c5-72c6-53123983dcda@weilnetz.de>
 <55002560-9741-1e71-85f9-e75d9f0f3bfc@weilnetz.de>
 <fde8dd22-679a-be5e-b36e-d8aeb7e955cc@redhat.com>
 <58f5c48c-cf85-ae2a-ce28-510520c2ae75@weilnetz.de>
 <1eae7ba1-47a2-29f3-9425-aa9d8f617106@redhat.com>
 <7cdc7066-0477-5f8b-9d22-12de97098cfc@weilnetz.de>
 <5261de23-cbf9-fa90-bcd3-ad8fe213297d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5261de23-cbf9-fa90-bcd3-ad8fe213297d@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 01:28:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "1879672@bugs.launchpad.net" <1879672@bugs.launchpad.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 04, 2020 at 10:10:31AM +0200, Thomas Huth wrote:
> On 04/08/2020 09.42, Stefan Weil wrote:
> > Am 04.08.20 um 09:23 schrieb Philippe Mathieu-Daudé:
> > 
> >> On 8/4/20 8:55 AM, Stefan Weil wrote:
> >>> Am 04.08.20 um 08:43 schrieb Thomas Huth:
> >>>
> >>>> On 03/08/2020 22.25, Stefan Weil wrote:
> >>>>> We can add a CI pipeline on Microsoft infrastructure by using a GitHub
> >>>>> action.
> >>>> Sorry for being ignorant, but how does that solve the legal questions
> >>>> just because it is running on GitHub instead of a different CI?
> >>>>
> >>>>  Thomas
> >>>>
> >>> Sorry, I though that would be clear by looking at the included shell script.
> >>>
> >>> The build does not use the Microsoft SDK. It gets the required header
> >>> files from Mingw-w64. They added them in git master.
> 
> Great, thanks for the clarification!
> 
> >> Oh, so we can do that with GitLab too now, we don't need to rely on the
> >> GitHub 'Actions' CI in particular, right?
> > 
> > That's right. The build script was written for Ubuntu, so depending on
> > the distribution used for GitLab CI it will need some modifications. If
> > GitLab already has a recent Mingw-w64, it might be sufficient to fix the
> > case of the header file names. Mingw-w64 uses winhvplatform.h while QEMU
> > expects WinHvPlatform.h and so on. I used symbolic links to add the
> > camel case filenames.
> 
> I'm currently working on a patch series for our gitlab-CI that uses our
> containers to all possible kinds of cross-compiler builds (basically the
> ones that we are doing on shippable.com so far), including the 32-bit
> and 64-bit MinGW cross-compilation jobs. I can have a look whether I can
> integrate these headers there!

Fedora rawhide carries mingw64 v7.0.0, which was released in Nov 2019

The WHPX headers were added to mingw64 git a week later, so they're
not available in any distro yet. 

The mingw64 release schedule looks "sporadic" so maybe we can just
request a new release to make WPHX stuff available. It'll thus be
available for our CI in rawhide/sid shortly thereafter, which will
be the best solution to let us do this in GitLab.

We certainly don't want to add yet another separate CI system just
for WHPX.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


