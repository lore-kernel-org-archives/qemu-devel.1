Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26FEEC33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:03:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E3B8F20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hwp719Ys"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3B8F20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyZWF-0003D3-4l
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:03:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54219)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZUa-0001rq-K4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:02:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyZUZ-0003zo-4N
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:02:12 -0500
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:44243)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyZUY-0003zI-Ug
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:02:11 -0500
Received: by mail-ot1-x342.google.com with SMTP id h9so13162762otj.11
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:02:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5V35DJ928f4p4WF+6iobgM3YFzpiMU6/PNW6GkKUmBc=;
 b=hwp719YsgV+Qy3HcUrPpExWT2ShSFH4IKh3rYct56qLh9KXG05KPKv/vsN/7xicjTG
 FOOUFcHbZnpqd4c+CgSkUgQoUC+xFbb24XMpRRN3Ldv5hsUUurhlaOhlOAAdvPY95/um
 5VAUBCVNKLePIK+3maQKV015FcdlsKbp+bu2s0GRviCFpyWWDra/RP56z0cG1elwQdIE
 QThRfhvlnID+WdLHFScJJ5n7rBvT0HCTgq8tupU+dbiARq8ytMXBYAXMhlWg8ZMR8KFM
 QtrQBcTUSCv/q6iX9sDsmra1rBGFRS4tzcG7hsOqKtl0ncPPgZF6+JeJdz4o8vV/C4Hf
 KR4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5V35DJ928f4p4WF+6iobgM3YFzpiMU6/PNW6GkKUmBc=;
 b=tXLyxSzO6ze0a+zvmQ5cBrK9fHst3wtpcPaTl4mHZ+GLGihsx2y8NPpipDP7nnYOvQ
 9mLkXHMaalPKwBXfCbSIsOzl5bHj7eIaS1HO4g7s7YIp3so9SMgZl2PaWXsE+BdhIeZi
 5PxM0DtNpp80e/1LjTCIPjbFIdgdSIc+wh2hd1ib3H9EntxqzG6sS+vamk5hNLKcc58X
 DJneVBF/eXyJkr9V/HXo1FPnV9BKaCdwjSYyFZ4N2W9xAgtDKkGekPd0MTvMM6ac2Uor
 8cVGIGV7Nnl+1uNiGXjtvq7+q2zPpcqEXPL/QOVBnwkkd4Gn0kxggmMryiHSMBUCvIcF
 YydQ==
X-Gm-Message-State: APjAAAVUSTeslePsnb8d+e1nh8m+o3eYPvEAE+mW1X07mpbasQNcseW8
 lE9FLufoRj+anejN7aVtgw8+w7EXLaDwGSzMFBaPpwvi
X-Google-Smtp-Source: APXvYqyX5Sgzre8pSnZq627Fh7yo2C+lAsenbD6wlsH/Z3Ory6UEcFNM0qGmFh8+hefjW3LahVpDEbGAMN7XqhoxuRM=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr16333049otq.97.1580727729787; 
 Mon, 03 Feb 2020 03:02:09 -0800 (PST)
MIME-Version: 1.0
References: <20200124162606.8787-1-peter.maydell@linaro.org>
In-Reply-To: <20200124162606.8787-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 11:01:59 +0000
Message-ID: <CAFEAcA9tFNZ26YeZmuUN6saYw+D9D85po0d02dmDOmZ0OhcQ5g@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] qemu-img, qemu-trace-stap, virtfs-proxy-helper:
 convert to rST
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
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
Cc: Kevin Wolf <kwolf@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, Greg Kurz <groug@kaod.org>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 24 Jan 2020 at 16:26, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> This patchset converts the following documentation to rST format:
>  * qemu-img
>  * qemu-trace-stap
>  * virtfs-proxy-helper
>
> (That means everything in step 3 in the plan:
> https://wiki.qemu.org/Features/Documentation#3:_Convert_things_which_are_mostly_standalone_manpages
> will be done except for qemu-cpu-models.texi. That
> should be a straightforward conversion but I haven't
> touched it yet because I know there's an on-list patch
> that updates the texi and wanted to avoid a conflict.)
>
> The patchset includes a new Sphinx extension which handles parsing
> the .hx files which provide documentation fragments for the qemu-img
> manual.
>

I'm going to send out a pullreq today with this in.
I'm squashing in these trivial fixups that deal with a
conflict with commit cdd267749a3ab787e8b, which added
a new qemu-img option and its documentation:

--- a/docs/interop/qemu-img.rst
+++ b/docs/interop/qemu-img.rst
@@ -247,7 +247,7 @@ Command description:
   Amends the image format specific *OPTIONS* for the image file
   *FILENAME*. Not all file formats support this operation.

-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
[--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET]
[--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE]
[-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
[--flush-interval=FLUSH_INTERVAL] [-n] [-i AIO] [--no-drain] [-o
OFFSET] [--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t
CACHE] [-w] [-U] FILENAME

   Run a simple sequential I/O benchmark on the specified image. If ``-w`` is
   specified, a write test is performed, otherwise a read test is performed.
@@ -268,6 +268,9 @@ Command description:
   Linux, this option only works if ``-t none`` or ``-t directsync`` is
   specified as well.

+  if ``-i`` is specified, *AIO* option can be used to specify different
+  AIO backends: ``threads``, ``native`` or ``io_uring``.
+
   For write tests, by default a buffer filled with zeros is written.
This can be
   overridden with a pattern byte specified by *PATTERN*.


--- a/qemu-img-cmds.hx
+++ b/qemu-img-cmds.hx
@@ -28,7 +28,7 @@ STEXI
 @item bench [-c @var{count}] [-d @var{depth}] [-f @var{fmt}]
[--flush-interval=@var{flush_interval}] [-n] [--no-drain] [-o
@var{offset}] [--pattern=@var{pattern}] [-q] [-s @var{buffer_size}]
[-S @var{step_size}] [-t @var{cache}] [-i @var{aio}] [-w] [-U]
@var{filename}
 ETEXI
 SRST
-.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
[--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET]
[--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE]
[-w] [-U] FILENAME
+.. option:: bench [-c COUNT] [-d DEPTH] [-f FMT]
[--flush-interval=FLUSH_INTERVAL] [-n] [--no-drain] [-o OFFSET]
[--pattern=PATTERN] [-q] [-s BUFFER_SIZE] [-S STEP_SIZE] [-t CACHE]
[-i AIO] [-w] [-U] FILENAME
 ERST
 DEF("check", img_check,
     "check [--object objectdef] [--image-opts] [-q] [-f fmt]
[--output=ofmt] [-r [leaks | all]] [-T src_cache] [-U] filename")

thanks
-- PMM

