Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C883EC4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8840B20640
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 16:16:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8840B20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58786 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7MKn-0000wm-En
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 12:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60106)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7M5u-0001sE-Ef
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:00:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7M5r-0002Yc-EY
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:00:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:6395)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7M5r-0002YJ-85
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 12:00:43 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9577C8D65C3;
 Mon,  9 Sep 2019 16:00:42 +0000 (UTC)
Received: from localhost (ovpn-117-107.ams2.redhat.com [10.36.117.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 238C260BF3;
 Mon,  9 Sep 2019 16:00:41 +0000 (UTC)
Date: Mon, 9 Sep 2019 18:00:39 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Johannes Berg <johannes@sipsolutions.net>
Message-ID: <20190909160039.GC20875@stefanha-x1.localdomain>
References: <20190902121233.13382-1-johannes@sipsolutions.net>
 <20190902121233.13382-2-johannes@sipsolutions.net>
 <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="eRtJSFbw+EEWtPj3"
Content-Disposition: inline
In-Reply-To: <fe517ef6c6a8e2df9675388be9454b5863c7fc55.camel@sipsolutions.net>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.69]); Mon, 09 Sep 2019 16:00:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC] docs: vhost-user: add in-band kick/call
 messages
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
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org, mst@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--eRtJSFbw+EEWtPj3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 10:28:33PM +0200, Johannes Berg wrote:
> =20
> > +``VHOST_USER_VQ_CALL``
> > +  :id: 34
> > +  :equivalent ioctl: N/A
> > +  :slave payload: vring state description
> > +  :master payload: N/A
>=20
> Oops. This message should be called VHOST_USER_VRING_KICK.
>=20
> This file doesn't take about virtqueues, just vrings, and I inverted the
> call/kick.
>=20
> [...]
> =20
> > +``VHOST_USER_VQ_KICK``
> > +  :id: 4
> > +  :equivalent ioctl: N/A
> > +  :slave payload: vring state description
> > +  :master payload: N/A
>=20
> Similarly, that should be called VHOST_USER_SLAVE_VRING_CALL.
>=20
> Anyway, some comments would be appreciated. I'm working on an
> implementation now for my simulation environment, and I guess I can keep
> that private etc. but if there's interest I can submit an (optional)
> implementation of this for libvhost-user too, I think.

Is this really necessary?  Can the simulation interpose between the
call/kick eventfds in order to control when events happen?

  CPU --cpu_kickfd--> Simulation --vhost_kickfd--> vhost-user device

and:

  vhost-user device --vhost_callfd--> Simulation -->cpu_callfd-> CPU

The simluation controls when the CPU's kick is seen by the device and
also when the call is seen by the CPU.

I don't understand why new vhost-user protocol messages are required.

Stefan

--eRtJSFbw+EEWtPj3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12dycACgkQnKSrs4Gr
c8jJrAf/R5S4NkRhfiO0/hE/XvufZy/HI1Aic6J2lzULw1XX6agVQSGkquvb5yOn
7bMlSTs+6bTixkF7P0/32t8tisQlDcKJAkQ+jpYhKfRD92zS5RpJaWrDYEDw401Y
fqfuByu+GzPK9EtrTJCG4Pm1qkGoBpHddFOTKl1uU7TXuBqqra+R1bSiWFefWeJy
fbkQGgZ7CwX9WvaNTG/s5J3pgpt2iElPo5xa/YjuGLwI2132cqjzNaEAOwa02bjM
5vdwAzWxE3HHrjkm7NOLThpyI5AiuzdutHoavsfZVh6AM+AVRWXA8vpiCRYdeG0v
Q6PkIwIpBp7PvKAlCZczsZDle+4poA==
=vtrr
-----END PGP SIGNATURE-----

--eRtJSFbw+EEWtPj3--

