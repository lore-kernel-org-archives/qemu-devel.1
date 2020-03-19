Return-Path: <SRS0=/hVT=5E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EE96C4332D
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:01:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4916B2070A
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2020 10:01:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ScAELSDh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4916B2070A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jErzI-00082C-Fl
	for qemu-devel@archiver.kernel.org; Thu, 19 Mar 2020 06:01:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50408)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <cohuck@redhat.com>) id 1jEry3-0006nO-Dq
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 06:00:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <cohuck@redhat.com>) id 1jEry2-0007RH-BZ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:59:59 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44795)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1jEry2-0007R5-8f
 for qemu-devel@nongnu.org; Thu, 19 Mar 2020 05:59:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584611998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1LDz5qktvaihEBgJ1F8iIql4C0wEg8cO879LooSKwn0=;
 b=ScAELSDhAZ4DxkZhnPzwmB/9PvYCAchGDL6RSaObqKTie9gHLDIm63WXgMT2vgYkrWED47
 7lQD9j0NyPw4mHeAIEpdrIBfN6VEuo5K0dINjWYSmVjBWzBV2EDiO3DaLKhsB+rWQnzpcP
 I6kJWjMjO/LCedM9cV5YKYqsa5tpO8A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-G_eOJcmKN3ad4LNkg-criw-1; Thu, 19 Mar 2020 05:59:51 -0400
X-MC-Unique: G_eOJcmKN3ad4LNkg-criw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2ACAD18FE860;
 Thu, 19 Mar 2020 09:59:50 +0000 (UTC)
Received: from gondolin (ovpn-113-188.ams2.redhat.com [10.36.113.188])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F15373865;
 Thu, 19 Mar 2020 09:59:43 +0000 (UTC)
Date: Thu, 19 Mar 2020 10:59:19 +0100
From: Cornelia Huck <cohuck@redhat.com>
To: Janosch Frank <frankja@linux.ibm.com>
Subject: Re: [PATCH v10 15/16] docs: system: Add protvirt docs
Message-ID: <20200319105919.34829695.cohuck@redhat.com>
In-Reply-To: <158d3b95-dca6-4dd7-0171-eb208664510e@linux.ibm.com>
References: <20200318143047.2335-1-frankja@linux.ibm.com>
 <20200318143047.2335-16-frankja@linux.ibm.com>
 <20200318155318.0c80acd2.cohuck@redhat.com>
 <158d3b95-dca6-4dd7-0171-eb208664510e@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; boundary="Sig_/rX6q51jAf9aTFU1Taq2ISvD";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
 david@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--Sig_/rX6q51jAf9aTFU1Taq2ISvD
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Mar 2020 10:04:38 +0100
Janosch Frank <frankja@linux.ibm.com> wrote:

> On 3/18/20 3:53 PM, Cornelia Huck wrote:
> > On Wed, 18 Mar 2020 10:30:46 -0400
> > Janosch Frank <frankja@linux.ibm.com> wrote:
> >  =20
> >> Let's add some documentation for the Protected VM functionality.
> >>
> >> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> >> Acked-by: David Hildenbrand <david@redhat.com>
> >> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> >> ---
> >>  docs/system/s390x/protvirt.rst | 59 +++++++++++++++++++++++++++++++++=
+
> >>  docs/system/target-s390x.rst   |  5 +++
> >>  2 files changed, 64 insertions(+)
> >>  create mode 100644 docs/system/s390x/protvirt.rst =20
> >=20
> > (...)
> >  =20
> >> +Booting from the image supplied on the QEMU command line requires tha=
t
> >> +the file passed via -kernel has the same memory layout as would resul=
t
> >> +from the disk boot. This memory layout includes the encrypted
> >> +components (kernel, initrd, cmdline), the stage3a loader and
> >> +metadata. In case this boot method is used, the command line
> >> +options -initrd and -cmdline are ineffective. The preparation of a PV=
M
> >> +image is done via the `genprotimg` tool from the s390-tools package. =
=20
> >=20
> > I still think 'package' is not a good name (yes, I realize that
> > s390-tools' README uses that term as well :) I'd prefer 'collection' or
> > something like that, so it doesn't get confused with distro packages,
> > which may use a different name. But no strong opinion. =20
>=20
> collection it is
>=20
> >  =20
> >> diff --git a/docs/system/target-s390x.rst b/docs/system/target-s390x.r=
st
> >> index 4c8b7cdd66154d26..8d97158dc804af1c 100644
> >> --- a/docs/system/target-s390x.rst
> >> +++ b/docs/system/target-s390x.rst
> >> @@ -24,3 +24,8 @@ or vfio-ap is also available.
> >>  .. toctree::
> >>     s390x/vfio-ap
> >> =20
> >> +Architectural features
> >> +~~~~~~~~ =20
> >=20
> > Architecture features
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >=20
> > ? =20
>=20
> Ack
>=20
> >  =20
> >> +
> >> +.. toctree::
> >> +   s390x/protvirt =20
> >=20
> > Otherwise, looks good to me.
> >=20
> >  =20
>=20
>=20

With those changes,
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

--Sig_/rX6q51jAf9aTFU1Taq2ISvD
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEw9DWbcNiT/aowBjO3s9rk8bwL68FAl5zQncACgkQ3s9rk8bw
L6+DXg//X8SYhaXkYr9m7YgOCRcp2H+eYSEdelCHL/vXrGdNTOTlhU+OrD1rxf6W
jQXBxVezwNIW05MJnUPyoZJ3wS/BlPmima+q5Kb65GVoy/AgULI190mVzpsvB7Km
BbEXgoF8HZUILSzz6XnV52dooPDnIA1515bfrbFsYoNHNSvtsPAeHWe6HgLBsNRG
yS5ykPVDgVm32uTCzTx43RTqdektBwOYU4mjeNUTY62M7UtTzVbuOg+yeSX4RKKW
7ct1qbYLFt46nzILl3l7mt3B8q4ypInwXP1c+UcW4NstDpo6KsLx7gSMicSrc9ju
TIu8E7qq3Fwicwt3X/GXF+8w4H3gEwee2iIZnF0M/g1z86N/PLZdpNj5PE/j4ATT
7fZovI5p/9t5+h4kkK7yIw791+/6K+0cDweHxiX1SoXiYE0M5asC2C0gmmFlvW06
uR2MQdClj+GFzSla/QUe1X5lMUNPixZv+6DH25EsyBeuiK8TgT5fd3tEeMH5wpjJ
Q8vw/6GEc485WG158S0oIK9sk/MALyKHFX8xWueEvAhLoPD6YtGymPanvkUKRHeE
+UBzZo5y8auJqunQALx6c68Ei8dOhHrlf8+IUhIbHkVohjsMS2muBo3tPzKKPJDz
EtlUVHDHqQXRUG2GdtqKyQtkFQ79/yCyNOI786siSEoiIsWQxI0=
=s6TV
-----END PGP SIGNATURE-----

--Sig_/rX6q51jAf9aTFU1Taq2ISvD--


