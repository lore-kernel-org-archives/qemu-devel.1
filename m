Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0832FC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:05:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE10D21726
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:05:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE10D21726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kuW-00043K-W6
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:05:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49664)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mlevitsk@redhat.com>) id 1i0ktY-00036c-H6
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1i0ktX-0005jK-8T
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:04:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48810)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1i0ktU-0005hM-Aa; Thu, 22 Aug 2019 07:04:40 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 918B3C04DBCD;
 Thu, 22 Aug 2019 11:04:39 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.33])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B4E83600CD;
 Thu, 22 Aug 2019 11:04:29 +0000 (UTC)
Message-ID: <7daeb59c95e5b28125a82caf0bb004c5660af9f2.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: "Daniel P." =?ISO-8859-1?Q?Berrang=E9?= <berrange@redhat.com>, John Snow
 <jsnow@redhat.com>
Date: Thu, 22 Aug 2019 14:04:28 +0300
In-Reply-To: <20190822102914.GE3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <6b9b4bf7-5765-400b-7452-e37ec797eed1@redhat.com>
 <20190822102914.GE3267@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Thu, 22 Aug 2019 11:04:39 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 02/13] qcrypto-luks: misc
 refactoring
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
 qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2019-08-22 at 11:29 +0100, Daniel P. Berrang=C3=A9 wrote:
> On Thu, Aug 15, 2019 at 05:40:11PM -0400, John Snow wrote:
> >=20
> >=20
> > On 8/14/19 4:22 PM, Maxim Levitsky wrote:
> > > This is also a preparation for key read/write/erase functions
> > >=20
> >=20
> > This is a matter of taste and I am not usually reviewing LUKS patches
> > (So don't take me too seriously), but I would prefer not to have "mis=
c"
> > patches and instead split things out by individual changes along with=
 a
> > nice commit message for each change.
> >=20
> > > * use master key len from the header
> >=20
> > This touches enough lines that you could make it its own patch, I thi=
nk.
> >=20
> > > * prefer to use crypto params in the QCryptoBlockLUKS
> > >   over passing them as function arguments
> >=20
> > I think the same is true here, and highlighting which variables you a=
re
> > sticking into state instead of leaving as functional parameters would=
 be
> > nice to see without all the other changes.
> >=20
> > > * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> >=20
> > This can likely be squashed with whichever patch of yours first needs=
 to
> > use it, because it's so short.
> >=20
> > > * Add comments to various crypto parameters in the QCryptoBlockLUKS
> > >=20
> >=20
> > Can probably be squashed with item #2.
>=20
> Agreed, with all these points  - it is too hard to review this
> for correctness with everything merged in one commit, so I'll
> wait for v2 before reviewing much more.
>=20
> > > @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCipherA=
lgorithm cipher,
> > >      }
> > >  }
> > > =20
> > > +static int masterkeylen(QCryptoBlockLUKS *luks)
> > > +{
> > > +    return luks->header.key_bytes;
> > > +}
> > > +
> > > +
> >=20
> > generally QEMU uses snake_case_names; please spell as "master_key_len=
".
>=20
> Also naming convention in this file expects "qcrypto_block_luks_" prefi=
x
> for all methods
>=20
The point of adding the masterkeylen was that IMHO it wasn't clear that
luks->header.key_bytes is the master key length.

However defining something like qcrypto_block_luks_master_key_len(QCrypto=
BlockLUKS *luks)=20
is way longer, and will force me to wrap just too many places in the code=
 to keep 80
character limit.

Now I am thinking of other ways to make this thing better:

1. How about adding luks->masterkeylen and using it. luks state already h=
as
several parsed values from the header, so using another one wouldn't hurt=
?


2. how about renaming the luks->header.key_bytes to luks->header->master_=
key_len?

Best regards,
	Maxim Levitsky


