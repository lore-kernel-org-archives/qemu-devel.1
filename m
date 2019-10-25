Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD6F7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 978802070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 07:57:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NY0ymcJK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 978802070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNuT1-0006UP-Ka
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 03:57:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41850)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu4c-0006wr-U0
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:31:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNu4b-0006PS-HE
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:31:50 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNu4b-0006Ow-BX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 03:31:49 -0400
Received: by mail-ot1-x344.google.com with SMTP id 41so1290818oti.12
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 00:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=rxcBsoyYLU1WL5Mfud5cWNDsJcaw3MUZtt+g15iNTJc=;
 b=NY0ymcJKW7rLmALoiEXtLFG6no1VuE7XTEOezvxU0Sfts85bm804AbDhyaZwB9cR8q
 +FANfhAZaLgKzWoesHJjzBX3cBR34FB8FKTI6xSYnnLBEMrOU1u3fNk76gsfQ+cVbsT/
 8Yt0453JmA1xxuHXmQvFgDC82Ks9PZWPtpzt/3Y11FY9VGwngY3Ylhckek5+RBHnlBtU
 R0jo0P+V8T6F2gfDsubRzRt4o197rEZWXe4LXClo603HKReBAZVBSs7Ne3oCHIlZoWe3
 My8KhXM7FQRzIgEjiJJJXr6s85Xxt12rb5FVSkgm8pmduywO1HdeOvwkQKfVNDvgPITD
 0Z9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=rxcBsoyYLU1WL5Mfud5cWNDsJcaw3MUZtt+g15iNTJc=;
 b=Bb0Z/8WkQzSNeNeAix2jjjITZVRwItHmVV45JMnW6zqdd4E/nay3OIvJJXLVTfwNnr
 6wN5DbTGApMeMw8CoQ+eScprvdfPxCh3PcifmrtKKe9kRraUfcWoHM4JPTO/EUsz3XKl
 K9T34+sOFtM4eemSh9mA7Sw6F3R3Q8uEo/EfNy/HUbk7PN2Gftu4qSCWOOYhpkZXBhO9
 XnpuHjjrwDrUpmVM/9hl1FlUy+1BCnVVM+UnfYdS7ef+CH6WyMOWi563icIXvZvr/Ldm
 MJEqbxEX0nzWyZXBNpmG6uh5t+GNPWDUCT3hXTCUY6a03YZ6kVlaZFpuFgsT7oKbKnLW
 7bJA==
X-Gm-Message-State: APjAAAUrz6Hrz+hu3eAtvdhZIT9wsTHSPYPZogeaKJmTJEm6iTzLIIaY
 l+zVX3/PFIcUlhYca3XsM4w6GNcdwZZa3uk/6Z7ENQ==
X-Google-Smtp-Source: APXvYqz6jOnCa8PHF8+sCO7d6MpRX/th1V9CZLpJ2hbrdmo1qS5FPX+Kkny7PtaH+F+8lFXz5JQ8e+HG2KoXnrHNl78=
X-Received: by 2002:a05:6830:4c1:: with SMTP id
 s1mr1613368otd.232.1571988708420; 
 Fri, 25 Oct 2019 00:31:48 -0700 (PDT)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-22-marcandre.lureau@redhat.com>
 <2d027692-e178-c1c8-8384-ad70ed345f29@redhat.com>
 <CAMxuvay9kroZUo7ZbdhJqKAdp52rMmLGv0LBvktb68B2CKg+Mw@mail.gmail.com>
 <2b9352d7-f4de-bd5c-62c5-cebec79e1c48@redhat.com>
 <CAFEAcA_A4edo3fQBJux6QBxkCf_r_EdrmYgv5OPidWDdn4aD8g@mail.gmail.com>
 <20191024180714.GY6744@habkost.net>
In-Reply-To: <20191024180714.GY6744@habkost.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 08:31:37 +0100
Message-ID: <CAFEAcA9yvw=fbp91A23o-t-om-axuAOwW4eMf2+pyQE-3z88TA@mail.gmail.com>
Subject: Re: [PATCH v3 21/33] lance: replace PROP_PTR with PROP_LINK
To: Eduardo Habkost <ehabkost@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Corey Minyard <cminyard@mvista.com>, Paul Burton <pburton@wavecomp.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel <qemu-devel@nongnu.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Fabien Chouteau <chouteau@adacore.com>,
 qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <rth@twiddle.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 24 Oct 2019 at 19:07, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Oct 24, 2019 at 12:52:28PM +0100, Peter Maydell wrote:
> > I don't think this is a good plan -- users shouldn't have to know
> > about the memory map of their boards. Plus it doesn't deal with
> > the complications of multiple address spaces, DMA, wiring up
> > irq lines to an interrupt controller, SoC reset handling,
> > clocks, power-managment...  Command line -device was designed
> > for pluggable devices, where in the world of real hardware
> > the device can be physically plugged and unplugged and there's
> > a clear interface that can be modelled. You can't add an
> > extra UART to an embedded board in real hardware either.
> >
> > The only plausible argument I've seen for command-line
> > plugging of embedded devices is as a sort of side-effect
> > of having a configuration language syntax for them for
> > the purpose of being able to write board models as
> > data-driven config files rather than in C code. But
> > that would be a lot of design and engineering work, and
> > if we want that I think we should approach it forwards,
> > not arrive at it backwards by adding gradual tweaks like
> > 'address' properties to devices.
>
> The QEMU community spent years designing QOM and QMP with that
> goal.  Which other pieces to you consider to be missing, to
> make you reject making gradual changes towards it?

QOM is an *internal* object model. It's fine for building
machine models *in C*. We have no mechanism for doing
this on the command line or via QMP, because there are
lots of parts of machine models (listed in the first
paragraph above) which aren't possible to do with purely
generic links and properties.

> I agree we shouldn't be introducing new external interfaces
> without careful thought.  But I welcome gradual internal API
> changes that are helpful for our long term goals.

Yeah, I have no objection to useful internal changes that
move generally in directions we'd like to go. But if
"machines via config files" really is a goal I'd like to
see at least a sketch of a design, rationale, summary of
what would need to change and proposals for what would be
done. And I don't think we should be exposing "MMIO addresses"
to users without at least some idea of why that would
fit in with other things we would be doing to move
towards where we're going.

(TBH: I also don't really see 'machines via config
files' as a serious project goal -- we haven't really moved
towards doing that in a decade, as far as I can see.)

thanks
-- PMM

