Return-Path: <SRS0=hQJD=5C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC62C10F29
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:23:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661A520753
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2020 15:23:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pIzDgNM2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661A520753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34662 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEE4S-0004rD-Gy
	for qemu-devel@archiver.kernel.org; Tue, 17 Mar 2020 11:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33123)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxj-0002jM-5g
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:17:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jEDxg-0001A4-Qx
 for qemu-devel@nongnu.org; Tue, 17 Mar 2020 11:16:58 -0400
Received: from mail-he1eur04on071a.outbound.protection.outlook.com
 ([2a01:111:f400:fe0d::71a]:20196
 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jEDxg-0000ji-24; Tue, 17 Mar 2020 11:16:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UVEMCZv+ONK07qBJgPkDvTM7RfSk14a96c/4EdMRjEk2qkLwlnlbin8YNC8cjTbzsKHvAuZ6djMytumFOBdA1RnWR5XDv2Y9IBpl/gxvH2xCNuXBc88OddZv2PfMlQPjF64Wc06q+3QSdWlLzgcF7aZL/MxYuL//pCsLIdYgbbkJs+DHU/cxGl6AH405iFIg1x8qM8vWpf+W0DWFeYnLoqqB1dHtE8pK2IePTd57j2/jR1ZTYCG9SQ1LoFpRzGZzgMtgi1ko8aBHDI1JOGmkToWTcDFtoFbzxmCTTH80/U9EFA7STRjFfEdbff2y/b79qSZ4mLXwFP9k5D+P7Tejsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUsq6mR0U4wxUIuZKye6yt7jGndO+qzgMrMfGLSdFzs=;
 b=m2H59Chm4uAtheuYGErpNynN7uDHT5suK0H/yOAzedwxRPlB4O/MCkaEFU+lm/bN/VxsklJrZjbl5LkvOE81rcerCbhAzm0CRwK3JU64PztAuybTWEOu5hv3YZfvSRPr3rCexopcURqN9kfjdVpf+MsajkdahWObdrO6LK2LyTMzjnU84Y9IeLC8waJJ16Fz+2Q0HpdlfjxxAnlNcVDbflHzZoYgYchwOFMz6cOH/xi9prY+KngRyAX3jgmQLaUJz8DLu4q3B6OkUSraUoGjSPw3XV5SrtdN93d7MrJfOhQgJUDol4eB0wcv9ml9W+kxAZvwhCTPKfqYwjyfYlE4nQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GUsq6mR0U4wxUIuZKye6yt7jGndO+qzgMrMfGLSdFzs=;
 b=pIzDgNM2VRDqJKmtTS+3vuiKCPjx5qNugj8Qd5qwm6+Y8evLDosUb29ZcE6Ldo+mstbzhRd6RNv68z9TqvkBKLBZ1hBagPzQESWL1fibEMyyezXKN7bODXoW0TepHkPZupLRO30Z5IoJVv5aCEV/+5xP+M4fIlZx783FQlUNSeE=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com (10.175.35.136) by
 HE1PR0802MB2620.eurprd08.prod.outlook.com (10.175.36.20) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2814.21; Tue, 17 Mar 2020 15:16:52 +0000
Received: from HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f]) by HE1PR0802MB2507.eurprd08.prod.outlook.com
 ([fe80::4d32:e4e1:5b9f:240f%12]) with mapi id 15.20.2814.021; Tue, 17 Mar
 2020 15:16:52 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v10 0/9] error: auto propagated local_err part I
