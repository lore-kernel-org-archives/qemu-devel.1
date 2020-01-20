Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C73A8C2D0DB
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:17:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9278C207FF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 12:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lyDOqw4m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9278C207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itVzt-0002qg-M1
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 07:17:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52009)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1itVyX-0001sV-72
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:16:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1itVyW-00054j-10
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:16:13 -0500
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:36856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1itVyV-00052H-Rc
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 07:16:11 -0500
Received: by mail-ot1-x32b.google.com with SMTP id m2so23643342otq.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 04:16:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xFQuNcLCkoeU3tI/OX3S7iOhI7u734JiwHNW4LQc9iQ=;
 b=lyDOqw4mHni2KtUZ/USVPqacvTPLxhAcIb+Jlcy1aXGi8lVZGcfPRqJX/NcK1lS6cP
 O0Z4GbE2IiGVN6OoBrg+/6iVX8EO0k1n8quAGcPyKdpj4FqADe1lzTzlq2MxTREned93
 cs2QONjyaqeYuqlmaBUxslC2rVKKMUFetMUNyWzoWRvtGA/0244VsO+RLX1Ib/6qz9KW
 xOF02UOxfmkBZ3W/BQnth6Zu5PJY2v8F2t/O4MawKX8XHRXxQ0ox25EtzA5U0Mv+EuTE
 2qjjJAWF/dP6R21Fyvrr08Zd8sx+V6aN8/9HhwWyPGQkGlBhSc+K1MTnxUW5iOZlAs1S
 VvUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xFQuNcLCkoeU3tI/OX3S7iOhI7u734JiwHNW4LQc9iQ=;
 b=oS9omgZNZHXUGvcOB3vUPWQKl7KeQkkIMiURsVvPIraejHay/67YDe5Ywj1nIpKLXX
 gETPYZ4wMikmyToOkqO8dgCK+YtEU+bSb7q4G/aYrWiy1o9Uq0OB4E/32No2WUTdqyrB
 CJ7R/au7hdnDSxAwL9F8tITwLHEVI2z/csf3HDXPujeSzdAKjYkUxZusSzm5SlON9dpE
 li/1ledlBHiRVhKbn+QrM3udeQLMSBkKdVk5e8VrnLDeFCtDZpqoIjV1ajEYxs4GVhTe
 IGtoSMUp0rKeUyDxAc0h/Xige4j6297eAzFHBYWRLKebESr/pgrRtdCHYwZ/N4bCApLR
 lKmg==
X-Gm-Message-State: APjAAAUi//4tL/ThyX+vOrB71l4QJq38GSH410xbJHO0rcYRf1HhAcUb
 qSx1toXUOujX7XGZ8xIhxQF15R4QS6OSr8g8pyycaw==
X-Google-Smtp-Source: APXvYqzPDYDa5NlW2Y71xCHinmaUVozzPD/HHh4z0/dOuxCpTMkKxFPWkc4S1lBNVsUch1YrCxO30zgmTtewIg1WLBU=
X-Received: by 2002:a05:6830:184:: with SMTP id
 q4mr16008856ota.232.1579522571014; 
 Mon, 20 Jan 2020 04:16:11 -0800 (PST)
MIME-Version: 1.0
References: <20200120103340.25118-1-quintela@redhat.com>
In-Reply-To: <20200120103340.25118-1-quintela@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jan 2020 12:16:00 +0000
Message-ID: <CAFEAcA8RimrjEc3duMC4-vZLk0eXVGuZfsf8jaJKBLJtG7C9mg@mail.gmail.com>
Subject: Re: [PULL 00/29] Migration pull patches
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32b
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
 qemu-ppc <qemu-ppc@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 20 Jan 2020 at 10:33, Juan Quintela <quintela@redhat.com> wrote:
>
> The following changes since commit 7fb38daf256bd1bcbcb5ea556422283d0d55a1b1:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200117-1' into staging (2020-01-17 17:27:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/juanquintela/qemu.git tags/migration-pull-pull-request
>
> for you to fetch changes up to ddac5cb2d95774cd019bfaf93c54ffd921095fea:
>
>   multifd: Be consistent about using uint64_t (2020-01-20 09:17:07 +0100)
>
> ----------------------------------------------------------------
> Migration pull request (take 5)
>
> Making history short:
>
> * having your machine named x32 to really be a 32bit guest helps for
>   testing 32bits
> * disabling CONFIG_XEN on i686 makes rdma_addr_t be a 32bit value
>
> After this, and patch sent on Friday, I got this pull request to:
> * compile on x86_64
> * pass tests on x86_64
> * compile on i686
> * pass tests on i686 (with rdma_dma_t 32 bits)
> * cross-compile for windows 32bits
> * cross-compile for windows 64bits
>
> Please apply, Juan.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

