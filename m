Return-Path: <SRS0=Ouwy=U3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F093C4321A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:24:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04188208CB
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Jun 2019 00:24:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04188208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgegc-0005B9-83
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 20:24:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <jdillama@redhat.com>) id 1hgeg4-0004fc-Sy
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jdillama@redhat.com>) id 1hgeg3-0002ZI-4O
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:23:44 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46560)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jdillama@redhat.com>) id 1hgeg1-0002Y3-D4
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 20:23:42 -0400
Received: by mail-ed1-f68.google.com with SMTP id d4so8741881edr.13
 for <qemu-devel@nongnu.org>; Thu, 27 Jun 2019 17:23:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
 :from:date:message-id:subject:to:cc;
 bh=a/mTAe6faintFFsw6NPc2H57Dufym9W/MmQsTC49Hdc=;
 b=ob85Qfv7x0W2zQbcRVXzxmm90I9PaCsMr35x4C9WY6rX1RQmnAtPaRA6+1i8GYT4qt
 xvhxVXP0yXSFGreyXLoGy1VnONWGF6Kzqe+Z5C/FAr3eC8NnruQ3WjUp0hofrSbGtmEr
 YNxrt/fU9lSxPxDB/1yQM5iblan4siNYehPuavD7TiTskkUEjvL0YgBBHWU/OY+Dm7Gy
 TOASFsDrkrVuykxz0b7ovuU2eLFHQ16iVedhOD9D6VpXLLUfeMLoIfm5NLJpMFM6TjAp
 J/EfUw6Fvece8GeA0/A+upHV1ftDCiHfjUt/Hjyg7AGZDJyA+CdjXjOmKtLqnD1U+PTk
 zpJQ==
X-Gm-Message-State: APjAAAUe7wFkkjme4v5PaTygDi2ZQwyB5qMXIqqqZXGuZPufPnJ860eE
 6HA7HAKbs4xaZ2+WlUSVVnnrtKm213xsZxNC2FOHOA==
X-Google-Smtp-Source: APXvYqzKmzdtY1n2ZN1cslom8PGXs79WrLFZkZgYqXvuQtJ0XJNZf9phlsOCsuAzy/Zz5tieC8dg3O+uwsAGBN7JoGM=
X-Received: by 2002:a17:906:1c94:: with SMTP id
 g20mr5893588ejh.179.1561681420023; 
 Thu, 27 Jun 2019 17:23:40 -0700 (PDT)
MIME-Version: 1.0
References: <20190510153346.238366-1-sgarzare@redhat.com>
 <96429d33-6514-33b5-3fe8-7bdf2eccc8d9@redhat.com>
 <20190627084816.u6fj556uen3iqa3r@steredhat.homenet.telecomitalia.it>
 <b7aaa681-12ae-e256-e295-06e953dc51ff@redhat.com>
 <CA+aFP1Btm6O5R0fiNZmBjHOO8t9ZDvvVgH0i1vFHsrQq85d+bA@mail.gmail.com>
 <90149c68-0dee-4afd-f517-5f204879dd18@redhat.com>
In-Reply-To: <90149c68-0dee-4afd-f517-5f204879dd18@redhat.com>
From: Jason Dillaman <jdillama@redhat.com>
Date: Thu, 27 Jun 2019 20:23:28 -0400
Message-ID: <CA+aFP1AdCKjrX_gBLn-BjTs0cY=XbnjQsxwYowDwJ-UDD7xZPA@mail.gmail.com>
To: John Snow <jsnow@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.208.68
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block/rbd: implement
 .bdrv_get_allocated_file_size callback
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
Reply-To: dillaman@redhat.com
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, qemu-devel <qemu-devel@nongnu.org>,
 Max Reitz <mreitz@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jun 27, 2019 at 3:45 PM John Snow <jsnow@redhat.com> wrote:
>
>
>
> On 6/27/19 3:43 PM, Jason Dillaman wrote:
> > On Thu, Jun 27, 2019 at 1:24 PM John Snow <jsnow@redhat.com> wrote:
> >>
> >>
> >>
> >> On 6/27/19 4:48 AM, Stefano Garzarella wrote:
> >>> On Wed, Jun 26, 2019 at 05:04:25PM -0400, John Snow wrote:
> >>>> It looks like this has hit a 30 day expiration without any reviews or
> >>>> being merged; do we still want this? If so, can you please resend?
> >>>
> >>> Yes, I think we still want :)
> >>>
> >>> Is it okay if I send a v3 following your comments?
> >>>
> >>
> >> Yes, but I don't know who is responsible for final approval; I guess
> >> that's Josh Durgin?
> >
> > I'm the new (for the past several years) upstream PTL for RBD, so feel
> > free to tag me.
> >
>
> I got Josh's name out of MAINTAINERS, does it need an update?
>
> > RBD
> > M: Josh Durgin <jdurgin@redhat.com>
> > L: qemu-block@nongnu.org
> > S: Supported
> > F: block/rbd.c

Yes, I'll submit a patch to update that tomorrow.

-- 
Jason

