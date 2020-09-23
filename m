Return-Path: <SRS0=UzyQ=DA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D00BFC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D74D21D92
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Sep 2020 13:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XL84AQCM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D74D21D92
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kL53s-0006VO-7p
	for qemu-devel@archiver.kernel.org; Wed, 23 Sep 2020 09:43:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38186)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL52i-0005Wi-6P
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:42:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44899)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1kL52g-0006cF-A1
 for qemu-devel@nongnu.org; Wed, 23 Sep 2020 09:42:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600868561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CTV9hM7LmEQisgo141HYYvxa0Iebf1k8eaEGAWTclMQ=;
 b=XL84AQCMM9t88L7KtPAJFANRb6KOv3Wkah6kkoZRjiLftzfuBArGgxOE8ydqoRyXhvlYGo
 CHfVe2qn9Lwo5Ua8dzoIXC3tJk+tRM+Yt0qa74AtuPZ5RZUP+lHjiuSpuHWIsQbICRpfEs
 KSNIypN63Om1TpFxBqy5W28mYVa9Bus=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-xbH0CprXP0OqmsqWh82SAg-1; Wed, 23 Sep 2020 09:42:39 -0400
X-MC-Unique: xbH0CprXP0OqmsqWh82SAg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB3118ECE7B;
 Wed, 23 Sep 2020 13:42:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-119-55.rdu2.redhat.com
 [10.10.119.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 034DA5DA7B;
 Wed, 23 Sep 2020 13:42:36 +0000 (UTC)
Date: Wed, 23 Sep 2020 09:42:35 -0400
From: Cleber Rosa <crosa@redhat.com>
To: John Snow <jsnow@redhat.com>
Subject: Re: [PATCH v2 07/38] qapi: add pylintrc
Message-ID: <20200923134235.GG191229@localhost.localdomain>
References: <20200922210101.4081073-1-jsnow@redhat.com>
 <20200922210101.4081073-8-jsnow@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200922210101.4081073-8-jsnow@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=crosa@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="TdkiTnkLhLQllcMS"
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/23 00:53:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.228,
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

--TdkiTnkLhLQllcMS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2020 at 05:00:30PM -0400, John Snow wrote:
> Using `pylint --generate-rcfile > pylintrc`, generate a skeleton
> pylintrc file. Sections that are not presently relevant (by the end of
> this series) are removed leaving just the empty section as a search
> engine / documentation hint to future authors.
>=20
> Right now, quite a few modules are ignored as they are known to fail as
> of this commit. modules will be removed from the known-bad list
> throughout this and following series as they are repaired.
>=20
> Note: Normally, pylintrc would go in the folder above the module, but as
> that folder is shared by many things, it is going inside the module
> folder (for now). Due to a bug in pylint 2.5.x, pylint does not
> correctly recognize when it is being run from "inside" a package, and
> must be run *outside* of the package.
>=20
> Therefore, to run it, you must:
>=20
>  > pylint scripts/qapi/ --rcfile=3Dscripts/qapi/pylintrc
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>

One concern I have here is that the pylint version is not defined.
Based on experience, different pylint will behave differently, because
among other things, it may introduce new checks.

I'd at the very least document the pylint version used in the commit
message, until a "requirements.txt"-like solution pinning a version is
given.

Other than that,

Reviewed-by: Cleber Rosa <crosa@redhat.com>
Tested-by: Cleber Rosa <crosa@redhat.com>

--TdkiTnkLhLQllcMS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEeruW64tGuU1eD+m7ZX6NM6XyCfMFAl9rUMoACgkQZX6NM6Xy
CfOIzBAAiGqV7T+J6ksSyTs/QQAbAnkZtyNR0NYVZauRCfOl+pPk45Ic2N+F9TLC
ifwzq/ekikfOcHsE35AR8sYK4kw8F8BSvBTQ9ZMjeE8ktpow6kyPDuFhQSYL9Hwj
VFAGO4tpKlj5YLsHm1JSVuuYZeEzS/tDl27XWb3UCfdHDENNuJlbBRsBVXbRdorL
G/LVQctYdG6Bm8AoH4V7+sFd7vosW7GsbaCjRCU/cSyLF1PVxceFFoEv6BlTOupB
9WzZNaV2VNHU2XfLzJo8vt5D0tArf8Peo/3Wfl4Yht241tXaMLlyr9uShgOQ5QCk
lZcvEihiDrfNPxxKckgUj5+wa7yGSoF7xyMAKJSEznJvAnR7fTyPfUYZsO7tiSta
KgacQp/z+5bBtdP8WO1zS0O3rOjwqibHl13f5NguN91wMOlwZhR58PhrSsQ7qtAs
eyZzwYHSS60br/9Y+VDwG4uX9IOwx7YnOs7C3cytlDhCkBjNonkzv62vEaP8VRb9
Q24s4dgFGyamBNRtUcQsP8qv3pT2Vxz8+dK0liae2tFPtNVE5hWkSRKkfNd/30G+
CT8Oe4B8PCSj/kszwuZcqVdzI93MuUivqOxTIv/aImROEz7aJ01Cy+zYeLay//Ko
VqK3TqpYojrNA1sqV1lktzSEndNz3vUqocB63qkNLSWZTtDMLjA=
=ABmc
-----END PGP SIGNATURE-----

--TdkiTnkLhLQllcMS--


