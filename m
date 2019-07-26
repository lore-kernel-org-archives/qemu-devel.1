Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F12C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 76CD520651
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:46:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 76CD520651
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1U3-0007zx-Cp
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:46:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47097)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hr1TZ-0006QF-3t
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:45:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hr1TX-0001Aq-1X
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:45:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43817)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hr1TT-00015n-HA; Fri, 26 Jul 2019 10:45:35 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1CD4DC0AF07F;
 Fri, 26 Jul 2019 14:45:34 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BFEB7A00C;
 Fri, 26 Jul 2019 14:45:19 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: "Richard W.M. Jones" <rjones@redhat.com>
Date: Fri, 26 Jul 2019 16:45:03 +0200
Message-ID: <4422965.dTeGc4fl6G@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <20190726142710.GY3888@redhat.com>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <20190726142710.GY3888@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart16494040.0sQhf7Hk5G";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 26 Jul 2019 14:45:34 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 0/2] ssh: add password and privkey auth
 methods
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart16494040.0sQhf7Hk5G
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Friday, 26 July 2019 16:27:11 CEST Richard W.M. Jones wrote:
> On Fri, Jul 26, 2019 at 04:09:52PM +0200, Pino Toscano wrote:
> > These two patches add the password and private key authentication
> > methods to the ssh block driver, using secure objects for
> > passwords/passphrases.
> 
> I was attempting to test this but couldn't work out the full command
> line to use it (with qemu-img).  I got as far as:
> 
> $ ./qemu-img convert -p 'json:{ "file.driver": "ssh", "file.host": "devr7", "file.path": "/var/tmp/root", "file.password-secret": "..." }' /var/tmp/root
> 
> I guess the secret should be specified using --object, but at that
> point I gave up.

Almost there :) add e.g.
  --object 'secret,id=sec0,file=passwd'
as parameter for the convert command (so after it, not before), and then
set 'sec0' as value for file.password-secret.  Of course 'sec0' is
arbitrary, any other QEMU id will do.

A long helpful comment in include/crypto/secret.h explains the basics
of the crypto objects.

-- 
Pino Toscano
--nextPart16494040.0sQhf7Hk5G
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl07Ee8ACgkQw9FMLZhk
N812ig//fZ2HnxytEP2NI69POcSDe9rhKugoPB3wdCNK9pv+SppFdRP8rgQdWFwu
a9MezwlwoQStX2f3fuq5NaTJm9tzVBqGkHtne0c5X7K5GlkClmDPZGq46sldfnm/
vmSVtxDovRZqrY/UDlpk2U/k8QNIJDcdrCBeH2e33yT0UYJAUHnGV8vc0eVqPYsK
2tnChBNkNgXNftoDS/2np0gl4ME0A6GrbuOZ6huZivUSoR0llQKjHn6/n8sDR+fc
/migDjoqUVAun8EVwFmjam30dGmmg89j7QnCXPrhgZy6AdbZesgPZqobEkuA12sw
rYy0jbi2GaYEO4F9TFncgrtzxEu/gKMUP6U/CbDyC2CPW4B4+W28asuojrHxoMqY
vPwkhwEyhZsUOhaxd6Z2uxIAj6vEZJafiLj5mdClSvkpwETKq6djqCJuA+kOXY/o
sQbM1TKqp1cTbmBVplEeo3CI9OTgV3FhK0bvAcHeP9QREvsynlfHJxQZB3L4jn34
tZowCLSQX03A/LsMswBrTxLCQ2UCoFA63E2utJm/awGD1PdwdHdCVzxtZw9tinw3
3zI7StwPMJCU2icQKpNJPa+G4cCS7ZkZucqzEfAn2Ndw66JjAEdIcAK9zAoU202c
aG78hCEXqzkUNThWoVdZ+mQGmoAibranGK4g8WEHB6VkYkAvGac=
=WflM
-----END PGP SIGNATURE-----

--nextPart16494040.0sQhf7Hk5G--




