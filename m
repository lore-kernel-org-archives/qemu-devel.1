Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE04CC433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:02:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C36C20809
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 22:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ldu+Y7TH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C36C20809
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60426 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0BCY-0002bn-U3
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 18:02:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B96-0007mE-6S; Mon, 27 Jul 2020 17:58:56 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:35318)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nirsof@gmail.com>)
 id 1k0B94-0004Kd-EQ; Mon, 27 Jul 2020 17:58:55 -0400
Received: by mail-wm1-x32d.google.com with SMTP id 184so16199636wmb.0;
 Mon, 27 Jul 2020 14:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxylbAlLgBB5wX4M1QMLfOjOSXomHrrWCqL3sU/4jlA=;
 b=Ldu+Y7TH6uMCyQV9ws1Fsm1D5nlvM6k++Bp6e1LUoYjlz4yOUvRjeFdz6bfn5vsmRG
 coCqHRKLggm3HCAtvb/rkzoN6Iux4PiYUPDPPf/a/i0zkdj+D5UCTTLszZ4L350NKr3C
 Ul1VtgYksXrCWyWkW+NCLMXEzBzls96LJ8h96Zcm0bwtIX3905P4YrWgeAGrAUreTACD
 7NjekIE2YBuNZaABWiwopds7910KuF9yoinGdavPRzHq7KimmFsCKNEGiCKtEm7LB1kr
 G2eCrcgaWC0psBx43xRNVvendurN810XCUjfm2Vkjl9CZX+65JBqUgYyOeEIReUDgzXm
 csZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=oxylbAlLgBB5wX4M1QMLfOjOSXomHrrWCqL3sU/4jlA=;
 b=WBTrgFvG77q+5D15p2ECb98yse9nXXSvD6eM0yScwXLXAfYTbCTbaQl7Xtid6UDH3h
 4SWZr8FvjR60KPl4m49TW/obuUbRxBn58hPQZ04W+qyCPBriuxPMkSFfsnWd/WX999uY
 AH35go5bCvTDScnrHplKE51UNkkoq4E2UgygiDzrbdTwBfnZztFaiK75q+PSek0duYGR
 9Qq1YwC9mDZvXQ2eLuNK+KaFexUETanJ4Eda4qgmomU/SGRWDG6j5qbL9kNFxI05HH8T
 qmxBjnCIpJUG4JNun9WYvuz8AB8hyzZ5KQZDGT3ojB+TGJOxcA2XwSByBAIQos7EgphE
 sycA==
X-Gm-Message-State: AOAM530YifkB7EAOgngnCwlv2YxD4RqNyrPm8YuxIOmISct1VQKWh7l8
 3Mf6Zn0GeXFHESrG2O0Yd1E81J9uvcU=
X-Google-Smtp-Source: ABdhPJz7HcuWZR0s/RY5cHF36CsfZH5nPzh1tfze93Ec1Y/6c4YqkDUVsjmFW9pL0kwK60STTKIJMg==
X-Received: by 2002:a7b:c841:: with SMTP id c1mr1158170wml.25.1595887130507;
 Mon, 27 Jul 2020 14:58:50 -0700 (PDT)
Received: from localhost.localdomain (109-186-134-209.bb.netvision.net.il.
 [109.186.134.209])
 by smtp.gmail.com with ESMTPSA id p14sm14492940wrx.90.2020.07.27.14.58.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2020 14:58:49 -0700 (PDT)
From: Nir Soffer <nirsof@gmail.com>
X-Google-Original-From: Nir Soffer <nsoffer@redhat.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Subject: [PATCH v2 0/4] Fix convert to qcow2 compressed to NBD
Date: Tue, 28 Jul 2020 00:58:42 +0300
Message-Id: <20200727215846.395443-1-nsoffer@redhat.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=nirsof@gmail.com; helo=mail-wm1-x32d.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Nir Soffer <nsoffer@redhat.com>,
 vsementsov@virtuozzo.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Fix qemu-img convert -O qcow2 -c to NBD URL and add missing test for this=0D
usage.=0D
=0D
This already works now, but unfortunately qemu-img fails when trying to=0D
truncate the target image to the same size at the end of the operation.=0D
=0D
Changes since v1:=0D
- Include complete code for creating OVA file [Eric]=0D
- Use qcow2 for source file to avoid issues with random CI filesystem [Max]=
=0D
- Fix many typos [Eric, Max]=0D
- Make qemu_nbd_popen a context manager=0D
- Add more qemu_img_* helpers=0D
- Verify OVA file contents=0D
=0D
v1 was here:=0D
https://lists.nongnu.org/archive/html/qemu-block/2020-07/msg01543.html=0D
=0D
Nir Soffer (4):=0D
  block: nbd: Fix convert qcow2 compressed to nbd=0D
  iotests: Make qemu_nbd_popen() a contextmanager=0D
  iotests: Add more qemu_img helpers=0D
  iotests: Test convert to qcow2 compressed to NBD=0D
=0D
 block/nbd.c                   |  30 ++++++++=0D
 tests/qemu-iotests/264        |  76 ++++++++------------=0D
 tests/qemu-iotests/264.out    |   2 +=0D
 tests/qemu-iotests/302        | 127 ++++++++++++++++++++++++++++++++++=0D
 tests/qemu-iotests/302.out    |  31 +++++++++=0D
 tests/qemu-iotests/group      |   1 +=0D
 tests/qemu-iotests/iotests.py |  34 ++++++++-=0D
 7 files changed, 251 insertions(+), 50 deletions(-)=0D
 create mode 100755 tests/qemu-iotests/302=0D
 create mode 100644 tests/qemu-iotests/302.out=0D
=0D
-- =0D
2.25.4=0D
=0D

