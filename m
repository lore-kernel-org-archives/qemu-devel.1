Return-Path: <SRS0=wsBa=SO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E890EC10F0E
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BDA2084D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2019 13:47:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BDA2084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:37618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hEwWR-00053F-Oo
	for qemu-devel@archiver.kernel.org; Fri, 12 Apr 2019 09:47:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hEwVM-0004Rr-Mz
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hEwVL-0007o4-Pq
	for qemu-devel@nongnu.org; Fri, 12 Apr 2019 09:46:08 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59418)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>)
	id 1hEwVH-0007MY-OQ; Fri, 12 Apr 2019 09:46:03 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDB3E300358C;
	Fri, 12 Apr 2019 13:45:57 +0000 (UTC)
Received: from localhost (ovpn-117-48.ams2.redhat.com [10.36.117.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8D8D55D9E2;
	Fri, 12 Apr 2019 13:45:51 +0000 (UTC)
Date: Fri, 12 Apr 2019 14:45:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Sergio Lopez <slp@redhat.com>
Message-ID: <20190412134549.GA30090@stefanha-x1.localdomain>
References: <20190402121908.44081-1-slp@redhat.com>
	<20190409112608.GD16944@stefanha-x1.localdomain>
	<87bm1diz23.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <87bm1diz23.fsf@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 12 Apr 2019 13:45:57 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [RFC PATCH] aio: Add a knob to always
 poll if there are in-flight requests
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
Cc: kwolf@redhat.com, fam@euphon.net, qemu-block@nongnu.org,
	Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org,
	mreitz@redhat.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190412134549.8-Re7Z9lTRZKcWzNrdQoRRuMAURxwiJ7YaaFRN464j8@z>


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Apr 10, 2019 at 06:51:16PM +0200, Sergio Lopez wrote:
> Perhaps it'd be worth doing a simple PoC outside QEMU, using the
> vhost-user-blk example server to avoid the block layer complexity and
> evaluate the raw benefits with different kinds of backends and
> workloads.

Sure, it's worth experimenting with.

libvirt is on top of QEMU.  oVirt or OpenStack is on top of libvirt.
It's hard for the user or management tools to set low-level tuning
options like this.  We either need smart defaults or self-tuning - knobs
are mostly useful for benchmarking and for a very small number of expert
users.

Stefan

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcsJaNAAoJEJykq7OBq3PIM7cH/RiaZqwn9jCm38GW2PZ1Sdx4
Vjb0DZTStSoaPwJSKpBxC+UCoabCOV6lDC2iw9WCMXb1mFgsavayaeeMM+EIDwpp
LOyKmL/KOO8JWduYVP4NzMu32dcBAREeblocsJGfqLg6y7kcJ5RzvNZw6ExVA9NA
Xk8JvicEaGpnmSirAbovPXWWhJ1765dzXtkdKHIRJKEdPNU0bbW7zAfqIa3l00Mx
+nEZrR4//i0op+9PhPLTwHfTVPMm4A3pwbCCwxRxGzGQI+1vPZA8vtkjuO3NO9Ko
XxjOwkTCxthX20oYfufLkCLW1hfk5N0OKcHkuW6Ik4BVHPPyWD+DfuBnelkZ9kE=
=Ul9J
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--

