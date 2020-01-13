Return-Path: <SRS0=PCRa=3C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C74E8C33CAD
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9263C207E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2020 15:07:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0GgVb/m"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9263C207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ir1Iy-0005dG-Kp
	for qemu-devel@archiver.kernel.org; Mon, 13 Jan 2020 10:07:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49098)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1ir1IJ-0005D3-KY
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:06:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1ir1II-0005kb-G2
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:06:19 -0500
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329]:53207)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1ir1II-0005iw-8v
 for qemu-devel@nongnu.org; Mon, 13 Jan 2020 10:06:18 -0500
Received: by mail-wm1-x329.google.com with SMTP id p9so10082683wmc.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2020 07:06:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=qlD924yJdSysyHuQoAvMAT1AdU1kxE17JTwVWzBb9uU=;
 b=I0GgVb/mJU/itYLGnPqvjUZ3MDSb3hsoOAV9nZwEE1oUB0impmdKnXCJe9aSafYx4I
 i1gqaSZf2b/hpvRA+M81Wpwl0QKWDoaiF8pfDJOV2boXJaikQr8U2HcZPBJySIs4It1v
 ZCDCFnaWxaqbyXYVcsFwrwwin8ylpXtDIp9JozmSW99EQ7DNyFysPYAuLZwWdRTsFh7I
 NPwyl95gksdPddQrsPQiMjszrdrvqp9WOzQ9p23SP+b77h01UBbJ7mHwEfXJz2iqK3TV
 FPrcaIOwRUrlENWfqT0mhHRzupvbkJ/RfvPNGohVSbfN7s5L6QPR3DoVi6ZTYL2wUW4R
 sfBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=qlD924yJdSysyHuQoAvMAT1AdU1kxE17JTwVWzBb9uU=;
 b=gfXBr9dYLzxfeLh0qum/sumOeToQkxr6BMLULur27nAKK6KtLh/1HjLItfweddTz67
 7vl5FACfwo6OBX+GwNu0XVIuD5F3gwQePlyOyTmadOUXGmQzKppOuZLeipBQGmYPMQYv
 YtFAZ4+ky7nMeCrPgL8RVJbTALtAjDh5JzcKgD3KVq/ofC5Ce7Fo6YBCX/EEKrYPcecA
 0iBCNR3XUvaamBzV5bjp9B/hK7NBY2qvbaYA97MkGLZROA8rPlCxkiYZnTx4xQkrvOQL
 KDk61U9sK5Dy0V2siiZVtyYz+lFXIbyC0zhZJl1Gs7x54Tlsv0u70Mmx87EC7ny1ZUbW
 XF/Q==
X-Gm-Message-State: APjAAAXaW6qvch8ajAByqiQuKwhIqGI+RImjXPE5BEQQFz5i2MYA6MN1
 Xj0R73u3mQ0s2gus8dcmq7azFNxYkrrlIuGBJoVflLaOm9sjkQ==
X-Google-Smtp-Source: APXvYqxAk1e6i/5ySDuJ/J7B3zsDv77i8ZpxtBEacuIxOSNZS46LrAmWrmK6PxOu2yp75Dtygl1RBFCDRMrlXPvDx9I=
X-Received: by 2002:a7b:cd07:: with SMTP id f7mr20064696wmj.37.1578927976176; 
 Mon, 13 Jan 2020 07:06:16 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 13 Jan 2020 23:06:04 +0800
Message-ID: <CAE2XoE9y_dR8t7vQABm6xzc03ARyEZ8zqD2XrNL64J9GoEHpLg@mail.gmail.com>
Subject: Issue: whpx mode can not install windows 7 os.
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000002563b4059c06d1ee"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::329
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

--0000000000002563b4059c06d1ee
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

any idea about how to resolve this problem.
ENV: MSYS2 newest.
```
mkdir build-qemu-x64
cd build-qemu-x64
../qemu.org/configure --python=3Dpython3 --prefix=3D/usr --disable-gtk
--disable-sdl --disable-virtfs --disable-werror \
  --enable-capstone=3Dsystem \
  --target-list=3Di386-softmmu,x86_64-softmmu,ppc-softmmu,ppc64-softmmu \
  --enable-hax --enable-whpx --enable-lzo --enable-vnc-jpeg
--enable-vnc-png \
  --enable-vdi --enable-qcow1 --enable-tools \
  --enable-libusb --enable-usb-redir --enable-membarrier --enable-smartcard
make install -j10 DESTDIR=3D/e/CI-Cor-Ready/xemu/qemu.org-x64
```.


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--0000000000002563b4059c06d1ee
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">any idea about how to resolve this problem.<div>ENV: MSYS2=
 newest.</div><div>```</div><div>mkdir build-qemu-x64<br>cd build-qemu-x64<=
br>../<a href=3D"http://qemu.org/configure">qemu.org/configure</a> --python=
=3Dpython3 --prefix=3D/usr --disable-gtk --disable-sdl --disable-virtfs --d=
isable-werror \<br>=C2=A0 --enable-capstone=3Dsystem \<br>=C2=A0 --target-l=
ist=3Di386-softmmu,x86_64-softmmu,ppc-softmmu,ppc64-softmmu \<br>=C2=A0 --e=
nable-hax --enable-whpx --enable-lzo --enable-vnc-jpeg --enable-vnc-png \<b=
r>=C2=A0 --enable-vdi --enable-qcow1 --enable-tools \<br>=C2=A0 --enable-li=
busb --enable-usb-redir --enable-membarrier --enable-smartcard<br>make inst=
all -j10 DESTDIR=3D/e/CI-Cor-Ready/xemu/qemu.org-x64<br></div><div>```.<div=
><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_si=
gnature" data-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=
=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours=
<br>=C2=A0 =C2=A0 sincerely,<br>Yonggang Luo<br></div></div></div></div>

--0000000000002563b4059c06d1ee--

