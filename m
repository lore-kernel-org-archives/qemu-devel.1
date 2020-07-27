Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6FE8C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B66B42075A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 10:33:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ncMTmg7q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B66B42075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k00S9-0004Sj-2x
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 06:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k00PS-0002iF-Qk
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:31:06 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233]:41399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ahmedkhaledkaraman@gmail.com>)
 id 1k00PQ-0008PZ-WE
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 06:31:06 -0400
Received: by mail-lj1-x233.google.com with SMTP id s16so1399433ljc.8
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 03:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=Sr5uXuKVKW7kGPKMggalWEP7vz5xY+vZg5oPL/KksYA=;
 b=ncMTmg7q8HyZ+rNNJ9NNFE7l4+Dt8tZKMFSw8zBeOYI4V+Y0iZs6IlTxAPKuz+SuCx
 GSBaIPbhCapvpXt84FXFARruaKs9iExMVIu1mJLN1TBIidu+j4v1LS07oaFPJJgpgM44
 hk7n/srDWdJfYDEK4b2L37bpDW+iygtAUgO9JwfgHp0aZJ/cbWfZS7Jp8vbPbodSqq6P
 y59ZFYGWZBpWj0kgWcyFCDP6tdOicIsPmJlZwH0L6A0ucxVymubVy+8lNZzB6/sWHYv5
 dXoIg9i9xgTiS6BK0VP1UWLpVa4jjkEYCV7wugW+hZR60MnMnBPy0Tvmf+hLVaLhDMH6
 yilQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Sr5uXuKVKW7kGPKMggalWEP7vz5xY+vZg5oPL/KksYA=;
 b=T0wOBvLTmLtfPBtQO64wnxpeIOQmhJmbCAcN5TMvWbqkvunzA6TcK/gSGXEV2TDJ1O
 TqLCGaHXWvPPux1l5Sw51QMto6Yy8k0050GhwC8qLzu9Ey5ReeoJweUKCtmO/GLWe6uR
 HgQbgvd15ZV+PFmVjo+p5/44sFaaCqd9n/O8Gf+v6HFDgrZkFHD5d243rUPo3Q3pwLMx
 z94iwazQpotggm+Qi5vCtQRPethNy029xefjslKspckUFhbpEHkF6zTG01GdEdFLxYEZ
 kguiYcKphF02lGS/XAnW7efamZJ6A+PpuvrvZMVXlz44HeCc/6Pl+XsbYa9MTPy7JU9R
 DSVQ==
X-Gm-Message-State: AOAM533gWKkKomj2NhbfPF6JL4isg+DG0XyZ1QCJh0WlxIEEzgokXaKh
 fsVGzH35rycjbW/BKKvz5YS8iE8TRGzV4HBhqikD6g==
X-Google-Smtp-Source: ABdhPJwcsY/L9ql4+0uTdC/n77cl1vcOicOtE0DPcakaLRL/VuTscZ+fQabKtB+I/TqzLNcTPaWYtx0psw9Acxexbmc=
X-Received: by 2002:a2e:908a:: with SMTP id l10mr2464485ljg.409.1595845862297; 
 Mon, 27 Jul 2020 03:31:02 -0700 (PDT)
MIME-Version: 1.0
From: Ahmed Karaman <ahmedkhaledkaraman@gmail.com>
Date: Mon, 27 Jul 2020 12:30:00 +0200
Message-ID: <CALTWKrWnseJidqDTDQM9TY3JfmvXy_0JufH9rR6hZHoAXkP8VQ@mail.gmail.com>
Subject: [REPORT] [GSoC - TCG Continuous Benchmarking] [#6] Performance
 Comparison of Two QEMU Builds
To: QEMU Developers <qemu-devel@nongnu.org>, 
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?B?THVrw6HFoSBEb2t0b3I=?= <ldoktor@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>, 
 Richard Henderson <rth@twiddle.net>, luoyonggang@gmail.com, jsnow@redhat.com
Content-Type: multipart/alternative; boundary="000000000000bd147905ab69d1cf"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=ahmedkhaledkaraman@gmail.com; helo=mail-lj1-x233.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000bd147905ab69d1cf
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

The sixth report of the TCG Continuous Benchmarking project presents a
performance comparison between two different QEMU builds, GCC and Clang.

The report also presents five new benchmarks to allow for a variety of
test workloads. Each of the five benchmarks is executed for seventeen
different QEMU targets on both the GCC and Clang builds.

The resulting ten tables are then summarized then analyzed using the
list_helpers.py and list_fn_callees.py scripts. The entire workflow is
automated using Python scripts that are posted in the report.

Report link:
https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Performance-Comparison-of-Two-QEMU-Builds/

Previous reports:
Report 1 - Measuring Basic Performance Metrics of QEMU:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.html
Report 2 - Dissecting QEMU Into Three Main Parts:
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.html
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.html
Report 4 - Listing QEMU Helpers and Function Callees:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.html
Report 5 - Finding Commits Affecting QEMU Performance:
https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.html

Best regards,
Ahmed Karaman

--000000000000bd147905ab69d1cf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi everyone,<br>
<br>
The sixth report of the TCG Continuous Benchmarking project presents a<br>
performance comparison between two different QEMU builds, GCC and Clang.<br=
>
<br>
The report also presents five new benchmarks to allow for a variety of<br>
test workloads. Each of the five benchmarks is executed for seventeen<br>
different QEMU targets on both the GCC and Clang builds.<br>
<br>
The resulting ten tables are then summarized then analyzed using the<br>
list_helpers.py and list_fn_callees.py scripts. The entire workflow is<br>
automated using Python scripts that are posted in the report.<br>
<br>
Report link:<br>
<a href=3D"https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Performa=
nce-Comparison-of-Two-QEMU-Builds/" rel=3D"noreferrer noreferrer" target=3D=
"_blank">https://ahmedkrmn.github.io/TCG-Continuous-Benchmarking/Performanc=
e-Comparison-of-Two-QEMU-Builds/</a><br>
<br>
Previous reports:<br>
Report 1 - Measuring Basic Performance Metrics of QEMU:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg06692.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-06/msg06692.html</a><br>
Report 2 - Dissecting QEMU Into Three Main Parts:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg09441.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-06/msg09441.html</a><br>
Report 3 - QEMU 5.0 and 5.1-pre-soft-freeze Dissect Comparison:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01978.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-07/msg01978.html</a><br>
Report 4 - Listing QEMU Helpers and Function Callees:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg04227.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-07/msg04227.html</a><br>
Report 5 - Finding Commits Affecting QEMU Performance:<br>
<a href=3D"https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg05769.h=
tml" rel=3D"noreferrer noreferrer" target=3D"_blank">https://lists.gnu.org/=
archive/html/qemu-devel/2020-07/msg05769.html</a><br>
<br>
Best regards,<br>
Ahmed Karaman<br></div>

--000000000000bd147905ab69d1cf--

