Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B99A2C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:36:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8238224655
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 10:36:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fqBPtiCQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8238224655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuDNZ-0000Bc-I9
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 05:36:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59050)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stevensd@chromium.org>) id 1iuDMs-0008CI-F5
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:36:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stevensd@chromium.org>) id 1iuDMr-0001G0-7e
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:36:14 -0500
Received: from mail-qv1-xf42.google.com ([2607:f8b0:4864:20::f42]:38184)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stevensd@chromium.org>)
 id 1iuDMr-0001Fk-20
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 05:36:13 -0500
Received: by mail-qv1-xf42.google.com with SMTP id t6so2973741qvs.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jan 2020 02:36:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=H5Q/enJnAE03WTWBi8/aJYWnHF9Q/si1wZbqxm7qIMY=;
 b=fqBPtiCQCcZp2HC/nOiTouELonf4sqDNI/IBFXf7075Q64Gm5fRAt6cuuTd5TkHAFn
 ACm/H1jSYCz30slLh+dprH8A2pFlIaRdDyMPXPN6E09TTSNRwGlX7As7Rbui+WKHxqf5
 KG9+ELa5YuiFfGc/so0Wr4FwcTv4j8k2ErWvM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=H5Q/enJnAE03WTWBi8/aJYWnHF9Q/si1wZbqxm7qIMY=;
 b=Vrn3N5dTQhNFD0bSHlU8tGSfFP+vE+4tGyggRHbbxLGptGHHNXwYXCvNyAu6TnZtFf
 VgaM1Brip6WHbICE73pAedd4xyIBIVOqmbhjYWXW6BDl2okOuXZPgg1a0+oC9xua75pN
 K2WG8JsFj4TfqD1c9PH0hO5gfpH9haq0nCgRMWQZtJZMPMUnL43lsz6FX5ByOCCR3ENk
 xna8tmB/mpbRKusVjTTe22cVqbh4/6fFr8C/R+boW2wWtDH3dt6JZIcDP52HofyTSoTx
 AKOZ+caUpchoLZrGCVqfDW1V6bTDUFZI8XVY3seJN8peTQak/yX/vpX7QGY2vNDbH8gP
 apbQ==
X-Gm-Message-State: APjAAAWmILSOlZoiBnDUUm9sRhxMxoC/DDG6tEcZJ+XBWe77WDMHsnpZ
 3YsHvdItKwsPJ+hRMYvS+orzdmYpzAMP0m452fSw2w==
X-Google-Smtp-Source: APXvYqyRYf1MLrUGY5LDFuW9isDnVb669Ork06kqaKh8XkIeXpMX9ZNprssj+aBOVO/q6kR+u1z7exc/TSUW6p0S454=
X-Received: by 2002:a05:6214:287:: with SMTP id
 l7mr9831933qvv.142.1579689372249; 
 Wed, 22 Jan 2020 02:36:12 -0800 (PST)
MIME-Version: 1.0
References: <CAD=HUj7N8dpEvf0Be8fg-qpFFTQOqzZX_kVoFB=BWp8S4uEFvg@mail.gmail.com>
 <20200122032433-mutt-send-email-mst@kernel.org>
In-Reply-To: <20200122032433-mutt-send-email-mst@kernel.org>
From: David Stevens <stevensd@chromium.org>
Date: Wed, 22 Jan 2020 19:36:01 +0900
Message-ID: <CAD=HUj7cXK65Hj1rrL9KKoa6oWzBBwf8J_kSU2beJwzD4q06Fw@mail.gmail.com>
Subject: Re: [virtio-dev][RFC PATCH v1 2/2] virtio-gpu: add the ability to
 export resources
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f42
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
Cc: virtio-dev@lists.oasis-open.org, Zach Reizner <zachr@chromium.org>,
 Alexandre Courbot <acourbot@chromium.org>, qemu-devel <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Alex Lau <alexlau@chromium.org>,
 Tomasz Figa <tfiga@chromium.org>, Keiichi Watanabe <keiichiw@chromium.org>,
 Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?St=C3=A9phane_Marchesin?= <marcheu@chromium.org>,
 Dylan Reid <dgreid@chromium.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Pawel Osciak <posciak@chromium.org>,
 Linux Media Mailing List <linux-media@vger.kernel.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> ok but how is this then used? will there be more commands to pass
> this uuid to another device?

This is intended to be used with the virtio video device being
discussed here https://markmail.org/thread/ingyqlps4rbcuazh. I don't
have a specific patch for how that will work, but it will likely be an
extension to VIRTIO_VIDEO_T_RESOURCE_CREATE.

> > +The response contains a uuid which identifies the exported object created from
> > +the host private resource.
>
> Are the uuids as specified in rfc-4122? I guess we need to link to that spec then

I don't think it's terribly important to specify how the uuids are
generated, as long as they're actually unique. That being said, I'm
not opposed to defining them as rfc-4122 version 4 uuids. Although if
we do that, it should go in the patch that defines what exported
objects and uuids are in the context of virtio, not in the virtio-gpu
section.

> > Note that if the resource has an attached backing,
> > +modifications made to the host private resource through the exported object by
> > +other devices are not visible in the attached backing until they are
> > transferred
> > +into the backing.
> > +
>
> s/host/device/?

The virtio-gpu is based around "resources private to the host", to
quote the existing specification. I think consistency with that
language is important.

-David

