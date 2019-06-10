Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EF84C5ACC3
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:17:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E461A207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 14:17:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sQ8jq0wI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E461A207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haL75-0006f5-Tt
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 10:17:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57540)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1haL1h-000424-RK
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1haL1e-0002L7-2x
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:11:55 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:33721)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1haL1b-00023L-QX
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 10:11:53 -0400
Received: by mail-ot1-x342.google.com with SMTP id p4so5199277oti.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jun 2019 07:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/4tMENzLMNsDa0O91fL+O22j73l07juZCpfAbX0FI40=;
 b=sQ8jq0wIKJ51Rv6tRPewy8KhqXDi3ADgkovFJQ0aSKCUIRCeOImx9wP/aowCLQzFTA
 efLRxSi7Lq1Cw+xID05f8bOz0lEIUM8aXn+eqeMX1Ah02j/v6f29BPXqToZthYTG9AR6
 JJJrUyAe2pnAF0uagcFocGEG0tLouiWOQfTop0mx5N+oOI1bH5ytREG21bNwSengoNhw
 tcyQj+3waK4/KH0K4mXjvJgbSEW1pnoY4bBQMn8djaiju4yV6dyLfXic0EyxXCI14jKZ
 HFvJZFolAgkO/F+WFqw9QtnoSe+ebZQwTzeLXkw5AViIRCgd6/lm7Ixyw7OQsbFwFzVL
 iXFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/4tMENzLMNsDa0O91fL+O22j73l07juZCpfAbX0FI40=;
 b=l/vUf2ZYJwqtto/zFCUiidUoH84uC0wF9MSZCT1qz7vI16gIat4DbPGzivhYkbi6e3
 0TjoQCIC9dggSRM0p9K/KJzuTG2TQvX0VfK+pji5an/EO1nv9DUfBTgCdery/+pRfTWE
 9sxKigvJbYSUxz37KaMM7+0G3Vxa33meiIx737fbS+/suiIAqfOP1TZybxfk5mLNNgmK
 3kffuVENtUkKx6CIkHPRSyxykFmkjOcqHNCvFSKSa06rnSHlKhnIKXg0a8ulRoE6A2JG
 AEyyLyvbOAd4ZEXv8+vZN3b6vWqZ0NgVuHfSRSaM9FPZ19TH5+WBHawg3L51ddDE5jqm
 l9bw==
X-Gm-Message-State: APjAAAU+Vw4YF1BChNzZNoaI8dkYptJ0Wq0SpiYpCY9F5ppCOylvkFjD
 EtGdNNOkEAtrlJYxyJo2o0r93534J96zzsZ0cmmjcg==
X-Google-Smtp-Source: APXvYqzA7cmn4Su1NfX2dqVvShXX1VyHL3svyuzBnPY6AuGv2cZZqU1ZECf2SGVAqki3KcRXlDsez/L1I+nuHV/XR5U=
X-Received: by 2002:a9d:193:: with SMTP id e19mr30086809ote.135.1560175894279; 
 Mon, 10 Jun 2019 07:11:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134545.3743-1-peter.maydell@linaro.org>
 <f638478d-8149-0dbb-1d76-0c45c29cbaf1@redhat.com>
In-Reply-To: <f638478d-8149-0dbb-1d76-0c45c29cbaf1@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 10 Jun 2019 15:11:23 +0100
Message-ID: <CAFEAcA_dApKKDFj9GbRVdW-c0js5U-ucuzPrnY2ZW5yBGQRDTA@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH] qemu-ga: Convert invocation documentation
 to rST
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
Cc: John Snow <jsnow@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 10 Jun 2019 at 14:56, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 10/06/19 15:45, Peter Maydell wrote:
> > +# Canned command to build manpages from a single manual
> > +build-manpages = $(call quiet-command,CONFDIR="$(qemu_confdir)" sphinx-build $(if $(V),,-q) -W -n -b man -D version=$(VERSION) -D release="$(FULL_VERSION)" -d .doctrees/$1 $(SRC_PATH)/docs/$1 $(MANUAL_BUILDDIR)/$1 ,"SPHINX","$(MANUAL_BUILDDIR)/$1")
>
>
> ...
>
> > +# The rst_epilog fragment is effectively included in every rST file.
> > +# We use it to define substitutions based on build config that
> > +# can then be used in the documentation. The fallback if the
> > +# environment variable is not set is for the benefit of readthedocs
> > +# style document building; our Makefile always sets the variable.
> > +confdir = os.getenv('CONFDIR', "/usr/local/etc")
>
> This should be /usr/local/etc/qemu is you want $(qemu_confdir) above and
> not $(sysconfdir).
>
> But since we always set the variable when building from the QEMU build
> system, perhaps "/etc" or "/etc/qemu" is a more useful default when
> building the manual outside QEMU?

Yeah, I wasn't sure what to set this to either...

thanks
-- PMM

