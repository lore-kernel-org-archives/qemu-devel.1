Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264DBC3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:05:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1CA6206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 17:05:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1CA6206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1vxB-0005gx-2r
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 13:05:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38757)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vwB-0005BR-Va
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:04:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1vwA-0007Dc-VV
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 13:04:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48234)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1vw8-0007C6-PM; Sun, 25 Aug 2019 13:04:16 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BB9315AFE3;
 Sun, 25 Aug 2019 17:04:15 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 170675D6A3;
 Sun, 25 Aug 2019 17:04:10 +0000 (UTC)
Message-ID: <def25014208484c8f82c998bd0ccbb95a5cf700d.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, "Daniel P." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Sun, 25 Aug 2019 20:04:09 +0300
In-Reply-To: <28be6b06-1a26-dd9a-806b-66df67da7f07@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-13-mlevitsk@redhat.com>
 <80e25f5b-b26c-7867-bb3a-0992029b33b9@redhat.com>
 <20190822113222.GQ3267@redhat.com>
 <28be6b06-1a26-dd9a-806b-66df67da7f07@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Sun, 25 Aug 2019 17:04:15 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/13] qemu-img: implement key management
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 16:42 +0200, Max Reitz wrote:
> On 22.08.19 13:32, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Aug 20, 2019 at 08:29:55PM +0200, Max Reitz wrote:
> > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  block/crypto.c   |  16 ++++++
> > > >  block/crypto.h   |   3 +
> > > >  qemu-img-cmds.hx |  13 +++++
> > > >  qemu-img.c       | 140 +++++++++++++++++++++++++++++++++++++++++=
++++++
> > > >  4 files changed, 172 insertions(+)
> > >=20
> > > Yes, this seems a bit weird.  Putting it under amend seems like the
> > > natural thing if that works; if not, I think it should be a single
> > > qemu-img subcommand instead of two.
> >=20
> > I'm not convinced by overloading two distinct operations on to one
> > sub-command - doesn't seem to give an obvious benefit to overload
> > them & IME experiance overloading results in harder to understand
> > commands due to having distinct args to each command.
>=20
> Because it suits the qemu-img interface we currently have.  For example=
,
> we have a single subcommand for internal snapshot management (=E2=80=9C=
qemu-img
> snapshot=E2=80=9D), so I think it makes sense to have a single subcomma=
nd for
> encrypted image management.

I personally don't care, other that I do thing that the best here is to u=
se
the amend interface.

>=20
> Max
>=20

Best regards,
	Maxim Levitsky


