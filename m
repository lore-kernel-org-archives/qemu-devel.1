Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F00EEC54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:33:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B76C0206A4
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 04:33:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W5rb+dAb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B76C0206A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jSvSu-0006uE-Tg
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 00:33:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jSvRs-0005kx-TC
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:32:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1jSvRs-0000fE-Fb
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:32:52 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130]:35491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1jSvRs-0000e8-2g
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 00:32:52 -0400
Received: by mail-lf1-x130.google.com with SMTP id r17so12651872lff.2
 for <qemu-devel@nongnu.org>; Sun, 26 Apr 2020 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=JA3GfwQ3QPc9m21Oy7qxlnX4fx/21emFHqus4GyhjE8=;
 b=W5rb+dAbuu6CER/TopT9WrkxBahGPEMVUIHsqfpPO1A4zqXbqrleixnHEO9fjAuV9C
 QJf/fCcfmA2pT/z1SLHrAKX++DGMGEeGcS3JMCfXbflvwnYlBiCVvALDmTdfBfBRzaL1
 g5XCJZaClYe4bwhxIbId83QANIq0tU5ysLXSMo4h3vXnpHcy8hoITszTNaoo7fIUfHK8
 obK55kJUvUUiG5nvkZFIvZ3mkS/SFjMlErRhmYX40iZA4FnZ0oUZcRX7KrZc5TMpUzgf
 CPhWnRknYyYijdZpoJ+SSHnR62QvRXrlc3tcsjnZ7tQG1n5V5EuFHKYblSO8MKWloqEf
 eVHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=JA3GfwQ3QPc9m21Oy7qxlnX4fx/21emFHqus4GyhjE8=;
 b=oryafMc2t+Pw4LPzC13ovKYIFS/cFZLF7S/HzRzIdgJ1DjG4g2NDA4rU5oOay3MNTR
 p68si2rPSpB0jrQTEqazOfu6jseE81/odXDbArZ2tpLjqJNYN+PgAeWsVCQxGXwDO5YX
 yEoPI6zVM3F7PhLEdUg9IeuqYqA+yEiA0x8JnPIpw+DSc3InQ/vxJHN3dB9D1sWuhmFw
 QSQ8y+bxwPqYtBFLMcsZW9S9wsKymqqedklZrxo5xQgociWMJHyPo37xnyunMW7gmYYp
 CGPNXshfESRsczEBHRs6Fvff5br6b4WwRZ9xBNgwl7e/hZ58jMb9zlug9C0ekRCdbNjL
 NHGw==
X-Gm-Message-State: AGi0PuZ865qN6YapaWWRyhThrP2jhoaluhW3kPz61H/hNwrKhvVhTXl2
 UIyEKH9N00vc+syRb7NLDzg/k3ZjkRKRSxSqOVE=
X-Google-Smtp-Source: APiQypIpha2fL5qaSBvFpm3KrxHiLf5q6eBjhUVGzLIbs2mYyYzV5tzGPCLB4Z4oqhKL70ElXM6pBeHaKURnNeDxcfk=
X-Received: by 2002:ac2:4c39:: with SMTP id u25mr14400709lfq.54.1587961969834; 
 Sun, 26 Apr 2020 21:32:49 -0700 (PDT)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Mon, 27 Apr 2020 12:32:38 +0800
Message-ID: <CAE2XoE90=hFFmuOUUCbXUN4zW0GvL03XXmyAdWnFv4S8GrTx6g@mail.gmail.com>
Subject: I've seen you are trying to add hardfloat support in qemu? Does it
 have any progress now?
To: cota@braap.org, qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000020ff2805a43e3502"
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=luoyonggang@gmail.com; helo=mail-lf1-x130.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::130
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

--00000000000020ff2805a43e3502
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I am interesting doing some help in this area.

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--00000000000020ff2805a43e3502
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I am interesting doing some help in this area.<br clear=3D=
"all"><div><br></div>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data=
-smartmail=3D"gmail_signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=
=E8=87=B4<br>=E7=A4=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =
=C2=A0 sincerely,<br>Yonggang Luo<br></div></div>

--00000000000020ff2805a43e3502--

