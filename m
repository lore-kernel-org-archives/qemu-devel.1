Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 967B3C432C3
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:36:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 60A5D2068D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 11:36:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzjO+NXm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 60A5D2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWfKG-000586-DN
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 06:36:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iWfJQ-0004EX-6q
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:35:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iWfJN-0005jw-6I
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:35:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:39687
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iWfJL-0005ik-1j
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 06:35:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574076912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L73iR7S0c4y+PPkbcpRiCNaBX1jUviS/Yu3+QetPhKQ=;
 b=FzjO+NXmE9iM8owJy8uWWd6Ix8ZJA+BlewnCAsAAxGk68AppksShMTic3aFaZmlaqxmaS6
 OLKsb/jHiULfAWQyH+VIaVlwU14JQN4f9ZXRHO/S7c7WaCdjXUtaxTQm1czVbVIft2khbb
 aeI4CZWEbyNH6sDWeP+HsQAMNo/blRA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-Yjq5w6gfP_a0Z7RN3J0D6g-1; Mon, 18 Nov 2019 06:35:09 -0500
X-MC-Unique: Yjq5w6gfP_a0Z7RN3J0D6g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 92E20107B7FE;
 Mon, 18 Nov 2019 11:35:07 +0000 (UTC)
Received: from dritchie.redhat.com (unknown [10.33.36.162])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E14BC60856;
 Mon, 18 Nov 2019 11:35:01 +0000 (UTC)
References: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
User-agent: mu4e 1.2.0; emacs 26.2
From: Sergio Lopez <slp@redhat.com>
To: Liam Merwick <liam.merwick@oracle.com>
Subject: Re: [PATCH v2] hw/i386: Move save_tsc_khz from PCMachineClass to
 X86MachineClass
In-reply-to: <1574075605-25215-1-git-send-email-liam.merwick@oracle.com>
Date: Mon, 18 Nov 2019 12:34:57 +0100
Message-ID: <87eey5s9i6.fsf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
Content-Type: multipart/signed; boundary="=-=-=";
 micalg=pgp-sha256; protocol="application/pgp-signature"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, qemu-devel@nongnu.org,
 darren.kenny@oracle.com, pbonzini@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


Liam Merwick <liam.merwick@oracle.com> writes:

> Attempting to migrate a VM using the microvm machine class results in the=
 source
