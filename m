Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01DFC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:34:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 24ACC221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVhsDaPv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 24ACC221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX0X-0006Dk-A4
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:34:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWxK-0003sC-DC
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:31:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51739)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWxI-000741-GB
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:31:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600975859;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EdlyipBrcWcEOxgv5FCntRU9E6aghxPnL4N9otTzvLU=;
 b=TVhsDaPvio/NWn7w9z13bfBOqRfQi0bytpkQfL/+GHkT1mT5DjOUG/D9JJFU536hXJo8/C
 dbdj1eFTxbw5Ewr8IEJPEhPs4ysH4izqz159OJVH2S0TYz7YalwXHSC5aJH6r7c79NYWyP
 FhZZ0r+KTESwj/dWZOPB6GZ524jD2uA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-I8LW60YlM2GRJJ8jAw0YQg-1; Thu, 24 Sep 2020 15:30:55 -0400
X-MC-Unique: I8LW60YlM2GRJJ8jAw0YQg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B2FA801AC8;
 Thu, 24 Sep 2020 19:30:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6178573672;
 Thu, 24 Sep 2020 19:30:53 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:30:51 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 10/38] qapi/common.py: delint with pylint
Message-ID: <20200924193051.GE347036@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-11-jsnow@redhat.com>
 <20200923160119.GJ191229@localhost.localdomain>
 <cc0047ca-cb29-67fa-759d-500d226e928c@redhat.com>
MIME-Version: 1.0
In-Reply-To: <cc0047ca-cb29-67fa-759d-500d226e928c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="G6nVm6DDWH/FONJq"
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 23:02:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.199,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org,
 Michael Roth <mdroth@linux.vnet.ibm.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--G6nVm6DDWH/FONJq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 01:37:06PM -0400, John Snow wrote:
> On 9/23/20 12:01 PM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:33PM -0400, John Snow wrote:
> > > At this point, that just means using a consistent strategy for consta=
nt names.
> > > constants get UPPER_CASE and names not used externally get a leading =
underscore.
> > >=20
> > > As a preference, while renaming constants to be UPPERCASE, move them =
to
> > > the head of the file. Generally, it's nice to be able to audit the co=
de
> > > that runs on import in one central place.
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> > > ---
> > >   scripts/qapi/common.py | 18 ++++++++----------
> > >   scripts/qapi/schema.py | 14 +++++++-------
> > >   2 files changed, 15 insertions(+), 17 deletions(-)
> > >=20
> > > diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
> > > index e0c5871b10..bddfb5a9e5 100644
> > > --- a/scripts/qapi/common.py
> > > +++ b/scripts/qapi/common.py
> > > @@ -14,6 +14,11 @@
> > >   import re
> > > +EATSPACE =3D '\033EATSPACE.'
> > > +POINTER_SUFFIX =3D ' *' + EATSPACE
> > > +_C_NAME_TRANS =3D str.maketrans('.-', '__')
> >=20
> > IMO _C_NAME_TRANS is solely the concern of the c_name() function, and
> > should not be a global.  If you're concerned with speed (which I don't
> > think you should) you could still do:
> >=20
>=20
> It's true, but that's why it's marked internal here with the leading
> underscore -- it will not be exported. It was also *already* defined at t=
he
> module level, I didn't hoist it.
>=20
> I think what is written here is already the simplest thing that works.
>=20
> >     def c_name(name, protect=3DTrue,
> >                name_translation=3Dstr.maketrans('.-', '__')):
> >        ...
> >        name =3D name.translate(name_translation)
> >=20
> > Keeping in mind that you're adding a mutable type to a function
> > argument *on purpose*.  I'd really favor having that statement within
> > the only function that uses it, though.
> >=20
>=20
> That complicates the signature, so I think we shouldn't.
>=20
> --js
>=20
>=20

Not a too strong opinion about this to block it.  So if I hadn't
already:

Reviewed-by: Cleber Rosa <crosa@redhat.com>

--G6nVm6DDWH/FONJq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s8+sACgkQZX6NM6Xy
CfN/mg//dZhNsMiFwP0iJKQBWal2k6urX/f75ZTXrFEwjnI0lKKoxg2QOfpn09M/
of6tFaOMka20/dWLy4O89D/8QabAEFDPpZWoDZCI42t7uwVUqku3K9YqaqTNFWce
/pGZeiLNxfoYIzR5hkwPmwHFU8GniAdYULzJnWB+K8j7rbh5UznrvurXfIa+8uTd
GrlVeZ5a6FFGAOqsBUNL2fDEDul+2q952VpEXzZ+g0U2YOqIFmZXZvzFrv02WlT6
VxW99pMZgi3iZ5+vns5NUeuEB173vNRzNAZkSonvOB0rmcc1+237UmP+eTbPfTdH
o1SFJd2KIKSa2VK+hMMpv/b1tSBDzUneYAJ2evirsWJxmb1uIgSYH1srDofst9/N
rlETqQwI6qjFRmiTvzTeVyfHULz5jVQKN2Y7fzGzhxDffh72KOobD0MjiChm/1Cn
8mq1Q4Rm/NDvTAzGI8y05fZs/v3dhvTV7guU5Zy0CcGjbYmZrpMRNVX2vO6XhSCV
FM+Bt4440s8HH2FIqOLgBmIiKclOkUbtudREyokjDMd3XDh4ZXP2dTeqn9+6vtBb
uiqWDYdhz7STcSCGgphSngCOjPcLlJQ+bmGr/3isVOm1+lNVzhm09rXGOjme0Rei
hKe9OsPpAHZF5wHLBYreZh034XQVy3Edbg7p+1CgfYD0loZmjQo=
=ZXUi
-----END PGP SIGNATURE-----

--G6nVm6DDWH/FONJq--


