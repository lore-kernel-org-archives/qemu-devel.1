Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70956C433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:12:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D03D20729
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 20:12:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDR36Mai"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D03D20729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39218 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k09Ts-0005pH-Ib
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 16:12:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jerry.geis@gmail.com>)
 id 1k09TB-0005NC-TC
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:11:33 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830]:32826)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jerry.geis@gmail.com>)
 id 1k09T9-0007fc-0I
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:11:33 -0400
Received: by mail-qt1-x830.google.com with SMTP id 6so13270871qtt.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 13:11:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=8A7XfRTIO9zzRbf05t9kS98sNHXucURN+N2YbRa0ZTA=;
 b=eDR36MaiS4rsHSkdv8+9Irkenx5ggJx9Tktwhc/B/dhPrPE6vMjs6BcFBsh/jh3i0A
 8WaJABWfKE+G30VfEl1yQ5GGDjbKCHKOpY8xHYinbzg3AHvA4/PjbHx6xtwuS9NWNfBG
 aShZiSm6dOSDpQJ5zy9u0/Py7PpY5rlfxK4GE1hrqXTLLBdyIz7Md6TsM0yRfoTre8EZ
 0EEZa/AGay1wSumHJWq/+oLIzrA0ZfveP6yVaaK9kqFQTd7OoEpmV9n2JCPchthge5ei
 hOtGwMM55ktLvEJSn/ih6L8n1yBFrCHNlVwS6OAhDcjNG1EF7PHONpjf0C5LV/gh5TlZ
 UzIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=8A7XfRTIO9zzRbf05t9kS98sNHXucURN+N2YbRa0ZTA=;
 b=qOx89kG5iDt7vRMdNd14FRzhF8waZLXWpa7mxc1SN+MxSuiZON95p1/3bscGhtEqFL
 B5GAWIJio/l9UOnIW3vXho8UVq6zMZ+kfmIg4IsWBlV0/zSeS6ROpCDcSlUwrclX0hik
 SEWv+cXnFLmIuFJfJOaZDHZUhXS7fBsJ3630KAb7LHW9+p7ZaI2vwFVClMJ9QJQmg5hu
 203xYOXZYVnygMUpKjnqUomfwO6/wRLF+Ul8eIYWFIF9sACwZiZ6O0MXvgfcubF1dQOs
 l/HDVi4ISGC6s2tlRqWa9MEEnt76UvN9CN63J0WPwSyvqVbx1A3EiYTo4MocxmQ6q/ZP
 42dg==
X-Gm-Message-State: AOAM530eXmrgBuGx4UABXps6ZaCbKyN4RTmB34TOwJLQ9IoTcaAbDgok
 74/A4okmDuMqTLLvX6eaaWSJvqyAZHNvM8zStqIjIu6a
X-Google-Smtp-Source: ABdhPJytTKwWm45A03HF1kjcoFqXw6nM7tWWVA0oiDRJ9ixSmQgc7pUkcYEX808RjkF7pJrosTheq7QZ0iRYS9qyvYA=
X-Received: by 2002:ac8:3772:: with SMTP id p47mr22643915qtb.355.1595880689367; 
 Mon, 27 Jul 2020 13:11:29 -0700 (PDT)
MIME-Version: 1.0
From: Jerry Geis <jerry.geis@gmail.com>
Date: Mon, 27 Jul 2020 16:11:18 -0400
Message-ID: <CABr8-B7TfZq5hEBCDP47tVrwvHiLDvUAM9JxKqiRQNttcrSTAQ@mail.gmail.com>
Subject: Windows 10 client 4k
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000098052f05ab71ed09"
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=jerry.geis@gmail.com; helo=mail-qt1-x830.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000098052f05ab71ed09
Content-Type: text/plain; charset="UTF-8"

How do I get 4K resolution on Windows 10 client.
I have using CentOS 7 or 8 (hosts) either one - both have issue.
I am set for QXL for the guest.

I tried to look at the VirtIO stable and new - neither have a Windows 10
driver under QXL.
THey stop at windows 7.  Lets me to think there is a different way to do
this - but I dont know what that is .

Suggestions?  My LInux host is running in 4K.

Thanks,


Jerry

--00000000000098052f05ab71ed09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">How do I get 4K resolution on Windows 10 client.<div>I hav=
e using CentOS 7 or 8 (hosts) either one - both have issue.=C2=A0</div><div=
>I am set for QXL for the guest.</div><div><br></div><div>I tried to look a=
t the VirtIO stable and new - neither have a Windows 10 driver under QXL.</=
div><div>THey stop at windows=C2=A07.=C2=A0 Lets me to think there is a dif=
ferent way to do this - but I dont=C2=A0know what that is .</div><div><br><=
/div><div>Suggestions?=C2=A0 My LInux host is running in 4K.</div><div><br>=
</div><div>Thanks,</div><div><br></div><div><br></div><div>Jerry</div></div=
>

--00000000000098052f05ab71ed09--

