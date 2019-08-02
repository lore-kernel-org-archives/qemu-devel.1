Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EDA7C433FF
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:45:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3E72087C
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 10:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l1HNg0Oq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3E72087C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htV3r-0003Oo-Vs
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 06:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43056)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1htV3Q-0002jb-Dr
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:44:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1htV3P-0007Ek-7c
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:44:56 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:44319)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1htV3P-0007Du-1r
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 06:44:55 -0400
Received: by mail-ot1-x32e.google.com with SMTP id b7so27497077otl.11
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 03:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=U7WE3ZXwofUxjtHpm2++ajNmJbteRBkeXWNCr/bETM0=;
 b=l1HNg0Oq19S5St+3vXDneRngt8sgGu7AVbrz0nw4BtQNihHWJ5EBm/pVDb89QPUWTC
 +xn68hnuqOzlEpXSslYlLpqgSIw4dBqC7It76HvqhTtBegdp/8jj+6xq6pID3MgyPjhW
 ld9RxBSSOiSd1EMcbtMemUDmen/BhVM9Q4Lj9yfyN80liZV7bfUjcTR3TCRiaaFZ9y/A
 8CdHhCKuyWMWYkXHEAtaWLySj6u8xszZPsAyhS8urjSR5PPym2EFr0jrgsYGnZoOTPii
 zxoJNx3jlYziZkXu+N0FMl4TBlD0PTGOOUcVf88zoRj9ytBdce1YzPvJf1XMNHroTqAA
 yLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=U7WE3ZXwofUxjtHpm2++ajNmJbteRBkeXWNCr/bETM0=;
 b=o4uZjg+FXFqqu9jG5pptsywMadiT0lXOFonESvPBJlFZRL5lJIZA8OSEICYF8a4Wzb
 SJZZDobf+TixW0Cji+gN6j0DolWUSZY5Gb7cNiaP6XZOR8Oel7Clug9gV+vOqeC8HC4I
 d2sdfiapaW4vItbsTvrLfCeQHvroECF/XfrXEto37eIPjUYPGa/OLf3Ev0zrb51VQYwS
 pBmNvurKgtqdgk+zWYbV1x5KnnIplAjhsMavcOtdwrdtY3mDmFlhr4Pd+d5uYKhqUX5V
 bS9NUwD9+RPW9XPXZGqkplJnWOyYYB+E5Yl1C7IjAUcFmL1OeQuK4UgLA+0nkBujIMxg
 9lPQ==
X-Gm-Message-State: APjAAAVh+lwWMIKHA7w7LxrFzKP7J17bMuzuja8V+u6gonW229TCrJvS
 xyuOplHBve1NjktDu0aXltTrJOcQLfA81DYYVqyJoA==
X-Google-Smtp-Source: APXvYqzG4wH8pXquMlgAnO52GiunJmqv1KBzbEzd38obT/DzwSkeG5cUZxtNggXNzJXvRbtzN+DPzeKocNSY5AKYgZc=
X-Received: by 2002:a05:6830:1653:: with SMTP id
 h19mr45857985otr.232.1564742694188; 
 Fri, 02 Aug 2019 03:44:54 -0700 (PDT)
MIME-Version: 1.0
References: <156452993884.16169.12168229409049273970@sif>
 <3c6ebc55-9416-a467-cfbe-73d2df6a64f2@redhat.com>
 <CAFEAcA9Vs=N_kaO1_DHM=Azttp=1Ju=bKFMU3iZdt6-+J=Oq4Q@mail.gmail.com>
 <CAFEAcA-dcHzyH0ojrpbKuq-NALToxRLjCwz9MiZqNfN2=xLLsA@mail.gmail.com>
 <CAJ+F1CJj8F3PFBDiKanqGdZ22r9AmeqYuTDQFq0RjeayR7U4dQ@mail.gmail.com>
In-Reply-To: <CAJ+F1CJj8F3PFBDiKanqGdZ22r9AmeqYuTDQFq0RjeayR7U4dQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 2 Aug 2019 11:44:43 +0100
Message-ID: <CAFEAcA8xnvg3QjwZV8Yhkk4g7rM2cHn5GYkmXngNDVVkE290=Q@mail.gmail.com>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32e
Subject: Re: [Qemu-devel] [ANNOUNCE] QEMU 4.1.0-rc3 is now available
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Samuel Thibault <samuel.thibault@gnu.org>,
 Michael Roth <mdroth@linux.vnet.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 2 Aug 2019 at 11:31, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Fri, Aug 2, 2019 at 2:19 PM Peter Maydell <peter.maydell@linaro.org> w=
rote:
> >
> > On Wed, 31 Jul 2019 at 19:17, Peter Maydell <peter.maydell@linaro.org> =
wrote:
> > >
> > > On Wed, 31 Jul 2019 at 19:05, Philippe Mathieu-Daud=C3=A9 <philmd@red=
hat.com> wrote:
> > > >
> > > > >   Unless there are any release critical bugs discovered, this
> > > > >   will be the last release candidate before final release of 4.1.=
0
> > > > >   on the 6th August. Otherwise we'll do an rc4 and release on
> > > > >   the 13th August.
> > > >
> > > > We forgot to update the slirp submodule :(
> > >
> > > Were there any RC bugs in it?
> >
> > Ping! If we want to put this into an rc4 can we have a
> > pull request with a justification on the mailing list
> > sooner rather than later, please?
>
> It's about a CVE-2019-14378, that Samuel fixed a few days ago:
> https://gitlab.freedesktop.org/slirp/libslirp/commit/126c04acbabd7ad32c2b=
018fe10dfac2a3bc1210
>
> Imho, it's not a regression, so no need to delay qemu release.

Yeah, but it is a security bug, presumably, given the CVE.
https://access.redhat.com/security/cve/cve-2019-14378
suggests the consequences are more than just a DoS.
I think that merits including in the release.

> I would encourage distributions to switch to the shared library
> version instead, so they can more easily and quickly apply updates.

Well, that might be nice eventually, but it's not where we are
right now. QEMU is the primary consumer of the slirp library
and we ship a copy of it, so we need to coordinate about releases
and potential security issues.

Could you send out a pull request which updates our slirp
submodule to a version which just has that CVE fix on top
of what we already have (slirp commit f0da6726207b740f6),
please?

thanks
-- PMM

