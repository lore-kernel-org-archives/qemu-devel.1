Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 302F9C072A4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 03:32:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2DF8217D9
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 03:32:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="LFNgXNq2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2DF8217D9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34910 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTHz9-000754-9X
	for qemu-devel@archiver.kernel.org; Tue, 21 May 2019 23:32:11 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTHxr-0005zo-Jl
	for qemu-devel@nongnu.org; Tue, 21 May 2019 23:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hTHxq-0004cy-DQ
	for qemu-devel@nongnu.org; Tue, 21 May 2019 23:30:51 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:52955 helo=ozlabs.org)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>)
	id 1hTHxp-0004aS-JO; Tue, 21 May 2019 23:30:50 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
	id 457ynw60BHz9s7h; Wed, 22 May 2019 13:30:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=gibson.dropbear.id.au; s=201602; t=1558495844;
	bh=gCOq24bADcAh5QF0lEBrXSpS+aITBdYveTM6zj/1D0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LFNgXNq2I3uWkAIqrV1VkcvicDDgbhhD5KF4tYqaCX1wvpe+dIKL3DjJ3Y/Ll7hXB
	bdkFWrsiYqHTWbOdI0kNXRdQIWTQsInwPna5IDwDPbOU6AOkoDjIXyQx44oVV6WZiH
	Fv8y6ZyktHlw4NSRVpwNpKGY+StOqwxJtmd114vY=
Date: Wed, 22 May 2019 10:49:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Anton Blanchard <anton@ozlabs.org>
Message-ID: <20190522004924.GF30423@umbus.fritz.box>
References: <20190507004811.29968-1-anton@ozlabs.org>
	<20190507004811.29968-4-anton@ozlabs.org>
	<c1d2a4cf-a9a7-4dfa-ed80-987118043f08@ilande.co.uk>
	<20190522061112.3accdb76@kryten>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3oCie2+XPXTnK5a5"
Content-Disposition: inline
In-Reply-To: <20190522061112.3accdb76@kryten>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2401:3900:2:1::2
Subject: Re: [Qemu-devel] [PATCH 4/9] target/ppc: Fix lxvw4x,
 lxvh8x and lxvb16x
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
Cc: ego@linux.vnet.ibm.com, sandipandas1990@gmail.com,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	richard.henderson@linaro.org, qemu-devel@nongnu.org,
	f4bug@amsat.org, qemu-ppc@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--3oCie2+XPXTnK5a5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2019 at 06:11:12AM +1000, Anton Blanchard wrote:
> Hi,
>=20
> > I've now had a bit of time to look through this and I believe it is
> > correct, so:
> >=20
> > Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>=20
> Thanks Mark. David: any chance we could get this merged? I can't run a
> recent Ubuntu image successfully without it. sshd hangs when I try to
> ssh into it.

I had a comment that was never addressed - it didn't look like the xth
and xtl temporaries were initialized after the patch.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3oCie2+XPXTnK5a5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlzknJEACgkQbDjKyiDZ
s5IF/Q//ftquz60qBleyvFpAfWXZxKdEJ6Cx8GgetIjQVXjsNDFUqg/jftQ0H6Za
sswAAhxWy0zaSw0Ah4HODqUkTLv7MekS72KHtzr+LrfIIB5h0+++uOxtV7d/teST
EkdlIYTj17m3r2UTodHh3+EvXYfjPFGe2js/RSXcqspGuTYbhVhqVcazxzBWpJxa
B0ao5CEENKfmzWWIM00yaaUGPI58HmczflxeNpIBfzw4SH/kBDXkBmLdP3gb56sy
jHkfLeH59JtjQXGsEOWJTthoRhImn5YEyTIZ98zqRzjZjJBK3/qm0Ye+794e73WW
8FZY9GW4D+v9eUMJ0lTwc9lTLAw7/5JFGRzkF7+Wna+j5xB58AXZkdd3NucvrNK7
6vD0bmHxRjL0586BRxXxokU6jgXlOT1RzpgwvwkFueGeJ94oQeqtQLzBZvnri7EK
ktx+LgijQ/LJ+o9Q1qPNLzwAoj5jcJgAWE5aDy/z9tekPXRtTcutKQ7Zn7EX0MO9
aNTuj/p+9Yx7z7S9VdY2qwz+xPDYS1oQ05HSTVAtwRix5JbQO88Mnbo5CTbhz20d
bgdMs6gSu2EeWtHqaram1N07CP2g81H4URjjbI6YK1OIZK+GcRnyrWiKdwBnPsyc
Ir1APNYYG9OdA5P9j689smzSl+c3cNp7SlErI5NyPWrVr8nqY8U=
=WMO9
-----END PGP SIGNATURE-----

--3oCie2+XPXTnK5a5--

