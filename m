Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B097C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:09:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 673DF207C3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 19:09:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KieXY1bQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 673DF207C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX7rj-00039b-EB
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 15:09:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7qB-00023L-Hr
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43822)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX7q9-0006pB-Ub
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 15:07:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603739253;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=YUPimfd1+Il1ZXihEUp45s96llasmd5rajL//TC8sE0=;
 b=KieXY1bQdglpqh9AGTafVU99yacSESWmqoNHDEcT+4DdF0j3z7jebk1eJ88qZqQZOsWfmJ
 UXxNLffCUPsQDfevSbqCvtGYLSdmA3DeJ3Tm472j5v1dpzz64mXlS/BBdp7iPahYYU+A6C
 V3oqZRqK34FTGfOdG151rfvWRPHSGiY=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-1r5HgBFOPXm3UMuKkJfHTA-1; Mon, 26 Oct 2020 15:07:30 -0400
X-MC-Unique: 1r5HgBFOPXm3UMuKkJfHTA-1
Received: by mail-ej1-f69.google.com with SMTP id lf18so5863144ejb.13
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 12:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=YUPimfd1+Il1ZXihEUp45s96llasmd5rajL//TC8sE0=;
 b=f8AMTgOgbdLuKM6L6rl0u3a99DzjHa5+pS826XIKCTc7hoObdwfueuSWShDRxhJeHy
 E9H1W++tcsgb3YnH50dav/oEZ8L0ZDyzO6/X22AxD5ARH6WqJYQCHZHOVwpRQvKcBVge
 XTUGMQFZuC5NXomTwMhj6CLSJQ44SuttkCVzXBcdboEsxYz43zaau2WeHXbqIiIftUWE
 i0gbclgVqn0zZ3reRS/FlxwYxMMVDprziabDmhLWxAHTGvKvSAhL3flE/TEZBNlBoeor
 IpqWWqTvcQh6wE+efyhaWlF5Nfa5BVop3VV4tVhokkLRJLZ+oVfhiVOcv2tGL8qm4bVS
 1t0Q==
X-Gm-Message-State: AOAM5302kHloRe+MOJRUuiO8stCnIuiXLwBJYXDPYaQLhqlOeXt0fkzO
 +AJ7UAQ4Z9d1vlqqdtz+wPChTaaHep7DvxBNOtfwDNlTbcMWlAfwV6MFiH8eC2YgQv96MuvARdo
 tASz1xiw4MX2mG+Q=
X-Received: by 2002:a17:906:e10e:: with SMTP id
 gj14mr17967982ejb.134.1603739248917; 
 Mon, 26 Oct 2020 12:07:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxDB37LVSz3/BR2eMqOVm1PXW3y3HNZxNRGAxDhHliJNln+SGNv8M93TQ6Dp8NgJGwpAY1dzA==
X-Received: by 2002:a17:906:e10e:: with SMTP id
 gj14mr17967946ejb.134.1603739248561; 
 Mon, 26 Oct 2020 12:07:28 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id bt16sm6377792ejb.89.2020.10.26.12.07.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 12:07:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Acceptance testing patches for 2020-10-26
Date: Mon, 26 Oct 2020 20:07:22 +0100
Message-Id: <20201026190726.19515-1-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit a46e72710566eea0f90f9c673a0f02da0064acce=
:=0D
=0D
  Merge remote-tracking branch 'remotes/cohuck/tags/s390x-20201026' into st=
ag=3D=0D
ing (2020-10-26 14:50:03 +0000)=0D
=0D
are available in the Git repository at:=0D
=0D
  https://gitlab.com/philmd/qemu.git tags/acceptance-testing-20201026=0D
=0D
for you to fetch changes up to 4c9ac67230d2d8c12bfc0f3447ae353e67b43f7f:=0D
=0D
  docs/devel/testing.rst: Update outdated Avocado URLs (2020-10-26 18:20:51=
 +=3D=0D
0100)=0D
=0D
----------------------------------------------------------------=0D
Acceptance testing patches=0D
=0D
- More ARM tests=0D
- Documentation update=0D
=0D
CI jobs results:=0D
. https://cirrus-ci.com/build/5754555684093952=0D
. https://gitlab.com/philmd/qemu/-/pipelines/207807648=0D
----------------------------------------------------------------=0D
=0D
Philippe Mathieu-Daud=3DC3=3DA9 (4):=0D
  tests/boot_linux_console: Boot Trusted Firmware-A on the Raspberry Pi=0D
    3=0D
  tests/acceptance: Add a 'virt_kvm' test using the GICv3=0D
  tests/acceptance: Allow running Orange Pi test using cached artifacts=0D
  docs/devel/testing.rst: Update outdated Avocado URLs=0D
=0D
 docs/devel/testing.rst                 |  4 ++--=0D
 tests/acceptance/boot_linux.py         | 17 ++++++++++++++++-=0D
 tests/acceptance/boot_linux_console.py | 24 ++++++++++++++++++++++++=0D
 3 files changed, 42 insertions(+), 3 deletions(-)=0D
=0D
--=3D20=0D
2.26.2=0D
=0D


