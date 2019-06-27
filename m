Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DB3C48BD3
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:21:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DC421726
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 02:21:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXykS8g5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96DC421726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgK2E-0001zJ-Rc
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 22:21:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53891)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <elohimes@gmail.com>) id 1hgK1R-0001TU-WD
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elohimes@gmail.com>) id 1hgK1Q-0002ZU-W4
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:20:25 -0400
Received: from mail-qt1-x844.google.com ([2607:f8b0:4864:20::844]:43937)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1hgK1Q-0002Xg-R2
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 22:20:24 -0400
Received: by mail-qt1-x844.google.com with SMTP id w17so789321qto.10
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2019 19:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LpmtgVigqYWU3H5LknR4oq+I7GPBn3rrMGMoJbtfhiQ=;
 b=nXykS8g5+WlTMTcGYBtPdu0Gr8Ow87ttklIqwhyW9vimznA2oQ2AFE0IsuyuSO/K6S
 aZ08GaoYeIdjYP90Db4rKxkkBOcFqYsuVF4UBq98qosHfQ4dOzV4ghyCHr+bjSKXT1/1
 qE20MQvnnjkKxga89x4xCuzQntY3zfjGL1P6vGLtul6t3DSjfuH4ErPT2LWDIEXHEo9h
 Zjikb7ansCgPbgqHP/ld7nZqFZgTIEIODqhd8ekUa+xSWedfZPiB0CcgKnbmsHVwQhBi
 nGn4qzvqJmUlszrWCHlOq2pDsRVO0+pbnG9fLq6px7ba79CHSJLBiCvNao2SOIQekh7T
 sppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LpmtgVigqYWU3H5LknR4oq+I7GPBn3rrMGMoJbtfhiQ=;
 b=dUf+JE/mRZ+Trdg/FMEEl6NrCIGnNan3UAFEM0tShuNcoxOsVxwAEr+B/NXztlnoip
 fo8g+aCXfUKnZa5OSlMsXXlsii47q+VE9SGr1NEjpyjuMuu6AyBFxlJnWU+8d2kglxCM
 CYAeWwKkEnu9pNjOJpsuAQukyFZwSF+AuM2zAs83+qBMRoFNwInr5dZzK9zO266r5NQP
 +NAjHkgpGLi8R5qStqVRZ2y08Kdi6SJok6fl3fTlEkINH8kVsh9RiuLFSMigiMOlVKZa
 6HUQIuADIbl6nse1Bv32hAfNp5IFYOiUSUQNeKPtAKV1vsFvQ2ix/faEd8htf4ZvJC0s
 g6zQ==
X-Gm-Message-State: APjAAAUsEngIdIIJ3wbv8gxp9hSyOy5tuNaFn7k41m7l/DfwGFxCMiAC
 77t5hl0V7qCN6l+xvfSgn/Q4pJ7LY8fV9Xj3jdS1Dw==
X-Google-Smtp-Source: APXvYqzBXm/WonRb4qXmygv1ZLtEuzJ0zYIwqjIsyrOyytvcrHO3F60BPO8k7s7NH/CaIIn5RrpUf7nR+SXx10MnruI=
X-Received: by 2002:ac8:30c4:: with SMTP id w4mr965936qta.314.1561602024260;
 Wed, 26 Jun 2019 19:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20190626023130.31315-1-xieyongji@baidu.com>
 <20190626023130.31315-2-xieyongji@baidu.com>
 <20190626121754.57a32df8@bahia.lan>
In-Reply-To: <20190626121754.57a32df8@bahia.lan>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 27 Jun 2019 10:20:12 +0800
Message-ID: <CAONzpcZW_ze92Z1T-zsMqSgbSzDMTiqqsFP5NH26hGDVLCyLVg@mail.gmail.com>
To: Greg Kurz <groug@kaod.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::844
Subject: Re: [Qemu-devel] [PATCH v4 1/5] virtio: add "use-started" property
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
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Xie Yongji <xieyongji@baidu.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 26 Jun 2019 at 18:18, Greg Kurz <groug@kaod.org> wrote:
>
> On Wed, 26 Jun 2019 10:31:26 +0800
> elohimes@gmail.com wrote:
>
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > In order to avoid migration issues, we introduce a "use-started"
> > property to the base virtio device to indicate whether use
> > "started" flag or not. This property will be true by default and
> > set to false when machine type <= 4.0.
> >
> > Suggested-by: Greg Kurz <groug@kaod.org>
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > ---
>
> LGTM,
>
> Reviewed-by: Greg Kurz <groug@kaod.org>
>
> This fixes the backward migration breakage I was observing.
>
> Tested-by: Greg Kurz <groug@kaod.org>
>

Thanks for the testing.

