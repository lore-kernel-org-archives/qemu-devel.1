Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D19CC3524F
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE2820CC7
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 16:39:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qZD8dVkH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE2820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44506 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyekk-0006RN-Hh
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 11:39:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50484)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <waynli329@gmail.com>) id 1iyejj-0005md-Hb
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:38:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <waynli329@gmail.com>) id 1iyeji-0003Hx-3W
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:38:11 -0500
Received: from mail-io1-xd33.google.com ([2607:f8b0:4864:20::d33]:32959)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <waynli329@gmail.com>) id 1iyejh-0003FB-SC
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 11:38:10 -0500
Received: by mail-io1-xd33.google.com with SMTP id z8so17480212ioh.0
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 08:38:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=wuGW7AK8HwG2b6sh+dHZESP7NcTJuveyoO1fDZzi+Vw=;
 b=qZD8dVkHE9wwGTAOLCER7XrhzN4mzE0tpGc0rt7Kz0hUdbtJi6jkWbeQk16AvOiGPa
 GnL7ITm10XaCfxpsMXmsix+lGk9P1GdPW5V+9uFQDMS6UxY2c9c8VmPbehxs96kpyy2S
 h+cquGlGhwhtJ42udLJpXYP6jp9afkWF0qRLfcXFj8eIqb5Gu2nItm+5SBmaGqddr6pO
 uDmuWUTUXqPb6OneqcYrx34b7I47oDCw7UCxiTaSHo7f1ddVLyKiuSXT30XwIeIrZqD2
 PKgtvt5wEYQUe3lBQ7iWUcvosMbmP3KgdkDWxiSlJnSf0R8y8NblLqcjcrKt9UHePWWi
 pmtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=wuGW7AK8HwG2b6sh+dHZESP7NcTJuveyoO1fDZzi+Vw=;
 b=aGom9zA8ye0TWCvwWpUdVuksBTjaTjLB3pVtYjJhYMm/Dhr5rYZur5Ef1DpMrAWoKi
 U9AIV6mUTUhiN1UxINpAPnN9azIfdfNX/SX3geC62IskG6WH/ZorrfMw63oW/dLZCuwo
 QRlbNcAQ5ipxJgc09SESCBSMOIAoIEuM/U3uzbDAjRbNn4ovJNhzsJLaHPmxzLDH2mja
 ozGXHBxORjMGDKQ3ihb4dF1sJZ+0pNQ/cNHwYZHNsmxeWG6GRS4HUYsd4ZiL+qdvAvOn
 VyeuoleneTbStHYp+q/jTdwzDq0lmlJWwrEjl9QkehjIPqWBUNLH6sgAIYe9weT7q0im
 almg==
X-Gm-Message-State: APjAAAUxKwFsCEKw0Rwlk9XJ8Ntm2Wh6VjPmfEJcQ0FNcfV3zuPARZkC
 ltZfUC4Y8py85xqbWWFm+kyxt9PpUmbT+TmrZs9+MgOx
X-Google-Smtp-Source: APXvYqzvPiq0Y3yeed/9r8pb0dFRqod6m5dyRZXJ8UMabsvY6LpYBEEC9EowToL+K+8ViaBrmuwyn7t1UFhGNOJAAGg=
X-Received: by 2002:a6b:17c4:: with SMTP id 187mr19235318iox.143.1580747888573; 
 Mon, 03 Feb 2020 08:38:08 -0800 (PST)
MIME-Version: 1.0
From: Wayne Li <waynli329@gmail.com>
Date: Mon, 3 Feb 2020 10:37:57 -0600
Message-ID: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
Subject: Need help understanding assertion fail.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000060c2a1059dae8ca4"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::d33
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

--00000000000060c2a1059dae8ca4
Content-Type: text/plain; charset="UTF-8"

Dear QEMU list members,

