Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2C3C31E40
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 909CF2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 08:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 909CF2064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBVV-0001r5-Ll
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 04:53:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40838)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <abologna@redhat.com>) id 1hyBUh-0001Gp-AZ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:52:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <abologna@redhat.com>) id 1hyBUg-0004NK-95
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 04:52:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51192)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <abologna@redhat.com>)
 id 1hyBUd-0004M9-Tr; Thu, 15 Aug 2019 04:52:24 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2B6892A09CA;
 Thu, 15 Aug 2019 08:52:23 +0000 (UTC)
Received: from kinshicho (unknown [10.43.2.73])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5AD8E45D1;
 Thu, 15 Aug 2019 08:52:18 +0000 (UTC)
Message-ID: <3bb3f4872c452fc9af2fc982b991a72dd3928a4e.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,  "Richard
 W . M . Jones" <rjones@redhat.com>, qemu-devel@nongnu.org, Pino Toscano
 <ptoscano@redhat.com>
Date: Thu, 15 Aug 2019 10:52:17 +0200
In-Reply-To: <e47b3d6e-c68d-c9f2-3681-3f29a5543ce7@redhat.com>
References: <20190814121527.17876-1-philmd@redhat.com>
 <20190814121527.17876-3-philmd@redhat.com>
 <4876e26ccda980f45e0ad1492097a66b07fe65de.camel@redhat.com>
 <ca03335f-55a1-322f-401d-a02a2d115b66@redhat.com>
 <9becb1b8d13703740411ae0e1e6e0580fe6a1bc7.camel@redhat.com>
 <e47b3d6e-c68d-c9f2-3681-3f29a5543ce7@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Thu, 15 Aug 2019 08:52:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/4] configure: Avoid using libssh
 deprecated API
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?Q?=E5=91=A8=E6=96=87=E9=9D=92?= <1151451036@qq.com>,
 Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-08-14 at 17:14 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> On 8/14/19 4:51 PM, Andrea Bolognani wrote:
> > On Wed, 2019-08-14 at 16:15 +0200, Philippe Mathieu-Daud=C3=A9 wrote:
> > > On 8/14/19 3:27 PM, Andrea Bolognani wrote:
> > > > On Wed, 2019-08-14 at 14:15 +0200, Philippe Mathieu-Daud=C3=A9 wr=
ote:
> > > > > Suggested-by: Andrea Bolognani <abologna@redhat.com>
> > > > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> > > > > ---
> > > > >  block/ssh.c | 2 +-
> > > > >  configure   | 7 +++++++
> > > > >  2 files changed, 8 insertions(+), 1 deletion(-)
> > > >=20
> > > > Did I really suggest this? I have no recollection of doing so, or
> > > > even getting involved with libssh support in QEMU at all for that
> > > > matter.
> > >=20
> > > I took this suggestion from
> > > https://www.redhat.com/archives/libvir-list/2018-May/msg00597.html
> >=20
> > I see :)
> >=20
> > I feel like adding a Suggested-by because of something that was
> > posted on an unrelated project's mailing list is stretching the
> > definition of the tag a bit, so if you end up having to respin I
> > think it would be reasonable to drop it, but honestly it's not a
> > big deal either way: I was just curious.
>=20
> Understood, sorry.

Nothing to apologize for! :)

--=20
Andrea Bolognani / Red Hat / Virtualization


