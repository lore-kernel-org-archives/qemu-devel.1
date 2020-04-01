Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A90C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:25:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CD7220772
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 07:25:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTIo+FOM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CD7220772
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJXkg-0004sZ-Ef
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 03:25:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46205)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jJXk3-0004Se-Mz
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:24:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jJXk2-0005SQ-My
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:24:51 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27716
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jJXk2-0005Nz-K2
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 03:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585725890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XcBZZFXe3xFZkmdpuu5ZuEnoCWmJ9dqeYzt5Yv0QGoI=;
 b=XTIo+FOM/pDl5AAidJ+xUYg5LqEOg7k/GbikF+CMnryAjJ2tiFiJ251a4dxcFuELyElHe4
 pqZKBEwHL65nXU0nXOun3xR3IEOTBUdI8nO8CxI/+92e8LLxh6pHJE3+Qz7QVhLtAMhQtG
 sQh8qvcdQglSJEwNzjKo7PKA/rrtc5w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-nOHQ5rxvNW2rmQvern3vSA-1; Wed, 01 Apr 2020 03:24:46 -0400
X-MC-Unique: nOHQ5rxvNW2rmQvern3vSA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 35BCF800D4E;
 Wed,  1 Apr 2020 07:24:45 +0000 (UTC)
Received: from gondolin (ovpn-112-252.ams2.redhat.com [10.36.112.252])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4AB1FDA0F2;
 Wed,  1 Apr 2020 07:24:41 +0000 (UTC)
Date: Wed, 1 Apr 2020 09:24:29 +0200
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v3] s390x: Add stsi 3.2.2 tests
Message-ID: <20200401092429.21e95d97.cohuck@redhat.com>
In-Reply-To: <e283a0ef-8f50-b677-cf42-66204d3164fd@linux.ibm.com>
References: <2ebc49ff-479a-351d-36f9-cb79fe4b9804@redhat.com>
 <20200331071456.3302-1-frankja@linux.ibm.com>
 <20200331113535.6bbd434d.cohuck@redhat.com>
 <82274eb6-2634-3400-b039-8fb49df6250e@redhat.com>
 <e283a0ef-8f50-b677-cf42-66204d3164fd@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/pmEs_WcAFmHMCyPWxLPoYrn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
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
Cc: borntraeger@de.ibm.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/pmEs_WcAFmHMCyPWxLPoYrn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 1 Apr 2020 09:20:49 +0200
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/31/20 7:24 PM, David Hildenbrand wrote:
> > On 31.03.20 11:35, Cornelia Huck wrote: =20
> >> On Tue, 31 Mar 2020 03:14:56 -0400
> >> Janosch Frank <frankja@linux.ibm.com> wrote:
> >> =20
> >>> Subcode 3.2.2 is handled by KVM/QEMU and should therefore be tested
> >>> a bit more thorough. =20
> >>
> >> s/thorough/thoroughly/ ? =20
> >=20
> > I fixed that up for now. =20
>=20
> Thanks
>=20
> >=20
> > [...]
> >  =20
> >>> +=09if (data->vm[0].ext_name_encoding !=3D 2) {
> >>> +=09=09report_skip("Extended VM names are not UTF-8."); =20
> >>
> >> Do we expect this to be anything other than UTF-8? =20
> >=20
> > I'm not a fan of hard-coding things that can change to other valid
> > values. No strong feelings though. I'll let Janosch decide :)
> >  =20
>=20
> I'd like to keep it as is.
>=20
>=20

Fair enough.

Feel free to add my

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--Sig_/pmEs_WcAFmHMCyPWxLPoYrn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl6EQa0ACgkQ3s9rk8bw
L6+5LQ//bgWVYeHO7rHn83vmqDwFToId/7XG9RHluZvB/5trZ24GjilMAXp1zRZZ
1at4YcnD+utygn40mVUXQAx9PVpuW2L1bssaE45gNL0g8RZmjfyiSViEgUXmk8k5
UUbeyJmZ/305Xy+xBeYI9d5ixfauoL4YFqBwGtkNK0hMLPQWAuoV21uR8rHsrURQ
OVsN2ujXLiuC6j3V7blUww73NjgvuC2FcXW5nNWwwOKfXVnN9bB587tDd+ln9dwY
YJFZ+o49gHR4qJcUXWb70TN28kMYzTpu99x98/fEGqf8ll+rq/BX0fSMaHhykugB
0oTeZqaptMHCZq/z0jmDTuLDWqsI0Z/46gMmRfcUydNeIlH57dBYZC7kjCwvQHj/
yQZTt64uKO89d/EszJNduC9IeG8PI2qV/m1941KSmlpCyt+/bZmwFNCk7gTuJesF
UcNDre0/plQctsImuXh8AvSvQv1kVqwWN+TMKnefIga39mWuBKgxTVBIN2ScCG7y
3irBFTFrOKmQg69xQgIQVBg5WYVIcizrhiqieSyr2p9kgD4nahi14B11GrRGHwMy
7EzgBLWixJWEhSvPTHOnPMPHO+umBOFapolMJ8J32nR6TDcXWyBuahDoltrk47Hs
MnoSOLOBfj+rFJ8sYELWKcn4Mk/xuMBvxdLxigJdkfU2K0eBzo4=
=UvPd
-----END PGP SIGNATURE-----

--Sig_/pmEs_WcAFmHMCyPWxLPoYrn--


