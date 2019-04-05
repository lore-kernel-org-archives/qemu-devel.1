Return-Path: <SRS0=1I+v=SH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ECBCC10F13
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 42EEB218AE
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2019 12:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 42EEB218AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41554 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hCOGB-0002CV-F8
	for qemu-devel@archiver.kernel.org; Fri, 05 Apr 2019 08:47:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:42307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOEg-00013n-3T
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:46:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hCOEe-0006NF-Tv
	for qemu-devel@nongnu.org; Fri, 05 Apr 2019 08:46:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50630)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hCOEc-0006FX-43; Fri, 05 Apr 2019 08:46:18 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
	[10.5.11.23])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 12282306C9E5;
	Fri,  5 Apr 2019 12:46:17 +0000 (UTC)
Received: from linux.fritz.box (ovpn-117-134.ams2.redhat.com [10.36.117.134])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id D91FC1A7CA;
	Fri,  5 Apr 2019 12:46:09 +0000 (UTC)
Date: Fri, 5 Apr 2019 14:46:08 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190405124608.GA4597@linux.fritz.box>
References: <20190328182810.21497-1-kwolf@redhat.com>
	<20190405103247.GG25152@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VS++wcV0S1rZb1Fb"
Content-Disposition: inline
In-Reply-To: <20190405103247.GG25152@stefanha-x1.localdomain>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 05 Apr 2019 12:46:17 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/2] file-posix:
 query-qemu-features for auto-read-only
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
Cc: pkrempa@redhat.com, armbru@redhat.com, qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190405124608.n-SHnhQfdezt5RWEbRTqzQ8yTnjwvS7NnwbCOVg79E0@z>


--VS++wcV0S1rZb1Fb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am 05.04.2019 um 12:32 hat Stefan Hajnoczi geschrieben:
> On Thu, Mar 28, 2019 at 07:28:08PM +0100, Kevin Wolf wrote:
> > auto-read-only=3Don changed its behaviour in file-posix for the 4.0
> > release. This change cannot be detected through the usual mechanisms
> > like schema introspection.
> >=20
> > I took Stefan's patch 'qmp: add query-qemu-capabilities', removed the
> > feature that he originally wanted this for and addressed the review
> > comments. The introduction of the file-posix-dynamic-auto-read-only
> > feature is a separate patch.
> >=20
> > Stefan, I kept you as the author of the first patch and also your
> > Signed-off-by. Is this okay with you or would you prefer a change?
>=20
> Sorry I was unresponsive.  I'm fine with the authorship and
> Signed-off-by: but won't be offended if either or both are removed when
> the patch is reworked (my code is trivial).

The plan is now that we integrate features in the QAPI schema (attached
to struct definitions), so they will be available with the normal schema
introspection. Obviously, this will be a completely new patch series
that isn't based on this patch any more.

Kevin

--VS++wcV0S1rZb1Fb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJcp04QAAoJEH8JsnLIjy/Wr+gP/1DVOdxvZnHw/UvD6eB9Ioay
HSr3pthwSk/ClsVtyu9+rTnpmgIlxhVf/PKU1Xhwohv5dk5RRQtfUqY+FQRj9uW9
eUlVAcuQ96xDg1pEjM0DWLSUBph0FvXD1xLChNMkt6LRxsaCj4Uqg4jPZvAWEg9s
PEyE2Z2WEESlgsOvRGJG3KpgxW4hLFnNDpuDvm71JgysO2j2U2Huwpj38m0NQ91o
Q/YvG6yBg2PtmKsCyH2+IwoWz/Gy8OYZBjq+WGbXSEo+QrhD18WYm83yqKbvfYx9
R4MbDIO1vIaJy7i6thWmq5ssYBbxp1I7yZRXaPacVHVKnQRyACLpMgi6h7d5Ykju
BrbwkAXQDJA5WF8VUbs10WGr/8umkDJb+43vr/6d/KUcfUiw13cs46PlcsCHTAT+
tw1soH6UfmhABaByyWq+TEmh0m/VR1EbqQ6RxI8c8FBFvkvTeB+6SHayUfCO/8wN
qO30sDI/J3z2fysWRo0gxE8sPANm5xzWSrL48Ep3mpShycqHaXXTUalME5+24Cdk
+9e1xhChEk8gXONnYZa+mf5p2ZcaolF4BoGvMPJsna017S7SnuHeLUQIuat1Hg9V
+A5pMItHeQxHRRfjIcoL+3w6gIRSvb1i//YJSjtgXX97iEMfYpIp1EuAni8fimIa
Ry9j8hilGNeHQdUTOiwb
=8iFh
-----END PGP SIGNATURE-----

--VS++wcV0S1rZb1Fb--

