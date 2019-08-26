Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54561C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:24:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 149AF2173E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="riPRxBwY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 149AF2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54744 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Gqy-00075p-7S
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56442)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2Gpy-0006WL-Sn
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:23:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2Gpy-0004Cx-0w
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:23:18 -0400
Received: from mail-io1-xd42.google.com ([2607:f8b0:4864:20::d42]:33021)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2Gpx-0004Cl-RA; Mon, 26 Aug 2019 11:23:17 -0400
Received: by mail-io1-xd42.google.com with SMTP id z3so38280326iog.0;
 Mon, 26 Aug 2019 08:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ifPruSZoUrpwYrEPs5mld7U5CubNc5EqUmXA//4Zk/o=;
 b=riPRxBwYy1JYDHRZutb9pvBeoibmipTPFD5zQZnE9ICxS+Wp+UQWHDYjU+aUGSZp8I
 Ntb62cqsnsMREevP9Md0KTipxSB8vG97fw/5OVDZ7HX6P7UiS5brbIVaP8K7NrhiA/Be
 nn5Itk9sqY38lb3ToB96iwQ7OgN59Kus0w3PjX2RYYwhncPGoy4ycDxkS1sK2ygYZacC
 pBv529Ak4CHkuSarAWE0gJCgpaeVnLM9NCE3Do5ZB1KjFwSAGJDCaVlETqQLdAhuKbwj
 wWSAeFjtR2gqVtNie0hsdYucKWth4NxXJupxgrX2Lg5Cpnes8RxdylaU9mNWQZCAqKef
 s5kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ifPruSZoUrpwYrEPs5mld7U5CubNc5EqUmXA//4Zk/o=;
 b=RqOEuaUtw63i9Z73HVDcxLmmVfQxz7coUisLc7W7/tlgs06Nq/Wg5GufS2FCMLw3n5
 wsCeOWyFVAe+WzOKDpr0ZyEPeNu0fXLcWjDj2tTiUkEG51Mn1E4RoQxHrXl699ygaslL
 EAm5FzX7GjQg1gxDmZhIetnk/rFednjpGVXXjxx75P2c+ICTSCweijp34TF4jpbxWkUr
 mAPtWgAR+ZvQWlS093CX0uYKYWxj/H1qemNgJ+DEfkPTRcqu+cPjFYNKR38RHmfoBtQs
 MQ5CdzgCjR21mpV0RSGh6KKfeWCLF4Q5902/G3wNBHib4mDxJzueNJ+uigc7HmNrKn3N
 EaBg==
X-Gm-Message-State: APjAAAVMKZm6h64rT2BLlktVwNGOIUDzEXaD/+UN1paQEj2MJSmwZHvx
 Pnpu9z+AsjVAP2Pw5NF70zbTIJ2mBVW9nbGeEIE=
X-Google-Smtp-Source: APXvYqw/ITsTJUTejmkMnrH1eYlGCQq1qL0nksVa7PXohvIPf1mWRYPvJ+a6WuZfDCwtzWmSsnh9kknlCDqVVenHCU8=
X-Received: by 2002:a5d:8353:: with SMTP id q19mr319973ior.59.1566832997019;
 Mon, 26 Aug 2019 08:23:17 -0700 (PDT)
MIME-Version: 1.0
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <e4e45496-b867-4e57-5b25-d0f1425d4824@redhat.com>
 <8a5eef62-27eb-9936-3db7-08d06532add7@redhat.com>
In-Reply-To: <8a5eef62-27eb-9936-3db7-08d06532add7@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 26 Aug 2019 18:23:00 +0300
Message-ID: <CAMr-obsWo0YiJR=mE8tLfuka_WQT-81RaYtSijvtRx1AFYD_rw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d42
Subject: Re: [Qemu-devel] [PATCH v2 1/2] block: posix: Always allocate the
 first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, qemu-block <qemu-block@nongnu.org>,
 Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Aug 26, 2019 at 4:49 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 8/26/19 7:31 AM, Max Reitz wrote:
>
> >>  # the file size.  This function hides the resulting difference in the
> >>  # stat -c '%b' output.
> >>  # Parameter 1: Number of blocks an empty file occupies
> >> -# Parameter 2: Image size in bytes
> >> +# Parameter 2: Minimal number of blocks in an image
> >> +# Parameter 3: Image size in bytes
> >>  _filter_blocks()
> >>  {
> >>      extra_blocks=$1
> >> -    img_size=$2
> >> +    min_blocks=$2
> >> +    img_size=$3
> >>
> >> -    sed -e "s/blocks=$extra_blocks\\(\$\\|[^0-9]\\)/nothing allocated/" \
> >> -        -e "s/blocks=$((extra_blocks + img_size / 512))\\(\$\\|[^0-9]\\)/everything allocated/"
> >> +    sed -e "s/blocks=$((min_blocks))\\(\$\\|[^0-9]\\)/min allocation/" \
> >
> > Superfluous parentheses ($(())), but not wrong.
>
> Note that $((..)) has a purpose: it can convert any variable content
> into decimal.  I can write min_blocks=0x1000, and $((min_blocks))
> results in 4096 while $min_blocks is still 0x1000.  But I'd need more
> context as to what the callers expect to pass as to whether the $((...))
> is superfluous here.

In this case min_blocks is computed and always use base 10, so we don't
need the $(()).

Nir

