Return-Path: <SRS0=4gpF=3O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5095C35242
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 23:31:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8812420708
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2020 23:31:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zam3QHzG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8812420708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58244 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivUtW-0007xb-Lj
	for qemu-devel@archiver.kernel.org; Sat, 25 Jan 2020 18:31:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50598)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <hsp.cat7@gmail.com>) id 1ivUsZ-0007QH-Mx
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 18:30:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <hsp.cat7@gmail.com>) id 1ivUsY-0003GI-GS
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 18:30:15 -0500
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c]:36511)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <hsp.cat7@gmail.com>) id 1ivUsY-0003Fg-Bs
 for qemu-devel@nongnu.org; Sat, 25 Jan 2020 18:30:14 -0500
Received: by mail-oi1-x22c.google.com with SMTP id c16so3304893oic.3
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2020 15:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=PPGhjSPXWfmxdB6VnXOwaCSv7cAeKrp2AD2xeuwFvHE=;
 b=Zam3QHzGjBBFSOOBtyWsCvVlRpo+IPMVKyZ5ObgaxIMrblwVKYAtjQoPC9X1eI5WFV
 C1NV5u7N+eGWFPP4lzbPjrIOYAOZoB9vHm1d+IanFaR7PxkHY6yFK6XFOpU24ChGfdmF
 L88Lsw+DgFSDEP6oHSV6r/cA2mVZuanDXSXEL6tCRJWLnRqiA/lPtLA+y0t9pMZeH7H9
 lsMnyc3MIlTO4XeLsf6CMe8DPKLkS++OIHGB1Mzk5KwIP/N8Er/AdAALL/rm5PzrUeI8
 itOBDkiClGxhXgGmRZxvMDFb7YHtV6A9gsyJ/YYdXiJW15UjHw3JzNlkEZqZ/HspRVf7
 KsYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=PPGhjSPXWfmxdB6VnXOwaCSv7cAeKrp2AD2xeuwFvHE=;
 b=OPSeG7ry7KhsV6Tur1RuuCBihq+2xg5QT3DQjSniy2vytBlI2kiCaYG8mRMiy2rkXb
 Z0drdzflIXLiM+1ffjrz7K6DpgOG5m8liA0TLNeQe2HWR+vywezghmggGyA4I2tfjLS6
 SXXc6Soa8Q33fK6A3i8zdFf5hGruzDjqS5lZXhe0Aggyz3CM6ySKZ5u7nTWfijyC2H/2
 PacPejcxahIrWihQBkWauuErv8YjABWSqLzgP/rtOuOdVjt3NS79auNNBNdnL0o/wvo+
 2rYzk2uwJA2V/cZNS35Pl6TMbq5z7zd8EGsUjdwbY0ySGA5+yHh8sKblcKF/MMF5pUv+
 R4eA==
X-Gm-Message-State: APjAAAUCAsJ8QuxEEMTtKGfAovh1AjovJvtWQsAem7fA7u1ZDgdXnkEo
 0+LYGhhgw/RCZRrKrquSe693q+4DNzwzRPNBWfnf8JQK
X-Google-Smtp-Source: APXvYqxeORRLq+8jbqxe5NHu9ckJpRmqaza2j8BERJgM5phO6IUKh0ZeFE1CQ/nGxqn6vKOjRmHHcYSznepa9jMVhWY=
X-Received: by 2002:aca:2407:: with SMTP id n7mr3584706oic.14.1579995013093;
 Sat, 25 Jan 2020 15:30:13 -0800 (PST)
MIME-Version: 1.0
From: Howard Spoelstra <hsp.cat7@gmail.com>
Date: Sun, 26 Jan 2020 00:30:02 +0100
Message-ID: <CABLmASG93Fz-=XR45Z7pcaUkF8De3EdZbS_=901w_vhYUPiuXg@mail.gmail.com>
Subject: Performance hit in qemu-system-ppc
To: qemu-devel qemu-devel <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000809e59059cff4153"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22c
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

--000000000000809e59059cff4153
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

 Hi,

