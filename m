Return-Path: <SRS0=5JRQ=YY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E59CA9EC3
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 318012083E
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Oct 2019 09:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=qnap.com header.i=@qnap.com header.b="XqBVeFH+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 318012083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=qnap.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iQ6Pe-0006pI-8u
	for qemu-devel@archiver.kernel.org; Thu, 31 Oct 2019 05:06:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60488)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <danielcho@qnap.com>) id 1iQ6Oe-0005l2-77
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <danielcho@qnap.com>) id 1iQ6Od-0008Du-1m
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:05:35 -0400
Received: from mail-yw1-xc2b.google.com ([2607:f8b0:4864:20::c2b]:41120)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <danielcho@qnap.com>) id 1iQ6Oc-0008BV-SK
 for qemu-devel@nongnu.org; Thu, 31 Oct 2019 05:05:34 -0400
Received: by mail-yw1-xc2b.google.com with SMTP id j131so1866463ywa.8
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2019 02:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qnap.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=Qf6M7vd7i/txNHtq04oL6TDWr5Iju7KFon5CwBjGTyM=;
 b=XqBVeFH+gSH/wJGGCaDUTK1kWp0zIKQpTZbymuveQ4MZZISPJRI7nV6/N7Bsjp9itv
 pP5PvZoRmdTQuqL4/8RnffbueGBx1uaT0AEOHe8gA106VONXmkww0nUbWSB+twHsuKvN
 Xpj/mevOU/zY98Oy4kAaHYP4ObJp9clN6pD3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=Qf6M7vd7i/txNHtq04oL6TDWr5Iju7KFon5CwBjGTyM=;
 b=ScLlGyNyjICPmdYv/y7IyAxhDMaaXW4x2tzbwXA800hIUyQxydWE4EsAJNL9YXPG6Q
 us0Vk87MOgSkXIvpK8r2lLBAytqsRGATGqmTlRju5i5X8iyDpgj6vtw6vYr2IfHbRLBP
 vX5EaUNbNkdKF86XAhmg+CIUXR/Hs9ViyrUfPk6u6IujZl4PxH2ZSfvRkbbYtz7NmTKo
 TgskfsOKmZ5U7oNCnqSsVwKCyS/iSXD/VoA3b3dg/qaYsdN3zZ6Gw48VDFunPt/Dxf1+
 kQcPDLitdGF1hLJAfALvevD52xa9+hEYIMBxiiScmdP3G9kzOTd6wF12VvOlLeEioqq3
 YdJA==
X-Gm-Message-State: APjAAAXhqnP0YwKf+yeVUvTs0ytcYodgqnPYxl9FcqcbNFKh4J5YjmMH
 qZhRaNSnSUZzpnaw1kEtlni5lgrd8HIXPM4yn5GlI1Ncw+jkBA==
X-Google-Smtp-Source: APXvYqzrXy+UIUiUsFwOEnL6BgtRHalglrOzSXDTNJb4FXS9Lpp2Kt6auBRbe+PGPKNG2RS0H5vjz6xATMQVkD+G5IQ=
X-Received: by 2002:a81:2cc6:: with SMTP id s189mr3191905yws.154.1572512732841; 
 Thu, 31 Oct 2019 02:05:32 -0700 (PDT)
MIME-Version: 1.0
From: Daniel Cho <danielcho@qnap.com>
Date: Thu, 31 Oct 2019 17:05:20 +0800
Message-ID: <CA+XQNE5xLXSNUEEd9n_=Hcgu=8QXvwFNuZ4B5WunSmiqM_tnrg@mail.gmail.com>
Subject: The problems about COLO
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000d8a2ed05963126c5"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::c2b
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

--000000000000d8a2ed05963126c5
Content-Type: text/plain; charset="UTF-8"

Hello all,
I have some questions about the COLO.
1)  Could we dynamic set fault tolerance feature on running VM?
In your document, the primary VM could not  start first (if you start
primary VM, the secondary VM will need to start), it means to if I want
this VM with fault-tolerance feature, it needs to be set while we boot it.

2)  If primary VM or secondary VM broke, could we start the third VM to
keep fault tolerance feature?


Best regard,
Daniel Cho.

--000000000000d8a2ed05963126c5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello all,=C2=A0<div>I have some questions about the COLO.=
=C2=A0</div><div>1)=C2=A0

Could we dynamic set fault tolerance feature on running VM?

</div><div>In your document, the primary VM could not=C2=A0 start first (if=
 you start primary VM, the secondary VM will need to start), it means to if=
 I want this VM with fault-tolerance feature, it needs to be set while we b=
oot it.</div><div><br></div><div>2)=C2=A0 If primary VM or secondary VM bro=
ke, could we start the third VM to keep fault tolerance feature?</div><div>=
<br></div><div><br></div><div>Best regard,=C2=A0</div><div>Daniel Cho.</div=
><div></div></div>

--000000000000d8a2ed05963126c5--

