Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89084C33C9A
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:15:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 580A522463
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 11:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nwcAtTHP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 580A522463
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXNwr-0004lL-Gw
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 06:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXNmJ-0004Uf-KX
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:04:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <marcandre.lureau@gmail.com>) id 1iXNmI-0006RU-9H
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 06:04:07 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32785)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
 id 1iXNmH-0006PZ-U3; Wed, 20 Nov 2019 06:04:06 -0500
Received: by mail-wr1-x442.google.com with SMTP id w9so27624999wrr.0;
 Wed, 20 Nov 2019 03:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=xGQ7+jRsYcLEubH7JDX88uX5w//TbVg1n/VU/GJV+6A=;
 b=nwcAtTHPOas25yEfzXaBNA5ZUsfe0lhg/0tpJ1CQxXh9X2a/PoJiUNSXbJ3F1uXXz2
 XF8atO68hdB5d8PsO6SsR6PkebXA+xh9wOVC52G8rUBkWiE4tMRkVaLox0zL9jUuF+U9
 qNdwmL/amlZH60EZNnzei7vRgbrdxX+81xsx/jobZIE/5L0wYgJ2Wo/Mn3PqQ8JRR4zV
 /820ee2Dn1ng7v5ArSaDww7BpRpIQ6Oorc39+8YNwc6eC1XLfWVMqGmBvZt4T3cNPdmF
 FShxuFBJndFcF43DTXS0vdkoiUAPkHRDWX+yAFRU8uiOHtM9UF7R/ugXQEUZbI5Wf2vR
 7enw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xGQ7+jRsYcLEubH7JDX88uX5w//TbVg1n/VU/GJV+6A=;
 b=sH22vr93/SLxZqpZvW+3pp5TzElaU3zXl0XnRZaQndtvG1vaSp6tBCPYiwTs5is/TF
 VuS5tjMXJYls+5No28+Coxc/wnsUcgAgmbIdKBxrEMsOkDkYXyuZRVJprSnnogF5cnop
 M7z2hk6Q2+jF4jShp2xm0qhRerfS6FKsaccAF8sJV62fbuPyn03KBe7YnZGoRGX2ChDS
 KTZ459iqncUDP/B9jWqSUzK+SxwPcQFaF53FrJyIo3MI9bB9Cls+pIZUwi4FYrx4ykfj
 UMoq1j0Y92gDTKhq4KdXy1YZej/+Rww2PEU4d284YDfoUFoDgmZlZ0Xv/dTMO7FUPNZV
 57pw==
X-Gm-Message-State: APjAAAV+qbn7MgCayEV9cTmrIbBDAMO7Ook2wij8+AGviMf9oUjyanVJ
 pWL1ufHIC1Rqsl/aoMmm4cmAhS9JZVSi5YBowQA=
X-Google-Smtp-Source: APXvYqzpWeGq0pz1SK5KT66O/Wd4vxDpZHY5Kj6anWnvWohoLcM9Ht59wQWv9u34cYQyej2KKqU25BeFlYdIgPs66IE=
X-Received: by 2002:a5d:4ad2:: with SMTP id y18mr2440828wrs.396.1574247843169; 
 Wed, 20 Nov 2019 03:04:03 -0800 (PST)
MIME-Version: 1.0
References: <20191023173154.30051-1-marcandre.lureau@redhat.com>
 <20191023173154.30051-14-marcandre.lureau@redhat.com>
 <CAFEAcA9Cq_MkAzqAjt5uPNu3HDUfxO0hyVWtqEiAashPEEq3=g@mail.gmail.com>
 <CAMxuvawroZ0jrQTJCbakft21Lgk2cHrE9VyihiUvYBVp+AXgXw@mail.gmail.com>
 <CAFEAcA97LxS0LhCN-uqmO++D2U3dXBn3KctW7n-4tA-b50xKcw@mail.gmail.com>
 <CAJ+F1CJGHeb2aT+8t7vEdB0bKZ8r6OAnnqpDdnkGbfDRcV=JjA@mail.gmail.com>
 <CAFEAcA-_fexNrzgdqwoaJVEyHMG-GAPZkEawiE59EX9+u_Kr5Q@mail.gmail.com>
In-Reply-To: <CAFEAcA-_fexNrzgdqwoaJVEyHMG-GAPZkEawiE59EX9+u_Kr5Q@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 20 Nov 2019 15:03:50 +0400
Message-ID: <CAJ+F1CL00TcaKz5LmC41urBULcO7meJuzuxW8nHmLQ6hG66tHg@mail.gmail.com>
Subject: Re: [PATCH v3 13/33] serial: start making SerialMM a sysbus device
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Cc: Corey Minyard <cminyard@mvista.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc <qemu-ppc@nongnu.org>, Magnus Damm <magnus.damm@gmail.com>,
 Jason Wang <jasowang@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Fabien Chouteau <chouteau@adacore.com>,
 KONRAD Frederic <frederic.konrad@adacore.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paul Burton <pburton@wavecomp.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Nov 20, 2019 at 2:58 PM Peter Maydell <peter.maydell@linaro.org> wr=
ote:
>
> On Wed, 20 Nov 2019 at 10:40, Marc-Andr=C3=A9 Lureau
> <marcandre.lureau@gmail.com> wrote:
> > On Wed, Nov 20, 2019 at 2:36 PM Peter Maydell <peter.maydell@linaro.org=
> wrote:
> > > There are two problems here:
> > >  (1) "self" gives no hint at all about whether it's the Object*,
> > > the DeviceState*, or the SerialMM*. All of those are the
> > > object the method is operating on, but the type differences matter.
> >
> > "self" should have the type of the object that is being implemented.
> >
> > serial_mm_instance_init ->  SerialMM *self
>
> In a typical device implementation, some functions take the
> object as a "SerialMM" or other specific pointer. Some take
> an Object*. Some take a DeviceState*. Some take void*.
> Which of those is "the type of the object that is being implemented" ?

In OOP, you implement methods for a specific type. "self" is of the
type that is being implemented.

serial_mm_foo(SerialMM *self);

serial_mm_instance_init(Object *o) {
  SerialMM *self =3D SERIAL_MM(o);
  ..
}


If you have a generic function, not tied to a specific class, this
rule doesn't apply.

do_this(some arg, SerialMM *smm)

>
> > > (2) *Absolutely nobody anywhere else in any other device model
> > > is using the 'self' argument name*. It's not a convention if
> > > only this one file is using it, and adopting it here gives us
> > > absolutely no consistency -- exactly the opposite.
> >
> > Since there is no clear convention, then adding "self" isn't breaking
> > any convention.
>
> There is a clear convention, which I explained to you already
> (variable is named with some abbreviation/initialism of
> the type name, or sometimes just 's' for "state"). You are trying
> to write code which ignores that convention and does something
> else *which no other code is doing*. Please stop doing that -- in
> particular, don't do it in one device in the middle of a refactoring
> series.
>
> If you want to argue that we should change our convention for
> how we write QOM code, feel free -- but that should be a separate
> discussion and probably ought to come with a plan for how
> to do a general update of the codebase to avoid a weird
> mix of styles.
>

Fair enough

We can only change things incrementally, and while doing refactoring
is the right moment to write better and more readable code.


--=20
Marc-Andr=C3=A9 Lureau

