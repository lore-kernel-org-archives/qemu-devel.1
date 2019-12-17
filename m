Return-Path: <SRS0=zFtV=2H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A785C43603
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:20:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4091221582
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Dec 2019 17:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l3BczMjD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4091221582
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44019 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihGWV-00069i-ET
	for qemu-devel@archiver.kernel.org; Tue, 17 Dec 2019 12:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39833)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ihGVk-0005hE-DB
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:19:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ihGVj-0001Xz-1D
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:19:52 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:34863)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ihGVi-0001Xr-Rp
 for qemu-devel@nongnu.org; Tue, 17 Dec 2019 12:19:50 -0500
Received: by mail-ot1-x32d.google.com with SMTP id f71so5001781otf.2
 for <qemu-devel@nongnu.org>; Tue, 17 Dec 2019 09:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rcECzhTd1HBYWF7LAUn/lPdWQwFk6rMb++qmPhd3QMk=;
 b=l3BczMjDeeajcbn9ErmpwyWGQxmKHB4FfQg/pAtBsXhs82khCfdh+X/N4XafTOuUOX
 sPxLPQoV5iwNJqJKq4yHTppeb+89OBCSaTZOe62OgkvDfJSVmn3zMrzjiKhAa10fhIUy
 WGgo+kkfwHdVnagBJgUiLWxi7fknltezC6SnbOEd/edC9vEeLpp+zRoGycNV6aOb8qcs
 oIMVHeyT4ITWQwJwdrbv9bJc/UAxHdbs08c3jBRmoXnR4at0vPamIPD1weypYcH12s9G
 vUzqhrcryZ20NxXAT564OZs4qfAeYJDKbYccKKp/gxCjJKexj/q0RySNsB/ayDhmm2uv
 ADJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rcECzhTd1HBYWF7LAUn/lPdWQwFk6rMb++qmPhd3QMk=;
 b=S+0/VF3wl97AsT/QxyykGjW7lLa0VfWDrZcM4lYutzx67QZDMwHTlje3zhAlK0xex9
 ld3XIg1ve1xv6XtsEAbkOQ6UtCp9zMQ70507/Mc/ZI74qhGybO62s8+smH47ricW23cd
 QvU6wbAs7nCrsWDFvJjdbhz909Yr61N6swClJRe5Y0pKyaibqXeEOJA8tjzdck1hxgYD
 ikKzWXwLXzqQVu+1Vak6FPPJai2lbWVPgWT46cEEgHtQW04WrB41dRJ5wCEqgT3VDGep
 bYkwhjWxp9QvAb2lUO9+vJYbPXHGDEHh2ZlRdPnDjtC/JcinzigFPIwdXUFXmOHhTbNw
 t7Mw==
X-Gm-Message-State: APjAAAUBZDXf/U0d5v3T519KTgfs71p2XeCUEYszvF8uucAgaZJKwjU+
 /3ZN+i58TIvfGYJ74AnkLt/S+e1dQ6b/0viS9cOwIg==
X-Google-Smtp-Source: APXvYqxsF0tSitO3YZEBzZdMg2M9ppqXULqVW7NMxeqY+/OYyPs0W6EBfS7+WagA6xNtWqAxOPXiR+k1jttaWO2P4mM=
X-Received: by 2002:a9d:6745:: with SMTP id w5mr36859834otm.221.1576603189995; 
 Tue, 17 Dec 2019 09:19:49 -0800 (PST)
MIME-Version: 1.0
References: <20191217084223.10231-1-thuth@redhat.com>
In-Reply-To: <20191217084223.10231-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 17 Dec 2019 17:19:39 +0000
Message-ID: <CAFEAcA_xwsaCym6yg7En0YScZDiA1nTnRcxCShur7LTQ5omrLQ@mail.gmail.com>
Subject: Re: [PULL v2 00/10] Bluetooth removal, and qtest & misc patches
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32d
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 17 Dec 2019 at 08:42, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi!
>
> The following changes since commit cb88904a54903ef6ba21a68a61d9cd51e2166304:
>
>   Merge remote-tracking branch 'remotes/amarkovic/tags/mips-queue-dec-16-2019' into staging (2019-12-16 14:07:56 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/huth/qemu.git tags/pull-request-2019-12-17
>
> for you to fetch changes up to 0f555602c7430ae55b5a4bacf39ce9e483e11193:
>
>   tests: use g_test_rand_int (2019-12-17 09:05:23 +0100)
>
> ----------------------------------------------------------------
> * Removal of the deprecated bluetooth code
> * Some qtest and misc patches
> ----------------------------------------------------------------
>
> v2: Unfortunately, I was not able to reproduce the build problem that
>     Peter reported for the v1 pull request. So I'm trying to work-around
>     the issue now by leaving an empty hw/bt/Kconfig file around this time.
>     I'll remove it by another patch later in a couple of weeks instead.
>

This passed without issues on all my build hosts, so your guess
about it being down to the deletion of the Kconfig file must
be right.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

