Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2FDC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:59:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FBB233A0
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:59:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FBB233A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40670 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0koW-00081m-DI
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0kml-0005tI-Ug
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0kmk-0000sD-VH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:57:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:20329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0kmh-0000pW-Cr; Thu, 22 Aug 2019 06:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8BB46308FFB1;
 Thu, 22 Aug 2019 10:57:38 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 849E060603;
 Thu, 22 Aug 2019 10:57:36 +0000 (UTC)
Message-ID: <e4e8999ce701759a67c394051a70b25ba0cfd619.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 22 Aug 2019 13:57:35 +0300
In-Reply-To: <20190822103253.GF3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-4-mlevitsk@redhat.com>
 <56f412ca-1985-589c-85b4-a8164f701a64@redhat.com>
 <426e109e6799ba1c9e045541777aeae9183b6134.camel@redhat.com>
 <20190822103253.GF3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 22 Aug 2019 10:57:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 03/13] qcrypto-luks: refactoring: extract
 load/store/check/parse header functions
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
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 11:32 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Aug 22, 2019 at 01:43:05AM +0300, Maxim Levitsky wrote:
> > On Tue, 2019-08-20 at 20:01 +0200, Max Reitz wrote:
> > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > With upcoming key management, the header will
> > > > need to be stored after the image is created.
> > > >=20
> > > > Extracting load header isn't strictly needed, but
> > > > do this anyway for the symmetry.
> > > >=20
> > > > Also I extracted a function that does basic sanity
> > > > checks on the just read header, and a function
> > > > which parses all the crypto format to make the
> > > > code a bit more readable, plus now the code
> > > > doesn't destruct the in-header cipher-mode string,
> > > > so that the header now can be stored many times,
> > > > which is needed for the key management.
> > > >=20
> > > > Also this allows to contain the endianess conversions
> > > > in these functions alone
> > > >=20
> > > > The header is no longer endian swapped in place,
> > > > to prevent (mostly theoretical races I think)
> > > > races where someone could see the header in the
> > > > process of beeing byteswapped.
> > >=20
> > > The formatting looks weird, it doesn=E2=80=99t look quite 72 charac=
ters wide...
> > >  (what commit messages normally use)
> >=20
> > Could you elaborate on that? I thought that code should not
> > exceed 80 character limit.
>=20
> Code itself should be wrapped at 80 chars, but it is common for
> commit messages to use 72 chars wrapping.
>=20
>=20
> Regards,
> Daniel
All right, will do this.
Best regards,
	Maxim Levitsky


