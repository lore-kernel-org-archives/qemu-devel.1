Return-Path: <SRS0=7VQp=V2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 409EFC433FF
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F9542070B
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2019 13:17:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eMqp8/Wa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F9542070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hs5X9-0002zU-4b
	for qemu-devel@archiver.kernel.org; Mon, 29 Jul 2019 09:17:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41680)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5WR-0002WX-6a
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:17:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hs5WQ-00066c-5o
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:17:03 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:36533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hs5WP-00061p-Sc
 for qemu-devel@nongnu.org; Mon, 29 Jul 2019 09:17:02 -0400
Received: by mail-ot1-x335.google.com with SMTP id r6so62478068oti.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2019 06:17:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TCrm4ivHs2IMudA2Tz9tISJsYbGA0/TCDE26vz9dz0I=;
 b=eMqp8/WaYWr7DUSojx7c3gmbnpArV4sBaXPPhiWt4tCWMii4GB+P+QuIhEUsik2DXx
 tzRFgU4eE1ae+KfAJ5v7xpPioixmBlMLSkiOIxub4FLYA93GtOgUjDILVB8fpe2sjzr4
 FkW9PpoRXbUijxhKFOAc+1ttwdui3BZQOH6Vz6dAFDYb85yYKds6ncHASd/ybxXL/hpU
 CdmnP4blMc10tAy6C5HwpXzWlJQWbyb7lWvt0fk6kkQiRgsls1L584ZqgxCv4pyagrdB
 6t/o7/9fL7UPYhZ19b556T40oBgyTqbklDqIyyIJgOMPCPR7GW39bWlbnbaQ12NqnP5B
 BbFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TCrm4ivHs2IMudA2Tz9tISJsYbGA0/TCDE26vz9dz0I=;
 b=oaP+zwkJG/djSt+mVNqRbdKZBq5Ad9zqjfnEI5EBh++pqVNc6HltABtyepa+l5vvo9
 e2ae8jX2dTBBshQ+UloejwD1wZGxIRDk5iQ2Iuv6hvDBiHi70mmrfz2eKBbS7iUzzbRm
 CdqnWMNbc5M5o2NoqxiyDUiZkKgfDnBms/RUeSVxF+wXHgMu5+22mDpeG2L39454sBaG
 98YdbVYG0ADvf9ADBRwF+DCO1BYCPYWHQ1ZO+GMOuSSsvLsdMbh5h3UNhL5upkazajo3
 BjfocB/89q2jINjAjmOUyKtSOK+jhjunTSPZhhdCE8WfvPiC4GlCSFI3MV6SxpOL7KAh
 47HA==
X-Gm-Message-State: APjAAAWupN+X8N42DisH5d1JyABWVO09mFg4zheuuAlfGeXx0VYt/S+C
 tvSw2KKo6EAkef5eeKTVj+dhORaFroRzNRstV6La8w==
X-Google-Smtp-Source: APXvYqwZlkgMNMWz4IiecXRm9unhe2/GNMGVOS5soLBp5lj/0l9AEJ+J9aD6q9J/ckzDzqOlvFAs+MMTKzPUj2YpnWc=
X-Received: by 2002:a9d:4d81:: with SMTP id u1mr106979otk.221.1564406220717;
 Mon, 29 Jul 2019 06:17:00 -0700 (PDT)
MIME-Version: 1.0
References: <20190722172616.28797-1-mreitz@redhat.com>
 <20190722172616.28797-3-mreitz@redhat.com>
In-Reply-To: <20190722172616.28797-3-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Jul 2019 14:16:50 +0100
Message-ID: <CAFEAcA-JfzfR258pgNxEc=x7NqDncUrvQMtyCZ6FVm0PaZdv+A@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Subject: Re: [Qemu-devel] [PULL 2/5] block/nvme: support larger that 512
 bytes sector devices
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 22 Jul 2019 at 18:26, Max Reitz <mreitz@redhat.com> wrote:
>
> From: Maxim Levitsky <mlevitsk@redhat.com>
>
> Currently the driver hardcodes the sector size to 512,
> and doesn't check the underlying device. Fix that.
>
> Also fail if underlying nvme device is formatted with metadata
> as this needs special support.
>
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Message-id: 20190716163020.13383-3-mlevitsk@redhat.com
> Signed-off-by: Max Reitz <mreitz@redhat.com>

> +static int64_t nvme_get_blocksize(BlockDriverState *bs)
> +{
> +    BDRVNVMeState *s = bs->opaque;
> +    assert(s->blkshift >= BDRV_SECTOR_BITS);
> +    return 1 << s->blkshift;
> +}

Hi -- Coverity points out here that we calculate the
"1 << s->blkshift" as a 32-bit shift, but then return an
int64_t type (CID 1403771).

Can the blkshift ever really be 31 or more ?

The types here seem weird anyway -- we return an int64_t,
but the only user of this is nvme_probe_blocksizes(),
which uses the value only to set BlockSizes::phys and ::log,
both of which are of type "uint32_t". That leads me to think
that the right return type for the function is uint32_t.

PS: this is the only Coverity issue currently outstanding so
if it's a trivial fix it might be nice to put it into rc3.

thanks
-- PMM

