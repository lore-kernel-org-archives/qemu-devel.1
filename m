Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BC4C433E3
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 767552064C
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 10:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lk+TwFPL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 767552064C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw15y-0006vt-NH
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 06:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw15K-0006MN-7i
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:25:50 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:42241
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jw15H-0007tM-KT
 for qemu-devel@nongnu.org; Thu, 16 Jul 2020 06:25:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594895145;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i816klkVehlrHLDcStk8Dm4prbSi9rGJHFd4h1QSPC8=;
 b=Lk+TwFPLrZnjlc9ilWjQ5qidJBVHhyppDBBorcG7n04zF8EjMRWFfSiRImxnWCrjqYnKOW
 dGMWbTlr9EWuryNr467BCyz1EjhJV7owDJhGCH0HdrQoLBw8DzuUaN7ala67f9e4gMf3HN
 N9Jk0cyZltcW1mJZ67d9xuEZF0hm1iA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-a46M31iyOPWQIBUA7zDBkQ-1; Thu, 16 Jul 2020 06:02:24 -0400
X-MC-Unique: a46M31iyOPWQIBUA7zDBkQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB59E1013994;
 Thu, 16 Jul 2020 10:02:02 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 11BCD10098A1;
 Thu, 16 Jul 2020 10:01:59 +0000 (UTC)
Date: Thu, 16 Jul 2020 11:01:57 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200716100157.GK227735@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200716083654.GA227735@redhat.com>
 <nycvar.YSQ.7.78.906.2007161428570.950384@xnncv>
 <3491260.5YPxQhmjAg@silver>
MIME-Version: 1.0
In-Reply-To: <3491260.5YPxQhmjAg@silver>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 04:55:15
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-devel@nongnu.org, P J P <ppandit@redhat.com>, Greg Kurz <groug@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jul 16, 2020 at 11:45:50AM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 16. Juli 2020 11:21:55 CEST P J P wrote:
> > +-- On Thu, 16 Jul 2020, Daniel P. BerrangÃ© wrote --+
> > 
> > | > Failing to start (with a message that explains why) if one of the
> > | > command
> > | > line options is not covered by a specified security policy is not
> > | > unreasonable (after all, we fail to start for other cases of
> > | > incompatible
> > | > command line options as well.)
> > 
> >   Yes, that's right.
> > 
> > | > However, we also need to cover dynamically-added devices. Aborting seems
> > | > very bad there, just failing to add the device seems like what we'd
> > | > want.
> > | 
> > | Yep, aborting is simply not an option for the inner code. It all has to
> > | propagate to a proper Error **errp object. The ultimate entry-point at the
> > | CLI vs QMP then decides whether to turn the error into an abort or feed
> > | back to the client app.
> > 
> >   True, handling dynamic devices is tricky.
> > 
> > Though it seems kind of uniform workflow to check for '--security' flag at
> > options parsing OR while handling dynamic devices at run time; It is a huge
> > task to cover all options/use-cases for all QEMU emulators across various
> > architectures.
> 
> My concern here is that just distinguishing between either 'low' or 'high' is 
> a far too rough classification.
> 
> In our preceding communication regarding 9pfs, I made clear that a) we do care 
> about security relevant 9pfs issues, and only b) the avarage use cases (as far 
> we know) for 9pfs are above a certain trust level.
> 
> However b) does not imply 9pfs being 'unsafe', nor that we want users to 
> refrain using it in a security relevant environment. So 9pfs would actually be 
> somewhere in between.

We shouldn't overthink this and invent many classification levels.

This is essentially about distinguishing code that is written with the
intent of protecting from a malicous guest, from code that assumes a
non-malicious guest. That is a pretty clear demarcation on when it is
reasonable to use any given feature in QEMU.

Within the set of code that is assuming a malicious guest, there are
still going to be varying levels of quality, and that is ok. We don't
need to express that programatically, the docs are still there to
describe the fine nuances of any given feature. We're just saying that
in general, this set of code is acceptable to use in combination with
a malicious guest, and if you find bugs we'll triage them as security
flaws.

9p is generally written from the POV of protecting against a malicious
guest, so it would be considered part of the high security set, and
flaws will be treated as CVEs. We don't need to be break it down into
any more detail than that.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


