Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51691C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B7CE206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 18:57:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="bFHur7bK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B7CE206C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyKwN-0002dL-17
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 14:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40018)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoG-0004BE-Rv
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hyKoE-0006pH-Gp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:16 -0400
Received: from mout.web.de ([212.227.17.12]:34461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hyKoE-0006nb-5L
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 14:49:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565894932;
 bh=sjqB++GCWNjjWXcs6v9hboDynw6QHR2DxdUD6di7Nt8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=bFHur7bKeEQ44g9vY4+bxnt+OxBcXIC1wGJYimfwZqPI8RN+6FghHQ9RWUkk7+uB+
 OBGohxOvTXcN4+8x/DZpK7AOo1ycX4tMyRVm8p91TKtWsAMBthAm3KwFc9SX+i2pve
 VnKIvRe/e5Fon9qungSKpBWYUhp0x0NKw3cdFkdk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.245]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MPHC8-1htx5A2T6u-004WmS; Thu, 15
 Aug 2019 20:48:52 +0200
Date: Thu, 15 Aug 2019 20:48:49 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Message-ID: <cover.1565894837.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:P41KZVetPFojcP3Qw6ng8leUH4MFEmaF240tx4au0Fw9QhXPatP
 hIt400M7R3vFejueyYNVOS89L2SZLZ+G+1gbTP2z/O80O0EQsOdYDDU9T5rdc0qhD++TPEr
 zC/dceQiTAl4/Y5Dy/8Ff1/jjpZV2b37iH9kkBgds6icGcKZcBlicnDuIBbHb29NtJuMJjA
 ubSNdkfvewYObfMk7Bang==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5VqTsvOyTp4=:TBn6Wb4aWqqOxdIKEss82m
 6s7uehnZulPW2RtcFDZIlYihk7yuHYW0vTJLB1IDoY+jBZmI5folVT2HQnyWVhwSuf+cqgXz/
 KoE7iV6AzY0EsYoo6Go8kOeI4mURd/aNT48mbytZEpqhCe+TQfE1HhIVZxdOySvhPlngw5H96
 AMDLajgyEWirc+SsCxvP+hWbQMYjxEiJSwEwChnf/aP3hLwuf3CThCVLsHNPPwpR39SE8RU+l
 srm+qw0ijYx2LkXYqsRSue+XrjL61cEqzl87Gb7THTXRRusOvTEPvVu6qowPSFJMXDmXdijUN
 ZIxPipB69SsFK48NKr4JVySoI9aPLhoiRV3atu2tLN8h/BoLotkspdE7pcVz6e2ZlAWScIP2S
 pRpkpa/+9+fSizLGVclQQMyKsl6VT3z4z1iYPZAmqsXwDUd5LXg2CKFsyltIUKuopzH9mNaIP
 1821FRELWU1T1mzblIUDO/Ouk5vsHUftqvmb4WZrqS8qhdx6z5wQZjVTXC9gsQuAa9tBGRmGu
 x0f6aB+M+w4k/4Os19m35SjDMtACFQLaQajkpMd2gYd30SCdXtoHV7pppfgC9PcsAfT1MHI41
 FNEuZxRl3JaCHLslb2qkGkTPxUVDOcfW1LHeLf/GIhqMunJkyv29f8A2clH7V0QPenT8Dzvws
 OdYizA43JRGGtxk3AInHeY74KFbstuORHFO985LlchXoi7GeXNo+6EJqCTeoHGUuueeuminfj
 t4ZCHuhypgLSwi09rogN0gA5XdmBnGUauFZy09SjzJZc1BMfkJjVOx/03zRnGKj76DEvkjoK4
 fG+AzMpkmFeiUDf5jE53AWgD44Jq8GAddd/X03gJB7XdZ5RoMQsrzujRuvZp0VAiKYYnWb5fn
 h33+yw1mYTb9+qC73jGPV7umNXHQ4xhahDgeUSWI9KNgZ6YgIReuVdyV/ePYhswskqkbpO0p2
 7qH8eM7KHTnbrTGJbxVZMpLhPwShwv7dvgiMHGENCu2BhSDw9wrR0vOUVpJKwU+EE4qUdxHa/
 A4X81TUCsCdRIq5pIUXOiEnf3sZuGOyOBQCP2WNJlhZwUTtKZnhuw9E/i1oLztSX21W43s+4+
 NbWcXCtFgmG+CdgK0ojN5PtUplyTN2bZJNe3YJ1yL3JgiguAlMHpYxPD9C5gaDxcUYXezut5v
 1TfZU=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.12
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

