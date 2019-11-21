Return-Path: <SRS0=OA/w=ZN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0628C432C3
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:53:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96E6B20658
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2019 17:53:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mxGEejMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96E6B20658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iXqeT-0001x5-Jy
	for qemu-devel@archiver.kernel.org; Thu, 21 Nov 2019 12:53:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42905)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lukasstraub2@web.de>) id 1iXqad-0000Em-DP
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:50:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <lukasstraub2@web.de>) id 1iXqac-00070n-Fh
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:49:59 -0500
Received: from mout.web.de ([212.227.17.11]:60345)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <lukasstraub2@web.de>) id 1iXqac-0006yQ-2h
 for qemu-devel@nongnu.org; Thu, 21 Nov 2019 12:49:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574358562;
 bh=jwfVK4sRWXBkN5gEvWZUe/U4B/BoeFvmRlrE/E3bWP8=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject;
 b=mxGEejMvP/shWS2lD5GA88ZBZQxqW4OKkEgbtBquzn4d9d3KEOst3ljOs0CbXCpvH
 LUOPk7JPaibFhcODK7j9BHAnEeylUyiu9dHq/DlgMAbePdk9n0NLLWJ20B4B8khEkW
 YBvY7QkbOGsq5nEsUoYoc1AJDSHiplX1MCvu2sk0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from luklap ([89.247.255.160]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LyljP-1hjuqs3Oyd-01693x; Thu, 21
 Nov 2019 18:49:21 +0100
Date: Thu, 21 Nov 2019 18:49:18 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: qemu-devel <qemu-devel@nongnu.org>
Subject: [PATCH 0/4] colo: Introduce resource agent and high-level test
Message-ID: <cover.1574356137.git.lukasstraub2@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VkPE7bInktOE4iZqub1ZzGZEZ5Pki6g2ozM0L0mS235M2Z+gJuQ
 UXDIcRGkN0A/nnDSJjda2pz6Urf+yWwuflbKfG/QVHVXKgiHAtw7EsOBFB8E9GEm2GWbD6C
 EvNT9xzhQtRohEWN3v1xbl5JCoNzswDdKiUSGfxG4hFQromaQdmoI6ytIGWixOgneU+Suuz
 NKbNBMOXHbb8Jwa/aLPWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SF+GvnFJNos=:zhLOkieu2GAwlQNDmR5ptx
 W4Nte082kUUX7BJr+CCreCR2jKH414r+4PmQCBgWDvn/6/AYZhQtGiCiYBfRL/A8Cpzvp1/LR
 4Q6B19b8NObhQZT7PNsLrS+IrLBREbYdoMeSVY4X+JF2SfDvFimsFQOrGCM5R1rIHnH8WGe1v
 ZmLSrTuu7+hSpWnSj+vzpvrnS1Pv5cKdnafPrwipz3oQQDABdKmDsHra54SnHf6nlvbMOwVh8
 mn087UWTMI/kdS6K4AVcdOrTEK64d36l7ib96diExyaagGwEhIUPNIPkizrHwQy2F90ZOkQf2
 htryXUhuO/saAVPalX/G5l6iKUfJ8t1T9nJkWmUvcdkTKioL/GzgTYl5pYPkcH6IiXEtcSxpQ
 kAJ3WpUPDMbqNjl1rvjX71SzYp097TzK55HnfCGoQQpkn0zmDBJAUGfXhO79pQTcHyVLdjMIZ
 FmX4RhqcMquolctyHMlwAyCbmLlf4Yyam2hOpnC76tpW7cj8ch38wEkCyEKaZ2Ruyq6FrCl7Z
 mMVbEId/uYQXuLPv1C+CGRdKM8ewRSEdULmTyjxRY/xaMtXvJvbYxMpEI4/oPlXXtmixRMubl
 2d404tMtxaT/MCR20dahxcZWLMOz6XhTFCU+fTt0vUxXf9yDX6Hqos7gU9zCbVhkkqOklqj5U
 8mbfY0ZXLoYaQ4wbjKTEGmlb1PTs6YFE4SagS5zD3YeXlfDOu9cPQE+cG1BPu9SAwAnnZhs84
 m1c3WBqGksSzo9Qr7aEmO1SggIyA6IyVHEku6cllt8zZdakg7m1J2WUfiB4fyuyOhyR4MO3Nu
 Ql3UW11eh3YxrKHOaYqIFZ+FEtFpVheX0E/2SgOxwbKujGr3hO85snEGdQ0oN0x8FwF3MYyiX
 WWPa686gn7EaBqnms5bxnca0AwaPn3551EL169l44oVg2EFp7R1r5WDsoOlfxZdqaf1y27Z31
 Q0bBne3SOIGtV1lGtNf9/NPZ2z0gUzuhPfmDjROtVyXZTh6BhTIcevMljBxim5hflykBFdzho
 DXttFqbXDiuAvoAQwOSWsFGVaXXGIWToCtr5L4yprjCXe4OcxRIqSDrzzWJo/Rgelr0cgONen
 SfRq3YSvbcwQwrbMnSBlQgzG61FTXifD/433e/VJjI0TdqSQfzxZDQiT2RayWTXpRHRfgvowk
 /tWMXX4S25EmGkuX90cQAI3d7doRu0ABMDFTiMZrKvJxSIX7spll4+djXsnk+cVHYH0GNazmq
 sDX7Gou12DTfgegtxArHJhT2YtTCqNZUMTsoGDkIiyZSlDzUjKMiqzOn9ZkI=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.17.11
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
Cc: "Zhang, Chen" <chen.zhang@intel.com>, Jason Wang <jasowang@redhat.com>,
 Alberto Garcia <berto@igalia.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hello Everyone,
These patches introduce a resource agent for use with the Pacemaker CRM an=
d a
high-level test utilizing it for testing qemu COLO.

The resource agent manages qemu COLO including continuous replication.

Currently the second test case (where the peer qemu is frozen) fails on pr=
imary
failover, because qemu hangs while removing the replication related block =
nodes.
Note that this also happens in real world test when cutting power to the p=
eer
host, so this needs to be fixed.

Based-on: <cover.1571925699.git.lukasstraub2@web.de>
([PATCH v7 0/4] colo: Add support for continuous replication)

Lukas Straub (4):
  block/quorum.c: stable children names
  colo: Introduce resource agent
  colo: Introduce high-level test
  MAINTAINERS: Add myself as maintainer for COLO resource agent

 MAINTAINERS                            |    6 +
 block/quorum.c                         |    6 +
 scripts/colo-resource-agent/colo       | 1026 ++++++++++++++++++++++++
 scripts/colo-resource-agent/crm_master |   44 +
 tests/acceptance/colo.py               |  444 ++++++++++
 5 files changed, 1526 insertions(+)
 create mode 100755 scripts/colo-resource-agent/colo
 create mode 100755 scripts/colo-resource-agent/crm_master
 create mode 100644 tests/acceptance/colo.py

=2D-
2.20.1

