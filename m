Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8498DC34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:25:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 463B120836
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:25:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PPaRfg/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 463B120836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50338 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3l5C-0002Z3-Gb
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:25:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45380)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1j3l4H-0001XZ-7o
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:24:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1j3l4E-0005tH-Pi
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:24:28 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1j3l4E-0005sR-LA
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:24:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581963865;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uVJjsfIr2c5gRiCAbfvFGBUbypqM7ujb7TaF0DpianY=;
 b=PPaRfg/bg3I4OCZhzHmijO+pyGQvTS6bC7ebRlxPFY/Bk+W44RCi/OP1cNQ51KXqt+y72i
 vNXhzXcm13Ofix0/pinOrpgjtxSolzyl4BuKPyz3xvYWh9ItrSSzgsgv8O+wBnFJgiTRKg
 gQz8iHI/3O5whDlXwDeMfwpBxye2VFc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-m8pPkyPjPo6FwvcW6ewqpw-1; Mon, 17 Feb 2020 13:24:21 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4E83800D50;
 Mon, 17 Feb 2020 18:24:20 +0000 (UTC)
Received: from work-vm (ovpn-116-78.ams2.redhat.com [10.36.116.78])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D04F19C69;
 Mon, 17 Feb 2020 18:24:16 +0000 (UTC)
Date: Mon, 17 Feb 2020 18:24:14 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 3/3] docs: Move tools documentation to tools manual
Message-ID: <20200217182414.GC3434@work-vm>
References: <20200217155415.30949-1-peter.maydell@linaro.org>
 <20200217155415.30949-4-peter.maydell@linaro.org>
MIME-Version: 1.0
In-Reply-To: <20200217155415.30949-4-peter.maydell@linaro.org>
User-Agent: Mutt/1.13.3 (2020-01-12)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: m8pPkyPjPo6FwvcW6ewqpw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Peter Maydell (peter.maydell@linaro.org) wrote:
> Move the following tools documentation files to the new tools manual:
>=20
>  docs/interop/qemu-img.rst
>  docs/interop/qemu-nbd.rst
>  docs/interop/virtfs-proxy-helper.rst
>  docs/interop/qemu-trace-stap.rst
>  docs/interop/virtiofsd.rst
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Would docs/tools be the right place for the virtiofsd security guide
(as previously posted there)?  It's not actually a manpage.

