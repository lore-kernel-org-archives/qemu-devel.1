Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 952CBC2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:35:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19A3C2075A
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 14:35:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crmUjwSG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19A3C2075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55936 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMuFa-0005qs-4K
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 10:35:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55356)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMuD6-0004Xc-3t
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:33:00 -0400
Received: from mail-ej1-x641.google.com ([2a00:1450:4864:20::641]:33719)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kMuD4-0004pt-9p
 for qemu-devel@nongnu.org; Mon, 28 Sep 2020 10:32:59 -0400
Received: by mail-ej1-x641.google.com with SMTP id j11so8877975ejk.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2020 07:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=nB/6bZ4t5RWMKtAjgLX9+ElSVsBF9GXuCsJ6kAP0Bso=;
 b=crmUjwSGXwkh79x6RGPQrZUoVzWfMQPz88lPUW75hn6j6jkG1X5bzbdUN9bzsCXTWs
 KThx9HyX/I7aYumSJc7ITN+faSsj1dkFUidA/85k9x7cWDsXKxj+1QS12Uyiuqtlym0X
 3azvDMBx25GINebnCQTf3ottFUheyIzaEhNOkJLhc1WTPmSLV4JkUr/Q7hzVS6qPBu+t
 vytctAZijxXR6SoJqLrVEkJ+sCPTPgi57xsRqLgb3XmLphpKVJjCK0QtMMnlMXYzdmaq
 Ay0/fNzHrKCRKK5Y4jdmU7ITbTsEVxFOKXHmSmxEJGmkO8uz3v9jLADwSSXSlcGtRDzS
 Ye6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nB/6bZ4t5RWMKtAjgLX9+ElSVsBF9GXuCsJ6kAP0Bso=;
 b=lkIQCZCodGNlfd8K56VZmKJAOigSWZP6UUEVrt+8vyy7J4ZS/FvnRDxIgIHtmUbZ6S
 QpMUQgKmsgAULSuhpV3A9ZQ6btXNoLbrDjB+q9JaFbP2soCaGWxO400EknRUs3tB94lH
 4x2x7ZHKvH2ePjX/2EI+Q20RbSsUSplV6RDXNImIscpMWbxJhOOdim7qG4V2qC++xpnM
 HY4buGZvDPCLibv9ZizQVf8l8wwt1QCNuMRVEv6Cm8qnrcVm/FjZMZL7k9Z5M2aGzEri
 Lh0DNVooVFsyAM084Bmr15YJnrBHyd8RmGlf+iLVYo+djOQIUyHvix1h189JgC8yh/ir
 ztUQ==
X-Gm-Message-State: AOAM532WpmRnQZg3sB0jccBeXFMYcluLCulDxIFg08bSgof3Co0hTArp
 ZK5NK22tST81/JloRdhcae3lRImOdamgH/aYvVke+Q==
X-Google-Smtp-Source: ABdhPJyXOAoZIthnvyoSTD4o2PoZF8sXjqctD9OPnLWZ9rXnqX7UMZkPdK1+v0C9x4MIu7s7GsYDQrsjj2kwdc+YHq0=
X-Received: by 2002:a17:906:4a53:: with SMTP id
 a19mr2056691ejv.56.1601303576513; 
 Mon, 28 Sep 2020 07:32:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200928125859.734287-1-philmd@redhat.com>
 <20200928125859.734287-2-philmd@redhat.com>
 <20200928140448.GH2230076@redhat.com>
 <CAFEAcA9THz32JdqVF8JykQebw=ub50vY1RMNV+zLuzSHmAcP0g@mail.gmail.com>
 <20200928142322.GJ2230076@redhat.com>
In-Reply-To: <20200928142322.GJ2230076@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2020 15:32:45 +0100
Message-ID: <CAFEAcA8dSc+L5Xv=sV_C-wtpddoYq7dZd2UN_-X6KgunxkZQAQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] qemu/compiler: Simplify as all compilers support
 attribute 'gnu_printf'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::641;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Sep 2020 at 15:23, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Mon, Sep 28, 2020 at 03:14:45PM +0100, Peter Maydell wrote:
> > On Mon, 28 Sep 2020 at 15:06, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > > I think this can be simplified even more by using GLib's macros
> > >
> > >   #define GCC_FMT_ATTR(n, m)  G_GNUC_PRINTF(n, m)
> >
> > At least on my system G_GNUC_PRINTF() expands to
> > __format__(__printf__,...), not gnu_printf, so it is
> > not quite what we want. (The difference is that on Windows
> > hosts we still want to mark up our our logging functions as
> > taking the glibc style format handling, not whatever the
> > MS C library format escapes happen to be.)
> > At a minimum you'd need to keep in the "on Windows,
> > redefine __printf__ to __gnu_printf__" logic.
> >
> > See also commit 95df51a4a02a853.
>
> Oh, that's a bug in old GLib versions. I thought we had a new enough
> min to avoid that problem, but i guess not after all.

Looks like the implementation changed 2 years ago:
https://gitlab.gnome.org/GNOME/glib/-/commit/98a0ab929d8c59ee27e5f470f11d07=
7bb6a56749
not sure which glib version that would correspond to.

thanks
-- PMM

