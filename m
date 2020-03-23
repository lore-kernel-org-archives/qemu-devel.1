Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D45E6C1975A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 01:53:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B5F120722
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 01:53:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NQ85FxbA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B5F120722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56336 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGCHH-0000zw-Mc
	for qemu-devel@archiver.kernel.org; Sun, 22 Mar 2020 21:53:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46254)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1jGCGO-0000Zo-2v
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:52:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1jGCGM-00019F-LD
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:52:23 -0400
Received: from mail-qt1-x842.google.com ([2607:f8b0:4864:20::842]:43114)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1jGCGM-00018r-F3
 for qemu-devel@nongnu.org; Sun, 22 Mar 2020 21:52:22 -0400
Received: by mail-qt1-x842.google.com with SMTP id a5so3244674qtw.10
 for <qemu-devel@nongnu.org>; Sun, 22 Mar 2020 18:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=frX3aSnCvwMZYRYwhP/kfk1qsbj5tle094zp7qlON38=;
 b=NQ85FxbA9U5l5Ssf8mI7RFw4jUu8WtueIFxNaFqnl/woz9cGtlOFoQe60Sa92vagm3
 Fcgyirf30WxvE+i6AflMUDjZiq84Wx2wfHWvJIqr3YeVcSaKZPgf/QFr5acS1Kp4kl/d
 6O5I3he6Sa1Zgs8+8qvkl1YaxF92rv9RSW0G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=frX3aSnCvwMZYRYwhP/kfk1qsbj5tle094zp7qlON38=;
 b=eFlxPiEIoa1PsnCv592MJmsjh8FgsgEu1mpg38zcGq14mXMfZ/+AP52XBaGmd0g64P
 s0tWsHvE11iJvJiUgsmBvUSVl3dy9c+rNpCq2EyfrIUze8K+EMm/i4GMMYG0JvsYwlcZ
 8HQ3wsZ09Kgzx7aqjVqeNhskXxi/lJJsAtYRn8/zeHCedLzCFk0Z0rUqKliIbZFM7AS+
 0DbunNFzidMjgvxS6KRye+WnFFLl3GbcD9rPVGx1at1IysoyjPx+L1rIbxAT7IRYYp8v
 ggo5I7ktAj1H0OREOPOquWddG5K+3nMhIny5iuqBvoCpFFH99m9tZTOG+4O7TLg2kddd
 +j3w==
X-Gm-Message-State: ANhLgQ3BLnUdCJoVmlYV/kNRMKKMFKxthzLdh+F+RhrcU6rz63pDsWpt
 8gywBfKWBM83HXDmFtqfLW14c9x4bX8pmVB8cnS1eA==
X-Google-Smtp-Source: ADFU+vsK11eSwW9pQKP54E3Rv6+fws/ZejMZbRqwR/vwnn0FZOuF6lMpAbLSnVfh4EDcsqNG0GwBaJt4aVnWYqZEXlw=
X-Received: by 2002:ac8:7769:: with SMTP id h9mr294273qtu.234.1584928341110;
 Sun, 22 Mar 2020 18:52:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200319021823.57219-1-stevensd@chromium.org>
 <20200320064143.4b2kyskr5clxsczs@sirius.home.kraxel.org>
In-Reply-To: <20200320064143.4b2kyskr5clxsczs@sirius.home.kraxel.org>
From: David Stevens <stevensd@chromium.org>
Date: Mon, 23 Mar 2020 10:52:09 +0900
Message-ID: <CAD=HUj4j7gEkHjQPt3aMy_X_m7pZ8CboDTjZtsO1RcfgN0JT5A@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] Cross-device resource sharing
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::842
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
Cc: Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 virtio-comment@lists.oasis-open.org,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Thanks for taking a look at this. I've opened a github issue.

Fixes: https://github.com/oasis-tcs/virtio-spec/issues/76

Thanks,
David

On Fri, Mar 20, 2020 at 3:41 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> On Thu, Mar 19, 2020 at 11:18:21AM +0900, David Stevens wrote:
> > Hi all,
> >
> > This is the next iteration of patches for adding support for sharing
> > resources between different virtio devices. The corresponding Linux
> > implementation is [1].
> >
> > In addition to these patches, the most recent virtio-video patchset
> > includes a patch for importing objects into that device [2].
>
> Looks good to me.
>
> So, open a github issue to kick the TC vote process and get this merged?
> (see virtio-spec/.github/PULL_REQUEST_TEMPLATE.md).
>
> cheers,
>   Gerd
>

