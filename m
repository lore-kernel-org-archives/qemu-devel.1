Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D550AC18E5A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:42:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4F6F20828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 12:42:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RE14e3Uc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4F6F20828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBHk2-0006l3-Nw
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 08:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58278)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1jBHSz-0000Ta-Bd
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1jBHSx-0004ym-7G
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:46860
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1jBHSx-0004yC-2a
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 08:25:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583756702;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=CEjE0J0smmyHnkbIXi2ezolKkLUeP/nKpHJ2jsqJL+s=;
 b=RE14e3UcCwNDqGbFmw/0juNGYZ4szwUjJdRlPMRyZmwJh39bdPJ6KP2U3NlRr6p+9/gX6R
 g6CZirW6P42emKGC9+czflJW2w2mh02Odgz+gK2EvwZybp7Vrb9uVekL5GpMKpfRWDht6x
 7iaU1N9ZN5aJ1RpYy+dVF45MFkeY+ys=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-jsKms0TuOBCbwQNAYzWDyg-1; Mon, 09 Mar 2020 08:24:59 -0400
X-MC-Unique: jsKms0TuOBCbwQNAYzWDyg-1
Received: by mail-wr1-f69.google.com with SMTP id t15so2283010wro.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 05:24:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JWZ4d7c5Ovr93t3BSApS4exfIDX4ayQtjp87yjJ4kdE=;
 b=tJHSsgfxEg05E8CmFiZoxCxq1HP6KYeiPglSZYvvk+Bzohns8sHrpDi+M7W1dqI1cO
 8Vpm6s+L1a+Mj0GRMyTzdrLwghROsIjFUiuEqeMkw7Fa70R7kODFIsEiY5/IlS4it987
 YTM7V+8+OX1gXyWxuox2tj+aqTpo5gf1Z+bsJduoAA9NIBcdl5jT1deB/yUKtq9rujFN
 uvbruGO/MC4YZIOc74BULhbDDuKf+5CXcuLSYES5k2Juj6Uulewp5Wsx5jVERMMTmOwl
 B6FpsgbORp3TmhdB4hnhuCGcqVzlS0xoO66gfiEZI3KZsTRiRRs8yHZ0zhyiaQCBoLhB
 94Xg==
X-Gm-Message-State: ANhLgQ02y4C9LUh0LUcgeEwYYxkeJ1PuJc/WZfKUNgXLunvOXquMexll
 LY1umbIGQjkqsYm9qP+S2O8ckollcl62DJnUsvD9LR5AlkCfBnnAjLGWMBSnVTCsZMPZlhslqAs
 utrnxkz3PlY+YG2Q=
X-Received: by 2002:adf:e506:: with SMTP id j6mr20546189wrm.309.1583756697740; 
 Mon, 09 Mar 2020 05:24:57 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtZpNjdmmaAQgPcOH9aQtZ8yyLu39hWeeqY+13UYs69aTw9788CAeGvdL9NCDzLb7/9hxFnsg==
X-Received: by 2002:adf:e506:: with SMTP id j6mr20546166wrm.309.1583756697505; 
 Mon, 09 Mar 2020 05:24:57 -0700 (PDT)
Received: from localhost.localdomain (47.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.47])
 by smtp.gmail.com with ESMTPSA id f4sm5194904wrt.24.2020.03.09.05.24.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2020 05:24:56 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/2] buildsys: Fix building with SASL on Windows
Date: Mon,  9 Mar 2020 13:24:52 +0100
Message-Id: <20200309122454.22551-1-philmd@redhat.com>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 =?UTF-8?q?=D0=90=D0=BB=D0=B5=D0=BA=D1=81=D0=B5=D0=B9=20=D0=9F=D0=B0=D0=B2=D0=BB=D0=BE=D0=B2?=
 <alexey.pawlow@gmail.com>,
 =?UTF-8?q?=D0=9C=D0=B5=D1=82=D0=BB=D0=B8=D1=86=D0=BA=D0=B8=D0=B9=20=D0=AE=D1=80=D0=B8=D0=B9=20=D0=92=D0=B8=D0=BA=D1=82=D0=BE=D1=80=D0=BE=D0=B2=D0=B8=D1=87?=
 <winaes@narod.ru>, Biswapriyo Nath <nathbappai@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix a bug reported by Youry few months ago:
https://www.mail-archive.com/qemu-devel@nongnu.org/msg625606.html

Since v1:
- addressed Daniel review (always define STRUCT_IOVEC_DEFINED)

The Fedora docker image already uses the libsasl since commit
8ea5962f286. Add the similar package to the Debian (host) image.

Philippe Mathieu-Daud=C3=A9 (2):
  configure: Fix building with SASL on Windows
  tests/docker: Install SASL library to extend code coverage on amd64

 configure                                    | 4 +++-
 tests/docker/dockerfiles/debian-amd64.docker | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

--=20
2.21.1


