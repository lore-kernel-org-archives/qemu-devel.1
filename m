Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D08CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:59:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 555002089C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 17:59:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QhtUI7a5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 555002089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMbxY-0000aa-Bg
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 13:59:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49770)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lersek@redhat.com>) id 1iMbw5-0008PE-OT
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:57:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lersek@redhat.com>) id 1iMbw3-0001Gi-1W
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:57:40 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:25383
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <lersek@redhat.com>) id 1iMbw2-0001Fg-PI
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 13:57:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571680657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KQ5Hs006e8za6SUmdkzeXIZzBBlG6iUFRLacoP5AiXM=;
 b=QhtUI7a54AvKmrI7ncnpM58iGYz1rB5IPI+OdcrMGUY3bI+Mh7BrefGOhT3ks4jvEvJBUv
 mhdKtfaykiZYbOpliTuJqwget4u6KUYNuC3Y1EStle27Fl5qZgORMf5D/LLFwuKdV1s3eo
 V+/uHExfqMPMmFdHO0jPPHZ0VFmgZ2M=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-FMlMBTpFPTWJJLhQ18dvYg-1; Mon, 21 Oct 2019 13:57:33 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0755880183E;
 Mon, 21 Oct 2019 17:57:32 +0000 (UTC)
Received: from lacos-laptop-7.usersys.redhat.com (ovpn-116-225.ams2.redhat.com
 [10.36.116.225])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1575D6A5;
 Mon, 21 Oct 2019 17:57:27 +0000 (UTC)
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <5dc0737a-f1b0-24aa-015a-1806a6d61e69@redhat.com>
Date: Mon, 21 Oct 2019 19:57:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-MC-Unique: FMlMBTpFPTWJJLhQ18dvYg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Claudio Fontana <claudio.fontana@gmail.com>,
 Ard Biesheuvel <ard.biesheuvel@linaro.org>, Alexander Graf <agraf@suse.de>,
 Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

(+Ard, Alex)

On 10/21/19 17:52, Richard Henderson wrote:
> On 10/21/19 7:58 AM, Peter Maydell wrote:
>> Since 2008 the tcg/LICENSE file has not changed: it claims that
>> everything under tcg/ is BSD-licensed.
>>
>> This is not true and hasn't been true for years: in 2013 we
>> accepted the tcg/aarch64 target code under a GPLv2-or-later
>> license statement. We don't really consider the tcg
>> subdirectory to be a distinct part of QEMU anyway.
>>
>> Remove the LICENSE file, since claiming false information
>> about the license of the code is confusing, and update
>> the main project LICENSE file also to be clearer about
>> the license used by TCG.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This patch takes the simple approach of just documenting
>> the de-facto current reality; does anybody want to argue
>> for something else? Other possibilities I guess would be
>> specifically documenting tcg/aarch64 as an accidental
>> exception to the general licensing rule for tcg/, or even
>> trying to get it relicensed.
>>
>> Does having tcg/ be BSD-licensed gain the project anything?
>> From my point of view I don't really see it as a cleanly
>> separable module of code -- it's quite tightly integrated
>> with the rest of QEMU, including code in accel/tcg which
>> is variously GPL or LGPL.
>=20
> I think this is the best solution.  I've never been convinced that TCG ca=
n
> usefully be extracted and reused for something else.

Side comment:

Ard and Alex extracted TCG to run x86 PCIe UEFI option ROMs on aarch64
hardware.

https://github.com/ardbiesheuvel/X86EmulatorPkg
https://kvmforum2017.sched.com/event/Bo0S/qemu-in-uefi-alexander-graf-suse
https://www.youtube.com/watch?v=3DuxvAH1Q4Mx0

If I remember correctly, they specifically picked a git commit hash that
was still purely BSD licensed.

FWIW,
<https://github.com/ardbiesheuvel/X86EmulatorPkg/blob/master/LICENSE> is
not any BSD license, so I'm almost surely out of date on that aspect;
just wanted to confirm that TCG has been usefully extracted.

Thanks,
Laszlo

> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>=20
>=20
> r~
>=20


