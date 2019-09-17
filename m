Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C90CC4CEC9
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:44:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2194A2053B
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 13:44:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2194A2053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iADmh-0005oU-1G
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 09:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46650)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1iADko-0004Gb-0M
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:42:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1iADkl-0008QE-NT
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 09:42:49 -0400
Received: from mx1.redhat.com ([209.132.183.28]:25941)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1iADkf-0008OJ-Iq; Tue, 17 Sep 2019 09:42:41 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DF65A8A2195;
 Tue, 17 Sep 2019 13:42:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-202.ams2.redhat.com
 [10.36.116.202])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A63BE6012E;
 Tue, 17 Sep 2019 13:42:37 +0000 (UTC)
Date: Tue, 17 Sep 2019 15:42:35 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190917134235.GC4824@localhost.localdomain>
References: <20190819201851.24418-1-mreitz@redhat.com>
 <20190819201851.24418-7-mreitz@redhat.com>
 <44f97011-4a02-7832-c253-d43474f79d44@redhat.com>
 <a829185c-7c09-5afe-1479-15054ad59807@redhat.com>
 <33f60f4e-8156-e46f-8500-79b0982348b2@redhat.com>
 <c38acedf-d3db-384f-4aea-967ef3f87fdd@redhat.com>
 <20190917084012.GA4824@localhost.localdomain>
 <e9c8a9f5-80d9-b003-8036-0ba8df352ec3@redhat.com>
 <20190917112212.GB4824@localhost.localdomain>
 <1bed5587-63bf-2fe5-fe6a-4ac337058e2a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1bed5587-63bf-2fe5-fe6a-4ac337058e2a@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Tue, 17 Sep 2019 13:42:40 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 6/8] iotests: Test driver whitelisting
 in 093
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 17.09.2019 um 15:09 hat John Snow geschrieben:
> On 9/17/19 7:22 AM, Kevin Wolf wrote:
> > Am 17.09.2019 um 13:07 hat Max Reitz geschrieben:
> >> On 17.09.19 10:40, Kevin Wolf wrote:
> >>> Am 17.09.2019 um 10:18 hat Max Reitz geschrieben:
> >>>> On 13.09.19 20:30, John Snow wrote:
> >>>>> I'd still like to define func_wrapper with a nod to the type cons=
traint
> >>>>> it has:
> >>>>>
> >>>>> def func_wrapper(instance: iotests.QMPTestCase, *args, **kwargs):
> >>>>>     [...]
> >>>>>
> >>>>>
> >>>>> Then, you'd write:
> >>>>>
> >>>>> if callable(required_formats):
> >>>>>     fmts =3D required_formats(instance)
> >>>>> else:
> >>>>>     fmts =3D required_formats
> >>>>
> >>>> Yep, that anyway.  (Although I didn=E2=80=99t know about the =E2=80=
=9Cparam: type=E2=80=9D
> >>>> syntax and put that constraint in a comment instead.  Thanks again=
 :-))
> >>>
> >>> Note that function annotations are Python 3 only, so we can't use t=
hat
> >>> syntax yet anyway. If you want to use type hints that are understoo=
d by
> >>> tools (like mypy) and compatible with Python 2, you have to use
> >>> something like this (feel free to be more specific than Any):
> >>
> >> Do we really feel like staying compatible with Python 2, though?
> >=20
> > Feel like it? No.
> >=20
> > It's more that we are compelled to do so because we only deprecated i=
t
> > in 4.1.
>=20
> Sorry for the impromptu lesson on type hints in 3.5! I added that in to
> my suggestion as a demonstrative example and didn't mean for you to use
> it as-is, sorry for not making that clear.
>=20
> I'm confused about the Python3 deprecation timeline. Normally we'd
> follow our standard approach, but it does hit EOL at the end of this
> year, so do we drop support then, too? I have the memory of a goldfish =
I
> suppose, and can't quite remember our conclusions, if any, of previous
> discussions on this subject.

It shouldn't make a difference actually because deprecation in 4.1 means
that 4.2 (in December) will be the last release that must still support
Python 2, and we can switch to Python 3 for 5.0.

> If we do drop python2 though, the new minimum version appears to be 3.5
> because that's what ships in EPEL. That'd give us standardized type
> hints that we can use for static analysis tools.

Actually I seem to remember I suggested that we should make 3.5 the
minimum Python 3 version, and I thought a patch to this effect had been
merged, but now I can't find any such check in configure. Maybe I should
find the old thread again to see if there was any reason not to do this.

Personally, I would have preferred 3.6 because it brings in variable
annotations, but I think last time the conclusion was that it would be
3.5 indeed.

Kevin

