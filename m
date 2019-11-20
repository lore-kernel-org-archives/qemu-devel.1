Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDF1C432C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34FB0206DA
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 14:51:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCDgZptD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34FB0206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58916 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXRJy-0001YO-5V
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 09:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55012)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXRJE-0000oh-Iy
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:50:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXRJD-0002Aj-Fe
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:50:20 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35822)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXRJD-0002AM-9I
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 09:50:19 -0500
Received: by mail-wr1-x444.google.com with SMTP id s5so144786wrw.2
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 06:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fq/kj87Wg1JR7Uc7h1f1+mYl8QVYHl09zCw6Rv7RU84=;
 b=hCDgZptDarq/0WVafAB2lAMT1SCzpIt8ti3sFG7E+vcRDDGMq7UGugwh/KWlI4SxqA
 hc9q4iuEeQdx24v+wWmVRAcyOqPKtr0p93N5AlPmvV/NzTZOm6UG4uoaBSLSYUD0Puyr
 ZdgoS5y4umLeu2AYdIt/WDn5YWFaxAWYbTybu5vkZ4m4gqWfFvGamULIowJdnfj7fi3h
 5au/zV7AYk/+Rfr4SOd+OlXDd1Uphj2S9T6DnCEbicqJ1qabVqDzco2NxGONa++92HmU
 OMXU86N22l4H4TeqRLm1oHh+H6MnzvHD3rgs5ELAknKGi9ezqewqWE0k0c+Th4b1Ss1B
 +S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fq/kj87Wg1JR7Uc7h1f1+mYl8QVYHl09zCw6Rv7RU84=;
 b=j5CTo9b4hQ2kTVBmQNm6tqzNkqFJwMAuNbIYjHX8Gz2gov8/BzH0k+Axk2tGM3FGWr
 pR4NRm0f+wpxeRUb/u2EY7jMrMYnLtKZDKInK4m0VfQTKwI0KOYfTzuFogfAzz/cPpNC
 U9LoTEnNGmEaz1KMtphABNY3AKRPThFCAXi3m2GvoUgSaHkTFoVJSD0JbfzkJlsIl0IP
 tqC1du/fK529f6JuvGQRSpqItro72WpjGRV7m9bZZuVDNOMdMmg/Ecf6Tqq+r5KAj70k
 nwL0ntGEtU7Vz1ZTZRq5/IvRom3K5bfUkRYWzDmvDb8hgAO8OQP6KO0cotoNNdB1ubgz
 USsg==
X-Gm-Message-State: APjAAAXmgCnOPcWvgdOCM+CELEY7atHGMk/Vqiywlb8dzKnkNUneHzWX
 DpZ6tehxPYxHb6O2TLw6T8Atk3F3Pcz/H/CYD/E=
X-Google-Smtp-Source: APXvYqwkD2SyzTo2EJXKjtDTyK0F4mhM10SkirITiMShVmPg0bx73pxnouaXXMtMP84jgSMG4+s6Flq/EZjxfwphdUY=
X-Received: by 2002:adf:f20f:: with SMTP id p15mr3600957wro.370.1574261417569; 
 Wed, 20 Nov 2019 06:50:17 -0800 (PST)
MIME-Version: 1.0
References: <20191107192731.17330-1-marcandre.lureau@redhat.com>
 <20191108045257-mutt-send-email-mst@kernel.org>
In-Reply-To: <20191108045257-mutt-send-email-mst@kernel.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 18:50:05 +0400
Message-ID: <CAJ+F1CJ3NHq1fcvpkMy+SsGxV2fr+dPeAK4bjn4yduaTA8QJ+A@mail.gmail.com>
Subject: Re: [PATCH 0/3] Some memory leak fixes
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, QEMU <qemu-devel@nongnu.org>,
 Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Fri, Nov 8, 2019 at 1:54 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Nov 07, 2019 at 11:27:28PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Hi,
> >
> > Another bunch of fixes spotted by ASAN when running check-qtest-x86_64.
>
> So who's merging this?
>
> > Marc-Andr=C3=A9 Lureau (3):
> >   virtio-input: fix memory leak on unrealize

This one is still pending. Michael, could you take it?

> >   qtest: fix qtest_qmp_device_add leak
> >   cpu-plug-test: fix leaks
> >
> >  hw/input/virtio-input.c | 3 +++
> >  tests/cpu-plug-test.c   | 2 ++
> >  tests/libqtest.c        | 1 +
> >  3 files changed, 6 insertions(+)
> >
> > --
> > 2.24.0.rc0.20.gd81542e6f3
>


--=20
Marc-Andr=C3=A9 Lureau

