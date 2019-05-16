Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F247C04AAF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:12:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E7BFA205ED
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:12:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E7BFA205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55800 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGBU-0002pQ-39
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:12:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33546)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hRG6W-00079i-27
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:07:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nsoffer@redhat.com>) id 1hRG6O-00035l-He
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:07:22 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:36767)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1hRG6I-0002xl-S1
	for qemu-devel@nongnu.org; Thu, 16 May 2019 09:07:12 -0400
Received: by mail-ot1-f67.google.com with SMTP id c3so3353008otr.3
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 06:07:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=d3cyTg76HlqEENpGxbCTVQH/mJPnY2Yl6e1Ol5HLDZ4=;
	b=lW9YBW1mNXf+1qxcdj1k83CO3u+BBpfPjvlpirfRiqmguYeuhrGkaJe1f9OH9gkXqx
	5lByDhCU35ZLBsowoRBaqwUkyFWGZ5/hLWpND/PV7FRTUuaSH3/qHo3KEq/+bHeem7BM
	w6YTZJoS0pzvDVq3iaxgguxTtmEAi47VICwJovsYB/EoG+d6wBH4GlGsB4HKOLnNFFyN
	DULnndA9NEFfx8RpcU5girQyG9N1aIbaYvaC60WuWdZ1012F/FP+WhUVPtCnMNDHErC4
	Ts8YTv6OYlDwz46Kvvl21vUZF3v3fpC5drbWwvBRDrsRP20sKkbmeedm8At6YYCJrTk+
	69Qw==
X-Gm-Message-State: APjAAAX8kZIx5dtiTCggb+IsdPwcaUq41PI2Oh5GTFtMZPyxCadQ3l4E
	Nz2BK1G60sgj63lJVfkK2Oa7FfwlBxVZQxNnLj7BOg==
X-Google-Smtp-Source: APXvYqzhBgOXvBzqffqZgg0u5Vnh+qh2zLXYdb4SvopMjqsx+ztKaVv4vEt8h/jHiVvJ6Yy8Da9nomgHNmg/ITt9EWs=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr20695836otj.233.1558012026517;
	Thu, 16 May 2019 06:07:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190513155254.27773-1-mreitz@redhat.com>
	<7886115c-a73e-607d-6487-5cf68a3da756@redhat.com>
In-Reply-To: <7886115c-a73e-607d-6487-5cf68a3da756@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Thu, 16 May 2019 16:06:55 +0300
Message-ID: <CAMRbyyvG-Tygjx8U8sDzsmaMaDgmyGWRb0NE_KUhhqBssfaGqA@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.210.67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Filter 175's allocation
 information
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
Cc: Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, May 16, 2019 at 2:03 PM Max Reitz <mreitz@redhat.com> wrote:

> On 13.05.19 17:52, Max Reitz wrote:
> > It is possible for an empty file to take up blocks on a filesystem.
> > Make iotest 175 take this into account.
> >
> > Reported-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> > v2: [Nir]
> > - Use a function for filtering
> > - s/empty_blocks/extra_blocks/
> > ---
> >  tests/qemu-iotests/175     | 26 ++++++++++++++++++++++----
> >  tests/qemu-iotests/175.out |  8 ++++----
> >  2 files changed, 26 insertions(+), 8 deletions(-)
> >
> > diff --git a/tests/qemu-iotests/175 b/tests/qemu-iotests/175
> > index d0ffc495c2..b5eb0aa856 100755
> > --- a/tests/qemu-iotests/175
> > +++ b/tests/qemu-iotests/175
> > @@ -28,10 +28,25 @@ status=3D1  # failure is the default!
> >
> >  _cleanup()
> >  {
> > -     _cleanup_test_img
> > +    _cleanup_test_img
> > +    rm -f "$TEST_DIR/empty"
> >  }
> >  trap "_cleanup; exit \$status" 0 1 2 3 15
> >
> > +# Some file systems sometimes allocate extra blocks independently of
> > +# the file size.  This function hides the resulting difference in the
> > +# stat -c '%b' output.
> > +# Parameter 1: Number of blocks an empty file occupies
> > +# Parameter 2: Image size in bytes
> > +_filter_blocks()
> > +{
> > +    extra_blocks=3D$1
> > +    img_size=3D$2
> > +
> > +    sed -e "s/blocks=3D$extra_blocks/nothing allocated/" \
> > +        -e "s/blocks=3D$((extra_blocks + img_size / 512))/everything
> allocated/"
>
> Only now got around to creating an FS with similar characteristics to
> Thomas=E2=80=99s.  Turns out this test still fails there because it print=
s
> =E2=80=9Cblocks=3Dnothing allocated050=E2=80=9D...
>
> Unless objections arise, I=E2=80=99ll just add a \$ to each pattern to fi=
x that.
>  (I could also just swap the lines, but that isn=E2=80=99t really right.)
>

Sounds right.

Can you share how to create file system which reproduces this?
Maybe adding the details in the test would be useful.

Nir
