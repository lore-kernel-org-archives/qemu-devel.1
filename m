Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F422C433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 02239216F4
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 20:52:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UrZRn356"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 02239216F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy0Fm-0002eV-1G
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 16:52:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37988)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CZ-00016Z-Gp
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1hy0CY-0001Ah-Hh
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:59 -0400
Received: from mout.web.de ([212.227.17.11]:37761)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1hy0CY-00017B-8m
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 16:48:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565815723;
 bh=9xveIuRCNmZdK+hyJGseF1OrstVLDlGQCr4J8tR3i34=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=UrZRn3567xcUrMPDaFv2r5Y713trI3mhPycMN5CdnEpjmkjLskHgQQ55gsBoOIIiV
 W2t5V0XDc1b5tq+d2FwFpygghHQ+3r4/vQnqJepDx7IUySUe4W1+mmXXLE4CQoA/OY
 2Epg4ccIoOfStT6qaVKS84eU/MaAXt0XEl7dFDY8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([87.123.206.175]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3SxQ-1iFfZb2ekC-00qye3; Wed, 14
 Aug 2019 22:48:43 +0200
Date: Wed, 14 Aug 2019 22:46:46 +0200
From: Lukas Straub <lukasstraub2@web.de>
To: "Zhang, Chen" <chen.zhang@intel.com>
Message-ID: <cover.1565814686.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fHWSlR6rei11ekx7c+y5RraGnxrqTRCOiOR+lky9tppQhzqNhXl
 b5ruEautD0MLTMypcJo00Mk9JQKtoGl5WkR1Vi8rAEJUGsI08kqaTkzr0ZFhitaB6Igah/q
 jvb01X5ngWmSn7xXWOoT60AIo8QDhWRMGA95f7A+TrjaRL/O4yUwErs42nIxHON5LoPP4lF
 8Wpow9nzzgKLFYv63KleQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZMUz44q0U6o=:sG8QgUdHyw+qoi6qYrYRLK
 wky5JzEL0V8bofN58JDY79f7vUqA0GiimJu7P/9pC1bJuxkkZnZ+EmZNJxfS+WUkBdqiuM0Br
 ujTMoAKEN0VyjpJjPpjRKgMHQJmpTgp2wgwSzl84fKyx99fiarz39Axjsg57cl0G/tvMTgawu
 9e2SFVlTAaRWIfOiVQLy6F7K0QfqeSeLFm2GOhnW1OPJke9YlkX2P3WpnToy1AnKr46yz+aOw
 xrm07Mj6gVj3Op12RPric4dIUvMF6LVn1W//otQn+delxNU/twv8ETaiW2UaZzNxJGBoiycq4
 bQ1Nwh9KexmQMfH641IGPUXX07ADxhiUEAvB3ph1Jlv6S5EdnK11a7G3PTI73UQWSY/pRHzz0
 Ms2l4nUs5sxnXoeWHV+Geqe/aVRLio4axK3+T8ZHLx4VQ7e/CrQDJ85khx4THkrIOJfV9TBfi
 MQtAQS8XAUEq9t19GXgM3uTSQdl/8he+/9y6fXk8BrDpJ1R2ib5UYzpFw/QwG4hnjPGTRyw6G
 qtWEebSWOoo+B6q1FxmGkaOd15IZ6H+8DJmk9ig8lfrjNTplow9iwgM90EHTYanv/mX/GAdCz
 k8nO+2h/5GuJIhO8O22o81R7PFmCxMFCJKb7TjOkovTdWmpgC6X5ud3uNl+XIeR0kUkbvkfov
 glerP9GM5jD4mu0YQ9XgUabtZJYNxzl/+zGRp/vYf0BcLdGlTm/wTInaTVcm5U/AoNQTk/rLI
 pdhJbp2v2lf1CpkFSu/z1L0dnCPBJmYDx1ljzFNXU329y3/xQxCaPiNjaHaTqDyPAkE+hrhOp
 U1/22PDzWMpiEqG4SizsCBBSybEOMkDWSizF3JdCbmyD/QPTVhSkkccpZ58BjwyU31J+Bf+SM
 90dgoeMEpNLFXvp4eIt6TtODIEE3vwiOtIEpPzAARWJLvyEZEkNLM2ljTE+iEyAWnKHMP9okv
 1LQfttRC4ZKNMNKX4FzmQiTgpckiv0QsckJnfYlyY5XfJTRJenLiCrx3Xzq0Ycy0ABb/phiRo
 w3tr4nEgMC79O+X6T9081bY3zblMcwY/rQ8E2dZ1VRVxuR5XGzdFDhsZ78BRIVboH57t/IFxl
 SjXW6nsprtuJRbtHY4y9zbRTEHLPUsZ0Jpf6Lhn9gtHH+pXSz39wKvmzAw5pY8cB1yQBlsNsX
 Sj6kZIVSEzH3HoJQbdMUXxDeRT5jGMHE1XWy4ORzhCSSPY8Q==
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.17.11
Subject: [Qemu-devel] [PATCH 0/3] colo: Add support for continious
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
Cc: qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These Patches add support for continious replication to colo.
Please review.

Regards,
Lukas Straub

Lukas Straub (3):
  Replication: Ignore requests after failover
  net/filter.c: Add Options to insert filters anywhere in the filter list
  Document the qmp commands for continious replication

 block/replication.c  |  31 +++++++-
 docs/COLO-FT.txt     | 185 ++++++++++++++++++++++++++++++++-----------
 include/net/filter.h |   2 +
 net/filter.c         |  73 ++++++++++++++++-
 qemu-options.hx      |  10 +--
 5 files changed, 243 insertions(+), 58 deletions(-)

=2D-
2.20.1

