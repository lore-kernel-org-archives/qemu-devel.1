Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1E5C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:56:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E69082173E
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 08:56:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E69082173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2XHK-0007Y7-Sj
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 04:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <berrange@redhat.com>) id 1i2XG3-0006cV-7J
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:55:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <berrange@redhat.com>) id 1i2XG1-0008RI-TC
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 04:55:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47292)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <berrange@redhat.com>)
 id 1i2XFy-0008QQ-Ip; Tue, 27 Aug 2019 04:55:14 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id B039110F23E7;
 Tue, 27 Aug 2019 08:55:13 +0000 (UTC)
Received: from redhat.com (ovpn-112-56.ams2.redhat.com [10.36.112.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A9F645D70D;
 Tue, 27 Aug 2019 08:55:08 +0000 (UTC)
Date: Tue, 27 Aug 2019 09:55:05 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
Message-ID: <20190827085505.GC16500@redhat.com>
References: <20190814202219.1870-1-mlevitsk@redhat.com>
 <20190814202219.1870-6-mlevitsk@redhat.com>
 <6019b9e3-a4a6-4780-9652-f7c2bec024a5@redhat.com>
 <20190822104945.GJ3267@redhat.com>
 <e5e2c603c616b6a14419f9942016f7df0c177610.camel@redhat.com>
 <cd1bc2cf3e2748db8aa686534ae7d84c71a58e69.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd1bc2cf3e2748db8aa686534ae7d84c71a58e69.camel@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.66]); Tue, 27 Aug 2019 08:55:13 +0000 (UTC)
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, Nir Soffer <nsoffer@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 25, 2019 at 06:31:02PM +0300, Maxim Levitsky wrote:
> On Thu, 2019-08-22 at 13:56 +0300, Maxim Levitsky wrote:
> > On Thu, 2019-08-22 at 11:49 +0100, Daniel P. Berrang=C3=A9 wrote:
> > > On Tue, Aug 20, 2019 at 08:12:51PM +0200, Max Reitz wrote:
> > > > On 14.08.19 22:22, Maxim Levitsky wrote:
> > > > > While there are other places where these are still stored in me=
mory,
> > > > > this is still one less key material area that can be sniffed wi=
th
> > > > > various side channel attacks
> > > > >=20
> > > > >=20
> > > > >=20
> > > >=20
> > > > (Many empty lines here)
> > > >=20
> > > > > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > > > > ---
> > > > >  crypto/block-luks.c | 52 +++++++++++++++++++++++++++++++++++++=
+-------
> > > > >  1 file changed, 44 insertions(+), 8 deletions(-)
> > > >=20
> > > > Wouldn=E2=80=99t it make sense to introduce a dedicated function =
for this?
> > >=20
> > > Yes, it would.
> > >=20
> > > In fact I have a series pending which bumps min glib and introduces
> > > use of auto-free functions in this code.
> > >=20
> > > It would be desirable to have a autp-free func for memset+free
> > > so we can just declare the variable
> > >=20
> > >    q_autowipefree char *password =3D NULL;
> > >=20
> > > and have it result in memset+free
> > >=20
> >=20
> > That is perfect.
> > When do you think you could post the series so that I could rebase
> > on top of it?
>=20
>=20
> I am thinking that I will keep my patch as is, just so that code is
> consistent in memsetting the secrets (even though as Nir pointed out,
> that these will be probably optimized away anyway).
> And then when you send your patch you will just remove all
> of these memsets.

I'm fine with you continuing to use memset, since this is a pre-existing
problem in the code that you are not making worse. We'll figure out the
fix separately.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|

