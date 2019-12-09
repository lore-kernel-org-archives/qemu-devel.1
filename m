Return-Path: <SRS0=fi8h=Z7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68AFCC04E30
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:08:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37FEC2077B
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2019 11:08:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VBq5iUXe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37FEC2077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ieGuB-0006pq-Ed
	for qemu-devel@archiver.kernel.org; Mon, 09 Dec 2019 06:08:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41209)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1ieGtP-0006Mv-57
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:07:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1ieGtO-0004tD-4F
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:07:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:49224
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ieGtO-0004sf-0s
 for qemu-devel@nongnu.org; Mon, 09 Dec 2019 06:07:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575889673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iaXGaA8ZzYvLSTNaXVxXETDGpsjvRR0CbsMPZIA4fhI=;
 b=VBq5iUXe5aY6GqGVuDPA+SUYa1RkPBG7tdZ5FHIQqpkQ8shJVL0n5nQGVal5UXlRHLaXHp
 kbrzd/I2FrGBehTK522PbnUck45G2dajm6Ow6dp3axtaykrZn0FjH8JyUHRSHnO4fW3Gi8
 6OlS18qDnrOufxt8CH27FGHbReY7fQY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-184-hkgelY28OBav0wRIMGU2Fw-1; Mon, 09 Dec 2019 06:07:50 -0500
X-MC-Unique: hkgelY28OBav0wRIMGU2Fw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9A720DC23;
 Mon,  9 Dec 2019 11:07:48 +0000 (UTC)
Received: from gondolin (dhcp-192-245.str.redhat.com [10.33.192.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 417636055B;
 Mon,  9 Dec 2019 11:07:47 +0000 (UTC)
Date: Mon, 9 Dec 2019 12:07:35 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [for-5.0 PATCH 0/4] ppc: Fix interrupt controller emulation
Message-ID: <20191209120735.4fe6e4ea.cohuck@redhat.com>
In-Reply-To: <20191209115947.2fb92760@bahia.w3ibm.bluemix.net>
References: <157548861171.3650476.14824062174573272058.stgit@bahia.lan>
 <20191209011428.GE2482@umbus.fritz.box>
 <20191209115947.2fb92760@bahia.w3ibm.bluemix.net>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/q4E/aV81sukE+xN5=PGcY9l";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: Laurent Vivier <lvivier@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@kaod.org>,
 Satheesh Rajendran <sathnaga@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/q4E/aV81sukE+xN5=PGcY9l
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 9 Dec 2019 11:59:47 +0100
Greg Kurz <groug@kaod.org> wrote:

> On Mon, 9 Dec 2019 12:14:28 +1100
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > On Wed, Dec 04, 2019 at 08:43:31PM +0100, Greg Kurz wrote: =20
> > > Guest hangs have been observed recently on POWER9 hosts, specifically=
 LC92x
> > > "Boston" systems, when the guests are being rebooted multiple times. =
The
> > > issue isn't POWER9 specific though. It is caused by a very long stand=
ing bug
> > > when using the uncommon accel=3Dkvm,kernel-irqchip=3Doff machine conf=
iguration
> > > which happens to be enforced on LC92x because of a host FW limitation=
. This
> > > affects both the XICS and XIVE emulated interrupt controllers.
> > >=20
> > > The actual fix is in patch 1. Patch 2 is a followup cleanup. The othe=
r
> > > patches are unrelated cleanups I came up with while investigating.
> > >=20
> > > Since this bug always existed and we're already in rc4, I think it is=
 better
> > > to fix it in 5.0 and possibly backport it to stable and downstream if=
 needed. =20
> >=20
> > Applied to ppc-for-5.0.
> >=20
> >  =20
>=20
> According to Cornelia's comments, it seems I need to respin this against
> the s390-next branch to avoid conflicts.


Aren't these ppc-only patches, though? Confused.

--Sig_/q4E/aV81sukE+xN5=PGcY9l
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3uKvcACgkQ3s9rk8bw
L68bYQ/+Lnv/ua3T7jlO0rXhvginPrb9+zX4iKBQ7KY/4nrPi1+DQrw/YCHANsWN
pB7x24bmUAWmvIcJ3F/Q9UsnbI0vqvmtbY2/XEsfs9YTqy3uKjkt9tO0xJ9TM9mO
8+Q0U6kNV5iyrXTpDfMLsgVaof6EjgNvkM5mbc3xvZHZ/OOWu6uo/u11Ze+EPsaj
hLAIroHdGiS83MjT7ZV/sCEjUHH6iZzH/orDlnbzTyJU2Rzdk4osK7iK7JJsiQwP
yirdkUfxZgvDIIBjy/sAmGlYYWTCqPK4rfV4njzu2VWPjsjnQM/Vgs+oklkRjN+e
ygKhljCwgkIzBMvCTElx63pHvRtlI7fgoHVXG/JYxQ+9Y+NXaqcSf+zwEGeUE+Sr
2js0QZ10vQ/qzQ5wUdV5PQS38uroti30jY37fi8DWozLPSx4qZ3thtjzG+Zd5Z4J
p9mH1esRQ3n1PCNiE10lvG/R3R9eGEkak9HagjGDFh+/i9GKAV/wPk7Fj6tDyMCY
HuzZRJk4EDgsqBLWxIXKj3dg4Olaqs2ImEKV2vRdwMznsQH/TCN4GpDtVAIBhykl
L5Kw/ckOGMMwIY4RqfyDJaL+VCDtvXVn8WBi7XUUMyLg+xFTkjilecHtoIgDR9Wx
vVj246d8TZXa/1j8+I76AJyzXIWyJhHP6Jcxf9BYa0KKGcsCEeg=
=aRa5
-----END PGP SIGNATURE-----

--Sig_/q4E/aV81sukE+xN5=PGcY9l--


