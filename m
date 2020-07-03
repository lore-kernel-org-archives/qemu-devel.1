Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDADC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:28:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAF2207FF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 11:28:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HdJ4a0uH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAF2207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrJrq-0003Kq-5R
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 07:28:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrJrI-0002vY-9y
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:27:56 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57150
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jrJrF-0007qa-Us
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 07:27:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593775671;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=puHAKZZb3Doh5SG1vI+fY92nWGWqHQ23G2JApvyki94=;
 b=HdJ4a0uHMpLsKiGXjuTmB5VMpMK0Y9dtsPN2BqqfM8/x9cA8Gocpt5nUPsEeg8MU5g/a9U
 /BNlxfaF1EndM8UT3wxceBHRA8ssOUkBr8V3sHORe/sVdFkFHSt2zygKYPpAkgq3m2PWGA
 7VvRCYx3GuoUyV3u4wXFvjhyaRNY5Fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-368-deYTFpIlOROocfHJ21EY8g-1; Fri, 03 Jul 2020 07:27:42 -0400
X-MC-Unique: deYTFpIlOROocfHJ21EY8g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D4B13EC1A0;
 Fri,  3 Jul 2020 11:27:41 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C65C87AC71;
 Fri,  3 Jul 2020 11:27:33 +0000 (UTC)
Date: Fri, 3 Jul 2020 12:27:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH v2 0/3] trace: Add a trace backend for the recorder library
Message-ID: <20200703112730.GD2213227@redhat.com>
References: <20200626162706.3304357-1-dinechin@redhat.com>
 <20200630125916.GG91444@stefanha-x1.localdomain>
 <lysge8c2b5.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <lysge8c2b5.fsf@redhat.com>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:17:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Jul 03, 2020 at 12:37:02PM +0200, Christophe de Dinechin wrote:
> 
> On 2020-06-30 at 14:59 CEST, Stefan Hajnoczi wrote...
> > On Fri, Jun 26, 2020 at 06:27:03PM +0200, Christophe de Dinechin wrote:
> >> The recorder library implements low-cost always-on tracing, with three
> >> usage models:
> >>
> >> 1. Flight recorder: Dump information on recent events in case of crash
> >> 2. Tracing: Individual traces can be enabled using environment variables
> >> 3. Real-time graphing / control, using the recorder_scope application
> >>
> >> This short series introduces a new "recorder" back-end which connects
> >> to the recorder. Traces using the recorder are intentionally "always on".
> >> An example is given of how the recorder can also be used separately
> >> from generated traces. This can be useful if you want to enable
> >> multiple related traces for a particular topic.
> >>
> >> This series requires a small makefile fix submitted earlier, included
> >> here for convenience.
> >>
> >> Christophe de Dinechin (3):
> >>   Makefile: Compute libraries for libqemuutil.a and libvhost-user.a
> >>   trace: Add support for recorder back-end
> >>   trace: Example of "centralized" recorder tracing
> >
> > Please add a build to .travis.yml that enables recorder. That way we'll
> > catch build failures.
> 
> There is no recorder package in Xenial.

Our .gitlab-ci.yml is going to start using the containers built from
tests/docker/dockerfiles. So if you add the package to the dockerfiles
that support it we can get coverage that way. I presume it'll need the
.gitlab-ci.yml modified to add the extra configure arg too.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


