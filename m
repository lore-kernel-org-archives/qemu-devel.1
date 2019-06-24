Return-Path: <SRS0=7PyC=UX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9702C4646B
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 657CF205C9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Jun 2019 14:59:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 657CF205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52030 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfQRX-0005E6-Cx
	for qemu-devel@archiver.kernel.org; Mon, 24 Jun 2019 10:59:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33908)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <lersek@redhat.com>) id 1hfQM1-0000R9-Ud
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1hfQLz-0007jZ-Lq
 for qemu-devel@nongnu.org; Mon, 24 Jun 2019 10:53:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48016)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>)
 id 1hfQLr-0006we-2w; Mon, 24 Jun 2019 10:53:47 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 23256309265C;
 Mon, 24 Jun 2019 14:53:19 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-226.ams2.redhat.com
 [10.36.116.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55BCB600CD;
 Mon, 24 Jun 2019 14:53:12 +0000 (UTC)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190620122132.10075-1-philmd@redhat.com>
 <20190620122132.10075-2-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <6a0086e7-79ea-fc5e-6359-c1d4d256bf6e@redhat.com>
Date: Mon, 24 Jun 2019 16:53:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190620122132.10075-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Mon, 24 Jun 2019 14:53:19 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 1/3] hw/firmware: Add Edk2Crypto and
 edk2_add_host_crypto_policy()
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-arm@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(+Daniel)

On 06/20/19 14:21, Philippe Mathieu-Daud=C3=A9 wrote:
> The Edk2Crypto object is used to hold configuration values specific
> to EDK2.
>=20
> The edk2_add_host_crypto_policy() function loads crypto policies
> from the host, and register them as fw_cfg named file items.
> So far only the 'https' policy is supported.
>=20
> A usercase example is the 'HTTPS Boof' feature of OVMF [*].

(1) s/usercase/use case/, s/Boof/Boot/

>=20
> Usage example:
>=20
> - via the command line:
>=20
>   $ qemu-system-x86_64 \
>       --object edk2_crypto,id=3Dhttps,\
>               ciphers=3D/etc/crypto-policies/back-ends/openssl.config,\
>               cacerts=3D/etc/pki/ca-trust/extracted/edk2/cacerts.bin
>=20
> - via QMP:
>=20
>   {
>     "execute": "object-add",
>     "arguments": {
>       "qom-type": "edk2_crypto",
>       "id": "https",
>       "props": {
>         "ciphers": "/etc/crypto-policies/back-ends/openssl.config",
>         "cacerts": "/etc/pki/ca-trust/extracted/edk2/cacerts.bin"
>       }
>     }
>   }
>=20
> (On Fedora these files are provided by the ca-certificates and
> crypto-policies packages).
>=20
> [*]: https://github.com/tianocore/edk2/blob/master/OvmfPkg/README
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v3:
> - inverted the if() logic
> - '-object' -> '--object' in commit description (Eric)
> - reworded the 'TODO: g_free' comment
> v4:
> - do not return pointer to alloc'd data (Markus)
> - INTERFACE_CHECK -> OBJECT_CLASS_CHECK (Markus)
> - path -> filename (Laszlo)
> - dropped the 'TODO: g_free' comment (Markus)
> v5:
> - only allow 1 singleton using the UserCreatableClass::complete
>   callback (Markus, Laszlo)
> - object own fw_cfg 'file' content, no need for
>   fw_cfg_add_file_from_host() (Laszlo)
> - g_file_get_contents() called when object is instantiated
>   and report error, the machine 'done' notifier do not have
>   to manage errors (do not fail).
> - add QMP example
> -
> - do not add docs/interop/firmware.json to MAINTAINERS
> ---
>  MAINTAINERS                             |   2 +
>  hw/Makefile.objs                        |   1 +
>  hw/firmware/Makefile.objs               |   1 +
>  hw/firmware/uefi_edk2_crypto_policies.c | 209 ++++++++++++++++++++++++
>  include/hw/firmware/uefi_edk2.h         |  30 ++++
>  5 files changed, 243 insertions(+)
>  create mode 100644 hw/firmware/Makefile.objs
>  create mode 100644 hw/firmware/uefi_edk2_crypto_policies.c
>  create mode 100644 include/hw/firmware/uefi_edk2.h
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d32c5c2313..28de489134 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2262,6 +2262,8 @@ EDK2 Firmware
>  M: Laszlo Ersek <lersek@redhat.com>
>  M: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
>  S: Supported
> +F: hw/firmware/uefi_edk2_crypto_policies.c
> +F: include/hw/firmware/uefi_edk2.h
>  F: pc-bios/descriptors/??-edk2-*.json
>  F: pc-bios/edk2-*
>  F: roms/Makefile.edk2
> diff --git a/hw/Makefile.objs b/hw/Makefile.objs
> index d770926ba9..c13b6ee0dd 100644
> --- a/hw/Makefile.objs
> +++ b/hw/Makefile.objs
> @@ -8,6 +8,7 @@ devices-dirs-$(CONFIG_SOFTMMU) +=3D char/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D cpu/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D display/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D dma/
> +devices-dirs-$(CONFIG_SOFTMMU) +=3D firmware/
>  devices-dirs-$(CONFIG_SOFTMMU) +=3D gpio/
>  devices-dirs-$(CONFIG_HYPERV) +=3D hyperv/
>  devices-dirs-$(CONFIG_I2C) +=3D i2c/

