Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 269C8C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F01A5233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:57:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F01A5233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kmf-0005Lf-4B
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:57:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46313)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0klg-0004Gj-3R
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:56:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0klf-0007si-2T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:56:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37952)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0klc-0007nf-Ui; Thu, 22 Aug 2019 06:56:33 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3E37D2BE94;
 Thu, 22 Aug 2019 10:56:32 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A00495E1C2;
 Thu, 22 Aug 2019 10:56:24 +0000 (UTC)
Message-ID: <e5e2c603c616b6a14419f9942016f7df0c177610.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, Max Reitz
 <mreitz@redhat.com>
Date: Thu, 22 Aug 2019 13:56:23 +0300
In-Reply-To: <20190822104945.GJ3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-6-mlevitsk@redhat.com>
 <6019b9e3-a4a6-4780-9652-f7c2bec024a5@redhat.com>
 <20190822104945.GJ3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.39]); Thu, 22 Aug 2019 10:56:32 +0000 (UTC)
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
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 11:49 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Tue, Aug 20, 2019 at 08:12:51PM +0200, Max Reitz wrote:
> > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > While there are other places where these are still stored in memory=
,
> > > this is still one less key material area that can be sniffed with
> > > various side channel attacks
> > >=20
> > >=20
> > >=20
> >=20
> > (Many empty lines here)
> >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  crypto/block-luks.c | 52 ++++++++++++++++++++++++++++++++++++++---=
----
> > >  1 file changed, 44 insertions(+), 8 deletions(-)
> >=20
> > Wouldn=E2=80=99t it make sense to introduce a dedicated function for =
this?
>=20
> Yes, it would.
>=20
> In fact I have a series pending which bumps min glib and introduces
> use of auto-free functions in this code.
>=20
> It would be desirable to have a autp-free func for memset+free
> so we can just declare the variable
>=20
>    q_autowipefree char *password =3D NULL;
>=20
> and have it result in memset+free
>=20

That is perfect.
When do you think you could post the series so that I could rebase
on top of it?

Best regards,
	Maxim Levitsky


