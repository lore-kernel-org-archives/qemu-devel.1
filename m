Return-Path: <SRS0=PWhW=VO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEE0AC7618F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B3B217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2019 18:35:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a636FA+B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B3B217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnoli-0007wV-9x
	for qemu-devel@archiver.kernel.org; Wed, 17 Jul 2019 14:35:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57887)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnolW-0007SU-6J
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:34:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnolV-0000bK-3x
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:34:58 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:35653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnolU-0000aH-Us
 for qemu-devel@nongnu.org; Wed, 17 Jul 2019 14:34:57 -0400
Received: by mail-oi1-x22e.google.com with SMTP id a127so19331629oii.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jul 2019 11:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=0wzWxhrNkfmvJ/tb8Uc/YxvAYodWT+ssXQ6FTAGlKf4=;
 b=a636FA+B/jXoJs4PwqcUiol4L5WblI8N8QaX3g/eU8TVot02WZAg42OR/k1/vLhRxb
 eGe68H2v0ldR9Ns9HFXWckRtAPVkx0VVu5uUjJm7W7pseAXNKdmERUzLpEBluU+cJQjM
 otXgYvGdChoOX0I0olaQl18+4+I0Nxko9gkjmodk/BoR2T7BNJOp9xrntaIP/ywS76jR
 HzYQ6Y34GDzNtu81UHFodQSSuRuEkCKOsLvbLC0hBoCBx6L9sOLnZAshZ3A34pogTpVO
 GL44/aH9sF0lsC+wMTWDiYvAoYGbN/s4Vnb4F8NM18EKiY+Y34SGJuiFfQcXDeuiGUgU
 ZqWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=0wzWxhrNkfmvJ/tb8Uc/YxvAYodWT+ssXQ6FTAGlKf4=;
 b=EwsB1yRYnmUf/y/n4EE/JCtBC+BvsnlTTCqHky6PDJo4M1fBXi1+Z+QRAn92lIbXae
 VF28BAAhkVhqnzFfMESx3HQKbl5PVYlwdP7+LcSKG+FjOutYMN2t8cA1hyJF6jhuB7bO
 KrsfHvGzPG5SISZnCp4ejN53IOQeh4TtgnELIo6g3RhYqsJGIrCsnFBgxjYNHrfty9tn
 GPupi4W9wwExh4bdCfk48HbQXR88v6tn0ZBtNkEhKcvPzkHxHtFiw/hHvTWRr3HJSSeN
 NY+BAdpF5B8w4PwVVRPm7PsuqQnAeCBg4aDUL/fncUz+nz9ogDAvTm4J+k8bBnBEjaua
 aaOQ==
X-Gm-Message-State: APjAAAWv3pXQYdp5WyfnbXjjJ0Sg8EpXBAUQLvjvAc1aQiG1Kxmk97eh
 Cp5Pcbz1v1mNld+NUQEj1Ez7Os6VK++6julHTYU=
X-Google-Smtp-Source: APXvYqwI3fyR3DWRvhf2/k+YfSekclOM5XjMe+VSNCDON5JRHZBxrdwAYOjJQ8ucsZuU2QdNBiANnkCwKPznoKVZeGM=
X-Received: by 2002:aca:4588:: with SMTP id s130mr19912292oia.79.1563388495538; 
 Wed, 17 Jul 2019 11:34:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
In-Reply-To: <20190716174420.GA857@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 17 Jul 2019 20:34:44 +0200
Message-ID: <CAL1e-=jvRnp9NBzuMjOjP_WgCxhDSUf4qCkswRvyrpGFPK6cHg@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
Subject: Re: [Qemu-devel] [QUESTION] SDL 1.2 support
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
Cc: Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jul 16, 2019 at 7:44 PM Daniel P. Berrang=C3=A9 <berrange@redhat.co=
m> wrote:
>
> On Tue, Jul 16, 2019 at 07:09:37PM +0200, Aleksandar Markovic wrote:
> > On Tue, Jul 16, 2019 at 1:54 PM Thomas Huth <thuth@redhat.com> wrote:
> > >
> > > On 16/07/2019 13.17, Aleksandar Markovic wrote:
> > > > Hello, Gerd, Daniel, and others involved.
> > > >
> > > > I have multiple reports from end users that say that transition fro=
m
> > > > SDL 1.2 to SDL 2.0 was difficult, or even impossible for their host=
s.
> > > > In that light, they don't appreciate removing SDL 1.2 support from
> > > > QEMU. The most notable example is Ubutnu 16.04, where it looks ther=
e
> > > > is no way of installing SDL 2.0 that does not involve complete OS
> > > > upgrade, which, for various reasons, many are not willing to do.
> > >
> > > What's the problem here? According to
> > > https://packages.ubuntu.com/xenial/libsdl2-2.0-0 the library should b=
e
> > > available there.
> > >
> >
> > Yes, we, as developers, are good at upgrading, we like flexibility in
> > our development systems, and naturally want to try latest and greatest
> > tools and libraries.
>
> We were actually very conservative in requiring use of SDL 2. We shipped
> QEMU with both SDL 1.2 & 2.0 support for many releases, and have only
> dropped SDL 1.2 support *5* years after SDL 2.0 was shipped.
>

Daniel, that is fine, I don't question that, I basically wanted to start a =
talk
between us to clarify some things. Related to our situation in the field,
I have a sub-question to you:

Let's say there is a build system with SDL 1.2, and not SDL 2.0. Should
QEMU refuse to build?

Yours,
Aleksandar

