Return-Path: <SRS0=Zx28=6B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99D4C352BE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:43:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2D972083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2020 09:43:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JXqmYsd6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2D972083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44710 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jPNX1-0002tM-Oi
	for qemu-devel@archiver.kernel.org; Fri, 17 Apr 2020 05:43:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jPNW9-0002Au-9j
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:42:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jPNW7-0005BS-Qj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:42:36 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:51225)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jPNW7-000583-Lj
 for qemu-devel@nongnu.org; Fri, 17 Apr 2020 05:42:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587116554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XkcRRxh5a/lFXuWr7eoQXtOg3tW3LOu46mPAD9Belkk=;
 b=JXqmYsd68QKczCenXdi5fM2glbg4FYBteWtx+9beUNasGRnZIAwfu1FX2AiGsD6sUdE3si
 3Atzb1KMGFvSHPyFBawEzLSzE0JdXZF6nZBjQ6zFWndJzVLEaLUlnz2QXRwKYk55ThJ4h0
 6jCCaRDNyp8eshqoXgXKOprvmS2hvLw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-dvx-DVYZPAeRBKKrfg3dvw-1; Fri, 17 Apr 2020 05:42:32 -0400
X-MC-Unique: dvx-DVYZPAeRBKKrfg3dvw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7793418C35A1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2020 09:42:31 +0000 (UTC)
Received: from localhost (ovpn-115-1.ams2.redhat.com [10.36.115.1])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2D25EA09B5;
 Fri, 17 Apr 2020 09:42:27 +0000 (UTC)
Date: Fri, 17 Apr 2020 10:42:26 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH 0/2] virtiofsd: drop Linux capabilities(7)
Message-ID: <20200417094226.GC9261@stefanha-x1.localdomain>
References: <20200416164907.244868-1-stefanha@redhat.com>
 <20200416201022.GD276932@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200416201022.GD276932@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="LwW0XdcUbUexiWVK"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: virtio-fs@redhat.com, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--LwW0XdcUbUexiWVK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2020 at 04:10:22PM -0400, Vivek Goyal wrote:
> On Thu, Apr 16, 2020 at 05:49:05PM +0100, Stefan Hajnoczi wrote:
> > virtiofsd doesn't need of all Linux capabilities(7) available to root. =
 Keep a
> > whitelisted set of capabilities that we require.  This improves securit=
y in
> > case virtiofsd is compromised by making it hard for an attacker to gain=
 further
> > access to the system.
>=20
> Hi Stefan,
>=20
> Good to see this patch. We needed to limit capabilities to reduce attack
> surface.
>=20
> What tests have you run to make sure this current set of whitelisted
> capabilities is good enough.

Booting and light usage of Fedora 29 and running blogbench.

I would appreciate it if others could try it out with their
tests/workloads.

Stefan

--LwW0XdcUbUexiWVK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6ZegIACgkQnKSrs4Gr
c8gCwQf/SGclgNGX+8xOqlJ74zhIpp6bGlVeuuRcjn87CM/oMgA0vS+f8aGZu5O7
c+YkV99TYQ5lB8xXzkg8BsyYyHUAJ3DQHOb/cb+x66zgF+kVoPMT8LNgozBC88ze
+4FCFFCBXLEoVnVyNcj+eATdLkH5usRjdfjtJ3LJRInEV+VwO7soogPmMTICZCXU
aPWOP9Ta1omkUBPvBMdqPUCXO4ihHabdBb/ZBPnWi+1TXg9gBTApmYPN40HwtIIB
Vhgnnbam8PDTRMSJQp1JDcGTFUOn6Uom4StlQJD1EObySpG2W4xYH+qAUOFXsJ2X
4yZaXikgN8AfzF42/6bbY/OLpmkeqw==
=sU5C
-----END PGP SIGNATURE-----

--LwW0XdcUbUexiWVK--


