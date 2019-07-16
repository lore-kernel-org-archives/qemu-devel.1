Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0041FC76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:01:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C0CAA21738
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 07:01:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="P4eshgUN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C0CAA21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHSc-0002XV-RO
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 03:01:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39024)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hnHSQ-00021I-EM
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:01:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hnHSP-0003F4-HB
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 03:01:02 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:33119)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hnHSL-0003BG-Bv; Tue, 16 Jul 2019 03:00:58 -0400
Received: by mail-qt1-x841.google.com with SMTP id r6so14249439qtt.0;
 Tue, 16 Jul 2019 00:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=TnJUM65uBcMIaHiYN7n5Wt/PcM5KenfjKYVz0ojBb2U=;
 b=P4eshgUNzzC96Ps/vPg0FH9cnhwkl+TUGZzA/CNjhlW3LYsftH15jqXrXqEGAin19B
 WL0V5x+qg0O3E45dVZI65SyQ0x9obKsizbHa/Tz5OlMDKCx3PcTW6Fe3zIIFIbGagQDw
 4nkqlMp3o9BucbDEK7E04mTGYjZYf0mJzqohk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=TnJUM65uBcMIaHiYN7n5Wt/PcM5KenfjKYVz0ojBb2U=;
 b=Qn9E8CNDheXFkD9KxuhqpKGF8zg9TgVaCPgEGUtadY+ol2ApXb6pcaQwIG959ZLjlS
 fYHdSJC/DudjKLTjcJPW+uNTBG286C094yyoWEUkeCPBfP8NE+69Gdpbs17p2qidVX08
 JefQQO4YZNxUCnuDPSHdsfF6QgIYXgEPhRJTKnfLbBd8x048TBaWsF+RzEanM8XlGBiA
 YRo6znbzMAMQdirjaX4q30DolmicmHruiiUVftuPe3uc8Bh6s9VOCTllMViuJBsk9bFq
 ow1Xq/vfnOLfhx3iGUuNiiJ3DwEqM1fPvVeGMe2VhViYsn6KlEtgDbwVho2/XA5KuvB+
 avCA==
X-Gm-Message-State: APjAAAVGfSSRkVBvI7jkZcPL2fOZVUC2ifPxdwjI9YqWkfj4c8mmkWnG
 SIRRTl2puPYmfjOWCkY8Hl4daHs1BEGn30Ww5Kw=
X-Google-Smtp-Source: APXvYqw/RQTGXyIHrclBJUHQbBoRl9HX7w1gLHTgxW/0UTIWPvc7UCWlhuDp8r95PcIJb8rLl9F+mutEhkJzebJKRCU=
X-Received: by 2002:a05:6214:1306:: with SMTP id
 a6mr22977497qvv.38.1563260455165; 
 Tue, 16 Jul 2019 00:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055150.4899-1-clg@kaod.org>
 <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
 <20190704101345.GC1609@stefanha-x1.localdomain>
 <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
 <CACPK8XdFUO6+Fx17Dry0D2QFhM885DugdvOkWnhgjxPc9VgG2Q@mail.gmail.com>
In-Reply-To: <CACPK8XdFUO6+Fx17Dry0D2QFhM885DugdvOkWnhgjxPc9VgG2Q@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 Jul 2019 07:00:43 +0000
Message-ID: <CACPK8XfZq1FvMBXLgS-WHoJy4s_L9k19hLW-XgBNoiY-DhGhWA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH for 4.1] aspeed/timer: Provide
 back-pressure information for short periods
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
Cc: Andrew Jeffery <andrew@aj.id.au>, QEMU Developers <qemu-devel@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 16 Jul 2019 at 06:54, Joel Stanley <joel@jms.id.au> wrote:
>
> Hi Peter,
>
> On Thu, 4 Jul 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
> >
> > On 04/07/19 12:13, Stefan Hajnoczi wrote:
> > > On Thu, Jul 04, 2019 at 11:26:53AM +0200, Philippe Mathieu-Daud=C3=A9=
 wrote:
> > >> CC'ing Stefan & Paolo for a non-ARM view on this...
> > >
> > > I'm not familiar with the various clock smoothing techniques implemen=
ted
> > > in QEMU and KVM, but this looks okay given that Linux guests expect
> > > this.
> >
> > Yeah, even KVM applies a minimum period of 200us to the x86 LAPIC timer=
.
>
> Can we please merge this so guests can boot on 4.1?

C=C3=A9dric pointed out this lacks my reviewed by. I had not provided it in
the past as I wondered if we could come up with a better fix. However,
I consider this a good fix for 4.1, and if sometime finds time to
further rework the timer model in the future then we can do that work
later.

Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Joel Stanley <joel@jms.id.au>

Cheers,

Joel

