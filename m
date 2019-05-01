Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 330D1C43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:24:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2EA62075E
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 17:24:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2EA62075E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37402 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLsyB-00046u-AE
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 13:24:35 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34655)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hLswB-0002zu-Mq
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:22:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hLswA-0006xT-Vb
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:22:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hLswA-0006uN-Q4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 13:22:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9D52330ADBAF;
	Wed,  1 May 2019 17:22:29 +0000 (UTC)
Received: from localhost (ovpn-116-250.ams2.redhat.com [10.36.116.250])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DEF4A7444E;
	Wed,  1 May 2019 17:22:28 +0000 (UTC)
Date: Wed, 1 May 2019 13:22:27 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Message-ID: <20190501172227.GD22391@stefanha-x1.localdomain>
References: <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <CAFEAcA9BCXuOxaFaHvT0bDnb+7e_vYuhxspjokRp19G+SUf+MA@mail.gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Wed, 01 May 2019 17:22:29 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] Spreading the load on QEMU pullreq handling and
 release work
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Markus Armbruster <armbru@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501172227.D1cT9ClACIQ78NZLLY9yQweRB0fMQBcO4wjy4qVqHzI@z>


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 30, 2019 at 06:27:03PM +0100, Peter Maydell wrote:
> For the moment I'd like to ask for in-principle volunteers
> to be on the release-handling rota.

I am willing to handle one release per year.

Stefan

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAlzJ1cAACgkQnKSrs4Gr
c8iWwAgAuv9RV5oYixE06a9lKngYmzo+njZ0LTjMskRzZax0RUjJTqIYGAqoRux2
PFfO128C2TeuWiyHs1W5Smws07MGljrBNSkY+0mzB+zu4Op+hEdO21ZSYYx2BG1A
C0Sb3zOhsPsraPqIr7KOU1EE1R8Lt+c1n5mAkkhnhY5rkavROd3z/5VabRp1kW9q
NN7Zlaa0bEMbSV3WPIYTap4y92WP7ZjoLYkqdJr05oMxsPDubitcWvWRQYB2JJ39
iW613OHyP2WRogc7MT67UXkybz+AY7e9DqsKAuQwwa8AECEdvxmhY9PEbUOvaW/Q
V6F6ZdwH57ei4QjfiBt1SSGHj2Zfvg==
=NKkT
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--

