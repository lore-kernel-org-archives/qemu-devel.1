Return-Path: <SRS0=1Qun=7R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 366A5C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D3E2072E
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2020 06:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="bX1JNvJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D3E2072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgjD9-00076j-7W
	for qemu-devel@archiver.kernel.org; Thu, 04 Jun 2020 02:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7D-0000Uk-Bq; Thu, 04 Jun 2020 02:12:35 -0400
Received: from ozlabs.org ([203.11.71.1]:47527)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jgj7B-0002nW-8y; Thu, 04 Jun 2020 02:12:35 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49cwRc61BPz9sSn; Thu,  4 Jun 2020 16:12:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1591251148;
 bh=4mNWXeeVJLVrbIApFBHif9Uyd9pGvH80LiEsHxKqPgg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bX1JNvJIns8y/4pX9fXsAZ40jYzgTI7SVDtXXbtimebDad1WlJYbl6njjBNhZ0ckX
 tjPi2UTLbdkAvRqN2ACWNd+p1qYp3htSLaezhwFAM5ZyirzRhl9onHj+X2TuV3y9ho
 r00s8jeDFMO1RpzInRknVUurFfstf4QOpeCMHGvg=
Date: Thu, 4 Jun 2020 13:27:51 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Greg Kurz <groug@kaod.org>
Subject: Re: [RFC v2 11/18] guest memory protection: Handle memory encrption
 via interface
Message-ID: <20200604032751.GD228651@umbus.fritz.box>
References: <20200521034304.340040-1-david@gibson.dropbear.id.au>
 <20200521034304.340040-12-david@gibson.dropbear.id.au>
 <20200525122655.0488cc3d@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="5gxpn/Q6ypwruk0T"
Content-Disposition: inline
In-Reply-To: <20200525122655.0488cc3d@bahia.lan>
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/04 02:12:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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


--5gxpn/Q6ypwruk0T
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 25, 2020 at 12:26:55PM +0200, Greg Kurz wrote:
>=20
> s/encrption/encryption

Fixed.

