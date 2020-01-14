Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D22E6C33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:23:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E25724676
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 11:23:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KCjiSLU0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E25724676
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irKHp-0000c5-OI
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 06:23:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1irKGc-0007dt-NI
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:21:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1irKGa-0005AQ-Rt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:21:50 -0500
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:41279)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1irKGa-00059j-Gt
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 06:21:48 -0500
Received: by mail-oi1-x22a.google.com with SMTP id i1so11429631oie.8
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2020 03:21:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=42IyICU/qzw8FWIibaG8XJJhqypIeJououtKd1vQJ/Y=;
 b=KCjiSLU03POPTL6dUmEHDkkCTKUo75X4RIHXyYxiJaHWpgubr9Mzrl5VolD8ZQBgv5
 KRsG+IwuBZPUsdzsEY25AuXEZBmc+Vvhka6BPSdSENayDWFp2TYEETc7HWBfypeNfnnB
 ZG+ZT1VzbuHOsiRotZcQ095uSn8UCjb5AAd0kcHnVU/tGgcWSQYeJ/wXKTS6OGH9Erod
 VC0A8BaGtY89BoackniRXSbJFF6GfT1W2TY9FYwzAHMkz7PKiJzN9lIq13LIt9NuEOKf
 jHAZ3DQr2KGhvr20iFkSF5mVvvozzHAQQy6UkQU331HuHhKnP0E73yKEhMQFr6zRohzy
 UcgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=42IyICU/qzw8FWIibaG8XJJhqypIeJououtKd1vQJ/Y=;
 b=EVk+igib9sySMIOoHVnssrVs11RcRtN0u5K8IiBjVgxTK8NEePYKNmuDIa4wD19HYJ
 bdzR9P95PfLrvbWPdFVdJOIQGNUYbpWQn1trODYCHx67Dn8+OUMgZrQY7gk5rdZyILjz
 vHmsR1mikHM5InOmcJAu1cn7o2FUwwScMvD8scT+PTDFPAlh4cczIL7c41R+r1Ksm8Ks
 GYAfdNf0c598t58h28y/GDLBCtRxad94qpZQXpJa0c9dBfcojIRdqb7MS48D1p73yr78
 efaMMMs//uACAqJnJnBk8P3nWSrMqqKPovEw8XM9e3BdGIhS7MTb4xdPYqm+K2Y1e1Xq
 TJnQ==
X-Gm-Message-State: APjAAAVfcxMJDJNLiw7hnDHCZ1KGGu7YyQgaS7zpdHydWetwktEbZM6h
 jE51nKLTs5Yh9D7CymoWRql79RuMMKqbdLpG59f/wA==
X-Google-Smtp-Source: APXvYqwG7MIwl2mCaEDAVF9tUpG/DW7qbNR4bw0P4YUJYZN4kIaradjNm4HrqMMJorF0XhbMhtgqTdlVQRDlH8O5uSE=
X-Received: by 2002:aca:3d7:: with SMTP id 206mr16571686oid.98.1579000907120; 
 Tue, 14 Jan 2020 03:21:47 -0800 (PST)
MIME-Version: 1.0
References: <20200114092606.1761-1-quintela@redhat.com>
In-Reply-To: <20200114092606.1761-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 14 Jan 2020 11:21:36 +0000
Message-ID: <CAFEAcA92xHe3T2teGQmBgkL1qSGoY6F+rd8a4A_ghw=CL98vQg@mail.gmail.com>
Subject: Re: [PULL 00/29] Migration pull patches (second try)
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22a
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
Cc: Laurent Vivier <lvivier@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 qemu-ppc <qemu-ppc@nongnu.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 14 Jan 2020 at 09:26, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 3c8a6575985b1652b45bfa670b5e1907d642cfa0:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/usb-20200113-pull-request' into staging (2020-01-13 14:19:57 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-request
>
> for you to fetch changes up to 4eafab585c091050b5ae63130f46fe46ac919c3a:
>
>   migration: Support QLIST migration (2020-01-14 10:17:12 +0100)
>
> ----------------------------------------------------------------
> Migration pull request
> - updated QList patch
> - initialize local msg variable

Also, your patch 1 has no Signed-off-by: line. Ideally you
should post it on the list before putting it in a pullreq...

thanks
-- PMM

