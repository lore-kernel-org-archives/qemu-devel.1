Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4635BC3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:09:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ADF2205C9
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 16:09:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ADF2205C9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i06hZ-00036Z-Ve
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 12:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41348)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Dave.Martin@arm.com>) id 1i06bn-0005al-69
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:03:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>) id 1i06bl-00007R-VA
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 12:03:43 -0400
Received: from foss.arm.com ([217.140.110.172]:42868)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <Dave.Martin@arm.com>)
 id 1i06bi-0008Vy-AH; Tue, 20 Aug 2019 12:03:38 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1FC8228;
 Tue, 20 Aug 2019 09:03:37 -0700 (PDT)
Received: from arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 518CB3F246;
 Tue, 20 Aug 2019 09:03:36 -0700 (PDT)
Date: Tue, 20 Aug 2019 17:03:29 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <20190820160320.GA27757@arm.com>
References: <20190803210803.5701-1-richard.henderson@linaro.org>
 <20190803210803.5701-5-richard.henderson@linaro.org>
 <CAFEAcA-_gMkE-0kA=xyUyNKxeqX0n6B-9i_7132xfFXQNRqb6w@mail.gmail.com>
 <7c739082-c1d5-ad03-0020-9776cf08694a@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c739082-c1d5-ad03-0020-9776cf08694a@linaro.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.140.110.172
Subject: Re: [Qemu-devel] [PATCH v7 4/6] include/elf: Add defines related to
 GNU property notes for AArch64
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm <qemu-arm@nongnu.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 20, 2019 at 04:59:50PM +0100, Richard Henderson wrote:
> On 8/20/19 8:39 AM, Peter Maydell wrote:
> > On Sat, 3 Aug 2019 at 22:08, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> These are all of the defines required to parse
> >> GNU_PROPERTY_AARCH64_FEATURE_1_AND, copied from binutils.
> >> Other missing defines related to other GNU program headers
> >> and notes are elided for now.
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > 
> > What's the authoritative source for these definitions? I
> > tried looking in glibc, binutils and the kernel without
> > any luck.
> 
> Presumably the true "authoritative" source is an ARM document, but I don't have
> that handy.
> 
> For binutils, the defines are in include/elf/common.h:
> 
> https://sourceware.org/git/?p=binutils-gdb.git;a=blob_plain;f=include/elf/common.h;hb=HEAD
> 
> The upstream kernel is also lacking the defines, as they're part of the ARM
> patch set that is still in flight.  The defines are still not present in glibc
> as of today.


The AArch64 spec is here:

https://developer.arm.com/docs/ihi0056/latest/elf-for-the-arm-64-bit-architecture-aarch64-abi-2019q2-documentation

Cheers
---Dave

