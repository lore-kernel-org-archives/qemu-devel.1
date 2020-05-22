Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F1C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:19:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C185206D5
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 19:19:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WVhhlv3I"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C185206D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jcDCS-0000YX-NJ
	for qemu-devel@archiver.kernel.org; Fri, 22 May 2020 15:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59308)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcDBl-0008Ua-17
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:18:37 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:36498)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jcDBi-0006gI-Qg
 for qemu-devel@nongnu.org; Fri, 22 May 2020 15:18:36 -0400
Received: by mail-ed1-x544.google.com with SMTP id b91so10087340edf.3
 for <qemu-devel@nongnu.org>; Fri, 22 May 2020 12:18:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=42F39tOmOM8KwIvea1fZ06ANcza8VYozO7cYvVq3kEg=;
 b=WVhhlv3IIsj0djN4nHWs7iZf8OHajhxxnkjxiPjpInxw7CMti+OocTFHTObJIb1M6n
 8a3hT1JX9pySWHIGxzZ9skfuvbgxXaRkSfLhkgL4j8OjbWew6uFL9kyhthW3CN3qO+bm
 c2iNtkJwO6Xq4hD68cCxFv4aw1a/KcfbmXARBtx9yRNbPCmoWE0bSUL8PgqbtkCPahaC
 cBx4sAfSaronICD5uI3OdqR+uAhuJuZXp0+4scr6ccY1BaHWM2qedGYvkYiCYrvSMPja
 VBBVUanuUYg+fUNMtFliNxZslL44ZRjGgX00Qxzp3BKorsg2rk7np4rRReOAIoszsWhO
 i2sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=42F39tOmOM8KwIvea1fZ06ANcza8VYozO7cYvVq3kEg=;
 b=ixbI3yJ7z+bJPptI1oHceEXbmXieR6DjKHXTB1mjBI1HQK9JTUVLK5hqq2fBGePr7r
 IXjZ624t0+OEv748JCsadJWmFmz0Nu5xmTE5IKIMhGhN4KMgMWta6DTFJjD49YevJAVq
 N7YGUIZy74XGdfi6J1qbUL4D8oEDvcmsAcEWzqKhPIzM1L0Fq1gWe0U/kvK4S2tD6XRZ
 khR7mrUq050UxqqjJl6LwhXxoo6QHyDFnqz/ui48cyG68VbyhSoOySbV7aTa0DEFbs3F
 gd9K1jHcwb9/L2D0B14HoPfGwXJglnmOpRa9saH3fJPaGapX4giCxaHMnStUpcN/iRx9
 tOyQ==
X-Gm-Message-State: AOAM532kxNhXAqWykNnejzs6puYijT4uUzyIQb4qMMrjxq7c1PDzo+k3
 0fBOu0lE9tLLP0dBspOIK7u6IQ==
X-Google-Smtp-Source: ABdhPJyc+xgYiadLyd7W0hy6u7bmDNv6Zwm9hxwmJezjKnWEORZt/sINT3gZUfW5qYwvtpc7WmKnvA==
X-Received: by 2002:a05:6402:1242:: with SMTP id
 l2mr4411527edw.261.1590175109325; 
 Fri, 22 May 2020 12:18:29 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u17sm8631322ejg.1.2020.05.22.12.18.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 May 2020 12:18:27 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E132D1FF7E;
 Fri, 22 May 2020 20:18:26 +0100 (BST)
References: <159017301531.7966.9120113243897778171.malonedeb@gac.canonical.com>
User-agent: mu4e 1.4.6; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Bug 1880225 <1880225@bugs.launchpad.net>
Subject: Re: [Bug 1880225] [NEW] Emulation of some arm programs fail with
 "Assertion `have_guest_base' failed."
In-reply-to: <159017301531.7966.9120113243897778171.malonedeb@gac.canonical.com>
Date: Fri, 22 May 2020 20:18:26 +0100
Message-ID: <87tv07dbi5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::544;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x544.google.com
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Aleksandar Markovic <1880225@bugs.launchpad.net> writes:

> Public bug reported:
>
> This issue is observer with QEMU ToT, checked out around May 15th (but I
> believe it is present in current master too), and wasn't present in QEMU
> v5.0.0.
>
> I am using 32-bit Intel(R) Pentium(R) M processor 1.73GHz host.
>
> Arm cross-compiler is a standard cross-compiler that comes with Debian-
> based distributions, and gcc version is:
>
> $ arm-linux-gnueabi-gcc --version
> arm-linux-gnueabi-gcc (Debian 8.3.0-2) 8.3.0
>
> Compile this program with cross compiler:
>
> $ arm-linux-gnueabi-gcc -O2 -static toupper_string.c -o toupper_string-
> arm
>
> Emulation with QEMU v5.0.0 is correct, and gives expected output:
>
> $ ~/Build/qemu-5.0.0/build-gcc/arm-linux-user/qemu-arm ./toupper_string-a=
rm
> CONTROL RESULT: (toupper_string)
>  nwlrbbmqbhcdarz owkkyhiddqscdxr jmowfrxsjybldbe fsarcbynecdyggx xpklorel=
lnmpapq
>  NWLRBBMQBHCDARZ OWKKYHIDDQSCDXR JMOWFRXSJYBLDBE FSARCBYNECDYGGX XPKLOREL=
LNMPAPQ
>
> While, in case of QEMU master it fails:
>
> $ ~/Build/qemu-master/build-gcc/arm-linux-user/qemu-arm ./toupper_string-=
arm
> qemu-arm: /home/rtrk/Build/qemu-master/linux-user/elfload.c:2294: probe_g=
uest_base: Assertion `have_guest_base' failed.
> Aborted
<snip>

Works for me in our TCG tests on master:

20:15:43 [alex@zen:~/l/q/b/user.static] review/aarch64-vms-v7|=E2=80=A6 + .=
/arm-linux-user/qemu-arm ./tests/tcg/arm-linux-user/toupper
CONTROL RESULT: (toupper_string)
 nwlrbbmqbhcdarz owkkyhiddqscdxr jmowfrxsjybldbe fsarcbynecdyggx xpklorelln=
mpapq
 NWLRBBMQBHCDARZ OWKKYHIDDQSCDXR JMOWFRXSJYBLDBE FSARCBYNECDYGGX XPKLORELLN=
MPAPQ

I have submitted a fix to the list that affected programs that couldn't
see /proc/self/maps but I guess that isn't the case here.

--=20
Alex Benn=C3=A9e

