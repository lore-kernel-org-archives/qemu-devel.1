Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCC11C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:48:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2C64206A2
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 12:48:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2C64206A2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwQII-0002e0-UR
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 07:48:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52581)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <balaton@eik.bme.hu>) id 1iwQHk-0002Ca-JB
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:48:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1iwQHj-0005En-7a
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 07:48:04 -0500
Received: from zero.eik.bme.hu ([152.66.115.2]:45553)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>)
 id 1iwQHj-0005Dq-10; Tue, 28 Jan 2020 07:48:03 -0500
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 74E33746386;
 Tue, 28 Jan 2020 13:48:00 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 5533B74637E; Tue, 28 Jan 2020 13:48:00 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 53C0D74637B;
 Tue, 28 Jan 2020 13:48:00 +0100 (CET)
Date: Tue, 28 Jan 2020 13:48:00 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Howard Spoelstra <hsp.cat7@gmail.com>
Subject: Re: Performance hit in qemu-system-ppc
In-Reply-To: <CABLmASG93Fz-=XR45Z7pcaUkF8De3EdZbS_=901w_vhYUPiuXg@mail.gmail.com>
Message-ID: <alpine.BSF.2.22.395.2001281344260.9839@zero.eik.bme.hu>
References: <CABLmASG93Fz-=XR45Z7pcaUkF8De3EdZbS_=901w_vhYUPiuXg@mail.gmail.com>
User-Agent: Alpine 2.22 (BSF 395 2020-01-19)
MIME-Version: 1.0
Content-Type: multipart/mixed;
 BOUNDARY="3866299591-1544100175-1580215477=:9839"
Content-ID: <alpine.BSF.2.22.395.2001281344550.9839@zero.eik.bme.hu>
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-devel qemu-devel <qemu-devel@nongnu.org>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--3866299591-1544100175-1580215477=:9839
Content-Type: text/plain; CHARSET=ISO-8859-15; format=flowed
Content-ID: <alpine.BSF.2.22.395.2001281344551.9839@zero.eik.bme.hu>
Content-Transfer-Encoding: quoted-printable

Hello,

cc-ing the ppc list, maintainer and original author of the patch could=20
increase the chances that they actually see your message which they might=
=20
miss on qemu-devel. David explicitely said he usually cannot read all=20
mails on qemu-devel so likely should be cc-d on all PPC issues (or also c=
c=20
the qemu-ppc list besides qemu-devel).

Regards,
BALATON Zoltan

On Sun, 26 Jan 2020, Howard Spoelstra wrote:
> Hi,
>
> I noticed a considerable (~20%) slowdown in the cpu performance of
> qemu-system-ppc.
> Bisecting led me to this commit:
>
> d03f140804b345a85973976506492027f703d82d is the first bad commit
> commit d03f140804b345a85973976506492027f703d82d
> Author: Richard Henderson <richard.henderson@linaro.org>
> Date:   Mon Dec 9 13:49:58 2019 -0800
>
>    cputlb: Move body of cpu_ldst_template.h out of line
>
>    With the tracing hooks, the inline functions are no longer
>    so simple.  Once out-of-line, the current tlb_entry lookup
>    is redundant with the one in the main load/store_helper.
>
>    This also begins the introduction of a new target facing
>    interface, with suffix *_mmuidx_ra.  This is not yet
>    official because the interface is not done for user-only.
>
>    Use abi_ptr instead of target_ulong in preparation for
>    user-only; the two types are identical for softmmu.
>
>    What remains in cpu_ldst_template.h are the expansions
>    for _code, _data, and MMU_MODE<N>_SUFFIX.
>
>    Tested-by: Philippe Mathieu-Daud=E9 <philmd@redhat.com>
>    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> accel/tcg/cputlb.c               | 116 ++++++++++++++++++++++++++++++++=
++++
> include/exec/cpu_ldst.h          |  25 +++++++-
> include/exec/cpu_ldst_template.h | 125
> ++++++++-------------------------------
> 3 files changed, 166 insertions(+), 100 deletions(-)
>
> Thanks for looking into this issue,
> Howard
>
--3866299591-1544100175-1580215477=:9839--

