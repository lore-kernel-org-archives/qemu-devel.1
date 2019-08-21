Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C0F1C3A589
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3667F22DD3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 03:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=jms.id.au header.i=@jms.id.au header.b="Wwx1eqz4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3667F22DD3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=jms.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43658 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0H9X-0001tj-4j
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 23:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43642)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <joel.stan@gmail.com>) id 1i0H7L-00018e-9C
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <joel.stan@gmail.com>) id 1i0H7K-0008PN-6K
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 23:16:59 -0400
Received: from mail-qt1-x843.google.com ([2607:f8b0:4864:20::843]:40085)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <joel.stan@gmail.com>)
 id 1i0H7H-0008NA-KN; Tue, 20 Aug 2019 23:16:55 -0400
Received: by mail-qt1-x843.google.com with SMTP id e8so1328644qtp.7;
 Tue, 20 Aug 2019 20:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jms.id.au; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=HefSvfC8MkuDZ3t3Fra2/mWNZ34tCHmc7DbjtKktUlg=;
 b=Wwx1eqz4a34jRLEMFkT67o7h6p+5u6DkCPdNp/SyGtSlThBv8BMFVxRGBYevzw+s/h
 U2NeRr5CN/msQxu9W+o+d9tmQ51nxiNd1KXPQx0cssydDUSMGeUMdCYmYJ/p7rDJwD6B
 mmpsOrtpMjmPck1KEb0kmEYPt1akRFgHDFTNM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=HefSvfC8MkuDZ3t3Fra2/mWNZ34tCHmc7DbjtKktUlg=;
 b=XNiDcyYm3mA7cnyGRKbnWGNRBWQkgoMkUrKCgzwSC5n5m26HDNWyWqCkfKq5PTA4Xb
 ioDOEKJy9rKssQ/SakqhubZ6ajs6KdU7GOJs3EL1fJIagFeyDo2BSXocwCq3JbXRaaNG
 e9kcmW9MgOc8T7V2H/MQLwLXhI61QDOs0ewsDtADGXpENOh1jON4VM4F0iBC6SSZjhxI
 MbAOr/Y8h8mkor57BK9luhObM+1rJZ/DBOPw74JzJhoEstOEm9vyuLIdMlFfYJqVPpTV
 t1OnOdCjYaZCRJhJuHXvuaWhYrqSCNaTtatqThdzy+MzKuy8fb/dEPPrefYDMCVRRx3V
 OShQ==
X-Gm-Message-State: APjAAAXtX2qRw9d6VmyD6l4OBq/hiXBhq1hhToDJDMGMEV6FF7WZX/L5
 qwWzPvPi8u+mPDo3+YIHEMTw3mzo0jelRuxoXgE=
X-Google-Smtp-Source: APXvYqxcaAdtiB0NAU9+vzab644npVO1OHqmatimmknY2cCQHL/2CgLF4z+MTiiyzbNzVb2eNgIegHhsu9DACJJI1Cg=
X-Received: by 2002:a05:6214:12ad:: with SMTP id
 w13mr7153220qvu.172.1566357414548; 
 Tue, 20 Aug 2019 20:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190704055150.4899-1-clg@kaod.org>
 <cd1f8a48-27cb-5cc5-1fd2-46f1597a7094@redhat.com>
 <20190704101345.GC1609@stefanha-x1.localdomain>
 <b304e4bd-1315-b1be-6c48-add99df92626@redhat.com>
 <CACPK8XdFUO6+Fx17Dry0D2QFhM885DugdvOkWnhgjxPc9VgG2Q@mail.gmail.com>
 <CACPK8XfZq1FvMBXLgS-WHoJy4s_L9k19hLW-XgBNoiY-DhGhWA@mail.gmail.com>
 <f5ed785c-027d-66fe-aba2-d03001b44162@redhat.com>
In-Reply-To: <f5ed785c-027d-66fe-aba2-d03001b44162@redhat.com>
From: Joel Stanley <joel@jms.id.au>
Date: Wed, 21 Aug 2019 03:16:42 +0000
Message-ID: <CACPK8XcG4JRq0hAUPu4+vv-j1TFNwwsu5iv6X9M-qAgm0atTRA@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::843
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

On Tue, 16 Jul 2019 at 07:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 7/16/19 9:00 AM, Joel Stanley wrote:
> > On Tue, 16 Jul 2019 at 06:54, Joel Stanley <joel@jms.id.au> wrote:
> >> On Thu, 4 Jul 2019 at 12:26, Paolo Bonzini <pbonzini@redhat.com> wrote=
:
> >>> On 04/07/19 12:13, Stefan Hajnoczi wrote:
> >>>> On Thu, Jul 04, 2019 at 11:26:53AM +0200, Philippe Mathieu-Daud=C3=
=A9 wrote:
> >>>>> CC'ing Stefan & Paolo for a non-ARM view on this...
> >>>>
> >>>> I'm not familiar with the various clock smoothing techniques impleme=
nted
> >>>> in QEMU and KVM, but this looks okay given that Linux guests expect
> >>>> this.
> >>>
> >>> Yeah, even KVM applies a minimum period of 200us to the x86 LAPIC tim=
er.
> >>
> >> Can we please merge this so guests can boot on 4.1?
> >
> > C=C3=A9dric pointed out this lacks my reviewed by. I had not provided i=
t in
> > the past as I wondered if we could come up with a better fix. However,
> > I consider this a good fix for 4.1, and if sometime finds time to
> > further rework the timer model in the future then we can do that work
> > later.
>
> Agreed.
>
> >
> > Reviewed-by: Joel Stanley <joel@jms.id.au>
> > Tested-by: Joel Stanley <joel@jms.id.au>
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

HI Peter,

Is this one still in your queue?

Cheers,

Joel

