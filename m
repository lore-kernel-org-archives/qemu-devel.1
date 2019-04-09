Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAA9C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:48:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1191E2077C
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 19:48:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AZHpecAc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1191E2077C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48270 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDwjh-00045U-Lf
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 15:48:49 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43502)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwiq-0003lg-RB
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hDwip-0007UF-VI
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:56 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:35681)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hDwip-0007Tb-Nr
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 15:47:55 -0400
Received: by mail-ot1-x343.google.com with SMTP id m10so16757160otp.2
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 12:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=/TFJ0+xV+CjbGjKcryNef6q8cMOWLagVruxOKTPM7y4=;
	b=AZHpecAcnNPM/tuQEDQJ3p7Uq5R2frfm7Kz4Yv2Z2uz33aQHxHP+IooRFK7o5NwDPW
	IwTCUWPATAgZTvLIWIex2vjG9NPaQi40DC76GXp4zUtjzFknrTdNERucxynUhHQfwhwb
	BAWFiJzV0Etb1a0isRl6LoqcbAdRiov/qx/NEgveehHwX/GgqgJmq/zmj+YwGfCS7Yav
	aKMNvcMHpkPAtty0W8g4MQ8diP0fLKH2rwTWms/8hlS8J/SsUBA8q/l3bae9Y64h8Mdw
	H7XRFGsYq3OS4TJkvmPO5GjDVzKikImNWg5Z/X62gbjHrC3MKNvJuRjaSKwRpraMadeY
	CcqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=/TFJ0+xV+CjbGjKcryNef6q8cMOWLagVruxOKTPM7y4=;
	b=lk260bQb8DJBmCgaZ3+DCQkxUrfq448tuPOPuCSyVfpfhitDysD8zaONi26QN6k0mI
	PLlWLEKjWhz1dkbojFQjJfwXv1lxaCV+KzpRaP03MtAi2VhxCavFm4D/SgcgGgqpCTPx
	iURvjgDmcLexyCRF/Rz2fggOidsTEvZdA8q6ORGxzyzz6OM5V7LwAmdJJOhxQHM45B0Y
	EbXOBrWhg0PsspgFUcw2L8lhQuHrzrfXyZsfsw1OfJFW5miSYhp3rzQkaSxMVZ6lFUcH
	nxTSB8vSM19+pf7kMSo7q6WQ3zcVZgTwo8xFXUye8Js0ubzzETDvPMa08+HxFrQcNiIA
	QbCg==
X-Gm-Message-State: APjAAAUrpCsMB2qtn/PigtbiKYBuNNBAmjDnOJbWaArP0a2T86OQtqA/
	7OMMbe+53WwULonoFDx+Ft+j3DfvH3CAt8mps9hz9A==
X-Google-Smtp-Source: APXvYqy9vNRmcFrekxHqmiQGU0wyPDZ/FkRVX6tiF1N5MAbBYTjjT215UoLs4S+KYTaGDc4ouvZO0e1QrJOdCUFutWY=
X-Received: by 2002:a05:6830:1044:: with SMTP id
	b4mr26262796otp.274.1554839274335; 
	Tue, 09 Apr 2019 12:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20190409151830.6024-1-peter.maydell@linaro.org>
	<87ef6byye5.fsf@trasno.org>
In-Reply-To: <87ef6byye5.fsf@trasno.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 10 Apr 2019 02:47:45 +0700
Message-ID:
 <CAFEAcA87-z9Su8qYOJoG9nVXnAYShwKBrDEpP+55WK5SVrnq=g@mail.gmail.com>
To: Juan Quintela <quintela@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH for-4.0] migration/ram.c: Fix
 use-after-free in multifd_recv_unfill_packet()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
	"Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409194745.p4KGvkzMLMVbIMyTnBckQYUKRgnbwj-EUE4r6FWy6tg@z>

On Tue, 9 Apr 2019 at 22:42, Juan Quintela <quintela@redhat.com> wrote:
>
> Peter Maydell <peter.maydell@linaro.org> wrote:
> > Coverity points out (CID 1400442) that in this code:
> >
> >     if (packet->pages_alloc > p->pages->allocated) {
> >         multifd_pages_clear(p->pages);
> >         multifd_pages_init(packet->pages_alloc);
> >     }
> >
> > we free p->pages in multifd_pages_clear() but continue to
> > use it in the following code. We also leak memory, because
> > multifd_pages_init() returns the pointer to a new MultiFDPages_t
> > struct but we are ignoring its return value.
> >
> > Fix both of these bugs by adding the missing assignment of
> > the newly created struct to p->pages.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
>
> ouch,
>
> good catch.
>
> Reviewed-by: Juan Quintela <quintela@redhat.com>

Thanks for the quick review. Applied to master for rc3.

-- PMM

