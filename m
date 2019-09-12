Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A73C49ED9
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:55:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13262206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 09:55:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13262206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8LpC-0001BP-1w
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 05:55:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49243)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LnP-0007Wr-51
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:53:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i8LnO-0004U3-75
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 05:53:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33862)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i8LnM-0004Sv-7b; Thu, 12 Sep 2019 05:53:44 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9470E307CDFC;
 Thu, 12 Sep 2019 09:53:43 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.59])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5BA59600C4;
 Thu, 12 Sep 2019 09:53:39 +0000 (UTC)
Message-ID: <b3ed2850ebe0b3413a247ba517af61f39fbb0fcb.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>
Date: Thu, 12 Sep 2019 12:53:38 +0300
In-Reply-To: <20190906135924.GM5119@redhat.com>
References: <20190830205608.18192-1-mlevitsk@redhat.com>
 <20190830205608.18192-5-mlevitsk@redhat.com>
 <20190906135924.GM5119@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 12 Sep 2019 09:53:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 04/10] block: amend: add 'force' option
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2019-09-06 at 14:59 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Fri, Aug 30, 2019 at 11:56:02PM +0300, Maxim Levitsky wrote:
>=20
> This could do with some text to explain what this will be
> used for.

I actually added an explanation to the man page

"
+--force allows some unsafe operations. Currently for -f luks,
+it allows to erase last encryption key, and to overwrite an active
+encryption key.
+
"

You probably mean adding few words in the commit message as well,
and I'll do that anyway.


>=20
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block.c                   | 4 +++-
> >  block/qcow2.c             | 1 +
> >  include/block/block.h     | 1 +
> >  include/block/block_int.h | 1 +
> >  qemu-img-cmds.hx          | 4 ++--
> >  qemu-img.c                | 8 +++++++-
> >  qemu-img.texi             | 6 +++++-
> >  7 files changed, 20 insertions(+), 5 deletions(-)
>=20
> For the code
>=20
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>=20
>=20
> Regards,
> Daniel


Best regards,
	Maxim Levitsky


