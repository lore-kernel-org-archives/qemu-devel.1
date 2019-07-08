Return-Path: <SRS0=vrBk=VF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A46CC606C1
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:41:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17D402166E
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2019 16:41:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBaP0/J5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17D402166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hkWhh-0003C0-6i
	for qemu-devel@archiver.kernel.org; Mon, 08 Jul 2019 12:41:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51767)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hkWgN-0002Wz-Q3
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:40:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hkWgM-0000B6-RP
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:40:03 -0400
Received: from mail-oi1-x22b.google.com ([2607:f8b0:4864:20::22b]:33907)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hkWgI-00005d-MW
 for qemu-devel@nongnu.org; Mon, 08 Jul 2019 12:40:00 -0400
Received: by mail-oi1-x22b.google.com with SMTP id l12so13126510oil.1
 for <qemu-devel@nongnu.org>; Mon, 08 Jul 2019 09:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V/QbX43fnqNoAWQIN4sTALdsFUnCoKf7FtMkq1efSjg=;
 b=hBaP0/J5hPzqr9ARNaM7bDXsPuk05DbG5eI0wAQsWl2RXiR8XlrCl6kk2ucRjaPJgI
 OHZWpThV0iMCulH/oc47hJpqShC9RE2HTVuYZxaRBpTxVO9SYybHjZRkCjJRqBp5mNbw
 rPNMZ0qdQ9EikGb+CoR8pUqMLE4dmPnX5McwOYKzWh2V4s4LdzSoCxqFHu4x9BSPU9TG
 JCCfcgN7EHxFZ6b5jJC02Oa9uh1f7Sq90V/a3oqwWkEtNs+bT1ir0aG7fHYzW8ah4w+I
 Wtb0MAW18Th/IWkZNzJqA4eVs2mrmcCFosGPSDT51GIK6r/zscL7nLy/+W8b2Nn++jqo
 Sq5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V/QbX43fnqNoAWQIN4sTALdsFUnCoKf7FtMkq1efSjg=;
 b=ckF3UVwOyPXRpnaq2jhv1O+zAthPZtwFVl/uOpRX8kq+/uf+JwGKEE4nVQmAxG4Myg
 mKIX5ZsaBORtmT8ex8tkKz5/lV9wLNyriijnk1b34dCNqWUZshrwohht8aMU/c9awe8R
 eos/APaDLP4Tl4Q1m/AOIG1y2T4oEtz/6S5xmQg+R9l+HvbB4p/UUQg/Nl3pkJGymmmi
 Dxb+Z5yRZjjOUXXnrBQ+LO3QIfKj3ERaoG2K3KJsvsN4aUnxZ9c+VQagAI7itEz9XARK
 +K7R6wVMmfdSLAZpPxrqpXPit1gRUyPJxRZzS3LsZBaezGRXEQC/bvY2IGE2iKumJVL8
 fQbQ==
X-Gm-Message-State: APjAAAWTtUHfyJ0Yue8ZIEtjBXJUaTPNg1HRTsmeKmcfbgtRHWU1IFEa
 FMe5XwCoOMJFxOEpZTWf84Pd0DFkML1wv4j8obCZBQ==
X-Google-Smtp-Source: APXvYqzVl/x47Ls+zLCJy1KKlmUVR4+ZzH4xC1GBEih0VNualodpY4CazKOoPwcLCeCJ+Mm17lFz5yrMqavI/eCNI+A=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr9483848oie.48.1562603996735; 
 Mon, 08 Jul 2019 09:39:56 -0700 (PDT)
MIME-Version: 1.0
References: <20190107122304.22997-1-marcandre.lureau@redhat.com>
In-Reply-To: <20190107122304.22997-1-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Jul 2019 17:39:45 +0100
Message-ID: <CAFEAcA_AFvdzWP7a9hE9qeqAp22swiP7MKBTO9yWJUoW4JnRjA@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22b
Subject: Re: [Qemu-devel] [PULL v2 00/28] Machine props patches
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 7 Jan 2019 at 12:23, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
> ----------------------------------------------------------------
> Generalize machine compatibility properties
>
> During "[PATCH v2 05/10] qom/globals: generalize
> object_property_set_globals()" review, Eduardo suggested to rework the
> GlobalProperty handling, so that -global is limited to QDev only and
> we avoid mixing the machine compats and the user-provided -global
> properties (instead of generalizing -global to various object kinds,
> like I proposed in v2).
>
> "qdev: do not mix compat props with global props" patch decouples a
> bit user-provided -global from machine compat properties. This allows
> to get rid of "user_provided" and "errp" fields in following patches.
>
> A new compat property "x-use-canonical-path-for-ramblock-id" is added
> to hostmem for legacy canonical path names, set to true for -file and
> -memfd with qemu < 4.0.
>
> (this series was initially titled "[PATCH v2 00/10] hostmem: use
> object "id" for memory region name with >=3D 3.1", but its focus is more
> in refactoring the global and compatilibity properties handling now)

Hi; I've just noticed that this refactoring that removed all the
HW_COMPAT and PC_COMPAT macros left a couple of references to
them behind in documentation/comments:

$ git grep HW_COMPAT
docs/devel/migration.rst:   b) Add an entry to the ``HW_COMPAT_`` for
the previous version that sets
hw/i386/pc_piix.c: * HW_COMPAT_*, PC_COMPAT_*, or * pc_*_machine_options().

Could you write a patch which updates these bits of documentation
to refer to the new scheme, please?

thanks
-- PMM

