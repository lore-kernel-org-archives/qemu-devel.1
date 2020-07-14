Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D57C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:53:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6FC121D7D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bi/xE3ub"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6FC121D7D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55404 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHdJ-0004mA-5M
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:53:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58334)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvHcK-0003JA-9s
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:21572
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jvHcI-0003wH-BC
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594720369;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=4ahIVRdzroTWucRtnmtZSf+bit5vhDlHW2uFf3XtDWs=;
 b=Bi/xE3ubO0vMpPDPm9aWV+6m6AtyX057wthT+4ZHRLjhdUKBuZ5uf/MaeMePsS2NqRr600
 ofFua2I28JpEOmH51QV0BAkBIDSG8htFkBundKfm/rPebIOgvXenBuvUmX6FrMh1ZcdCd/
 SYOBINqoGI/s3QO4loprtN+Wof6iruc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-U1TwQ5vQMpS001brehneNg-1; Tue, 14 Jul 2020 05:52:47 -0400
X-MC-Unique: U1TwQ5vQMpS001brehneNg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EF2098015F3;
 Tue, 14 Jul 2020 09:52:45 +0000 (UTC)
Received: from redhat.com (unknown [10.36.110.42])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D799210013C1;
 Tue, 14 Jul 2020 09:52:36 +0000 (UTC)
Date: Tue, 14 Jul 2020 10:52:33 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 1/1] MAINTAINERS: introduce cve or security quotient field
Message-ID: <20200714095233.GC25187@redhat.com>
References: <20200714083631.888605-1-ppandit@redhat.com>
 <20200714083631.888605-2-ppandit@redhat.com>
 <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9QWLmi1fGuPW93GXFKV2KCwNs6Xp3U9MU2r4wtendzhg@mail.gmail.com>
User-Agent: Mutt/1.14.5 (2020-06-23)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>,
 Prasad J Pandit <pjp@fedoraproject.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Michael Roth <mdroth@linux.vnet.ibm.com>, P J P <ppandit@redhat.com>,
 Greg Kurz <groug@kaod.org>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 14, 2020 at 10:42:55AM +0100, Peter Maydell wrote:
> On Tue, 14 Jul 2020 at 09:40, P J P <ppandit@redhat.com> wrote:
> >
> > From: Prasad J Pandit <pjp@fedoraproject.org>
> >
> > QEMU supports numerous virtualisation and emulation use cases.
> > It also offers many features to support guest's function(s).
> >
> > All of these use cases and features are not always security relevant.
> > Because some maybe used in trusted environments only. Some may still
> > be in experimental stage. While other could be very old and not
> > used or maintained actively.
> >
> > For security bug analysis we generally consider use cases wherein
> > QEMU is used in conjunction with the KVM hypervisor, which enables
> > guest to use hardware processor's virtualisation features.
> >
> > The CVE (or Security or Trust) Quotient field tries to capture this
> > sensitivity pertaining to a feature or section of the code.
> >
> > It indicates whether a potential issue should be treated as a security
> > one OR it could be fixed as a regular non-security bug.
> 
> How does this interact with the way we already document our
> level of security support in docs/system/security.rst ?
> 
> > +       C: CVE/Security/Trust Quotient
> > +          H:High - Feature (or code) is meant to be safe and used by untrusted
> > +                   guests. So any potential security issue must be processed with
> > +                   due care and be considered as a CVE issue.
> > +          L:Low  - Feature (or code) is not meant to be safe OR is experimental
> > +                   OR is used in trusted environments only OR is not well
> > +                   maintained. So any potential security issue can be processed
> > +                   and fixed as regular non-security bug. No need for a CVE.
> 
> The difficulty with this is that MAINTAINERS is not set up
> with a split between "security issues" and "non-security
> issues". For instance this stanza:
> 
> > @@ -149,6 +161,7 @@ ARM TCG CPUs
> >  M: Peter Maydell <peter.maydell@linaro.org>
> >  L: qemu-arm@nongnu.org
> >  S: Maintained
> > +C: Low
> >  F: target/arm/
> >  F: tests/tcg/arm/
> >  F: tests/tcg/aarch64/
> 
> you have marked "Low", but the files it covers include
> both ones used by TCG (not security-critical) and ones
> used by KVM (security-critical).
> 
> Also, MAINTAINERS is not user-facing. If we want to say
> that vvfat or 9pfs are not suitable for use on a security
> boundary and that we do not consider bugs in them to
> be security issues, we should do that in the user-facing
> documentation.
> 
> Broadly speaking, it feels like you're trying to come up
> with an automatic way to say "does this patch touch a
> security-relevant part of the code", and I'm not sure
> that that's possible.

I agree that it isn't possible in the MAINTAINERS file, as the level
of granularity is a very poor match for what we want to express.

My high level thought would be that we should ultimately be able to
have a build flag to request only security-critical code is built
into the binaries.

This is probably a bit too much of a stretch goal right now, but it
at least points towards maintaining the information on a per-file
level of granularity. There might be some individual files which
currently contain a mix security-critical/not-security critical
code. Either they can be split eventually, or we can simply declare
that the entire file is none the less security critical.

We could perhaps have a magic comment at the top of each file that
is security critical. eg

 /* @security: maintained */

we don't need any comment in files we consider non-maintained from
a security POV.  Eventually we could do some (insert hand waving)
magic in meson to pull out this list of comments and use it to
exclude build of files that are not security critical. Maybe we
find out that using a magic comment isn't the best option, but
at least if we start now by keeping a per-file comment, we can
probably do an automated transformation to any other data storage
later.

Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


