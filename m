Return-Path: <SRS0=sZ1e=65=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F2AC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FE820657
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2020 18:10:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4zfF0V/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FE820657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZemw-0000EF-GT
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 14:10:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.goffioul@gmail.com>)
 id 1jZem1-00082R-A0
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:09:29 -0400
Received: from mail-qt1-x82c.google.com ([2607:f8b0:4864:20::82c]:40805)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.goffioul@gmail.com>)
 id 1jZem0-0003NX-EO
 for qemu-devel@nongnu.org; Fri, 15 May 2020 14:09:28 -0400
Received: by mail-qt1-x82c.google.com with SMTP id c24so2725951qtw.7
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 11:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=jGuN+94YU3NotJwJngKzXUj6RtmqRZFDgnOOOY2x5ek=;
 b=K4zfF0V/x2O/EK8z8jyyhwETIUQ1Eg5XERMNvYaBCAY2fhu7iGSfPnluqkunAbTpik
 PdIS2sJp5JiYs15OncVAaIUZd/c9+bYrgEFLU5bWqex1RepGp6c7OhI7DZOhfst5saGZ
 ygX8ng7rywh/hclhmR+7pqezu//lzwYLZo3E/Yi1TJDR1pXPBZjAissDNyj8jLKARfbz
 X/SeZ4DI7DVlFcypoFocdRt7+In/DqFZeNtR25K4702bE8LyrGSVSdEqFxHX/rqc5z7e
 ct4LZuXw3l+1WE9/c6XuSHHVi75DnCnX3zHSzZS1SrxdFAYWrgaq+1SFz+FD1mMf16WJ
 N2Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=jGuN+94YU3NotJwJngKzXUj6RtmqRZFDgnOOOY2x5ek=;
 b=Q2FA5GVTIak4nMIA6PSNK3f1ywQ3jUBEGJA5nnF037p6HkDJck7HuxExyCtVsgPwI4
 kB0AWekPzQjjAbbDfGEhUpiBzG5+uzc/a+zHmi3gGSI2mmUePJDXHBRLVvdHPdnbStpT
 ukZw5qAyDpsQ2okaRfq23XYFXfuSu0ABCa+Z/7vl0cO19hVITCyxapmUz8pxKg7EEOEw
 IC5RIHeLZ/tZVkcPZF8BT6ohZRw1Zp4Goev/exjGJPjOBWRPFlFiPwoDR72/mx6W6gOq
 VxHBLo8AoOd1ENBNeyWF50caK7FBTRHuLlPpL6Kl2e4nqmRGCIE16fiAjzFyE4+F5aGD
 QHAQ==
X-Gm-Message-State: AOAM532hKrR8H5/zHzt+TfkUmvvwXajK9MMZBBiOqThmpuj3gL4CoyZF
 Z2YhQFr2W869uOTHNfAg3J3qSKp4pfNGKMQJ19eevCM1tJE=
X-Google-Smtp-Source: ABdhPJwLS/rqccYs2yBa6RGgq3N8Mi0w92l9gi2bnbBmZEl8+3kbnpf78prVymb87ypYo9ZJEAIOMSTHuSVh6jBJLXc=
X-Received: by 2002:aed:2d23:: with SMTP id h32mr4778562qtd.389.1589566166625; 
 Fri, 15 May 2020 11:09:26 -0700 (PDT)
MIME-Version: 1.0
From: Michael Goffioul <michael.goffioul@gmail.com>
Date: Fri, 15 May 2020 14:09:14 -0400
Message-ID: <CAB-99Lu3eOQ2asfubOKyO8wLgPhyNvOHy9mgi=MDdR43S0M1Gg@mail.gmail.com>
Subject: Crash when detached thread exits with bionic and QEMU usermode
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000b5745705a5b3b60d"
Received-SPF: pass client-ip=2607:f8b0:4864:20::82c;
 envelope-from=michael.goffioul@gmail.com; helo=mail-qt1-x82c.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000b5745705a5b3b60d
Content-Type: text/plain; charset="UTF-8"

Not sure this is a bug in QEMU usermode, but I've tracked a crash that
happens when running ARM guest code linked against bionic (from Android).
More specifically when a detached thread exits.

In bionic, threads are created with the flag CLONE_CHILD_CLEARTID [1]. When
a detached thread exits normally, bionic calls set_tid_address with nullptr
to reset the address, before unmapping the thread memory [2] and exiting.

The problem seems to be that the handling of TARGET_NR_set_tid_address does
not reset TaskState->child_tidptr, and this lead to a SIGSEGV during
handling of TARGET_NR_exit [3]

[1]
https://github.com/aosp-mirror/platform_bionic/blob/android-10.0.0_r33/libc/bionic/pthread_create.cpp#L390
[2]
https://github.com/aosp-mirror/platform_bionic/blob/android-10.0.0_r33/libc/bionic/pthread_exit.cpp#L123
[3] https://github.com/qemu/qemu/blob/master/linux-user/syscall.c#L7650

--000000000000b5745705a5b3b60d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Not sure this is a bug in QEMU usermode, but I&#39;ve trac=
ked a crash that happens when running ARM guest code linked against bionic =
(from Android). More specifically when a detached thread exits.<div><br></d=
iv><div>In bionic, threads are created with the flag=C2=A0CLONE_CHILD_CLEAR=
TID [1]. When a detached=C2=A0thread exits normally, bionic calls set_tid_a=
ddress with nullptr to reset the address, before unmapping the thread memor=
y [2] and exiting.</div><div><br></div><div>The problem seems to be that th=
e handling of TARGET_NR_set_tid_address does not reset TaskState-&gt;child_=
tidptr, and this lead to a SIGSEGV during handling of TARGET_NR_exit [3]</d=
iv><div><br></div><div>[1]=C2=A0<a href=3D"https://github.com/aosp-mirror/p=
latform_bionic/blob/android-10.0.0_r33/libc/bionic/pthread_create.cpp#L390"=
>https://github.com/aosp-mirror/platform_bionic/blob/android-10.0.0_r33/lib=
c/bionic/pthread_create.cpp#L390</a></div><div>[2]=C2=A0<a href=3D"https://=
github.com/aosp-mirror/platform_bionic/blob/android-10.0.0_r33/libc/bionic/=
pthread_exit.cpp#L123">https://github.com/aosp-mirror/platform_bionic/blob/=
android-10.0.0_r33/libc/bionic/pthread_exit.cpp#L123</a></div><div>[3]=C2=
=A0<a href=3D"https://github.com/qemu/qemu/blob/master/linux-user/syscall.c=
#L7650">https://github.com/qemu/qemu/blob/master/linux-user/syscall.c#L7650=
</a></div><div><br></div></div>

--000000000000b5745705a5b3b60d--

