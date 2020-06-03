Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D80C433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41F820772
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 12:09:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="W4s6JcXc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F41F820772
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgSCj-0008O4-7q
	for qemu-devel@archiver.kernel.org; Wed, 03 Jun 2020 08:09:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43704)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgSBe-0006oD-5f; Wed, 03 Jun 2020 08:08:02 -0400
Received: from bilbo.ozlabs.org ([2401:3900:2:1::2]:43381 helo=ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgSBb-0007yu-QW; Wed, 03 Jun 2020 08:08:01 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cSN426Smz9sSc; Wed,  3 Jun 2020 22:07:48 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591186068;
 bh=/8OHMiJYf9fsWc/S8JvslYN4IuSO+nUpOmIPBciWWek=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W4s6JcXcU7N66PtMVZVa79cn/fiI8+C+Sgd1/1mTXtHUBUDyWnWGeyHyhcol86/1w
 xk50FEpRc77mxtIpTFfBKD2GmM/6G+z5VHq0d8VqroZwlTZZTYyFlnpcweHdOgCGCF
 UYqzp8kUX+OY7xqhRhwckvcGqadancJGeyTbgnCQ=
Date: Wed, 3 Jun 2020 20:09:10 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC v2 10/18] guest memory protection: Add guest memory
 protection interface
Message-ID: <20200603100910.GA11091@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-11-david@gibson.dropbear.id.au>
 <20200525122735.1d4a45c7@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20200525122735.1d4a45c7@bahia.lan>
Received-SPF: pass client-ip=2401:3900:2:1::2; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: pair@us.ibm.com, brijesh.singh@amd.com,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 qemu-devel@nongnu.org, dgilbert@redhat.com, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 mdroth@linux.vnet.ibm.com, frankja@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 12:27:35PM +0200, Greg Kurz wrote:
> On Thu, 21 May 2020 13:42:56 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Several architectures have mechanisms which are designed to protect gue=
st
> > memory from interference or eavesdropping by a compromised hypervisor. =
 AMD
> > SEV does this with in-chip memory encryption and Intel has a similar
> > mechanism.  POWER's Protected Execution Framework (PEF) accomplishes a
> > similar goal using an ultravisor and new memory protection features,
> > instead of encryption.
> >=20
> > This introduces a new GuestMemoryProtection QOM interface which we'll u=
se
> > to (partially) unify handling of these various mechanisms.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  backends/Makefile.objs                 |  2 ++
> >  backends/guest-memory-protection.c     | 29 +++++++++++++++++++++
> >  include/exec/guest-memory-protection.h | 36 ++++++++++++++++++++++++++
> >  3 files changed, 67 insertions(+)
> >  create mode 100644 backends/guest-memory-protection.c
> >  create mode 100644 include/exec/guest-memory-protection.h
> >=20
> > diff --git a/backends/Makefile.objs b/backends/Makefile.objs
> > index 28a847cd57..e4fb4f5280 100644
> > --- a/backends/Makefile.objs
> > +++ b/backends/Makefile.objs
> > @@ -21,3 +21,5 @@ common-obj-$(CONFIG_LINUX) +=3D hostmem-memfd.o
> >  common-obj-$(CONFIG_GIO) +=3D dbus-vmstate.o
> >  dbus-vmstate.o-cflags =3D $(GIO_CFLAGS)
> >  dbus-vmstate.o-libs =3D $(GIO_LIBS)
> > +
> > +common-obj-y +=3D guest-memory-protection.o
> > diff --git a/backends/guest-memory-protection.c b/backends/guest-memory=
-protection.c
> > new file mode 100644
> > index 0000000000..7e538214f7
> > --- /dev/null
> > +++ b/backends/guest-memory-protection.c
> > @@ -0,0 +1,29 @@
> > +#/*
> > + * QEMU Guest Memory Protection interface
> > + *
> > + * Copyright: David Gibson, Red Hat Inc. 2020
> > + *
> > + * Authors:
> > + *  David Gibson <david@gibson.dropbear.id.au>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * later.  See the COPYING file in the top-level directory.
> > + *
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +
> > +#include "exec/guest-memory-protection.h"
> > +
> > +static const TypeInfo guest_memory_protection_info =3D {
> > +    .name =3D TYPE_GUEST_MEMORY_PROTECTION,
> > +    .parent =3D TYPE_INTERFACE,
> > +    .class_size =3D sizeof(GuestMemoryProtectionClass),
> > +};
> > +
> > +static void guest_memory_protection_register_types(void)
> > +{
> > +    type_register_static(&guest_memory_protection_info);
> > +}
> > +
> > +type_init(guest_memory_protection_register_types)
> > diff --git a/include/exec/guest-memory-protection.h b/include/exec/gues=
t-memory-protection.h
> > new file mode 100644
> > index 0000000000..38e9b01667
> > --- /dev/null
> > +++ b/include/exec/guest-memory-protection.h
> > @@ -0,0 +1,36 @@
> > +#/*
> > + * QEMU Guest Memory Protection interface
> > + *
> > + * Copyright: David Gibson, Red Hat Inc. 2020
> > + *
> > + * Authors:
> > + *  David Gibson <david@gibson.dropbear.id.au>
> > + *
> > + * This work is licensed under the terms of the GNU GPL, version 2 or
> > + * later.  See the COPYING file in the top-level directory.
> > + *
> > + */
> > +#ifndef QEMU_GUEST_MEMORY_PROTECTION_H
> > +#define QEMU_GUEST_MEMORY_PROTECTION_H
> > +
> > +#include "qom/object.h"
> > +
> > +typedef struct GuestMemoryProtection GuestMemoryProtection;
> > +
> > +#define TYPE_GUEST_MEMORY_PROTECTION "guest-memory-protection"
> > +#define GUEST_MEMORY_PROTECTION(obj)                                  =
  \
