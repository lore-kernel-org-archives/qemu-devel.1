Return-Path: <SRS0=6hMH=ZM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2AD8C432C3
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0C720878
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2019 16:34:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o6DD/Ene"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0C720878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60360 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXSwQ-0000Ke-P3
	for qemu-devel@archiver.kernel.org; Wed, 20 Nov 2019 11:34:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45861)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSv0-0007US-UK
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:33:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iXSuz-000688-I2
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:33:26 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:33128)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iXSuz-00067x-A6
 for qemu-devel@nongnu.org; Wed, 20 Nov 2019 11:33:25 -0500
Received: by mail-wm1-x343.google.com with SMTP id t26so1606765wmi.0
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2019 08:33:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=9Tp/AY1uyywjZax7kSL3kgzVIQaTqP87DP4NSKQlTLc=;
 b=o6DD/EneyfB5FjQKn0Arbd77HuJ4kCIMW94EFPWaYUvsnJGmAob2KsXxSoPkpwIAtl
 9q9D4a8W9DWU+4XvxXTKoRnvcd/aj9IaeDhzd/hjXbdkC13Zu/6kwzuK/dYfDd4FQJo/
 TF8/9MkIrF7qOza529ljuqNVbLA+kWIRP7uikQWLDswzVJXMc5iniswv8XeW0ZCvSxp9
 r4ZdyP4W7cgqiass8IvMJuchFhQ63VdNq/wqGxJEe4dzSRgJHO5zW6OHpfvvCdpUbhS+
 hNbf1uEvrnhMVDsqQYrVxzqvDL+w1Fqnd6K2ZA8vZvLYB7M4S7pgGYKlL+P7WnfBc5xg
 oeuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=9Tp/AY1uyywjZax7kSL3kgzVIQaTqP87DP4NSKQlTLc=;
 b=S9y9V8qODL8+5IN1BAHyH6txMIeoYjP+AMUauA6xWBmxc7DTbtz4Cppo6sCpYCgxhl
 RJWDX2tdE5c5bq7KddFIFSdb5r26Biq9eGIAUdqflqiVDRQwj2LjZRJHlmthrfQMXWnj
 lPZk431VJSoXlv067q1HaFo+E6FBiXW4CRppz+5Tiz5TrdhPLR7fOjEAtle2aKU+aWWk
 fEdZHBvnZPhBN1xDx36NUufwdobLd3k//8RYe5mEWiUqdV2u4XSbxeX/TU77UhuPpqXM
 SUwOJ+2Mgotf9k9C1zOdrItZlrBKAEO2aMEDDdoRskgAPrXM2fjUeppRhmP7dskMZrqM
 jgpg==
X-Gm-Message-State: APjAAAXAhytn9hMcW7pIJwhrvVDXmn2k52xGVxgyQrg2YAea/ej792O2
 1TVVvFTThfEGhaPjOJiN5pFjcA==
X-Google-Smtp-Source: APXvYqz3MOPdiTFMjMD1dsxzzRRydFoQM0I5EZ8tn2B3NnHw3fwGolAGzmOXx3xVlxkkfUHNwGiVFQ==
X-Received: by 2002:a1c:560b:: with SMTP id k11mr4554892wmb.153.1574267603707; 
 Wed, 20 Nov 2019 08:33:23 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n65sm7411617wmf.28.2019.11.20.08.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2019 08:33:22 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9CEB01FF87;
 Wed, 20 Nov 2019 16:33:21 +0000 (GMT)
References: <20191118211528.3221-1-robert.foley@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Robert Foley <robert.foley@linaro.org>
Subject: Re: [PATCH v3 0/6] Make the qemu_logfile handle thread safe.
In-reply-to: <20191118211528.3221-1-robert.foley@linaro.org>
Date: Wed, 20 Nov 2019 16:33:21 +0000
Message-ID: <87mucqfqy6.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: peter.puhov@linaro.org, richard.henderson@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Robert Foley <robert.foley@linaro.org> writes:

> This patch adds thread safety to the qemu_logfile handle.  This now
> allows changing the logfile while logging is active, and also solves
> the issue of a seg fault while changing the logfile.
>
> This patch adds use of RCU for handling the swap out of the
> old qemu_logfile file descriptor.
>
> Also added a few tests for logfile including changing the logfile
> and closing the logfile.
>
> One change also added for a pre-existing double free issue in
> qemu_set_log_filename() uncovered with the new test.
>
> We also cleaned up the flow of code in qemu_set_log().

This all looks good to me. As we are in hardfreeze now I think it's best
we wait for the tree to open before submitting the PR. If no one else
wants to pick this up I'll put together a PR.



> ---
> v3
>     - This version of the patch incorporates a few minor changes.
>     - Change patch which adds qemu_logfile_mutex to remove the
>       asserts that mutex is initialized, instead we will rely
>       on the constructor.
>     - Also added details to commit for patch adding mutex to explain some
>       unavoidable temporary ugliness that we cleanup in a later patch.
>     - Change qemu_log_lock() to unconditionally hold the rcu_read_lock()
>       until qemu_log_unlock().
>     - Also changed one use case in target/tilegx/translate.c
>       to eliminate use of qemu_log_lock()/unlock().
> ---
> v2
>     - This version of the patch adds some cleanup of code in
>       qemu_set_log().
>     - Also changed the order of patches to move our fix for the
>       double free issue in qemu_set_log_filename() up to the beginning
>       of the patch.
> ---
> v1
>     - This version of the patch incorporates changes
>       from the first round of review.
>     - It also includes a fix for an issue in
>       qemu_set_log_filename().  This issue was uncovered
>       by the test added for this patch.
> ---
>
> Robert Foley (6):
>   Fix double free issue in qemu_set_log_filename().
>   Cleaned up flow of code in qemu_set_log(), to simplify and clarify.
>   Add a mutex to guarantee single writer to qemu_logfile handle.
>   qemu_log_lock/unlock now preserves the qemu_logfile handle.
>   Add use of RCU for qemu_logfile.
>   Added tests for close and change of logfile.
>
>  accel/tcg/cpu-exec.c          |   4 +-
>  accel/tcg/translate-all.c     |   4 +-
>  accel/tcg/translator.c        |   4 +-
>  exec.c                        |   4 +-
>  hw/net/can/can_sja1000.c      |   4 +-
>  include/exec/log.h            |  33 +++++++++--
>  include/qemu/log.h            |  48 +++++++++++++---
>  net/can/can_socketcan.c       |   5 +-
>  target/cris/translate.c       |   4 +-
>  target/i386/translate.c       |   5 +-
>  target/lm32/translate.c       |   4 +-
>  target/microblaze/translate.c |   4 +-
>  target/nios2/translate.c      |   4 +-
>  target/tilegx/translate.c     |   6 --
>  target/unicore32/translate.c  |   4 +-
>  tcg/tcg.c                     |  28 ++++++----
>  tests/test-logging.c          |  80 +++++++++++++++++++++++++++
>  util/log.c                    | 100 ++++++++++++++++++++++++++--------
>  18 files changed, 268 insertions(+), 77 deletions(-)


--
Alex Benn=C3=A9e

