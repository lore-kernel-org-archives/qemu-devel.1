Return-Path: <SRS0=rz2F=DU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ACCCC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:18:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 187EC20708
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Oct 2020 10:18:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YpBjM77a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 187EC20708
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSHNl-0002YL-2b
	for qemu-devel@archiver.kernel.org; Tue, 13 Oct 2020 06:18:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52460)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMe-0001oC-Fz
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:04 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:45599)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kSHMc-0001XN-UL
 for qemu-devel@nongnu.org; Tue, 13 Oct 2020 06:17:04 -0400
Received: by mail-wr1-x430.google.com with SMTP id e17so23287687wru.12
 for <qemu-devel@nongnu.org>; Tue, 13 Oct 2020 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=1t1Vhx6MiGT0IoPrCz5UXV88IBBa97BZhmTdP8SfZKk=;
 b=YpBjM77aJOq7hL9BcW1QwVBv6LfCxRvXORuIw9N2rusZuct+WBFA/lIi46rPkXN/m3
 8xY6/mH+DsHzfKTKn1rDJ3PoJhNYslYmyWUDZ8baaW31jUyzpiI5luThu+fUjf2qvX83
 l3BQtPCmS+0GCruICqBh+DN/ROQOwwTdhCZvPN+RZj4YIZ46A9JJb623PN7yawYjdOHH
 vsou5U8YeZAOAEZNWXoZqOx/koAs0bJHQUP4iwKvJCvXofJi4viENDe5h3TUU09CHgis
 oc7fBiL36UO+IY92nCMwwiqB4SefX2RJW9TLpA28IPXDJoUb27aVxIkM6ME7wb8LkEfU
 lecg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=1t1Vhx6MiGT0IoPrCz5UXV88IBBa97BZhmTdP8SfZKk=;
 b=K9ARKAFXDHPRw6nUme45MlkWg3yqvakutakTygjLRvHtrt7PRmdctr+b2bQNtUjsWw
 2bnjXpHX04AwH9zIgXE+i3+1nEH/bQXi6nS/WosLPsX9PenAosJ8z0iRpwQdgJdZ4BTq
 4lXrs1+z9WSMW1j6JqWC8viUZhwXaDVVdl6wmqQTIdOVfHcGZoGXEA3cRu1gwPs01nNi
 7YWjcuKSy1EXjZWXY4h1jNbBoY8FWY9pm6dfWsaLeDdvQPrbpIXXy+KYiPZlzGXo5oC6
 J2vud5BgHBKXLuy+XrbOZo3HkgzmugcTofZztYe3lO7wa9jt2IPtID6cbIlP4AzpSGyR
 al7g==
X-Gm-Message-State: AOAM5322nkUIdq0ufWd9WclrvIB5FBqqzN5oGyv/fWUq0kg8dX6AYle9
 kWFiAey13yeZ56Jx8jemt/9bFmSx7aw=
X-Google-Smtp-Source: ABdhPJwqcYz9HkdhqTCXkBJZ2lcX5HEf2qFtM3MXO7fOHcLTvd8hAB/edm/OuwB/Bi1HYm5wFZv4cA==
X-Received: by 2002:adf:f48c:: with SMTP id l12mr34762270wro.77.1602584221171; 
 Tue, 13 Oct 2020 03:17:01 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id z127sm26331406wmc.2.2020.10.13.03.16.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2020 03:17:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] MAINTAINERS: Update MIPS sections
Date: Tue, 13 Oct 2020 12:16:55 +0200
Message-Id: <20201013101659.3557154-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x430.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Chen Huacai <zltjiangshi@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Volunteer to maintain MIPS TCG.=0D
As discussed on list, Huacai will likely send a similar patch.=0D
=0D
Few more adjustments (in particular around Boston board).=0D
=0D
Based-on: <1602103041-32017-1-git-send-email-aleksandar.qemu.devel@gmail.co=
m>=0D
https://lists.gnu.org/archive/html/qemu-devel/2020-10/msg01974.html=0D
=0D
v2:=0D
- Squashed Paul email address change with Boston downgrade (Thomas)=0D
=0D
Philippe Mathieu-Daud=C3=A9 (4):=0D
  MAINTAINERS: Put myself forward for MIPS target=0D
  MAINTAINERS: Remove duplicated Malta test entries=0D
  MAINTAINERS: Downgrade MIPS Boston to 'Odd Fixes', fix Paul Burton=0D
    mail=0D
  MAINTAINERS: Move MIPS GIC timer files to Boston board section=0D
=0D
 MAINTAINERS | 16 ++++++++--------=0D
 1 file changed, 8 insertions(+), 8 deletions(-)=0D
=0D
-- =0D
2.26.2=0D
=0D

