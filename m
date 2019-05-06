Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E05C04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:46:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84298205C9
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 08:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I818EKFU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84298205C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52959 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNZGE-0004AL-S3
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 04:46:10 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57062)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hNZEw-0003MO-3l
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:44:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1hNZEv-0004jF-1d
	for qemu-devel@nongnu.org; Mon, 06 May 2019 04:44:50 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:46449)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <atar4qemu@gmail.com>)
	id 1hNZEu-0004iv-T9; Mon, 06 May 2019 04:44:48 -0400
Received: by mail-io1-xd44.google.com with SMTP id m14so10418065ion.13;
	Mon, 06 May 2019 01:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=uKB1RqKEVNbuSQHNymYkQARx2BavFHPIlbcq1bAyMqo=;
	b=I818EKFUOgjCgLaHul3VTPBMiyF8XyhmfBymEfGq3bskZYRj3RVsxXH+MD7BMgt5Zx
	mhHeIAQMaXuXMDdu38ZR+2nelk7iLeGbT1PfRRA2YXFGxgk4OUBI/XwkZ6dDfbZhaGoH
	XIb1YmMkeB/8xzxX/1JuXmcnvueMOzJA0ShhTP5ntnxnOVLrTTUBinTxLz3h3AuuVhac
	AUdMBQ0qT/HvgSfdrURD9x+ZtpEDfZpC1d/5dgzDh6JmEfnRADGlQmr4o+0A3t6+4Agd
	nrOWLIXUR+8joSu6YMwV+jH5JsmD6+FbXsA2Ed95B7Chv8d5bmBLHIqEDeTqRvlNdrMW
	1jYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=uKB1RqKEVNbuSQHNymYkQARx2BavFHPIlbcq1bAyMqo=;
	b=HdHes99CFzPYDvEfdRDqVFKZJFb93IGoGmKGXPlBi+/FHKB/sw0li5Y68ejFQlAh+l
	zLyehDOhIwJsxj0xksMcEohCGYlBGb1CgA+UVoInvaGcg8HS26KEdlfNDeU8yJw+RREz
	GcMJ/iDkUVAWeBDnuc/ZT6Uka0Ec0+n+gnHnlN9ue/uVAwm6r7sSirSla/YILlq66PfE
	Szx7DzPRWeGNNidAb4ZGkrQyWay8LBc/bwM9YO0MIc9zBqDJCT97W4sBXOr/f7dFP6B5
	uXjpzJyWhdxGXRdBD51Z+K4soUq0hlxZeUvG3MLIR6Bh2Nb4A5GpDmQzZlDS89Yncrvq
	lb5g==
X-Gm-Message-State: APjAAAXC15133MlGeAG388BLa95JxqHbibOM0vR/4ZBkg5miFiGqQPzA
	nMJHN3+DACLEQ+VHf43T98Hfw/tJEwGkSoS+dc8=
X-Google-Smtp-Source: APXvYqzSnFJ9GtBkixX0xZcLOOYKidRi1gTPGw9P0t5Ol1RepzljuoNvr9Bvm43ayJ6geyNxRtCkxRHSbcW2uaaMhQU=
X-Received: by 2002:a05:6602:1c1:: with SMTP id
	w1mr15066163iot.75.1557132288102; 
	Mon, 06 May 2019 01:44:48 -0700 (PDT)
MIME-Version: 1.0
References: <1557003754-26473-1-git-send-email-atar4qemu@gmail.com>
	<1557003754-26473-4-git-send-email-atar4qemu@gmail.com>
	<7e282cd4-f402-c807-b9aa-7034d04031b6@ilande.co.uk>
	<debd00a6-dcc0-83a0-b0a8-1184d6da6d9c@redhat.com>
In-Reply-To: <debd00a6-dcc0-83a0-b0a8-1184d6da6d9c@redhat.com>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 6 May 2019 10:44:38 +0200
Message-ID: <CACXAS8CM6NO3PFZUfymvO2PuhX_=rUJfB8W5RUkABKRvjFTr+A@mail.gmail.com>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::d44
Subject: Re: [Qemu-devel] [PATCH v2 3/3] hw/isa/i82378.c: use 1900 as a base
 year
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
Cc: "open list:PReP" <qemu-ppc@nongnu.org>,
	=?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
	Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
	qemu-devel <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, May 5, 2019 at 5:19 PM Philippe Mathieu-Daud=C3=A9 <philmd@redhat.c=
om> wrote:
>
> Hi Mark, Artyom.
>
> On 5/5/19 12:46 PM, Mark Cave-Ayland wrote:
> > On 04/05/2019 22:02, Artyom Tarasenko wrote:
> >
> >> AIX 5.1 expects the base year to be 1900. Adjust accordingly.
> >>
> >> Signed-off-by: Artyom Tarasenko <atar4qemu@gmail.com>
> >> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> >> ---
> >>  hw/isa/i82378.c | 4 +++-
> >>  1 file changed, 3 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
> >> index a5d67bc..546c928 100644
> >> --- a/hw/isa/i82378.c
> >> +++ b/hw/isa/i82378.c
> >> @@ -107,7 +107,9 @@ static void i82378_realize(PCIDevice *pci, Error *=
*errp)
> >>      isa =3D isa_create_simple(isabus, "i82374");
> >>
> >>      /* timer */
> >> -    isa_create_simple(isabus, TYPE_MC146818_RTC);
> >> +    isa =3D isa_create(isabus, TYPE_MC146818_RTC);
> >> +    qdev_prop_set_int32(DEVICE(isa), "base_year", 1900);
> >> +    qdev_init_nofail(DEVICE(isa));
> >>  }
> >>
> >>  static void i82378_init(Object *obj)
> >
> > Is this true for the 82378 in general, or is it a particular quirk of t=
he 40p
> > machine/PReP specification?
>
> This is indeed incorrect (see
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02452.html) so:
> Nack
>
> Artyom: I did wrote the patch and included it in another series based on
> top of Joel Stanley's
> https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg00657.html
> which is also depending of another from C=C3=A9dric, so I'll just extract=
 it
> and send directly, sorry for the delay.

Thanks, it works for me.

--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu

