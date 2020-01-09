Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866E5C282DD
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 23:57:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FF96206A1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 23:57:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3TEg0dx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FF96206A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iphgN-0003c0-Ej
	for qemu-devel@archiver.kernel.org; Thu, 09 Jan 2020 18:57:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49290)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyonggang@gmail.com>) id 1iphfa-0003CA-M5
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:56:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyonggang@gmail.com>) id 1iphfZ-0000Ie-Hs
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:56:54 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:36300)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <luoyonggang@gmail.com>)
 id 1iphfZ-00007T-7B
 for qemu-devel@nongnu.org; Thu, 09 Jan 2020 18:56:53 -0500
Received: by mail-wr1-x42f.google.com with SMTP id z3so80693wru.3
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 15:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:reply-to:from:date:message-id:subject:to;
 bh=So3Qs0ppfttzEODJO/F2NAgnOQdXKy/7ZbSZ2p/ffsE=;
 b=U3TEg0dxTqiZZcbYmChd2OxC+PQps5eeey/YJPkjMVmC2p72jlFRsFaDzYKm2t6j/2
 YwK0ePyLicm5pGursaD8AHrLmAQ0rRrhJuQrNI14sGdsEGYxJ0sLUvmwsuCGKZCFHM5E
 GMxj/+rNXWCItq0HD7CRHQTSecRFTO7LDaA501f06cHsF6G6+i7Qr1jxgz/isRYuVKoM
 IL5rNMFi7VZhIsE8qRBWA3gzUhHo43HGectnOfQuoVhaQR1iJulIRxzm7lhdbk3YwuBa
 AWDveRZU2qbA+bDMgGwttBul0cYL2mHbFIUDOuWaroUSPC1TP5Dwamv1WLJ/PJP01FYQ
 vevQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:reply-to:from:date:message-id
 :subject:to;
 bh=So3Qs0ppfttzEODJO/F2NAgnOQdXKy/7ZbSZ2p/ffsE=;
 b=Furc7ej65SdedEMFOnBVkRwGlFUx1MHJbfsBY5LPVn+NX6p1yYLbq/46f0L5QtAzsT
 yiwOcJC/XwxkbaBvEK5X2+tU3sovGLZL9b2kWAqJ1M9GAYcOHStnJDw44D62BmhiJrq5
 1JKZ+IHbF+pwkPRjxIotEfHm4/7pbHNVSrlvLuT75E72bBbJH/MMUlhJHqFAr348IcXK
 4ET4060nm2fM/PnXyIgmi/CPia5XS5iduv5PblfHMg1mz+N0N1a7zyMooduw43fCl366
 mB/4AANvsFblNtczM1MRfMvEmF9tHeKq5cA+BvXOoFwzwHirsjLeHf9hz+3Q369gqLbP
 DC+Q==
X-Gm-Message-State: APjAAAXvdiAjFSLiMg6NsMgCjtOAg4SI2ImV0eyBTTOtraRBcxMR6rZE
 HEQNqzOlUWa1JWofTC0/W11Hw0PCB6G6Qy6/4e0HzR8t
X-Google-Smtp-Source: APXvYqyrOaCcrFFvQRzQDjnU99OiVXXH4onQxFOVmJ7+0uP7BbD2cui5BXmjLSoSosXtPUj4cyPxCOCmWtJrvh+Lf8o=
X-Received: by 2002:adf:e6cb:: with SMTP id y11mr10022wrm.345.1578614210914;
 Thu, 09 Jan 2020 15:56:50 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Fri, 10 Jan 2020 07:56:41 +0800
Message-ID: <CAE2XoE-GatzSG+y9y8HWU7TiRHfP4TX232pvim9sy8muXGVzjw@mail.gmail.com>
Subject: Does ppc target support for MTTCG are stable?
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000476ea1059bbdc3c9"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42f
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

--000000000000476ea1059bbdc3c9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I enabled it and working, but I don't know if there any other issue are
still not resolved..


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

--000000000000476ea1059bbdc3c9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">I enabled it and working, but I don&#39;t know if there an=
y other issue are still not resolved..<div><br clear=3D"all"><div><br></div=
>-- <br><div dir=3D"ltr" class=3D"gmail_signature" data-smartmail=3D"gmail_=
signature">=C2=A0 =C2=A0 =C2=A0 =C2=A0=C2=A0 =E6=AD=A4=E8=87=B4<br>=E7=A4=
=BC<br>=E7=BD=97=E5=8B=87=E5=88=9A<br>Yours<br>=C2=A0 =C2=A0 sincerely,<br>=
Yonggang Luo<br></div></div></div>

--000000000000476ea1059bbdc3c9--

