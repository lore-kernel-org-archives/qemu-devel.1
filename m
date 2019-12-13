Return-Path: <SRS0=VaDC=2D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED76C2D0CA
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:42:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D7D021655
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Dec 2019 10:42:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjQJe+jT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D7D021655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifiOm-0002b5-7V
	for qemu-devel@archiver.kernel.org; Fri, 13 Dec 2019 05:42:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60518)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefanha@redhat.com>) id 1ifiO1-00028o-61
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:41:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@redhat.com>) id 1ifiNz-00049y-Bf
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:41:28 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33172
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1ifiNz-00048q-69
 for qemu-devel@nongnu.org; Fri, 13 Dec 2019 05:41:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1576233686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FXz59p1KIpTBr9xtrwlHS2/WaXmtVcvDqgnSoiK09RM=;
 b=PjQJe+jT6PsaXTJkYNXe9HQ0vQtKf7XCG/35WikgEC+QCpDzIJstyGn5l7S4gGoCSMQ8kj
 FBkFgv0ESzuD02BLWEYef1QUpJl//iGzHOQ87rlELFGeBHS2vGdDn+qrbwAR0ha+ierqbh
 tK3CTVP83KxdAzPpT6CSECukrnukwrI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-366-p0YK2oCINk6Golz3VZ7aIQ-1; Fri, 13 Dec 2019 05:41:25 -0500
X-MC-Unique: p0YK2oCINk6Golz3VZ7aIQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B7011005512;
 Fri, 13 Dec 2019 10:41:23 +0000 (UTC)
Received: from localhost (unknown [10.36.118.64])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 799B019C4F;
 Fri, 13 Dec 2019 10:41:17 +0000 (UTC)
Date: Fri, 13 Dec 2019 10:41:16 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Subject: Re: [RFC v4 PATCH 00/49] Initial support of multi-process qemu -
 status update
Message-ID: <20191213104116.GB1180977@stefanha-x1.localdomain>
References: <cover.1571905346.git.jag.raman@oracle.com>
 <20191210064716.GA6401@flaka>
MIME-Version: 1.0
In-Reply-To: <20191210064716.GA6401@flaka>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
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
Cc: fam@euphon.net, john.g.johnson@oracle.com, mst@redhat.com,
 qemu-devel@nongnu.org, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, armbru@redhat.com, kanth.ghatraju@oracle.com,
 felipe@nutanix.com, thuth@redhat.com, ehabkost@redhat.com,
 konrad.wilk@oracle.com, dgilbert@redhat.com, liran.alon@oracle.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--3uo+9/B/ebqu+fSQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 09, 2019 at 10:47:17PM -0800, Elena Ufimtseva wrote:
> At this moment we are working on the first stage of the project with help=
 of
> the Nutanix developers.
> The questions we have gathered so far will be addressed with muser
> and Qemu developers after we finish the first stage and make sure we unde=
rstand
> what it will take for us to move onto the next stage.
>=20
> We will also incorporate relevant review from Stefan that he provided
> on the series 4 of the patchset. Thank you Stefan.
>=20
> If anyone have any further suggestions or questions about the status,
> please reply to this email.

Hi Elena,
At KVM Forum we discussed spending 1 or 2 weeks trying out muser.  A few
weeks have passed and from your email it sounds like this "next stage"
might be a lot of work.

Is there a work-in-progress muser patch series you can post to start the
discussion early?  That way we can avoid reviewers like myself asking
you to make changes after you have invested a lot of time.

It's good that you are in touch with the muser developers (via private
discussion?  I haven't seen much activity on #muser IRC).

Stefan

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl3zaswACgkQnKSrs4Gr
c8hZzgf/WCt/3kYE6z8TM6uvtBeADyRqIplOuv/b3Fll4maY9A8PqVQ0JgxLd/B5
QVUNB7vU+fyBKmbg8B3pyAQ/WEZbfoj8gRdN7pb3kdk0mfBaqiNUTZBsO+b5TUsO
Ndc0N2n5E5NJHYONtL5S/ex3CTAT4bvovMBjbVn2RwgcGvf0A78pAWdF8g3E2neG
PpWgwzn6jxZlZNwpUc1QbUma6W/yrHh0qjxG7BVqYq5ABJRZrOLP1Cn3Gez2wRoc
xc3KkvUFwlWwDeVw4WkdtYExr0nJ/aB05ZfNIqiKGgD79mD1xo2/Hu53C3o5+owh
N8prM+tCnDS+8G+KWKydL5CCt07Big==
=BvHz
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--


