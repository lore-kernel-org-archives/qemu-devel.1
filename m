Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551B3C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:09:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 101382173E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 12:09:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JlZkUQ7v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 101382173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8jsu-0008FB-9J
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 07:09:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40730)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j8js4-00079d-KP
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j8js0-0006eg-Fm
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:28 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:38803)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j8js0-0006bg-5E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 07:08:24 -0500
Received: by mail-wm1-x344.google.com with SMTP id u9so4547347wml.3
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 04:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=uJewdsK7P0oydLTOg+6BkU33gHsjFKNyYM35RQrhTfw=;
 b=JlZkUQ7vNgzmGBdxUgc5M9RuDODJgKnh47+J6NhVQ1FmB6/VthF43yK1k2yCejLYRb
 iA7lpnT+YcCv5w3nKbb8DjW4Z1CjJaeVFAJtCXopN+6YI0H5WC5fqdP12ChKvacp9NW9
 HidOR1X/LgqHV1HU2fJzDyt5F6Dv9trSM5cH9e2sguURdy3wPUNHc8UL5SPhbEoF/zWl
 cbyfoL8Vr29bd93++U5S/1JpPTTsRDLqaotNU+2SqxGhPJCpkh02PL7MjfJYm6Baw33k
 nugphh2F/L3CL4OGQA0lfUTf+ubHHeQ4fx5Psy64OpJR+6WXtcTlPG0UCb/VbOBK2ped
 QJaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=uJewdsK7P0oydLTOg+6BkU33gHsjFKNyYM35RQrhTfw=;
 b=mIMwQSs8d0iYCq+kkaaYkVdTrxOvti64QO0fw2QKNxtwQ+p9EANyGiUghq7KEKhJfW
 m7Gru431icLY6iqLrv/3dfg2amcqpKyjnSNzuf4yAf5MTVn8cbjM+AvPEfSfEqtCxzVL
 ImgBToW8RYNIr1axyLARSfZG8mk6ySJZN8wVA52D3V7ZqA+/tuecPui1Bud1NTO2OXZ0
 c1aQpk37HJlf1/+0SHZ3quTXR03+eajK39wmuzzQHCFhzmgm9GzRiHWC7xykwBrNuYed
 HdYltWruetNOGeZgbmMonXKvQDqsLWXPurH2yJIXLHs9Be9pbHMxgvw+1ZhegMzlEF2b
 e0HQ==
X-Gm-Message-State: APjAAAWGu9DAXJYuifFc1/V3nUR3uB3GwDz9588dwLH0/Kpav4zx0+xz
 KA7wOL7XuuWH0s95bfzywNj2lg==
X-Google-Smtp-Source: APXvYqzIjuufOQdguco6tNi04EitJ85FQ0Ah7h3oNYPjysPxR5zNSL4dK36jr8AN4nHVIKC//i0liA==
X-Received: by 2002:a7b:c5da:: with SMTP id n26mr18829300wmk.138.1583150902167; 
 Mon, 02 Mar 2020 04:08:22 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q12sm29409710wrg.71.2020.03.02.04.08.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2020 04:08:20 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 0A1C51FF87;
 Mon,  2 Mar 2020 12:08:20 +0000 (GMT)
References: <20200228153619.9906-1-peter.maydell@linaro.org>
 <20200228153619.9906-16-peter.maydell@linaro.org>
User-agent: mu4e 1.3.9; emacs 27.0.90
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v3 15/33] docs/system: Convert qemu-cpu-models.texi to rST
In-reply-to: <20200228153619.9906-16-peter.maydell@linaro.org>
Date: Mon, 02 Mar 2020 12:08:20 +0000
Message-ID: <87a74zarij.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Kashyap Chamarthy <kchamart@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> From: Kashyap Chamarthy <kchamart@redhat.com>
>
> This doc was originally written by Daniel P. Berrang=C3=A9
> <berrange@redhat.com>, introduced via commit[1]: 2544e9e4aa (docs: add
> guidance on configuring CPU models for x86, 2018-06-27).
>
> In this patch:
>
>   - 1-1 conversion of Texinfo to rST, besides a couple of minor
>     tweaks that are too trivial to mention.   (Thanks to Stephen
>     Finucane on IRC for the suggestion to use rST "definition lists"
>     instead of bullets in some places.)
>
>     Further modifications will be done via a separate patch.
>
>   - rST and related infra changes: manual page generation, Makefile
>     fixes, clean up references to qemu-cpu-models.texi, update year in
>     the copyright notice, etc.
>
> [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dcommit;h=3D2544e9e4aa
>
> As part of the conversion, we use a more generic 'author' attribution
> for the manpage than we previously had, as agreed with the original
> author Dan Berrange.
>
> Signed-off-by: Kashyap Chamarthy <kchamart@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-id: 20200226113034.6741-15-pbonzini@redhat.com
> [Move macros to defs.rst.inc, split in x86 and MIPS parts,
>  make qemu-cpu-models.rst a standalone document. - Paolo]
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> [PMM: Move defs.rst.inc setup to its own commit;
>  fix minor issues with MAINTAINERS file updates;
>  drop copyright date change; keep capitalization of
>  "QEMU Project developers" consistent with other uses;
>  minor Makefile fixups]
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  Makefile                            |   8 +-
>  MAINTAINERS                         |   2 +
>  docs/system/conf.py                 |   6 +-
>  docs/system/cpu-models-mips.rst.inc | 105 ++++++++
>  docs/system/cpu-models-x86.rst.inc  | 365 ++++++++++++++++++++++++++++
>  docs/system/qemu-cpu-models.rst     |  20 ++
>  docs/system/qemu-cpu-models.texi    |  28 ---
>  7 files changed, 500 insertions(+), 34 deletions(-)
>  create mode 100644 docs/system/cpu-models-mips.rst.inc
>  create mode 100644 docs/system/cpu-models-x86.rst.inc
>  create mode 100644 docs/system/qemu-cpu-models.rst
>  delete mode 100644 docs/system/qemu-cpu-models.texi
>
> diff --git a/Makefile b/Makefile
> index 26bbd334438..f8642cd28a1 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -354,7 +354,7 @@ endif
>  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
>  DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/qemu-ga-ref.txt docs/=
interop/qemu-ga-ref.7
> -DOCS+=3Ddocs/system/qemu-cpu-models.7
> +DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-cpu-models.7
>  DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
>  DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
> @@ -780,7 +780,6 @@ distclean: clean
>  	rm -f docs/interop/qemu-qmp-ref.txt docs/interop/qemu-ga-ref.txt
>  	rm -f docs/interop/qemu-qmp-ref.pdf docs/interop/qemu-ga-ref.pdf
>  	rm -f docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-ref.html
> -	rm -f docs/system/qemu-cpu-models.7
>  	rm -rf .doctrees
>  	$(call clean-manual,devel)
>  	$(call clean-manual,interop)
> @@ -861,7 +860,7 @@ ifdef CONFIG_POSIX
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) docs/interop/qemu-qmp-ref.7 "$(DESTDIR)$(mandir)/man7"
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DESTD=
IR)$(mandir)/man7"
> -	$(INSTALL_DATA) docs/system/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
> +	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-cpu-models.7 "$(DESTDIR)=
$(mandir)/man7"
>  ifeq ($(CONFIG_TOOLS),y)
>  	$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mandir=
)/man1"
>  	$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
> @@ -1083,7 +1082,7 @@ $(MANUAL_BUILDDIR)/user/index.html: $(call manual-d=
eps,user)
>=20=20
>  $(call define-manpage-rule,interop,qemu-ga.8)
>=20=20
> -$(call define-manpage-rule,system,qemu-block-drivers.7)
> +$(call define-manpage-rule,system,qemu-block-drivers.7 qemu-cpu-models.7)
>=20=20
>  $(call define-manpage-rule,tools,\
>         qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> @@ -1112,7 +1111,6 @@ docs/interop/qemu-ga-qapi.texi: qga/qapi-generated/=
qga-qapi-doc.texi
>=20=20
>  qemu.1: qemu-doc.texi qemu-options.texi qemu-monitor.texi qemu-monitor-i=
nfo.texi
>  qemu.1: docs/system/qemu-option-trace.texi
> -docs/system/qemu-cpu-models.7: docs/system/qemu-cpu-models.texi docs/sys=
tem/cpu-models-x86.texi docs/system/cpu-models-mips.texi
>=20=20
>  html: qemu-doc.html docs/interop/qemu-qmp-ref.html docs/interop/qemu-ga-=
ref.html sphinxdocs
>  info: qemu-doc.info docs/interop/qemu-qmp-ref.info docs/interop/qemu-ga-=
ref.info
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 74b025fb806..1712eb90851 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -216,6 +216,7 @@ F: target/mips/
>  F: default-configs/*mips*
>  F: disas/*mips*
>  F: docs/system/cpu-models-mips.texi
> +F: docs/system/cpu-models-mips.rst.inc
>  F: hw/intc/mips_gic.c
>  F: hw/mips/
>  F: hw/misc/mips_*
> @@ -321,6 +322,7 @@ F: tests/tcg/x86_64/
>  F: hw/i386/
>  F: disas/i386.c
>  F: docs/system/cpu-models-x86.texi
> +F: docs/system/cpu-models-x86.rst.inc
>  T: git https://github.com/ehabkost/qemu.git x86-next
>=20=20
>  Xtensa TCG CPUs
> diff --git a/docs/system/conf.py b/docs/system/conf.py
> index 7ca115f5e03..23cab3fb364 100644
> --- a/docs/system/conf.py
> +++ b/docs/system/conf.py
> @@ -13,10 +13,14 @@ exec(compile(open(parent_config, "rb").read(), parent=
_config, 'exec'))
>  # This slightly misuses the 'description', but is the best way to get
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] =3D u'System Emulation User''s Guide'
> +
>  # One entry per manual page. List of tuples
>  # (source start file, name, description, authors, manual section).
>  man_pages =3D [
>      ('qemu-block-drivers', 'qemu-block-drivers',
>       u'QEMU block drivers reference',
> -     ['Fabrice Bellard and the QEMU Project developers'], 7)
> +     ['Fabrice Bellard and the QEMU Project developers'], 7),
> +    ('qemu-cpu-models', 'qemu-cpu-models',
> +     u'QEMU CPU Models',
> +     ['The QEMU Project developers'], 7)
>  ]
> diff --git a/docs/system/cpu-models-mips.rst.inc b/docs/system/cpu-models=
-mips.rst.inc
> new file mode 100644
> index 00000000000..499b5b6fedb
> --- /dev/null
> +++ b/docs/system/cpu-models-mips.rst.inc
> @@ -0,0 +1,105 @@
> +Supported CPU model configurations on MIPS hosts
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +QEMU supports variety of MIPS CPU models:
> +
> +Supported CPU models for MIPS32 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are supported for use on MIPS32 hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +``mips32r6-generic``
> +    MIPS32 Processor (Release 6, 2015)
> +
> +``P5600``
> +    MIPS32 Processor (P5600, 2014)
> +
> +``M14K``, ``M14Kc``
> +    MIPS32 Processor (M14K, 2009)
> +
> +``74Kf``
> +    MIPS32 Processor (74K, 2007)
> +
> +``34Kf``
> +    MIPS32 Processor (34K, 2006)
> +
> +``24Kc``, ``24KEc``, ``24Kf``
> +    MIPS32 Processor (24K, 2003)
> +
> +``4Kc``, ``4Km``, ``4KEcR1``, ``4KEmR1``, ``4KEc``, ``4KEm``
> +    MIPS32 Processor (4K, 1999)
> +
> +
> +Supported CPU models for MIPS64 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are supported for use on MIPS64 hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +``I6400``
> +    MIPS64 Processor (Release 6, 2014)
> +
> +``Loongson-2F``
> +    MIPS64 Processor (Loongson 2, 2008)
> +
> +``Loongson-2E``
> +    MIPS64 Processor (Loongson 2, 2006)
> +
> +``mips64dspr2``
> +    MIPS64 Processor (Release 2, 2006)
> +
> +``MIPS64R2-generic``, ``5KEc``, ``5KEf``
> +    MIPS64 Processor (Release 2, 2002)
> +
> +``20Kc``
> +    MIPS64 Processor (20K, 2000
> +
> +``5Kc``, ``5Kf``
> +    MIPS64 Processor (5K, 1999)
> +
> +``VR5432``
> +    MIPS64 Processor (VR, 1998)
> +
> +``R4000``
> +    MIPS64 Processor (MIPS III, 1991)
> +
> +
> +Supported CPU models for nanoMIPS hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are supported for use on nanoMIPS hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +``I7200``
> +    MIPS I7200 (nanoMIPS, 2018)
> +
> +Preferred CPU models for MIPS hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are preferred for use on different MIPS hosts:
> +
> +``MIPS III``
> +    R4000
> +
> +``MIPS32R2``
> +    34Kf
> +
> +``MIPS64R6``
> +    I6400
> +
> +``nanoMIPS``
> +    I7200
> +
> diff --git a/docs/system/cpu-models-x86.rst.inc b/docs/system/cpu-models-=
x86.rst.inc
> new file mode 100644
> index 00000000000..cbad930c700
> --- /dev/null
> +++ b/docs/system/cpu-models-x86.rst.inc
> @@ -0,0 +1,365 @@
> +Recommendations for KVM CPU model configuration on x86 hosts
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The information that follows provides recommendations for configuring
> +CPU models on x86 hosts. The goals are to maximise performance, while
> +protecting guest OS against various CPU hardware flaws, and optionally
> +enabling live migration between hosts with heterogeneous CPU models.
> +
> +
> +Two ways to configure CPU models with QEMU / KVM
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +(1) **Host passthrough**
> +
> +    This passes the host CPU model features, model, stepping, exactly to
> +    the guest. Note that KVM may filter out some host CPU model features
> +    if they cannot be supported with virtualization. Live migration is
> +    unsafe when this mode is used as libvirt / QEMU cannot guarantee a
> +    stable CPU is exposed to the guest across hosts. This is the
> +    recommended CPU to use, provided live migration is not required.
> +
> +(2) **Named model**
> +
> +    QEMU comes with a number of predefined named CPU models, that
> +    typically refer to specific generations of hardware released by
> +    Intel and AMD.  These allow the guest VMs to have a degree of
> +    isolation from the host CPU, allowing greater flexibility in live
> +    migrating between hosts with differing hardware.  @end table
> +
> +In both cases, it is possible to optionally add or remove individual CPU
> +features, to alter what is presented to the guest by default.
> +
> +Libvirt supports a third way to configure CPU models known as "Host
> +model".  This uses the QEMU "Named model" feature, automatically picking
> +a CPU model that is similar the host CPU, and then adding extra features
> +to approximate the host model as closely as possible. This does not
> +guarantee the CPU family, stepping, etc will precisely match the host
> +CPU, as they would with "Host passthrough", but gives much of the
> +benefit of passthrough, while making live migration safe.
> +
> +
> +Preferred CPU models for Intel x86 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are preferred for use on Intel hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +``Skylake-Server``, ``Skylake-Server-IBRS``
> +    Intel Xeon Processor (Skylake, 2016)
> +
> +``Skylake-Client``, ``Skylake-Client-IBRS``
> +    Intel Core Processor (Skylake, 2015)
> +
> +``Broadwell``, ``Broadwell-IBRS``, ``Broadwell-noTSX``, ``Broadwell-noTS=
X-IBRS``
> +    Intel Core Processor (Broadwell, 2014)
> +
> +``Haswell``, ``Haswell-IBRS``, ``Haswell-noTSX``, ``Haswell-noTSX-IBRS``
> +    Intel Core Processor (Haswell, 2013)
> +
> +``IvyBridge``, ``IvyBridge-IBR``
> +    Intel Xeon E3-12xx v2 (Ivy Bridge, 2012)
> +
> +``SandyBridge``, ``SandyBridge-IBRS``
> +    Intel Xeon E312xx (Sandy Bridge, 2011)
> +
> +``Westmere``, ``Westmere-IBRS``
> +    Westmere E56xx/L56xx/X56xx (Nehalem-C, 2010)
> +
> +``Nehalem``, ``Nehalem-IBRS``
> +    Intel Core i7 9xx (Nehalem Class Core i7, 2008)
> +
> +``Penryn``
> +    Intel Core 2 Duo P9xxx (Penryn Class Core 2, 2007)
> +
> +``Conroe``
> +    Intel Celeron_4x0 (Conroe/Merom Class Core 2, 2006)
> +
> +
> +Important CPU features for Intel x86 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following are important CPU features that should be used on Intel
> +x86 hosts, when available in the host CPU. Some of them require explicit
> +configuration to enable, as they are not included by default in some, or
> +all, of the named CPU models listed above. In general all of these
> +features are included if using "Host passthrough" or "Host model".
> +
> +``pcid``
> +  Recommended to mitigate the cost of the Meltdown (CVE-2017-5754) fix.
> +
> +  Included by default in Haswell, Broadwell & Skylake Intel CPU models.
> +
> +  Should be explicitly turned on for Westmere, SandyBridge, and
> +  IvyBridge Intel CPU models. Note that some desktop/mobile Westmere
> +  CPUs cannot support this feature.
> +
> +``spec-ctrl``
> +  Required to enable the Spectre v2 (CVE-2017-5715) fix.
> +
> +  Included by default in Intel CPU models with -IBRS suffix.
> +
> +  Must be explicitly turned on for Intel CPU models without -IBRS
> +  suffix.
> +
> +  Requires the host CPU microcode to support this feature before it
> +  can be used for guest CPUs.
> +
> +``stibp``
> +  Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
> +  operating systems.
> +
> +  Must be explicitly turned on for all Intel CPU models.
> +
> +  Requires the host CPU microcode to support this feature before it can
> +  be used for guest CPUs.
> +
> +``ssbd``
> +  Required to enable the CVE-2018-3639 fix.
> +
> +  Not included by default in any Intel CPU model.
> +
> +  Must be explicitly turned on for all Intel CPU models.
> +
> +  Requires the host CPU microcode to support this feature before it
> +  can be used for guest CPUs.
> +
> +``pdpe1gb``
> +  Recommended to allow guest OS to use 1GB size pages.
> +
> +  Not included by default in any Intel CPU model.
> +
> +  Should be explicitly turned on for all Intel CPU models.
> +
> +  Note that not all CPU hardware will support this feature.
> +
> +``md-clear``
> +  Required to confirm the MDS (CVE-2018-12126, CVE-2018-12127,
> +  CVE-2018-12130, CVE-2019-11091) fixes.
> +
> +  Not included by default in any Intel CPU model.
> +
> +  Must be explicitly turned on for all Intel CPU models.
> +
> +  Requires the host CPU microcode to support this feature before it
> +  can be used for guest CPUs.
> +
> +
> +Preferred CPU models for AMD x86 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPU models are preferred for use on Intel hosts.
> +Administrators / applications are recommended to use the CPU model that
> +matches the generation of the host CPUs in use. In a deployment with a
> +mixture of host CPU models between machines, if live migration
> +compatibility is required, use the newest CPU model that is compatible
> +across all desired hosts.
> +
> +``EPYC``, ``EPYC-IBPB``
> +    AMD EPYC Processor (2017)
> +
> +``Opteron_G5``
> +    AMD Opteron 63xx class CPU (2012)
> +
> +``Opteron_G4``
> +    AMD Opteron 62xx class CPU (2011)
> +
> +``Opteron_G3``
> +    AMD Opteron 23xx (Gen 3 Class Opteron, 2009)
> +
> +``Opteron_G2``
> +    AMD Opteron 22xx (Gen 2 Class Opteron, 2006)
> +
> +``Opteron_G1``
> +    AMD Opteron 240 (Gen 1 Class Opteron, 2004)
> +
> +
> +Important CPU features for AMD x86 hosts
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following are important CPU features that should be used on AMD x86
> +hosts, when available in the host CPU. Some of them require explicit
> +configuration to enable, as they are not included by default in some, or
> +all, of the named CPU models listed above. In general all of these
> +features are included if using "Host passthrough" or "Host model".
> +
> +``ibpb``
> +  Required to enable the Spectre v2 (CVE-2017-5715) fix.
> +
> +  Included by default in AMD CPU models with -IBPB suffix.
> +
> +  Must be explicitly turned on for AMD CPU models without -IBPB suffix.
> +
> +  Requires the host CPU microcode to support this feature before it
> +  can be used for guest CPUs.
> +
> +``stibp``
> +  Required to enable stronger Spectre v2 (CVE-2017-5715) fixes in some
> +  operating systems.
> +
> +  Must be explicitly turned on for all AMD CPU models.
> +
> +  Requires the host CPU microcode to support this feature before it
> +  can be used for guest CPUs.
> +
> +``virt-ssbd``
> +  Required to enable the CVE-2018-3639 fix
> +
> +  Not included by default in any AMD CPU model.
> +
> +  Must be explicitly turned on for all AMD CPU models.
> +
> +  This should be provided to guests, even if amd-ssbd is also provided,
> +  for maximum guest compatibility.
> +
> +  Note for some QEMU / libvirt versions, this must be force enabled when
> +  when using "Host model", because this is a virtual feature that
> +  doesn't exist in the physical host CPUs.
> +
> +``amd-ssbd``
> +  Required to enable the CVE-2018-3639 fix
> +
> +  Not included by default in any AMD CPU model.
> +
> +  Must be explicitly turned on for all AMD CPU models.
> +
> +  This provides higher performance than ``virt-ssbd`` so should be
> +  exposed to guests whenever available in the host. ``virt-ssbd`` should
> +  none the less also be exposed for maximum guest compatibility as some
> +  kernels only know about ``virt-ssbd``.
> +
> +``amd-no-ssb``
> +  Recommended to indicate the host is not vulnerable CVE-2018-3639
> +
> +  Not included by default in any AMD CPU model.
> +
> +  Future hardware generations of CPU will not be vulnerable to
> +  CVE-2018-3639, and thus the guest should be told not to enable
> +  its mitigations, by exposing amd-no-ssb. This is mutually
> +  exclusive with virt-ssbd and amd-ssbd.
> +
> +``pdpe1gb``
> +  Recommended to allow guest OS to use 1GB size pages
> +
> +  Not included by default in any AMD CPU model.
> +
> +  Should be explicitly turned on for all AMD CPU models.
> +
> +  Note that not all CPU hardware will support this feature.
> +
> +
> +Default x86 CPU models
> +^^^^^^^^^^^^^^^^^^^^^^
> +
> +The default QEMU CPU models are designed such that they can run on all
> +hosts.  If an application does not wish to do perform any host
> +compatibility checks before launching guests, the default is guaranteed
> +to work.
> +
> +The default CPU models will, however, leave the guest OS vulnerable to
> +various CPU hardware flaws, so their use is strongly discouraged.
> +Applications should follow the earlier guidance to setup a better CPU
> +configuration, with host passthrough recommended if live migration is
> +not needed.
> +
> +``qemu32``, ``qemu64``
> +    QEMU Virtual CPU version 2.5+ (32 & 64 bit variants)
> +
> +``qemu64`` is used for x86_64 guests and ``qemu32`` is used for i686
> +guests, when no ``-cpu`` argument is given to QEMU, or no ``<cpu>`` is
> +provided in libvirt XML.
> +
> +Other non-recommended x86 CPUs
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +The following CPUs models are compatible with most AMD and Intel x86
> +hosts, but their usage is discouraged, as they expose a very limited
> +featureset, which prevents guests having optimal performance.
> +
> +``kvm32``, ``kvm64``
> +    Common KVM processor (32 & 64 bit variants).
> +
> +    Legacy models just for historical compatibility with ancient QEMU
> +    versions.
> +
> +``486``, ``athlon``, ``phenom``, ``coreduo``, ``core2duo``, ``n270``, ``=
pentium``, ``pentium2``, ``pentium3``
> +    Various very old x86 CPU models, mostly predating the introduction
> +    of hardware assisted virtualization, that should thus not be
> +    required for running virtual machines.
> +
> +
> +Syntax for configuring CPU models
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The examples below illustrate the approach to configuring the various
> +CPU models / features in QEMU and libvirt.
> +
> +QEMU command line
> +^^^^^^^^^^^^^^^^^
> +
> +Host passthrough:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -cpu host
> +
> +Host passthrough with feature customization:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -cpu host,-vmx,...
> +
> +Named CPU models:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -cpu Westmere
> +
> +Named CPU models with feature customization:
> +
> +.. parsed-literal::
> +
> +  |qemu_system| -cpu Westmere,+pcid,...
> +
> +Libvirt guest XML
> +^^^^^^^^^^^^^^^^^
> +
> +Host passthrough::
> +
> +    <cpu mode=3D'host-passthrough'/>
> +
> +Host passthrough with feature customization::
> +
> +    <cpu mode=3D'host-passthrough'>
> +        <feature name=3D"vmx" policy=3D"disable"/>
> +        ...
> +    </cpu>
> +
> +Host model::
> +
> +    <cpu mode=3D'host-model'/>
> +
> +Host model with feature customization::
> +
> +    <cpu mode=3D'host-model'>
> +        <feature name=3D"vmx" policy=3D"disable"/>
> +        ...
> +    </cpu>
> +
> +Named model::
> +
> +    <cpu mode=3D'custom'>
> +        <model name=3D"Westmere"/>
> +    </cpu>
> +
> +Named model with feature customization::
> +
> +    <cpu mode=3D'custom'>
> +        <model name=3D"Westmere"/>
> +        <feature name=3D"pcid" policy=3D"require"/>
> +        ...
> +    </cpu>
> diff --git a/docs/system/qemu-cpu-models.rst b/docs/system/qemu-cpu-model=
s.rst
> new file mode 100644
> index 00000000000..53d7538c473
> --- /dev/null
> +++ b/docs/system/qemu-cpu-models.rst
> @@ -0,0 +1,20 @@
> +:orphan:
> +
> +QEMU / KVM CPU model configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Synopsis
> +''''''''
> +
> +QEMU CPU Modelling Infrastructure manual
> +
> +Description
> +'''''''''''
> +
> +.. include:: cpu-models-x86.rst.inc
> +.. include:: cpu-models-mips.rst.inc
> +
> +See also
> +''''''''
> +
> +The HTML documentation of QEMU for more precise information and Linux us=
er mode emulator invocation.
> diff --git a/docs/system/qemu-cpu-models.texi b/docs/system/qemu-cpu-mode=
ls.texi
> deleted file mode 100644
> index f399daf9448..00000000000
> --- a/docs/system/qemu-cpu-models.texi
> +++ /dev/null
> @@ -1,28 +0,0 @@
> -@c man begin SYNOPSIS
> -QEMU / KVM CPU model configuration
> -@c man end
> -
> -@set qemu_system_x86 qemu-system-x86_64
> -
> -@c man begin DESCRIPTION
> -
> -@include cpu-models-x86.texi
> -@include cpu-models-mips.texi
> -
> -@c man end
> -
> -@ignore
> -
> -@setfilename qemu-cpu-models
> -@settitle QEMU / KVM CPU model configuration
> -
> -@c man begin SEEALSO
> -The HTML documentation of QEMU for more precise information and Linux
> -user mode emulator invocation.
> -@c man end
> -
> -@c man begin AUTHOR
> -Daniel P. Berrange
> -@c man end
> -
> -@end ignore


--=20
Alex Benn=C3=A9e

