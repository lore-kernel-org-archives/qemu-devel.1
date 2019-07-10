Return-Path: <SRS0=axyf=VH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A9FFC73C7C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:41:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE3420838
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2019 08:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE3420838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hl8AO-000425-Kk
	for qemu-devel@archiver.kernel.org; Wed, 10 Jul 2019 04:41:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59449)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlureau@redhat.com>) id 1hl89B-0003RT-FB
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:40:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlureau@redhat.com>) id 1hl899-0005LN-5Y
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:40:17 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:39570)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mlureau@redhat.com>) id 1hl898-0005EU-SX
 for qemu-devel@nongnu.org; Wed, 10 Jul 2019 04:40:15 -0400
Received: by mail-ot1-f68.google.com with SMTP id r21so1339130otq.6
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2019 01:40:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=jFgRUpd8bUgku3r4lNNwTtsCAyjchjwVyzG0+MLcW1Y=;
 b=SnHz9ZwMme3/EAg4vYyKlfufJ4NOCm0MbNThMM/0ECxPI/RmLzplB3RNxefZ61/HlQ
 JIKaeamxHI7Qbnah9MybF+o9t1f8mYWxXtzTd/tHL+qAgqdhxpsHOohcbl2v5NwvBKty
 l+DMgQBcKqNZIiST20INjihI8jPd9GlBMZroObKhDRZ4ok5EyEMIDZ8b447OgkP0j/F0
 VXsGQuNzABqt4eJe+4sd2S2ll55Iay57lgh9m+mAmpUvzd7hyFUhSEazcjQvDZbFnA0F
 zeJwLDcFlGZxtQLK2gnCcivhgI4jTGNcSoD8iUH3hkONvj6Y2O+qVdWAYLXFP8Rezi5k
 mRsg==
X-Gm-Message-State: APjAAAXDbwC4C8Ew15MbCW0XIOH8Oz1TKFrYkoH166YpOIwsYDInpD9m
 ao5YYYTrLfR6sURlkYFrHTnGwxR2VMPrY2G02GbMeg==
X-Google-Smtp-Source: APXvYqw2lPLxxhb3qX3+oD9FnS/QiAkEPZZlj0N2/vS4HXzb0iyii2EsRI5ebmsoh8GsNMbgg3S2elmirVwm3QGVbgY=
X-Received: by 2002:a9d:3f06:: with SMTP id m6mr21858631otc.62.1562748010959; 
 Wed, 10 Jul 2019 01:40:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190709194330.837-1-marcandre.lureau@redhat.com>
 <20190709194330.837-3-marcandre.lureau@redhat.com>
 <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
In-Reply-To: <b6823a5f-658e-19c9-6bb4-559a12517a66@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 10 Jul 2019 12:39:59 +0400
Message-ID: <CAMxuvay5jPM6AnsZtLYvVB+nb4nopGnRP=BWxUctA1aZNaMdog@mail.gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, debarshi@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.210.68
Subject: Re: [Qemu-devel] [PATCH v2 2/5] tests/docker: add podman support
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
Cc: Fam Zheng <fam@euphon.net>, "P. Berrange, Daniel" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Gerd Hoffmann <kraxel@redhat.com>,
 Debarshi Ray <rishi@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi

On Wed, Jul 10, 2019 at 12:27 PM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On 09/07/19 21:43, Marc-Andr=C3=A9 Lureau wrote:
> > With current podman, we have to use a uidmap trick in order to be able
> > to rw-share the ccache directory with the container user.
> >
> > With a user 1000, the default mapping is:
> > 1000 (host) -> 0 (container).
>
> Why not do this in docker.py (either as part of patch 1 or separately)?
>  Also, can you document in a comment why this is not needed with docker?
>

Doing it in docker.py would probably mean parsing and tweaking
arguments given to Docker.run(). Since it's a "temporary" work around,
I would rather have it at the top-level caller, in the Makefile.

I am not very familiar with podman or docker, so I am not able to tell
you why docker does work by default.  @Debarshi Ray might know, as he
helped me finding a workaround.

thanks

