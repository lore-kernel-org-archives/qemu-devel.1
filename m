Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45B43C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:14:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F63F2072D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 14:14:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ed8CaGu0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F63F2072D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8OrC-0000ta-FU
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 10:14:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8Oq8-00088r-Vr
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:13:20 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:21531
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1k8Oq5-0006Yd-VM
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 10:13:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597846395;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kj/V1UlGBP0JIPFeHzffSdBlICo0fyx/j5PgSuvDD0U=;
 b=Ed8CaGu0nfIHONjsRiMIH7pxHMpXFzIs2iDjS/rvkHu5sCZT2zUdmIixgGV1QYuAFd604l
 dPnndTTUGk4p395XRKrbs7ajyFR4+LKuhe86GVBfRM56yAqJe4y9eB4RhnCUXP5W5bTP8H
 HDk9x9fH/zqXe9+Y2lL1/bUj+RsSW6Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-zBJHFCOPMOWeq59LxJtggw-1; Wed, 19 Aug 2020 10:13:10 -0400
X-MC-Unique: zBJHFCOPMOWeq59LxJtggw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D6E60801AAF;
 Wed, 19 Aug 2020 14:13:08 +0000 (UTC)
Received: from localhost (ovpn-113-22.ams2.redhat.com [10.36.113.22])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3B93610013C2;
 Wed, 19 Aug 2020 14:13:01 +0000 (UTC)
Date: Wed, 19 Aug 2020 15:12:59 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v6 2/7] hw: add 5.2 machine types and 5.1 compat options
Message-ID: <20200819141259.GD366841@stefanha-x1.localdomain>
References: <20200818143348.310613-1-stefanha@redhat.com>
 <20200818143348.310613-3-stefanha@redhat.com>
 <20200818171132.551e2c72.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200818171132.551e2c72.cohuck@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=stefanha@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="SO98HVl1bnMOfKZd"
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 01:46:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
 Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <ehabkost@redhat.com>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, David Gibson <david@gibson.dropbear.id.au>,
 Max Reitz <mreitz@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--SO98HVl1bnMOfKZd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 18, 2020 at 05:11:32PM +0200, Cornelia Huck wrote:
> On Tue, 18 Aug 2020 15:33:43 +0100
> Stefan Hajnoczi <stefanha@redhat.com> wrote:
>=20
> > arm, i386, ppc, and s390x have versioned machine types and associated
> > compatibility options. Introduce new ones now that QEMU 5.1 has been
> > released.
> >=20
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > ---
> >  include/hw/boards.h        |  3 +++
> >  include/hw/i386/pc.h       |  3 +++
> >  hw/arm/virt.c              |  9 ++++++++-
> >  hw/core/machine.c          |  4 ++++
> >  hw/i386/pc.c               |  4 ++++
> >  hw/i386/pc_piix.c          | 14 +++++++++++++-
> >  hw/i386/pc_q35.c           | 13 ++++++++++++-
> >  hw/ppc/spapr.c             | 15 +++++++++++++--
> >  hw/s390x/s390-virtio-ccw.c | 14 +++++++++++++-
> >  9 files changed, 73 insertions(+), 6 deletions(-)
>=20
> https://lore.kernel.org/qemu-devel/20200728094645.272149-1-cohuck@redhat.=
com/
> is already out there :)

You're too quick! :)

Next time I'll write a script and monitor qemu.git for the release tag
so I can be first!!!!!!111

Stefan

--SO98HVl1bnMOfKZd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAl89M2sACgkQnKSrs4Gr
c8jppwgAl+5lv2GTdnNasXQm/Mwg3LDGc0ThGWVYpdxH/8HHIafE/MGYWrmVBVWf
x00wciEKslllyyMDV6seS51COXOFNufyhnzgQEfuWqJ2tH4/DUxvPVYHX2iMcg4U
GhExWyu5fGzaqDZ24U5WHcIDHEQvUfhT0vJOH9Y1CVqrUE8+QoAXc/I3mOD4QjqB
ALG18Q0xCWln+IbMZpRF9O6fMeppfR1W3CM7qZC4URyfAqjdFXH/F84JbEC2NqRE
fV66u2pyO0+0Au9b3dvYDmUCg9KHbsE4O3UknznMHfudWKU5mOMrYzewtT8J6Uoc
uLtRy/KKJKEft3FP1VG1DZvck8AqXA==
=xCgX
-----END PGP SIGNATURE-----

--SO98HVl1bnMOfKZd--


