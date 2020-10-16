Return-Path: <SRS0=JoQ+=DX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B21C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:53:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BCCB72076C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2020 20:53:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BCCB72076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=canonical.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41198 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kTWjD-0005Dm-H6
	for qemu-devel@archiver.kernel.org; Fri, 16 Oct 2020 16:53:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dan.streetman@canonical.com>)
 id 1kTWiI-0004li-Fx
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:52:35 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:43513)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
 (Exim 4.90_1) (envelope-from <dan.streetman@canonical.com>)
 id 1kTWiC-0002oZ-Mi
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 16:52:34 -0400
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by youngberry.canonical.com with esmtps
 (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128) (Exim 4.86_2)
 (envelope-from <dan.streetman@canonical.com>) id 1kTWi8-0001tD-KJ
 for qemu-devel@nongnu.org; Fri, 16 Oct 2020 20:52:24 +0000
Received: by mail-io1-f70.google.com with SMTP id s135so2501872ios.6
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2020 13:52:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GFZeo4JxcJxg//iXP1FLpGz85o/VJn68BDvQ1AnLb40=;
 b=IPDN8Rm8shNvPU0m/tsv2wKQPjRLVnC0qiY0k37EVhFTYUzpOjwzUr3w2ZOHbiRymO
 GRm59ix969etbJ8aaIJNp21olL16FplbVykMXqFWanPTM/DqkeYgTxxciDHPg22UByfr
 dvue8I8nHw2BTN/G2lbPLRkI/g43kugg9p9hWK7nbKY+RgGRFadQSstqpC4QkedhPjXz
 2sxjvtOYPyljuOGxCRXSYEr+ttarXH0bs8oSqrwNSXkNEbpkQWL2WMalCxoysTru5eYi
 yMZ1pLwl9TJt5nCN/xar/xbW4RjwOpIRCUpdfBmx4JlJfQLKYnQwlBmON3xGe1pHFPOy
 mi2g==
X-Gm-Message-State: AOAM533HgKym+kCFJsiAzx7V3KeLvI6OhvbvS9TPyUJ9acWdJkBZh0NL
 joUVHHfaLCgiE0C2rG2jn/C2O81YG+r6jCFUyTcB75sNc1gtIaDUiXxxW2c74r1AaSp9dztwvl4
 sDfp9VxbTA5AFAKBvCdKdUHF4mIx7TBHvJrdcD7cqHVB3yTG1
X-Received: by 2002:a02:c557:: with SMTP id g23mr4187658jaj.5.1602881543403;
 Fri, 16 Oct 2020 13:52:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyM1KsEq+mbtiGh9zMvDb/2EKjNsCi19A+ntH3wJRFl6ialat6ja+YwXhYMLGbMmboLjpnr7gWU6vtwmxEHmww=
X-Received: by 2002:a02:c557:: with SMTP id g23mr4187640jaj.5.1602881543087;
 Fri, 16 Oct 2020 13:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <e55fea6e-e403-166f-e693-9e73ae29e5cc@msgid.tls.msk.ru>
 <20200729195829.1335082-1-ddstreet@canonical.com>
 <20200922163441.GA2049853@redhat.com>
 <CAOZ2QJPsSTH4MStgduBGjhvaH-5-Tgj7-++qYLbSmQnqWQPpug@mail.gmail.com>
 <20201002131130.GB2338114@redhat.com>
In-Reply-To: <20201002131130.GB2338114@redhat.com>
From: Dan Streetman <ddstreet@canonical.com>
Date: Fri, 16 Oct 2020 16:51:47 -0400
Message-ID: <CAOZ2QJOJSFzMZZTRxV4Deq945CbVgzQD9i70FLVWnYL4QWwokQ@mail.gmail.com>
Subject: Re: [PATCH] configure: actually disable 'git_update' mode with
 --disable-git-update
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: none client-ip=91.189.89.112;
 envelope-from=dan.streetman@canonical.com; helo=youngberry.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/16 16:39:41
X-ACL-Warn: Detected OS   = Linux 3.1-3.10
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Christian Ehrhardt <christian.ehrhardt@canonical.com>,
 Rafael David Tinoco <rafael.tinoco@canonical.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 2, 2020 at 9:11 AM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> On Wed, Sep 30, 2020 at 09:28:54PM -0400, Dan Streetman wrote:
> > On Tue, Sep 22, 2020 at 12:34 PM Daniel P. Berrang=C3=A9 <berrange@redh=
at.com> wrote:
> > >
> > > On Wed, Jul 29, 2020 at 03:58:29PM -0400, Dan Streetman wrote:
> > > > The --disable-git-update configure param sets git_update=3Dno, but
> > > > some later checks only look for the .git dir. This changes the
> > > > --enable-git-update to set git_update=3Dyes but also fail if it
> > > > does not find a .git dir. Then all the later checks for the .git
> > > > dir can just be changed to a check for $git_update =3D "yes".
> > > >
> > > > Also update the Makefile to skip the 'git_update' checks if it has
> > > > been disabled.
> > > >
> > > > This is needed because downstream packagers, e.g. Debian, Ubuntu, e=
tc,
> > > > also keep the source code in git, but do not want to enable the
> > > > 'git_update' mode; with the current code, that's not possible even
> > > > if the downstream package specifies --disable-git-update.
> > >
> > > Lets recap the original intended behaviour
> > >
> > >  1. User building from master qemu.git or a fork
> > >      a) git_update=3Dyes (default)
> > >          - Always sync submodules to required commit
> > >
> > >      b) git_update=3Dno  (--disable-git-update)
> > >          - Never sync submodules, user is responsible for sync
> > >          - Validate submodules are at correct commit and fail if not.
> > >
> > >  2. User building from tarball
> > >      - Never do anything git related at all
> > >
> > >
> > > Your change is removing the validation from  1.b).
> >
> > Would you accept adding a --disable-git-submodules-check so downstream
> > packagers can keep the source in git, but avoid the submodule
> > validation?
>
> It feels like the current option shouldn't be a boolean, rather
> a tri-state    --with-git-submodules=3D[update|validate|ignore]
>

Ok, I updated the patch to do that:
https://lists.nongnu.org/archive/html/qemu-devel/2020-10/msg04799.html

> > Or do you have another suggestion for handling this?
>
> Assuming you're just using git for conveniently applying local
> downstream patches, you don't need the git repo to exist once
> getting to the build stage. IOW just delete the .git dir after
> applying patches before running a build.
>
>
> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
>

