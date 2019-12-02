Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BA21C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:29:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A9D720718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:29:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWr4m+uv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A9D720718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43140 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqSA-0007Tf-J3
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:29:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60844)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <crosa@redhat.com>) id 1ibqRL-0006oa-J8
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:28:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <crosa@redhat.com>) id 1ibqRJ-0005UQ-3W
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:28:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55045
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <crosa@redhat.com>) id 1ibqRI-0005Tf-Vw
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:28:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575311332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClzXoSZu6d6XlbyFYQeekvGdgH5IbxdIFyqnHWzk+y0=;
 b=CWr4m+uvwED28h0lu8cYa+7644KXvkuCGWgpoYS41oAEo0F8GzDm7q7/Cp3p6OI7vkBt77
 z4XYi913AJ4Hq6pe4eAKFd7QnbM+olErYrY4rz+mFfGWKg9vjeXm4OnwkxecFmOMW+o37s
 rPKSByVi45pR2r/Bc1kbpPt2TVIaW8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-167-le6uAItXPrWZgENDFjzGQA-1; Mon, 02 Dec 2019 13:28:51 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2A817800C71;
 Mon,  2 Dec 2019 18:28:50 +0000 (UTC)
Received: from localhost.localdomain (ovpn-122-75.rdu2.redhat.com
 [10.10.122.75])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 81402600C8;
 Mon,  2 Dec 2019 18:28:42 +0000 (UTC)
Date: Mon, 2 Dec 2019 13:28:40 -0500
From: Cleber Rosa <crosa@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [RFC] QEMU Gating CI
Message-ID: <20191202182840.GA24511@localhost.localdomain>
References: <20191202140552.GA5353@localhost.localdomain>
 <20191202170018.GD139090@stefanha-x1.localdomain>
 <CAFEAcA_fB1o95JitpzcZ4rtspxfD8dfkUZ3ZOcdMcAQpDFtYYQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_fB1o95JitpzcZ4rtspxfD8dfkUZ3ZOcdMcAQpDFtYYQ@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: le6uAItXPrWZgENDFjzGQA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Jeff Nelson <jen@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Ademar Reis <areis@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Dec 02, 2019 at 05:08:35PM +0000, Peter Maydell wrote:
> On Mon, 2 Dec 2019 at 17:00, Stefan Hajnoczi <stefanha@redhat.com> wrote:
> >
> > On Mon, Dec 02, 2019 at 09:05:52AM -0500, Cleber Rosa wrote:
> > > To exemplify my point, if one specific test run as part of "check-tcg=
"
> > > is found to be faulty on a specific job (say on a specific OS), the
> > > entire "check-tcg" test set may be disabled as a CI-level maintenance
> > > action.  Of course a follow up action to deal with the specific test
> > > is required, probably in the form of a Launchpad bug and patches
> > > dealing with the issue, but without necessarily a CI related angle to
> > > it.
> >
> > I think this coarse level of granularity is unrealistic.  We cannot
> > disable 99 tests because of 1 known failure.  There must be a way of
> > disabling individual tests.  You don't need to implement it yourself,
> > but I think this needs to be solved by someone before a gating CI can b=
e
> > put into use.
> >
> > It probably involves adding a "make EXCLUDE_TESTS=3Dfoo,bar check"
> > variable so that .gitlab-ci.yml can be modified to exclude specific
> > tests on certain OSes.
>=20
> We don't have this at the moment, so I'm not sure we need to
> add it as part of moving to doing merge testing via gitlab ?
> The current process is "if the pullreq causes a test to fail
> then the pullreq needs to be changed, perhaps by adding a
> patch which disables the test on a particular platform if
> necessary". Making that smoother might be nice, but I would
> be a little wary about adding requirements to the move-to-gitlab
> that don't absolutely need to be there.
>=20
> thanks
> -- PMM
>=20

Right, it goes without saying that:

1) I acknowledge the problem (and I can have a long conversation
about it :)

2) I don't think it has to be a prerequisite to the "move-to-gitlab"
effort

Thanks,
- Cleber.


