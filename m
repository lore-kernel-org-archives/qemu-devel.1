Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B86C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:43:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75563222D9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:43:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHR6n0UV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75563222D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50724 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lMU-0002U1-JN
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48385)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1j3lL8-0000XG-TZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:41:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1j3lL5-00088f-Fz
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:41:54 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52314
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1j3lL5-00087w-8e
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581964910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=w6cz8juDY0PPw/DwRcXzpU59WvcPn6IWAQCyJRzWA6c=;
 b=AHR6n0UVcf4qvknXcugavrr9OayFgU7YRfMNhIKpECcFWFt2p7BCkoY7Cl5EMbWsCRbEXt
 UE8tEChqLpSuJ6h9PfxeDj0xlR7g2tOOBNY+tdLClwnBIZPpaACPTUSJesMiXgNmVGFoD8
 AdEa+JYNuhSjB8gOu1nCdknxHUAhZ3o=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-z-VDjEi4P5yPRR_tPv6oyg-1; Mon, 17 Feb 2020 13:41:42 -0500
Received: by mail-ed1-f69.google.com with SMTP id ck15so13779759edb.6
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:41:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=i3wb/mJwSqcFpCLcSqFbCya7EFz9hdeGLJvMrp2uk28=;
 b=MzYztWVk9L0hR1XI6BPrEFb6Z86QbbIAexUOH3q+LKRIKTxIo+0DVre0YFDHMmJqv2
 wAgVMfQKNulKxL+slIS1wTNCookNOmPbb0KHqt29oYl5ahIRvizXngfY65hmRMl3HF/B
 KEvLMHvVGMxuSCbKb0/N9JNIJmyNj2GIiQSyw/dCkdCReO5ci7bMvB1q+hNTbJtSrvSd
 lE5EeriWTKVu6+Ou7uEUtdvR4pszoWwbD4l/2n3HAhIUT+LxhfK84nIcZj7E0xTtRX4+
 5Tq3eR85ZZAYKYCBcgUXdHj0LqXOt/WuK/C1SiMLM2CyppdKutP4/kmshikyxAMhHKb5
 JXiw==
X-Gm-Message-State: APjAAAUjTDIcWrjM1sBhZS74P4+/awVQmIB45cljkdPMuwslc8wIrxZF
 82prL74yjahQSh7SGCXhgCWSiXrOTNqPaISCVQsKOU+w8+1fQ9+eOWNVewmZGgwxqidCzVT9By5
 7htoXrbb+yoZW4SEbib826yp7fFaQNBA=
X-Received: by 2002:a17:906:6858:: with SMTP id
 a24mr16146760ejs.366.1581964901069; 
 Mon, 17 Feb 2020 10:41:41 -0800 (PST)
X-Google-Smtp-Source: APXvYqwVvEKZ0ofVoRcQ8pjNKFZXDxBoID2BsUb4ag62WduKQVDt/nlbzmjhX4nzZJSz0GvT5kI6kZhYwYP1IBwvHcY=
X-Received: by 2002:a17:906:6858:: with SMTP id
 a24mr16146739ejs.366.1581964900747; 
 Mon, 17 Feb 2020 10:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20200217155415.30949-1-peter.maydell@linaro.org>
 <20200217155415.30949-4-peter.maydell@linaro.org>
 <20200217182414.GC3434@work-vm>
In-Reply-To: <20200217182414.GC3434@work-vm>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 17 Feb 2020 19:41:28 +0100
Message-ID: <CABgObfZA3faNxun6_LBdeAZochnoYyaJmansWuXLpTNpdmSX8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] docs: Move tools documentation to tools manual
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
X-MC-Unique: z-VDjEi4P5yPRR_tPv6oyg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000f4e97c059ec9e7ee"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f4e97c059ec9e7ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Il lun 17 feb 2020, 19:24 Dr. David Alan Gilbert <dgilbert@redhat.com> ha
scritto:

> * Peter Maydell (peter.maydell@linaro.org) wrote:
> > Move the following tools documentation files to the new tools manual:
> >
> >  docs/interop/qemu-img.rst
> >  docs/interop/qemu-nbd.rst
> >  docs/interop/virtfs-proxy-helper.rst
> >  docs/interop/qemu-trace-stap.rst
> >  docs/interop/virtiofsd.rst
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>
> Would docs/tools be the right place for the virtiofsd security guide
> (as previously posted there)?  It's not actually a manpage.
>

