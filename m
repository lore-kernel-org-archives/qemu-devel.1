Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64011C33CB3
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:55:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3141924684
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 08:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="guXfUqUm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3141924684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwMeq-0001ja-BO
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 03:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <slp@redhat.com>) id 1iwMdz-0001GC-CE
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:54:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <slp@redhat.com>) id 1iwMdw-0004Nh-Q8
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:54:46 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25421
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <slp@redhat.com>) id 1iwMdw-0004La-F1
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 03:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580201683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3LH98Gn/Za/VMEH6pXU7nloo37P8SH4vPsNofPjCWK8=;
 b=guXfUqUmBLTbsAb/oJaI5f9yaMDYmuozNdbRqRMKFgIVaoJiRhR5JS36MTIMWrv2ph8da3
 S0aYnzVI/CPAMNQxqY19aL7JA8BTV3aQq8H5pkTawbXvIcd3bZoeR4tCUiEajpqCIyqMXq
 uBM8a5gLo68O4YLg3k06npvGd2+acg8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-261-UPe2iSAyOJOHEa1XQQLifg-1; Tue, 28 Jan 2020 03:54:41 -0500
X-MC-Unique: UPe2iSAyOJOHEa1XQQLifg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFFA5A0CBF;
 Tue, 28 Jan 2020 08:54:39 +0000 (UTC)
Received: from localhost (unknown [10.33.36.25])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 651045C219;
 Tue, 28 Jan 2020 08:54:39 +0000 (UTC)
Date: Tue, 28 Jan 2020 09:54:38 +0100
From: Sergio Lopez <slp@redhat.com>
To: Kamil Rytarowski <n54@gmx.com>
Subject: Re: [PATCH 2/4] Add the NetBSD Virtual Machine Monitor accelerator.
Message-ID: <20200128085438.hhz3f55bow75zl35@dritchie>
References: <20200107125401.18126-1-n54@gmx.com>
 <20200107125401.18126-3-n54@gmx.com>
MIME-Version: 1.0
In-Reply-To: <20200107125401.18126-3-n54@gmx.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="iyzcydilraxyxp76"
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org,
 Maxime Villard <max@m00nbsd.net>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--iyzcydilraxyxp76
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 07, 2020 at 01:53:59PM +0100, Kamil Rytarowski wrote:
> From: Maxime Villard <max@m00nbsd.net>
>=20
> Introduces the configure support for the new NetBSD Virtual Machine Monit=
or that
> allows for hypervisor acceleration from usermode components on the NetBSD
> platform.
>=20
> Signed-off-by: Maxime Villard <max@m00nbsd.net>
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  configure       | 36 ++++++++++++++++++++++++++++++++++++
>  qemu-options.hx |  4 ++--
>  2 files changed, 38 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure b/configure
> index 0ce2c0354a..eb456a271e 100755
> --- a/configure
> +++ b/configure
> @@ -241,6 +241,17 @@ supported_whpx_target() {
>      return 1
>  }
>=20
> +supported_nvmm_target() {
> +    test "$nvmm" =3D "yes" || return 1
> +    glob "$1" "*-softmmu" || return 1
> +    case "${1%-softmmu}" in
> +        i386|x86_64)
> +            return 0
> +        ;;
> +    esac
> +    return 1
> +}
> +
>  supported_target() {
>      case "$1" in
>          *-softmmu)
> @@ -268,6 +279,7 @@ supported_target() {
>      supported_hax_target "$1" && return 0
>      supported_hvf_target "$1" && return 0
>      supported_whpx_target "$1" && return 0
> +    supported_nvmm_target "$1" && return 0
>      print_error "TCG disabled, but hardware accelerator not available fo=
r '$target'"
>      return 1
>  }
> @@ -387,6 +399,7 @@ kvm=3D"no"
>  hax=3D"no"
>  hvf=3D"no"
>  whpx=3D"no"
> +nvmm=3D"no"
>  rdma=3D""
>  pvrdma=3D""
>  gprof=3D"no"
> @@ -1168,6 +1181,10 @@ for opt do
>    ;;
>    --enable-whpx) whpx=3D"yes"
>    ;;
> +  --disable-nvmm) nvmm=3D"no"
> +  ;;
> +  --enable-nvmm) nvmm=3D"yes"
> +  ;;
>    --disable-tcg-interpreter) tcg_interpreter=3D"no"
>    ;;
>    --enable-tcg-interpreter) tcg_interpreter=3D"yes"
> @@ -1768,6 +1785,7 @@ disabled with --disable-FEATURE, default is enabled=
 if available:
