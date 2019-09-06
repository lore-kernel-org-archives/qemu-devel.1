Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39E3C43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:24:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D5A82082C
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 09:24:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D5A82082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53784 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6AU9-0003Lf-N8
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 05:24:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i6ATW-0002wz-Ci
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:24:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i6ATS-0008Ty-Rd
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:24:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51768)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>) id 1i6ATS-0008TQ-JC
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 05:24:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B81C3307D88D;
 Fri,  6 Sep 2019 09:24:08 +0000 (UTC)
Received: from redhat.com (ovpn-112-50.ams2.redhat.com [10.36.112.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C42F05D9CA;
 Fri,  6 Sep 2019 09:24:06 +0000 (UTC)
Date: Fri, 6 Sep 2019 10:24:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190906092403.GO5119@redhat.com>
References: <20190905134526.32146-1-berrange@redhat.com>
 <CAFEAcA8-C4V6EQBZDvLUaL+WoLfnr4wB6tiQNAtH1wN1kRQN3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8-C4V6EQBZDvLUaL+WoLfnr4wB6tiQNAtH1wN1kRQN3Q@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Fri, 06 Sep 2019 09:24:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PULL 0/4] Docs patches
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
Cc: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Sep 05, 2019 at 04:34:33PM +0100, Peter Maydell wrote:
> On Thu, 5 Sep 2019 at 14:45, Daniel P. Berrang=C3=A9 <berrange@redhat.c=
om> wrote:
> >
> > The following changes since commit 500efcfcf0fe2e0dae1d25637a13435ce7=
b6e421:
> >
> >   Merge remote-tracking branch 'remotes/rth/tags/pull-or1k-20190904' =
into staging (2019-09-05 09:33:01 +0100)
> >
> > are available in the Git repository at:
> >
> >   https://github.com/berrange/qemu tags/docs-pull-request
> >
> > for you to fetch changes up to 9f8efa74d3f1cb9ceeee957ee382c2b4feb2ae=
30:
> >
> >   docs: split the CODING_STYLE doc into distinct groups (2019-09-05 1=
4:41:00 +0100)
> >
> > ----------------------------------------------------------------
> >
> > * Merges HACKING into CODING_STYLE
> > * Converts README and CODING_STYLE docs into RST syntax
> > * Documents use of auto cleanup functions
> >
> > ----------------------------------------------------------------
> >
> > Daniel P. Berrang=C3=A9 (4):
> >   docs: convert README, CODING_STYLE and HACKING to RST syntax
> >   docs: merge HACKING.rst contents into CODING_STYLE.rst
> >   docs: document use of automatic cleanup functions in glib
> >   docs: split the CODING_STYLE doc into distinct groups
> >
> >  CODING_STYLE          | 216 --------------
> >  CODING_STYLE.rst      | 641 ++++++++++++++++++++++++++++++++++++++++=
++
> >  HACKING               | 257 -----------------
> >  README =3D> README.rst  |  47 ++--
> >  scripts/checkpatch.pl |   2 +-
>=20
> I'm going to apply this, but something I thought of looking at
> the diffstat: should some or all of this be in the docs/devel
> manual rather than free-floating rst files in the root directory?

The answer really hinges on whether moving CODING_STYLE into the
docs/devel directory will make it less obvious to users.

On a related point, with the prevelance of github/gitlab for
hosting, it has become fairly common to have a top level
CONTRIBUTING.md file, with guidance of key factors relating
to contributing - how to submit patches, code of conduct,
developer signoff, coding style, etc. This file doesn't
have to contain the actual content - often people just use
it as an index to link to all the individual topic docs:

  https://github.com/rails/rails/blob/master/CONTRIBUTING.md
  https://github.com/atom/atom/blob/master/CONTRIBUTING.md
  https://gitlab.com/gitlab-org/gitlab-ce/blob/master/CONTRIBUTING.md
  https://github.com/creativecommons/.github/blob/master/CONTRIBUTING.md

So we could just move CODING_STYLE into the docs/devel dir and link
to it from a CONTRIBUTING.md (well .rst) file.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

