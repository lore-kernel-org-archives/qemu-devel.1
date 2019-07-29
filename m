Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B4CC7618B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:22:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D50D2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 11:22:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D50D2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs3jX-0005IJ-Bw
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 07:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49065)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ptoscano@redhat.com>) id 1hs3j5-0004pt-Qy
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:22:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ptoscano@redhat.com>) id 1hs3j4-0001Lk-RH
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 07:21:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57024)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ptoscano@redhat.com>)
 id 1hs3j2-0001KC-9k; Mon, 29 Jul 2019 07:21:56 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4272C307D978;
 Mon, 29 Jul 2019 11:21:55 +0000 (UTC)
Received: from lindworm.usersys.redhat.com (unknown [10.43.2.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AF2795D9C3;
 Mon, 29 Jul 2019 11:21:53 +0000 (UTC)
From: Pino Toscano <ptoscano@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Date: Mon, 29 Jul 2019 13:21:34 +0200
Message-ID: <2550520.5yHEQrR4yj@lindworm.usersys.redhat.com>
Organization: Red Hat
In-Reply-To: <87ftmprtuj.fsf@dusky.pond.sub.org>
References: <20190726140954.31921-1-ptoscano@redhat.com>
 <28464409.aSG18riZGY@lindworm.usersys.redhat.com>
 <87ftmprtuj.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1746126.sGHGHDKn35";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.48]); Mon, 29 Jul 2019 11:21:55 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 2/2] ssh: implement private key
 authentication
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
Cc: kwolf@redhat.com, pkrempa@redhat.com, qemu-block@nongnu.org,
 rjones@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--nextPart1746126.sGHGHDKn35
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

On Monday, 29 July 2019 12:57:40 CEST Markus Armbruster wrote:
> Pino Toscano <ptoscano@redhat.com> writes:
> 
> > On Friday, 26 July 2019 16:24:34 CEST Eric Blake wrote:
> >> On 7/26/19 9:09 AM, Pino Toscano wrote:
> >> > Add a 'private-key' option which represents the path of a private key
> >> > to use for authentication, and 'private-key-secret' as the name of an
> >> > object with its passphrase.
> >> > 
> >> > Signed-off-by: Pino Toscano <ptoscano@redhat.com>
> >> 
> >> > +++ b/qapi/block-core.json
> >> > @@ -3226,6 +3226,11 @@
> >> >  # @password-secret:     ID of a QCryptoSecret object providing a password
> >> >  #                       for authentication (since 4.2)
> >> >  #
> >> > +# @private-key:         path to the private key (since 4.2)
> >> > +#
> >> > +# @private-key-secret:  ID of a QCryptoSecret object providing the passphrase
> >> > +#                       for 'private-key' (since 4.2)
> >> 
> >> Is password-secret intended to be mutually-exclusive with
> >> private-key/private-key-secret?
> >
> > My initial thought was to allow users to specify data for all the
> > authentication methods possible.  Either ways (all of them, or a single
> > one) are fine for me.
> 
> How does this work at the libssh level?  Can you configure multiple
> authentication methods, and let negotiation pick the one to be used?

The remote servers sends all the authentication methods supported, and
the user of libssh can decide which one(s) to attempt.  See for example
the small tutorial in the libssh documentation:
http://api.libssh.org/stable/libssh_tutor_authentication.html

-- 
Pino Toscano
--nextPart1746126.sGHGHDKn35
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEbjdOQa52nq0tQalew9FMLZhkN80FAl0+1r4ACgkQw9FMLZhk
N80TQRAAnZ36GQplntjEMq4Zi2TRY5B7NptCr1M4oDzi2+iI0I4YOY+QoQzqjFYk
BXlNleLwcKir3BDsXX1cdDbjDfzP8d+xVAk87kSkOwPcLvhQozhdJWpbkP2d2a+E
uH5SkT6pVjNAZShbvCf00g2SMVhMbWuiQBDeYYNK2KVcIyexIAO3UFpHV0/sL1Bp
2Ps5eoDz2uQiLJFuun5k9/Fa8a0VsbQ69Cq9+JFl37PCeJlsoKjmxC9c/JUzMfZB
x0XZztkvATwbYBs1DQQ78g5s4uB4WFbQNnMTJl5TqGXRFlILAHnAgIt2hlJWhLd4
6rckvbRncCIatUXO4Kk7FlraMfATOE/54nEseCg55TVqVU0/If1zO9YAXYO3ajKa
4on7ps8UZ1170YeAfBQv8BpGslCEm3zxKLE5k917avDgE6HEcYNPfxbEZBXFV/6c
qQ+kJz5KTIg07a9kN1asImel1czjKTipAfqLdGpmICCWreKIcUrcBXwCkbZeOHY+
3gdMOFx3RGfHkC5j6WoEO1ywejOCN8EA1vl9D2qxxax+vfRFmR1I2Kw2c6HCwyX6
vYEUXQQQ7SdvLEL3R01i6K4RJ1IM8h6qUWnly/s00qTtVggyzE8ZorNz7jVCkmPu
5lr6iDrYMPkTg3NOMchdvA/2Zp8TfmIrQX9X+SdAyRiM85mx5fw=
=hPIo
-----END PGP SIGNATURE-----

--nextPart1746126.sGHGHDKn35--




