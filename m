Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FB28C32771
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:12:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04BB422522
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 01:12:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l7JpA9cD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04BB422522
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iti68-00032i-3n
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 20:12:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41924)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iti5Z-0002cm-0q
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:12:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ianjiang.ict@gmail.com>) id 1iti5X-00010R-Ua
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:12:16 -0500
Received: from mail-il1-x12d.google.com ([2607:f8b0:4864:20::12d]:42246)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <ianjiang.ict@gmail.com>)
 id 1iti5X-00010B-No
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 20:12:15 -0500
Received: by mail-il1-x12d.google.com with SMTP id t2so1004250ilq.9
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 17:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/6Ka4PLgO8Wd32BMRnyXtOdzjnqlZcZTuENvmyYqQxo=;
 b=l7JpA9cDCGLTZPrEE59GjwJgtSfiY3uw1ZIjI6OmPhqKjs2ttDQkpO4IE8KIJZ4UPe
 gVpkRRAr0qiVAfnvLx/zzAMdFtAPSSx9uKXArfNrnlZnCPZT36C6zU8LJQiOE0uFGys9
 mUCy8Zo6HyZtnmy/EtdKkVwdQP4uUDAnyFNb6W73Yyo+6twuvzr8zmzGo8w1ney7R+69
 DlbySvPoqgGm+u9ziKAszjahKyA5AVXyIhumX9uF2dTlBtDdJ3zHQuw2+/1hPZ+w9wE7
 dtgRvmJYOObOTbMPAayV1hohChOV5tNHXZItpI9cwCjj+Dbgwlg05mb8kw+yUd7atl7c
 DVwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/6Ka4PLgO8Wd32BMRnyXtOdzjnqlZcZTuENvmyYqQxo=;
 b=D9LykAqhhV+KTJGvhDkW4Tt64F4QR3FQMeCCVkcdhB8g0TaGziROhoulfLyYPTGyn2
 xhMz0B7c0vAfx6tiAyYo58nWhSxR5U0kIzVho3V/hmTq7xRZJVNxah9BZSJHkcK7rlr1
 iCWJKW5z5Z+9lczLSD5rIJMGKXLYw/nt0973B9Ri6qsGyYR1x1mjUe4KsSwwkAplklGf
 bJLpkNCMvo0rxMb47+cEeVuHCYuxNGlmhmOvuwrsVjZs1NNo2S5pE7jQgS/yT5KMAHWC
 SBvoO533gvXDmwKzilVIeSSzPQr8TvKbnF164w/94DT197H5rxnYuC6g3spTriCCskcK
 /yhA==
X-Gm-Message-State: APjAAAWQeCnpXQEorgqIatqRQMmMatx3UehvRAX4iZ4qArXOstp46Ett
 MdOrxjk81Ws1qMh0fheD4aSvanSxMar7xmIHAoUIYbaivII=
X-Google-Smtp-Source: APXvYqz6V+aSy+LzbZthOwI90UvNijaqMMq6CX0vL9sbmqnE2Is6BpWno5L8tHWk6wLD6tFOZ/65YYdJblOVlci3amw=
X-Received: by 2002:a92:8d88:: with SMTP id w8mr1612970ill.71.1579569134652;
 Mon, 20 Jan 2020 17:12:14 -0800 (PST)
MIME-Version: 1.0
From: Ian Jiang <ianjiang.ict@gmail.com>
Date: Tue, 21 Jan 2020 09:12:03 +0800
Message-ID: <CAMAD20n_9Xj6HqgYzB-_Ra71f=_YyS4WkAFJK6VExOA50Bfcjw@mail.gmail.com>
Subject: riscv: How to check floating point support is currently enabled?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002b5312059c9c1968"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::12d
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

--0000000000002b5312059c9c1968
Content-Type: text/plain; charset="UTF-8"

The function riscv_cpu_fp_enabled() is used for checking whether floating
point support is currently enabled. In fact it checks the FS field in the
mstatus MSR.

target/riscv/cpu_helper.c
 76 bool riscv_cpu_fp_enabled(CPURISCVState *env)
 77 {
 78     if (env->mstatus & MSTATUS_FS) {
 79         return true;
 80     }
 81
 82     return false;
 83 }

This will cause a problem that the SD bit in mstatus is not set to 1 when
FS in mstatus is modified from '00'b to '11'b with write_mstatus().

file target/riscv/csr.c, func write_mstatus():
350     dirty = (riscv_cpu_fp_enabled(env) &&
351              ((mstatus & MSTATUS_FS) == MSTATUS_FS)) |
352             ((mstatus & MSTATUS_XS) == MSTATUS_XS);
353     mstatus = set_field(mstatus, MSTATUS_SD, dirty);
354     env->mstatus = mstatus;

So checking fields D and F in the misa MSR (bit 3 and bit 5) may be an
better way. That is
bool riscv_cpu_fp_enabled(CPURISCVState *env)
    if (env->misa & (MISA_F | MISA_F) {
        return true;
    }
    return false;
}


--
Ian Jiang

--0000000000002b5312059c9c1968
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>The function=C2=A0riscv_cpu_fp_enabled() is used for=
=C2=A0checking whether floating point support is currently enabled. In fact=
 it checks the FS field in the mstatus MSR.</div><div><br></div><div>target=
/riscv/cpu_helper.c<br></div><div>=C2=A076 bool riscv_cpu_fp_enabled(CPURIS=
CVState *env)<br>=C2=A077 {<br>=C2=A078 =C2=A0 =C2=A0 if (env-&gt;mstatus &=
amp; MSTATUS_FS) {<br>=C2=A079 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return true;<br>=
=C2=A080 =C2=A0 =C2=A0 }<br>=C2=A081 <br>=C2=A082 =C2=A0 =C2=A0 return fals=
e;<br>=C2=A083 }<br></div><div><br></div><div>This will cause a problem tha=
t the SD bit in mstatus is not set to 1 when=C2=A0 FS in mstatus is modifie=
d from &#39;00&#39;b to &#39;11&#39;b with write_mstatus().</div><div><br><=
/div><div>file=C2=A0target/riscv/csr.c, func write_mstatus():<br></div><div=
>350 =C2=A0 =C2=A0 dirty =3D (riscv_cpu_fp_enabled(env) &amp;&amp;<br>351 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((mstatus &amp; MSTATUS_FS)=
 =3D=3D MSTATUS_FS)) |<br>352 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((m=
status &amp; MSTATUS_XS) =3D=3D MSTATUS_XS);<br>353 =C2=A0 =C2=A0 mstatus =
=3D set_field(mstatus, MSTATUS_SD, dirty);<br>354 =C2=A0 =C2=A0 env-&gt;mst=
atus =3D mstatus;<br></div><div><br></div>So checking fields D and F in the=
 misa MSR (bit 3 and bit 5) may be an better way. That is=C2=A0<div>bool ri=
scv_cpu_fp_enabled(CPURISCVState *env)<br></div><div>=C2=A0 =C2=A0 if (env-=
&gt;misa &amp; (MISA_F | MISA_F) {</div><div>=C2=A0 =C2=A0 =C2=A0 =C2=A0 re=
turn true;</div><div>=C2=A0 =C2=A0 }</div><div>=C2=A0 =C2=A0 return false;<=
/div><div>}</div><div><br></div><div><br clear=3D"all"><div><div dir=3D"ltr=
" class=3D"gmail_signature" data-smartmail=3D"gmail_signature">--<br>Ian Ji=
ang</div></div></div></div>

--0000000000002b5312059c9c1968--

