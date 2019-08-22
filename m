Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D24CCC3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:36:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8AF12173E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8AF12173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kRo-0005Ht-RF
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:36:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39103)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kQk-0004Ew-OQ
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kQj-0003vA-FU
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:34:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44406)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0kQg-0003p2-0R; Thu, 22 Aug 2019 06:34:54 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 16ED9308620B;
 Thu, 22 Aug 2019 10:34:53 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 663D15C205;
 Thu, 22 Aug 2019 10:34:49 +0000 (UTC)
Date: Thu, 22 Aug 2019 11:34:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822103447.GG3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-4-mlevitsk@redhat.com>
 <56f412ca-1985-589c-85b4-a8164f701a64@redhat.com>
 <426e109e6799ba1c9e045541777aeae9183b6134.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <426e109e6799ba1c9e045541777aeae9183b6134.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 22 Aug 2019 10:34:53 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 01:43:05AM +0300, Maxim Levitsky wrote:
> On Tue, 2019-08-20 at 20:01 +0200, Max Reitz wrote:
> > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > With upcoming key management, the header will
> > > need to be stored after the image is created.
> > >=20
> > > Extracting load header isn't strictly needed, but
> > > do this anyway for the symmetry.
> > >=20
> > > Also I extracted a function that does basic sanity
> > > checks on the just read header, and a function
> > > which parses all the crypto format to make the
> > > code a bit more readable, plus now the code
> > > doesn't destruct the in-header cipher-mode string,
> > > so that the header now can be stored many times,
> > > which is needed for the key management.
> > >=20
> > > Also this allows to contain the endianess conversions
> > > in these functions alone
> > >=20
> > > The header is no longer endian swapped in place,
> > > to prevent (mostly theoretical races I think)
> > > races where someone could see the header in the
> > > process of beeing byteswapped.
> >=20
> > The formatting looks weird, it doesn=E2=80=99t look quite 72 characte=
rs wide...
> >  (what commit messages normally use)
> Could you elaborate on that? I thought that code should not
> exceed 80 character limit.
>=20
> >=20
> > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > ---
> > >  crypto/block-luks.c | 756 ++++++++++++++++++++++++++--------------=
----
> > >  1 file changed, 440 insertions(+), 316 deletions(-)
> >=20
> > Also, this commit is just too big.
>=20
> Yea, but it has no functional changes.
> I can split it further, but that won't help much IMHO.

I'd find it easier to review if each newly introduced method was a
separate patch. It makes it easier to see which bit of removed
code was added to which method.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

