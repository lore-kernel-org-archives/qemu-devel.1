Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E421C10DAA
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:29:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C46320936
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 06:29:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AuC3FbnG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C46320936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36748 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFtbx-00015d-GK
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 02:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38520)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFtb3-0000e2-6M
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:28:45 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f]:33929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kFtb1-0007SY-LR
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 02:28:44 -0400
Received: by mail-lj1-x22f.google.com with SMTP id v23so2035554ljd.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 23:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=zi3OWYKlxVKlaaCIs1pFgyZGu9f7Bc2vs4bHwGjQg3c=;
 b=AuC3FbnGJc/zrobIZK6Xvn3/LiRPm50I9Kt1Fkkbk8BOqO4eE6dltNgMDqxevwIngn
 XO7ZbehUvNEV9MupuHrOMCdih2U/o9gy200K7oW49zdFH/plFV7q+1GKZ27eAI2s9/ME
 5LKY+XzlAnxrWwgp2sLgIcJFQ5qD1fmMKdKW3g3hA4hPgdUCBAJq68cS9nYwyUwmKiJh
 wKyGVXYp8wd3U+OnL5N11jtsy3BUEgZw2vsCHGz2uyQFeCwSXV6jGD2gdyxZgrEoXQV3
 Dv9d2e6BxS2HO0FlZBN7acU7OysDU2msRxdukCkZqkm1Cm33qaeVw4+4oXjXvNhPVepD
 epeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=zi3OWYKlxVKlaaCIs1pFgyZGu9f7Bc2vs4bHwGjQg3c=;
 b=rGmwXq4KEK7G0P71eqGLhyNi0xaL8pLkEN5iB79msmNGA2CW2RYoGIjL8MrvRcK3r7
 I+W4D8aGRPHSXUz2rkUOSIAsg+5t3bqE5Re9+cTqTrzZNzo9h/PHoVmUY/lKkzUmQosP
 M8TgJEgzjelFzCFi38ezZAdx8c+Qoofv+rqV6mTqH8Qx5knSP4hlYfW9S+HNk2/UVa9l
 e4dZlWoaB5XkW/LBTG5evT28wh1H4hLJQenBqg0nXzm0pD5T7RlPLNYfIsZdqXtrlWg8
 OSe4b0SB5FrNmOvxexqsgZjpD0laC3Z9yp7r8O2+kTQdIjybhVFEEuWfjGKiojh02Xzu
 zCmw==
X-Gm-Message-State: AOAM531f3DloXKdVI7EOuxRbwpL+wkcQ9tMzl26OMV/woXJ6SRfP6vFQ
 TVPdPv85nAE1sMvTk0l+cYcYEDa0IOQlTu66JYbqJg+fvcVZl8bl
X-Google-Smtp-Source: ABdhPJx+hUVtruzXA4lOX3e1C5VxudfkzbKxiDswtdUk6eklm9WUpFto7QhLx6Dg6HE3Q7zViw2L/S2rUosniDCYsmw=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr1067263ljj.120.1599632920419; 
 Tue, 08 Sep 2020 23:28:40 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Wed, 9 Sep 2020 14:28:28 +0800
Message-ID: <CAE2XoE9TOFpLBdD4b5pcwsu7orW7Dj13G8+YVcZM23BNYJ3+mA@mail.gmail.com>
Subject: When running test-io-channel-socket on win32, the qemu_aio_context
 not inited
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000fe223205aedb8f8a"
Received-SPF: pass client-ip=2a00:1450:4864:20::22f;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x22f.google.com
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

--000000000000fe223205aedb8f8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

qemu_fd_register (c:\work\xemu\qemu\util\main-loop.c:336)
qemu_try_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:224)
qemu_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:230)
socket_can_bind_connect (c:\work\xemu\qemu\tests\socket-helpers.c:93)
socket_check_protocol_support (c:\work\xemu\qemu\tests\socket-helpers.c:141=
)
main (c:\work\xemu\qemu\tests\test-io-channel-socket.c:568)
__tmainCRTStartup (@__tmainCRTStartup:142)
mainCRTStartup (@1400014f6..140001539:3)
BaseThreadInitThunk (@BaseThreadInitThunk:9)
RtlUserThreadStart (@RtlUserThreadStart:12)


when tests calling to  socket_check_protocol_support, the qemu_aio_context
are still null and that's cause tests failure on win32, what we should do?



--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000fe223205aedb8f8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><br></div><div>qemu_fd_register (c:\work\xemu\qemu\ut=
il\main-loop.c:336)<br>qemu_try_set_nonblock (c:\work\xemu\qemu\util\oslib-=
win32.c:224)<br>qemu_set_nonblock (c:\work\xemu\qemu\util\oslib-win32.c:230=
)<br>socket_can_bind_connect (c:\work\xemu\qemu\tests\socket-helpers.c:93)<=
br>socket_check_protocol_support (c:\work\xemu\qemu\tests\socket-helpers.c:=
141)<br>main (c:\work\xemu\qemu\tests\test-io-channel-socket.c:568)<br>__tm=
ainCRTStartup (@__tmainCRTStartup:142)<br>mainCRTStartup (@1400014f6..14000=
1539:3)<br>BaseThreadInitThunk (@BaseThreadInitThunk:9)<br>RtlUserThreadSta=
rt (@RtlUserThreadStart:12)<br></div><div><br></div><div><br></div><div>whe=
n tests calling to=C2=A0

socket_check_protocol_support, the=C2=A0qemu_aio_context are still null and=
 that&#39;s cause tests failure on win32, what we should do?</div><div><br>=
</div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gma=
il_signature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=
=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--000000000000fe223205aedb8f8a--

