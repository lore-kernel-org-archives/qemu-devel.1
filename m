Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9577DC28CC5
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:45:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E8E920693
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 14:45:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NpL7Vgjc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E8E920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYXAf-0006sH-IX
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 10:45:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hYX5Y-0002PH-Qc
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1hYX5X-0004Il-3c
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:28 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:44572)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1hYX5W-0004DJ-T1
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 10:40:27 -0400
Received: by mail-wr1-x436.google.com with SMTP id w13so19699677wru.11
	for <qemu-devel@nongnu.org>; Wed, 05 Jun 2019 07:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=sender:from:to:subject:date:message-id;
	bh=YwwS/Fhfq8EuqX9k717eLOkoypze8UvhPqnn1LmdKs4=;
	b=NpL7VgjcVM93Z/3fSlH/r3/VvU3ILRJbgFW7ZpxMnlQXSD3zFpSUwRlToZP0g+/RLE
	M3eOtGJVpkRefqhH9F3XJK590y3ZB79w3HZpz/1KhVjA1202J/kAvOvQvYjl6VSIKrcN
	ypvOAB6QglrstUln+KVu7KZejqMW8Tctae64uVhn2/cpJRpOc+ThOs6haPjA92Kj0Ms7
	BFyzzCFKRovyOoXkBWLj+fdYZqOdPuC9eOGUoBq0/VTeEgSCDiTezNvqzW14txlyPGhJ
	PKUhyGv8UQz1xgy2tloCna58zFK1dHjn47Mapx6LqTM5qyE6Y/sZ1GFNmiC80frPCXNU
	dAJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:sender:from:to:subject:date:message-id;
	bh=YwwS/Fhfq8EuqX9k717eLOkoypze8UvhPqnn1LmdKs4=;
	b=ZYrKbk2VD5n7yLtuflsxvk+6Lj7fjSnUah9tEr58njE4jJp4I124OyAmV0CvvaBT25
	1fuTqdpGtBGkC41YP7P1fTTHrP+ufbTU6Of4uEt7sXVR0weT/DcNEbxOOlOe/H2iMM+q
	ONv+myhdqh94YnZuCdcAtO093uSnIZyVpB151cqvbaHC8mTI80FwLLfOg2d86akHlIBN
	GHatSI76Zsux2cH29ni7n/gOqwvEolzpArNRfFfMkW99X6LL4yioF8kYlyVPK9Nl8Nc6
	L8mCmigqbLB+06aREdtDi+k+rDHMarX8Llf77ly7s7wx1eFI4pwNc39lp0sfH2nEFobP
	YGAA==
X-Gm-Message-State: APjAAAWy3Go55lnuwPT7b1/t52eIfRcFVH6Ck/9JVKGHrXsRYE7S4UIH
	QxB7J0PJQs69FdCiyaeN7YN01yie
X-Google-Smtp-Source: APXvYqxr0nIRJ7ryQRwTxJfvkU0QZMcJOPCj37Y5W8rb+DobfBGuikhFZRuIp7BtY26U0HEtCosiVQ==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr14081340wro.311.1559745622032;
	Wed, 05 Jun 2019 07:40:22 -0700 (PDT)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	t14sm22123117wrr.33.2019.06.05.07.40.21 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 05 Jun 2019 07:40:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 16:40:18 +0200
Message-Id: <1559745620-18828-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: [Qemu-devel] [PULL 0/2] SCSI/vl.c patches for 2019-06-05
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The following changes since commit c87759ce876a7a0b17c2bf4f0b964bd51f0ee871:

  q35: Revert to kernel irqchip (2019-06-03 14:03:03 +0200)

are available in the git repository at:

  git://github.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to edfb4389c26cbfd873707306024130bda6049780:

  vl: Document why objects are delayed (2019-06-05 16:15:32 +0200)

----------------------------------------------------------------
* Fix pr-manager-helper (Markus)

----------------------------------------------------------------
Markus Armbruster (2):
      vl: Fix -drive / -blockdev persistent reservation management
      vl: Document why objects are delayed

 vl.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)
-- 
1.8.3.1


