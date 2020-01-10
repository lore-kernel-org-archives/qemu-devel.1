Return-Path: <SRS0=GavZ=27=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DA33C33C99
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 06:01:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 152072077B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2020 06:01:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WM8l3Ykw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 152072077B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipnMY-0005t6-3h
	for qemu-devel@archiver.kernel.org; Fri, 10 Jan 2020 01:01:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32918)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <padmashree9107@gmail.com>) id 1ipnLa-0005PV-AV
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:00:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <padmashree9107@gmail.com>) id 1ipnLZ-0001qx-9M
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:00:38 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629]:39644)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <padmashree9107@gmail.com>)
 id 1ipnLY-0001jH-UM
 for qemu-devel@nongnu.org; Fri, 10 Jan 2020 01:00:37 -0500
Received: by mail-pl1-x629.google.com with SMTP id g6so428352plp.6
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2020 22:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=XXqSqeIex064+UKl9d8O1DU9BPNLXORpo/xXjCyUgpk=;
 b=WM8l3YkwouVwwox80KKlN8jr/oT1/hdi6u1BJqp3Rve3/cHtEf6QzpbdtIU5zz3KXP
 zwWWi1KBcSXouOH6D3e9xcVMj0JhBah8TtIzScCy+yP/ezcMzHam60JLqOA/dSkrY0GG
 3A+NyB0xUVXjOD7s1gmG/o480ZyNyQlTxJYA4Y9IzwLOcEC2qp0rysJ7BYy0VY7jIvOu
 wUXQZQF4OGva9Qa8bKr0ZDXKmzAXIiUbx8DNBjvAgKrR9S1/ygVHe/oADxsIAkaDdUQM
 0/TQiwBLWFEEqhYFmA50Sgh6xwhm2aUtvOe+vP2vgxW/XPaDZi9orZTFqhnvjx/37pX0
 6C5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=XXqSqeIex064+UKl9d8O1DU9BPNLXORpo/xXjCyUgpk=;
 b=oUmNcrbT4UmKAI1VXRqQz80yY8xQXI2am+OwYvOYwyKbm0CPM0KnrYv6qkqoeZyXZC
 1i4I0tb1k0XtCOsylyLagQFDEAMIJXU7hDheupO126vPS3A449BThJ1dCNiYVmcDvPsO
 P+1JUAciB01r1IKNLVdCyUv6pMzjk6PVaVoiliLpSO2hpn+PyetuxwVDd07tzTmPi4fT
 pP78qjPheMvDUPhX4NU9+qjFNy5E5px3TlJjTVSss4oy6tBA9xFCBB6bV/NkDgWQigIQ
 HE4tILPZD8K2yvua/3tXNpvVh+BMDVZh2AKf1m5ByzDcGWCfxHitgeCuBVrMfVx8y4GT
 ZcrQ==
X-Gm-Message-State: APjAAAX5phDkSfd9UPl3x5vovm7PjhyluyAIHCs9a/BYeKbdWQpnAyce
 652gpmyFJJXe+3itecWTYItgAoMfmMQNHvRSGlTbFHVN
X-Google-Smtp-Source: APXvYqz/kjIWxmpXooE6yyZ4LD/kXzxVFqNkRMz+rCuZbdnxSeBpYnicxx2kiU2PLTYrx7XB/ctse7PaXsLQf1UKTSM=
X-Received: by 2002:a17:90a:d156:: with SMTP id
 t22mr2483732pjw.108.1578636035269; 
 Thu, 09 Jan 2020 22:00:35 -0800 (PST)
MIME-Version: 1.0
From: padmashree mandri <padmashree9107@gmail.com>
Date: Fri, 10 Jan 2020 11:30:24 +0530
Message-ID: <CANT-jrJ=oiO23sB9fL86Kowt0rBWijvGBars1euVJQRqJ+72iA@mail.gmail.com>
Subject: Audio pace issue with qemu4.2
To: qemu-devel@nongnu.org
Content-Type: multipart/alternative; boundary="0000000000001ca82a059bc2d8a0"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::629
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

--0000000000001ca82a059bc2d8a0
Content-Type: text/plain; charset="UTF-8"

Hi all,

    I am trying to run qemu4.2 with ALSA. Playback pace is fast. Where can
i set sampling rate and all parameters related to audio in qemu?

Thanks
padma

--0000000000001ca82a059bc2d8a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<div><br><div>=C2=A0 =C2=A0 I am trying to run qemu=
4.2 with ALSA. Playback pace is fast. Where can i set sampling rate and all=
 parameters related to audio in qemu?</div><div><br></div><div>Thanks</div>=
<div>padma</div><div><br></div></div></div>

--0000000000001ca82a059bc2d8a0--

