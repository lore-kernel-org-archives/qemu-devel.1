Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A71C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:40:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D48620758
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 09:40:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DeZp8Gh8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D48620758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGJ4D-00006E-AM
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 05:40:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJ3B-0006sY-A4
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:55988)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGJ37-0003fr-QF
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 05:39:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599730763;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UJMJyRzObNSzgsm7nKTBhtIdlUcnnERbJ5o1q7a0ciI=;
 b=DeZp8Gh8p6cl+FugftWunwKCqm0B2RXcWnNJpBW/W0j5Wsc4Lwtt9IknBbW714cp219AOw
 BFtl9u7ITf0As+0o2ysFim6VBeYHraEb8e6XGnua8FJcp6ixDb1kAIzoCD+zM9g6lB5Wyj
 qucI3wJf32sIV3FRwXLBm07dbN5f2Pg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-uRVKf8UVNO6_we5Y9MFxTQ-1; Thu, 10 Sep 2020 05:39:19 -0400
X-MC-Unique: uRVKf8UVNO6_we5Y9MFxTQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 890321008542;
 Thu, 10 Sep 2020 09:39:18 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 347F65D9E8;
 Thu, 10 Sep 2020 09:39:13 +0000 (UTC)
Date: Thu, 10 Sep 2020 10:39:10 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200910093910.GG1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <1695914.5EixHECA2G@silver>
 <20200910073710.GA1083348@redhat.com> <2421928.3WNMogbLRJ@silver>
MIME-Version: 1.0
In-Reply-To: <2421928.3WNMogbLRJ@silver>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 02:38:59
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, qemu-devel@nongnu.org,
 G 3 <programmingkidx@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 11:32:35AM +0200, Christian Schoenebeck wrote:
> On Donnerstag, 10. September 2020 09:37:10 CEST Daniel P. Berrangé wrote:
> > I don't think we want to be adding more 3rd party deps as submodules, quite
> > the opposite, we want to remove more submodules we currently have.
> > 
> > Bundling every important dep we use as a submodule and providing build
> > rules, means we're effectively re-inventing Homebrew / MacPorts and this is
> > not a sane use of our time.
> 
> Well, that's actually the whole point of this thread: saving developers' time. 
> And I think the submodule solution is the most sane one.
>
> Frankly if you compile FOSS software on Mac that asks you to "just" install 
> dependencies with Homebrew and co, it feels like you have 2 jobs: a software 
> developer, and a distribution maintainer. The difference to the submodule 
> though: a much larger amount of developers have to do that maintainer job 
> (manually resolving conflicts & crashes, rollbacks, etc.).


I don't think it saves time. If you look at the bigger picture across
multiple project it costs time. Every project that depends on glib or
gtk or gnutls or etc  reinvents the wheel figuring out a suitable
recipe for bundling & building these dependencies. Worse is that they
will all do it slightly differently, or use a variety of versions, and
so users get a worse experiance too with different features available
and different things broken. Projects like HomeBrew exist precisely to
save developer time because these build steps can be figured out once,
and every project can now just rely on the well maintained HomeBrew
packages.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


