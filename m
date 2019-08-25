Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70751C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:32:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45A58206DD
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 15:32:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45A58206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43150 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1uVL-0003Di-9V
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 11:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55339)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i1uUA-0002aa-H6
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:31:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i1uU9-0001D7-4I
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 11:31:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58578)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i1uU2-00016m-Cs; Sun, 25 Aug 2019 11:31:11 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4A9457F748;
 Sun, 25 Aug 2019 15:31:08 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.49])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7FE5C19C70;
 Sun, 25 Aug 2019 15:31:03 +0000 (UTC)
Message-ID: <cd1bc2cf3e2748db8aa686534ae7d84c71a58e69.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Max Reitz
 <mreitz@redhat.com>
Date: Sun, 25 Aug 2019 18:31:02 +0300
In-Reply-To: <e5e2c603c616b6a14419f9942016f7df0c177610.camel@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-6-mlevitsk@redhat.com>
 <6019b9e3-a4a6-4780-9652-f7c2bec024a5@redhat.com>
 <20190822104945.GJ3267@redhat.com>
 <e5e2c603c616b6a14419f9942016f7df0c177610.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.71]); Sun, 25 Aug 2019 15:31:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 05/13] qcrypto-luks: clear the masterkey
 and password before freeing them always
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
 qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 13:56 +0300, Maxim Levitsky wrote:
> On Thu, 2019-08-22 at 11:49 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Aug 20, 2019 at 08:12:51PM +0200, Max Reitz wrote:
> > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > While there are other places where these are still stored in memo=
ry,
> > > > this is still one less key material area that can be sniffed with
> > > > various side channel attacks
> > > >=20
> > > >=20
> > > >=20
> > >=20
> > > (Many empty lines here)
> > >=20
> > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > ---
> > > >  crypto/block-luks.c | 52 ++++++++++++++++++++++++++++++++++++++-=
------
> > > >  1 file changed, 44 insertions(+), 8 deletions(-)
> > >=20
> > > Wouldn=E2=80=99t it make sense to introduce a dedicated function fo=
r this?
> >=20
> > Yes, it would.
> >=20
> > In fact I have a series pending which bumps min glib and introduces
> > use of auto-free functions in this code.
> >=20
> > It would be desirable to have a autp-free func for memset+free
> > so we can just declare the variable
> >=20
> >    q_autowipefree char *password =3D NULL;
> >=20
> > and have it result in memset+free
> >=20
>=20
> That is perfect.
> When do you think you could post the series so that I could rebase
> on top of it?


I am thinking that I will keep my patch as is, just so that code is
consistent in memsetting the secrets (even though as Nir pointed out,
that these will be probably optimized away anyway).
And then when you send your patch you will just remove all
of these memsets.

Is this all right?=20

Best regards,
	Maxim Levitsky