So we developed a virtual machine using the QEMU code.  This virtual
machine emulates a certain custom-made computer that runs on a certain
military platform.  All I can tell you about this virtual machine is that
emulates a computer that has a PowerPC 7457 processor.  Anyway, we
developed this virtual machine using QEMU on little endian machines (i.e.
like your typical desktop running Windows).  What I'm working on right now
is getting this virtual machine to work on a T4240-RDB which has a PowerPC
e6500 processor.  The biggest roadblock I face when trying to get this to
work relates to the fact that the T4240-RDB is a big-endian machine and
transferring our code from a little-endian machine to a big-endian machine
created a lot of problems due to a lot of bad practices the team made when
they developed the virtual machine.

Anyway that's the background.  The specific problem I'm having right now is
I get the following assertion error during some of the setup stuff our OS
does post boot-up (the OS is also custom-made):

qemu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val: Assertion
`disp == (int16_t) disp' failed.

Looking at the QEMU code, "disp" is the difference between two pointers
named "target" and "pc".  I'm not sure exactly what either of those names
mean.  And it looks like since the assertion is checking if casting "disp"
as a short changes the value, it's checking if the "disp" value is too
big?  I'm just not very sure what this assertion means.

Anyway, the thing is this problem has to be somehow related to the transfer
of the code from a little-endian platform to a big-endian platform as our
project works without any problem on little-endian platforms.  But I think
it would be really helpful if I knew more about this assertion.  What
exactly is trying to check for here and why?  Do you see how it could
relate to endianism issues in any way?

-Thanks!, Wayne Li

--00000000000060c2a1059dae8ca4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Dear QEMU list members,</div><div><br></div><div>So w=
e developed a virtual machine using the QEMU code.=C2=A0 This virtual machi=
ne emulates a certain custom-made computer that runs on a certain military =
platform.=C2=A0 All I can tell you about this virtual machine is that emula=
tes a computer that has a PowerPC 7457 processor.=C2=A0 Anyway, we develope=
d this virtual machine using QEMU on little endian machines (i.e. like your=
 typical desktop running Windows).=C2=A0 What I&#39;m working on right now =
is getting this virtual machine to work on a T4240-RDB which has a PowerPC =
e6500 processor.=C2=A0 The biggest roadblock I face when trying to get this=
 to work relates to the fact that the T4240-RDB is a big-endian machine and=
 transferring our code from a little-endian machine to a big-endian machine=
 created a lot of problems due to a lot of bad practices the team made when=
 they developed the virtual machine.</div><div><br></div><div>Anyway that&#=
39;s the background.=C2=A0 The specific problem I&#39;m having right now is=
 I get the following assertion error during some of the setup stuff our OS =
does post boot-up (the OS is also custom-made):</div><div><br></div><div>qe=
mu_programs/qemu/tcg/ppc/tcg-target.inc.c:224: reloc_pc14_val: Assertion `d=
isp =3D=3D (int16_t) disp&#39; failed.</div><div><br></div><div>Looking at =
the QEMU code, &quot;disp&quot; is the difference between two pointers name=
d &quot;target&quot; and &quot;pc&quot;.=C2=A0 I&#39;m not sure exactly wha=
t either of those names mean.=C2=A0 And it looks like since the assertion i=
s checking if casting &quot;disp&quot; as a short changes the value, it&#39=
;s checking if the &quot;disp&quot; value is too big?=C2=A0 I&#39;m just no=
t very sure what this assertion means.</div><div><br></div><div>Anyway, the=
 thing is this problem has to be somehow related to the transfer of the cod=
e from a little-endian platform to a big-endian platform as our project wor=
ks without any problem on little-endian platforms.=C2=A0 But I think it wou=
ld be really helpful if I knew more about this assertion.=C2=A0 What exactl=
y is trying to check for here and why?=C2=A0 Do you see how it could relate=
 to endianism issues in any way?</div><div><br></div><div>-Thanks!, Wayne L=
i=C2=A0 <br></div></div>

--00000000000060c2a1059dae8ca4--