(1) I wonder if this granularity is the right one. Do we really want to
link this code into all softmmu targets, even if they (a) don't support
fw_cfg, (b) and/or have no bindings (per spec) for UEFI?

I can't recommend anything better (i.e. I can't really be "constructive"
here), but the above seems a bit to broad. In practice anyway, we only
need this for the i386, x86_64, arm, and aarch64 softmmu targets (for
now anyway).

FWIW, the vmgenid device, which we tend to use as an example here (for
some aspects anyway), seems to have its own knob: CONFIG_ACPI_VMGENID.


> diff --git a/hw/firmware/Makefile.objs b/hw/firmware/Makefile.objs
> new file mode 100644
> index 0000000000..ea1f6d44df
> --- /dev/null
> +++ b/hw/firmware/Makefile.objs
> @@ -0,0 +1 @@
> +common-obj-y +=3D uefi_edk2_crypto_policies.o
> diff --git a/hw/firmware/uefi_edk2_crypto_policies.c b/hw/firmware/uefi=
_edk2_crypto_policies.c
> new file mode 100644
> index 0000000000..a0164272ea
> --- /dev/null
> +++ b/hw/firmware/uefi_edk2_crypto_policies.c
> @@ -0,0 +1,209 @@
> +/*
> + * UEFI EDK2 Support
> + *
> + * Copyright (c) 2019 Red Hat Inc.
> + *
> + * Author:
> + *  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qom/object_interfaces.h"
> +#include "hw/firmware/uefi_edk2.h"
> +
> +
> +#define TYPE_EDK2_CRYPTO "edk2_crypto"
> +
> +#define EDK2_CRYPTO_CLASS(klass) \
> +     OBJECT_CLASS_CHECK(Edk2CryptoClass, (klass), \
> +                        TYPE_EDK2_CRYPTO)
> +#define EDK2_CRYPTO_GET_CLASS(obj) \
> +     OBJECT_GET_CLASS(Edk2CryptoClass, (obj), \
> +                      TYPE_EDK2_CRYPTO)
> +#define EDK2_CRYPTO(obj) \
> +     OBJECT_CHECK(Edk2Crypto, (obj), \
> +                  TYPE_EDK2_CRYPTO)
> +
> +typedef struct FWCfgHostContent {
> +    /*
> +     * Path to the acceptable ciphersuites and the preferred order fro=
m
> +     * the host-side crypto policy.
> +     */
> +    char *filename;

(2) The leading comment on this member is too specific. It is correct
for the "Edk2Crypto.ciphers" member (below) only.

How about simply stating: "load @contents from the host-side file
identified by @filename".

> +    /*
> +     * Add a new NAMED fw_cfg item as a raw "blob" of the given size. =
The data
> +     * referenced by the starting pointer is only linked, NOT copied, =
into the
> +     * data structure of the fw_cfg device.
> +     */
> +    char *contents;
> +
> +    size_t contents_length;
> +} FWCfgHostContent;
> +
> +typedef struct Edk2Crypto {
> +    Object parent_obj;
> +
> +    /*
> +     * Path to the acceptable ciphersuites and the preferred order fro=
m
> +     * the host-side crypto policy.
> +     */
> +    FWCfgHostContent ciphers;
> +    /* Path to the trusted CA certificates configured on the host side=
. */
> +    FWCfgHostContent cacerts;
> +} Edk2Crypto;

