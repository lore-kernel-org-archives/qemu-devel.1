Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97A1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:52:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E1922082F
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 19:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E1922082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1yYR-00006E-Qo
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 15:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i1yXl-00081V-2h
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:51:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i1yXj-0000Ia-CA
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:51:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33472)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i1yXj-0000Hc-4p
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 15:51:15 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BDD5D59455
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 19:51:13 +0000 (UTC)
Received: by mail-ot1-f70.google.com with SMTP id t26so8912059otp.17
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 12:51:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=SvQ+879S3t9v1lyU6g2WNsANnt6yoxCG+c/MKbB4rcg=;
 b=czsMSsC64KSvT91vjIX/QS0KCrt5zPDfh8890VMyCJ0cfYP+MuCHlpo9pUQx9+suGl
 VGNLXCJWEB39lA8g6CcT43yn1ko1cJ6m+yyw+321+xFYX51wqFVI7/AZN9gmsJHCrgK/
 QicMbOGkj7l+b8nvc6qOYanWrmukTpoYEO1VoyIGXxqH934utKns0Psm5q234Nv2Zkno
 JJu2rZutKD5KO8ZYnA+eV3ZI0BssAJNY+p2fgbiNrAPVZr7fFJ8yYZcUxpCtSQCmQJyV
 Eh7dG7ip4qiaQt/dj7r8+5VxAsk/HjcgbxNxePA2aDWyVOgCXf6exZCtdCB175Hg0GCk
 /jzg==
X-Gm-Message-State: APjAAAWMUca+Xy3q59aCKPbABrjbepMhXNH6gQmmhu6AGlKwdJF/AdvG
 2l1RP2dPtF9euSMRwwYDeXp77e1raSl3d5a1d+3hKq2n5Jy3uDKeDThHg6izNQATPBXDANtpI/b
 tjupn9Yn6B/+Uc6Ss1zoPaTAcG6B+y9Y=
X-Received: by 2002:aca:ad57:: with SMTP id w84mr1362440oie.106.1566762673154; 
 Sun, 25 Aug 2019 12:51:13 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzswWOCkR7EbkDdC6xcFZSmi52eNonlCT1/GsYinjVDR2/Jx4nMdiSt/gCQ3w52mZMUJnEdMy4hTA78dPxn5hs=
X-Received: by 2002:aca:ad57:: with SMTP id w84mr1362432oie.106.1566762672799; 
 Sun, 25 Aug 2019 12:51:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190816212122.8816-1-nsoffer@redhat.com>
 <92b8b240313fc978a1454e079963488667b6d4b0.camel@redhat.com>
In-Reply-To: <92b8b240313fc978a1454e079963488667b6d4b0.camel@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sun, 25 Aug 2019 22:51:01 +0300
Message-ID: <CAMRbyyt2PTWJBuR7Ni+gSCeHGpFuF-hkmCEG0Sqvm2gzFQL=CQ@mail.gmail.com>
To: Maxim Levitsky <mlevitsk@redhat.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH] block: posix: Always allocate
 the first block
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
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block <qemu-block@nongnu.org>, Nir Soffer <nirsof@gmail.com>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 25, 2019 at 10:44 AM Maxim Levitsky <mlevitsk@redhat.com> wrote:

> On Sat, 2019-08-17 at 00:21 +0300, Nir Soffer wrote:
> > When creating an image with preallocation "off" or "falloc", the first
> > block of the image is typically not allocated. When using Gluster
> > storage backed by XFS filesystem, reading this block using direct I/O
> > succeeds regardless of request length, fooling alignment detection.
> >
> > In this case we fallback to a safe value (4096) instead of the optimal
> > value (512), which may lead to unneeded data copying when aligning
> > requests.  Allocating the first block avoids the fallback.
> >
> > When using preallocation=off, we always allocate at least one filesystem
> > block:
> >
> >     $ ./qemu-img create -f raw test.raw 1g
> >     Formatting 'test.raw', fmt=raw size=1073741824
> >
> >     $ ls -lhs test.raw
> >     4.0K -rw-r--r--. 1 nsoffer nsoffer 1.0G Aug 16 23:48 test.raw
>
> Are you sure about this?
>

This is the new behaviour with this change...

[mlevitsk@maximlenovopc ~/work/test_area/posix-file 0]$ qemu-img create -f
> raw test.raw 1g -o preallocation=off
> Formatting 'test.raw', fmt=raw size=1073741824 preallocation=off
> [mlevitsk@maximlenovopc ~/work/test_area/posix-file 0]$ls -lhs ./test.raw
> 0 -rw-r--r--. 1 mlevitsk mlevitsk 1.0G Aug 25 10:38 ./test.raw
>
> ext4, tested on qemu-4.0.0 and qemu git master.
>

And this is the old behavior. I guess the commit message does not make it
clear.

From what I remember, the only case when posix-raw touches the first block
> is to zero it out
> when running on top of kernel block device, to erase whatever header might
> be there, and this
> is also kind of a backward compat hack which might be one day removed.
>

This change is only for file, on block storage we use BLKSSZGET.


>
> [...]
>
> Best regards,
>         Maxim Levitsky
>
>
>
