Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74BC8C31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE9D214C6
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 12:35:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE9D214C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45098 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hx9Xm-0006ON-JT
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 08:35:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43302)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pmathieu@redhat.com>) id 1hx9XK-0005tp-LG
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pmathieu@redhat.com>) id 1hx9XJ-0001gP-HD
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:34:54 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39362)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pmathieu@redhat.com>) id 1hx9XJ-0001fk-BQ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 08:34:53 -0400
Received: by mail-wm1-f67.google.com with SMTP id u25so11601130wmc.4
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2019 05:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=peHclrgjz+AXqkSU7jes+3NdA2R3fGF0/AbZV6lY9Jw=;
 b=hPlRYpcQiIg2D9be162xXlEiqqTm8P8ysN/wBUesPQAmQUToY9yYzLkUXCn2pNdzpC
 7jOb5tymmtiT6FlG6Nc912km7hjvLuhXdFxjZDXDaBajCgg7sSg2OHMgYidooh2Z7Cq1
 TzUqpBDLZU/fi2ccteXx6KREmnpft1OplFhGq/aIJattk1ZmjAH3Z2Km0WwrfQJTCIcL
 c7wFG5Z9iBkQKG8Cs5A2BM2B3cu8qA6fPawKCeFZ/zqQvmBhtK0rzhU+t3a68aHzCEWh
 1QSOd+xJ6XLirZWBeWIdAwqZ8L2uSVY5Pf9K+Ul96YXzSxEh1X55aSdEzqKrnWJJGGZG
 Scow==
X-Gm-Message-State: APjAAAV88a7Zldscx1lzg5V+HPYo3P7JH9jJrXQnP0QTrh97oRQs4h5R
 4lck9dhnhqs8+LyuUUetgbF9mxyG3P8z1M70fqaNqA==
X-Google-Smtp-Source: APXvYqxp2f7ysNhLzxeekQ8Xqb8MtN4XrLi6M8WfyrPtWRcB1CqpXzbudjQ7PHvM1e95o5eiEqRfJERVN9KKzLX8+Jk=
X-Received: by 2002:a1c:407:: with SMTP id 7mr29151367wme.113.1565613291674;
 Mon, 12 Aug 2019 05:34:51 -0700 (PDT)
MIME-Version: 1.0
References: <20190806151435.10740-1-armbru@redhat.com>
 <20190806151435.10740-28-armbru@redhat.com>
 <8c2a6fad-6ac1-21b1-c17c-e1bd5ac41c9f@redhat.com>
 <87a7ckrat7.fsf@dusky.pond.sub.org>
 <ee3709c9-f351-081a-3aeb-53b7b6036b0a@redhat.com>
 <87imr8l0ti.fsf_-_@dusky.pond.sub.org>
 <695325d7-a0c3-73c1-97ab-f62fb345c622@unipi.it>
 <87blwzho1y.fsf@dusky.pond.sub.org>
 <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
In-Reply-To: <2fb98b77-efab-6092-dd5a-fa50c3c4b3f9@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Date: Mon, 12 Aug 2019 14:34:40 +0200
Message-ID: <CAP+75-UHvn+1EjHRn1PThuZg1YJ+=EpWj6LnSfk8Ww33JpqVuw@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>,
 Giuseppe Lettieri <giuseppe.lettieri@unipi.it>, 
 Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.67
Subject: Re: [Qemu-devel] Is network backend netmap worth keeping?
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Vincenzo Maffione <v.maffione@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Giuseppe Lettieri <g.lettieri@iet.unipi.it>, Luigi Rizzo <rizzo@iet.unipi.it>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I forgot to Cc Thomas, who did a lot of directory refactoring in the past.

On Mon, Aug 12, 2019 at 2:32 PM Philippe Mathieu-Daud=C3=A9
<philmd@redhat.com> wrote:
> On 8/8/19 1:52 PM, Markus Armbruster wrote:
> > Giuseppe Lettieri <giuseppe.lettieri@unipi.it> writes:
> >
> >> Dear Markus,
> >>
> >> the netmap project is alive and well, if a bit understuffed. We have
> >> moved to github:
> >>
> >> https://github.com/luigirizzo/netmap
> >>
> >> We have users from FreeBSD, where it is part of the official kernel,
> >> and Linux, both from Academia and industry.
> >>
> >> But you asked about the netmap backend in QEMU, in particular. When it
> >> was merged, the decision was made to disable it by default because it
> >> was not supported upstream in Linux. As Jason Wang says, this support
> >> is even more unlikely now than it was then.
> >>
> >> The fact the the backend has to be explicitly enabled and built from
> >> the sources has obviously cut down the number of potential
> >> users. However, we still think it is useful and we have pending
> >> updates for it. If it's causing problems in the workflow, I am willing
> >> to help as much as I can.
> >
> > Could we make it a submodule, simililar to slirp and capstone?
>
> Good idea, this would extend the coverage. Netmap users/developers are
> probably best suited to do this.
>
> >
> >     --enable-netmap=3Dsystem      use the system's netmap
> >     --enable-netmap=3Dgit         use the git submodule
> >     --enable-netmap             use system's, else git, else fail
> >     --disable-netmap            disable netmap
> >     default                     use system's, else git, else disable
> >
> > A fresh clone of https://github.com/luigirizzo/netmap clocks in at
> > 14MiB, which is between libslirp's 1.5MiB and capstone's 72MiB.
>
> In which directory should we clone it? As /netmap directly?
>
> Should we start using a 3rd-party/ subdirectory?
>
> Similarly, what about the virglrenderer component?
>
> Its repository is: https://anongit.freedesktop.org/git/virglrenderer.git

