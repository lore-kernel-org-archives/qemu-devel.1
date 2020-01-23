Return-Path: <SRS0=mO9Z=3M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4110FC2D0DB
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C99520718
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jan 2020 18:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U4WwNSEq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C99520718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iugpC-0004Ko-0d
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 13:03:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iueRt-0000XY-MT
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iueRr-00042A-2Z
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58855
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iueRp-00041M-N1
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 10:31:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579793468;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pKcISCskl+WWDqr2Z+V3Nk+BZOY8G5LBK+LhZYLVt+Y=;
 b=U4WwNSEqmZWjyrDLZljPuOnoc3vIAiqbx3fWVnkPJ1qFRrYjDqg11zPcakhK30AT9eW+g0
 fvGVcTor7kifxVp87nhEWLjjdKwoN0JvVZItnuRh5Kuh3XQKNeNGQD4/1z4OWJNJBkhf6L
 bOyLEa16gGg5HQR7uN38sv7xUiQuzag=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-381-kVbP9LUvNlekboIby00a9A-1; Thu, 23 Jan 2020 10:31:04 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 441708C3EFB;
 Thu, 23 Jan 2020 15:31:03 +0000 (UTC)
Received: from work-vm (ovpn-116-110.ams2.redhat.com [10.36.116.110])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DA9AD28DC1;
 Thu, 23 Jan 2020 15:30:54 +0000 (UTC)
Date: Thu, 23 Jan 2020 15:30:52 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, berrange@redhat.com
Subject: Re: [PULL 000/111] virtiofs queue
Message-ID: <20200123153052.GA2732@work-vm>
References: <20200123115841.138849-1-dgilbert@redhat.com>
 <CAFEAcA_7T2Yu8fXv7XycSSN=8xoi8aciR5NMh76o8LQxNU6rDw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_7T2Yu8fXv7XycSSN=8xoi8aciR5NMh76o8LQxNU6rDw@mail.gmail.com>
User-Agent: Mutt/1.13.0 (2019-11-30)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: kVbP9LUvNlekboIby00a9A-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> On Thu, 23 Jan 2020 at 12:54, Dr. David Alan Gilbert (git)
> <dgilbert@redhat.com> wrote:
> >
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> >
> > The following changes since commit 3e08b2b9cb64bff2b73fa9128c0e49bfcde0=
dd40:
> >
> >   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20=
200121' into staging (2020-01-21 15:29:25 +0000)
> >
> > are available in the Git repository at:
> >
> >   git@gitlab.com:dagrh/qemu.git tags/pull-virtiofs-20200123
> >
> > for you to fetch changes up to 87509325f70c78a28683f9460699915ea3300091=
:
> >
> >   virtiofsd: add some options to the help message (2020-01-23 10:54:49 =
+0000)
> >
> > ----------------------------------------------------------------
> > virtiofsd first pull
> >
> > Import our virtiofsd.
> > This pulls in the daemon to drive a file system connected to the
> > existing qemu virtiofsd device.
> > It's derived from upstream libfuse with lots of changes (and a lot
> > trimmed out).
> > The daemon lives in the newly created qemu/tools/virtiofsd
> >
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
>=20
>=20
> >  docs/tools/conf.py                        |   16 +
> >  docs/tools/index.rst                      |   14 +
> >  docs/tools/virtiofsd-security.rst         |  118 ++
>=20
> Do we really want a new top-level manual? This isn't
> in the plan: https://wiki.qemu.org/Features/Documentation
>=20
> What defines what goes in docs/tools rather than
> docs/interop (like qemu-nbd and qemu-img do) ?

In my v1 patchset this lived in tools/virtiofsd and I hadn't
wired up the top level index, however discussion with Daniel
we came up with docs/tools/virtiofsd. See:

https://lists.gnu.org/archive/html/qemu-devel/2020-01/msg00793.html

My suggestion is that more should move into tools and docs/tools
since they're not really 'interop' - but I don't have a strong feeling
as long as we can quickly come to an agreement.

Dave

> thanks
> -- PMM
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


