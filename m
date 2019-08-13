Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E78A8C433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B136020673
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 11:23:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UF9TVF2V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B136020673
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxUuC-0004j5-1f
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 07:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42214)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hxUsc-0001vo-Vu
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:22:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hxUsY-00076O-7V
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:22:18 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:42040)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hxUsY-000742-0r
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 07:22:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id j7so26206115ota.9
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2019 04:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=K7Kst45sz0Jls6qj8gFgRNM6vdNPbeVuMePnsfpmIG8=;
 b=UF9TVF2V0KTiNRGSDvwc1w2nn4ptdotqRLdNvmLCTLQkJVVocgOVM7plfL5cNzO38R
 wL/7GyP7LvXz/Z45WwScvsygZhjnWgm2YwwPixrp56bn3zkJdfHD4hwjic9NXmWPFztT
 6eFIbo6XcSZOBv50ONCXH/YuzZ5JsHYmnZjY6yMjDEQ+tdoyCucgZv5vckfPrTaJvCPL
 8lSkaUFJWbltaNHr+xXLHQOy5X9WdBfYQn91szz62WPI24UdLIJ+o88lf7q2ESLhswby
 cjxWm/TE/XbiU9GNn5dIjeihQb8dej+m5hO2gNJw3OvSf7oc56RJfg2krD58hUQjMck1
 /PUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=K7Kst45sz0Jls6qj8gFgRNM6vdNPbeVuMePnsfpmIG8=;
 b=VPZ4W5z6jm32Wc9UXvYXCXB839YO317VF6a5SgTXkd//lrpasQL4AF82B3bZmX7pPO
 PnutZ7PklNhTtcscGMDAI5h9oi3mZa4EZduHXoYjdEU3a5S7WEmbPV34vp1PX16g9cMO
 3SOl1mZQYeQDR9P4OAngedNYHCWIWq9DiiXMi5fE2kGdkusPbe8DPI5DjtWBpPQ2phb3
 hwVs3N+M9M6QlqloBJOYHsI+jA46uUeFMGGE5QKYcMcOddLkK6+elzjVBwKTyylBeMM3
 57Re/CacDQpMp70Pxz+Ju5eoWhJ0VYDKBWl7UKV6h69a1T2BAAjxEDI0LUgXDpD63sqX
 Ydaw==
X-Gm-Message-State: APjAAAVY17LOqzZEsnyT6IhjqQ/DiEySs8iwEpVwfu0P0whF89IakSku
 zO8Nb2mSEfwgleu4difSzoFoiA5KO4fWX3ohmKm0jw==
X-Google-Smtp-Source: APXvYqxMztsg0HaqgtmfS/vKoyG+Fjhp6BpdG0hTXJNN9AajxgWxWUMXBgQH2oGWvvdy4LB7nYzP3vJgjkIN9rRCYZU=
X-Received: by 2002:a9d:4817:: with SMTP id c23mr996044otf.97.1565695333037;
 Tue, 13 Aug 2019 04:22:13 -0700 (PDT)
MIME-Version: 1.0
References: <20190813111809.3141-1-kraxel@redhat.com>
In-Reply-To: <20190813111809.3141-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Aug 2019 12:22:01 +0100
Message-ID: <CAFEAcA9QnntNxWQmNG7_oM=tOb0-xhxKA3JED8GhPOeDtjNJ4Q@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PULL 00/15] Audio 20190813 patches
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
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Michael Walle <michael@walle.cc>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 13 Aug 2019 at 12:20, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 5e7bcdcfe69ce0fad66012b2cfb2035003c37eef:
>
>   display/bochs: fix pcie support (2019-08-12 16:36:41 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/audio-20190813-pull-request
>
> for you to fetch changes up to 7f6f83e89de6967db66a87f7ceb7be3c02a24d56:
>
>   audio: Add missing fall through comments (2019-08-13 12:17:57 +0200)
>
> ----------------------------------------------------------------
> audio: second batch of -audiodev support, adding support for multiple backends.
>
> ----------------------------------------------------------------

We're still in freeze for 4.1 and will be until at least Thursday...

thanks
-- PMM

