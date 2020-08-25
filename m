Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E737C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3ADBA2065F
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 08:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ekzBbEY+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3ADBA2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kATsh-0001Kc-Fm
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 04:00:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATrk-0000GJ-6N
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:59:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30303)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kATri-00059m-IJ
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 03:59:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598342373;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=acDkiMr2Sfnu8cZbgIFbj9jAkTZ0AwjsAKbWJ3jU1is=;
 b=ekzBbEY+EwvZ8lfwP+Y8MohNOe0ULn5nG2t/zWXKIZGKsno2F0Q5Gm0UxDLvLcyNMj3elA
 ANImGLyzBRq9a3KbJRy6d3+OhFIBTm+MQ6HMDkZMss7FB/be+lO+OFfcyDG/pWrmb7/ZIR
 XHvUjaF7eT3HvicCC+veN4VKKGYgyJA=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-KCoxcbDyPZKyD1v9xb2CeA-1; Tue, 25 Aug 2020 03:59:31 -0400
X-MC-Unique: KCoxcbDyPZKyD1v9xb2CeA-1
Received: by mail-ej1-f72.google.com with SMTP id u13so5033226ejr.19
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 00:59:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=acDkiMr2Sfnu8cZbgIFbj9jAkTZ0AwjsAKbWJ3jU1is=;
 b=GV3Jqaf18iDFq2L3iZo5mfcD0Drd0iAIjFrJoNfxaNVb9ssgf/VWNFma1ZWI5TYWgW
 MTRvr9yEYMLGyqJZ8oadMnlCr9w2FSu4Na04pA2n605MbC2JXX6t6EA43KCtGWTXmg2I
 dJ3JiYgv28pwl5OWHJrB7JCNeecU3ZneBguEwpoyTACv1moQ1R0Uarxwl4Gbyzsd/sia
 kW/5DK9YtMz8skygErr8r5624ETNmGtKt24UWyUdAXxWP2+eVS2xNO1EKd7nokuyWgkL
 WmExs36PMa97e2rSo+eT3icPxIrTVPTJZdM54g5T/saD0+BRytrVOE/RmCa0itgC3AVw
 wWTw==
X-Gm-Message-State: AOAM530dEg81+27a/IaA1yLA7FYjTtytQe5OF0BgGGWVFddGnmjGsCfH
 9WXvBTWckAf4YkKJ6PkYu8NdyOb1GjHNoqGAB/ANW+LJdwfxRDssVUP8nOpIbtZM2+qYcpcetRi
 lVLs6b6F37yhSt4hrc51xtX/kQ6uJMpc=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8533397edr.243.1598342370401; 
 Tue, 25 Aug 2020 00:59:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUYBK2CC7dz4bSvYgBV3Gvlr6sP2ZCJvRwSCrVGQMwiWh5c63NZ1+OHaZy68gEK9vRQ+q0SBEo3Dj1m0NAVSE=
X-Received: by 2002:a50:ee96:: with SMTP id f22mr8533384edr.243.1598342370240; 
 Tue, 25 Aug 2020 00:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200823111757.72002-1-thuth@redhat.com>
In-Reply-To: <20200823111757.72002-1-thuth@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 25 Aug 2020 09:59:18 +0200
Message-ID: <CABgObfad0gt_qenKUJJaWWJn7mE3qBM+6h5O0TLaASsC9OgoVA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] Run cross-compilation build tests in the gitlab-CI
To: Thomas Huth <thuth@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0.0
X-Mimecast-Originator: redhat.com
Content-Type: multipart/alternative; boundary="00000000000035372905adaf15b2"
Received-SPF: pass client-ip=216.205.24.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/25 02:03:58
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.956,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 qemu-devel <qemu-devel@nongnu.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, luoyonggang@gmail.com,
 Stefan Weil <sw@weilnetz.de>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000035372905adaf15b2
Content-Type: text/plain; charset="UTF-8"

Build system parts

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

Il dom 23 ago 2020, 13:18 Thomas Huth <thuth@redhat.com> ha scritto:

