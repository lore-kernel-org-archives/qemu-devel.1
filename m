Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2CA3C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:59:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69BF720775
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 07:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q8Dvt8RV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69BF720775
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDk9R-0005qa-J6
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 03:59:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45426)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDk8r-0005Rl-Do
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:58:45 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:39555
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kDk8o-0005OL-0B
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 03:58:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599119920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uMQQqJzY3MMoJDOH02wnz0FOc0BBDd/jrPa1nRkAiPg=;
 b=Q8Dvt8RVKTedjKW9RQnsZml7iC1y+3IMKKm1FpTz2nbt8YWvwkKohiYkI3E8rPTr2aakKN
 13M0eY+yM0/LLE92GCM3EYYpMupYxsss3fqykergzZPHghYwqmSdp1zrHZnohAkkDAT8Bs
 NM6b6edpDWnXH2XNCzbdqu7jiSnrONA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-550-9Hh5qOtnP-m4YVc-Taid4g-1; Thu, 03 Sep 2020 03:58:24 -0400
X-MC-Unique: 9Hh5qOtnP-m4YVc-Taid4g-1
Received: by mail-ed1-f72.google.com with SMTP id y1so924684edw.16
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 00:58:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uMQQqJzY3MMoJDOH02wnz0FOc0BBDd/jrPa1nRkAiPg=;
 b=ZDBcChvSBes92jnjjS5dvd6z96EJi4/ooe8UET/1XW98sBa5nyV+Aho2yOMJazikkj
 1Zxf81D/3tHCQLbxcWYnHjy9Ab4V37afSokoxz4elZgki2MbPW4bT5ZIzt+Vj7jOpvjq
 z8Z7gRwL3TfKwImzQXkWZw627RS9/eE6wTznZRXKYQG6GeYEB+61irkTRwSJHa0OPoG3
 ju9GelaQs47k5Uli+hysVDqoB6Jbgg5uqmL3hfavurN499p/hVtv+E3MRSfPMbpxsrwx
 6PDFqGUzgkJHA7ha2Mqn1IQTcpMeRFXv9nhpGJjJ5XyHOOvCBNpELe61GSX3562sN3cU
 DU0g==
X-Gm-Message-State: AOAM530iHh2MS57AfygPK2j51AwaZBs5QbhqJnl0O7qlijYjUY4ewtzR
 sEt9hdFsnEIVBB+9DEjlGrztCwfg6HMkAyXhAcK/eBNGfjA8nrNAnHU5tFBiTIVW/eNJ5kED/sD
 6+yG8mV7VKPmT8iAaErdzoBPZbZy18cg=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr877921ejk.449.1599119903511; 
 Thu, 03 Sep 2020 00:58:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyhl2zGZ0dxBYSgHaM4BeG+RpNCKzEzDUgHwbuFZN77WT1bp+wIvTP8X9r14vh3h/sDX5wVXVwo/jBDzupzv/k=
X-Received: by 2002:a17:906:5046:: with SMTP id
 e6mr877911ejk.449.1599119903324; 
 Thu, 03 Sep 2020 00:58:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200903074313.1498-1-luoyonggang@gmail.com>
In-Reply-To: <20200903074313.1498-1-luoyonggang@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 3 Sep 2020 09:58:11 +0200
Message-ID: <CABgObfaR7nO2b2ndhDoc9rEFRbVU5mT0ozzgFzKA3fx7Xrw2_g@mail.gmail.com>
Subject: Re: [PATCH v3 00/12] Green the msys2 CI make
To: Yonggang Luo <luoyonggang@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="000000000000ca8cc005ae641de9"
Received-SPF: pass client-ip=205.139.110.120; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000ca8cc005ae641de9
Content-Type: text/plain; charset="UTF-8"

Please send patches more slowly. You already have several queued, and
resending them only adds confusion.

Paolo

Il gio 3 set 2020, 09:43 Yonggang Luo <luoyonggang@gmail.com> ha scritto:

> Also it's fixes issues about make check
>
> Yonggang Luo (12):
>   configure: fixes dtc not cloned when running msys2 CI
>   meson: Convert undefsym.sh to undefsym.py
>   tcg: Fixes dup_const link error
>   tests: handling signal on win32 properly
>   configure: Fix include and linkage issue on msys2
>   block: Fixes nfs on msys2/mingw
>   osdep: These function are only available on Non-Win32 system.
>   ci: fixes msys2 build by upgrading capstone to 4.0.2
>   stubs: qemu_notify_event have no need to stub
>   meson: Fixes qapi tests.
>   tests: Disable test-image-locking that not works under Win32
>   ci: Enable msys2 ci in cirrus
>
>  .cirrus.yml                         |   108 +-
>  block/nfs.c                         |  1812 +--
>  capstone                            |     2 +-
>  configure                           | 16560 +++++++++++++-------------
>  include/qemu/osdep.h                |  1372 +--
>  include/tcg/tcg.h                   |  2898 ++---
>  meson.build                         |  2994 ++---
>  scripts/ci/windows/msys2_build.sh   |    33 +
>  scripts/ci/windows/msys2_install.sh |    31 +
>  scripts/undefsym.py                 |    57 +
>  scripts/undefsym.sh                 |    20 -
>  stubs/notify-event.c                |     8 +-
>  tcg/tcg-op-gvec.c                   |  7012 +++++------
>  tests/Makefile.include              |  1086 +-
>  tests/qapi-schema/meson.build       |   451 +-
>  tests/test-replication.c            |  1214 +-
>  16 files changed, 17904 insertions(+), 17754 deletions(-)
>  create mode 100644 scripts/ci/windows/msys2_build.sh
>  create mode 100644 scripts/ci/windows/msys2_install.sh
>  create mode 100644 scripts/undefsym.py
>  delete mode 100755 scripts/undefsym.sh
>
> --
> 2.28.0.windows.1
>
>
>

--000000000000ca8cc005ae641de9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Please send patches more slowly. You already have several=
 queued, and resending them only adds confusion.<div dir=3D"auto"><br></div=
><div dir=3D"auto">Paolo</div></div><br><div class=3D"gmail_quote"><div dir=
=3D"ltr" class=3D"gmail_attr">Il gio 3 set 2020, 09:43 Yonggang Luo &lt;<a =
href=3D"mailto:luoyonggang@gmail.com">luoyonggang@gmail.com</a>&gt; ha scri=
tto:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex">Also it&#39;s fixes issues abo=
ut make check<br>
<br>
Yonggang Luo (12):<br>
=C2=A0 configure: fixes dtc not cloned when running msys2 CI<br>
=C2=A0 meson: Convert undefsym.sh to undefsym.py<br>
=C2=A0 tcg: Fixes dup_const link error<br>
=C2=A0 tests: handling signal on win32 properly<br>
=C2=A0 configure: Fix include and linkage issue on msys2<br>
=C2=A0 block: Fixes nfs on msys2/mingw<br>
=C2=A0 osdep: These function are only available on Non-Win32 system.<br>
=C2=A0 ci: fixes msys2 build by upgrading capstone to 4.0.2<br>
=C2=A0 stubs: qemu_notify_event have no need to stub<br>
=C2=A0 meson: Fixes qapi tests.<br>
=C2=A0 tests: Disable test-image-locking that not works under Win32<br>
=C2=A0 ci: Enable msys2 ci in cirrus<br>
<br>
=C2=A0.cirrus.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0108 +-<br>
=C2=A0block/nfs.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1812 +--<br>
=C2=A0capstone=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 16560 +++++++++++++-------------<br=
>
=C2=A0include/qemu/osdep.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 1372 +--<br>
=C2=A0include/tcg/tcg.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 2898 ++---<br>
=C2=A0meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2994 ++---<br>
=C2=A0scripts/ci/windows/msys2_build.sh=C2=A0 =C2=A0|=C2=A0 =C2=A0 33 +<br>
=C2=A0scripts/ci/windows/msys2_install.sh |=C2=A0 =C2=A0 31 +<br>
=C2=A0scripts/undefsym.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 57 +<br>
=C2=A0scripts/undefsym.sh=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 20 -<br>
=C2=A0stubs/notify-event.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A08 +-<br>
=C2=A0tcg/tcg-op-gvec.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 7012 +++++------<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 1086 +-<br>
=C2=A0tests/qapi-schema/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0451 +-<br>
=C2=A0tests/test-replication.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 1214 +-<br>
=C2=A016 files changed, 17904 insertions(+), 17754 deletions(-)<br>
=C2=A0create mode 100644 scripts/ci/windows/msys2_build.sh<br>
=C2=A0create mode 100644 scripts/ci/windows/msys2_install.sh<br>
=C2=A0create mode 100644 scripts/undefsym.py<br>
=C2=A0delete mode 100755 scripts/undefsym.sh<br>
<br>
-- <br>
2.28.0.windows.1<br>
<br>
<br>
</blockquote></div>

--000000000000ca8cc005ae641de9--