(3) This looks good to me, but I'd like to request some more documentatio=
n.

The commit message already references
<https://github.com/tianocore/edk2/blob/master/OvmfPkg/README>, and
that's good. However:

(3a) I'd like to see that OvmfPkg/README reference either moved here, or
duplicated here (right after "parent_obj")

(3b) just above "ciphers', please reference (in addition to the current
comment):

  https://gitlab.com/redhat-crypto/fedora-crypto-policies/issues/12

(3c) just above "cacerts", please reference (in addition to the current
comment):

  p11-kit commit ee27f9153a14 (trust: implement the "edk2-cacerts"
extractor)

> +
> +typedef struct Edk2CryptoClass {
> +    ObjectClass parent_class;
> +} Edk2CryptoClass;
> +
> +static Edk2Crypto *edk2_crypto_by_policy_id(const char *policy_id, Err=
or **errp)
> +{
> +    Object *obj;
> +
> +    obj =3D object_resolve_path_component(object_get_objects_root(), p=
olicy_id);
> +    if (!obj) {
> +        error_setg(errp, "Cannot find EDK2 crypto policy ID %s", polic=
y_id);
> +        return NULL;
> +    }
> +
> +    if (!object_dynamic_cast(obj, TYPE_EDK2_CRYPTO)) {
> +        error_setg(errp, "Object '%s' is not a EDK2 crypto subclass",
> +                         policy_id);

(4) The indentation looks off.

> +        return NULL;
> +    }
> +
> +    return EDK2_CRYPTO(obj);
> +}
> +
> +static void edk2_crypto_prop_set_ciphers(Object *obj, const char *valu=
e,
> +                                         Error **errp G_GNUC_UNUSED)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
> +
> +    g_free(s->ciphers.filename);
> +    s->ciphers.filename =3D g_strdup(value);
> +}
> +
> +static char *edk2_crypto_prop_get_ciphers(Object *obj,
> +                                          Error **errp G_GNUC_UNUSED)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
> +
> +    return g_strdup(s->ciphers.filename);
> +}
> +
> +static void edk2_crypto_prop_set_cacerts(Object *obj, const char *valu=
e,
> +                                         Error **errp G_GNUC_UNUSED)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
> +
> +    g_free(s->cacerts.filename);
> +    s->cacerts.filename =3D g_strdup(value);
> +}
> +
> +static char *edk2_crypto_prop_get_cacerts(Object *obj,
> +                                          Error **errp G_GNUC_UNUSED)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
> +
> +    return g_strdup(s->cacerts.filename);
> +}
> +
> +static void edk2_crypto_complete(UserCreatable *uc, Error **errp)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(uc);
> +    Error *local_err =3D NULL;
> +    GError *gerr =3D NULL;
> +
> +    if (s->ciphers.filename) {
> +        if (!g_file_get_contents(s->ciphers.filename, &s->ciphers.cont=
ents,
> +                                 &s->ciphers.contents_length, &gerr)) =
{
> +            goto report_error;
> +        }
> +    }
> +    if (s->cacerts.filename) {
> +        if (!g_file_get_contents(s->cacerts.filename, &s->cacerts.cont=
ents,
> +                                 &s->cacerts.contents_length, &gerr)) =
{
> +            goto report_error;
> +        }
> +    }
> +    return;
> +
> + report_error:
> +    error_setg(&local_err, "%s", gerr->message);
> +    g_error_free(gerr);
> +    error_propagate_prepend(errp, local_err, "EDK2 crypto policy: ");
> +}

(5) Assuming we load the ciphers successfully, but fail to load the
cacerts, will this not leak the former?

(Well I see that the finalize method releases everything that's not
NULL, yet it feels strange to leave this function with a
half-constructed object, where "ciphers.filename" is not in sync with
"ciphers.contents".)


(6) The error_propagate_prepend() function must have been added since I
last looked :) , and the docs seem clear on it in "include/qapi/error.h".

Given that we construct the QAPI error here in the first place, can we
simplify the code as follows?

  error_setg(errp, "EDK2 crypto policy: %s", gerr->message);
  g_error_free(gerr);


