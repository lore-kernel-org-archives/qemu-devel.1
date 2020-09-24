Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F4DC4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:33:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD133221EB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:32:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHHoFKLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD133221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39002 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLWzC-0004Xh-SS
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50902)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWvi-0001xi-71
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39731)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kLWvY-0006ip-S8
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:21 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600975750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=osQ1hgRlvwMqUkfZ26yi5ZZ2PSTKP2+6WhP7Dd0+0W0=;
 b=LHHoFKLzaXFlln+jE2o4XCBrJe8WZ0pkXE5VgJBlUeVDD3ZLLdKUSxdySWmvH3Ke1poCH6
 +/Hu5bE7npxkw6iAzxQkDOBwY7uJKFSZO/cbGiNJvCwyKj5kLSftMzpgWFWZO9LflRIOXT
 Hx4IVh2j3y/clgAflGaLbO85DtDZKUk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-313-N3cJOIpuP62rh98ylNtJ0A-1; Thu, 24 Sep 2020 15:29:08 -0400
X-MC-Unique: N3cJOIpuP62rh98ylNtJ0A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 460C71006708;
 Thu, 24 Sep 2020 19:29:07 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 60CC65C1C7;
 Thu, 24 Sep 2020 19:29:06 +0000 (UTC)
Date: Thu, 24 Sep 2020 15:29:04 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 07/38] qapi: add pylintrc
Message-ID: <20200924192904.GD347036@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-8-jsnow@redhat.com>
 <20200923134235.GG191229@localhost.localdomain>
 <751aa453-8c25-6769-d305-d0729beb3415@redhat.com>
MIME-Version: 1.0
In-Reply-To: <751aa453-8c25-6769-d305-d0729beb3415@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="XvKFcGCOAo53UbWW"
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

--XvKFcGCOAo53UbWW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 23, 2020 at 01:23:56PM -0400, John Snow wrote:
> On 9/23/20 9:42 AM, Cleber Rosa wrote:
> > On Tue, Sep 22, 2020 at 05:00:30PM -0400, John Snow wrote:
> > > Using `pylint --generate-rcfile > pylintrc`, generate a skeleton
> > > pylintrc file. Sections that are not presently relevant (by the end o=
f
> > > this series) are removed leaving just the empty section as a search
> > > engine / documentation hint to future authors.
> > >=20
> > > Right now, quite a few modules are ignored as they are known to fail =
as
> > > of this commit. modules will be removed from the known-bad list
> > > throughout this and following series as they are repaired.
> > >=20
> > > Note: Normally, pylintrc would go in the folder above the module, but=
 as
> > > that folder is shared by many things, it is going inside the module
> > > folder (for now). Due to a bug in pylint 2.5.x, pylint does not
> > > correctly recognize when it is being run from "inside" a package, and
> > > must be run *outside* of the package.
> > >=20
> > > Therefore, to run it, you must:
> > >=20
> > >   > pylint scripts/qapi/ --rcfile=3Dscripts/qapi/pylintrc
> > >=20
> > > Signed-off-by: John Snow <jsnow@redhat.com>
> >=20
> > One concern I have here is that the pylint version is not defined.
> > Based on experience, different pylint will behave differently, because
> > among other things, it may introduce new checks.
> >=20
> > I'd at the very least document the pylint version used in the commit
> > message, until a "requirements.txt"-like solution pinning a version is
> > given.
> >=20
> > Other than that,
> >=20
> > Reviewed-by: Cleber Rosa <crosa@redhat.com>
> > Tested-by: Cleber Rosa <crosa@redhat.com>
> >=20
>=20
> Alright, I'll put it in the commit message itself instead of in the cover
> letter.
>

I missed that info on the cover letter, so my apologies.  But still, I
think it's a good idea to have that preserved in the repo history
indeed.

> The next step is to re-engage on that Makefile patch that I was working o=
n
> for ./python/qemu and introduce it here too, which will document the pinn=
ed
> versions correctly.
>=20
> --js

Agreed!

- Cleber.

--XvKFcGCOAo53UbWW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9s84AACgkQZX6NM6Xy
CfPd1g//TyTW0fKXz37orkF7aehcoPhapNyvFDZn2TgdBG3vDQ0l5Alf5j8ZMDl2
eStbG4mTiX9jDu+ym8VHDiCDwBjgOMFI3rXGxoK/ljAmVBPCw2ACqrUCz0BXfoJU
0Bh2qmAnFeXUlbF/14chEpGJEXDhkcXvuHUUPqQKe57lXfNXVKyBc8pG9GTcW+yg
qkyhJjEe3wpC91zaasSaV2YBvO2FmZ/ptoBKszAna+8juHtQCFQOFcon7F/03lPV
wzu+jhgSBLSDgfGZqb2xbdqtlnMUjRAlrlWAS2u2rlkpEcCPaJ3s4ny5BC/3OAbX
iJYotfd6tVAihd3s7D6mpymbBh9U54HH5D0uz2rVRF9XNYyOZ2lRzNv9PPNSnVo+
hZMynfOj4iipt7+/HCV+3mWwad2XM4ul5uTRdZvQct62pDosAhRoNlt4rVT7fbst
MHxG/Ul1NldF/PreKI+6MyPFjBRl+spSQNdLQYgDEa/uDhQrN/8UxX9GO2+KeWVr
f9Zd9PhfBSwKA5SePzZZjq9dzXldRFO+0w0DXv6fqpCMKsvCRBUpcyAsykbSdZNh
Xn8CX9alwTdUgbQdqWXtxwFIV1CU2hUJd2zlWJs1bcI0E/cbdA9IoOKiELgH6oFv
TbO58eYyhAG6W5d8czGcPhUZptsfnv6OQxS1StTTg/39Q6fqFR4=
=NSbL
-----END PGP SIGNATURE-----

--XvKFcGCOAo53UbWW--


