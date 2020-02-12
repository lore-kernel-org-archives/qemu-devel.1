Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B43C4C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:23:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EE2821734
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:23:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mgURBvjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EE2821734
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yY2-0004bR-Lx
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:23:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40683)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jerry.geis@gmail.com>) id 1j1yXV-000489-5l
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:23:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jerry.geis@gmail.com>) id 1j1yXU-0005jp-9r
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:23:17 -0500
Received: from mail-qv1-xf33.google.com ([2607:f8b0:4864:20::f33]:38642)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <jerry.geis@gmail.com>)
 id 1j1yXU-0005jO-5r
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:23:16 -0500
Received: by mail-qv1-xf33.google.com with SMTP id g6so1561820qvy.5
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=x6UNEvYBqwKi7bblt/3Fku0Kod0c5C9fMhEZdr4mJT0=;
 b=mgURBvjlE3MaA95hnovoWYspavTw8GpXA52TiaP8DTspap2cNRJNE8cc8iDHVu7dBO
 uYl8C9bKUZ7mNuuvlgLrVROahgAELyZxkg6RNYkj5aSFpWTJH6D8igm96jBgew4Etwt4
 QAaZUfUsnq6Wpx8LrWIGpqMsKUkhE6BYxYoHCbrNkH74BgU+hjIenTn40pc91y/Jr5pt
 bcNsBEw9GDWj+WkfGjw7V2fHeKT4kIylgBl3mY8Q3olBPuOBo19Mhtufg1LO/6oTbvno
 LpR8hZuSh1eQt17mvqdUzLhxqUbrxwZt3UBVhKAXSLx3pPCU3RViEJLwelphaifx1LZd
 KAJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=x6UNEvYBqwKi7bblt/3Fku0Kod0c5C9fMhEZdr4mJT0=;
 b=c+X2Z51CMeaNv3qHS6GiigVjnLHGiJErTNCdYeQUagcXo56Q70nuWgGYa8n4SK4Cjp
 vQdt5SSPDe8B01SWiQvMDGUsTsjRDVB6741eDXgE/gssd4/zJDs1NnbUy5e1VhJOsykS
 9MKPCZUaI0bcVo+kofCocXw7lkmI9JkEYbM0wGwsk3guw73+W4BN1QzmyzTYVA2vFkTd
 bX5HxDql0DZWhAWxssomNTIEd1AB96Ae+n4Xd8TOLRag47M+WgY6N0ZLe4Wk7Z+zyAjw
 +E+Rfw9/C43gNMxjpxb6RxoEJ71G5P07u9bRrnkz2V0WF2MC9xWwoFLSekiQR5qg8CVP
 07yg==
X-Gm-Message-State: APjAAAVctc8rSiisZKltdQbuaQu7lRgV5bSILAc4nL7XkzTra+uXmWGX
 BwOH9uI2shCDHiJFgVlWq0MvbOSHgip3NWQCKskvNw==
X-Google-Smtp-Source: APXvYqzfZN23r2eztXTZ3It7aeXAiqvvtjTVF7JoLISJc5PA/VhbvFxACTLZ338dJTlL7QEcfpmxS5+RRew17u6Kygo=
X-Received: by 2002:ad4:514d:: with SMTP id g13mr20445717qvq.190.1581538995133; 
 Wed, 12 Feb 2020 12:23:15 -0800 (PST)
MIME-Version: 1.0
From: Jerry Geis <jerry.geis@gmail.com>
Date: Wed, 12 Feb 2020 15:23:04 -0500
Message-ID: <CABr8-B4_mEkOkodKVVe=U_eiMemWictNSQj4T5R6nEynVXCEGw@mail.gmail.com>
Subject: How do UEFI on Windows host
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000000e030059e66be9f"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::f33
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

--00000000000000e030059e66be9f
Content-Type: text/plain; charset="UTF-8"

How do I start a UEFI install (centos 8) for UEFI with 4.2.0 on Windows
host ???
I can do a regular install just fine. I desire to do UEFI install.

Thanks,

Jerry

--00000000000000e030059e66be9f
Content-Type: text/html; charset="UTF-8"

<div dir="ltr">How do I start a UEFI install (centos 8) for UEFI with 4.2.0 on Windows host ???<div>I can do a regular install just fine. I desire to do UEFI install.</div><div><br></div><div>Thanks,</div><div><br></div><div>Jerry</div></div>

--00000000000000e030059e66be9f--

