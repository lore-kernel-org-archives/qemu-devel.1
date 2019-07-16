Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 151B9C76188
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:55:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D79682145D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 06:55:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="mujOGOqC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D79682145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnHMu-0007Pq-Vn
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 02:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37225)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <joel.stan@gmail.com>) id 1hnHMj-0006uU-PO
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:55:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1hnHMi-00079j-RU
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 02:55:09 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:37736)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1hnHMc-00070C-SL; Tue, 16 Jul 2019 02:55:03 -0400
Received: by mail-qt1-x841.google.com with SMTP id y26so18425204qto.4;
 Mon, 15 Jul 2019 23:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=usensxpkP49U49PKDqI42Xxl/kfLbhduueChDwmz3K4=;
 b=mujOGOqC7rBngmL1oo23bhsSFuXzdfTOQ1T9J/1k82QOioccqV5RrWOw6eOZux+Hv1
 zK9z5lLRlndkaMuMF2BWr/o/QNdnDVo4TtKrIyCq5yX2HxtzlKoVDWwr3Q1thdd3XT64
 aw/2GXyPqzq36MhvmPB7WKUe4VfdAUtjHi6XQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=usensxpkP49U49PKDqI42Xxl/kfLbhduueChDwmz3K4=;
 b=Gk520HtLFgKmYz6IKXL1OuoArpBn1WQdmMSzN2R0YRr7fid37y9NPrBIWDvpSmVl4P
 jwNEfFT3ACzwUGA1y+E8QzFfs3hqlb3EuVfE4T/ipY+6NloGtblOke4vVDDH+2DXHMYa
 HF0ETh1uIHvKb+UKnM9sLr8unvO2dOaPOF+ZN0940W3hbTpraMUgsE2sqLdcC3bH6IG5
 KkWb9K4dsMZ7uPNMAaLDaaM6qALaGoEfcFbHGLKYPmjyBpnrH5zrWLlw+T2OG8MyvmuJ
 ZysyNNzy97boDMcY7u1xqC4tqmoE/g3TrwpKZQg4Alo4uQ3jbZJzJBqy41lZIwcv8DGJ
 4PQQ==
X-Gm-Message-State: APjAAAXXFm8OuPQETD9hdIWJvzdZFDnmriAu/NRhZGr6rSesnMRlUBpo
 /HA8x9il80Dazc53Lkh2aElAcSREp8YmXmENDcQ=
X-Google-Smtp-Source: APXvYqwykvTarS/l2maKnZcuje8bvfubs3i/lWMFSignKUIq9OlBhYE/zPQjY1pq1RlMmDeH/1tMwa/MpUYokdFDuCU=
X-Received: by 2002:a0c:afd5:: with SMTP id t21mr22451648qvc.105.1563260101260; 
 Mon, 15 Jul 2019 23:55:01 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055150.4899-1-clg@kaod.org>
 <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
 <20190704101345.GC1609@stefanha-x1.localdomain>
 <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
In-Reply-To: <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 16 Jul 2019 06:54:48 +0000
Message-ID: <CACPK8XdFUO6+Fx17Dry0D2QFhM885DugdvOkWnhgjxPc9VgG2Q@mail.gmail.com>
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

Hi Peter,

On Thu, 4 Jul 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 04/07/19 12:13, Stefan Hajnoczi wrote:
> > On Thu, Jul 04, 2019 at 11:26:53AM +0200, Philippe Mathieu-Daud=C3=A9 w=
rote:
> >> CC'ing Stefan & Paolo for a non-ARM view on this...
> >
> > I'm not familiar with the various clock smoothing techniques implemente=
d
> > in QEMU and KVM, but this looks okay given that Linux guests expect
> > this.
>
> Yeah, even KVM applies a minimum period of 200us to the x86 LAPIC timer.

Can we please merge this so guests can boot on 4.1?

Cheers,

Joel

