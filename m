Return-Path: <SRS0=McoT=XE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 526D1C4740A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295D1218DE
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2019 12:38:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295D1218DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56096 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i7Iw2-0005La-9U
	for qemu-devel@archiver.kernel.org; Mon, 09 Sep 2019 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1i7IvN-0004u4-JT
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:37:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1i7IvL-0000DN-GW
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:37:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:24080)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1i7IvL-0000Cd-9D
 for qemu-devel@nongnu.org; Mon, 09 Sep 2019 08:37:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DE2F6309DEE0;
 Mon,  9 Sep 2019 12:37:37 +0000 (UTC)
Received: from localhost (ovpn-117-125.ams2.redhat.com [10.36.117.125])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 279636061E;
 Mon,  9 Sep 2019 12:37:36 +0000 (UTC)
Date: Mon, 9 Sep 2019 14:37:35 +0200
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Eryu Guan <eguan@linux.alibaba.com>
Message-ID: <20190909123735.GE13708@stefanha-x1.localdomain>
References: <20190905152136.30637-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <20190905152136.30637-1-stefanha@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Mon, 09 Sep 2019 12:37:38 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [RFC 0/3] virtiofsd: get/set log level via DBus
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
Cc: virtio-fs@redhat.com,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 05, 2019 at 04:21:33PM +0100, Stefan Hajnoczi wrote:
> It is likely that virtiofsd will need to support "management commands" for
> reconfiguring it at runtime.  The first use case was proposed by Eryu Gua=
n for
> getting/setting the current log level.
>=20
> I promised to try out DBus as the management interface because it has a r=
ich
> feature set and is accessible from most programming languages.  It should=
 be
> able to support all the use cases we come up with.
>=20
> This patch series is a prototype that implements the get-log-level and
> set-log-level management commands via DBus.  Use the new virtiofsctl tool=
 to
> talk to a running virtiofsd process:
>=20
>   # dbus-run-session ./virtiofsd ...
>   ...
>   Using dbus address unix:abstract=3D/tmp/dbus-H9WBbpjk3O,guid=3D0be16ace=
fb868e6025a8737f5d7124d2
>   # export DBUS_SESSION_BUS_ADDRESS=3Dunix:abstract=3D/tmp/dbus-H9WBbpjk3=
O,guid=3D0be16acefb868e6025a8737f5d7124d2
>   # ./virtiofsctl set-log-level err
>=20
> Most of the work is done by gdbus-codegen(1).  It generates code for the
> org.qemu.Virtiofsd.xml interface definition.  Our code can use the simple
> virtiofsd_get/set_log_level() APIs and it will make corresponding DBus ca=
lls.
>=20
> I'm pretty happy with this approach because the code is straightforward. =
 It
> hasn't even triggered seccomp failures yet :).
>=20
> Error handling is a little problematic.  I noticed that virtiofsctl silen=
tly
> returns success even if it cannot talk to virtiofsd.  This is due to the =
code
> generated by gdbus-codegen(1) which has no error reporting :(.  This can =
be
> solved by writing more low-level GDBus code instead of using the high-lev=
el
> generated bindings.
>=20
> What do you think about this approach?

Hi Eryu Guan,
Have you had a chance to try these patches?  Do they meet your
requirements for being able to get/set the log level at runtime?

Stefan

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl12R48ACgkQnKSrs4Gr
c8inMwf/S33Jzq9qoUqyhtPqOS/dzEtmMg9hxfQ7jLb/HWdi0HRvJSIzeEwst1GV
3LGOFZcpvYx3oYPP24gwfrUg1HCziPT5B+qMNWzAWaSbGpiGKBK0FbqXFk07HLst
eEkYIGh/dNGnSgVEV6qDcVULUUhQdPJeCYUQrVYZoUajKnT/gHIHSuL3slhrko9o
XQnANtllc8KgGp4UVcTUQRhCbfjKfPRF2XzfRlQv2qd5kADgRc+hZeYReCS8UZNR
MYze0/S16FFQEmbayWWlXkkNTKtAQ9cP4fO7Xpt0ujLtylQp5oxOI+PMKwvbS77y
gGteeGdDFdybFoSr1+KVp28aGREgKw==
=OKkS
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--

