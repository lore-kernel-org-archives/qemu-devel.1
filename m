Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE43DC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:40:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B560921743
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 21:40:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WXsNpuo9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B560921743
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53952 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLaUU-00033F-Vg
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 17:40:43 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaTc-0002a3-Em
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:39:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hLaTb-0008DB-Ci
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 17:39:48 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:33429)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hLaTb-0008Ck-4n; Tue, 30 Apr 2019 17:39:47 -0400
Received: by mail-lf1-x144.google.com with SMTP id j11so12028690lfm.0;
	Tue, 30 Apr 2019 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=/EnJjfQru62WxSl+IcAnUF/CWCtyj07gupeydBsUevs=;
	b=WXsNpuo94mNKWJJAG0MkrxWXIoCJ2YCakjyQIrOdmofkamEiDuIvhT4Qf29hSq5B0Z
	6OHBh/iVHrkreBNCx2YKkOz/YIeSD/OEEAB8rSmmiR1YgD7oWcizdLBVi8077JvQ+g15
	vO7J9xWkFJETC6ZmZYYE2ZDBWNgem00aCypPmKiQoseLxG/ZmCL/LNzAy7nYmX5U9VJz
	nUahVkTOLYbM+dxPnI7PiLByY+q4K2DzGhHcbmTHQ18ydXttqlLv43/8Ehu298b2c6Ps
	cTvvJ2SATZNNuPaMA6vw2MeNMdnrHwSFi1QcETMzWbrxbEpJnYs3fynn4uXYqlh10x9D
	opcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=/EnJjfQru62WxSl+IcAnUF/CWCtyj07gupeydBsUevs=;
	b=d7cORnkAGXD/Dft4nqekQO4d4uvVhcX3UJMxUWX4/iPUbRi4CykKeM0pualI+kFKhQ
	knkHUv1wq9fqBTL4kOoTKiq+RCQLtjs8vJaccgO3m6YyYMTEUJNMZdFF/5IG11Xs9iwy
	luKSSQx7BJdl0Z6YCm3VZm+XvDmZQbYAcn3PHX7z21P/fiz6rfS4T1Rwd841AQdK3oqO
	GBvVnkkehXfssEV3G39v7rCvLqfibAV5zq9GgOvY9fjh6H/BPspDGulOKu59F4Kf/b7K
	CRhGxf4uB+f60cgG+mDf79sJ9r7VBoZNdqZkhe4v1wFILHJ6oJRcaguTl6EnXmPWbc+a
	daGQ==
X-Gm-Message-State: APjAAAUt69SL4O3wIc8oIfNvZe90Fk2D9EHV9dJct7nQlmx0ydXrS18K
	tWRUlmmykvzTTRZ5DlFlGomrNFvwlGRAMAfJzDE=
X-Google-Smtp-Source: APXvYqxxo8/t7qaBhHh8Hazx4JkXU4Iij0M26AuUwGaEBqAYtJ/BAN3s016S4b6uTX8g61sSo9oh04K2At/OzX6VKT4=
X-Received: by 2002:ac2:523a:: with SMTP id i26mr32115461lfl.118.1556660385752;
	Tue, 30 Apr 2019 14:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556650594.git.alistair.francis@wdc.com>
	<81a342ee886cf0f63cdbfc8573b14dd2d41de42d.1556650594.git.alistair.francis@wdc.com>
	<c95d2923-45b2-9acf-9cc6-aa4b9e102e48@redhat.com>
	<4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
In-Reply-To: <4f41ed2c-b49b-e1f5-e9a3-ad08e16ac77e@redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 30 Apr 2019 14:37:51 -0700
Message-ID:
 <CAKmqyKOxQZAX2grABD5=YFAK=G-TGFRWbJ=PmgutNeosF7M7Mw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v1 1/5] util/qemu-sockets: Fix GCC 9 build
 warnings
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
Cc: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>,
	"riku.voipio@iki.fi" <riku.voipio@iki.fi>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"laurent@vivier.eu" <laurent@vivier.eu>,
	Alistair Francis <Alistair.Francis@wdc.com>,
	"kraxel@redhat.com" <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430213751.QdBc7JlwMj8DnoTzpd3zyUtvV1WoUmFziarMpnxIBUA@z>

On Tue, Apr 30, 2019 at 2:16 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 4/30/19 3:25 PM, Eric Blake wrote:
> > On 4/30/19 3:08 PM, Alistair Francis wrote:
> >> Fix this warning when building with GCC9 on Fedora 30:
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98unix_connect_saddr.isra.0=E2=80=99 at util/q=
emu-sockets.c:925:5:
> >> /usr/include/bits/string_fortified.h:106:10: error: =E2=80=98__builtin=
_strncpy=E2=80=99 specified bound 108 equals destination size [-Werror=3Dst=
ringop-truncation]
> >>   106 |   return __builtin___strncpy_chk (__dest, __src, __len, __bos =
(__dest));
> >>       |          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~~~~~~
> >> In function =E2=80=98strncpy=E2=80=99,
> >>     inlined from =E2=80=98unix_listen_saddr.isra.0=E2=80=99 at util/qe=
mu-sockets.c:880:5:
> >>
>
> >> -    strncpy(un.sun_path, path, sizeof(un.sun_path));
> >> +    strncpy(un.sun_path, path, sizeof(un.sun_path) - 1);
> >
> > NACK. Linux allows you to use the full width of un.sun_path (a NUL
> > terminator is required if you copy less than that, but not if you use
> > the full width). Rather, we may need to mark path as a potential
> > nonstring to silence the warning, or use memcpy instead of strncpy, or
> > some other workaround.  (Sadly, this is one of those odd places where
> > strncpy is actually the right function to use, but there are so many
> > other places where strncpy is used incorrectly that it has turned into =
a
> > battle to use it here)
>
> We don't have control over un (that's from the libc system headers), but
> does adding the QEMU_NONSTRING attribute to our declaration of path
> serve to silence the warning?

I don't think that would fix it, I'll double check though.

>
> In short, I think most of this series should look at the use of the
> QEMU_NONSTRING macro, as that macro goes hand-in-hand with strncpy() for
> informing the compiler exactly when we know that we are copying
> something that has fixed length and may or may not be NUL-terminated.

I have changed the series to use memcpy() and QEMU_NONSTRING. I'll
send a v2 out soon with all your comments addressed.

Alistair

>
> --
> Eric Blake, Principal Software Engineer
> Red Hat, Inc.           +1-919-301-3226
> Virtualization:  qemu.org | libvirt.org
>

