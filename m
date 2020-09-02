Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54DF6C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:14:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECD120758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 19:14:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O50dKhk3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1ECD120758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43234 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDYDS-0004DB-9r
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 15:14:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48462)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYCj-0003HM-Bq
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:13:57 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230]:39820)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1kDYCg-0000Tt-IJ
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 15:13:56 -0400
Received: by mail-lj1-x230.google.com with SMTP id e11so492008ljn.6
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 12:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=xV0wittsj6u8+/JcEX/EaM6zv+OcnGX7iVErLpcsqj8=;
 b=O50dKhk33os9P+uRrVBj6auTYL9bJFAGrem7HAbUYPGEHKs7PvGp0UhQjJBm7M+WNS
 9+IFST1W8HNK0/6YuVMDK1x4L8tA7nB+trn+xVVO4PnQYD/hcsKr6RpR/YUHx/uuivl0
 HH0KDKzuu+hmczf9WNELU7s9+xHpA7UCFOjpWeFS+UtrXj6rhNG3AekkTf+EJO1/5Zcr
 ag6ONjpmRpRcXAcEtYVQhL1ctjGxoZkkYBdyIUC6DTP02luz11twNEdBkaC5AyMma5ro
 AjRQkWymVI7XF3YHfezeuPgxunTehJm90WiqscBJauerxQGw2hMi5pMotNZtIDtpqvLz
 J0rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=xV0wittsj6u8+/JcEX/EaM6zv+OcnGX7iVErLpcsqj8=;
 b=UeibsYMOUqbM7kOCtiG5tQwIBL4J02/nDOlM1YoVMOJgSnCjQgW1LwJSslQ49xaSpA
 c3rhWvBt6E8ruO6bj69WA4LPORH+W537T1xcGZI7oR08TURfhP/tjAzx+OlyZEgoNxRy
 hghKbhM3zyqHGnYLGYuV4jym6Olztg+2rgwcsxUQxj/IaOFxS6pry/xjwdK4V47fTe85
 sujkPIb7DGbRoLfuHnBdjfrjdZECfDOsazLzmh0O4fU3CqzxaGYMO5FTyJjZQDJl/Ln9
 X6YDG2g57YhWQhach7D4/ii+eM9Fy1q2Ot4s4kCLigjtVcrzLyMLbzAq7Tyv4PJfKvBk
 brJw==
X-Gm-Message-State: AOAM531zYXbrPWPGFvLtIFi+Rh5ujH+vDg9kXV0XDX83unRkZ951vUkg
 wkxapGmTY7V98Z+SAbokPaKua3L9AFhMPilw1fWOalTYAzgy9w==
X-Google-Smtp-Source: ABdhPJzPirbXE0XNIJ87kjFHEvJ0BvQ2vsdg9xmubnhRiascKUwmz211NRPgxofHV52K1gh2v0vFDlFbDO3QhpV9dQ4=
X-Received: by 2002:a2e:854c:: with SMTP id u12mr3923493ljj.120.1599074031930; 
 Wed, 02 Sep 2020 12:13:51 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Thu, 3 Sep 2020 03:13:40 +0800
Message-ID: <CAE2XoE8VqiSFAuRL--VZtj-wOsGcGPn0FO3SOLeVfXwrP12_ig@mail.gmail.com>
Subject: new msys2 testing failure,
 does this fixe? undefined reference to `qemu_lock_fd_test'
To: qemu-level <qemu-devel@nongnu.org>
Content-Type: multipart/alternative; boundary="000000000000a4956905ae596f79"
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=luoyonggang@gmail.com; helo=mail-lj1-x230.google.com
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

--000000000000a4956905ae596f79
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../.=
./x86_64-w64-mingw32/bin/ld.exe:
tests/test-image-locking.o: in function `check_locked_bytes':
5564D:/a/qemu/qemu/tests/test-image-locking.c:69: undefined reference to
`qemu_lock_fd_test'
5565C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ld.exe:
D:/a/qemu/qemu/tests/test-image-locking.c:71: undefined reference to
`qemu_lock_fd_test'
5566C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ld.exe:
D:/a/qemu/qemu/tests/test-image-locking.c:62: undefined reference to
`qemu_lock_fd_test'
5567C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../=
../../x86_64-w64-mingw32/bin/ld.exe:
tests/test-image-locking.o: in function `main':
5568D:/a/qemu/qemu/tests/test-image-locking.c:152: undefined reference to
`qemu_has_ofd_lock'
5569collect2.exe: error: ld returned 1 exit status
5570make: *** [D:/a/qemu/qemu/rules.mak:88: tests/test-image-locking.exe]
Error 1
5571make: *** Waiting for unfinished jobs....
--
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000a4956905ae596f79
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br>C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-ming=
w32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe: tests/test-image-lock=
ing.o: in function `check_locked_bytes&#39;:<br>5564D:/a/qemu/qemu/tests/te=
st-image-locking.c:69: undefined reference to `qemu_lock_fd_test&#39;<br>55=
65C:/tools/msys64/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../..=
/../x86_64-w64-mingw32/bin/ld.exe: D:/a/qemu/qemu/tests/test-image-locking.=
c:71: undefined reference to `qemu_lock_fd_test&#39;<br>5566C:/tools/msys64=
/mingw64/bin/../lib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mi=
ngw32/bin/ld.exe: D:/a/qemu/qemu/tests/test-image-locking.c:62: undefined r=
eference to `qemu_lock_fd_test&#39;<br>5567C:/tools/msys64/mingw64/bin/../l=
ib/gcc/x86_64-w64-mingw32/10.2.0/../../../../x86_64-w64-mingw32/bin/ld.exe:=
 tests/test-image-locking.o: in function `main&#39;:<br>5568D:/a/qemu/qemu/=
tests/test-image-locking.c:152: undefined reference to `qemu_has_ofd_lock&#=
39;<br>5569collect2.exe: error: ld returned 1 exit status<br>5570make: *** =
[D:/a/qemu/qemu/rules.mak:88: tests/test-image-locking.exe] Error 1<br>5571=
make: *** Waiting for unfinished jobs....<br>--<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0=E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br=
>Yours<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo</div>

--000000000000a4956905ae596f79--