Yes, I think it would.

Paolo


> Dave
> > ---
> >  Makefile                                      | 34 ++++++++++---------
> >  docs/interop/conf.py                          | 12 -------
> >  docs/interop/index.rst                        |  5 ---
> >  docs/tools/conf.py                            | 17 ++++++++++
> >  docs/tools/index.rst                          |  6 ++++
> >  docs/{interop =3D> tools}/qemu-img.rst          |  0
> >  docs/{interop =3D> tools}/qemu-nbd.rst          |  0
> >  docs/{interop =3D> tools}/qemu-trace-stap.rst   |  0
> >  .../virtfs-proxy-helper.rst                   |  0
> >  docs/{interop =3D> tools}/virtiofsd.rst         |  0
> >  10 files changed, 41 insertions(+), 33 deletions(-)
> >  rename docs/{interop =3D> tools}/qemu-img.rst (100%)
> >  rename docs/{interop =3D> tools}/qemu-nbd.rst (100%)
> >  rename docs/{interop =3D> tools}/qemu-trace-stap.rst (100%)
> >  rename docs/{interop =3D> tools}/virtfs-proxy-helper.rst (100%)
> >  rename docs/{interop =3D> tools}/virtiofsd.rst (100%)
> >
> > diff --git a/Makefile b/Makefile
> > index 886d4299d54..7a9c682a2c0 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -345,11 +345,11 @@ endif
> >
> >  ifdef BUILD_DOCS
> >  DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1
> > -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1
> > -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8
> > +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-img.1
> > +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-nbd.8
> >  DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8
> >  ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> > -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1
> > +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtiofsd.1
> >  endif
> >  DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
> >  DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref.txt
> docs/interop/qemu-qmp-ref.7
> > @@ -357,10 +357,10 @@ DOCS+=3Ddocs/interop/qemu-ga-ref.html
> docs/interop/qemu-ga-ref.txt docs/interop/qe
> >  DOCS+=3Ddocs/qemu-cpu-models.7
> >  DOCS+=3D$(MANUAL_BUILDDIR)/index.html
> >  ifdef CONFIG_VIRTFS
> > -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
> > +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
> >  endif
> >  ifdef CONFIG_TRACE_SYSTEMTAP
> > -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
> > +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1
> >  endif
> >  else
> >  DOCS=3D
> > @@ -848,12 +848,12 @@ ifdef CONFIG_POSIX
> >       $(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qemu-block-drivers.7
> "$(DESTDIR)$(mandir)/man7"
> >       $(INSTALL_DATA) docs/qemu-cpu-models.7 "$(DESTDIR)$(mandir)/man7"
> >  ifeq ($(CONFIG_TOOLS),y)
> > -     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-img.1
> "$(DESTDIR)$(mandir)/man1"
> > +     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img.1
> "$(DESTDIR)$(mandir)/man1"
> >       $(INSTALL_DIR) "$(DESTDIR)$(mandir)/man8"
> > -     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-nbd.8
> "$(DESTDIR)$(mandir)/man8"
> > +     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-nbd.8
> "$(DESTDIR)$(mandir)/man8"
> >  endif
> >  ifdef CONFIG_TRACE_SYSTEMTAP
> > -     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1
> "$(DESTDIR)$(mandir)/man1"
> > +     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1
> "$(DESTDIR)$(mandir)/man1"
> >  endif
> >  ifneq (,$(findstring qemu-ga,$(TOOLS)))
> >       $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-ga.8
> "$(DESTDIR)$(mandir)/man8"
> > @@ -864,10 +864,10 @@ endif
> >  endif
> >  ifdef CONFIG_VIRTFS
> >       $(INSTALL_DIR) "$(DESTDIR)$(mandir)/man1"
> > -     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1
> "$(DESTDIR)$(mandir)/man1"
> > +     $(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1
> "$(DESTDIR)$(mandir)/man1"
> >  endif
> >  ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)
> > -     $(INSTALL_DATA) docs/interop/virtiofsd.1 "$(DESTDIR)$(mandir)/man=
1"
> > +     $(INSTALL_DATA) docs/tools/virtiofsd.1 "$(DESTDIR)$(mandir)/man1"
> >  endif
> >
> >  install-datadir:
> > @@ -1049,7 +1049,7 @@ endef
> >  $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)
> >       $(call build-manual,devel,html)
> >
> > -$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
> $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
> > +$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
> >       $(call build-manual,interop,html)
> >
> >  $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
> > @@ -1058,16 +1058,18 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call
> manual-deps,specs)
> >  $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)
> >       $(call build-manual,system,html)
> >
> > -$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
> > +$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)
> $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc
> >       $(call build-manual,tools,html)
> >
> > -$(call define-manpage-rule,interop,\
> > -       qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> > -       virtiofsd.1 virtfs-proxy-helper.1,\
> > -       $(SRC_PATH)/qemu-img-cmds.hx
> $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
> > +$(call define-manpage-rule,interop,qemu-ga.8)
> >
> >  $(call define-manpage-rule,system,qemu-block-drivers.7)
> >
> > +$(call define-manpage-rule,tools,\
> > +       qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\
> > +       virtiofsd.1 virtfs-proxy-helper.1,\
> > +       $(SRC_PATH)/qemu-img-cmds.hx
> $(SRC_PATH)/docs/qemu-option-trace.rst.inc)
> > +
> >  $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/index.html.in
> qemu-version.h
> >       @mkdir -p "$(MANUAL_BUILDDIR)"
> >       $(call quiet-command, sed "s|@@VERSION@@|${VERSION}|g" $< >$@, \
> > diff --git a/docs/interop/conf.py b/docs/interop/conf.py
> > index b3cda17042c..42ce7e3d365 100644
> > --- a/docs/interop/conf.py
> > +++ b/docs/interop/conf.py
> > @@ -19,16 +19,4 @@ html_theme_options['description'] =3D u'System
> Emulation Management and Interopera
> >  man_pages =3D [
> >      ('qemu-ga', 'qemu-ga', u'QEMU Guest Agent',
> >       ['Michael Roth <mdroth@linux.vnet.ibm.com>'], 8),
> > -    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
> > -     ['Fabrice Bellard'], 1),
> > -    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
> > -     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
> > -    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool=
',
> > -     [], 1),
> > -    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> > -     u'QEMU 9p virtfs proxy filesystem helper',
> > -     ['M. Mohan Kumar'], 1),
> > -    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system
> daemon',
> > -     ['Stefan Hajnoczi <stefanha@redhat.com>',
> > -      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
> >  ]
> > diff --git a/docs/interop/index.rst b/docs/interop/index.rst
> > index e8455b4270c..049387ac6de 100644
> > --- a/docs/interop/index.rst
> > +++ b/docs/interop/index.rst
> > @@ -18,10 +18,5 @@ Contents:
> >     live-block-operations
> >     pr-helper
> >     qemu-ga
> > -   qemu-img
> > -   qemu-nbd
> > -   qemu-trace-stap
> >     vhost-user
> >     vhost-user-gpu
> > -   virtfs-proxy-helper
> > -   virtiofsd
> > diff --git a/docs/tools/conf.py b/docs/tools/conf.py
> > index 56461110b9d..9052d17d6d4 100644
> > --- a/docs/tools/conf.py
> > +++ b/docs/tools/conf.py
> > @@ -14,3 +14,20 @@ exec(compile(open(parent_config, "rb").read(),
> parent_config, 'exec'))
> >  # the manual title to appear in the sidebar.
> >  html_theme_options['description'] =3D \
> >      u'Tools Guide'
> > +
> > +# One entry per manual page. List of tuples
> > +# (source start file, name, description, authors, manual section).
> > +man_pages =3D [
> > +    ('qemu-img', 'qemu-img', u'QEMU disk image utility',
> > +     ['Fabrice Bellard'], 1),
> > +    ('qemu-nbd', 'qemu-nbd', u'QEMU Disk Network Block Device Server',
> > +     ['Anthony Liguori <anthony@codemonkey.ws>'], 8),
> > +    ('qemu-trace-stap', 'qemu-trace-stap', u'QEMU SystemTap trace tool=
',
> > +     [], 1),
> > +    ('virtfs-proxy-helper', 'virtfs-proxy-helper',
> > +     u'QEMU 9p virtfs proxy filesystem helper',
> > +     ['M. Mohan Kumar'], 1),
> > +    ('virtiofsd', 'virtiofsd', u'QEMU virtio-fs shared file system
> daemon',
> > +     ['Stefan Hajnoczi <stefanha@redhat.com>',
> > +      'Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>'], 1),
> > +]
> > diff --git a/docs/tools/index.rst b/docs/tools/index.rst
> > index c5a4a13ec7a..232ce9f3e46 100644
> > --- a/docs/tools/index.rst
> > +++ b/docs/tools/index.rst
> > @@ -9,3 +9,9 @@ Contents:
> >
> >  .. toctree::
> >     :maxdepth: 2
> > +
> > +   qemu-img
> > +   qemu-nbd
> > +   qemu-trace-stap
> > +   virtfs-proxy-helper
> > +   virtiofsd
> > diff --git a/docs/interop/qemu-img.rst b/docs/tools/qemu-img.rst
> > similarity index 100%
> > rename from docs/interop/qemu-img.rst
> > rename to docs/tools/qemu-img.rst
> > diff --git a/docs/interop/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
> > similarity index 100%
> > rename from docs/interop/qemu-nbd.rst
> > rename to docs/tools/qemu-nbd.rst
> > diff --git a/docs/interop/qemu-trace-stap.rst
> b/docs/tools/qemu-trace-stap.rst
> > similarity index 100%
> > rename from docs/interop/qemu-trace-stap.rst
> > rename to docs/tools/qemu-trace-stap.rst
> > diff --git a/docs/interop/virtfs-proxy-helper.rst
> b/docs/tools/virtfs-proxy-helper.rst
> > similarity index 100%
> > rename from docs/interop/virtfs-proxy-helper.rst
> > rename to docs/tools/virtfs-proxy-helper.rst
> > diff --git a/docs/interop/virtiofsd.rst b/docs/tools/virtiofsd.rst
> > similarity index 100%
> > rename from docs/interop/virtiofsd.rst
> > rename to docs/tools/virtiofsd.rst
> > --
> > 2.20.1
> >
> --
> Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
>
>

