Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F329C433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8FE920C09
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 10:56:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JWkCOp3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8FE920C09
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGKFG-0004eb-RC
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 06:56:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55746)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGKDx-0003KP-FH
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:54:41 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28039
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kGKDv-0005wX-It
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 06:54:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599735278;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aH+DNHVmAe+Z27KeeHOZaXeet2R4uIQ2kqeWtfDWuEg=;
 b=JWkCOp3xWclPRdcZCnHVM1AhlRU3Nam/MpQub9/JA4Q1yX2KLTpaAC/ggoO6JHyLdXbUo3
 jayIDBzwL/ksi5tMF6jZqRcQHG9lNIBlb2TTzBSseiQCKMuv+8tqJSy3clmBqgcsBJ4hSR
 QdLS7CwRzmC9VJS94PWZmmr3pWQ+kUs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-cShkXMtaOaa2b_dGjxC5tQ-1; Thu, 10 Sep 2020 06:54:37 -0400
X-MC-Unique: cShkXMtaOaa2b_dGjxC5tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C959580EF9C;
 Thu, 10 Sep 2020 10:54:35 +0000 (UTC)
Received: from redhat.com (ovpn-112-4.ams2.redhat.com [10.36.112.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F2A671775;
 Thu, 10 Sep 2020 10:54:25 +0000 (UTC)
Date: Thu, 10 Sep 2020 11:54:22 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC] QEMU as Xcode project on macOS
Message-ID: <20200910105422.GI1083348@redhat.com>
References: <2764135.D4k31Gy3CM@silver> <1695914.5EixHECA2G@silver>
 <20200910073710.GA1083348@redhat.com> <2421928.3WNMogbLRJ@silver>
 <CABgObfabaOTqq0bEVUQ1G=QKMBq3-FpgRnH+WhLZc_mvPsCzsA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABgObfabaOTqq0bEVUQ1G=QKMBq3-FpgRnH+WhLZc_mvPsCzsA@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 01:23:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Liviu Ionescu <ilg@livius.net>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 qemu-devel <qemu-devel@nongnu.org>, G 3 <programmingkidx@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 10, 2020 at 12:41:45PM +0200, Paolo Bonzini wrote:
> Il gio 10 set 2020, 11:32 Christian Schoenebeck <qemu_oss@crudebyte.com> ha
> scritto:
> 
> > On Donnerstag, 10. September 2020 09:37:10 CEST Daniel P. Berrangé wrote:
> > > I don't think we want to be adding more 3rd party deps as submodules,
> > quite
> > > the opposite, we want to remove more submodules we currently have.
> > >
> > > Bundling every important dep we use as a submodule and providing build
> > > rules, means we're effectively re-inventing Homebrew / MacPorts and this
> > is
> > > not a sane use of our time.
> >
> > Well, that's actually the whole point of this thread: saving developers'
> > time.
> > And I think the submodule solution is the most sane one.
> >
> 
> You're very welcome to do this, but what you're doing is effectively a
> *distribution of QEMU* that targets the "macOS build from source" scenario,
> for people that don't want to use Homebrew. It is *not* going to be used by
> QEMU developers, because QEMU developers have conflicting requirements:
> 
> * Not getting in the business of maintaining a distribution of all their
> dependencies (glib, pixman, etc.)
> 
> * Not wanting to maintain multiple build systems
> 
> both of which are non-negotiable.
> 
> What you might do is use the configure script and the ninja backend to
> build all generated sources (produced by either configure, meson or make);
> then copy those generated file over to a new build directory, invoke meson
> again with the xcode backend, and distribute the result so that it is ready
> to build from source using xcode. The resulting distribution is not
> appropriate to develop QEMU, but it would be okay to install it and even
> for some simple debugging.
> 
> The above approach still doesn't solve the problem of building glib and
> friends as part of the same xcode project. Perhaps this can be fixed by
> patching the xcodeproj that Meson generated.
> 
> The scripts needed to do so should be relatively stable and can certainly
> be included in the upstream QEMU sources. You can't expect that other
> people will test them unless you also include them somehow in our CI, but
> just having the scripts would be a start.

I'm not convinced we want to take what amounts to distribution packaging
into the main QEMU repo, as QEMU has generally stayed out of this area
leaving it to be done as downstream users/projects desire.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


