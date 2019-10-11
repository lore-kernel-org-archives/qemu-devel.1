Return-Path: <SRS0=T2pn=YE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02EF1ECE58D
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4ADF218AC
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2019 18:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nfwz5eel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4ADF218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55810 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIzxz-000899-NQ
	for qemu-devel@archiver.kernel.org; Fri, 11 Oct 2019 14:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60875)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mindentropy@gmail.com>) id 1iIzwm-00072s-Oc
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mindentropy@gmail.com>) id 1iIzwk-0004eI-N8
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:47:28 -0400
Received: from mail-qt1-x82d.google.com ([2607:f8b0:4864:20::82d]:39655)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mindentropy@gmail.com>)
 id 1iIzwk-0004ax-IY
 for qemu-devel@nongnu.org; Fri, 11 Oct 2019 14:47:26 -0400
Received: by mail-qt1-x82d.google.com with SMTP id n7so15274286qtb.6
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2019 11:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=cB32g707z84hqWl4LgeRCHqbQQYwq6Ta2LTjE7ckE9o=;
 b=Nfwz5eelVPAnE5+ByEngA08m7jn6xb+qce0KoSoBzQENarhFX8rUrKka4zGepcttRp
 Z2GlHt0AHrQ0yHCQT/v4LKdw7JhpP3RewPsVV+rKHgPCMs4imFhgrSumRDaSOnfAFgMk
 RKnjvDC46ujA6XbXeMkFxDjt8ECMev3lUGY3s8UTUthKpV3A8O2AvceDNxCBjfT6jiTv
 Aftd5bIVamTA25ylhUtsXf7IM2PBCtwhudPep8gEFf+XGa1By4LoSRCkyoIU70pN+SDe
 Zdow5EF8VuvB7AVGS8H3EZt7OlB39afNvMviQJSJ/EVYt3eUMsDTXUBc5khheMleSX3Z
 Py+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=cB32g707z84hqWl4LgeRCHqbQQYwq6Ta2LTjE7ckE9o=;
 b=dszBkFlEeRm0cWzwdnNDiMmjgk9QYYYZLMKEL8uQIWjA7rgawxqOGUApn5u42CwqJX
 yQ0g4+wOqupW44Sbamj0guD4l0Gc0mSyLRw33QsJasVi9IcNdj2RRwMkPS/vuUtG0XJm
 WE7eo0T/1HWVwPVYHjWmh9pQRD0rmP5h+ZbmUZJosFEykhxiHm4r8s0quUJY4EcUfgYw
 385gzwBQITJPh+VEhL8eZHDiRWE9QBAvy+DraRZ55G2ZqT+aVw+I0Sk7ASDBm4JuoYdI
 0VvBhJOgM58EfnCwIO3ycgD+dzdo4xbig4LLZMcVezV78iU3G/im9pwDPGgsLk6ZGfNu
 4aLw==
X-Gm-Message-State: APjAAAVTGjvb5TCG2DKdyQxmpHw2iiRkrjCupuZEzI4ofF6ldtgQQVih
 x1nQfPUQZTOxYanuO4lzSi8G/5jsx9y/N8MFTHdqPg==
X-Google-Smtp-Source: APXvYqyUNBAv0gbaMdlTpdqOByYykQxSk5X/ShDl7V+nbHnPkDJz7ej2hO4wY2B93dTuOY5VNI9wbBMqxVvqFcwy1Nw=
X-Received: by 2002:ad4:4583:: with SMTP id x3mr17939372qvu.162.1570819641851; 
 Fri, 11 Oct 2019 11:47:21 -0700 (PDT)
MIME-Version: 1.0
From: Gautam Bhat <mindentropy@gmail.com>
Date: Sat, 12 Oct 2019 00:17:10 +0530
Message-ID: <CAM2a4uzF-mtTEYwQE3+MvvDiQrfC_KQMwX4vqCg_dY9ytjZrjA@mail.gmail.com>
Subject: ACPI table modifications
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="000000000000c245850594a6f2a2"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::82d
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

--000000000000c245850594a6f2a2
Content-Type: text/plain; charset="UTF-8"

Hi,

I want to add some I2C based temperature sensors to the -M Q35 machine. I
want to update the ACPI tables to add this device information. How can I go
about  doing this?

Thanks,
Gautam.

--000000000000c245850594a6f2a2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:verdana,=
sans-serif">Hi,</div><div class=3D"gmail_default" style=3D"font-family:verd=
ana,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-family=
:verdana,sans-serif">I want to add some I2C based temperature sensors to th=
e -M Q35 machine. I want to update the ACPI tables to add this device infor=
mation. How can I go about=C2=A0 doing this?</div><div class=3D"gmail_defau=
lt" style=3D"font-family:verdana,sans-serif"><br></div><div class=3D"gmail_=
default" style=3D"font-family:verdana,sans-serif">Thanks,</div><div class=
=3D"gmail_default" style=3D"font-family:verdana,sans-serif">Gautam.<br></di=
v></div>

--000000000000c245850594a6f2a2--