--000000000000f4e97c059ec9e7ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote"><div dir=3D"ltr" =
class=3D"gmail_attr">Il lun 17 feb 2020, 19:24 Dr. David Alan Gilbert &lt;<=
a href=3D"mailto:dgilbert@redhat.com">dgilbert@redhat.com</a>&gt; ha scritt=
o:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex">* Peter Maydell (<a href=3D"mail=
to:peter.maydell@linaro.org" target=3D"_blank" rel=3D"noreferrer">peter.may=
dell@linaro.org</a>) wrote:<br>
&gt; Move the following tools documentation files to the new tools manual:<=
br>
&gt; <br>
&gt;=C2=A0 docs/interop/qemu-img.rst<br>
&gt;=C2=A0 docs/interop/qemu-nbd.rst<br>
&gt;=C2=A0 docs/interop/virtfs-proxy-helper.rst<br>
&gt;=C2=A0 docs/interop/qemu-trace-stap.rst<br>
&gt;=C2=A0 docs/interop/virtiofsd.rst<br>
&gt; <br>
&gt; Signed-off-by: Peter Maydell &lt;<a href=3D"mailto:peter.maydell@linar=
o.org" target=3D"_blank" rel=3D"noreferrer">peter.maydell@linaro.org</a>&gt=
;<br>
<br>
Would docs/tools be the right place for the virtiofsd security guide<br>
(as previously posted there)?=C2=A0 It&#39;s not actually a manpage.<br></b=
lockquote></div></div><div dir=3D"auto"><br></div><div dir=3D"auto">Yes, I =
think it would.</div><div dir=3D"auto"><br></div><div dir=3D"auto">Paolo</d=
iv><div dir=3D"auto"><br></div><div dir=3D"auto"><div class=3D"gmail_quote"=
><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1=
px #ccc solid;padding-left:1ex">
<br>
Dave<br>
&gt; ---<br>
&gt;=C2=A0 Makefile=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 | 34 ++++++++++---------<br>
&gt;=C2=A0 docs/interop/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 12 -------<br>
&gt;=C2=A0 docs/interop/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ---<br>
&gt;=C2=A0 docs/tools/conf.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 17 ++++++++++<br>
&gt;=C2=A0 docs/tools/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 ++++<br>
&gt;=C2=A0 docs/{interop =3D&gt; tools}/qemu-img.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 docs/{interop =3D&gt; tools}/qemu-nbd.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 0<br>
&gt;=C2=A0 docs/{interop =3D&gt; tools}/qemu-trace-stap.rst=C2=A0 =C2=A0|=
=C2=A0 0<br>
&gt;=C2=A0 .../virtfs-proxy-helper.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 docs/{interop =3D&gt; tools}/virtiofsd.rst=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 0<br>
&gt;=C2=A0 10 files changed, 41 insertions(+), 33 deletions(-)<br>
&gt;=C2=A0 rename docs/{interop =3D&gt; tools}/qemu-img.rst (100%)<br>
&gt;=C2=A0 rename docs/{interop =3D&gt; tools}/qemu-nbd.rst (100%)<br>
&gt;=C2=A0 rename docs/{interop =3D&gt; tools}/qemu-trace-stap.rst (100%)<b=
r>
&gt;=C2=A0 rename docs/{interop =3D&gt; tools}/virtfs-proxy-helper.rst (100=
%)<br>
&gt;=C2=A0 rename docs/{interop =3D&gt; tools}/virtiofsd.rst (100%)<br>
&gt; <br>
&gt; diff --git a/Makefile b/Makefile<br>
&gt; index 886d4299d54..7a9c682a2c0 100644<br>
&gt; --- a/Makefile<br>
&gt; +++ b/Makefile<br>
&gt; @@ -345,11 +345,11 @@ endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 ifdef BUILD_DOCS<br>
&gt;=C2=A0 DOCS=3Dqemu-doc.html qemu-doc.txt qemu.1<br>
&gt; -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-img.1<br>
&gt; -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-nbd.8<br>
&gt; +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-img.1<br>
&gt; +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-nbd.8<br>
&gt;=C2=A0 DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-ga.8<br>
&gt;=C2=A0 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)<b=
r>
&gt; -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtiofsd.1<br>
&gt; +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtiofsd.1<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 DOCS+=3D$(MANUAL_BUILDDIR)/system/qemu-block-drivers.7<br>
&gt;=C2=A0 DOCS+=3Ddocs/interop/qemu-qmp-ref.html docs/interop/qemu-qmp-ref=
.txt docs/interop/qemu-qmp-ref.7<br>
&gt; @@ -357,10 +357,10 @@ DOCS+=3Ddocs/interop/qemu-ga-ref.html docs/inter=
op/qemu-ga-ref.txt docs/interop/qe<br>
&gt;=C2=A0 DOCS+=3Ddocs/qemu-cpu-models.7<br>
&gt;=C2=A0 DOCS+=3D$(MANUAL_BUILDDIR)/index.html<br>
&gt;=C2=A0 ifdef CONFIG_VIRTFS<br>
&gt; -DOCS+=3D$(MANUAL_BUILDDIR)/interop/virtfs-proxy-helper.1<br>
&gt; +DOCS+=3D$(MANUAL_BUILDDIR)/tools/virtfs-proxy-helper.1<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 ifdef CONFIG_TRACE_SYSTEMTAP<br>
&gt; -DOCS+=3D$(MANUAL_BUILDDIR)/interop/qemu-trace-stap.1<br>
&gt; +DOCS+=3D$(MANUAL_BUILDDIR)/tools/qemu-trace-stap.1<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 else<br>
&gt;=C2=A0 DOCS=3D<br>
&gt; @@ -848,12 +848,12 @@ ifdef CONFIG_POSIX<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/system/qe=
mu-block-drivers.7 &quot;$(DESTDIR)$(mandir)/man7&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) docs/qemu-cpu-models.7 &quot=
;$(DESTDIR)$(mandir)/man7&quot;<br>
&gt;=C2=A0 ifeq ($(CONFIG_TOOLS),y)<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-i=
mg.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-img=
.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DIR) &quot;$(DESTDIR)$(mandir)/man=
8&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-n=
bd.8 &quot;$(DESTDIR)$(mandir)/man8&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-nbd=
.8 &quot;$(DESTDIR)$(mandir)/man8&quot;<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 ifdef CONFIG_TRACE_SYSTEMTAP<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/qemu-t=
race-stap.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/qemu-tra=
ce-stap.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 ifneq (,$(findstring qemu-ga,$(TOOLS)))<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/q=
emu-ga.8 &quot;$(DESTDIR)$(mandir)/man8&quot;<br>
&gt; @@ -864,10 +864,10 @@ endif<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 ifdef CONFIG_VIRTFS<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(INSTALL_DIR) &quot;$(DESTDIR)$(mandir)/man=
1&quot;<br>
&gt; -=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/interop/virtfs=
-proxy-helper.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) $(MANUAL_BUILDDIR)/tools/virtfs-p=
roxy-helper.1 &quot;$(DESTDIR)$(mandir)/man1&quot;<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 ifeq ($(CONFIG_LINUX)$(CONFIG_SECCOMP)$(CONFIG_LIBCAP_NG),yyy)<b=
r>
&gt; -=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) docs/interop/virtiofsd.1 &quot;$(=
DESTDIR)$(mandir)/man1&quot;<br>
&gt; +=C2=A0 =C2=A0 =C2=A0$(INSTALL_DATA) docs/tools/virtiofsd.1 &quot;$(DE=
STDIR)$(mandir)/man1&quot;<br>
&gt;=C2=A0 endif<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 install-datadir:<br>
&gt; @@ -1049,7 +1049,7 @@ endef<br>
&gt;=C2=A0 $(MANUAL_BUILDDIR)/devel/index.html: $(call manual-deps,devel)<b=
r>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call build-manual,devel,html)<br>
&gt;=C2=A0 <br>
&gt; -$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop) $(=
SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc<br>
&gt; +$(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)<br=
>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call build-manual,interop,html)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 $(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)<b=
r>
&gt; @@ -1058,16 +1058,18 @@ $(MANUAL_BUILDDIR)/specs/index.html: $(call ma=
nual-deps,specs)<br>
&gt;=C2=A0 $(MANUAL_BUILDDIR)/system/index.html: $(call manual-deps,system)=
<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call build-manual,system,html)<br>
&gt;=C2=A0 <br>
&gt; -$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools)<br>
&gt; +$(MANUAL_BUILDDIR)/tools/index.html: $(call manual-deps,tools) $(SRC_=
PATH)/qemu-img-cmds.hx $(SRC_PATH)/docs/qemu-option-trace.rst.inc<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call build-manual,tools,html)<br>
&gt;=C2=A0 <br>
&gt; -$(call define-manpage-rule,interop,\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-ga.8 qemu-img.1 qemu-nbd.8 qemu-trace=
-stap.1\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0virtiofsd.1 virtfs-proxy-helper.1,\<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0$(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/d=
ocs/qemu-option-trace.rst.inc)<br>
&gt; +$(call define-manpage-rule,interop,qemu-ga.8)<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 $(call define-manpage-rule,system,qemu-block-drivers.7)<br>
&gt;=C2=A0 <br>
&gt; +$(call define-manpage-rule,tools,\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0qemu-img.1 qemu-nbd.8 qemu-trace-stap.1\<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0virtiofsd.1 virtfs-proxy-helper.1,\<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0$(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/d=
ocs/qemu-option-trace.rst.inc)<br>
&gt; +<br>
&gt;=C2=A0 $(MANUAL_BUILDDIR)/index.html: $(SRC_PATH)/docs/<a href=3D"http:=
//index.html.in" rel=3D"noreferrer noreferrer" target=3D"_blank">index.html=
.in</a> qemu-version.h<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0@mkdir -p &quot;$(MANUAL_BUILDDIR)&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0$(call quiet-command, sed &quot;s|@@VERSION@=
@|${VERSION}|g&quot; $&lt; &gt;$@, \<br>
&gt; diff --git a/docs/interop/conf.py b/docs/interop/conf.py<br>
&gt; index b3cda17042c..42ce7e3d365 100644<br>
&gt; --- a/docs/interop/conf.py<br>
&gt; +++ b/docs/interop/conf.py<br>
&gt; @@ -19,16 +19,4 @@ html_theme_options[&#39;description&#39;] =3D u&#39=
;System Emulation Management and Interopera<br>
&gt;=C2=A0 man_pages =3D [<br>
&gt;=C2=A0 =C2=A0 =C2=A0 (&#39;qemu-ga&#39;, &#39;qemu-ga&#39;, u&#39;QEMU =
Guest Agent&#39;,<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0[&#39;Michael Roth &lt;<a href=3D"mailto:mdr=
oth@linux.vnet.ibm.com" target=3D"_blank" rel=3D"noreferrer">mdroth@linux.v=
net.ibm.com</a>&gt;&#39;], 8),<br>
&gt; -=C2=A0 =C2=A0 (&#39;qemu-img&#39;, &#39;qemu-img&#39;, u&#39;QEMU dis=
k image utility&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[&#39;Fabrice Bellard&#39;], 1),<br>
&gt; -=C2=A0 =C2=A0 (&#39;qemu-nbd&#39;, &#39;qemu-nbd&#39;, u&#39;QEMU Dis=
k Network Block Device Server&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[&#39;Anthony Liguori &lt;<a href=3D"mailto:antho=
ny@codemonkey.ws" target=3D"_blank" rel=3D"noreferrer">anthony@codemonkey.w=
s</a>&gt;&#39;], 8),<br>
&gt; -=C2=A0 =C2=A0 (&#39;qemu-trace-stap&#39;, &#39;qemu-trace-stap&#39;, =
u&#39;QEMU SystemTap trace tool&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[], 1),<br>
&gt; -=C2=A0 =C2=A0 (&#39;virtfs-proxy-helper&#39;, &#39;virtfs-proxy-helpe=
r&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0u&#39;QEMU 9p virtfs proxy filesystem helper&#39;=
,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[&#39;M. Mohan Kumar&#39;], 1),<br>
&gt; -=C2=A0 =C2=A0 (&#39;virtiofsd&#39;, &#39;virtiofsd&#39;, u&#39;QEMU v=
irtio-fs shared file system daemon&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0[&#39;Stefan Hajnoczi &lt;<a href=3D"mailto:stefa=
nha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a=
>&gt;&#39;,<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 &#39;Masayoshi Mizuma &lt;<a href=3D"mailto:m.mi=
zuma@jp.fujitsu.com" target=3D"_blank" rel=3D"noreferrer">m.mizuma@jp.fujit=
su.com</a>&gt;&#39;], 1),<br>
&gt;=C2=A0 ]<br>
&gt; diff --git a/docs/interop/index.rst b/docs/interop/index.rst<br>
&gt; index e8455b4270c..049387ac6de 100644<br>
&gt; --- a/docs/interop/index.rst<br>
&gt; +++ b/docs/interop/index.rst<br>
&gt; @@ -18,10 +18,5 @@ Contents:<br>
&gt;=C2=A0 =C2=A0 =C2=A0live-block-operations<br>
&gt;=C2=A0 =C2=A0 =C2=A0pr-helper<br>
&gt;=C2=A0 =C2=A0 =C2=A0qemu-ga<br>
&gt; -=C2=A0 =C2=A0qemu-img<br>
&gt; -=C2=A0 =C2=A0qemu-nbd<br>
&gt; -=C2=A0 =C2=A0qemu-trace-stap<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user<br>
&gt;=C2=A0 =C2=A0 =C2=A0vhost-user-gpu<br>
&gt; -=C2=A0 =C2=A0virtfs-proxy-helper<br>
&gt; -=C2=A0 =C2=A0virtiofsd<br>
&gt; diff --git a/docs/tools/conf.py b/docs/tools/conf.py<br>
&gt; index 56461110b9d..9052d17d6d4 100644<br>
&gt; --- a/docs/tools/conf.py<br>
&gt; +++ b/docs/tools/conf.py<br>
&gt; @@ -14,3 +14,20 @@ exec(compile(open(parent_config, &quot;rb&quot;).re=
ad(), parent_config, &#39;exec&#39;))<br>
&gt;=C2=A0 # the manual title to appear in the sidebar.<br>
&gt;=C2=A0 html_theme_options[&#39;description&#39;] =3D \<br>
&gt;=C2=A0 =C2=A0 =C2=A0 u&#39;Tools Guide&#39;<br>
&gt; +<br>
&gt; +# One entry per manual page. List of tuples<br>
&gt; +# (source start file, name, description, authors, manual section).<br=
>
&gt; +man_pages =3D [<br>
&gt; +=C2=A0 =C2=A0 (&#39;qemu-img&#39;, &#39;qemu-img&#39;, u&#39;QEMU dis=
k image utility&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[&#39;Fabrice Bellard&#39;], 1),<br>
&gt; +=C2=A0 =C2=A0 (&#39;qemu-nbd&#39;, &#39;qemu-nbd&#39;, u&#39;QEMU Dis=
k Network Block Device Server&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[&#39;Anthony Liguori &lt;<a href=3D"mailto:antho=
ny@codemonkey.ws" target=3D"_blank" rel=3D"noreferrer">anthony@codemonkey.w=
s</a>&gt;&#39;], 8),<br>
&gt; +=C2=A0 =C2=A0 (&#39;qemu-trace-stap&#39;, &#39;qemu-trace-stap&#39;, =
u&#39;QEMU SystemTap trace tool&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[], 1),<br>
&gt; +=C2=A0 =C2=A0 (&#39;virtfs-proxy-helper&#39;, &#39;virtfs-proxy-helpe=
r&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0u&#39;QEMU 9p virtfs proxy filesystem helper&#39;=
,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[&#39;M. Mohan Kumar&#39;], 1),<br>
&gt; +=C2=A0 =C2=A0 (&#39;virtiofsd&#39;, &#39;virtiofsd&#39;, u&#39;QEMU v=
irtio-fs shared file system daemon&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0[&#39;Stefan Hajnoczi &lt;<a href=3D"mailto:stefa=
nha@redhat.com" target=3D"_blank" rel=3D"noreferrer">stefanha@redhat.com</a=
>&gt;&#39;,<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 &#39;Masayoshi Mizuma &lt;<a href=3D"mailto:m.mi=
zuma@jp.fujitsu.com" target=3D"_blank" rel=3D"noreferrer">m.mizuma@jp.fujit=
su.com</a>&gt;&#39;], 1),<br>
&gt; +]<br>
&gt; diff --git a/docs/tools/index.rst b/docs/tools/index.rst<br>
&gt; index c5a4a13ec7a..232ce9f3e46 100644<br>
&gt; --- a/docs/tools/index.rst<br>
&gt; +++ b/docs/tools/index.rst<br>
&gt; @@ -9,3 +9,9 @@ Contents:<br>
&gt;=C2=A0 <br>
&gt;=C2=A0 .. toctree::<br>
&gt;=C2=A0 =C2=A0 =C2=A0:maxdepth: 2<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0qemu-img<br>
&gt; +=C2=A0 =C2=A0qemu-nbd<br>
&gt; +=C2=A0 =C2=A0qemu-trace-stap<br>
&gt; +=C2=A0 =C2=A0virtfs-proxy-helper<br>
&gt; +=C2=A0 =C2=A0virtiofsd<br>
&gt; diff --git a/docs/interop/qemu-img.rst b/docs/tools/qemu-img.rst<br>
&gt; similarity index 100%<br>
&gt; rename from docs/interop/qemu-img.rst<br>
&gt; rename to docs/tools/qemu-img.rst<br>
&gt; diff --git a/docs/interop/qemu-nbd.rst b/docs/tools/qemu-nbd.rst<br>
&gt; similarity index 100%<br>
&gt; rename from docs/interop/qemu-nbd.rst<br>
&gt; rename to docs/tools/qemu-nbd.rst<br>
&gt; diff --git a/docs/interop/qemu-trace-stap.rst b/docs/tools/qemu-trace-=
stap.rst<br>
&gt; similarity index 100%<br>
&gt; rename from docs/interop/qemu-trace-stap.rst<br>
&gt; rename to docs/tools/qemu-trace-stap.rst<br>
&gt; diff --git a/docs/interop/virtfs-proxy-helper.rst b/docs/tools/virtfs-=
proxy-helper.rst<br>
&gt; similarity index 100%<br>
&gt; rename from docs/interop/virtfs-proxy-helper.rst<br>
&gt; rename to docs/tools/virtfs-proxy-helper.rst<br>
&gt; diff --git a/docs/interop/virtiofsd.rst b/docs/tools/virtiofsd.rst<br>
&gt; similarity index 100%<br>
&gt; rename from docs/interop/virtiofsd.rst<br>
&gt; rename to docs/tools/virtiofsd.rst<br>
&gt; -- <br>
&gt; 2.20.1<br>
&gt; <br>
--<br>
Dr. David Alan Gilbert / <a href=3D"mailto:dgilbert@redhat.com" target=3D"_=
blank" rel=3D"noreferrer">dgilbert@redhat.com</a> / Manchester, UK<br>
<br>
</blockquote></div></div></div>

--000000000000f4e97c059ec9e7ee--


