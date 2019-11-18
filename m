Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B741EC432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:29:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8639E20857
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 15:29:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VEwhSkl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8639E20857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWiy0-0003gs-Jw
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 10:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37539)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWix3-0002hy-0T
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWix2-0002W1-0G
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:28 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:38437)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWix1-0002VW-QK
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 10:28:27 -0500
Received: by mail-oi1-x244.google.com with SMTP id a14so15659797oid.5
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 07:28:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=7afJ7tzPngtye9+ZMXHFHBKQgLixlBBO+3uIN0csNZk=;
 b=VEwhSkl8ChEcPJNybye8+pdh9412ki0N9z9zjJh7a9eLt7hILBIFqkXrc/u9FR4aGM
 zQ+GE4RwE7ePGTIv82Gn7c3EUeSJ2V8Ln5zHKGqWXtbQL1zJhn/pEMHLq+OHBgtpl/bo
 0d0nV/uj3OKjzh8FXhuK14gzCApwGGKU1r65UZg+k4wapFMsEeR0PCHBSvohoKJ0H+yC
 XHAmt3kXdt7cUbNNmcHFADbc7iV1dtgXm1PDj3RLGuGBewEzw6gpnMuvIs4V5QsUDice
 CSbdT1Kr41+w3Npdv4fphpDhATfyJajwcEKzqagFQGLdRHXK5x5zpoC12R+tSvFUV9Js
 PaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=7afJ7tzPngtye9+ZMXHFHBKQgLixlBBO+3uIN0csNZk=;
 b=Xs0lvAyYNybePKPoBGKpvW4mXI3NBwNs3i9FtJkQH2r5Gxz45JEH4cHOGyOf71UuNq
 Bzm6dxi+2VL2imL6prhvWWDf3ED5EgaYB6ev7qw8w0awRJjT5FS8iasiLlD+hFEilfdO
 clUTUC/uuc/x92xkNpIG2xVYqVkPFCUcIv5939zkHBjLoBc5+4ecgXAiu+y1jFqWtcjM
 w9Sb9ZJ8vsK93W/pFbXXh3KCN0MHvFnNxSVqAE7QV40rgctJYEsJHye3GT/KrMr5PLq9
 q/p3dzgF1eFXRJ0hkfwuwlg/z8BkHvJT5JlkVQAS62xZFFAuLzC1RvqBHDZiRjm6VNsB
 PG4Q==
X-Gm-Message-State: APjAAAVu8IPHqylVpKmRfVlopwvbIpNtbCzCfDFO+4agygtaaPtJo2Ma
 yVoqpaCgptRxTxS1RBjyKM2y5MMXh7hv2dqTIKFLIQ==
X-Google-Smtp-Source: APXvYqx9QkfqY7JkD/DeEM93qbSIOd4LUIStqhdxl3ODI1qpPFFX/MCkeYcHrig2eAOMr4PvllvE2jo1yeAaiLxTMI0=
X-Received: by 2002:aca:a9d4:: with SMTP id
 s203mr20061094oie.146.1574090906952; 
 Mon, 18 Nov 2019 07:28:26 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-23-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-23-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 15:28:12 +0000
Message-ID: <CAFEAcA8tQ4Hn6Rm5_DeQmo5JHk5Debp_qGFqGoFvJu4Srh3sQw@mail.gmail.com>
Subject: Re: [PATCH v3 22/33] etraxfs: remove PROP_PTR usage
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Fabien Chouteau <chouteau@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 18:34, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> etraxfs_dma_client are not Object, so can't be exposed to user with
> QOM path. Let's remove property usage and move the constructor to the
> .c unit, simplifying some code on the way.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/net/etraxfs_eth.c      | 44 +++++++++++++++++++++++++++++----------
>  include/hw/cris/etraxfs.h | 20 +++---------------
>  2 files changed, 36 insertions(+), 28 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

