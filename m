Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D953C4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 404D0206CD
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 22:46:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 404D0206CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8XrE-0008Nw-61
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 18:46:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44620)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Xph-0007KT-Vl
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:44:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8Xpg-0005YN-1B
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 18:44:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43340)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8Xpa-0005W9-98; Thu, 12 Sep 2019 18:44:51 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id AA743C08EC0F;
 Thu, 12 Sep 2019 22:44:48 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 70A5519C5B;
 Thu, 12 Sep 2019 22:44:46 +0000 (UTC)
Message-ID: <ce0a42dfc06429ac3f1b5debee8aded308421db8.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Fri, 13 Sep 2019 01:44:44 +0300
In-Reply-To: <20190722090556.GC23775@redhat.com>
References: <20190721181508.28608-1-mlevitsk@redhat.com>
 <20190721181508.28608-2-mlevitsk@redhat.com>
 <20190722090556.GC23775@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Thu, 12 Sep 2019 22:44:49 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/2] LUKS: better error message when
 creating too large files
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 2019-07-22 at 10:05 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Sun, Jul 21, 2019 at 09:15:07PM +0300, Maxim Levitsky wrote:
> > Currently if you attampt to create too large file with luks you
> > get the following error message:
> >=20
> > Formatting 'test.luks', fmt=3Dluks size=3D17592186044416 key-secret=3D=
sec0
> > qemu-img: test.luks: Could not resize file: File too large
> >=20
> > While for raw format the error message is
> > qemu-img: test.img: The image size is too large for file format 'raw'
> >=20
> >=20
> > The reason for this is that qemu-img checks for errono of the failure=
,
> > and presents the later error when it is -EFBIG
> >=20
> > However crypto generic code 'swallows' the errno and replaces it
> > with -EIO.
> >=20
> > As an attempt to make it better, we can make luks driver,
> > detect -EFBIG and in this case present a better error message,
> > which is what this patch does
> >=20
> > The new error message is:
> >=20
> > qemu-img: error creating test.luks: The requested file size is too la=
rge
> >=20
> > Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1534898
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/crypto.c | 25 +++++++++++++++++++++----
> >  1 file changed, 21 insertions(+), 4 deletions(-)
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
> Regards,
> Daniel
Hi!

Do you think that we should merge this or, shall I close the bugreport
as WONTFIX?

Best regards,
	Maxim Levitsky



