Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA2BCC3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 87EEE2064A
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="haoPX8iP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 87EEE2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKFC-00025Y-JL
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:13:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34258)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyKB8-0007RW-CB
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyKB5-0006bt-VV
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:50 -0400
Received: from mout.web.de ([217.72.192.78]:58495)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyKB3-0006Vs-Nd
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:08:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565892500;
 bh=sjqB++GCWNjjWXcs6v9hboDynw6QHR2DxdUD6di7Nt8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=haoPX8iPsJIjbNP/fZskUnS7R3YT0j9IpRTOix/CfUYqXY7icIPK8uXbHV7oKh1yF
 wj6vNP8KhZqSpVWfFNZAvkWnoeRt6pqkJ4Nk5j9RnAe9PArI6ZF9OthtNBF4B16OvB
 Ct3RFGZt1GTSjHigyDTAaUyg+U+YSQKk/oZVCHN8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M9GJ0-1i8nEr4218-00CmXH; Thu, 15
 Aug 2019 20:08:20 +0200
Date: Thu, 15 Aug 2019 20:08:15 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <20190815200815.2cffc21b@luklap>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dkNv+800YlY1q/JDMvVRAUpZhOqZNvDLNulw/i93mLxjEg1QXgS
 7BHzEyo2DHM1cBR0CGoOvHsHmbhbEtLsH7O0KQyL5LXNue1jB9D7tlt2IrzCsflJbS0abO6
 2OZcd99DerkHuLbmaYF+MDPN672OzZ/Fx5lBWvy1LgW//Z+QLJVZJ46SKk5Pqyy/DHPDUDk
 jEVD7FfuHZl0nUWbn4qhQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FNYNLDAmYXw=:UvtFchXY4gCIKTKrgG7ZGE
 unWUJMQoOy7JEISvP7O+EMlPdUmGHdHWjpYqQNE58OfS/+AeWdJ5EmPpkQFeDD/Gaxi946pz7
 S7SXhwlU1l549yYu/QKyWOlmUo4J5T8LKvClkrL/dPmucnFhDujod8FZlE1oOeiPfAt1csuxH
 CeQQq5r1grWn+UOWtNTksxgHdyyxbKtRFU3/bge8HpNmkdk4jxxAEkh/siANKxjq/WCmn2pIr
 YlyHZ9aylGNDbge318xMBqgjucXY2RU3pNe34faAWZNvtAinmkEuA6eJxU7mDlHjSH0+50SGi
 GUK1FFbpCtWQgDwz3BviIRWoBfMd7B3giuXPJr/1yvL+gGqsQN6FSWlc6XtSukVEZxrpfUi1/
 0XdZXn3poCv88gDxsXTo+SYOU8wkESrNiRHOoy3xHsX2ac0looONGTgQMxDbhPcA9DuORftuD
 2GH/aqZOYA5/3DDBZSpmu8YFd69fPmw8g4nsPDkAn0oBf3921YtVI47oDFZMD1LMEJkt2AzGl
 wfCdL688Cc/fk6ZBuqADww5eYVu2zkwuIU5aMPQ1Pj8uBXg4u/5CzTGiMFdx8z3kN0+RemmNv
 /fxCsApg9Zw0YSQMnDQBNexYh9QgI9Gyhb/z00jXs3pUMljGPfxh8Eid42smN4xzYlufEXPul
 EYyDYJhydjFa7vyoyfvgLzzllnT1TPn6r0WgqiXWdmu5X/ppvEfBG4bI00K5CYdOH4ZeOBGrW
 1N3cEhgJ7woASRyVDYuQF1I2Jtd4acHs89gHYDYcy3zOv2Wn50IFRCG2ZlmHpxFmtwXBuSJ3k
 UplZ91lGloABlS/ImmPIHb0+RDqhrMIQnu7ZAMea8mEwjZVbZYdMNXBm5t9ZNdNG0l25akZVI
 Ot2+aUFrHPqQZOxEsKFohwUIhxeNINGQuJT5yrMy6uIgoCupSTU2x5RIi5lm8Q2QbgB5bp5Ls
 UNwim35iIKRDkiUm47Cved0DGMDnsRaSo+TCTacvtJb8/X6qoJcqJv/kRzz2Zyl7Y/XLgrXYP
 JpW8hixcROVfwDF6eGYz7984Tn4LnbqxE8DLRAYtKsfjYLgyeJoqxz9wK6nFdjZpAm/XG8SmW
 MawX4TUbU7s109AZsg6qn7I9im0P4RMQx3Po7iNHBErFABnZocX9PGvkPyPd5VVdtONXzGCo1
 waKWo=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.78
Subject: [Qemu-devel] [PATCH v2 0/3] colo: Add support for continious
 replication
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
Cc: Zhang Chen <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Xie Changlong <xiechanglong.d@gmail.com>,
 Wen Congyang <wencongyang2@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continious replication to colo.
Please review.

Regards,
Lukas Straub

v2:
 - fix email formating
 - fix checkpatch.pl warnings
 - fix patchew error
 - clearer commit messages

Lukas Straub (3):
  Replication: Ignore requests after failover
  net/filter.c: Add Options to insert filters anywhere in the filter
    list
  Update Documentation

 block/replication.c  |  38 ++++++++-
 docs/COLO-FT.txt     | 185 ++++++++++++++++++++++++++++++++-----------
 include/net/filter.h |   2 +
 net/filter.c         |  71 ++++++++++++++++-
 qemu-options.hx      |  10 +--
 5 files changed, 250 insertions(+), 56 deletions(-)

=2D-
2.20.1

