Return-Path: <SRS0=7MIY=3D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8753DC33CB1
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:31:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A568207FD
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2020 08:31:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A568207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irHcC-0001RE-Gb
	for qemu-devel@archiver.kernel.org; Tue, 14 Jan 2020 03:31:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49444)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1irHbA-0000fH-8B
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:30:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1irHb9-0000oM-6F
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:30:52 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:48885)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1irHb8-0000o0-Jg
 for qemu-devel@nongnu.org; Tue, 14 Jan 2020 03:30:51 -0500
Received: from [192.168.100.1] ([78.238.229.36]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1MIMKq-1iuWiF45gK-00EMv0; Tue, 14 Jan 2020 09:30:28 +0100
Subject: Re: [PATCH 1/4] linux-user: Use `qemu_log' for non-strace logging
To: Josh Kunz <jkz@google.com>, qemu-devel@nongnu.org
References: <20200114030138.260347-1-jkz@google.com>
 <20200114030138.260347-2-jkz@google.com>
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; prefer-encrypt=mutual; keydata=
 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
Message-ID: <003b154c-f193-b099-55a6-da77e13fb2da@vivier.eu>
Date: Tue, 14 Jan 2020 09:30:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200114030138.260347-2-jkz@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:Nj4Z4lRnwf3sS7syl59Z3BKeOOaTGTlvRb7ivobzpJINS6rH3WJ
 Hy1lIwavFFmA3LgxP/FnR0AChMfoC7hzzyRp16YNxw+f9OIAdMJwQ4YqaGvNpKOk2CttPeb
 T5q8w0DMTmSnFn03Cs3CjP4HBMSxYKsvctDwfm+IwjlCDlLcIKpZnJCjh1UdSk2MFljoUCc
 AbYXPbUuEkiQteFTzpt9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ko0nViJESR4=:wm/cZGy6m5ditBRXlwr1nD
 TPBbyytTuIvlsKJlu+NSF1CuVeFyWTsvDa1MMgNpQiob9fQB1ZmIhpwPhH+RZuXeq/9LQu8vA
 3tb7x+AZqsL3OhjaQO8mFZ1qvchdGY2I5DWkAh1F/w6stDYXgew4kiX+hnaK+8G+G/gmGl2+i
 PxCQwPMesAOkUF0/4YXECL/EGXm3NbK0zX8qXWsiCRuM1a/5X3cv5b+1b8SY54VLr7+01RzZg
 hscd5+bNtDzQ4ofNZIVODY+9Iw31g6OyekxeWjDMTBgWZuG8feYh3xKFSdovBm3E0kVOtwooY
 e++Z0sPV7PXJ8g5LHiy9fvOnLKM8kvQc69gdsbT4q/oCSUeUynST834HGWSD4Nx0SLF5Q1Ksc
 cRVy4ZSqefMGEQd1Xot6A/03RvppXK5nQCcczaxD5nDkewoumq/FS+g7LVm3YQLH7fw0zj+ou
 1FDhYcX6vxIj0hnflA5mSMNnqnFU2eKzwp9zhmWvHF11QVVsp6z7n3rBIkfXPUJlTH+gyYkbs
 XnRfuv/66UrNQGOcllAxb5CML9HfgRAO4+IzkQUM0n3d0srIOH0pOFaiv5GEf3hYfIP9TwdQ8
 WhmQKXYSMOXGLQh42LB3kAP5fr4ID6KQhH/TOEtQ/Xu3U5AqDwMVoGqK+DyBs1tipGoEfJfWq
 i95exdr20zsXdnkAUc4lyqAm0WVPJxRo3771GtsCR333wGiYzP9I7sR7XNBH0D34RtF32vSI7
 8OZwdVjhNjpoSV31pmBgGQykxGSD5rYQ6GaOp5RlGaEmpXFQKli15fDYq6vlRX3vIXdUIxeRk
 bqfrENhSs4DJL6PynN9IYCHwM9jvzmz4CVi17w3Kajz+xVndI7ioGxyR9dQWO3zRv/0T1/R94
 rxR4f2Xo3YhQ5iTLaBiB2SKYNAeggf5GF/E/N9dkg=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.130
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
Cc: riku.voipio@iki.fi, alex.bennee@linaro.org, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Le 14/01/2020 à 04:01, Josh Kunz a écrit :
> This change introduces a new logging mask "LOG_USER", which is used for
> masking general user-mode logging. This change also switches all non-strace
> uses of `gemu_log' in linux-user/ to use `qemu_log_mask(LOG_USER, ...)'
> instead. This allows the user to easily log to a file, and to mask out
> these log messages if they desire.
> 
> Signed-off-by: Josh Kunz <jkz@google.com>
> ---
>  include/qemu/log.h        |  2 ++
>  linux-user/arm/cpu_loop.c |  5 ++--
>  linux-user/fd-trans.c     | 55 +++++++++++++++++++++++++--------------
>  linux-user/main.c         | 24 +++++++++++++++++
>  linux-user/syscall.c      | 30 ++++++++++++---------
>  linux-user/vm86.c         |  3 ++-
>  util/log.c                |  3 +++
>  7 files changed, 86 insertions(+), 36 deletions(-)
> 

I think most of these log messages should use LOG_UNIMP, so no need for
a new flag.

Thanks,
Laurent


