Return-Path: <SRS0=Z/nf=BQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7AD0C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:14:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B0E22D70
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Aug 2020 12:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtGaYR39"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B0E22D70
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3e17-0007Rp-QZ
	for qemu-devel@archiver.kernel.org; Thu, 06 Aug 2020 07:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47120)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3dlK-0005zX-Nx
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:08:42 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32665
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3dlI-0002Fb-Gs
 for qemu-devel@nongnu.org; Thu, 06 Aug 2020 07:08:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596712119;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=ULrzB/PF8NcQODa8y9P80PUhlFP+2SyoOpd4oZ6dsf8=;
 b=DtGaYR39o2zBdwPIbL2sxDbpvP47PENFiKCsc5gUir5dKFfSN87ElLgQHJcfjnmS1Am1KS
 He/tGd+PxkykqrKQrOP0G9PAksONniVsEwJ+w7ilD9NWSLbE7gISOEtuQiCsasygM9Uk7c
 mMdhyD/85MstM1HR5x3dYBVHOzaud10=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-VsgXipuTPwG4_BkZstFm0g-1; Thu, 06 Aug 2020 07:08:35 -0400
X-MC-Unique: VsgXipuTPwG4_BkZstFm0g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7494C10059A7;
 Thu,  6 Aug 2020 11:08:34 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3B51F70105;
 Thu,  6 Aug 2020 11:08:29 +0000 (UTC)
Date: Thu, 6 Aug 2020 12:08:26 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: Why QEMU should move from C to Rust (clickbait alert ;))
Message-ID: <20200806110826.GH4159383@redhat.com>
References: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWF8g7r5VqU_PRbskWZU3ahCq+eobR8GexUcPrAiYoCPQ@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/06 05:03:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Sergio Lopez <slp@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Oleinik, Alexander" <alxndr@bu.edu>, Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Dave Gilbert <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 06, 2020 at 11:24:13AM +0100, Stefan Hajnoczi wrote:

...snip...

I broadly agree with the points about why Rust is desirable as
a language for QEMU.

> How can we change programming language?
> ------------------------------------------------------------
> When I checked in 2018 QEMU was 1.5 million lines of code. It has
> grown since then. Moving a large codebase to a new programming
> language is extremely difficult. If people want to convert QEMU to
> Rust that would be great, but I personally don't have the appetite to
> do it because I think the integration will be messy, result in a lot
> of duplication, and there is too much un(der)maintained code that is
> hard to convert.
> 
> The reason I am writing this post is because device emulation, the
> main security attack surface for VMMs, can be done in a separate
> program. That program can be written in any language and this is where
> Rust comes in. For vhost devices it is possible to write Rust device
> backends today and I hope this will become the default approach to
> writing new devices.
> 
> For non-vhost devices the vfio-user project is working on an interface
> out-of-process device emulation. It will be possible to implement
> devices in Rust there too.

I guess this dovetails into our view of security bug classification.
Stuff that affects virtualization use cases is security critical,
while stuff that affects emulation is NOT security critical.

With this in mind, it is not a priority to convert the whole of
QEMU to Rust. The priority is the subset that affects virtualization
use cases. It is a much more tractable problem if we're looking at
creating rust based vhost-user / vfio-user, only for the devices
that are commonly used for KVM with modern OS, and ignore the many
100's of devices that are only there for emulation or foir legacy OS.


> If you are implementing new device emulation code please consider
> doing it in Rust!

Yes, but I think we'll need put in significant effort to guide / assist
people in taking this direction, and think about what it means for the
future of QEMU as a brand and GIT repo.

In many ways it is a good thing if the Rust vhost-user impls are
all in their own standalone git repos. They're likely to be independent
codebases, so there's little compelling reason to force them into the
QEMU git, where they'll have to use QEMU workflow, and QEMU release
cycle. They're better off free from QEMU where they can choose to adopt
modern development practices like GitLab merge requests if they
desire and release on a more frequent cycle than QEMU's 3-times a
year, etc. Would also make them more appealing for use by alternative
non-QEMU userspaces for KVM.

The downside is that QEMU git would only contain the "legacy" builtin
C impls of the devices, and all the "recommended" modern Rust impls
would be elsewhere. Essentially QEMU would no longer be a self-contained
provider of the complete solution. Many parts would be disaggregated,
and users now have the burden of finding all the right pieces to build
the best solution. We've already seen this to some extent with existing
vhost-user impls, but it feels like we'd be pushing towards that as a
more general model for the future which would amplify problems we've
largely been able to ignore upto now.

I'm not sure what a good answer here is. Perhaps QEMU could try to
become more of brand for an umbrella project that covers multiple
independant repos ? eg create new repos under gitlab.com/qemu-project/
but allow them to work fairly independantly from the main qemu.git ?
That way we can more easily promote a collection of QEMU repos as
showing the recommended architecture, without forcing everything
into qemu.git. We can leverage the QEMU website, wiki and documentation
in general to showcase the overall solution, while still letting the
pieces develop independently.

> Conclusion
> ---------------
> Most security bugs in QEMU today are C programming bugs. Switching to
> a safer programming language will significantly reduce security bugs
> in QEMU. Rust is now mature and proven enough to use as the language
> for device emulation code. Thanks to vhost-user and vfio-user using
> Rust for device emulation does not require a big conversion of QEMU
> code, it can simply be done in a separate program. This way attack
> surfaces can be written in Rust to make them less susceptible to
> security bugs going forward.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


