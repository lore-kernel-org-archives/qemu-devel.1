Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_IMAGE_ONLY_08,HTML_MESSAGE,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E5E6C33CB3
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BBAB2083E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 21:14:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SG+HgYet"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2BBAB2083E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isYwg-00062g-Af
	for qemu-devel@archiver.kernel.org; Fri, 17 Jan 2020 16:14:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40661)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fairouz.fsegs@gmail.com>) id 1isXKz-0007to-2E
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:31:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fairouz.fsegs@gmail.com>) id 1isXKx-0006FD-Tw
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:31:20 -0500
Received: from mail-oi1-x231.google.com ([2607:f8b0:4864:20::231]:45841)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <fairouz.fsegs@gmail.com>)
 id 1isXKx-0006EF-PK
 for qemu-devel@nongnu.org; Fri, 17 Jan 2020 14:31:19 -0500
Received: by mail-oi1-x231.google.com with SMTP id n16so23190311oie.12
 for <qemu-devel@nongnu.org>; Fri, 17 Jan 2020 11:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=/uBY9fCAQSyeZdYF9jAsudL5P9yVjLAeINdgiZzi03M=;
 b=SG+HgYet7p2bHkuf1HXLgo/XVFdNimzJEACaBZB1Io2cyaYYOTx1F68cwujM4T4O0c
 +TR4olqAr9fEqVctA5LUbrhMDZQRJuTDxHbRmK8KmgnVnrmYydKgOCH0g/ABV0lrgsUp
 FBlbTShs7PRlDn4RLvfZJDBEQks5SRliUNKA7TgOp7VqqmxjR11rDs5wRkmHoUkkXJED
 E/nk7TasAqdyOdF7WWfeMmTvdjudMgzmx3dZcBRvd248nKGsD1hgf9bHKLYgDM6fZNxF
 hRogGCW4qFedUPs3xMuo4e1I/BTjtnpFtZgSnZvY7fiXVq0QwKDYpT2wTERFsk/FwZpW
 aSHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=/uBY9fCAQSyeZdYF9jAsudL5P9yVjLAeINdgiZzi03M=;
 b=Ra9rwVI2AnMFtYWBrDEo1xTeDu3jxMI7GOibxNE3DuiKKCWBikxTJaBoj9gE5oMNB/
 Z51zEGr3IP0HbwnnTALhyLnMk2ZVrhAuCgVpPdUnN8gbL0M51TjA4JCh7PDoZTQ27u+m
 LkK0T1ANellfjoESF8wPDPtF6tEmYr4tT1XYg7AaKNOb8fnuVGp4jq+jc8PuVo4Nk5hJ
 8FiLJk033ecfjPaJPTe1L4h1M3+l2oDar5jalcYN0a72a+7cHLVBbTi0lDYohMGbEbgK
 45PFi8ZVM24UoTSHjEnIM/9GuQLsx2ruzFsKjtGDw7sYhcKVMTbC/6ni6eBtvIkPhjjA
 fk0w==
X-Gm-Message-State: APjAAAWCJuXofkrB+WfOekVdUWk25dln9lhs0zAuyN0I6MhAk3dSJyZp
 mD8rFin01R060HuL0nAblUfNh5BnnheUpuBcs6gqeeA4
X-Google-Smtp-Source: APXvYqxa/CM8g4H/jGC9h4pFcmdK4Fb3eMWgntAw2lc3H0kmrKNmP+M2wmKXVwR6nH1YuimlgRVI1hAl9F6/7F/4a2g=
X-Received: by 2002:a05:6808:a83:: with SMTP id q3mr4798066oij.0.1579289478123; 
 Fri, 17 Jan 2020 11:31:18 -0800 (PST)
MIME-Version: 1.0
From: Fairouz Fakhfakh <fairouz.fsegs@gmail.com>
Date: Fri, 17 Jan 2020 20:31:08 +0100
Message-ID: <CABeOJJXwH05-fKDumR=vLV8aJvxyZhaqD7S+LMAqEz-53MOmYQ@mail.gmail.com>
Subject: help
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000057533a059c5afc2a"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::231
X-Mailman-Approved-At: Fri, 17 Jan 2020 16:13:05 -0500
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

--00000000000057533a059c5afc2a
Content-Type: text/plain; charset="UTF-8"

Hello,
I would like to use qemu to install a virtual machine (VM) in Ubuntu.
I need a minimal VM  which contains only jdk (openjdk).

Can someone help me, please.
Thank you in advance.

--00000000000057533a059c5afc2a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello,</div><div>I would like to use qemu to install =
a virtual machine (VM) in Ubuntu.<br>I need a minimal VM =C2=A0which contai=
ns only jdk (openjdk).<br><br>Can someone help me, please.<br>Thank you in =
advance.<br></div></div><img src=3D"https://my-email-signature.link/signatu=
re.gif?u=3D43490&amp;e=3D82146786&amp;v=3Dac8ccdef42c4fd4b7d102b7c8d6f15c85=
0fefb5c9a5bd6adaad6257e36bcd7cd" style=3D"width:2px;max-height:0;overflow:h=
idden">

--00000000000057533a059c5afc2a--