> > +    INTERFACE_CHECK(GuestMemoryProtection, (obj),                     =
  \
> > +                    TYPE_GUEST_MEMORY_PROTECTION)
> > +#define GUEST_MEMORY_PROTECTION_CLASS(klass)                          =
  \
> > +    OBJECT_CLASS_CHECK(GuestMemoryProtectionClass, (klass),           =
  \
> > +                       TYPE_GUEST_MEMORY_PROTECTION)
> > +#define GUEST_MEMORY_PROTECTION_GET_CLASS(obj)                        =
  \
> > +    OBJECT_GET_CLASS(GuestMemoryProtectionClass, (obj),               =
  \
> > +                     TYPE_GUEST_MEMORY_PROTECTION)
> > +
> > +typedef struct GuestMemoryProtectionClass {
> > +    InterfaceClass parent;
> > +} GuestMemoryProtectionClass;
> > +
> > +#endif /* QEMU_GUEST_MEMORY_PROTECTION_H */
> > +
>=20
> Applying patch #1294935 using "git am -s -m"
> Description: [RFC,v2,10/18] guest memory protection: Add guest memory pro=
tection
> Applying: guest memory protection: Add guest memory protection interface
> .git/rebase-apply/patch:95: new blank line at EOF.
> +
> warning: 1 line adds whitespace errors.

Oops, fixed.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7XdsMACgkQbDjKyiDZ
s5K/hBAA1/nV1iP+BSJxo3zR4Q52aEImFYxuD6PEoIQ0BQczE0qNK6HW2Uqe4w0H
PclvgiMHwprTIIiQVQo4vu98mQvhpHTnYVZbjH0ww+oIBponyDA/aHBSNsKvNF76
ovkfC/nZ11GvHUA1FQzEKvnn4qiU2qv0N6aoKetxHmSUMSCUYomxdGKJOIVxa754
TMJvR0DuxcmEnY5/1bXah0QN9c4luvP3k7HVOJq5xSvz/4pK47znpvVaT9ZtX+h0
2Dq4vUWLlCgBKzOD859xLAdA8BdR0Ju8xpRmfdtkJSVQyb1rPprNRQWhi1YKO6SP
4uRwgRmlynNpVj3/MoWnBYFrXRKTYuAboPZZPf2mCTuErLEv6M4b20ZNvtAt93u+
4AFKYOweqivywCFdu6aDszC3ja2lwMxxlcc1TBYX/OVzjpPlzghpEEv4h79tgC6o
cIqde6lNeUxZ1VPScsW7fHsopIOW6ZLZs1vcg2raqqC76zmSek/JltMOmRUabUAj
7lUjIEgn9EGJZ3kc8KEXPl89H1rjmd4P4EmEkfNfasorEz7HCe6KtoSRCLBSblUx
iZ30ECn3MMF+Ptu9j9xWr53+Du4ldLOsWQYQjd7e318rhp7XfGFHerLEQachMhoH
ObHRq66/cP1XsRRcOEPYRxHZ+sFZJoJWDyCilG99tbokuT+OZtM=
=6G9C
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--

