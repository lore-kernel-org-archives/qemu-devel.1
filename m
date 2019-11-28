Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D803DC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:28:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56C4521774
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 19:28:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeyVWMT3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56C4521774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaPSj-00032E-AS
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 14:28:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1iaNgv-0000fT-L7
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1iaNgg-0003m0-PQ
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:34:47 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32556
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1iaNgY-0003IM-Ao
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 12:34:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574962470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pBPbDORutuwZvbBTvLoOi0PBYVM3AHALLVGknygglq0=;
 b=ZeyVWMT3+vm/8BXw5TTRFaIm5GmCHcSRxlouhmykmwp2N0YywXzIQ2l9AUZcpucSlZfLwU
 JwaJ5DeAgYKSXdCRT5mNCaNLvI/SNo52nxzhOmGdhglezBuvRxsXLz1CFa3kmGIaOBGfhh
 IrWXAuJhq4xCBPHw4BC6sX492t9XU0g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-274-TdGYG7VyNTe8DKNArifXKg-1; Thu, 28 Nov 2019 12:34:28 -0500
X-MC-Unique: TdGYG7VyNTe8DKNArifXKg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E22CA800D53;
 Thu, 28 Nov 2019 17:34:26 +0000 (UTC)
Received: from gondolin (ovpn-116-200.ams2.redhat.com [10.36.116.200])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 956CE5C1B0;
 Thu, 28 Nov 2019 17:34:22 +0000 (UTC)
Date: Thu, 28 Nov 2019 18:34:09 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v4 6/6] s390x: kvm: Make kvm_sclp_service_call void
Message-ID: <20191128183409.4a91ea1c.cohuck@redhat.com>
In-Reply-To: <452fc85c-17b7-76d3-8ed8-fb76d50b37a6@linux.ibm.com>
References: <20191127175046.4911-1-frankja@linux.ibm.com>
 <20191127175046.4911-7-frankja@linux.ibm.com>
 <c3b81ef7-860d-8cee-df34-0c6f103a1757@redhat.com>
 <76627b69-5c0a-a9d6-f20e-f7ce61858774@linux.ibm.com>
 <452fc85c-17b7-76d3-8ed8-fb76d50b37a6@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="Sig_/T+caPbvXbBsAv=WL70CK31w";
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
Cc: thuth@redhat.com, pmorel@linux.ibm.com,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 borntraeger@de.ibm.com, qemu-s390x@nongnu.org, mihajlov@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/T+caPbvXbBsAv=WL70CK31w
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 Nov 2019 19:38:06 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 11/27/19 7:25 PM, Janosch Frank wrote:
> >=20
> > There's 0 (initiated), busy and operational and as far as I know we
> > implement neither. =20
>=20
> That came out wrong...
> s/operational/not operational/
>=20
> We only implement "command initiated" / cc =3D 0
> We can never have busy, because we handle sclp calls synchronously.
> The spec does not give any indication when we could return "not
> operational". I guess that's just a free pass for hypervisors.

Regardless, setcc(cpu, r) also feels a bit cleaner to me...

>=20
> > sclp_service_call() returns either 0 or -PGM_CODE, so we don't need to
> > check when we're after the pgm injection code. =20
>=20
>=20


--Sig_/T+caPbvXbBsAv=WL70CK31w
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl3gBREACgkQ3s9rk8bw
L6/n1w//SgYz1VZH8/LQskD48SXgc/z8AVDErey2akV35GNHjYHJEYCB9VD7aYsz
rXDb1jiJzv43Y79ue7//gZb2EMtrf0gWzycerOmKtGKjsVJn40uGRLoR79pDRx2A
J9Y/Run7cfwJtvnELLC/t0eh46XL+nXGRyh5ygi9mgbY9+B3GLyww5o654+4HfCe
vIfpaeb3jAEp0fjuHDzBX5ec6TAY6WCqg3pb4vCv77lM983IO9w5gLkiIg9VCECZ
gAnsKLQHt4B9o7iwbMaob1LOm6hRGyrzUIrjsa34a7+apF+0wZ5OHt8djSq6MWrF
tDb6lGdO5Gea9HoWhoY0Azo7ak5NCpQVdlzVAtSt/KCJWLV1x5ntjf4Uv/M2wfw5
VUuFeYgVxa/AQkgkxgUGhRNHg9iFf0bWKbfM5Di/qNP+0Kwp37YGj63wfmga7uMH
60pJaLtivfGJaeHkDhEwfhiD60b2f2iX8aspuD2xG5/gf+L/Vm9wKL31/iAHpr+D
1/kji834gAD73dLKvvN7xZT8yFDp7mZLHo219lJ23Z7ZQnPxNajs13E9N8td0blX
v8MMpuvAasJ6i3QtP5Rfi4pb8mXSz2qFbTnx+t8m2VzgS1x3PTP3c97yh89NUuXB
To1PpiEz8Amj9zDteszSQ6hvdtOwrth2prVeXDfGCi5D1y4C94U=
=9bId
-----END PGP SIGNATURE-----

--Sig_/T+caPbvXbBsAv=WL70CK31w--