>    hax             HAX acceleration support
>    hvf             Hypervisor.framework acceleration support
>    whpx            Windows Hypervisor Platform acceleration support
> +  nvmm            NetBSD Virtual Machine Monitor acceleration support
>    rdma            Enable RDMA-based migration
>    pvrdma          Enable PVRDMA support
>    vde             support for vde network
> @@ -2757,6 +2775,20 @@ if test "$whpx" !=3D "no" ; then
>      fi
>  fi
>=20
> +##########################################
> +# NetBSD Virtual Machine Monitor (NVMM) accelerator check
> +if test "$nvmm" !=3D "no" ; then
> +    if check_include "nvmm.h" ; then
> +        nvmm=3D"yes"
> +=09LIBS=3D"-lnvmm $LIBS"
> +    else
> +        if test "$nvmm" =3D "yes"; then
> +            feature_not_found "NVMM" "NVMM is not available"
> +        fi
> +        nvmm=3D"no"
> +    fi
> +fi
> +
>  ##########################################
>  # Sparse probe
>  if test "$sparse" !=3D "no" ; then
> @@ -6495,6 +6527,7 @@ echo "KVM support       $kvm"
>  echo "HAX support       $hax"
>  echo "HVF support       $hvf"
>  echo "WHPX support      $whpx"
> +echo "NVMM support      $nvmm"
>  echo "TCG support       $tcg"
>  if test "$tcg" =3D "yes" ; then
>      echo "TCG debug enabled $debug_tcg"
> @@ -7771,6 +7804,9 @@ fi
>  if test "$target_aligned_only" =3D "yes" ; then
>    echo "TARGET_ALIGNED_ONLY=3Dy" >> $config_target_mak
>  fi
> +if supported_nvmm_target $target; then
> +    echo "CONFIG_NVMM=3Dy" >> $config_target_mak
> +fi
>  if test "$target_bigendian" =3D "yes" ; then
>    echo "TARGET_WORDS_BIGENDIAN=3Dy" >> $config_target_mak
>  fi
> diff --git a/qemu-options.hx b/qemu-options.hx
> index e9d6231438..f2dbac68ef 100644
> --- a/qemu-options.hx
> +++ b/qemu-options.hx
> @@ -31,7 +31,7 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
>      "-machine [type=3D]name[,prop[=3Dvalue][,...]]\n"
>      "                selects emulated machine ('-machine help' for list)=
\n"
>      "                property accel=3Daccel1[:accel2[:...]] selects acce=
lerator\n"
> -    "                supported accelerators are kvm, xen, hax, hvf, whpx=
 or tcg (default: tcg)\n"
> +    "                supported accelerators are kvm, xen, hax, hvf, nvmm=
, whpx or tcg (default: tcg)\n"
>      "                vmport=3Don|off|auto controls emulation of vmport (=
default: auto)\n"
>      "                dump-guest-core=3Don|off include guest memory in a =
core dump (default=3Don)\n"
>      "                mem-merge=3Don|off controls memory merge support (d=
efault: on)\n"
> @@ -63,7 +63,7 @@ Supported machine properties are:
>  @table @option
>  @item accel=3D@var{accels1}[:@var{accels2}[:...]]
>  This is used to enable an accelerator. Depending on the target architect=
ure,
> -kvm, xen, hax, hvf, whpx or tcg can be available. By default, tcg is use=
d. If there is
> +kvm, xen, hax, hvf, nvmm, whpx or tcg can be available. By default, tcg =
is used. If there is

Nitpick, but I think it'd be better to end the line at "tcg is used."
and rearrange the paragraph, to avoid such a long line.

>  more than one accelerator specified, the next one is used if the previou=
s one
>  fails to initialize.
>  @item vmport=3Don|off|auto

Please update the section for "accel" option too.

Sergio.

--iyzcydilraxyxp76
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEvtX891EthoCRQuii9GknjS8MAjUFAl4v9s0ACgkQ9GknjS8M
AjU2rw//Ue9Pef5Z23mpFhxxG7yV6LZxSxqqqmDbFmYsBsL65nVoXXdPNn2n30Qn
WH4fiBkm+z4R5ejitIn9HsQKW/7U/8HSeF2P4qV8lmERe+78R0tMGBuv7WuFuzGj
C1oCest6iVCtuxgz0eCC7n5mXrbKHKbZIh24SNtV0Ra+ofAmgDKmqxBj46GSW3vs
0ntWRKAQGAY+5LK7ptO404qFnL4nD4fZsnELIYIEyva8BtiRsquYc2uP4Bo/A0EM
wgo3S5fmgMqnl2PrGNJ39ozRZy+ESW/8pYLDhtU6hWjoTEm2eP3cSdQRlsG21cA5
9Cerp7lBkyROCLw3ILI17zS65q58q37T1FffhXzN4hGn/13H9pYA4Pk9N0ZYotAv
VaLbu8geJR+PJ168t6FzqQ9wYc0DNB3U2aj4jau8kaeiAbvWumye08lNt70AevCq
IMsCxtN2pA/pOn0wEoP/R0J9MaKGQjGkYdwXYjtprRQk+KDsJzIKKrax7YVqXbZf
BGQPMspEJBWIwx6lCD2xv8TO+vdPQ1LHPguT7kHv6YjB9R0VD/el+GPQWoSs4/K0
BHED3GIu9kyRzusK6EV02iZDWSt2cECacDT3vZ+Na4ilqbasUiufdkIxcVqGo9s5
vIM92kVTlJIscKBvFJB1ZrkIMeh5b0ctOBiTHxVBaoOC6M9Cbo0=
=IjH8
-----END PGP SIGNATURE-----

--iyzcydilraxyxp76--


