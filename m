Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC92CC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA2CF22CAF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 09:19:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OpIa5fDW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA2CF22CAF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3yXX-0001Ox-06
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 05:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59114)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3yWn-0000zb-VV
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:19:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53367
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k3yWk-0001TS-Qw
 for qemu-devel@nongnu.org; Fri, 07 Aug 2020 05:19:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596791942;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=P23C6hIQdNH+9tX5hx8rvoPevhsADaeGB5f3seHcD/Q=;
 b=OpIa5fDWDE5uZFszsz4SCMXgCiIyBY4xO9aCEWp7qo91AelEW+2bLVGghNH25Re0Y3zuHk
 79CX0DsBVzfNtSUcj7dZ5Th6Du/2mEEwpanIpZHmYr2djMWfXYhG6L6dpfKu4Q2HGmgu8h
 Dcpb3VwwR63nIXJ3llotwX3CD2wWNlA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-462-jH2fzSWDNvO0tNvvynfrlw-1; Fri, 07 Aug 2020 05:19:00 -0400
X-MC-Unique: jH2fzSWDNvO0tNvvynfrlw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C96D19057AD;
 Fri,  7 Aug 2020 09:18:59 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.44])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6A12669314;
 Fri,  7 Aug 2020 09:18:43 +0000 (UTC)
Date: Fri, 7 Aug 2020 10:18:41 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Subject: Re: [DRAFT PATCH 000/143] Meson integration for 5.2
Message-ID: <20200807091841.GG120942@redhat.com>
References: <1596741379-12902-1-git-send-email-pbonzini@redhat.com>
 <CAFEAcA-d0F9y2OSX5D7GrzUYU7yf4nAhHabE1dUVii3LRrueLQ@mail.gmail.com>
 <dc73a810-ee9e-711e-dad0-76a566b923e4@redhat.com>
 <8dedfe22-8659-5684-99a6-e9d503a5b3e2@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8dedfe22-8659-5684-99a6-e9d503a5b3e2@redhat.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 04:00:03
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 John Snow <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Aug 07, 2020 at 11:06:55AM +0200, Thomas Huth wrote:
> On 07/08/2020 11.02, Paolo Bonzini wrote:
> > On 07/08/20 10:49, Peter Maydell wrote:
> >>> This the more or less final version of the Meson conversion.  Due to
> >>> the sheer size of the series you have been CCed only on the cover
> >>> letter.
> >>
> >> Does this work with actually-released versions of Meson yet?
> >> I am still not very enthusiastic about the prospect of having
> >> to carry around an entire build system in a submodule. That
> >> still seems to me to be living closer to the bleeding edge
> >> than I would like...
> > 
> > Yes it works with 0.55.0, with only a few warnings about possible future
> > incompatibility.  Those will be fixed in 0.56.0, where the feature was
> > stabilized without introducing any incompatibility.
> > 
> > Carrying around Meson in a submodule was mostly done to let QEMU build
> > transparently on older distros.  Removing it is easy (though it would
> > involve modifying the docker files to install the latest meson, so
> > whatever you throw out of the door comes back through the window).
> 
> From my point of view, we should keep the meson submodule at least 'till
> spring next year - then we'll remove support for RHEL7 according to our
> support policy. Hopefully the other distros will have a recent version
> of Meson at that point in time.

I very much doubt that will be the case. None of the distros rebase
meson in their stable streams. Given our targetted platforms, it is
going to be many years (3-4 years) before Meson is present in all the
platforms we target.

This is not the end of the world, as even 3-4 years is short term in
the overall lifetime of QEMU going into the future. Also not exactly
worse than bundling all the other stuff we bundle for years. If itis
a problem, then perhaps we can finally start shipping a 'qemu.tar.gz'
with no bundling at all, and a 'qemu-bundled.tar.gz' with all the
3rd party stuff  added.


We can, however, expect the distros to have new enough ninja.

If we bundle Meson, there's a risk that we see a new shiny feature
in next meson, and bump our sub-module to the next release. And
again. And again. And again. If we do that we'll never get to a
place where we can rely on distro Meson. That will be bad.

So I think we need to be very mindful of this and strongly resist
the urge to further increase our min meson version in future.


FWIW, for libvirt we decided that despite lack of distro support,
there was not a compelling reason to bundle meson, because it is
really trivial for users to update. e.g. just "pip install".

   pip install meson --user
   meson build
   ninja -C build

(possibly need to set $PATH if you don't already have $HOME/.local/bin
in your $PATH).


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


