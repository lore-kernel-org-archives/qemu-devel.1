Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E802C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 23:01:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47B8420656
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 23:01:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eGf+3vK7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47B8420656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvqPS-0007Vy-H8
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 19:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvqOp-00075j-Ow
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:01:15 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:43371)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flukshun@gmail.com>)
 id 1jvqOn-00086e-QC
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 19:01:15 -0400
Received: by mail-oi1-x22a.google.com with SMTP id x83so3557473oif.10
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 16:01:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:mime-version:content-transfer-encoding:from:cc:user-agent:to
 :message-id:subject:date;
 bh=MbfNRRwMNHKM8rcU1xAdGm9AYRBZChNq7cMZY2m2WpU=;
 b=eGf+3vK7qUdBj60zyr9nfE5kS9EhrbSZ8D5v/zH1+IdY6C0JXAtvg2bdzwNdvCTz1t
 RG+1mFKoSqOyFU6OeMrJ+kmCtfNm/aTjAc2L7yCTEe41Ng3mmpWfMS62ESqShwTY013B
 ljBdXK2HHA8ZJ0HACz6sVgsHEfBpjUaG6dBS5kM/vEAqayw++gMXxC0Fr8Olg7hsTRRr
 D2tfSnuOIIDaepUMf709aH0eMY7CpBaJ537e/Eo9cNt5KawHNyCnNlmwquwGLzc0pN7Z
 08IQhoaBvJ1ll4y5UiI/EnlGHPfd75ESd5C8ADeXLiNviOtZ+j1E8SfeIH5M2P4F0VBF
 nCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:mime-version:content-transfer-encoding
 :from:cc:user-agent:to:message-id:subject:date;
 bh=MbfNRRwMNHKM8rcU1xAdGm9AYRBZChNq7cMZY2m2WpU=;
 b=aLn3EWHS9Y4uM3gXQlAPIyAJKi+TEW4mclqdfvD+zCEeZceSwp8pVLpB6mZL6fxktH
 r+X1Wo8psN0r0QUxHhyXYnbEzIP/bGIg9iyBd2eRz3svXFGf9RIhgssSgAv6wz2E3k4b
 6Ejn6gku8rARAF8th4xsfWjPscSW2kcrFsQnJuslPZlq1/ye5jwU5HKskj4NZ0bR2Uex
 PKfgaUnZmzBI+gmw2w9cG0wajZlYgFQqhJCrie1PljPpy3AZoBBDmykY6LE814gKJ2Vh
 UlG5jBYoFYXkD5WCoVBH3+hdYe+HcdoKXqZcAGZ22wxsYpNrU7VOw/KW06VUt4F+sQLG
 4Ogw==
X-Gm-Message-State: AOAM533ZhKxGz+Y8U5CLV4PBZMrekPDQc+cjlHwv6HGCSl2OPmYEK544
 xs1Mv1T1TZl9QjKwTq9Yje0=
X-Google-Smtp-Source: ABdhPJzZFJhq/PwrexiIWwwK6tQfrDS5LXyhb/5T0GEoAWmgV8UDWKNn0KUcANtV4xNYDM9HOAN1tA==
X-Received: by 2002:aca:2807:: with SMTP id 7mr1731611oix.140.1594854072164;
 Wed, 15 Jul 2020 16:01:12 -0700 (PDT)
Received: from localhost (76-251-165-188.lightspeed.austtx.sbcglobal.net.
 [76.251.165.188])
 by smtp.gmail.com with ESMTPSA id 100sm719126otu.52.2020.07.15.16.01.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 15 Jul 2020 16:01:11 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
User-Agent: alot/0.7
To: qemu-devel@nongnu.org
Message-ID: <159485406181.29768.12896621627791602156@sif>
Subject: [ANNOUNCE] QEMU 5.1.0-rc0 is now available
Date: Wed, 15 Jul 2020 18:01:01 -0500
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=flukshun@gmail.com; helo=mail-oi1-x22a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello,

On behalf of the QEMU Team, I'd like to announce the availability of the
first release candidate for the QEMU 5.1 release.  This release is meant
for testing purposes and should not be used in a production environment.

  http://download.qemu-project.org/qemu-5.1.0-rc0.tar.xz
  http://download.qemu-project.org/qemu-5.1.0-rc0.tar.xz.sig

You can help improve the quality of the QEMU 5.1 release by testing this
release and reporting bugs on Launchpad:

  https://bugs.launchpad.net/qemu/

The release plan, as well a documented known issues for release
candidates, are available at:

  http://wiki.qemu.org/Planning/5.1

Please add entries to the ChangeLog for the 5.1 release below:

  http://wiki.qemu.org/ChangeLog/5.1

Thank you to everyone involved!