I noticed a considerable (~20%) slowdown in the cpu performance of
qemu-system-ppc.
Bisecting led me to this commit:

d03f140804b345a85973976506492027f703d82d is the first bad commit
commit d03f140804b345a85973976506492027f703d82d
Author: Richard Henderson <richard.henderson@linaro.org>
Date:   Mon Dec 9 13:49:58 2019 -0800

    cputlb: Move body of cpu_ldst_template.h out of line

    With the tracing hooks, the inline functions are no longer
    so simple.  Once out-of-line, the current tlb_entry lookup
    is redundant with the one in the main load/store_helper.

    This also begins the introduction of a new target facing
    interface, with suffix *_mmuidx_ra.  This is not yet
    official because the interface is not done for user-only.

    Use abi_ptr instead of target_ulong in preparation for
    user-only; the two types are identical for softmmu.

    What remains in cpu_ldst_template.h are the expansions
    for _code, _data, and MMU_MODE<N>_SUFFIX.

    Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
    Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

 accel/tcg/cputlb.c               | 116 +++++++++++++++++++++++++++++++++++=
+
 include/exec/cpu_ldst.h          |  25 +++++++-
 include/exec/cpu_ldst_template.h | 125
++++++++-------------------------------
 3 files changed, 166 insertions(+), 100 deletions(-)

Thanks for looking into this issue,
Howard

--000000000000809e59059cff4153
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">
<div>Hi,</div><div><br></div><div>I noticed a considerable (~20%) slowdown =
in the cpu performance of qemu-system-ppc.</div><div>Bisecting led me to th=
is commit:<br></div><div><br></div><div>d03f140804b345a85973976506492027f70=
3d82d is the first bad commit</div>commit d03f140804b345a85973976506492027f=
703d82d<br>Author: Richard Henderson &lt;<a href=3D"mailto:richard.henderso=
n@linaro.org" target=3D"_blank">richard.henderson@linaro.org</a>&gt;<br>Dat=
e: =C2=A0 Mon Dec 9 13:49:58 2019 -0800<br><br>=C2=A0 =C2=A0 cputlb: Move b=
ody of cpu_ldst_template.h out of line<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 W=
ith the tracing hooks, the inline functions are no longer<br>=C2=A0 =C2=A0 =
so simple.=C2=A0 Once out-of-line, the current tlb_entry lookup<br>=C2=A0 =
=C2=A0 is redundant with the one in the main load/store_helper.<br>=C2=A0 =
=C2=A0 <br>=C2=A0 =C2=A0 This also begins the introduction of a new target =
facing<br>=C2=A0 =C2=A0 interface, with suffix *_mmuidx_ra.=C2=A0 This is n=
ot yet<br>=C2=A0 =C2=A0 official because the interface is not done for user=
-only.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Use abi_ptr instead of target_ulo=
ng in preparation for<br>=C2=A0 =C2=A0 user-only; the two types are identic=
al for softmmu.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 What remains in cpu_ldst=
_template.h are the expansions<br>=C2=A0 =C2=A0 for _code, _data, and MMU_M=
ODE&lt;N&gt;_SUFFIX.<br>=C2=A0 =C2=A0 <br>=C2=A0 =C2=A0 Tested-by: Philippe=
 Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@redhat.com" target=3D"_bla=
nk">philmd@redhat.com</a>&gt;<br>=C2=A0 =C2=A0 Signed-off-by: Richard Hende=
rson &lt;<a href=3D"mailto:richard.henderson@linaro.org" target=3D"_blank">=
richard.henderson@linaro.org</a>&gt;<br><br>=C2=A0accel/tcg/cputlb.c =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 116 ++++++++++++++++++++++++++=
++++++++++<br>=C2=A0include/exec/cpu_ldst.h =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0| =C2=A025 +++++++-<br>=C2=A0include/exec/cpu_ldst_template.h | 125 ++++=
++++-------------------------------<br><div>=C2=A03 files changed, 166 inse=
rtions(+), 100 deletions(-) <br></div><div><br></div><div>Thanks for lookin=
g into this issue,</div><div>Howard<br></div></div>

--000000000000809e59059cff4153--

