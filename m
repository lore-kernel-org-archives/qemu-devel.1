Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70268C34026
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:42:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3CF412173E
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 13:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cDrwwU4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3CF412173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j439K-000858-Fr
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 08:42:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48615)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j438f-0007cn-3p
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:42:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j438d-0007uO-RF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:42:12 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j438d-0007uE-M4
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 08:42:11 -0500
Received: by mail-oi1-x242.google.com with SMTP id d62so20064645oia.11
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2020 05:42:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=/yjtpi/etBZsP1UXjF4HtS1llgIBkQGDGWlyi0HHcXo=;
 b=cDrwwU4z1FDFP+jHjaDBt7hkgDQNKepwDoO0F1O6g4QcJK4jmzqGmlwM7vh4sCh276
 vLlk7UnAUdG+XDU8Bw5GHersfViJxsvmITSpVRnuRU+2HKuA4nxW01NtQHAOYxY1eyzs
 CdVwirVemsePS+6aq+GulFuQoP2QyKRVL2y4CRH4NYUJrxX6klF0eQP4vFsm2ifw9MuV
 VomzZwL57BJ5yRQOTH9pjEq07ZKalmpxOHqxg6REXiyYAOuNsBTZQb5I6x5F/YZC2K51
 RtM3EALXPMOrUF1B/24t/5dozTV5EsKSdLtzN8N9CFK0Ki1u+5Dj70qQz7fgZF8CEW9+
 oJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=/yjtpi/etBZsP1UXjF4HtS1llgIBkQGDGWlyi0HHcXo=;
 b=Ek9kd2KiHAssTM5RcVshrUszljUMvWJftEDk3eJ/PeMkgQLs4w6opQUK5hIOoMsl6N
 g8UlQlAQQsNMpa01Qs67UQre6gekUCS+V8WWIzm1F+RQK6yb0MqipTn8oMlEnQaY2nuI
 +NR5BCsFPXTjQvWsMBmLDKW1LCE0Dmv0MOoAwabaZU8jVt8n3XLu7Z1t2yAwc/rQIur1
 AScUYe4tEe4jqUO+FeIEinDyyx36bsKudhjtOvfh6V148FAh+I01vws794QjnbBSw2rh
 FNtgXuWtUgIyNwodZ20P2QAkDDECkBZ+kP1u9PtTBm/VerzNP10D4LDZBbCfI/Lneu6W
 q8Dw==
X-Gm-Message-State: APjAAAUNg3TQrH2vefReeGYP1GGoQTiE6gJd6aftAcugAxML45UIKpmR
 GtR16kjjOQgWJOgg/dDOeqUfzDTEyvFI8ejAvDjBiw==
X-Google-Smtp-Source: APXvYqwD0Nnjl2ilMKcX7JLtCIohbjy57ftvEcQvZHfXfnwQVBVRflu/obDLwvOefPx4WOORXLX+QoS7mk8ezwP3wxQ=
X-Received: by 2002:a05:6808:289:: with SMTP id
 z9mr1199689oic.48.1582033330375; 
 Tue, 18 Feb 2020 05:42:10 -0800 (PST)
MIME-Version: 1.0
References: <20200218112457.22712-1-peter.maydell@linaro.org>
 <f87dbeeb-2259-9eb9-45c7-a30819eec2ee@redhat.com>
 <08b37e02-49b5-1485-aa71-83ead1adf407@redhat.com>
In-Reply-To: <08b37e02-49b5-1485-aa71-83ead1adf407@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2020 13:41:59 +0000
Message-ID: <CAFEAcA-AaDxCbLu3S2LO49Lt18s_aLmDC9XZ-kHtac33sdv_jg@mail.gmail.com>
Subject: Re: [PATCH v2] Avoid address_space_rw() with a constant is_write
 argument
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 18 Feb 2020 at 13:33, Eric Blake <eblake@redhat.com> wrote:
>
> On 2/18/20 6:56 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>
> >> +++ b/scripts/coccinelle/as_rw_const.cocci
> >> @@ -0,0 +1,30 @@
> >> +// Avoid uses of address_space_rw() with a constant is_write argument=
.
> >> +// Usage:
> >> +//  spatch --sp-file as-rw-const.spatch --dir . --in-place
> >
> > Nitpick, script is now scripts/coccinelle/as_rw_const.cocci.
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> >
> >> +
> >> +@@
> >> +expression E1, E2, E3, E4, E5;
> >> +symbol false;
> >> +@@
> >> +
> >> +- address_space_rw(E1, E2, E3, E4, E5, false)
> >> ++ address_space_read(E1, E2, E3, E4, E5)
> >> +@@
> >> +expression E1, E2, E3, E4, E5;
> >> +@@
> >> +
> >> +- address_space_rw(E1, E2, E3, E4, E5, 0)
> >> ++ address_space_read(E1, E2, E3, E4, E5)
>
> This feels a bit redundant.  Doesn't coccinelle have enough smarts about
> isomorphisms (such as 0 =3D=3D false, 1 =3D=3D true) that it could get by=
 with
> one @@ hunk instead of 2, if we come up with the right way to represent
> any isomorphism to a constant value?  But admittedly, I don't know what
> that representation would actually be, and your verbose patch works even
> if it is not the most concise possible.  So don't let my remarks hold
> this patch up.

My experience with Coccinelle has generally been that trying
to make semantic patches smaller and less redundant is futile
and a massive timesink. In this case as far as I can tell
Coccinelle has no idea at all about the existence of the 'bool'
type and that 'true' and 'false' are equivalent to 1 and 0.
Thus the 'symbol' declaration, otherwise it thinks that 'false'
is a random semantic identifier and doesn't look for a literal
match of it.

thanks
-- PMM