Dave
> ---
>  Makefile                                      | 34 ++++++++++---------
>  docs/interop/conf.py                          | 12 -------
>  docs/interop/index.rst                        |  5 ---
>  docs/tools/conf.py                            | 17 ++++++++++
>  docs/tools/index.rst                          |  6 ++++
>  docs/{interop =3D> tools}/qemu-img.rst          |  0
>  docs/{interop =3D> tools}/qemu-nbd.rst          |  0
>  docs/{interop =3D> tools}/qemu-trace-stap.rst   |  0
>  .../virtfs-proxy-helper.rst                   |  0
>  docs/{interop =3D> tools}/virtiofsd.rst         |  0
>  10 files changed, 41 insertions(+), 33 deletions(-)
>  rename docs/{interop =3D> tools}/qemu-img.rst (100%)
>  rename docs/{interop =3D> tools}/qemu-nbd.rst (100%)
>  rename docs/{interop =3D> tools}/qemu-trace-stap.rst (100%)
>  rename docs/{interop =3D> tools}/virtfs-proxy-helper.rst (100%)
>  rename docs/{interop =3D> tools}/virtiofsd.rst (100%)
>=20
> diff --git a/Makefile b/Makefile
> index 886d4299d54..7a9c682a2c0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -345,11 +345,11 @@ endif
> =20
>  ifdef BUILD_DOCS
>  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
> -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
> -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
> +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-img.1
> +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
>  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
>  ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1
> +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtiofsd.1
>  endif
>  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
>  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt doc=
s/interop/qemu-qmp-ref.7
> @@ -357,10 +357,10 @@ DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/interop/=
qemu-ga-ref.txt docs/interop/qe
>  DOCS+=3Ddocs/qemu-cpu-models.7
>  DOCS+=3D$(MANUAL_BUILDDIR)/index.html
>  ifdef CONFIG_VIRTFS
> -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
> +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
>  endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
> -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
> +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1
>  endif
>  else
>  DOCS=3D
> @@ -848,12 +848,12 @@ ifdef CONFIG_POSIX
>  =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7 "$(DES=
TDIR)$(mandir)/man7"
>  =09$(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
>  ifeq ($(CONFIG_TOOLS),y)
> -=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1 "$(DESTDIR)$(ma=
ndir)/man1"
> +=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1 "$(DESTDIR)$(mand=
ir)/man1"
>  =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
> -=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8 "$(DESTDIR)$(ma=
ndir)/man8"
> +=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-nbd.8 "$(DESTDIR)$(mand=
ir)/man8"
>  endif
>  ifdef CONFIG_TRACE_SYSTEMTAP
> -=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1 "$(DESTD=
IR)$(mandir)/man1"
> +=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1 "$(DESTDIR=
)$(mandir)/man1"
>  endif
>  ifneq (,$(findstring qemu-ga,$(TOOLS)))
>  =09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8 "$(DESTDIR)$(man=
dir)/man8"
> @@ -864,10 +864,10 @@ endif
>  endif
>  ifdef CONFIG_VIRTFS
>  =09$(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
> -=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1 "$(D=
ESTDIR)$(mandir)/man1"
> +=09$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1 "$(DES=
TDIR)$(mandir)/man1"
>  endif
>  ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> -=09$(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
> +=09$(INSTALL_DATA) docs/tools/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
>  endif
> =20
>  install-datadir:
> @@ -1049,7 +1049,7 @@ endef
>  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
>  =09$(call build-manual,devel,html)
> =20
> -$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(SRC=
_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
> +$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
>  =09$(call build-manual,interop,html)
> =20
>  $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
> @@ -1058,16 +1058,18 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call manua=
l-deps,specs)
>  $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
>  =09$(call build-manual,system,html)
> =20
> -$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
> +$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_PAT=
H)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
>  =09$(call build-manual,tools,html)
> =20
> -$(call define-manpage-rule,interop,\
> -       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> -       virtiofsd.1 virtfs-proxy-helper.1,\
> -       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.r=
st.inc)
> +$(call define-manpage-rule,interop,qemu-ga.8)
> =20
>  $(call define-manpage-rule,system,qemu-block-drivers.7)
> =20
> +$(call define-manpage-rule,tools,\
> +       qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> +       virtiofsd.1 virtfs-proxy-helper.1,\
> +       $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.r=
st.inc)
> +
>  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in qemu-versi=
on.h
>  =09@mkdir -p "$(MANUAL_BUILDDIR)"
>  =09$(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
> diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> index b3cda17042c..42ce7e3d365 100644
> --- a/docs/interop/conf.py
> +++ b/docs/interop/conf.py
> @@ -19,16 +19,4 @@ html_theme_options['description'] =3D u'System Emulati=
on Management and Interopera
>  man_pages =3D [
>      ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
>       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
> -    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
> -     ['Fabrice Bellard'], 1),
> -    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
> -     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
> -    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
> -     [], 1),
> -    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> -     u'QEMU 9p virtfs proxy filesystem helper',
> -     ['M. Mohan Kumar'], 1),
> -    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemo=
n',
> -     ['Stefan Hajnoczi <stefanha@redhat.com>',
> -      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
>  ]
> diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> index e8455b4270c..049387ac6de 100644
> --- a/docs/interop/index.rst
> +++ b/docs/interop/index.rst
> @@ -18,10 +18,5 @@ Contents:
>     live-block-operations
>     pr-helper
>     qemu-ga
> -   qemu-img
> -   qemu-nbd
> -   qemu-trace-stap
>     vhost-user
>     vhost-user-gpu
> -   virtfs-proxy-helper
> -   virtiofsd
> diff --git a/docs/tools/conf.py b/docs/tools/conf.py
> index 56461110b9d..9052d17d6d4 100644
> --- a/docs/tools/conf.py
> +++ b/docs/tools/conf.py
> @@ -14,3 +14,20 @@ exec(compile(open(parent_config, "rb").read(), parent_=
config, 'exec'))
>  # the manual title to appear in the sidebar.
>  html_theme_options['description'] =3D \
>      u'Tools Guide'
> +
> +# One entry per manual page. List of tuples
> +# (source start file, name, description, authors, manual section).
> +man_pages =3D [
> +    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
> +     ['Fabrice Bellard'], 1),
> +    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
> +     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
> +    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool',
> +     [], 1),
> +    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> +     u'QEMU 9p virtfs proxy filesystem helper',
> +     ['M. Mohan Kumar'], 1),
> +    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system daemo=
n',
> +     ['Stefan Hajnoczi <stefanha@redhat.com>',
> +      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
> +]
> diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> index c5a4a13ec7a..232ce9f3e46 100644
> --- a/docs/tools/index.rst
> +++ b/docs/tools/index.rst
> @@ -9,3 +9,9 @@ Contents:
> =20
>  .. toctree::
>     :maxdepth: 2
> +
> +   qemu-img
> +   qemu-nbd
> +   qemu-trace-stap
> +   virtfs-proxy-helper
> +   virtiofsd
> diff --git a/docs/interop/qemu-img.rst b/docs/tools/qemu-img.rst
> similarity index 100%
> rename from docs/interop/qemu-img.rst
> rename to docs/tools/qemu-img.rst
> diff --git a/docs/interop/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
> similarity index 100%
> rename from docs/interop/qemu-nbd.rst
> rename to docs/tools/qemu-nbd.rst
> diff --git a/docs/interop/qemu-trace-stap.rst b/docs/tools/qemu-trace-sta=
p.rst
> similarity index 100%
> rename from docs/interop/qemu-trace-stap.rst
> rename to docs/tools/qemu-trace-stap.rst
> diff --git a/docs/interop/virtfs-proxy-helper.rst b/docs/tools/virtfs-pro=
xy-helper.rst
> similarity index 100%
> rename from docs/interop/virtfs-proxy-helper.rst
> rename to docs/tools/virtfs-proxy-helper.rst
> diff --git a/docs/interop/virtiofsd.rst b/docs/tools/virtiofsd.rst
> similarity index 100%
> rename from docs/interop/virtiofsd.rst
> rename to docs/tools/virtiofsd.rst
> --=20
> 2.20.1
>=20
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK


