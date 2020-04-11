Return-Path: <SRS0=9/5m=53=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A89DC2BA2B
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:16:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4EE520857
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2020 09:16:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZahZDuaC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4EE520857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50106 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jNCFE-0006al-Vm
	for qemu-devel@archiver.kernel.org; Sat, 11 Apr 2020 05:16:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCEA-0005VB-DW
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCE8-0005Zr-GI
 for qemu-devel@nongnu.org; Sat, 11 Apr 2020 05:15:02 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:33052)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jNCE8-0005ZM-As; Sat, 11 Apr 2020 05:15:00 -0400
Received: by mail-wr1-x430.google.com with SMTP id a25so4767602wrd.0;
 Sat, 11 Apr 2020 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=7cZgEqjBAQ4pYWzWIE6aM+/CIA+MPhalgtvv3VeWBmo=;
 b=ZahZDuaCSjxzhKxb9Lvk1mjUP6ISS8zdGZ21b/eCPI8TlAdI9iQP0LNNlvnnBA79b5
 LI4q+4ORndswqdQ9sVeGsNBcr7LmysZ13V/yhc7n4UcoQaDuilyjh7eqitVeMnFPym9r
 xDPzHUDfi5o8R1psdRQG4iS66iEEBmcGljwPD7f9agYMKcqV5gh2theIFHsPKJ5O82vi
 2BSJ4JF1C/peKnEsrfLmPzcSuOXiGgy9Nk9HpV6o+31WFgJGgjM/Fesb2Blsk2Ssnxsm
 ZvjQ4uyQy89dbb8ajmq9WMBERIKQNcGTZoMPSpvEIAV+QQg7tGXR3+4cQwo5hF5FI58a
 CbbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :mime-version:content-transfer-encoding;
 bh=7cZgEqjBAQ4pYWzWIE6aM+/CIA+MPhalgtvv3VeWBmo=;
 b=Pg/OuAfKCQnZISo7YfGb09AegWaDBNDDiOhP62Y82ntd5f4y7cX7T0JlxjoLZkd8rS
 XeZXWQaHdUPNcw1SEiD0yL8i7k0QiDWf1k7PzQlnswJzKR4mj9dtuB+ulFiWxc7nNvgK
 6qhgksdZU1uT7nYl2N6WcTY8MN4L0KOKZPdC6djQ4JKZNCYXxWDOKI7PF29kr9XhoZqg
 m/YZ2wu4rf/43L6pG3lBX9ZdaECJRAdU8+Ou/bs1hCPqR38VGTUM0/Qkczpf5D3VldhY
 WG4CZd/lIjTKx0HGq3XsEaAFNa05VzDaMoPXrXkrHsneBQRS+HwibkZCMgfNU723O+nq
 jEkA==
X-Gm-Message-State: AGi0PubgBBC1qqhjclqPucONO4QqqxryP2978JaPWdsCtj/1r0lnPOe0
 c+dUcO3jgDiYsAIMN+9u82Tth2jcFxw=
X-Google-Smtp-Source: APiQypIA2LrcheBEk0n4mLeZlLm4bTgp7jCkkwzroPJImXe2d4F0cLHBDAPBNzcEdp8EiPsoE1Scog==
X-Received: by 2002:adf:e48c:: with SMTP id i12mr8701511wrm.173.1586596498187; 
 Sat, 11 Apr 2020 02:14:58 -0700 (PDT)
Received: from localhost.localdomain (116.red-83-42-57.dynamicip.rima-tde.net.
 [83.42.57.116])
 by smtp.gmail.com with ESMTPSA id f83sm6073301wmf.42.2020.04.11.02.14.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 11 Apr 2020 02:14:57 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH-for-5.0 0/2] hw/display/sm501: Avoid heap overflow in
 sm501_2d_operation()
Date: Sat, 11 Apr 2020 11:14:51 +0200
Message-Id: <20200411091453.30371-1-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Magnus Damm <magnus.damm@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Zhang Zi Ming <1015138407@qq.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

I once setup a Bugzilla 'Component Watching' rule on 'QEMU + CVE',
and recently found a notification for BZ#1786026 about a heap
overflow in sm501_2d_operation():
https://bugzilla.redhat.com/show_bug.cgi?id=1786026
As this is from december I suppose there was some embargo that
recently expired. Apparently there is a CVE assigned but the
information about it is private.
I'm not sure the upstream community is already aware of this
problem, but since we are in hard freeze and the bug can easily
be avoided, I believe a 3-lines patch is appropriate.

Philippe Mathieu-Daudé (2):
  hw/display/sm501: Avoid heap overflow in sm501_2d_operation()
  qtest: Test the Drawing Engine of the SM501 companion

 hw/display/sm501.c           |   6 ++
 tests/qtest/sm501-test.c     | 106 +++++++++++++++++++++++++++++++++++
 tests/qtest/Makefile.include |   2 +
 3 files changed, 114 insertions(+)
 create mode 100644 tests/qtest/sm501-test.c

-- 
2.21.1


