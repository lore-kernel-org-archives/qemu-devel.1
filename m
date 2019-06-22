Return-Path: <SRS0=QkNH=UV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20525C43613
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DBC5A2070B
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Jun 2019 15:15:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJTgumBs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DBC5A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41212 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hehjp-0007wl-Vi
	for qemu-devel@archiver.kernel.org; Sat, 22 Jun 2019 11:15:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35526)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefanha@gmail.com>) id 1hehhq-0006aZ-0m
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:13:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefanha@gmail.com>) id 1hehhn-0008M8-BR
 for qemu-devel@nongnu.org; Sat, 22 Jun 2019 11:13:29 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <stefanha@gmail.com>)
 id 1hehhk-0008Fg-Ub; Sat, 22 Jun 2019 11:13:25 -0400
Received: by mail-wr1-x442.google.com with SMTP id p13so9311080wru.10;
 Sat, 22 Jun 2019 08:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ok2BF4nPIsyIuxRVw3FE28hapxJKdu2X9EtlblHX7ds=;
 b=KJTgumBsIkXyNP11+HFcGr9V+501iYx20nJxnNjvVJjH8W7b+DYBdleqp8Tr7gXVjP
 wTRPA4MiuOml01Lh3enGiSesgh6sUPd8Ut8ZPw1CjLK1bM+rqIQ2obJ8FR+FMJ9uu2F/
 aP2Q7/Q8XUSC4qmzIexysUqqEgQYMKCUbKoMu/qE5fRHVcMUyi/RqtxCxpvdZtR2lcj+
 nSSw1al8yi2O1BftzuresaRDl4Y48ZvELa7Q93+KAl1ehrbipqyGU8Y2ZHd63/DZJ032
 R88AGx8jvh6Kl9aHOUP3a3XOzciZe0nx2tsaomNLgB45CQJkEGaOp9Kr7TT0lXJb2Jjq
 dMaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ok2BF4nPIsyIuxRVw3FE28hapxJKdu2X9EtlblHX7ds=;
 b=CLnUTn/cSB8kwJ76iJGnlTh7kqpN55v6BVfhuavLLrg6tTapJkH2VUDJjxFbAve2yW
 XoN+n/UZOzozbNDCnv1or+y34MR1MIilhTgbr3a0cFHQJuduTzKy+8ID9CXJ5tYnW5l/
 67y/hPPDrgZjpwJSFZ/Pb+kzreulBsvkKWGmIkwSvCMIrPqshTfguNnFaoiVvsMrz34x
 H+AjStIWWEdCScfVwOz7BaMNx0LsMHRkyGIHObJSNTa/HSGIbd9v5DhXyXNlMkQNNP3a
 qvZeAqSLVEq3Y7sEm3Fs0NFY99xsXdn4VSIZM0vFsLbXjRZXzRcHa1N6Bx4/hIOXXh4O
 3M8Q==
X-Gm-Message-State: APjAAAUr4+8Q/UNn0NaykKTgtDXCrBwlkgiVmfBgw+Za734MM4PIUcBZ
 zMHsY6mZJ6wy5bWUSWIiiXrSu/Ykao60IivryHM=
X-Google-Smtp-Source: APXvYqzEeN5XU6HZt/e4G+DYfXSQsYAobrz9aaYlGCDtc272eG8l71Bb2zizAM82om5HE63MbUpIJETvMCEpTYp9zoA=
X-Received: by 2002:adf:f3cc:: with SMTP id g12mr96297546wrp.149.1561216403834; 
 Sat, 22 Jun 2019 08:13:23 -0700 (PDT)
MIME-Version: 1.0
References: <20190610134905.22294-1-mehta.aaru20@gmail.com>
 <20190611095654.GS14257@stefanha-x1.localdomain>
In-Reply-To: <20190611095654.GS14257@stefanha-x1.localdomain>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Sat, 22 Jun 2019 16:13:12 +0100
Message-ID: <CAJSP0QWZKJ3KiAM2ZU8spYd13UWxW9xVhMAg_s-PxWcjCp9AdQ@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

On Tue, Jun 11, 2019 at 10:57 AM Stefan Hajnoczi <stefanha@redhat.com> wrote:
> On Mon, Jun 10, 2019 at 07:18:53PM +0530, Aarushi Mehta wrote:
> > This patch series adds support for the newly developed io_uring Linux AIO
> > interface. Linux io_uring is faster than Linux's AIO asynchronous I/O code,
> > offers efficient buffered asynchronous I/O support, the ability to do I/O
> > without performing a system call via polled I/O, and other efficiency enhancements.
> >
> > Testing it requires a host kernel (5.1+) and the liburing library.
> > Use the option -drive aio=io_uring to enable it.
> >
> > v5:
> > - Adds completion polling
> > - Extends qemu-io
> > - Adds qemu-iotest
>
> Flush is not hooked up.  Please use the io_uring IOURING_OP_FSYNC that
> you've already written and connect it to file-posix.c.

IOURING_OP_FSYNC is in fact synchronous.  This means io_uring_enter()
blocks until this operation completes.  This is not desirable since
the AIO engine should not block the QEMU thread it's running from for
a long time (e.g. network file system that is not responding).

I think it's best *not* to use io_uring for fsync.  Instead we can
continue to use the thread pool, just like Linux AIO.

Stefan

