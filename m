Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5951FC432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:27:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C1F2067D
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 18:27:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kjYs1fl+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C1F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44770 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXrAW-0002LH-3Z
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 13:27:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iXr90-0001KA-H9
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:25:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iXr8z-0006eP-Ed
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:25:30 -0500
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229]:39597)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iXr8z-0006dy-9Y
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 13:25:29 -0500
Received: by mail-oi1-x229.google.com with SMTP id v138so4094927oif.6
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2019 10:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LOZGz2UDMIwMUg0tcm9urZX6fqfPGuOFbxhsjTMlJRk=;
 b=kjYs1fl+UtCHwCFH4bPrPnnopj7Ix3pkW5vsaOfMdCkl/YJtJxb5I1W3DpXezsm0F9
 wLh1VNj+9UhyfNZGiv0irhhPOSa9Go2oI0QJajwvZvqh1waU5QD/AQYKtplN2xHbAqXZ
 SW2wyaqi5Z0Vw2qOaB+oXkUaZdvxszZbO2iCteBvniO096lSU8DCqU3bsDLxLEKap1Sa
 /F2hwWYHI4UHVkIGPxJOy9bXDMKPYDkydpxWxfJDWz0SCbKqR/ZCXBzNRAbzSil6kl6d
 riRObHrfzcszR87v9eeVdQ+BTnJKuM2wTMBnz/ax16WyBNr/MM9wy1Jp0jN803x0MKfR
 Qgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LOZGz2UDMIwMUg0tcm9urZX6fqfPGuOFbxhsjTMlJRk=;
 b=aP4ah5EIbmsbxLUtGXOuJC+N8WlpyqwIJSfXEfkDSKpI35V+V2KA/p7Q+W2F+u8ZPh
 /HN8SXWh+dC3hUvYxAYl7/KNCZYXwZjbQ/l3U5bkit2QeH0a/IhDQf1EcoMrTIr8UqyX
 0N9kBIr20SWHLEQLnU4gLFtr5u3c8HL20elttHbqZLDtOBg/oAH3PDGUaHskcGc2vsWU
 as4J9/wxKnJzBGNgckwCw00PfmNnGhygA9NPdF2lK0pJGqZ413s+B/v4FiXcK68tnkp8
 Mk3ioMYTiEw3p1XV3EvUJXayCAejI23dD9pktIzOjHEtQfTAfV+ZeQwrV0lBq/ebsfsZ
 TftA==
X-Gm-Message-State: APjAAAU0+jorK778kH2OT4ax0dy0JOX1EcNszQdcZREC5Qg9OXA182k/
 1t+olJTrbjtBz2PgtQHv+0HBuO10fxb6yOeKwtzCrw==
X-Google-Smtp-Source: APXvYqz5+tsTykVfoHAF9eTCgZGyvcchPITBjKJIN32d3291I/nNzDBoB4lC4K842HwEOLgkw+33CWiK6nKmbrIeT90=
X-Received: by 2002:aca:a9d4:: with SMTP id s203mr8592621oie.146.1574360728474; 
 Thu, 21 Nov 2019 10:25:28 -0800 (PST)
MIME-Version: 1.0
References: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1574350609-29518-1-git-send-email-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Nov 2019 18:25:17 +0000
Message-ID: <CAFEAcA_TwtiE3dPvsz3XPkfrPHSSBU3V37-QQ3tnSW+tEnPvbQ@mail.gmail.com>
Subject: Re: [PULL 0/4] x86 updates for QEMU 4.2-rc
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::229
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 21 Nov 2019 at 15:39, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 39e2821077e6dcf788b7c2a9ef50970ec7995437:
>
>   Update version for v4.2.0-rc2 release (2019-11-19 19:34:10 +0000)
>
> are available in the git repository at:
>
>   git://github.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 02fa60d10137ed2ef17534718d7467e0d2170142:
>
>   i386: Add -noTSX aliases for hle=off, rtm=off CPU models (2019-11-21 16:35:05 +0100)
>
> ----------------------------------------------------------------
> * x86 updates for Intel errata (myself, Eduardo)
> * the big ugly list of x86 VMX features, which was targeted for 5.0 but
> caused a Libvirt regression (myself)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

