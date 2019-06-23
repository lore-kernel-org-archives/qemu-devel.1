Return-Path: <SRS0=JchA=UW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F03C43613
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 14:05:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD79520665
	for <qemu-devel@archiver.kernel.org>; Sun, 23 Jun 2019 14:05:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPujOPmf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD79520665
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44964 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hf37v-0005m7-LZ
	for qemu-devel@archiver.kernel.org; Sun, 23 Jun 2019 10:05:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59803)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hf36L-0005H2-SU
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 10:04:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hf36K-0000UZ-R8
 for qemu-devel@nongnu.org; Sun, 23 Jun 2019 10:04:13 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:41331)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hf36I-0000KV-Ab; Sun, 23 Jun 2019 10:04:10 -0400
Received: by mail-wr1-x444.google.com with SMTP id c2so11051369wrm.8;
 Sun, 23 Jun 2019 07:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=A0qp8kIzg4iiYpBAy0FnjbL9LLskKgQH0BTFEtt0C1A=;
 b=qPujOPmfbPyQWFCfT6REHWNhhyXKAhk6HV7liCJVZoHt4h9Qt5Ft5tPLgFFznQCarq
 Xm5WrOCLzP2bUz7KgScR1EWphnIOlunt0ayW5ZY84jnM9jG3Jn7hDUe1ZYLY3QuUmMqe
 Jobdbq35ZNP81LwsqCK88J0KmlH7fvuH4rgPpclRkNB4GAtj07XOiSA19f+WFd5PXYU9
 zvzUZZ0FT0z2PlgqFvtLnGwmHB4Her6cW9VqMtVXlOGMdKAZ/GFJqZDRWcIhyDqXfk37
 1gEzOpy8erPB7Z27Glj3rtIvEk57c5cZRptMOTQv1pWqXPQOhvKxdBLQPh3ErWPPKcpv
 dMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=A0qp8kIzg4iiYpBAy0FnjbL9LLskKgQH0BTFEtt0C1A=;
 b=HDSDhMvaZfBdCGaSw0On+8FI7OiGy/F27YiKaXYmcHZVCPEpuId0WILS9otSqQrbrJ
 cshJLG+rG8OHJ8ZBPlpCr+Lum1lIMcgizR7yKiAZj9p/A/sW8G7iI7jeZRl3HH8yRRX8
 7zibSRpDCZx0LS7+6hO7XpCR6Q8fgEE+ZOnJVbM5uqSTkgzS7qkYC/LToTJdlLMVz0sJ
 mtRPJKP4OkndiKkgRq5mg+LiAq9N0igiFB0cokXmE4CdZGshiz6kp1h2VyikjXDjh7X5
 hj7pG9c3U9aZRi2fcNsd9+tXSiQg3eq3znIv3I8S9efSGmy7Yf/aQ43nZAkLGaYVfhUA
 rSXQ==
X-Gm-Message-State: APjAAAV6nIHD36o7sC9vaRZ6Wxjoj23wODXVrPRq4pVXm1SrNRHvl3RN
 2KPWrmlwk2Nct1e455q1/t2CeOJat4iF/Cc67mQ=
X-Google-Smtp-Source: APXvYqzYlvPGwRwP3rb5J5lJZSL97N4J2uTamjdWPmPVa3Fx4xGEZbaGwn0fwMkjGbInMIiYwxRXMfwigqCQJC2GsZo=
X-Received: by 2002:adf:b64e:: with SMTP id i14mr53933770wre.248.1561298649131; 
 Sun, 23 Jun 2019 07:04:09 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190611095654.GS14257@stefanha-x1.localdomain>
 <CAJSP0QWZKJ3KiAM2ZU8spYd13UWxW9xVhMAg_s-PxWcjCp9AdQ@mail.gmail.com>
In-Reply-To: <CAJSP0QWZKJ3KiAM2ZU8spYd13UWxW9xVhMAg_s-PxWcjCp9AdQ@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sun, 23 Jun 2019 15:03:58 +0100
Message-ID: <CAJSP0QUwPoEi8-23-Qvfos5UtWi_7NaTdq7BW4T0SeZ47ET2UQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 00/12] Add support for
 io_uring
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu block <qemu-block@nongnu.org>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 saket.sinha89@gmail.com, Paolo Bonzini <pbonzini@redhat.com>,
 Julia Suvorova <jusual@mail.ru>, Aarushi Mehta <mehta.aaru20@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jun 22, 2019 at 4:13 PM Stefan Hajnoczi <stefanha@gmail.com> wrote:
> On Tue, Jun 11, 2019 at 10:57 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> > On Mon, Jun 10, 2019 at 07:18:53PM +0530, Aarushi Mehta wrote:
> > > This patch series adds support for the newly developed io_uring Linux AIO
> > > interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
> > > offers efficient buffered asynchronous I/O support, the ability to do I/O
> > > without performing a system call via polled I/O, and other efficiency enhancements.
> > >
> > > Testing it requires a host kernel (5.1+) and the liburing library.
> > > Use the option -drive aio=io_uring to enable it.
> > >
> > > v5:
> > > - Adds completion polling
> > > - Extends qemu-io
> > > - Adds qemu-iotest
> >
> > Flush is not hooked up.  Please use the io_uring IOURING_OP_FSYNC that
> > you've already written and connect it to file-posix.c.
>
> IOURING_OP_FSYNC is in fact synchronous.  This means io_uring_enter()
> blocks until this operation completes.  This is not desirable since
> the AIO engine should not block the QEMU thread it's running from for
> a long time (e.g. network file system that is not responding).
>
> I think it's best *not* to use io_uring for fsync.  Instead we can
> continue to use the thread pool, just like Linux AIO.

Looking more closely, this is wrong.  Although fsync is synchronous,
io_uring takes care to bounce it to the workqueue when submitted via
io_uring_enter().  Therefore it appears asynchronous to userspace and
we can and should use io_uring for fsync.

Stefan

