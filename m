Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F8EAC433FF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF9CF2086D
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 10:35:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cpDKUiw1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF9CF2086D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvJHw-0003Nb-4Q
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 06:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hvJHT-0002hS-DB
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:34:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hvJHR-00006T-Nv
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:34:55 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:38155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hvJHR-00005U-Hd
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 06:34:53 -0400
Received: by mail-ot1-x344.google.com with SMTP id d17so102380499oth.5
 for <qemu-devel@nongnu.org>; Wed, 07 Aug 2019 03:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GHi1f+voEbXN8hKlRxap0utKOX1Tjporwl0c9C0XDl4=;
 b=cpDKUiw1I/jyIsGTm+dDejVGNs94pPIqMuqaOXCMaBHSDS9cchAV+uye19rqEnDQpe
 VHk2UVwa2JadUGiFnUQgMNzlafT+8BTb7mhNUepAHiSQGz0KmM3cB60SdYp6DwBA97LR
 mZPX73Cl3/ZLthzBFgX7tEkMx5ibJVZiKQWPmrlJhx6DhT4T0F2uxefQtlCxhyU2sLQn
 StUMCgnHaygIDZjGAK0RkVvlZOXqUPa5pDbUPbz5jOavbRgABH8HTsp58Hf/aohI63V5
 49T7/cC69N1HjLFABicgvPhgNsCVQNSOy4NuyjISiQEqpaOZZaejL4OmVtsJx61QvRhZ
 0H2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GHi1f+voEbXN8hKlRxap0utKOX1Tjporwl0c9C0XDl4=;
 b=G8dJwiBGZptZqA0CoHGfor7Qi/0gzD6j32hJ9idvrX12tAENe/IHJ88NriKZy0qNNW
 YsxjMOuBtWJOfP4xZOIWQqp3hw6dgV2DqkVO6O4QsVN16ArHFGP8QRuFghqbXWEn+Bkh
 12HOn5huUSm825Nb3f12iVSYQdyVh3f3a8blTGN3+o/D2km3wVKn1W5J7GiQ/lwRiaCa
 P4wgYTrUQaSKs+Nb9YJmdmoBJhsgrb1pF/dCZIhhnjCW+JmOfEfLC1Py15Q84LHxzC28
 scTxDIpSyunFBDq2l/TfQtJ4beMCmjmW9a5pNQ2eebvpLn7Aax+HcwkOzWsWvWZooxnn
 jc4w==
X-Gm-Message-State: APjAAAU15UtDdLUkbB7KryCADSFbuuvtT7ymVFYAk+wNbwWw6JZcLjG6
 xFEe04U/2mICkxGeqAA8/iJASuG7gh3MpaeFt1I90A==
X-Google-Smtp-Source: APXvYqzgKBVaFc7+ZzBSemdPEhqcLzr3H63/JJXF+IJf02F1bSlSaDJac0QtDR6QrRQipjBcIDNpCJp/E0Pekyc/d/0=
X-Received: by 2002:a9d:711e:: with SMTP id n30mr6609741otj.97.1565174092162; 
 Wed, 07 Aug 2019 03:34:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-10-damien.hedde@greensocs.com>
 <20190731063044.GG2032@umbus.fritz.box>
In-Reply-To: <20190731063044.GG2032@umbus.fritz.box>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 7 Aug 2019 11:34:41 +0100
Message-ID: <CAFEAcA-=rMgKuhtq4AT+QohRXf71biNFDRQaxMctrro7mTV4kQ@mail.gmail.com>
To: David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH v3 09/33] add doc about Resettable interface
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
Cc: Fam Zheng <fam@euphon.net>, Collin Walling <walling@linux.ibm.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Edgar Iglesias <edgar.iglesias@xilinx.com>, Hannes Reinecke <hare@suse.com>,
 Qemu-block <qemu-block@nongnu.org>, David Hildenbrand <david@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 31 Jul 2019 at 07:33, David Gibson <david@gibson.dropbear.id.au> wrote:
>
> On Mon, Jul 29, 2019 at 04:56:30PM +0200, Damien Hedde wrote:
> > +The function *resettable_reset* is used to trigger a reset on a given
> > +object.
> > +void resettable_reset(Object *obj, bool cold)
> > +
> > +The parameter *obj* must implement the Resettable interface.
>
> And what happens if it doesn't?  This function has no way to report an
> error.

Trying to reset an object that isn't actually resettable would
be a programming error -- I think asserting is a reasonable
response to that.

thanks
-- PMM

