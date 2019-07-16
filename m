Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDE3FC7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:06:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C38F0206C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 18:06:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rYyBwbYl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C38F0206C2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnRqg-0005nh-Ur
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 14:06:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52868)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnRqX-0005Pc-Bw
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:06:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1hnRqW-0001jd-7b
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:06:37 -0400
Received: from mail-ot1-x330.google.com ([2607:f8b0:4864:20::330]:44464)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1hnRqW-0001jA-2u
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 14:06:36 -0400
Received: by mail-ot1-x330.google.com with SMTP id b7so22030058otl.11
 for <qemu-devel@nongnu.org>; Tue, 16 Jul 2019 11:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=pBdMtUDvi84x8MYS+clfO5mf7iL0VRTxC9qaxxec86I=;
 b=rYyBwbYlvxIjdCML9fi6EDVL+IW8xmjgXlMBUBSN53MXFOEz6iQktqYKxLZUcdSlZI
 PB/fbmOja303+NzHrrkL6fh1qPfhZIz/KAfwsUUmHdahvW8i9iBh4Y9K2CPjset2aCRT
 utYOO2BFPFYda+zRQUdN29B+BAUEcfiOfguz4wY/BbrhFaIGr13Q3w+DYgOtMjejWGEI
 KiQ7Hyh2ZTHSyND4nULUBKy5gRoMuE/hTa05Q17wrN5LgMk5sd9euWigwA9O5YXKBuD8
 VYafNzoal9lbSL6PDaJ4Ju3BO4vut8XmvhSm05knF0gIxtotWSWL2Xs2V+DxyRCL6HOg
 8l0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=pBdMtUDvi84x8MYS+clfO5mf7iL0VRTxC9qaxxec86I=;
 b=k9vzgvTYvBdhjGbj0NQGWK/6RKKrG/QhZPDKrkJUS/aJGl00AbZVC6m9As4VGfXLBx
 qGpJ36rRdHnMOshjaRanUJzS5udiqHdqJxFKywRYad62Pa50RT5iORXyLqbF5kR6oc2F
 prI6LD0XLntnu/IwZabfiP7cP9tbWp162lzk8uPND/ySIndf3/MYN4amDgrl6Omu7zlt
 PKiMb/Qy36eOHfsdtbrgvGr611S4hULn2SU8lJmJ6qQhcRbiyTHu6pqSD2bG+Yb1ZzJN
 0LKU4yv4CTX3COhuYtF5tb2mySL6JfYD9D6/rvZVNXznbfm17T+ongGvAp9SHWwJgncV
 mURg==
X-Gm-Message-State: APjAAAUL1Vvxw5xNfHZy7lunt8pjYNNrjZxGbiN2tikKgKfeCq0+z/Rl
 gwg0wUEArStfcjLepOXon5atOn2NSm422O6a5qQ=
X-Google-Smtp-Source: APXvYqzexXfbbDJ7p5NHhjpwrL5E5KCj5T/hBnp1ujqLlbho7/KerQFjmkChEyhir8Zx2K0Bp7LIqt9U6UWDAtC6VDc=
X-Received: by 2002:a9d:5cc1:: with SMTP id r1mr18661634oti.341.1563300395132; 
 Tue, 16 Jul 2019 11:06:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAL1e-=jiySpoypabXMkUsO=2pqgUrRxUhac=JM_V=2sn2LPhWA@mail.gmail.com>
 <054d5b29-6482-1d71-3866-057dd00cb021@redhat.com>
 <CAL1e-=ikCpJO1bn=AKYSLWb8QNYkf6062ojxn+UN3svXCEQvFA@mail.gmail.com>
 <20190716174420.GA857@redhat.com>
In-Reply-To: <20190716174420.GA857@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 16 Jul 2019 20:06:24 +0200
Message-ID: <CAL1e-=jDKUo7UrXz4wPuby4fWHXEK0pj2k_=sXiHz=zz+66u4A@mail.gmail.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::330
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

> > It appears that Ubuntu 16.04 came originally with SDL 1.2, and
> > SDL 2.0 was made available later on.
>
> That is not the case. Ubuntu has shipped both SDL 1.2 and 2.0
> concurrently as options, even in the previous 14.04 LTS, and
> probably before that too.
>

Thank you for finding this out.

However, this bring to surface another problematic point:

We assume that introduction of SDL 2.0 to Ubuntu is a green light
for deprecating SDL 1.2. In fact, SDL 1.2 is not deprecated by
Ubuntu (at least not by 16.04) - as established by you.

> > That is the problem: We make, in my opinion, an incorrect logical
> > leap here: we assume that if a package is available for an OS, it is
> > installed (or should be installed) on any instance of an OS.
>
> We're not assuming that it is installed, as everyone's OS install
> packageset is going to be different. We're just assuming that it is
> possible to be installed as an official vendor package, should the
> user want that feature. This is not unreasonable IMHO.
>

Again, what I find problematic is that we don't take deprecating
of older version of a library by a distribution as our reference point,
but our reference point is introducing of a new version.

Daniel, in any case, thanks a lot for your responses, I will not
respond to another email of yours in this thread, since I would be
just repeating myself - I also responded to Peter and Thomas,
so you can read those responses too for more details.

Many thanks again!
Aleksandar

> Regards,
> Daniel
> --
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|

