Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF119ECE58C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:15:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9668D2084C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 09:15:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9668D2084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIr0r-0007ih-I9
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 05:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50372)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pkrempa@redhat.com>) id 1iIqyu-0005ul-RT
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:13:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pkrempa@redhat.com>) id 1iIqyt-0006lz-Ss
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 05:13:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35660)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pkrempa@redhat.com>)
 id 1iIqyr-0006kZ-Jp; Fri, 11 Oct 2019 05:13:01 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BADB18372E9;
 Fri, 11 Oct 2019 09:13:00 +0000 (UTC)
Received: from andariel.pipo.sk (ovpn-204-231.brq.redhat.com [10.40.204.231])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1CBE310013D9;
 Fri, 11 Oct 2019 09:12:50 +0000 (UTC)
Date: Fri, 11 Oct 2019 11:12:47 +0200
From: Peter Krempa <pkrempa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 1/1] IDE: deprecate ide-drive
Message-ID: <20191011091247.GD1979@andariel.pipo.sk>
References: <20191009224303.10232-1-jsnow@redhat.com>
 <20191009224303.10232-2-jsnow@redhat.com>
 <518ae20b-049d-19ee-1e86-c48466ba0655@redhat.com>
 <20191010112650.GR6129@angien.pipo.sk>
 <10bb29c8-2375-25cd-af67-edddca1be5d7@redhat.com>
 <20191010115436.GS6129@angien.pipo.sk>
 <1a35d92f-ccb1-9e54-193b-a1b193c3e696@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="IMjqdzrDRly81ofr"
Content-Disposition: inline
In-Reply-To: <1a35d92f-ccb1-9e54-193b-a1b193c3e696@redhat.com>
X-PGP-Key-ID: 0xD018682B
X-PGP-Key-Fingerprint: D294 FF38 A6A2 BF40 6C75  5DEF 36EC 16AC D018 682B
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.68]); Fri, 11 Oct 2019 09:13:00 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, libvir-list@redhat.com, qemu-devel@nongnu.org,
 Max Reitz <mreitz@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--IMjqdzrDRly81ofr
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2019 at 14:08:12 -0400, John Snow wrote:
> On 10/10/19 7:54 AM, Peter Krempa wrote:
> > On Thu, Oct 10, 2019 at 13:42:26 +0200, Philippe Mathieu-Daud=E9 wrote:
> >> On 10/10/19 1:26 PM, Peter Krempa wrote:

[...]

> > To be honest, I didn't really review the code nor the documentation.
> > I actually reviewed only the idea itself in the context of integration
> > with libvirt and that's why I didn't go for 'Reviewed-by:'.
> >=20
> > The gist of the citation above is that we should stick to well known
> > tags with their well known meanings and I think that considering this a
> > 'review' would be a stretch of the definiton.
> >=20
>=20
> I wasn't aware that PMM wanted to avoid non-standard tags; I consider
> them to be for human use, but I can change that behavior.
>=20
> Peter, I'll change it to an ACK (as suggested by Kevin) is that's OK by y=
ou.

Sure! I'll spell it out even for compliance:

ACKed-by: Peter Krempa <pkrempa@redhat.com>

--IMjqdzrDRly81ofr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUn7DGLvflazX+2GwHGwCByjY1GoFAl2gR48ACgkQHGwCByjY
1GpDgA/8DbOVMkrsad4mVFvBJCyWG8yxm06OPPjBm9tZfz0SFHZCVtwgdxO7LzHz
cDMFam2j8TkMHIUw6C4HMksO+x+SaCzXW4BMk6/IzN2duAFV16zrxCJTyVf92Y+g
MRqEj+Fkpk4QDynzFkzZj70pAseKuiiw0b7ayzncHWeJHUvn+/FpdKSp9l/NCNXI
BS5+57YFNmAu83bYhQw1KiSeT1L7Nof21XdbksraSjf2bX7ZQqe6Ilx57F7UV2eW
x5NZ1awH1K6k2WEHX9uNnwZM29aRw7F2S/ofXSsbSGnJM6QYue3IonFK1wpXfZUZ
yxGGC2nxvqEVJjR7WmHofKja75VvrJDpNcVomgkPY8neSfCnoiYWaDhZS6UVbpkL
qmDkkoozG2GcigeJXHknrOKieZPmKtc8vdbbgkWO9+2H6RUTfTvOUm5kp0s827PO
NNacvDNf3xJYTE9HevADAUlFOu+RxlgepZTJ2hb4qeeAYo9JPoa+FBe3Llqo0Nxj
fMP6pN6Q/mmHR5S/uDHHnfDOJsSlS37zz1JVgBtZpV3TEweGnDgg+cD2NT5HuBFP
1Zf1WgQvdNFkuIibwt0efb4n94Z8S3H3ck8XdE12w01uNnR7Ns3oTDee/GP7KUyV
lFha+q987IhgUJ14Xr9X3Su6mGrG3wLURHRAonxRD610afSiPEU=
=tBnA
-----END PGP SIGNATURE-----

--IMjqdzrDRly81ofr--

