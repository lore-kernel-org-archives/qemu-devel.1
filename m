Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAD4C352A2
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4927920720
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 11:41:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WoFpzwVH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4927920720
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j020W-0004BW-DK
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 06:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36088)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z5-0002q9-Rf
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j01z4-0005cr-IW
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:43 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39542)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j01z4-0005ay-B9
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 06:39:42 -0500
Received: by mail-wr1-x444.google.com with SMTP id y11so2286540wrt.6
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 03:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jyG9KD8JNUOpj/k4ZmkY8ByVZXkTc/qLI0RZdDbWsBY=;
 b=WoFpzwVH+gAAWElYog37Bo5Q23Q6rTfjzZuOrIpLpqW9WP1WodR0mn8Qwh47Aucube
 uH+TMXsZffr3MgNQs8Xa/9/SUbw0I3axKVqNsYb1VyOJO5XnmLJFEZ3nrQB36pIQfMGr
 zmqqQH3VIkw+PV+3SwPAYy8+6zCq1eqDoJq/+qFwArHXc41HeuZp+zAnuP+N3LVQxUj6
 hrYYwpotk2iNyPY+kPuqdnMnmEkfTDwyLA6alYCskHkyGo4rbDmEC7BKCgAPxTqLzWwo
 moZgxKeBcEyjeYxwkT0EtzQaaxGnYD4D6n8irNMJgH4lJpmotmRWx38ouXcwEhXq8QxR
 ZDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=jyG9KD8JNUOpj/k4ZmkY8ByVZXkTc/qLI0RZdDbWsBY=;
 b=Wulw0uBsDliDI7QSm3+nvLt8M666/dUQYYp+GUJLuan8rcvMqvvEbbaSARrsk2IT8c
 8q+GecJENYtq1RhoLPSF0luKAM5PhU5cnk18/eK0SbyvpUS3aXFrSR2mLw+lu0SpqZ6x
 S5TAS43Ezfmb/cLyb/MD7XjosWuIiWwmeBrivUN79Vq7hQ3+1tfs9k2iMWR+iV1FtOUj
 fMUuJFlwlJU2LSBTsU0e3tG43rxlYk2hga7Z9Lirth0Q996/NYaMFAdedEzX0QxO3hRy
 Axtd9LPgsbaS2gMhTJEHQJxdTYNF5KKGS1L6C8fnx4ueZx/pTmgN3lOgQ6A7QBUDgFjY
 zePg==
X-Gm-Message-State: APjAAAV1RDAETJU0aVBfneP/XfBsK1VdnOzw23z3nc9F8V0ZPBeXUAwL
 hGSzZilbG+DTl6HF5B5MVZrOjQ==
X-Google-Smtp-Source: APXvYqyRtR/lg5DrMOcnPHycRXJ+qGrxfMS8usMunzx5so6M8lUrXbJvNPbfpnBQpYne5Hu78rx/WA==
X-Received: by 2002:a5d:6987:: with SMTP id g7mr4148216wru.422.1581075581220; 
 Fri, 07 Feb 2020 03:39:41 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id z11sm2971617wrv.96.2020.02.07.03.39.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 03:39:40 -0800 (PST)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6B5141FF87;
 Fri,  7 Feb 2020 11:39:39 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH  v1 0/5] testing/next (rcutorture and misc tweaks)
Date: Fri,  7 Feb 2020 11:39:34 +0000
Message-Id: <20200207113939.9247-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: fam@euphon.net, berrange@redhat.com, stefanb@linux.vnet.ibm.com,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 richard.henderson@linaro.org, f4bug@amsat.org, cota@braap.org,
 stefanha@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com,
 aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

The current state of testing/next is mostly a rubber duck exercise as
I tried to figure out what might cause the rcutorture test to fail.
The only real practical change is asserting we are never about to
reset and existing active RCU structure. So far I haven't seen the
rcutorture crash occur since (although git stability seems to be a
current problem for Travis).

Alex Bennée (4):
  tests/tcg: include a skip runner for pauth3 with plugins
  tests/rcutorture: update usage hint
  tests/rcutorture: better document locking of stats
  tests/rcutorture: mild documenting refactor of update thread

Thomas Huth (1):
  travis.yml: Test the s390-ccw build, too

 tests/rcutorture.c                        | 55 +++++++++++++++++------
 .travis.yml                               | 10 +++++
 tests/tcg/aarch64/Makefile.softmmu-target |  2 +
 3 files changed, 53 insertions(+), 14 deletions(-)

-- 
2.20.1