> Now that we can use all our QEMU build containers in the gitlab-CI,
> we can also run the cross-compilation jobs there. Of course, some
> problems have to be fixed first, so this is taken care of in the first
> four patches.
>
> The following two patches make sure that we can also enable WHPX builds
> with
> our debian-win64-cross container, so that we can compile-test this
> accelerator
> code now, too.
>
> The last patch then finally enables the cross-compilation jobs in the CI.
>
> v2:
>  - Dropped patches that are not necessary anymore
>  - Added the first two patches to fix problems with the new meson build
>    system
>
> Thomas Huth (7):
>   configure: Add system = 'linux' for meson when cross-compiling
>   tests/docker: Install python3-setuptools in the debian9-mxe containers
>   tests/Makefile: test-image-locking needs CONFIG_POSIX
>   tests/Makefile: test-replication needs CONFIG_POSIX
>   dockerfiles/debian-win64-cross: Download WHPX MinGW headers
>   configure: Allow automatic WHPX detection
>   gitlab-ci: Add cross-compiling build tests
>
>  .gitlab-ci.d/crossbuilds.yml                  | 113 ++++++++++++++++++
>  .gitlab-ci.yml                                |   1 +
>  MAINTAINERS                                   |   1 +
>  configure                                     |   4 +
>  tests/Makefile.include                        |   6 +-
>  .../dockerfiles/debian-win64-cross.docker     |   9 +-
>  tests/docker/dockerfiles/debian9-mxe.docker   |   2 +-
>  7 files changed, 133 insertions(+), 3 deletions(-)
>  create mode 100644 .gitlab-ci.d/crossbuilds.yml
>
> --
> 2.18.2
>
>

--00000000000035372905adaf15b2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Build system parts<div dir=3D"auto"><br></div><div dir=3D=
"auto">Acked-by: Paolo Bonzini &lt;<a href=3D"mailto:pbonzini@redhat.com">p=
bonzini@redhat.com</a>&gt;</div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">Il dom 23 ago 2020, 13:18 Thomas Huth &lt;<=
a href=3D"mailto:thuth@redhat.com">thuth@redhat.com</a>&gt; ha scritto:<br>=
</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-l=
eft:1px #ccc solid;padding-left:1ex">Now that we can use all our QEMU build=
 containers in the gitlab-CI,<br>
we can also run the cross-compilation jobs there. Of course, some<br>
problems have to be fixed first, so this is taken care of in the first<br>
four patches.<br>
<br>
The following two patches make sure that we can also enable WHPX builds wit=
h<br>
our debian-win64-cross container, so that we can compile-test this accelera=
tor<br>
code now, too.<br>
<br>
The last patch then finally enables the cross-compilation jobs in the CI.<b=
r>
<br>
v2:<br>
=C2=A0- Dropped patches that are not necessary anymore<br>
=C2=A0- Added the first two patches to fix problems with the new meson buil=
d<br>
=C2=A0 =C2=A0system<br>
<br>
Thomas Huth (7):<br>
=C2=A0 configure: Add system =3D &#39;linux&#39; for meson when cross-compi=
ling<br>
=C2=A0 tests/docker: Install python3-setuptools in the debian9-mxe containe=
rs<br>
=C2=A0 tests/Makefile: test-image-locking needs CONFIG_POSIX<br>
=C2=A0 tests/Makefile: test-replication needs CONFIG_POSIX<br>
=C2=A0 dockerfiles/debian-win64-cross: Download WHPX MinGW headers<br>
=C2=A0 configure: Allow automatic WHPX detection<br>
=C2=A0 gitlab-ci: Add cross-compiling build tests<br>
<br>
=C2=A0.gitlab-ci.d/crossbuilds.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 113 ++++++++++++++++++<br>
=C2=A0.gitlab-ci.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A01 +<=
br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A01 +<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A04 +<br>
=C2=A0tests/Makefile.include=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A06 +-<br>
=C2=A0.../dockerfiles/debian-win64-cross.docker=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A09 +-<br>
=C2=A0tests/docker/dockerfiles/debian9-mxe.docker=C2=A0 =C2=A0|=C2=A0 =C2=
=A02 +-<br>
=C2=A07 files changed, 133 insertions(+), 3 deletions(-)<br>
=C2=A0create mode 100644 .gitlab-ci.d/crossbuilds.yml<br>
<br>
-- <br>
2.18.2<br>
<br>
</blockquote></div>

--00000000000035372905adaf15b2--


