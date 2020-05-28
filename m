Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73343C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:29:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3DA0E208DB
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 08:29:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RZmsJ2wl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3DA0E208DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeDur-0006NB-Dt
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 04:29:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDu6-0005wi-Pq
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:28:42 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35397)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jeDu5-00030Q-Ep
 for qemu-devel@nongnu.org; Thu, 28 May 2020 04:28:42 -0400
Received: by mail-wr1-x444.google.com with SMTP id x14so21572491wrp.2
 for <qemu-devel@nongnu.org>; Thu, 28 May 2020 01:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=a5ZBZzeKDfBHOE7jqGqPzt4IkHZCT04+UUXSj+sLoYc=;
 b=RZmsJ2wlQE+QtXUUsx+bKFM9RrHDg9Cc4+aGhINd0bO8aECD98WEUXex6rMWS0YvSe
 QDxhviQcIyhFDBDq0Vojpog5tpiFR2LgW/Ss4xYj3EsSdQ99aGLSA1Qya70PIOPZjkNI
 ezYPaM1N9JiIPOVEIXFFdD4jZSauOzoe9b6vO77tDE2nNo9+zwzWn2lbzUDV0DeUnRqm
 gyzprF9ZpKFijsk3XV+Y/pPn1RmpFd1XUUrmfGa/HrZb1indGKqGt2SKm7GMoMzrOWGs
 cbYcMZP+sSTFw5V8RTsK1yITKXX5V/LGKOimdUNkGm6drOhRy0lucS1etZNK0uBqKKfp
 uXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=a5ZBZzeKDfBHOE7jqGqPzt4IkHZCT04+UUXSj+sLoYc=;
 b=qUSpMvEHlq+zcUR0tXtRV6SP/fE2YBN8zKZHtEwhSLanzlKFUcIWdy2hGPMVNFJvuz
 xM1SwNFGW2yaXXk2M9DMdQuHqg20V9IRzsVD62UjGqbFXBKz53Ql1pxadfJnsNBS3k2L
 HHDkJhx6Ye8iUlwH6nSlc0Swzov1lqEakZunfCplnQjIfwA9XbqPpidDFlWThwiBugbn
 6aDM3wpr9VjBtCRQxvWhiONh4U9xArCEq0JHj6bnJNYtDOPqFoEp+MVnO9FAKLUfG0DD
 axy/tdYiQLb/MDv8VoEI8XEGy9nxGynC2f3CZNGFTlkJQidtgknE5dXHQv4XZtXwYouD
 M0lQ==
X-Gm-Message-State: AOAM533Ee3Bq827drnkkWwhDpp84lzML/xuYNGjYMOs4EKFMhvEi1knE
 gjbPLBNDB1fMDbtguxqW1lIgLQ==
X-Google-Smtp-Source: ABdhPJyykIEWASqrsUi3UWKH/9tRH0XYgFaYa2LCFMh6cdTINeNZu/W6qEszVOBm2j/wslbw0RFgYQ==
X-Received: by 2002:a5d:68c2:: with SMTP id p2mr2395060wrw.253.1590654519812; 
 Thu, 28 May 2020 01:28:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j190sm5741393wmb.33.2020.05.28.01.28.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2020 01:28:38 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 986F91FF7E;
 Thu, 28 May 2020 09:28:37 +0100 (BST)
References: <159057543840.16818.14393433996899521784.stgit@pasha-ThinkPad-X280>
 <159057545565.16818.10615781697342502198.stgit@pasha-ThinkPad-X280>
 <87y2pd5rrd.fsf@linaro.org>
 <34f0a0f8-d7ab-2d81-c4da-594936db6c7f@ispras.ru>
User-agent: mu4e 1.5.1; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <dovgaluk@ispras.ru>
Subject: Re: [PATCH v2 03/11] tests/acceptance: add base class record/replay
 kernel tests
In-reply-to: <34f0a0f8-d7ab-2d81-c4da-594936db6c7f@ispras.ru>
Date: Thu, 28 May 2020 09:28:37 +0100
Message-ID: <871rn45uq2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: wrampazz@redhat.com, qemu-devel@nongnu.org,
 Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com>, pavel.dovgaluk@ispras.ru,
 crosa@redhat.com, pbonzini@redhat.com, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <dovgaluk@ispras.ru> writes:

> On 27.05.2020 18:20, Alex Benn=C3=A9e wrote:
>> Pavel Dovgalyuk <Pavel.Dovgaluk@gmail.com> writes:
>>
>>> This patch adds a base for testing kernel boot recording and replaying.
>>> Each test has the phase of recording and phase of replaying.
>>> Virtual machines just boot the kernel and do not interact with
>>> the network.
>>> Structure and image links for the tests are borrowed from boot_linux_co=
nsole.py
>>> Testing controls the message pattern at the end of the kernel
>>> boot for both record and replay modes. In replay mode QEMU is also
>>> intended to finish the execution automatically.
>>>
>>> Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 47ef3139e6..e9a9ce4f66 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -2497,6 +2497,7 @@ F: net/filter-replay.c
>>   F: include/sysemu/replay.h
>>   F: docs/replay.txt
>>   F: stubs/replay.c
>> +F: tests/acceptance/replay_kernel.py
>>     IOVA Tree
>>   M: Peter Xu <peterx@redhat.com>
>> diff --git a/tests/acceptance/replay_kernel.py b/tests/acceptance/replay=
_kernel.py
>> new file mode 100644
>> index 0000000000..b8b277ad2f
>> --- /dev/null
>> +++ b/tests/acceptance/replay_kernel.py
>> @@ -0,0 +1,57 @@
>> +# Record/replay test that boots a Linux kernel
>> +#
>> +# Copyright (c) 2020 ISP RAS
>> +#
>> +# Author:
>> +#  Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
>> +#
>> +# This work is licensed under the terms of the GNU GPL, version 2 or
>> +# later.  See the COPYING file in the top-level directory.
>> +
>> +import os
>> +import gzip
>>
>> Do we actually use gzip in this test?
>
> Removed that, thanks.
>
>>
>> +
>> +from avocado_qemu import wait_for_console_pattern
>> +from avocado.utils import process
>> +from avocado.utils import archive
>> +from boot_linux_console import LinuxKernelUtils
>> +
>> +class ReplayKernel(LinuxKernelUtils):
>> +    """
>> +    Boots a Linux kernel in record mode and checks that the console
>> +    is operational and the kernel command line is properly passed
>> +    from QEMU to the kernel.
>> +    Then replays the same scenario and verifies, that QEMU correctly
>> +    terminates.
>>
>> Shouldn't we be doing more to verify the replay behaved the same as the
>> recorded session? What happens if things go wrong? Does QEMU barf out or
>> just deviate from the previous run?
>
> We hardly can compare vCPU states during record and replay.
>
> But in the most cases it is not needed. When control flow goes in the
> wrong direction, it affects the interrupts and exceptions.
>
> And interrupts and exceptions are the synchronization points in the
> replay log. Therefore when the executions differ, QEMU replay just
> hangs.

Maybe we should fix that and exit with a more definitive error? Hangs
are just plain ugly to debug because your first step has to be to start
poking around with a debugger.

--=20
Alex Benn=C3=A9e

