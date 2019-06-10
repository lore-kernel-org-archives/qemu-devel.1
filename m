Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D2AC43218
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:42:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EE720859
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 21:41:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISsVHcJj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EE720859
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49902 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haS3D-0002zP-6V
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 17:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34502)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haS0m-0001vs-3Z
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:39:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1haS0g-00089l-Fr
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:39:24 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:33983)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1haS0d-00085K-Bi
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 17:39:20 -0400
Received: by mail-ot1-x344.google.com with SMTP id z24so9812261oto.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 14:39:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=2JhvtJfdlMNccF3+h73l+RqwbFY/nDLzA3VeauC2u04=;
 b=ISsVHcJjSHYgHE0ntEKGPCM5xowmdjEMSoBEXtr4gf+FI+vXrwZ1aZROxU47WmjM0j
 S1FGgkNGFOyhj/KMCHl7BjW69YzZCMePcpPWGYK2MAbLmql4uWRVX842p1ps2F+06p1s
 ghc6bgb5SnRV6kOhBhWLH0b+Pc5KoxGrwE0SRhyNMF8quu36eH131akj1cWAYJ8bWgPr
 PPB+0Yi41zjus9KXRkpLshbvNpGSU09ckpXu5HTGzH5MrndZRhXFcg6Qv2pII82tM4fe
 xrsLpJS7oONoBIM1TtomTmG6Zbym42atRRUF1qZbesFd2hRToVUkTyK8xgV8smavSmvq
 ZobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=2JhvtJfdlMNccF3+h73l+RqwbFY/nDLzA3VeauC2u04=;
 b=VRMy6Wh7Uci30vGJD3G3GA2mMj2WdyKWpgUIZIrCUYlw+HkwIBuEmxm24ybQAoWhBW
 ODVm2bN/EEkzkW6Od6E1dAXHg6/45sdA8eN57AcSGweDPNxVowFRG+2jerQxSbx+8ELI
 HNUpka+Ru69q66LWZ6qo5PzWZrtPd/rHgAIT3WX3piid5TXaa1LDkdTlSezEISAOyQVt
 N7tnY3acXR7JE9JNHBrUEbAg1L+xUUzvXbj7NKEKOk+B5Ufcp0ELCJWEziBri2/yU+o1
 8EzGLMVJ9Lby6tCfLQ7RZagu/TfYP1Xpkl8NSSE8zDwo39mLqMQ3GiBGt3ZjwV1n1+aR
 oajA==
X-Gm-Message-State: APjAAAV8Pz7rpBI+BD9EBOszXq80bMbO4Bg6jiLhq039QBFolcwo5JuQ
 SB9gnnrVlV8cIoPZIt4IQodka+n4A87vzMYt5vA=
X-Google-Smtp-Source: APXvYqzWM2VcCOEANgOrelaVbSkp9ZvogRi0PBeL028E0plGaidJgHKhT92y70iwtshO6YLWICv6TD5zomrMnjPr8lI=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr174968oti.341.1560202756367;
 Mon, 10 Jun 2019 14:39:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 14:39:15
 -0700 (PDT)
Received: by 2002:a9d:20e4:0:0:0:0:0 with HTTP; Mon, 10 Jun 2019 14:39:15
 -0700 (PDT)
In-Reply-To: <20190610152444.20859-3-peter.maydell@linaro.org>
References: <20190610152444.20859-1-peter.maydell@linaro.org>
 <20190610152444.20859-3-peter.maydell@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Mon, 10 Jun 2019 23:39:15 +0200
Message-ID: <CAL1e-=jpEP5zfzEMPR6NtvToTV79OH1J5=re=LU7n=Lyo-usOA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH 2/2] docs: Build and install specs manual
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
 David Gibson <david@gibson.dropbear.id.au>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Jun 10, 2019 5:25 PM, "Peter Maydell" <peter.maydell@linaro.org> wrote:
>
> Now we have some rST format docs in the docs/specs/ manual, we should
> actually build and install it.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Acked-by: Aleksandar Markovic <amarkovic@wavecomp.com>

>  Makefile           |  7 ++++++-
>  docs/specs/conf.py | 16 ++++++++++++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
>  create mode 100644 docs/specs/conf.py
>
> diff --git a/Makefile b/Makefile
> index 8e2fc6624c3..cfb18f15254 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -731,6 +731,7 @@ distclean: clean
>         rm -rf .doctrees
>         $(call clean-manual,devel)
>         $(call clean-manual,interop)
> +       $(call clean-manual,specs)
>         for d in $(TARGET_DIRS); do \
>         rm -rf $$d || exit 1 ; \
>          done
> @@ -781,6 +782,7 @@ endef
>  .PHONY: install-sphinxdocs
>  install-sphinxdocs: sphinxdocs
>         $(call install-manual,interop)
> +       $(call install-manual,specs)
>
>  install-doc: $(DOCS) install-sphinxdocs
>         $(INSTALL_DIR) "$(DESTDIR)$(qemu_docdir)"
> @@ -962,7 +964,7 @@ docs/version.texi: $(SRC_PATH)/VERSION config-host.mak
>  # and handles "don't rebuild things unless necessary" itself.
>  # The '.doctrees' files are cached information to speed this up.
>  .PHONY: sphinxdocs
> -sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html
$(MANUAL_BUILDDIR)/interop/index.html
> +sphinxdocs: $(MANUAL_BUILDDIR)/devel/index.html
$(MANUAL_BUILDDIR)/interop/index.html $(MANUAL_BUILDDIR)/specs/index.html
>
>  # Canned command to build a single manual
>  build-manual = $(call quiet-command,sphinx-build $(if $(V),,-q) -W -n -b
html -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1
$(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
> @@ -975,6 +977,9 @@ $(MANUAL_BUILDDIR)/devel/index.html: $(call
manual-deps,devel)
>  $(MANUAL_BUILDDIR)/interop/index.html: $(call manual-deps,interop)
>         $(call build-manual,interop)
>
> +$(MANUAL_BUILDDIR)/specs/index.html: $(call manual-deps,specs)
> +       $(call build-manual,specs)
> +
>  qemu-options.texi: $(SRC_PATH)/qemu-options.hx $(SRC_PATH)/scripts/hxtool
>         $(call quiet-command,sh $(SRC_PATH)/scripts/hxtool -t < $< >
$@,"GEN","$@")
>
> diff --git a/docs/specs/conf.py b/docs/specs/conf.py
> new file mode 100644
> index 00000000000..4d56f3ae13c
> --- /dev/null
> +++ b/docs/specs/conf.py
> @@ -0,0 +1,16 @@
> +# -*- coding: utf-8 -*-
> +#
> +# QEMU documentation build configuration file for the 'specs' manual.
> +#
> +# This includes the top level conf file and then makes any necessary
tweaks.
> +import sys
> +import os
> +
> +qemu_docdir = os.path.abspath("..")
> +parent_config = os.path.join(qemu_docdir, "conf.py")
> +exec(compile(open(parent_config, "rb").read(), parent_config, 'exec'))
> +
> +# This slightly misuses the 'description', but is the best way to get
> +# the manual title to appear in the sidebar.
> +html_theme_options['description'] = \
> +    u'System Emulation Guest Hardware Specifications'
> --
> 2.20.1
>
>
