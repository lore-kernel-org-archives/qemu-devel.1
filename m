Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4764C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:12:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A92422CE3
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 11:12:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A92422CE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40848 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0l0s-00005a-MA
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 07:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51867)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i0kzg-0007yX-9l
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:11:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i0kze-0001c2-9y
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 07:11:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58640)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i0kzX-0001Y5-Gb; Thu, 22 Aug 2019 07:10:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 6C7B33082128;
 Thu, 22 Aug 2019 11:10:54 +0000 (UTC)
Received: from redhat.com (unknown [10.42.16.132])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 720A71001B32;
 Thu, 22 Aug 2019 11:10:48 +0000 (UTC)
Date: Thu, 22 Aug 2019 12:10:46 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190822111046.GL3267@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-3-mlevitsk@redhat.com>
 <6b9b4bf7-5765-400b-7452-e37ec797eed1@redhat.com>
 <20190822102914.GE3267@redhat.com>
 <7daeb59c95e5b28125a82caf0bb004c5660af9f2.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7daeb59c95e5b28125a82caf0bb004c5660af9f2.camel@redhat.com>
User-Agent: Mutt/1.12.0 (2019-05-25)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Thu, 22 Aug 2019 11:10:54 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Max Reitz <mreitz@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 22, 2019 at 02:04:28PM +0300, Maxim Levitsky wrote:
> On Thu, 2019-08-22 at 11:29 +0100, Daniel P. Berrang=C3=A9 wrote:
> > On Thu, Aug 15, 2019 at 05:40:11PM -0400, John Snow wrote:
> > >=20
> > >=20
> > > On 8/14/19 4:22 PM, Maxim Levitsky wrote:
> > > > This is also a preparation for key read/write/erase functions
> > > >=20
> > >=20
> > > This is a matter of taste and I am not usually reviewing LUKS patch=
es
> > > (So don't take me too seriously), but I would prefer not to have "m=
isc"
> > > patches and instead split things out by individual changes along wi=
th a
> > > nice commit message for each change.
> > >=20
> > > > * use master key len from the header
> > >=20
> > > This touches enough lines that you could make it its own patch, I t=
hink.
> > >=20
> > > > * prefer to use crypto params in the QCryptoBlockLUKS
> > > >   over passing them as function arguments
> > >=20
> > > I think the same is true here, and highlighting which variables you=
 are
> > > sticking into state instead of leaving as functional parameters wou=
ld be
> > > nice to see without all the other changes.
> > >=20
> > > > * define QCRYPTO_BLOCK_LUKS_DEFAULT_ITER_TIME
> > >=20
> > > This can likely be squashed with whichever patch of yours first nee=
ds to
> > > use it, because it's so short.
> > >=20
> > > > * Add comments to various crypto parameters in the QCryptoBlockLU=
KS
> > > >=20
> > >=20
> > > Can probably be squashed with item #2.
> >=20
> > Agreed, with all these points  - it is too hard to review this
> > for correctness with everything merged in one commit, so I'll
> > wait for v2 before reviewing much more.
> >=20
> > > > @@ -397,6 +411,12 @@ qcrypto_block_luks_essiv_cipher(QCryptoCiphe=
rAlgorithm cipher,
> > > >      }
> > > >  }
> > > > =20
> > > > +static int masterkeylen(QCryptoBlockLUKS *luks)
> > > > +{
> > > > +    return luks->header.key_bytes;
> > > > +}
> > > > +
> > > > +
> > >=20
> > > generally QEMU uses snake_case_names; please spell as "master_key_l=
en".
> >=20
> > Also naming convention in this file expects "qcrypto_block_luks_" pre=
fix
> > for all methods
> >=20
> The point of adding the masterkeylen was that IMHO it wasn't clear that
> luks->header.key_bytes is the master key length.
>=20
> However defining something like qcrypto_block_luks_master_key_len(QCryp=
toBlockLUKS *luks)=20
> is way longer, and will force me to wrap just too many places in the co=
de to keep 80
> character limit.
>=20
> Now I am thinking of other ways to make this thing better:
>=20
> 1. How about adding luks->masterkeylen and using it. luks state already=
 has
> several parsed values from the header, so using another one wouldn't hu=
rt?

With those the parsed values are actually a different format from the
header values, so it makes sense to have duplication.  Duplication
just for sake of having a different name will just be confusing
with some code using one field & some code using the other field
when they are identical.

> 2. how about renaming the luks->header.key_bytes to luks->header->maste=
r_key_len?

This is fine.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