Date: Tue, 17 Mar 2020 18:16:16 +0300
Message-ID: <20200317151625.20797-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:17c::15) To HE1PR0802MB2507.eurprd08.prod.outlook.com
 (2603:10a6:3:e1::8)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (185.215.60.248) by
 AM0PR10CA0005.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2835.15 via Frontend
 Transport; Tue, 17 Mar 2020 15:16:50 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.248]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 600065ec-ee0e-4cbc-097b-08d7ca8638aa
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2620:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2620DB66CA79529558EFB236C1F60@HE1PR0802MB2620.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1360;
X-Forefront-PRVS: 0345CFD558
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(39850400004)(376002)(136003)(346002)(366004)(396003)(199004)(66946007)(6666004)(1076003)(66556008)(54906003)(66476007)(86362001)(6486002)(16526019)(5660300002)(6916009)(186003)(966005)(6506007)(52116002)(4326008)(81166006)(6512007)(81156014)(8676002)(8936002)(316002)(7416002)(2906002)(26005)(478600001)(956004)(36756003)(2616005);
 DIR:OUT; SFP:1102; SCL:1; SRVR:HE1PR0802MB2620;
 H:HE1PR0802MB2507.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; A:1; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 54KyzpFy68TOS/M26bHvYqYr+edhElwjXOkwblYZ+sZGwOPh2PEpf9PetGsWmuPqsi+DighC/gjgkh3GweeLsTpXRu/NCiiNgf3hhpJOmpXDT54nxvwxM16S7bgFSJs8KHuxDZk2cPLlg58wM3hgwz/uXKlPG90GFvqBOFNweN6L6xG5QA4VpDWbnoNtv6DwymbxMva/X1yj0ItPZ9JNsYWTWVy2F5i/0fO9aVdGC9mg/vNbc8b/eiqpW00kX00FflmwkKxO2sz1EBSBQnK1k0jEbN6GgkmsL4xNKHwiCijx1cQxLbC2sdeBF+wuNekxzkAO8VXQ/uyWEMDTYzHWBn5a89jGZ7Se/1EsclVKaV+TNIv6LETjngY/RUu1wG5fq7sYxWAwMnn02Q+GdjI+vXcxtvCaoNrkUmxI5+ZX+mJk5iZnV4kfcD8gpIwtSluIo0SR7MEza+ouRnO6DZOE3QqYHVXiyD5aJncvaBISy9xi71rdO6PiRmNUcsir0dZpyef1yQHDMmb3Q+10P5EVKQ==
X-MS-Exchange-AntiSpam-MessageData: PZD43QbGR8vV34Dyn87Fuija2za1kCvIDdC1uU3+mFdKUlxZc4JGoXFhr/34jPsM7GU7Z7bKDqHBau+9wuiQRZq0lTHshQoQrpsfnpOJ7lMaYxpSddcz738q4sIpBRWScEMhT/LNVaEmP0QWigOT+g==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 600065ec-ee0e-4cbc-097b-08d7ca8638aa
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2020 15:16:52.4119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2KMNcUJV88TNrSh52fl28gvkv+nKshGiDpzqkUec9IcJhl0b+OKxvXqUiy0Uj0xalvK8ViNOXhep5LqrKtRZsQYb49KNb9MSOQDIUPIOV8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2620
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 2a01:111:f400:fe0d::71a
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
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org,
 Paul Durrant <paul@xen.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
 armbru@redhat.com, Stefano Stabellini <sstabellini@kernel.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org,
 Max Reitz <mreitz@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>,
 Stefan Berger <stefanb@linux.ibm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v10: (based-on "[PATCH 0/3] Minor error handling cleanups" including my 4/3=
 in it)
02: Change some comments.
    Do not chain check1 and check2 rules to rule1 to cover move
    unusual cases to warn about.
    Add positions to check1 rule.
    Move check1 and check2 above rule1, otherwise our ___ hack will break c=
heck2
    rule.
03: add hunk, due to rebasing and
09: rebased. Change is trivial, I keep r-b.


v10 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-par=
tI-v10
v9 is available at
 https://src.openvz.org/scm/~vsementsov/qemu.git #tag up-auto-local-err-par=
tI-v9


In these series, there is no commit-per-subsystem script, each generated
commit is generated in separate.

