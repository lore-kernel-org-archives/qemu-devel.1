Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA88DC3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:22:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A55372064A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 22:22:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f+v1F3bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A55372064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2jrC-00052r-I7
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 18:22:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41733)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2jpI-0003xr-6P
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:20:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1i2jpG-0002yj-NZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 18:20:32 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:34175)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1i2jpG-0002x7-Bg; Tue, 27 Aug 2019 18:20:30 -0400
Received: by mail-oi1-x242.google.com with SMTP id g128so552660oib.1;
 Tue, 27 Aug 2019 15:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=Ke4EP9pzyAaS8AnFudlXUGsTk9WqfGLF8sxTfnGtLQY=;
 b=f+v1F3bJDFk70UXZ5fQSofgrDNRWeAhJUcKeIxeRALX/MVsTZFynnyRxSvXgQdjhgg
 cvGEjuX+7mramp6Tpk3DvE8gIjwgJ6G/MQ2pA+IyAyYmhD0+GOrXYCsX0WbOMKARJPTo
 TbNJzX1w2hleZ75Ok4z0ksIv9sW5wqzUJYTXS2Eq5GVGUB4SvvKNMwdLUysOZUO5UoNG
 MHbK6lubADNY+HsqYX0V30HQYtWXj27iPl+CX3c6DLFODX8BSy0sEYQCjMEdgZC4PhAS
 ftl01//PbeBF2sggQEeBohD/7JJ7TjfD1kgsHdhA6jPRa0mCPj7ejyGoQkfjn7JRhsaz
 b0mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=Ke4EP9pzyAaS8AnFudlXUGsTk9WqfGLF8sxTfnGtLQY=;
 b=sv5Hqeode7XxqbPxlOOm6NrssqIvTI/xV8LOF1aoSeM9IEIJIu1LR9YdV/q74Rev9I
 wnSC6I3YL3QMa+vaj8eO4APR4CiY3Pehwp5YcxHSwCR1V2xkSk08jvNDHokOUFuZaBfz
 i8jm1onVCGFk6bikbJSATsbjIYZUJ4WAAYekx9VOlUZbLMbI9hisNOUTU9cyPRsblkAR
 edhSCYENXtNAFtZ6/+iq74OV9p7ydllKQl0nkVmwjd/TejNGL1KTA5YFtwR8Dqf1f8hB
 lsF53oR5/cuyoZ8hXnA3GJtOMDerMlX8x/FrmMLeB7jSn/U6RPEOSKzktcLkuAh1DQ+9
 wkHQ==
X-Gm-Message-State: APjAAAVTkbQpSob3s0Z0u3o/Xdx6DaiSEE58E3YNcZlF3RdgwX9cuaXU
 u//0oWMjqlPBXRfsQvRtUC5UMtG+Dj1v1aNHCKc=
X-Google-Smtp-Source: APXvYqzyFJf18MEOkp2CaVHUmose8TZKd143xiq0yy7hsei9rVza/k8hQ0QjPPCa0l8NR9PCMlBYk5mQfN7MUZlogHo=
X-Received: by 2002:a05:6808:198:: with SMTP id
 w24mr677859oic.53.1566944428409; 
 Tue, 27 Aug 2019 15:20:28 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 27 Aug 2019 15:20:27
 -0700 (PDT)
Received: by 2002:a05:6830:10d7:0:0:0:0 with HTTP; Tue, 27 Aug 2019 15:20:27
 -0700 (PDT)
In-Reply-To: <fdba9c20-3ffb-7862-51c5-f78852b68238@codesourcery.com>
References: <1550008033-26540-1-git-send-email-sandra@codesourcery.com>
 <CAFEAcA8eFexmymsaur-DtgYdKcyJB0ia7dW_vp358hbySsyBDw@mail.gmail.com>
 <fdba9c20-3ffb-7862-51c5-f78852b68238@codesourcery.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 28 Aug 2019 00:20:27 +0200
Message-ID: <CAL1e-=iyYCiCP-kMhyvL_CUpsQQ7gKi5CjS1XivAzj55qTxpGA@mail.gmail.com>
To: Sandra Loosemore <sandra@codesourcery.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH] gdbstub: Send a reply to the vKill packet.
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
Cc: QEMU Trivial <qemu-trivial@nongnu.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

14.02.2019. 19.27, "Sandra Loosemore" <sandra@codesourcery.com> =D1=98=D0=
=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 2/14/19 10:48 AM, Peter Maydell wrote:
>>
>> On Tue, 12 Feb 2019 at 21:52, Sandra Loosemore <sandra@codesourcery.com>
wrote:
>>>
>>>
>>> Per the GDB remote protocol documentation
>>>
>>>
https://sourceware.org/gdb/current/onlinedocs/gdb/Packets.html#index-vKill-=
packet
>>>
>>> the debug stub is expected to send a reply to the 'vKill' packet.  At
>>> least some versions of GDB crash if the gdb stub simply exits without
>>> sending a reply.  This patch fixes QEMU's gdb stub to conform to the
>>> expected behavior.
>>>
>>> Note that QEMU's existing handling of the legacy 'k' packet is
>>> correct: in that case GDB does not expect a reply, and QEMU does not
>>> send one.
>>>
>>> Signed-off-by: Sandra Loosemore <sandra@codesourcery.com>
>>
>>
>> Thanks, applied to target-arm.next.
>>
>> As an aside, do you know if there is any kind of test suite for
>> the remote protocol that implementors of a debug stub can use to
>> check that they're conforming to it?
>
>
> Well, I discovered this problem by running the GDB testsuite (using QEMU
for nios2-elf target with the other target-specific patches I recently
posted).  I'm not sure if it's designed to exhaustively test the entire
remote protocol, but it does a pretty good job of covering user-visible GDB
features that depend on the remote target doing something reasonable, even
if it's just saying "Huh?  I don't know how to do that."  :-)
>

Debugging using gdb/qemu setups is fairly frequent use case and perhaps we
should have a test module for interoperability of gdb and qemu, and also
"make check-gdb".

Thanks for pinpointing and fixing bugs in this area, Sandra!

Aleksandar

> -Sandra
>
