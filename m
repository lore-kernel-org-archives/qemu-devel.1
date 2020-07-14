Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6639C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 941F6222C8
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 14:05:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iskyRm6n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 941F6222C8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvLZE-0006p2-St
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 10:05:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36274)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvLWj-0003Oy-Pt
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:03:25 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:51674
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvLWg-0004B3-4q
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 10:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594735396;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VmG9Vpofizzdvasuk5QOuimP8a3UiPQQuHne73g6PIg=;
 b=iskyRm6nm84Eu/fpQacU3UYJTAzPoPMflkUKCJUuJQgqhogcfic3E96Mt14HWNf2Y+jA6Q
 Dp3fiFDAEIe95v8rXoB8ZpGTl2mFcSab454olMaaxV6jsQz2SPhCh1Q3Kf+7WO74r1bfUU
 a0zCKCguv21vPrM17z/tzoPB0BSnKuM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-392-dtaamCYkO6yss7DuL98-RQ-1; Tue, 14 Jul 2020 10:02:57 -0400
X-MC-Unique: dtaamCYkO6yss7DuL98-RQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 33C791085;
 Tue, 14 Jul 2020 14:02:51 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0B7FB61477;
 Tue, 14 Jul 2020 14:02:42 +0000 (UTC)
Date: Tue, 14 Jul 2020 15:02:39 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200714140157.GG25187@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
 <20200714095233.GC25187@redhat.com>
 <20200714060916-mutt-send-email-mst@kernel.org>
 <CAFEAcA_ca4JN655GW=eGyjrjDmiv0EktaZZ7RMghO5rBwm9tGQ@mail.gmail.com>
 <20200714064921-mutt-send-email-mst@kernel.org>
 <20200714133021.GF25187@redhat.com>
 <20200714134856.GC5120@linux.fritz.box>
MIME-Version: 1.0
In-Reply-To: <20200714134856.GC5120@linux.fritz.box>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/14 03:57:32
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 P J P <ppandit@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 03:48:56PM +0200, Kevin Wolf wrote:
> Am 14.07.2020 um 15:30 hat Daniel P. BerrangÃÂ© geschrieben:
> > On Tue, Jul 14, 2020 at 07:02:59AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Jul 14, 2020 at 11:22:28AM +0100, Peter Maydell wrote:
> > > > On Tue, 14 Jul 2020 at 11:12, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > And for people who want to build QEMU with lots of functionality (like
> > > > > Fedora does), I think a -security flag would be a useful addition.
> > > > > We can then tell security researchers "only a high security issue
> > > > > if it reproduces with -security=high, only a security issue
> > > > > if it reproduces with -security=low".
> > > > 
> > > > I think a -security option would also be useful to users -- it
> > > > makes it easier for them to check "is this configuration using
> > > > something that I didn't realize was not intended to be secure".
> > > > For me, something useful for our users is much more compelling
> > > > than "this might make security researchers' lives a bit easier".
> > > > 
> > > > thanks
> > > > -- PMM
> > > 
> > > True. And I guess downstreams can also force the option to high or set the
> > > default to high rather easily if they want to.
> > > 
> > > So the option would be:
> > > 
> > > -security level
> > > 	Set minimal required security level of QEMU.
> > > 
> > > 	high: block use of QEMU functionality which is intended to be secure against
> > > 		malicious guests.
> > > 	low: allow use of all QEMU functionality, best effort security
> > > 		against malicious guests.
> > > 
> > > Default would be -security low.
> > > 
> > > Does this look reasonable?
> > 
> > The challenge I see is that wiring up a runtime flag into every relevant
> > part of the QEMU codebase is an pretty large amount of work. Every device,
> > every machine type, every backend type, every generic subsystem will all
> > need checks for this flag. It is possible, but it isn't going to be quick
> > or easy, especially with poor error reporting support in many areas.
> 
> Would it make more sense as a configure flag that decides whether or not
> to compile in potentially problematic devices/backends?

In the perfect world I think we need both because they satisfy different
scenarios.

There are people who are so paranoid they don't want the insecure code
compiled at all. They want a binary guaranteed to only have the trustworthy
code.

Then there are the people who just want protection against making silly
mistakes in their configuration, but want to be able choose between the
features at runtime.

For security researchers reporting issues, I think we already do enough
by documenting what we consider in / out of scope.  In most cases we
can quickly identify whether the reported flaw is in or out of scope.
So I wouldn't think too much about what to do for security researchers.

It is more productive to focus on what our real users needs.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


