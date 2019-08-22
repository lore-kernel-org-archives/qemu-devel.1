Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B1CDC3A5A1
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:06:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0166C2133F
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 15:06:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0166C2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0of7-0007K4-U5
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 11:06:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40553)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0odZ-0006La-Lt
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0odY-0005e9-L6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 11:04:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37896)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0odV-0005bM-Cx; Thu, 22 Aug 2019 11:04:25 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E588F308A9E0;
 Thu, 22 Aug 2019 15:04:23 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5C3341001DC0;
 Thu, 22 Aug 2019 15:04:16 +0000 (UTC)
Message-ID: <25e2e19f476990a187d30a61b134646a4ca96593.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 18:04:15 +0300
In-Reply-To: <b3a06e6c-c2b1-32f2-50c9-f7c87119a17f@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-2-mlevitsk@redhat.com>
 <a55bee89-9f0a-07ee-e411-7f2811449199@redhat.com>
 <dfad98e6072f37d0a10f4f7c0b5c96aee77aaf18.camel@redhat.com>
 <b3a06e6c-c2b1-32f2-50c9-f7c87119a17f@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.41]); Thu, 22 Aug 2019 15:04:23 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 01/13] block-crypto: misc refactoring
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
 "Daniel P. =?ISO-8859-1?Q?Berrang=E9?=" <berrange@redhat.com>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 16:34 +0200, Max Reitz wrote:
> On 22.08.19 02:05, Maxim Levitsky wrote:
> > On Tue, 2019-08-20 at 18:38 +0200, Max Reitz wrote:
> > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > * rename the write_func to create_write_func,
> > > >   and init_func to create_init_func
> > > >   this is  preparation for other write_func that will
> > > >   be used to update the encryption keys.
> > > >=20
> > > > No functional changes
> > > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  block/crypto.c | 15 ++++++++-------
> > > >  1 file changed, 8 insertions(+), 7 deletions(-)
> > > >=20
> > >=20
> > > I=E2=80=99m not quite sure why you remove or add blank lines seemin=
gly at random...
> >=20
> > Basically to have consistent two space separation between all functio=
ns.
> > A bit of OCD I confess :-)
>=20
> Well, it didn=E2=80=99t work because in one place you added two empty l=
ines
> where we already had two, so there are four now.
Exactly :-)=20

While the reason I sometimes add/remove black lines between functions
is this, this time this was just a leftover from some stuff I removed and=
 forget
to remove the black lines. Usually prior to sending the patches I 'polish=
' very
carefully such stuff, but this time since I send up the RFC, I didn't do =
that=20
that well thus various issues like that poped up.


Best regards,
	Maxim Levitsky