> On Thu, 21 May 2020 13:42:57 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > At the moment AMD SEV sets a special function pointer, plus an opaque
> > handle in KVMState to let things know how to encrypt guest memory.
> >=20
> > Now that we have a QOM interface for handling things related to guest
> > memory protection, use a QOM method on that interface, rather than a ba=
re
> > function pointer for this.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> >  accel/kvm/kvm-all.c                    | 23 +++----
> >  accel/kvm/sev-stub.c                   |  5 --
> >  include/exec/guest-memory-protection.h |  2 +
> >  include/sysemu/sev.h                   |  6 +-
> >  target/i386/sev.c                      | 84 ++++++++++++++------------
> >  5 files changed, 63 insertions(+), 57 deletions(-)
> >=20
> > diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
> > index d06cc04079..40997de38c 100644
> > --- a/accel/kvm/kvm-all.c
> > +++ b/accel/kvm/kvm-all.c
> > @@ -45,6 +45,7 @@
> >  #include "qapi/qapi-types-common.h"
> >  #include "qapi/qapi-visit-common.h"
> >  #include "sysemu/reset.h"
> > +#include "exec/guest-memory-protection.h"
> > =20
> >  #include "hw/boards.h"
> > =20
> > @@ -119,8 +120,7 @@ struct KVMState
> >      QLIST_HEAD(, KVMParkedVcpu) kvm_parked_vcpus;
> > =20
> >      /* memory encryption */
> > -    void *memcrypt_handle;
> > -    int (*memcrypt_encrypt_data)(void *handle, uint8_t *ptr, uint64_t =
len);
> > +    GuestMemoryProtection *guest_memory_protection;
> > =20
> >      /* For "info mtree -f" to tell if an MR is registered in KVM */
> >      int nr_as;
> > @@ -172,7 +172,7 @@ int kvm_get_max_memslots(void)
> > =20
> >  bool kvm_memcrypt_enabled(void)
> >  {
> > -    if (kvm_state && kvm_state->memcrypt_handle) {
> > +    if (kvm_state && kvm_state->guest_memory_protection) {
> >          return true;
> >      }
> > =20
> > @@ -181,10 +181,13 @@ bool kvm_memcrypt_enabled(void)
> > =20
> >  int kvm_memcrypt_encrypt_data(uint8_t *ptr, uint64_t len)
> >  {
> > -    if (kvm_state->memcrypt_handle &&
> > -        kvm_state->memcrypt_encrypt_data) {
> > -        return kvm_state->memcrypt_encrypt_data(kvm_state->memcrypt_ha=
ndle,
> > -                                              ptr, len);
> > +    GuestMemoryProtection *gmpo =3D kvm_state->guest_memory_protection;
> > +
> > +    if (gmpo) {
> > +        GuestMemoryProtectionClass *gmpc =3D
> > +            GUEST_MEMORY_PROTECTION_GET_CLASS(gmpo);
> > +
> > +        return gmpc->encrypt_data(gmpo, ptr, len);
> >      }
> > =20
> >      return 1;
> > @@ -2101,13 +2104,11 @@ static int kvm_init(MachineState *ms)
> >       * encryption context.
> >       */
> >      if (ms->memory_encryption) {
> > -        kvm_state->memcrypt_handle =3D sev_guest_init(ms->memory_encry=
ption);
> > -        if (!kvm_state->memcrypt_handle) {
> > +        kvm_state->guest_memory_protection =3D sev_guest_init(ms->memo=
ry_encryption);
> > +        if (!kvm_state->guest_memory_protection) {
> >              ret =3D -1;
> >              goto err;
> >          }
> > -
> > -        kvm_state->memcrypt_encrypt_data =3D sev_encrypt_data;
> >      }
> > =20
> >      ret =3D kvm_arch_init(ms, s);
> > diff --git a/accel/kvm/sev-stub.c b/accel/kvm/sev-stub.c
> > index 4f97452585..4a5cc5569e 100644
> > --- a/accel/kvm/sev-stub.c
> > +++ b/accel/kvm/sev-stub.c
> > @@ -15,11 +15,6 @@
> >  #include "qemu-common.h"
> >  #include "sysemu/sev.h"
> > =20
> > -int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
> > -{
> > -    abort();
> > -}
> > -
> >  void *sev_guest_init(const char *id)
> >  {
> >      return NULL;
>=20
> This requires some extra care:
>=20
> accel/kvm/sev-stub.c:18:7: error: conflicting types for =E2=80=98sev_gues=
t_init=E2=80=99
>  void *sev_guest_init(const char *id)
>        ^~~~~~~~~~~~~~
> In file included from accel/kvm/sev-stub.c:16:0:
> include/sysemu/sev.h:21:24: note: previous declaration of =E2=80=98sev_gu=
est_init=E2=80=99 was here
>  GuestMemoryProtection *sev_guest_init(const char *id);
>                         ^~~~~~~~~~~~~~
> rules.mak:69: recipe for target 'accel/kvm/sev-stub.o' failed

Oops, that's embarrassing - I forgot to do a build on ppc.

Fixed now.

> > diff --git a/include/exec/guest-memory-protection.h b/include/exec/gues=
t-memory-protection.h
> > index 38e9b01667..eb712a5804 100644
> > --- a/include/exec/guest-memory-protection.h
> > +++ b/include/exec/guest-memory-protection.h
> > @@ -30,6 +30,8 @@ typedef struct GuestMemoryProtection GuestMemoryProte=
ction;
> > =20
> >  typedef struct GuestMemoryProtectionClass {
> >      InterfaceClass parent;
> > +
> > +    int (*encrypt_data)(GuestMemoryProtection *, uint8_t *, uint64_t);
> >  } GuestMemoryProtectionClass;
> > =20
> >  #endif /* QEMU_GUEST_MEMORY_PROTECTION_H */
> > diff --git a/include/sysemu/sev.h b/include/sysemu/sev.h
> > index 98c1ec8d38..7735a7942e 100644
> > --- a/include/sysemu/sev.h
> > +++ b/include/sysemu/sev.h
> > @@ -16,6 +16,8 @@
> > =20
> >  #include "sysemu/kvm.h"
> > =20
> > -void *sev_guest_init(const char *id);
> > -int sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len);
> > +typedef struct GuestMemoryProtection GuestMemoryProtection;
> > +
> > +GuestMemoryProtection *sev_guest_init(const char *id);
> > +
> >  #endif
> > diff --git a/target/i386/sev.c b/target/i386/sev.c
> > index d273174ad3..986c2fee51 100644
> > --- a/target/i386/sev.c
> > +++ b/target/i386/sev.c
> > @@ -28,6 +28,7 @@
> >  #include "sysemu/runstate.h"
> >  #include "trace.h"
> >  #include "migration/blocker.h"
> > +#include "exec/guest-memory-protection.h"
> > =20
> >  #define TYPE_SEV_GUEST "sev-guest"
> >  #define SEV_GUEST(obj)                                          \
> > @@ -281,26 +282,6 @@ sev_guest_set_sev_device(Object *obj, const char *=
value, Error **errp)
> >      sev->sev_device =3D g_strdup(value);
> >  }
> > =20
> > -static void
> > -sev_guest_class_init(ObjectClass *oc, void *data)
> > -{
> > -    object_class_property_add_str(oc, "sev-device",
> > -                                  sev_guest_get_sev_device,
> > -                                  sev_guest_set_sev_device);
> > -    object_class_property_set_description(oc, "sev-device",
> > -            "SEV device to use");
> > -    object_class_property_add_str(oc, "dh-cert-file",
> > -                                  sev_guest_get_dh_cert_file,
> > -                                  sev_guest_set_dh_cert_file);
> > -    object_class_property_set_description(oc, "dh-cert-file",
> > -            "guest owners DH certificate (encoded with base64)");
> > -    object_class_property_add_str(oc, "session-file",
> > -                                  sev_guest_get_session_file,
> > -                                  sev_guest_set_session_file);
> > -    object_class_property_set_description(oc, "session-file",
> > -            "guest owners session parameters (encoded with base64)");
> > -}
> > -
> >  static void
> >  sev_guest_instance_init(Object *obj)
> >  {
> > @@ -319,20 +300,6 @@ sev_guest_instance_init(Object *obj)
> >                                     OBJ_PROP_FLAG_READWRITE);
> >  }
> > =20
> > -/* sev guest info */
> > -static const TypeInfo sev_guest_info =3D {
> > -    .parent =3D TYPE_OBJECT,
> > -    .name =3D TYPE_SEV_GUEST,
> > -    .instance_size =3D sizeof(SevGuestState),
> > -    .instance_finalize =3D sev_guest_finalize,
> > -    .class_init =3D sev_guest_class_init,
> > -    .instance_init =3D sev_guest_instance_init,
> > -    .interfaces =3D (InterfaceInfo[]) {
> > -        { TYPE_USER_CREATABLE },
> > -        { }
> > -    }
> > -};
> > -
> >  static SevGuestState *
> >  lookup_sev_guest_info(const char *id)
> >  {
> > @@ -670,7 +637,7 @@ sev_vm_state_change(void *opaque, int running, RunS=
tate state)
> >      }
> >  }
> > =20
> > -void *
> > +GuestMemoryProtection *
> >  sev_guest_init(const char *id)
> >  {
> >      SevGuestState *sev;
> > @@ -748,16 +715,16 @@ sev_guest_init(const char *id)
> >      qemu_add_machine_init_done_notifier(&sev_machine_done_notify);
> >      qemu_add_vm_change_state_handler(sev_vm_state_change, sev);
> > =20
> > -    return sev;
> > +    return GUEST_MEMORY_PROTECTION(sev);
> >  err:
> >      sev_guest =3D NULL;
> >      return NULL;
> >  }
> > =20
> > -int
> > -sev_encrypt_data(void *handle, uint8_t *ptr, uint64_t len)
> > +static int
> > +sev_encrypt_data(GuestMemoryProtection *opaque, uint8_t *ptr, uint64_t=
 len)
> >  {
> > -    SevGuestState *sev =3D handle;
> > +    SevGuestState *sev =3D SEV_GUEST(opaque);
> > =20
> >      assert(sev);
> > =20
> > @@ -769,6 +736,45 @@ sev_encrypt_data(void *handle, uint8_t *ptr, uint6=
4_t len)
> >      return 0;
> >  }
> > =20
> > +static void
> > +sev_guest_class_init(ObjectClass *oc, void *data)
> > +{
> > +    GuestMemoryProtectionClass *gmpc =3D GUEST_MEMORY_PROTECTION_CLASS=
(oc);
> > +
> > +    object_class_property_add_str(oc, "sev-device",
> > +                                  sev_guest_get_sev_device,
> > +                                  sev_guest_set_sev_device);
> > +    object_class_property_set_description(oc, "sev-device",
> > +        "SEV device to use");
> > +    object_class_property_add_str(oc, "dh-cert-file",
> > +                                  sev_guest_get_dh_cert_file,
> > +                                  sev_guest_set_dh_cert_file);
> > +    object_class_property_set_description(oc, "dh-cert-file",
> > +        "guest owners DH certificate (encoded with base64)");
> > +    object_class_property_add_str(oc, "session-file",
> > +                                  sev_guest_get_session_file,
> > +                                  sev_guest_set_session_file);
> > +    object_class_property_set_description(oc, "session-file",
> > +        "guest owners session parameters (encoded with base64)");
> > +
> > +    gmpc->encrypt_data =3D sev_encrypt_data;
> > +}
> > +
> > +/* sev guest info */
> > +static const TypeInfo sev_guest_info =3D {
> > +    .parent =3D TYPE_OBJECT,
> > +    .name =3D TYPE_SEV_GUEST,
> > +    .instance_size =3D sizeof(SevGuestState),
> > +    .instance_finalize =3D sev_guest_finalize,
> > +    .class_init =3D sev_guest_class_init,
> > +    .instance_init =3D sev_guest_instance_init,
> > +    .interfaces =3D (InterfaceInfo[]) {
> > +        { TYPE_GUEST_MEMORY_PROTECTION },
> > +        { TYPE_USER_CREATABLE },
> > +        { }
> > +    }
> > +};
> > +
> >  static void
> >  sev_register_types(void)
> >  {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5gxpn/Q6ypwruk0T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAl7YajQACgkQbDjKyiDZ
s5LcVxAA3Fgzwvs7wQwUbjt6B+5U8qYfHBnYRsADRO/UVuOTJA/1pfPww4uElLIh
nL2u3R7+lQ9i4K4zHc5IgMYZQgIZOPhvTd59DiW9uKq/OuTRXqEgi4u3s5dy741g
BYGZaB7uVjA254RAEi1DJ1dXRpaZQZ4NFhySO0oq50WannYEKKR0NPIWgktexoCG
3r7AGy9t1dClE1iEpFJCmw8ziu8ZIWLNzQBLK9dDi2tAnycqYnjIn+cG8seBeSXn
U4exIFpYq4MbLPN/QbulFzZkUyZcN/t6U4zrEvjJ6JmZmqRuDJbmioWN3wr6evui
DxRbTyUxAawyaiv0t7/mI5XdKncZ1FwKq+gwlAm9aa4RFMU0XyX6N0nhdGt66HYe
KW6c70+ySDkYyokX9mGxl0+3gLE5RfjCWHyTzEzU/t0EeRoF5qcKNFIK0iaTvd/d
Lr2dJHAMGBLXLKssp7+yTPjPxXJj6VKLqp0yrd2tCMK6t9KwsqLTlKAQsAU49Bdo
SUDUrAVGl6bMAfuk6PAGw/WZvYHlhgOlXGt3pPh2o1SAUy9CXme9tlByVqIR6u4R
Ci+M1SF4iVemcV7BPqDNtGN4SAJVE1AAJ9X8jOxGGbPlqcO+oUWpn86QzB3vYtB7
FpW4Fj5Zj11ijUGr8FtL8lRwfISwwe599BmHW22rjO8eG3nhtJo=
=6yZ0
-----END PGP SIGNATURE-----

--5gxpn/Q6ypwruk0T--