> +
> +static void edk2_crypto_finalize(Object *obj)
> +{
> +    Edk2Crypto *s =3D EDK2_CRYPTO(obj);
> +
> +    g_free(s->ciphers.filename);
> +    g_free(s->ciphers.contents);
> +    g_free(s->cacerts.filename);
> +    g_free(s->cacerts.contents);
> +}
> +
> +static void edk2_crypto_class_init(ObjectClass *oc, void *data)
> +{
> +    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
> +
> +    ucc->complete =3D edk2_crypto_complete;
> +
> +    object_class_property_add_str(oc, "ciphers",
> +                                  edk2_crypto_prop_get_ciphers,
> +                                  edk2_crypto_prop_set_ciphers,
> +                                  NULL);
> +    object_class_property_add_str(oc, "cacerts",
> +                                  edk2_crypto_prop_get_cacerts,
> +                                  edk2_crypto_prop_set_cacerts,
> +                                  NULL);
> +}
> +
> +static const TypeInfo edk2_crypto_info =3D {
> +    .parent =3D TYPE_OBJECT,
> +    .name =3D TYPE_EDK2_CRYPTO,
> +    .instance_size =3D sizeof(Edk2Crypto),
> +    .instance_finalize =3D edk2_crypto_finalize,
> +    .class_size =3D sizeof(Edk2CryptoClass),
> +    .class_init =3D edk2_crypto_class_init,
> +    .interfaces =3D (InterfaceInfo[]) {
> +        { TYPE_USER_CREATABLE },
> +        { }
> +    }
> +};
> +
> +static void edk2_crypto_register_types(void)
> +{
> +    type_register_static(&edk2_crypto_info);
> +}
> +
> +type_init(edk2_crypto_register_types);
> +
> +static void edk2_add_host_crypto_policy_https(FWCfgState *fw_cfg)
> +{
> +    Edk2Crypto *s;
> +
> +    s =3D edk2_crypto_by_policy_id("https", NULL);
> +    if (!s) {
> +        return;
> +    }
> +    if (s->ciphers.contents_length) {
> +        fw_cfg_add_file(fw_cfg, "etc/edk2/https/ciphers",
> +                        s->ciphers.contents, s->ciphers.contents_lengt=
h);
> +    }
> +    if (s->cacerts.contents_length) {
> +        fw_cfg_add_file(fw_cfg, "etc/edk2/https/cacerts",
> +                        s->cacerts.contents, s->cacerts.contents_lengt=
h);
> +    }
> +}
> +
> +void edk2_add_host_crypto_policy(FWCfgState *fw_cfg)
> +{
> +    edk2_add_host_crypto_policy_https(fw_cfg);
> +}

(7) How is it ensured by this implementation that "id=3Dhttps" is
specified at most twice, for this object type?

Is that guaranteed by general infrastructure?

I vaguely recall object_resolve_path_component() or similar failing if
there isn't exactly one match. But, you mention
"UserCreatableClass::complete" in the patch notes anyway, so the
conflict is likely detected even earlier.


> diff --git a/include/hw/firmware/uefi_edk2.h b/include/hw/firmware/uefi=
_edk2.h
> new file mode 100644
> index 0000000000..f8f81c5cb2
> --- /dev/null
> +++ b/include/hw/firmware/uefi_edk2.h
> @@ -0,0 +1,30 @@
> +/*
> + * UEFI EDK2 Support
> + *
> + * Copyright (c) 2019 Red Hat Inc.
> + *
> + * Author:
> + *  Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2 or =
later.
> + * See the COPYING file in the top-level directory.
> + */
> +
> +#ifndef HW_FIRMWARE_UEFI_EDK2_H
> +#define HW_FIRMWARE_UEFI_EDK2_H
> +
> +#include "hw/nvram/fw_cfg.h"
> +
> +/**
> + * edk2_add_host_crypto_policy:
> + * @fw_cfg: fw_cfg device being modified
> + *
> + * Add a new named file containing the host crypto policy.

(8) I'd use plural here ("add named files...")


> + *
> + * This method is called by the machine_done() Notifier of
> + * some implementations of MachineState, currently the X86
> + * PCMachineState and the ARM VirtMachineState.
> + */

(9) I suggest dropping the phrase starting with "currently".

The first half of the sentence is helpful, because it states a goal.

The second half of the sentence is bound to get stale at some point, and
whoever cares can run "git grep -w edk2_add_host_crypto_policy" at any ti=
me.

> +void edk2_add_host_crypto_policy(FWCfgState *fw_cfg);
> +
> +#endif /* HW_FIRMWARE_UEFI_EDK2_H */
>=20

Thanks!
Laszlo

