Return-Path: <SRS0=AuXU=XO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B56BC3A5A6
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36A72207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Sep 2019 10:43:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1JTA0Bf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36A72207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAtuR-0002le-CN
	for qemu-devel@archiver.kernel.org; Thu, 19 Sep 2019 06:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54605)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <liq3ea@gmail.com>) id 1iAtr9-0007G5-Af
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:40:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <liq3ea@gmail.com>) id 1iAtr7-0008Ni-Us
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:40:11 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335]:46742)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1iAtr5-0008Kr-Sm
 for qemu-devel@nongnu.org; Thu, 19 Sep 2019 06:40:09 -0400
Received: by mail-ot1-x335.google.com with SMTP id f21so2577665otl.13
 for <qemu-devel@nongnu.org>; Thu, 19 Sep 2019 03:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=EsfUqyYl6KMSxRF+Xa1BlWxkzqCBC1ScQLdTQmdFPnI=;
 b=D1JTA0Bf7i0j5ekrtb3g3iNOFlvXVqO5NhKw3Wd56lm6AuyZGdb5UxIeNzwUS4EJ2m
 3trj5A2g5jk6pHu67KyQbiY8+gjL0NHdqysmnT/COueBrmXMk0bDju32Fk8+5RAbKwkT
 t0btssLdUmz6b/t/cgcLqyQAqOIfbBY+BHcBgUcogDi36y2AMN05MbZnna/xCRfQDJ61
 /73au1LoN6VxTpFKMX3LESE5/v3ZcmNajgEZKiswO7Whm9g/i/EXyBYna6RRgWfSp5u2
 QrDBKdANl80kYHiDGkygsHe4vdi7YyVP20BWmwSeIUu3hpkAs69BulYtv+KURNFN7L6J
 lWlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=EsfUqyYl6KMSxRF+Xa1BlWxkzqCBC1ScQLdTQmdFPnI=;
 b=lcHc9Z9Rp9Q3pvGsRw87xuC9sUNGFmUosylztf/JbXJMuDlFUJ+4OeFe4XKh/IDfJA
 NR+R7rD6NEkaPKhaBDlN8jBopnTAJhj5eanu2n6jyZ+2Og+HbFrN+dmSiP7uyUsggKCn
 APAt9FAMEEcklo0ZXq+8HkUrbLKnwJIfMiVkSnf72QZlZeKqJ0nuJh85eO/XtatLOxa6
 ZZdQsC2D+eQUUx/3TYcyq5j5wjc4EIRlHwoCIiYkd5fYX7aLY+U2+vC7xAnYCqUgdtEb
 EaP+raIjUCVPz14bHgb2pK4t5GfHn17DEqM2FAUw/vaMmAhjlSaUumhw7fF3cxkfp5KU
 nDTA==
X-Gm-Message-State: APjAAAWS1B1+vExvfThhBHfd5eB479xdXNfzrL8/Kq/G9oMQD1KO2gz9
 J7AW9Z8kMOasa+AEh8rreg/u8YVIXb7wXPcxSac=
X-Google-Smtp-Source: APXvYqxUvOBpbS95mv/Ev3epya0S4fN4ZiHTAY0J7ytG2p/TfnJzphGTyW8Ax5pUUQNrMhO4zHSdDQMOqd7lDmfq1DY=
X-Received: by 2002:a05:6830:1f16:: with SMTP id
 u22mr3220695otg.181.1568889605448; 
 Thu, 19 Sep 2019 03:40:05 -0700 (PDT)
MIME-Version: 1.0
References: <7d22c299-29fe-8479-ee14-17d521bb9d6b@huawei.com>
 <CAKXe6SL+LC4RVRy+4oAKnuS=qMFDG4A0iyoL0hqg_f76gSrmBA@mail.gmail.com>
 <43E932EA88344C498D975E4FF00CF41E2EAB29A5@dggeml529-mbx.china.huawei.com>
 <CAKXe6SJB4fc_2a0gz8JJ_LD6Qh65DDXaFVhJSspTHQxxn4=UQg@mail.gmail.com>
 <20190919085434.i2vkxasicqxfegvt@sirius.home.kraxel.org>
In-Reply-To: <20190919085434.i2vkxasicqxfegvt@sirius.home.kraxel.org>
From: Li Qiang <liq3ea@gmail.com>
Date: Thu, 19 Sep 2019 18:39:29 +0800
Message-ID: <CAKXe6S+E8K_QRWWATk67PfaQ2+UxXoedk1yn_tK-4Z42AJcyzg@mail.gmail.com>
To: Gerd Hoffmann <kraxel@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::335
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] Discussion: vnc: memory leak in zrle_compress_data
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
Cc: fangying <fangying1@huawei.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, zhouyibo <zhouyibo3@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Gerd Hoffmann <kraxel@redhat.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=8819=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8B=E5=8D=884:54=E5=86=99=E9=81=93=EF=BC=9A

> On Sun, Sep 01, 2019 at 10:43:42PM +0800, Li Qiang wrote:
> > fangying <fangying1@huawei.com> =E4=BA=8E2019=E5=B9=B49=E6=9C=881=E6=97=
=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=888:29=E5=86=99=E9=81=93=EF=BC=9A
> >
> > > Nice work, your patch does fix this issue in my test.
> > >
> > > I think we should make VncState.zlib to be a pointer type as well.
> > >
> > > Since we are going to use pointers instead of copy, we must make sure
> that
> > > there=E2=80=99s no race condition of pointer members between the loca=
l vs (vnc
> > > worker thread) and origin vs (main thread).
> > >
> > >
> >
> > Yes, there is a race between the main thread and vnc thread.
>
> Where do you see a race?  The main thread allocates the data structures
> before any job is started, cleans up after the jobs have been stopped
> and never accesses them otherwise.
>
> So unless I missed something the data structures are never accessed in
> parallel from multiple threads.
>

I checked the code again. Seems you're right.

Thanks Gerd, this strengthen my understanding of the vnc working mechanism.


Thanks,
Li Qiang


>
> > Maybe we should add a lock just like the 'vs->output_mutex'.
>
> output is a different story.  The output buffer is accessed in parallel
> (job thread produces and main thread consumes), so we actually need a
> lock here for synchronization.
>
> cheers,
>   Gerd
>
>
