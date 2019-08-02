Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A555C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E5E820B7C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 14:08:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E5E820B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htYEV-00021u-AJ
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 10:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60187)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1htYDY-0000eb-JB
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1htYDX-00014a-Fo
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 10:07:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40780)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1htYDV-00013W-8y; Fri, 02 Aug 2019 10:07:33 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 8379630832E9;
 Fri,  2 Aug 2019 14:07:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-117-107.ams2.redhat.com
 [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E37FE600C8;
 Fri,  2 Aug 2019 14:07:28 +0000 (UTC)
Date: Fri, 2 Aug 2019 16:07:27 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190802140727.GD6379@localhost.localdomain>
References: <20190801151744.798-1-kwolf@redhat.com>
 <20190801151744.798-3-kwolf@redhat.com>
 <976a878d-0344-8cb6-aa4b-d8e540bb1eaf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <976a878d-0344-8cb6-aa4b-d8e540bb1eaf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Fri, 02 Aug 2019 14:07:32 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/3] iotests: Enable -d for Python
 non-unittest tests
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 01.08.2019 um 19:57 hat Max Reitz geschrieben:
> On 01.08.19 17:17, Kevin Wolf wrote:
> > The part of iotests.main() that is related to the implementation of the
> > debug option -d and enables QEMU and QMP logging is not only useful in
> > tests that use the Python unittest framework, but also in tests that
> > work by comparing with a reference output.
> >=20
> > Factor these parts out into iotests.init() and call it from the test
> > cases that currently lack support for debug output.
>=20
> How does this relate to
> https://lists.nongnu.org/archive/html/qemu-block/2019-07/msg01212.html ?

Hm, no idea? :-)

Looks like John's patch depends on some other patches which would then
conflict with mine, too, so maybe I'll just drop my patch and wait what
happens?

John, any opinion?

Kevin

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJdREOfAAoJEH8JsnLIjy/WZ+IQAKDPIr3bWJ/OJPYdpAeKd0bc
xke1lKVqvz5QtHa8h4wJ5bg0N3pD5JCRG0muD2kTslmUrLvEnEwBOWv/Bta7PFWC
WFiSqeQArYpVeDiLkGP5qlMIwAOJct+d75oGq7S4AyeE8yI6XXUE2sNijP8cCLfv
Pi/SIoJhx6AIeSqFFiXmCjyc48170XdH+mAdOfaDIs8aMTMsnUC7fBfzWGkOwv8/
VDSELNuO5uffpmsaoOhyigT6GyxbLzGVVxPOj2HwPatammGeoV65u2Tnza4qTAEO
8EaNWH6Ujy4KDhykJdxRVVdKuAJasTfDEalfHQljX6SfcsMZX93RVxqwYdWGFet4
lbvgoKqEsYoPLu0W1bb0dKHRdf2vPw9r5rukrhr6x1Y8nLBk1Jqafa+lKaUoTqEV
uiOTEkHHzm8OHYxX/KV7DUayfF4dCbVzMi2tD6t6NE7b3adcPgjWAVBnoHbyeiDI
lFZP251PPzDzja0qfxNCcDsfXV7AKFp0qf84K/8w/rrk4IalfwqB8cXViAkncieq
WQ1sqlaJQStN2Gv1Z4fhC4yLUPv5Qz8HphoIrqKxtX+GbTR908rHjIxHs3MCphQH
RW9uRM9XntE/XSe928jZY6SJFvvR9iHyXf49FOZkAo5I3/quKZKr95pPptOI99eJ
3t75hOvChbi95VDiJoE5
=VDSs
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--

