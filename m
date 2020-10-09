Return-Path: <SRS0=T5iq=DQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641BDC43457
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D828D20709
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Oct 2020 14:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ISDbtt5x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D828D20709
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57422 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQtXI-000849-SK
	for qemu-devel@archiver.kernel.org; Fri, 09 Oct 2020 10:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQtVf-0006aW-AX; Fri, 09 Oct 2020 10:36:39 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b]:41618)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kQtVb-0007fN-1R; Fri, 09 Oct 2020 10:36:39 -0400
Received: by mail-lf1-x12b.google.com with SMTP id d24so10918439lfa.8;
 Fri, 09 Oct 2020 07:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=b70ybZEuYdSJGRrgbwqCMBXx6vKrWq8e1OoQGiu9zfU=;
 b=ISDbtt5x0JGMdOWAYrOKe1Lruoi5aQdFP1ZvwTiLDm1NTkRwfYNJ8MU0DlgH4FE8bK
 MBf8hgm2ntX17FM6Ku+QsKpEdmkBtdO95JnwJuH+YLUu3IrNUtAmp+woR7sFgLbePNm2
 rz1/EAnIykKMKQ3Sd1OYa39TnNfZwrhnq3P4D2XhZ/8/yTgs9pV6c5KaUXbb3r8Kg04g
 zhhDA1VjXSWQy5+YvBwwROD5hDnlwgjOS623uiYawK+UVj8pu0HvBracrcTNUKWt+tOL
 NAu1PEFsdRVi6yAyHyy4r3Meaxy5pBym2vaScu4/3VLoZfuo4aW4OqW67fLllybB65NO
 dbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=b70ybZEuYdSJGRrgbwqCMBXx6vKrWq8e1OoQGiu9zfU=;
 b=EyZRmYnAEjLdtNW0c3TIs2WYbi6IKlmNlFx9ltSI+Yfunku4rnd3ZzgmqK3gJ8BRV8
 PniBXd/OPIlOv1mWgEFE/Q+DhIhZTO/Bf/JOGP/hyRTaiNj5vc2ZW1WzxahDUFsLSoK4
 z0I+CVigvJtqk1gKGFUJBKs1IV6toCusCxzP4hLIaYyJTHFSKqvduLlQMvlySWyM9WdU
 P5oe0bB1r7arHVClVcMzYx0LjR7fSE1+Srxy3L6vGrkJgtbmIF+fN/UttNXoYTxQgBmV
 n5fwinhenU3sN7Ef5YqSyzyUutGVNW6Jho0voCAErs4dCAWDLT2NfXbU5ql2TDtjAyPK
 Mgmg==
X-Gm-Message-State: AOAM531eRgRpfXtWttMav/DIaor3J3oYTqFkJynML41rLsq1yEjUxu3S
 cVmgLNZjKUr1ATtrZvZN1xQJTAMjDQu566D81AVQfPE0O5sxE3Iu
X-Google-Smtp-Source: ABdhPJyc6zectKL4ERlPoDb9tmhJ7fPH7dIa6SBLiySGfPFvJndj3cd+YJNDaMk4fFf8fqFx+McyAne/gzJzd7RJYk8=
X-Received: by 2002:a19:383:: with SMTP id 125mr4611778lfd.356.1602254191932; 
 Fri, 09 Oct 2020 07:36:31 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 9 Oct 2020 22:36:20 +0800
Message-ID: <CAE2XoE8N+A3Z0zYv=a=SWHkSxWLJM2JD+E67=XzOXAkqx5oBZg@mail.gmail.com>
Subject: What's this error means? On windows, it's randomly failing
To: qemu-level <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000f3387605b13ddff9"
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x12b.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000f3387605b13ddff9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

PASS 7 test-coroutine /basic/in_coroutine
7043PASS 8 test-coroutine /basic/order
7044PASS 9 test-coroutine /locking/co-mutex
7045PASS 10 test-coroutine /locking/co-mutex/lockable
7046MALLOC_PERTURB_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
G_TEST_SRCDIR=3DD:/a/qemu/qemu/tests
G_TEST_BUILDDIR=3DD:/a/qemu/qemu/build/tests tests/test-aio.exe --tap -k
7047PASS 1 test-aio /aio/acquire
7048PASS 2 test-aio /aio/external-client
7049PASS 3 test-aio /aio/bh/schedule
7050PASS 4 test-aio /aio/bh/schedule10
7051PASS 5 test-aio /aio/bh/cancel
7052PASS 6 test-aio /aio/bh/delete
7053PASS 7 test-aio /aio/bh/flush
7054PASS 8 test-aio /aio/bh/callback-delete/one
7055PASS 9 test-aio /aio/bh/callback-delete/many
7056PASS 10 test-aio /aio/event/add-remove
7057PASS 11 test-aio /aio/event/wait
7058PASS 12 test-aio /aio/event/flush
7059PASS 13 test-aio /aio/event/wait/no-flush-cb
7060**
7061ERROR test-aio - Bail out!
ERROR:../tests/test-aio.c:501:test_timer_schedule: assertion failed:
(aio_poll(ctx, true))
7062ERROR:../tests/test-aio.c:501:test_timer_schedule: assertion failed:
(aio_poll(ctx, true))
7063make: *** [Makefile.mtest:317: run-test-43] Error 1

--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000f3387605b13ddff9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">PASS 7 test-coroutine /basic/in_coroutine<br>7043PASS 8 te=
st-coroutine /basic/order<br>7044PASS 9 test-coroutine /locking/co-mutex<br=
>7045PASS 10 test-coroutine /locking/co-mutex/lockable<br>7046MALLOC_PERTUR=
B_=3D${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))} G_TEST_SRCDIR=3DD:/a/=
qemu/qemu/tests G_TEST_BUILDDIR=3DD:/a/qemu/qemu/build/tests tests/test-aio=
.exe --tap -k<br>7047PASS 1 test-aio /aio/acquire<br>7048PASS 2 test-aio /a=
io/external-client<br>7049PASS 3 test-aio /aio/bh/schedule<br>7050PASS 4 te=
st-aio /aio/bh/schedule10<br>7051PASS 5 test-aio /aio/bh/cancel<br>7052PASS=
 6 test-aio /aio/bh/delete<br>7053PASS 7 test-aio /aio/bh/flush<br>7054PASS=
 8 test-aio /aio/bh/callback-delete/one<br>7055PASS 9 test-aio /aio/bh/call=
back-delete/many<br>7056PASS 10 test-aio /aio/event/add-remove<br>7057PASS =
11 test-aio /aio/event/wait<br>7058PASS 12 test-aio /aio/event/flush<br>705=
9PASS 13 test-aio /aio/event/wait/no-flush-cb<br>7060**<br>7061ERROR test-a=
io - Bail out! ERROR:../tests/test-aio.c:501:test_timer_schedule: assertion=
 failed: (aio_poll(ctx, true))<br>7062ERROR:../tests/test-aio.c:501:test_ti=
mer_schedule: assertion failed: (aio_poll(ctx, true))<br>7063make: *** [Mak=
efile.mtest:317: run-test-43] Error 1<br><br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000f3387605b13ddff9--

