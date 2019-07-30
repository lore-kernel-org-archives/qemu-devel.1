Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C446FC433FF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:01:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C99A206E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 14:01:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yeqhFwI2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C99A206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33190 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsSgg-0001Qd-OQ
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 10:01:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54768)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsSfd-0000VC-Jo
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsSfc-00009f-9c
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:05 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:37596)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsSfc-000099-2T
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 10:00:04 -0400
Received: by mail-ot1-x342.google.com with SMTP id s20so893456otp.4
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 07:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ozn85kLHHdYbnp7yoE6ellLtbD6HtMj9acchm0i6WTA=;
 b=yeqhFwI29UCqTGtz5SKWJNYgF8q2kwqzYFqe3FE4z/O4rtVK3+tKAqYAkGZfKpJ1yq
 yHCIwqWLpNeOnfOxBANGwy160WDHsDYhnMA5u7EFpfXfDAFS48l8/1jow7A1oo2fdM0u
 Yg1F3Q6pMO6GSp8b/a5q+X6/v7ih+adqKLaWQ0adBuiLtKnRXYfbBoSwqP/Nfx0riesr
 TyXtLj1PZl/okQsFojpBNi+PdQh6AVzLln2guxLSmP2jGSk2/uBOKZQKt9tSVirfqsGy
 k1mdhovZzAEGDzU9XaX+qHpVKNul6SnwUdKK31dxOoNxYwBW3bB0yKXsrBRPA1F9vCP3
 CHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ozn85kLHHdYbnp7yoE6ellLtbD6HtMj9acchm0i6WTA=;
 b=O3a6rsGNlIblryQTwVk+NPzrW9E2hgxY5+1+5sbBW6dNz3ou1V1rG5F0xTzjXgAs/y
 CliZIIj1V0TOUA7DN4TeQPm9lRPfB9auN6JOlGtH2Glxp5r5eLc9yCUbSePRvPlyewe5
 qu5Dy7pmM45vwpZ+SCAPIoPoKkEMT6oDK2GlAtBT6XRzI4mpUq6NCjtHzPiT9CjWQxOp
 iKSkO5Ru+8WzVB0roFlZAQnP9ZGdEvcmvm+jA/seKBhNk/bquzfUAglj07oO5zoIasH4
 2o0/Cdn531jlEaRaZ5IoFmH4UU3L+PbOtJYpmDtYoLN4PxGNL3NRftgX3bxN9h2BH1TN
 InkA==
X-Gm-Message-State: APjAAAVY8Wzac3TZKgBNJ+esiFeqGBjWb8RDh1BPlH59xxsb8r8jEul/
 43Z92zyR9kubjh9GYdAqCj8pPBSwkFS92fl8gZed6Q==
X-Google-Smtp-Source: APXvYqzTMAJaqpdIV7b/fTERP8eZj5KhBkD0ItzWYLAOuRQVJ+AsCW+qx4LX6mKzqWlm5O5T+yQdA+WOJX1313u98rc=
X-Received: by 2002:a9d:6a0f:: with SMTP id g15mr56622087otn.135.1564495203082; 
 Tue, 30 Jul 2019 07:00:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190729145654.14644-1-damien.hedde@greensocs.com>
 <20190729145654.14644-2-damien.hedde@greensocs.com>
 <20190730154209.2049f10a.cohuck@redhat.com>
 <CAFEAcA-rwBiXkDEDuT-=KQVJ2A2ob16=P0obbZBPUfZeYXy+dQ@mail.gmail.com>
 <20190730155547.7b201f5e.cohuck@redhat.com>
In-Reply-To: <20190730155547.7b201f5e.cohuck@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 14:59:52 +0100
Message-ID: <CAFEAcA_BU3DECLVv2QD_RshR0OL3=GqGwsm0YAmEAE6_SpW=HA@mail.gmail.com>
To: Cornelia Huck <cohuck@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v3 01/33] Create Resettable QOM interface
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
 Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, John Snow <jsnow@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Damien Hedde <damien.hedde@greensocs.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Mark Burton <mark.burton@greensocs.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 30 Jul 2019 at 14:56, Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Tue, 30 Jul 2019 14:44:21 +0100
> Peter Maydell <peter.maydell@linaro.org> wrote:
>
> > On Tue, 30 Jul 2019 at 14:42, Cornelia Huck <cohuck@redhat.com> wrote:
> > > I'm having a hard time figuring out what a 'cold' or a 'warm' reset is
> > > supposed to be... can you add a definition/guideline somewhere?
> >
> > Generally "cold" reset is "power on" and "warm" is "we were already
> > powered-on, but somebody flipped a reset line somewhere".
>
> Ok, that makes sense... my main concern is to distinguish that in a
> generic way, as it is a generic interface. What about adding something
> like:
>
> "A 'cold' reset means that the object to be reset is initially reset; a 'warm'
> reset means that the object to be reset has already been initialized."
>
> Or is that again too generic?

I think it doesn't quite capture the idea -- an object can have already
been reset and then get a 'cold' reset: this is like having a powered-on
machine and then power-cycling it.

The 'warm' reset is the vaguer one, because the specific behaviour
is somewhat device-dependent (many devices might not have any
difference from 'cold' reset, for those that do the exact detail
of what doesn't get reset on warm-reset will vary). But every
device should have some kind of "as if you power-cycled it" (or
for QEMU, "go back to the same state as if you just started QEMU on the
command line"). Our current "reset" method is really cold-reset.

thanks
-- PMM