> QEMU aborting with the following message/backtrace:
>
> target/i386/machine.c:955:tsc_khz_needed: Object 0x555556608fa0 is not an
> instance of type generic-pc-machine
>
> abort()
> object_class_dynamic_cast_assert()
> vmstate_save_state_v()
> vmstate_save_state()
> vmstate_save()
> qemu_savevm_state_complete_precopy()
> migration_thread()
> migration_thread()
> migration_thread()
> qemu_thread_start()
> start_thread()
> clone()
>
> The access to the machine class returned by MACHINE_GET_CLASS() in
> tsc_khz_needed() is crashing as it is trying to dereference a different
> type of machine class object (TYPE_PC_MACHINE) to that of this microVM.
>
> This can be resolved by extending the changes in the following commit
> f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineState fro=
m it")
> and moving the save_tsc_khz field in PCMachineClass to X86MachineClass.
>
> Fixes: f0bb276bf8d5 ("hw/i386: split PCMachineState deriving X86MachineSt=
ate from it")
> Signed-off-by: Liam Merwick <liam.merwick@oracle.com>
> Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
> ---
>
> v1 -> v2 - fix SHA1 of patch being referenced.
>
>  hw/i386/pc.c          | 1 -
>  hw/i386/pc_piix.c     | 4 ++--
>  hw/i386/pc_q35.c      | 4 ++--
>  hw/i386/x86.c         | 1 +
>  include/hw/i386/pc.h  | 2 --
>  include/hw/i386/x86.h | 2 ++
>  target/i386/machine.c | 4 ++--
>  7 files changed, 9 insertions(+), 9 deletions(-)
>
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index 96715f8a3f99..ac08e6360437 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -2195,7 +2195,6 @@ static void pc_machine_class_init(ObjectClass *oc, =
void *data)
>      /* BIOS ACPI tables: 128K. Other BIOS datastructures: less than 4K r=
eported
>       * to be used at the moment, 32K should be enough for a while.  */
>      pcmc->acpi_data_size =3D 0x20000 + 0x8000;
> -    pcmc->save_tsc_khz =3D true;
>      pcmc->linuxboot_dma_enabled =3D true;
>      pcmc->pvh_enabled =3D true;
>      assert(!mc->get_hotplug_handler);
> diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> index 2aefa3b8dfe3..0548c259dc74 100644
> --- a/hw/i386/pc_piix.c
> +++ b/hw/i386/pc_piix.c
> @@ -567,10 +567,10 @@ DEFINE_I440FX_MACHINE(v2_6, "pc-i440fx-2.6", NULL,
> =20
>  static void pc_i440fx_2_5_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> =20
>      pc_i440fx_2_6_machine_options(m);
> -    pcmc->save_tsc_khz =3D false;
> +    x86mc->save_tsc_khz =3D false;
>      m->legacy_fw_cfg_order =3D 1;
>      compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
> diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
> index d51f5247276d..385e5cffb167 100644
> --- a/hw/i386/pc_q35.c
> +++ b/hw/i386/pc_q35.c
> @@ -508,10 +508,10 @@ DEFINE_Q35_MACHINE(v2_6, "pc-q35-2.6", NULL,
> =20
>  static void pc_q35_2_5_machine_options(MachineClass *m)
>  {
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(m);
> =20
>      pc_q35_2_6_machine_options(m);
> -    pcmc->save_tsc_khz =3D false;
> +    x86mc->save_tsc_khz =3D false;
>      m->legacy_fw_cfg_order =3D 1;
>      compat_props_add(m->compat_props, hw_compat_2_5, hw_compat_2_5_len);
>      compat_props_add(m->compat_props, pc_compat_2_5, pc_compat_2_5_len);
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index fd84b23124e6..394edc2f7209 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -763,6 +763,7 @@ static void x86_machine_class_init(ObjectClass *oc, v=
oid *data)
>      mc->get_default_cpu_node_id =3D x86_get_default_cpu_node_id;
>      mc->possible_cpu_arch_ids =3D x86_possible_cpu_arch_ids;
>      x86mc->compat_apic_id_mode =3D false;
> +    x86mc->save_tsc_khz =3D true;
>      nc->nmi_monitor_handler =3D x86_nmi;
> =20
>      object_class_property_add(oc, X86_MACHINE_MAX_RAM_BELOW_4G, "size",
> diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
> index e6fa8418ca61..1f86eba3f998 100644
> --- a/include/hw/i386/pc.h
> +++ b/include/hw/i386/pc.h
> @@ -116,8 +116,6 @@ typedef struct PCMachineClass {
>      bool enforce_aligned_dimm;
>      bool broken_reserved_end;
> =20
> -    /* TSC rate migration: */
> -    bool save_tsc_khz;
>      /* generate legacy CPU hotplug AML */
>      bool legacy_cpu_hotplug;
> =20
> diff --git a/include/hw/i386/x86.h b/include/hw/i386/x86.h
> index 82d09fd7d099..4b8491788526 100644
> --- a/include/hw/i386/x86.h
> +++ b/include/hw/i386/x86.h
> @@ -30,6 +30,8 @@ typedef struct {
> =20
>      /*< public >*/
> =20
> +    /* TSC rate migration: */
> +    bool save_tsc_khz;
>      /* Enables contiguous-apic-ID mode */
>      bool compat_apic_id_mode;
>  } X86MachineClass;
> diff --git a/target/i386/machine.c b/target/i386/machine.c
> index 6481f846f6e9..7bdeb7815755 100644
> --- a/target/i386/machine.c
> +++ b/target/i386/machine.c
> @@ -988,8 +988,8 @@ static bool tsc_khz_needed(void *opaque)
>      X86CPU *cpu =3D opaque;
>      CPUX86State *env =3D &cpu->env;
>      MachineClass *mc =3D MACHINE_GET_CLASS(qdev_get_machine());
> -    PCMachineClass *pcmc =3D PC_MACHINE_CLASS(mc);
> -    return env->tsc_khz && pcmc->save_tsc_khz;
> +    X86MachineClass *x86mc =3D X86_MACHINE_CLASS(mc);
> +    return env->tsc_khz && x86mc->save_tsc_khz;
>  }
> =20
>  static const VMStateDescription vmstate_tsc_khz =3D {

LGTM, thanks.

Reviewed-by: Sergio Lopez <slp@redhat.com>

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl3SgeEACgkQ9GknjS8M
AjX66g//V7e4qWNoAmHF0JsvlL5yraYa/CZSbJ5kwCuqvrhFaThkPYWZPTFwYtZ8
IL9Hdb8mHXRTGZyzTDr9pfdKDvCPlC/RbLYO0tJYNLszVtActYjMcN0OPCmzOibK
M1s0EK7hsRHCc7fabjg9ubHsapfZRQFqZzkK3QAhtCztDFDDvtCDtzJ19KUr3F49
UPdH/lPhq/va4XM0DP1N6oJkcahC3hAUEEVX3/YOVO+3E7SgVXE3wAWIhCVV9aVN
z8URkE6t6/YEzBA2R+gat1+erkq71Yvdnqr5PnGzGctu5/K4/xIGM1SBZhZ+8Wo3
BczMGN5R3EC3peyl9E9WzVZCdRc59ZmBsdewdrBQRz5841axHC4aMHeyEQ49X4hY
ly9LkL8JNG/E22eBS73FcUJ1441F6p0aXrfWo4Evma08y5i04v4kg7/aqdsdCsMY
ClS4vtyc/3R8RrrDSfJDrQ0zjh+Ce5dSUYT8AzMrv/I1X2HSdkyU02Uzhcf86/k6
YYXBdv80g3YX6O5MrykAGg/koYRx9rkFwMaIszg9kyI+wuIZ6z+SDXQ2yAeESCbc
UfN4x2M0XcjUK3KpBQqE+V5yhADFR06/GYEKEW/O5Tmt45tnbsj0KDNnDBScjObT
/KBoRqX1hH6ycpiMe9U11IGWhqNzRSagqQ6ZUP0Xbtzo880Hnt0=
=hgEO
-----END PGP SIGNATURE-----
--=-=-=--


