Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72AC1C3A5A1
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 05:16:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41C20217F5
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 05:16:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41C20217F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codesourcery.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2qK3-0007EW-FM
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 01:16:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2qJL-0006nA-NP
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 01:16:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <Sandra_Loosemore@mentor.com>) id 1i2qJJ-00008Z-PN
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 01:15:58 -0400
Received: from esa4.mentor.iphmx.com ([68.232.137.252]:17811)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <Sandra_Loosemore@mentor.com>)
 id 1i2qJJ-00006p-Gz
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 01:15:57 -0400
IronPort-SDR: nJ7Wwcb+78h+HxF4zxjInkfHSWbyl78gNC9/uV3FsQ9OQR1Xg4oB97K/6+jYQiPF2jPbIZ83Pe
 PuxfUEZLfoG3qEixWLqD3u+z9hkwVt8FPA8YlrgYkkZPeqW9WbNNFLUWpYs7CryraLFsyyU6a4
 XR91Xe1l+U2yKXrGXZLzLbs/6AwBxhShTMUT54MgxRsBe3uKFL2pYENf7HY1/Qh2FlVUxa7kYZ
 Hy7AWVSb2T51MfDiE22qE3C3eXoYmb93hZlBoyLHV/fKO0g0ViXIxs5ljTwJJvSvpBdLENwotp
 WiM=
X-IronPort-AV: E=Sophos;i="5.64,440,1559548800"; d="scan'208";a="40831204"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
 by esa4.mentor.iphmx.com with ESMTP; 27 Aug 2019 21:15:54 -0800
IronPort-SDR: FMzxC+/np1aeW9NWtEbh1mvk2yKVyKNh1826czTV/slb2Y7a7oSoqkyLR72+vf12cm4ZZ8Fdc6
 c+/gLLmKwy23KgmXg159wppFmViNE+wRIAmehxPmlYDpFur5lPxpMb8EHqaI7S7fQWUVZyoe0I
 uwIPi1zFfEYZdEEboTFDfSUP0IENkg5SZ/17QI82cdEUB6A2J56WKXZLcNr15WbZq3m0UOYVwL
 9uLxTaI3XtHgNRdhQ1LXCxUn6IeMy1ogIEKcIRaDB7DXcXzRJ1C238jKmLBTackgrQKDOS2KH4
 tDo=
To: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers
 <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
References: <81a8c0ca-c5fb-fc3d-cc7b-00c4da31d621@codesourcery.com>
 <6ee9f4b4-39ff-f36a-9430-3e7a5de7a2de@linaro.org>
 <49104914-988e-d446-6b38-3ff26b7da7fa@codesourcery.com>
 <b9645a79-b331-b911-f51f-1352c8c5fa20@linaro.org>
From: Sandra Loosemore <sandra@codesourcery.com>
Message-ID: <0ded5548-7798-3cd5-6192-f54dd42c32ee@codesourcery.com>
Date: Tue, 27 Aug 2019 23:15:48 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <b9645a79-b331-b911-f51f-1352c8c5fa20@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203) To
 svr-orw-mbx-03.mgc.mentorg.com (147.34.90.203)
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x
X-Received-From: 68.232.137.252
Subject: Re: [Qemu-devel] libvhost-user: undefined reference to
 MADV_NOHUGEPAGE
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/27/19 9:01 PM, Richard Henderson wrote:
> On 8/27/19 6:42 PM, Sandra Loosemore wrote:
>> Sorry if that was not clear.  The target is aarch64-none-elf with the provided
>> semihosting facilities in QEMU.  The host is x86_64-linux-gnu. We deliberately
>> link against a pretty old glibc sysroot (looks like version 2.11.1), but we did
>> that for last year's 3.0 release as well, and haven't made any other changes in
>> the configure options etc that we use to build QEMU for this target.
> 
> Still not clear.
> 
> The combination "glibc" and "qemu semihosting" doesn't make sense.  The triplet
> "aarch64-none-elf" is a gcc thing and has no referent in qemu.
> 
> Are you building qemu-system-aarch64 for x86_64-linux, using an old x86_64 sysroot?

Yes.  We only use this configuration of QEMU as an instruction-set 
simulator so that we can test cross-compilers and gdb for bare-metal 
aarch64-none-elf target, using newlib as the target C library and the 
GDB semihosting support in QEMU for low-level fileio primitives.

BTW, I did not run into this undefined-symbol error when building the 
equivalent configuration for bare-metal nios2-elf target with the same 
sysroot and host setup.  That target does not build libvhost-user at all.

> In any case, glibc 2.11.1 is definitely out of support.  Even CentOS 6 used
> 2.12 and we don't support that anymore either.  Of the current
> long-term-support distros, I believe the oldest version of glibc is CentOS 7
> with 2.17.
> 
> As recently mentioned in
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2019-08/msg04514.html
> 
> we may accept a small patch with a large comment, but there are no guarantees
> how long we will keep such workarounds.

I wouldn't mind just applying a local patch to fix the build.  What I'm 
really trying to do is just get help in understanding what broke this, 
so I can come up with such a patch to un-break it again.

> I encourage you to re-examine why you're carrying around a 10 year old glibc.

We update our host build environment infrequently, and we've still had 
customers requiring CentOS 6 support until quite recently.

-Sandra