Still, generating commands are very similar, and looks like

    sed -n '/^<Subsystem name>$/,/^$/{s/^F: //p}' MAINTAINERS | \
    xargs git ls-files | grep '\.[hc]$' | \
    xargs spatch \
        --sp-file scripts/coccinelle/auto-propagated-errp.cocci \
        --macro-file scripts/cocci-macro-file.h \
        --in-place --no-show-diff --max-width 80

Note, that in each generated commit, generation command is the only
text, indented by 8 spaces in 'git log -1' output, so, to regenerate all
commits (for example, after rebase, or change in coccinelle script), you
may use the following command:

git rebase -x "sh -c \"git show --pretty=3D --name-only | xargs git checkou=
t HEAD^ -- ; git reset; git log -1 | grep '^        ' | sh\"" HEAD~7

Which will start automated interactive rebase for generated patches,
which will stop if generated patch changed
(you may do git commit --amend to apply updated generated changes).

Note:
  git show --pretty=3D --name-only   - lists files, changed in HEAD
  git log -1 | grep '^        ' | sh   - rerun generation command of HEAD


Check for compilation of changed .c files
git rebase -x "sh -c \"git show --pretty=3D --name-only | sed -n 's/\.c$/.o=
/p' | xargs make -j9\"" HEAD~7

Vladimir Sementsov-Ogievskiy (9):
  error: auto propagated local_err
  scripts: Coccinelle script to use ERRP_AUTO_PROPAGATE()
  SD (Secure Card): introduce ERRP_AUTO_PROPAGATE
  pflash: introduce ERRP_AUTO_PROPAGATE
  fw_cfg: introduce ERRP_AUTO_PROPAGATE
  virtio-9p: introduce ERRP_AUTO_PROPAGATE
  TPM: introduce ERRP_AUTO_PROPAGATE
  nbd: introduce ERRP_AUTO_PROPAGATE
  xen: introduce ERRP_AUTO_PROPAGATE

 scripts/coccinelle/auto-propagated-errp.cocci | 336 ++++++++++++++++++
 include/block/nbd.h                           |   1 +
 include/qapi/error.h                          | 208 +++++++++--
 block/nbd.c                                   |  21 +-
 hw/9pfs/9p-local.c                            |  12 +-
 hw/9pfs/9p.c                                  |   1 +
 hw/block/dataplane/xen-block.c                |  17 +-
 hw/block/pflash_cfi01.c                       |   7 +-
 hw/block/pflash_cfi02.c                       |   7 +-
 hw/block/xen-block.c                          | 122 +++----
 hw/nvram/fw_cfg.c                             |  14 +-
 hw/pci-host/xen_igd_pt.c                      |   7 +-
 hw/sd/sdhci-pci.c                             |   7 +-
 hw/sd/sdhci.c                                 |  21 +-
 hw/sd/ssi-sd.c                                |  16 +-
 hw/tpm/tpm_util.c                             |   7 +-
 hw/xen/xen-backend.c                          |   7 +-
 hw/xen/xen-bus.c                              |  92 ++---
 hw/xen/xen-host-pci-device.c                  |  27 +-
 hw/xen/xen_pt.c                               |  25 +-
 hw/xen/xen_pt_config_init.c                   |  20 +-
 nbd/client.c                                  |   5 +
 nbd/server.c                                  |   5 +
 tpm.c                                         |   7 +-
 MAINTAINERS                                   |   1 +
 25 files changed, 715 insertions(+), 278 deletions(-)
 create mode 100644 scripts/coccinelle/auto-propagated-errp.cocci

Cc: Eric Blake <eblake@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Greg Kurz <groug@kaod.org>
Cc: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: Paul Durrant <paul@xen.org>
Cc: "Philippe Mathieu-Daud=C3=A9" <philmd@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefan Berger <stefanb@linux.ibm.com>
Cc: Markus Armbruster <armbru@redhat.com>
Cc: Michael Roth <mdroth@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org
Cc: xen-devel@lists.xenproject.org

--=20
2.21.0


