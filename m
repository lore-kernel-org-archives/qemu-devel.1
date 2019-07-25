Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E05C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:52:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA9E6218DA
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 10:52:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9E6218DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58557 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqbMU-0005Gc-26
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 06:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39461)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <groug@kaod.org>) id 1hqbMK-0004sG-C0
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:52:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1hqbMJ-0002aa-FU
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:52:28 -0400
Received: from 8.mo173.mail-out.ovh.net ([46.105.46.122]:35558)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1hqbMJ-0002aM-9e
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 06:52:27 -0400
Received: from player755.ha.ovh.net (unknown [10.109.159.159])
 by mo173.mail-out.ovh.net (Postfix) with ESMTP id 221BE1115BD
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 12:52:24 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player755.ha.ovh.net (Postfix) with ESMTPSA id 705698640ECD;
 Thu, 25 Jul 2019 10:52:22 +0000 (UTC)
Date: Thu, 25 Jul 2019 12:52:21 +0200
From: Greg Kurz <groug@kaod.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <20190725125221.7fdbe6ba@bahia.lab.toulouse-stg.fr.ibm.com>
In-Reply-To: <20190725101836.1273-1-pbonzini@redhat.com>
References: <20190725101836.1273-1-pbonzini@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Ovh-Tracer-Id: 9937192580113537486
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduvddrkedvgdefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.46.122
Subject: Re: [Qemu-devel] [PATCH] 9p: simplify source file selection
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
Cc: =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 25 Jul 2019 12:18:36 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> Express the complex conditions in Kconfig rather than Makefiles, since Kc=
onfig
> is better suited at expressing dependencies and detecting contradictions.
>=20
> Cc: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Acked-by: Greg Kurz <groug@kaod.org>

>  Kconfig.host        | 1 +
>  fsdev/Makefile.objs | 2 +-
>  hw/9pfs/Kconfig     | 5 +++++
>  3 files changed, 7 insertions(+), 1 deletion(-)
>=20
> diff --git a/Kconfig.host b/Kconfig.host
> index aec95365ff..bb6e116e2a 100644
> --- a/Kconfig.host
> +++ b/Kconfig.host
> @@ -28,6 +28,7 @@ config VHOST_USER
> =20
>  config XEN
>      bool
> +    select FSDEV_9P if VIRTFS
> =20
>  config VIRTFS
>      bool
> diff --git a/fsdev/Makefile.objs b/fsdev/Makefile.objs
> index 24bbb3e75c..42cd70c367 100644
> --- a/fsdev/Makefile.objs
> +++ b/fsdev/Makefile.objs
> @@ -1,6 +1,6 @@
>  # Lots of the fsdev/9pcode is pulled in by vl.c via qemu_fsdev_add.
>  # only pull in the actual 9p backend if we also enabled virtio or xen.
> -ifeq ($(call land,$(CONFIG_VIRTFS),$(call lor,$(CONFIG_VIRTIO_9P),$(CONF=
IG_XEN))),y)
> +ifeq ($(CONFIG_FSDEV_9P),y)
>  common-obj-y =3D qemu-fsdev.o 9p-marshal.o 9p-iov-marshal.o
>  else
>  common-obj-y =3D qemu-fsdev-dummy.o
> diff --git a/hw/9pfs/Kconfig b/hw/9pfs/Kconfig
> index 8c5032c575..3ae5749661 100644
> --- a/hw/9pfs/Kconfig
> +++ b/hw/9pfs/Kconfig
> @@ -1,4 +1,9 @@
> +config FSDEV_9P
> +    bool
> +    depends on VIRTFS
> +
>  config VIRTIO_9P
>      bool
>      default y
>      depends on VIRTFS && VIRTIO
> +    select FSDEV_9P


