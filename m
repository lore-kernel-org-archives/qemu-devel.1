Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14C80C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:21:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D143620828
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 15:21:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t0vnUGtC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D143620828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2Go7-00054a-0v
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 11:21:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55609)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nirsof@gmail.com>) id 1i2Gmg-00045V-PV
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:19:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nirsof@gmail.com>) id 1i2Gmf-0001kk-6t
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 11:19:54 -0400
Received: from mail-io1-xd44.google.com ([2607:f8b0:4864:20::d44]:36483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <nirsof@gmail.com>)
 id 1i2Gmf-0001kV-2b; Mon, 26 Aug 2019 11:19:53 -0400
Received: by mail-io1-xd44.google.com with SMTP id o9so38175013iom.3;
 Mon, 26 Aug 2019 08:19:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=NtvB7jmh0tvli2E79VHxmPm+zatFlmL75lfW57MuVbE=;
 b=t0vnUGtCHjk+QOhbthvo9GoTr4SzgPyPAY7bXCIgFuQcoG1PYvr2Yka8BAWqe8oamS
 obMfdlP5Dz+RySb34dG3IgeFas7jS/UmQ5QkkUto2wUke4c1w7HQdv5Q/z1ZiQRYumlp
 htnDpMGRwO+c+7myoopZXon+yrtK3YV7qQOZBx2F7ZmiVLUSSNGW+HDWUMFUAtGo/Cwj
 43C9MRBZ5lfKytAK9TmKDKXOOnXIxlHnH/Y9sZhUlADhy6FzryKx2TIRRrocPf4oENXa
 9Gu2UbncCrgIyqply42+GXFDmkpn8dQzz6a5f9Fr1GauHSRDtXUT2PsDhrnc9U8rMX7/
 WDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=NtvB7jmh0tvli2E79VHxmPm+zatFlmL75lfW57MuVbE=;
 b=IC35LOLqE5IWcsrHYa1MZpUEUDqT2xYLq6HYzcPRhjzXKfzy1gELhWKR2efdr4QDI8
 DfTqZefLgcsDfW+1RyyHV7pnjw19T6DnwPL4UXU7cLQTAGO7YsB0/mG43jF/Y32rbClc
 TKQ/CY5NuzoBYVtqlmB4seF9DCH5JxnM4riwXabRY/bdcxvX9SuelQpKEkpAGKNby1z1
 XA29Js5AUCgsG76jfq/PFgYxZVyNmraIT8yUxkLvirsrwPHHf5tODxTJgAuTv8uVvrKf
 uXUdx3xXEa1VKIZ7u5kYqeFweAcddK6VZQatUqYNodrOfeUQ0cMwx4KPVJKJm7NOAkQU
 Itaw==
X-Gm-Message-State: APjAAAWNncNHfA+inwmo0cvOzp6EimNTNNiVohWNEMAZKfSFSAI/GbpO
 zyPbqjH9AlXZPBk+gyAawFo6pLp7hGhqMOeFKFM=
X-Google-Smtp-Source: APXvYqx3U6QsBzGcDy8Q0R41475pSVyOva+4yBAeCpZFMwTwogdRnUgJ2YucNbckA2DVrB+1Jg0K4GjYfruCTS0A0kM=
X-Received: by 2002:a6b:8e8b:: with SMTP id q133mr3040191iod.165.1566832792102; 
 Mon, 26 Aug 2019 08:19:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190825220329.7942-1-nsoffer@redhat.com>
 <20190825220329.7942-2-nsoffer@redhat.com>
 <65085dba-f180-8a4e-8464-65e91323b69b@redhat.com>
In-Reply-To: <65085dba-f180-8a4e-8464-65e91323b69b@redhat.com>
From: Nir Soffer <nirsof@gmail.com>
Date: Mon, 26 Aug 2019 18:19:35 +0300
Message-ID: <CAMr-obvapP0fcjrQafvdi+vDuyEDMnwG9cBC1HYmW1gwH=JrUw@mail.gmail.com>
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d44
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

On Mon, Aug 26, 2019 at 4:46 PM Eric Blake <eblake@redhat.com> wrote:
>
> On 8/25/19 5:03 PM, Nir Soffer wrote:
> > When creating an image with preallocation "off" or "falloc", the first
> > block of the image is typically not allocated. When using Gluster
> > storage backed by XFS filesystem, reading this block using direct I/O
> > succeeds regardless of request length, fooling alignment detection.
> >
> > In this case we fallback to a safe value (4096) instead of the optimal
> > value (512), which may lead to unneeded data copying when aligning
> > requests.  Allocating the first block avoids the fallback.
> >
>
> > Here is a table comparing the total time spent:
> >
> > Type    Before(s)   After(s)    Diff(%)
> > ---------------------------------------
> > real      530.028    469.123      -11.4
> > user       17.204     10.768      -37.4
> > sys        17.881      7.011      -60.7
> >
> > We can see very clear improvement in CPU usage.
>
> Nice justification.
>
>
> > +/*
> > + * Help alignment probing by allocating the first block.
> > + *
>
> > +    do {
> > +        n = pwrite(fd, buf, write_size, 0);
> > +    } while (n == -1 && errno == EINTR);
> > +
> > +    qemu_vfree(buf);
>
> qemu_vfree() can corrupt errno...
>
> > +
> > +    return (n == -1) ? -errno : 0;
>
> ...which means you may be returning an unexpected value here.
>
> Either we should patch qemu_vfree() to guarantee that errno is
> preserved, or you locally capture errno before calling it here.

qemu_vfree() returns void like free(), so changing errno is unexpected, but
other code using it should not be effected, so preserving errno here seems
like a better change.

Thanks!

Nir

