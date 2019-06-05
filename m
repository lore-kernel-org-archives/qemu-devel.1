Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB05CC282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7F18206BA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 06:20:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7F18206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=efs-auto.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36175 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYPHg-0000LQ-VK
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 02:20:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPER-0006zX-LJ
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david.brenken@efs-auto.org>) id 1hYPEQ-0006hn-7X
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:07 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:49555)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <david.brenken@efs-auto.org>)
	id 1hYPEK-0006EN-31
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 02:17:01 -0400
Received: from localhost.localdomain ([178.239.76.114]) by
	mrelayeu.kundenserver.de (mreue109 [212.227.15.183]) with ESMTPSA
	(Nemesis)
	id 1MxUfn-1gfAxT2l0j-00xoDU; Wed, 05 Jun 2019 08:11:42 +0200
From: David Brenken <david.brenken@efs-auto.org>
To: qemu-devel@nongnu.org
Date: Wed,  5 Jun 2019 08:11:21 +0200
Message-Id: <20190605061126.10244-1-david.brenken@efs-auto.org>
X-Mailer: git-send-email 2.16.1.windows.4
X-Provags-ID: V03:K1:9Ks7sV9w2FdhZWKzXLv1dY0hTZPLEI2Hcqgs0PvfPD5jxf4XoBZ
	o6/+CAyHCR7X/JRuxe+dDg1Sew2CdRFlK+9OR5hcFCmhO9R47k7xfcXuJIa3SD0rPXJ78Nx
	RTbN4HSRq/iKArhv66805P7BgUtONBQZ0LWAGUV1JdV39hwb0YtvlAKalqcHLaNDZS7LheY
	uaPuWxTxfu38Uls1Jg3kQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gm2VGpCZpfY=:09PRqCcEIC2IWPQdNPld06
	7ItwgUrPLOWtSP0mB2DIFH9deysLcelgHimevCBS5ZAb27JmK6iaREfTpkuhYx9WL7qq5nNc6
	jWxVDTK6YRhIIigBRt8n8k4J5iIyWvwNf5OwVrSJVfuq2Vjusmi2MWj9hh/ejfp6x9Nz70cd8
	EWeRHudnsTrggPPQNQqX+wKzxgoi8l7fZJI+8KbvGRwenKBjmwEDJIfN58JSGrZ2q862sX6a5
	y5XECKFKInAPtXoKEmrvLxKyrkz1/3qZqRs7cMoD0tVbuAhCqaoa3N5yFN582pTSq3akw5ZPG
	lCzQfipKqvb6CYkgFamqIh0NZxmkMsYy0a1Cn7Pby6LiOhBTEc21lxrx6iDpeiZOqMHzLv466
	GKdJoNFLBkQRI9wcAIv83xLSOafooZMzaaMc4Lgf3zl5AVY4mmesj7XFeLn6GFPx/Gdl4qFqf
	rptO266LdcKYrbp5Q6VbdNzJ0KZLhnsughXl3UooB/qvMYXfsfOLgUXCmsUvIZvm7PvjDxvdL
	GGRGnnVor0cN+A9o1AWwFvA8rJd1HZpGULO68SnXMNpNh+ORQFu+Qg2IhQe/yNnQ637WesM5E
	uErvvrZa3KUhDY1vbYdZKEBFiuxC8Wis+DzmiZ3roU/szqrD3gU58ZubhssPPX+keFztv7ES9
	dxfXvCZmg3frSqtF9EUB/HJrHOY93QZkyQ/pAqplE72upDYnm0KolqKquiM8mp1yNx7u6tEMF
	tkoggudOF3l1e6UzM6SNiaOfEP+xx5ck6lBKXxo5HKQAJI/pRU3szWULMvQ=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.24
Subject: [Qemu-devel] [PATCH 0/5] tricore: adding new instructions and
 fixing issues
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
Cc: kbastian@mail.uni-paderborn.de, David Brenken <david.brenken@efs-auto.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: David Brenken <david.brenken@efs-auto.de>

Hello everyone,

in the scope of this patchset we added implementations for the following 
instructions for the target TriCore:

QSEED, FTOIZ, UTOF

For the implementation of the QSEED instruction we wrote a test application to 
record the QSEED results on the actual target. We recognized that the results
of the instruction can be clustered in blocks and do not use all available mantissa bits.
After investigating on how to calculate the square root on floats, which can easily
be done using shift and add, we implemented it using a 128 entry LUT and finetuned
the values to exactly match the hardware results.

Furthermore we added a fix for the RRPW_INSERT instruction.

Internally we are now using QEMU head and encountered strange issues during 
execution. Sometimes the PC of the target was set to address 0x0 which was wrong 
behaviour. A detailed analysis (using valgrind and git bisect) resulted in the fix 
to reset the ctx variable before generating intermediate code.

Best regards

David Brenken


Andreas Konopik (1):
  tricore: add QSEED instruction

David Brenken (3):
  tricore: add FTOIZ instruction
  tricore: add UTOF instruction
  tricore: fix RRPW_INSERT instruction

Georg Hofstetter (1):
  tricore: reset DisasContext before generating code

 target/tricore/fpu_helper.c | 129 ++++++++++++++++++++++++++++++++++++
 target/tricore/helper.h     |   3 +
 target/tricore/translate.c  |  21 +++++-
 3 files changed, 150 insertions(+), 3 deletions(-)

-- 
2.17.1


