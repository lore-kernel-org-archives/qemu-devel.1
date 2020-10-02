Return-Path: <SRS0=fJPX=DJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E100C4363D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE6302074B
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2020 13:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dF9uVpRK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE6302074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kOKrj-0008Ob-SV
	for qemu-devel@archiver.kernel.org; Fri, 02 Oct 2020 09:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOKqd-0007M1-Rg
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:11:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58027)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kOKqb-0002dS-R3
 for qemu-devel@nongnu.org; Fri, 02 Oct 2020 09:11:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601644298;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9oehqfd3ClazrR1vxs14+nwqmCN/L3eV3EEC1DtsFoQ=;
 b=dF9uVpRKjFNWI+PybiiBRVnsyUSmRn1F0SZsnLx6O87gvyEpkyMRXGpl+qRkLyThMPOlZM
 sYezdw/DsBbq6fBNjBFTsEig3FkDl5P0pWYNpLEvzy3Uky32E+wkKDLQwaGICVwIu6RrPX
 XL1X2GkDWYpVEvtG6ENhtlzGhO5bs+I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-Z2jTlr6ZNQim89Nbj4Td8A-1; Fri, 02 Oct 2020 09:11:36 -0400
X-MC-Unique: Z2jTlr6ZNQim89Nbj4Td8A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C5712803659;
 Fri,  2 Oct 2020 13:11:34 +0000 (UTC)
Received: from redhat.com (ovpn-114-9.ams2.redhat.com [10.36.114.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4824A5C1DA;
 Fri,  2 Oct 2020 13:11:33 +0000 (UTC)
Date: Fri, 2 Oct 2020 14:11:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Dan Streetman <ddstreet@canonical.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
Message-ID: <20201002131130.GB2338114@redhat.com>
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
 <20200922163441.GA2049853@redhat.com>
 <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/02 01:13:31
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Sep 30, 2020 at 09:28:54PM -0400, Dan Streetman wrote:
> On Tue, Sep 22, 2020 at 12:34 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Jul 29, 2020 at 03:58:29PM -0400, Dan Streetman wrote:
> > > The --disable-git-update configure param sets git_update=no, but
> > > some later checks only look for the .git dir. This changes the
> > > --enable-git-update to set git_update=yes but also fail if it
> > > does not find a .git dir. Then all the later checks for the .git
> > > dir can just be changed to a check for $git_update = "yes".
> > >
> > > Also update the Makefile to skip the 'git_update' checks if it has
> > > been disabled.
> > >
> > > This is needed because downstream packagers, e.g. Debian, Ubuntu, etc,
> > > also keep the source code in git, but do not want to enable the
> > > 'git_update' mode; with the current code, that's not possible even
> > > if the downstream package specifies --disable-git-update.
> >
> > Lets recap the original intended behaviour
> >
> >  1. User building from master qemu.git or a fork
> >      a) git_update=yes (default)
> >          - Always sync submodules to required commit
> >
> >      b) git_update=no  (--disable-git-update)
> >          - Never sync submodules, user is responsible for sync
> >          - Validate submodules are at correct commit and fail if not.
> >
> >  2. User building from tarball
> >      - Never do anything git related at all
> >
> >
> > Your change is removing the validation from  1.b).
> 
> Would you accept adding a --disable-git-submodules-check so downstream
> packagers can keep the source in git, but avoid the submodule
> validation?

It feels like the current option shouldn't be a boolean, rather
a tri-state    --with-git-submodules=[update|validate|ignore]

> Or do you have another suggestion for handling this?

Assuming you're just using git for conveniently applying local
downstream patches, you don't need the git repo to exist once
getting to the build stage. IOW just delete the .git dir after
applying patches before running a build.


Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


