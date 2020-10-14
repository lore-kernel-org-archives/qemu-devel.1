Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0BDC2D0A2
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:15:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6683A2068E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 10:15:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="J0ESd4JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6683A2068E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSdoH-00018N-S3
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 06:15:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57304)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSdnU-0000fg-Do
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:14:16 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1kSdnS-0004nL-3z
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 06:14:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id n18so3100636wrs.5
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 03:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nsUcLiQMS0JfQ8tG/lbncnCVK3W3YcOVhDB8q3OI9i0=;
 b=J0ESd4JQcgrV23uTW00Vuex4KyNC5SvakzXG4ql5ATRc21559SFS7eZ8CnP/M+yc06
 JYRn51OmcnEMBU6zLlNNjOKF8S9CSDSRYM4DM2ATugONxpbJXsr953JJT8Wk1bKyVlSK
 nVM95rWRkdaNAcdEaK2drBMQyTrl0SbMLU8cTUfazcUuD9dqBKf/xcHUECv+RkWBVk64
 DeCUV/4oOqggNklzu3Ebirnbz9MAwLTrS4ncJ28uxXxYmWA0T4S1GH4pleuiBqtha3fs
 7VjnL39UgWfZWbica5ZcAh/emkPhwBig76LXPGcHHnkLbFWaQq94/idpZGw0YAeGxte+
 r4xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nsUcLiQMS0JfQ8tG/lbncnCVK3W3YcOVhDB8q3OI9i0=;
 b=UwA91ED/9HiOPGVGcth2iOGeW0e5+PbdY+vmPExH/ybVmH4jZAm6yQkF0WRLMC9Df7
 47k/IRe0M73BfMj5+LfaQmBtrdK3lqUDeq27EGEztlOSzGKgKMSRciIfieiFz8tlMqEZ
 zMdEGThWlJR4SwcKEZJ/pfpTzk2CJkyirjnwSxPB8bYIhPlfc4FKZwXMhXbEb+uM+xY/
 0XI9nBhhMfqJ3mZXNroMylB37p8Iwe3J7LOacvbiZcyAA5ATD1+ZRkiWDnaUDkC+CPm7
 GN00zAKvwkoheI4fU4CkHuIFh/eUyyJxYK+VT4tPoTZ4A9eDn6URh3bskKKbkZoklgsr
 5gSg==
X-Gm-Message-State: AOAM531ro1+RjjZnMu7vUOyFhtpwnbXfln2W3DHrPd4a0vZYpuNySCXO
 Aig10SFnPuvGqNL+/Proi4j22w==
X-Google-Smtp-Source: ABdhPJyixvNu8T++6udowxXOnRFCj/EVMQBMlSTwO0PiRUF25eHQkhWIdLFvE4rjLt8+Ij3Q2iHFmQ==
X-Received: by 2002:a5d:5609:: with SMTP id l9mr4475169wrv.140.1602670451636; 
 Wed, 14 Oct 2020 03:14:11 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u2sm4549956wre.7.2020.10.14.03.14.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 03:14:10 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 959841FF7E;
 Wed, 14 Oct 2020 11:14:09 +0100 (BST)
References: <20201014073605.6155-1-cfontana@suse.de>
User-agent: mu4e 1.5.5; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC v1 0/2] tcg-cpus: split into 3 tcg variants
In-reply-to: <20201014073605.6155-1-cfontana@suse.de>
Date: Wed, 14 Oct 2020 11:14:09 +0100
Message-ID: <87pn5lxgge.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Claudio Fontana <cfontana@suse.de> writes:

> The purpose of this series is to split the tcg-cpus into
> 3 variants:
>
> tcg_cpus_mttcg    (multithreaded tcg vcpus)
> tcg_cpus_rr       (single threaded round robin vcpus)
> tcg_cpus_icount   (same as RR, but using icount)

I've no objection to the cosmetic clean-up but I assume the 3 modes will
still be available in TCG enabled binaries.

>
> Alex, I read the comment in tcg_start_vcpu_thread saying:
>
>     /*
>      * Initialize TCG regions--once. Now is a good time, because:
>      * (1) TCG's init context, prologue and target globals have been set =
up.
>      * (2) qemu_tcg_mttcg_enabled() works now (TCG init code runs before =
the
>      *     -accel flag is processed, so the check doesn't work then).
>      */
>
> Is this actually current?

Hmm probably not. Now everything is tied to the order of class
initialisation and realisation. AIUI all properties set by the command
line should be complete by the time an object realizes and parent
classes should be processed before their children.

>
> I tried to refactor this (see patch 2), and it seems to work to do
> the init of regions in tcg_init, and it seems that mttcg_enabled is known
> already at that point..
>
> Ciao,
>
> Claudio
>
> Claudio Fontana (2):
>   accel/tcg: split CpusAccel into three TCG variants
>   accel/tcg: split tcg_start_vcpu_thread
>
>  accel/tcg/meson.build       |   9 +-
>  accel/tcg/tcg-all.c         |  13 +-
>  accel/tcg/tcg-cpus-icount.c | 145 +++++++++++
>  accel/tcg/tcg-cpus-icount.h |  20 ++
>  accel/tcg/tcg-cpus-mttcg.c  | 142 ++++++++++
>  accel/tcg/tcg-cpus-mttcg.h  |  25 ++
>  accel/tcg/tcg-cpus-rr.c     | 305 ++++++++++++++++++++++
>  accel/tcg/tcg-cpus-rr.h     |  26 ++
>  accel/tcg/tcg-cpus.c        | 500 +-----------------------------------
>  accel/tcg/tcg-cpus.h        |   9 +-
>  softmmu/icount.c            |   2 +-
>  11 files changed, 697 insertions(+), 499 deletions(-)
>  create mode 100644 accel/tcg/tcg-cpus-icount.c
>  create mode 100644 accel/tcg/tcg-cpus-icount.h
>  create mode 100644 accel/tcg/tcg-cpus-mttcg.c
>  create mode 100644 accel/tcg/tcg-cpus-mttcg.h
>  create mode 100644 accel/tcg/tcg-cpus-rr.c
>  create mode 100644 accel/tcg/tcg-cpus-rr.h


--=20
Alex Benn=C3=A9e

