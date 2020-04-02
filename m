Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DB5C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:07:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4290D2077D
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 09:07:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUqDsmZm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4290D2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJvpL-0005fW-FK
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 05:07:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1jJvoX-0004q5-PE
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1jJvoW-0006S8-T4
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:07:05 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51921
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1jJvoW-0006Rm-Pq
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 05:07:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585818424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCWiwW5vLbNby8hM/7B5SMTuRdLR4Izx1A6Eoe/s4lw=;
 b=FUqDsmZmkPw4DB1Jlot442lMdaWWRUYTDTZzsl2RlLjVNnHj7MyQFzOxYMtv2hELlfBSLS
 WiIxn3n1XLzJP4J6f9jNdr/I/rOEh2enVoXYwqfwvl3VcJJs9gHVu2VJHqOHkb+g5Sv9y2
 1qy9adZnNs2Gb6S5/JwV0uDDOxzv3VI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-215-VOfYwslTPwGdBkb0fnx3FQ-1; Thu, 02 Apr 2020 05:07:00 -0400
X-MC-Unique: VOfYwslTPwGdBkb0fnx3FQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E16A310096C4;
 Thu,  2 Apr 2020 09:06:58 +0000 (UTC)
Received: from localhost (ovpn-113-134.ams2.redhat.com [10.36.113.134])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6AE9963147;
 Thu,  2 Apr 2020 09:06:55 +0000 (UTC)
Date: Thu, 2 Apr 2020 10:06:54 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>
Subject: Re: QEMU participation to Google Season of Docs
Message-ID: <20200402090654.GB28280@stefanha-x1.localdomain>
References: <de92e66d-c474-dd1b-ddab-194b2f92d1dd@redhat.com>
 <36614289-5498-7a78-5f8e-1b4da84261ad@redhat.com>
MIME-Version: 1.0
In-Reply-To: <36614289-5498-7a78-5f8e-1b4da84261ad@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="/NkBOFFp2J2Af1nK"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-discuss@nongnu.org, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--/NkBOFFp2J2Af1nK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 01, 2020 at 06:46:02PM +0200, Paolo Bonzini wrote:
> On 01/04/20 18:37, Philippe Mathieu-Daud=E9 wrote:
> >=20
> > * Refactor the open source project's existing documentation to
> > =A0 provide an improved user experience or a more accessible
> > =A0 information architecture.
>=20
> This kind of project would be indeed very suitable to QEMU.  Stefan,
> perhaps you could help by providing the text for our Summer of Code
> submission?

Philippe, would you like to be the Google Season of Docs administrator
for QEMU?  I don't have enough bandwidth to be involved myself.

I can provide you the QEMU's GSoC 2020 application form which might have
useful snippets you can reuse for building a GSoD application for QEMU.

Stefan

--/NkBOFFp2J2Af1nK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl6Fqy0ACgkQnKSrs4Gr
c8hsVAf9EVweyp90JO+YPlgN/pWI74SbIKPQFAfkBZ8jJ3nKpGdjkvAKbUgDPFK2
V/PX/Jnps9PEYgfcsFdVLBatDpmEMB18/UKUXVOzIOV/OhRQBy5HRdwsBXPhvgvF
jiq5IvXQCU7+kHw8XBf6hAIrNW9RE+X9ITd9z+vMMNzMsPYLR7wgjAuxlZst4JJm
FZdaQQd7DIOoUxmRzxwQaRoo2rBz6dwz5TnnXd6PByRNnLmrPguvYBW1M3wH39kI
C07/mRtS+AX4bO+xJcdwjE3yt1MTcaP6PFaRcJYMmIEK283d1bYMYRS/HSckRsM2
y2bfB6gqgJjyZfy9i5VnnvKzCrht3g==
=6zLF
-----END PGP SIGNATURE-----

--/NkBOFFp2J2Af1nK--


