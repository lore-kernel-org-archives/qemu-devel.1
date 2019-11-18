Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA04C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:02:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7B2D20722
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 14:02:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="czZYA1o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7B2D20722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWhcC-0008Ov-LH
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 09:02:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51196)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhb3-0007gr-2O
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:01:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iWhay-00036i-5x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:01:40 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35111)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iWhay-00035b-0V
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 09:01:36 -0500
Received: by mail-ot1-x342.google.com with SMTP id c14so7579190oth.2
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 06:01:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=WhTJ+1f501vkUHUKKPATnM7Xp5Jofmh8PwlYt2xJv04=;
 b=czZYA1o+/tXtCZsPfFRxRlnAC8tk0E4LRhadp7zcBnSjx1/WLCUIHb2UU96/SPKu7t
 SFnmBhstG/ShVi3YogsViVEe8FSzAStDpCpSDc9SUJWfGlATY+CAMAVJHbD7tVbwRC0k
 6qZ7VbT6jMh28+P5AI36CiCXQJW3R3Mb0n7AVK0VMgu9HypeHGU+KpViqPQgXC4zuDU6
 roW/AzhMd2+zLhiGBmcFgfkYviXEHjDAY/JZ5pOE3rWB3oqlHX9PFM83KVkmvBbGU4Td
 0EPmqn++9ygbhjTxypSZsPk76nSXDQjVmqqAH9rHKZdb/Cxsvvlf527gP4DZSO2n8lZA
 FeDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=WhTJ+1f501vkUHUKKPATnM7Xp5Jofmh8PwlYt2xJv04=;
 b=g3sEy7pJNfBy1NzYzLOK/pOHmrRAab4cYdaPGYAXuDDn1rA6UgpJ8mAGD1rpUkG84A
 HX4/h177FMta2v4hGUQer54TlZkiOo9GHIpfGUvsMXvF1EWya1TQ6Dx3uuM5ODu98QUk
 ae39B4hCNW58/X4Gb8coQEzU8CJvWTQ97237dDdfORkRi2NEgnyEmnZUVeOLu4h3NHqJ
 WKLVO/KzwNO9zW+m0hyWXOKyp3jyJ+IonUS7w/FwB4QNpU4itY9etCgeE+l/53ssfRxH
 IrxJrNyMqDKdYeYcTOipiWxme1+1bB4UFsgmHEvCVJsXYFHkIGVKJJ3JkpUdumey1sU9
 7CNw==
X-Gm-Message-State: APjAAAVrAMUzdaFs+8geW/n/R43euqEekklSZeRad9P4YmuErZN+Zv/v
 KIJr9zwqvXEgayYIRvn5g+QcHDHbDYkouVFtnEdthA==
X-Google-Smtp-Source: APXvYqzGdczXBndLKbT1wkM1hT98jm8wECN3io64fUaT3H61mNm1/UVsQUgro8tDN3uptj4/irqiZLA3iTIQVuorXWE=
X-Received: by 2002:a9d:7ac2:: with SMTP id m2mr22636654otn.135.1574085690697; 
 Mon, 18 Nov 2019 06:01:30 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-2-marcandre.lureau@redhat.com>
In-Reply-To: <20191023173154.30051-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Nov 2019 14:01:16 +0000
Message-ID: <CAFEAcA_k9TqzRJZ4=Q1jQP46SajiaMLEciSHZ83_CicMv__oiA@mail.gmail.com>
Subject: Re: [PATCH v3 01/33] qdev: remove unused qdev_prop_int64
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
 Paul Burton <pburton@wavecomp.com>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 Magnus Damm <magnus.damm@gmail.com>,
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

On Wed, 23 Oct 2019 at 18:32, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@redhat.com> wrote:
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/core/qdev-properties.c    | 32 --------------------------------
>  include/hw/qdev-properties.h |  3 ---
>  2 files changed, 35 deletions(-)

I think I'd rather keep this. It's weird to not have a symmetric
set of properties for the common integer types, and annoying
for whoever next runs into a need for an int64 property to
have to reinstate the deleted code. (Yes, I know we don't
currently have int8 or int16.)

thanks
-- PMM

