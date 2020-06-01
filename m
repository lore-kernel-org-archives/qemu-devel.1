Return-Path: <SRS0=dyow=7O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FF90C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:58:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC5722067B
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2020 13:58:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vt8zMqYj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC5722067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfkx9-0006vX-2M
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 09:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34928)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfkwJ-0006Rc-KK; Mon, 01 Jun 2020 09:57:19 -0400
Received: from mail-eopbgr50090.outbound.protection.outlook.com
 ([40.107.5.90]:61447 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jfkwG-0003FB-Dj; Mon, 01 Jun 2020 09:57:18 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nAcaKu+DLfwZftu6u+OvFQ2xnAug++yRCEuqpQ5amaYsbcY0bpMAP3OMibbDlZPvuzBhn2NANjJ9f0vQbEWrnLQ2BzLhB6FJJ5dY1x/J80W0Kq2SbIByOooKiiagCqgnLMbqTDDaHBIWlzAC1ovkOTc9bKfu1emx0i2OS72CMIAu3+4nh3lY7El/Jyp2A2MllftOqsO0nREwEo4Sdi011fFPo5XKnLAx9CQ5to74mGioMiomXr+vI9XbJ+LCuqBf4wc6JU0E86DU3t7IHA8wTiibIbCP1ngFLsXKuL1bR8cmxHrfcA0zYkufLN64bvjmf8zHeC1/cxYtCalBEG4pMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jqB6ecDmIkVDfVDxh5BILxX3FoeHnG1H5YHKzHHies=;
 b=DqhoHQR/kSMm/mNlWp1KvncIBaO0o6XLYo0oTHYa2EBSqxtbXBHGl342frda9OYmfRVA0Hq8ZWi50xVguqw/GDhgQSPDs9t4otX2kNfH5fgJ/eLLefk9LTJzrzXGOarKOKCMGDYR+J3opAb8p0XD07yzO8246cj32kSePSgDUF4rpZZtDVDUEZCdLRFVTBSgSm3gOZo32pOw4zs70t16x+pJ4QnwU6uI2/LgIVfbYVJ5Oo8NmsFH8R0ZksATHlkjpqm59Bci/EDab+Klp95KNXqYCxSfnllfMMsTCk1Uu5P+76Omlyxf5LkXYm8U/ZmReFuHG13pcPM8AmXZRmDGiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+jqB6ecDmIkVDfVDxh5BILxX3FoeHnG1H5YHKzHHies=;
 b=Vt8zMqYj/T0+ccLT4pj3031Af+RGdayghCwwYdkrtUzdfwxgEgAGlIzLtfBYaRq1jKc2kUhqbMXTgvOpIyTInIWH0L5LEN49c49FlmJkXx8TtiuNR4/u9z/qbPquqGCuSx54xjl5DP0/WEDDwGFK3PPQGNjYyCN3lcmzp21T0YE=
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3638.eurprd08.prod.outlook.com (2603:10a6:20b:4b::25)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3045.17; Mon, 1 Jun
 2020 13:57:06 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::2122:8358:546a:adae%3]) with mapi id 15.20.3045.024; Mon, 1 Jun 2020
 13:57:06 +0000
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Subject: Re: [PATCH v5 00/15] Apply COR-filter to the block-stream permanently
Thread-Topic: [PATCH v5 00/15] Apply COR-filter to the block-stream permanently
Thread-Index: AQHWKQwWkOpphuYTkkWJhO5zdBVmxKjD5qpj
Date: Mon, 1 Jun 2020 13:57:06 +0000
Message-ID: <AM6PR08MB407077857517F552E121D413F48A0@AM6PR08MB4070.eurprd08.prod.outlook.com>
References: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1589363456-1035571-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
x-originating-ip: [109.252.114.90]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 165fbbaf-ab80-4ce5-f319-08d80633aba2
x-ms-traffictypediagnostic: AM6PR08MB3638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM6PR08MB363821E09C5D6B645A56D4A0F48A0@AM6PR08MB3638.eurprd08.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 0421BF7135
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n8rwHhYBDmDVVmxlX959RG1CMyS82BH/pikEle6eVucoBxHoIz4wMHQb1wzXcgeCugLPFap9g4BPjwmNEGrkDMNQWAQNdeAuEYWH08GjQ01v0X6CytXWhc2n+o7NyY3kCdbJTK2J6KXrSWpY2CjsC1/U9qY+pNSgAJ1gIjFfPvjwVJIHrM9QOnzCPwLJVOdWy1pMPRMVBqbmikH3canC7j1aXccZTWnNiAecTLOKVnmmU6oii/iqKNYg2CwNZ1c8dJ8KCBSh0i7jXDt/vJm/X2uTNREJmL24lke5beoCo+TEM6xZDzcqy1irGL/dfZ+68UIt6V1XmLkkkbfXzPzwXwlyVMqp8lWV+xw0miY3s9/66heI8ICC1UJ4Mbg6FFMJhmH2YrQ8EnaUtaX7WFEdaQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(366004)(136003)(346002)(376002)(39840400004)(478600001)(52536014)(2906002)(66946007)(53546011)(9686003)(966005)(8676002)(8936002)(55016002)(44832011)(107886003)(33656002)(6506007)(7696005)(54906003)(4326008)(316002)(5660300002)(83380400001)(166002)(26005)(6916009)(66476007)(186003)(76116006)(66556008)(64756008)(66446008)(71200400001)(91956017)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: 3TWDelkhk2IWuFko0/3leob4VOuXh3I4cpXJKHY5L62lSTFDCxG7ayw3IxRP1Drf1eDQ/AWu8SfVixFH1rPK9+GHJ3XZbuuPRnOZmRd9usKdwbQwetmvywQUF8KWSAqVNUFN0KupHJgagABs8ieQ2YSRAJepAD3F1H008dK0F2/blrawAeziXiHGQtM04ixFB12nWQ+DQxEDm9zp5sMhbkHbKZt++zSaWA9bVARQe2zgPxWV0BLU9pqIkEVqsL/P84VyGCctIcwNvEU7bHq7CM9qwJkqOaJZpnKPr+grLPG2vZqf0D7HyKApc0+7NtXkhytE+1bkWbljECFNp7CcucAcpMjzQodyqliFYEZfiGdzBGzaOeW1MAx9l7VuFZH7G2BWOZrx8nl8Zas/0x4TwLEHb8XJ1tRtrBykcTxNMcGm6j3tFh7KvQoK6Ysz+tDvHoepvtPPbMTUUAe5ZS6naRlr9YnlA9CFzz8WvE03vhAbxSvlkhioAHBYDhOlGtWW
Content-Type: multipart/alternative;
 boundary="_000_AM6PR08MB407077857517F552E121D413F48A0AM6PR08MB4070eurp_"
MIME-Version: 1.0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 165fbbaf-ab80-4ce5-f319-08d80633aba2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2020 13:57:06.4137 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HhSiOfn1XsAbqE1AqeZStOdUriN1vq/NTdTzwEkjA+nACdJgZWXDb9+/7R7UKlzLx+zsjtCw0ow0T7fcDQUAjGojeYrdeZ0TdhLqdvsjnZ8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3638
Received-SPF: pass client-ip=40.107.5.90;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/01 09:57:09
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: "kwolf@redhat.com" <kwolf@redhat.com>, "fam@euphon.net" <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Denis Lunev <den@virtuozzo.com>, "armbru@redhat.com" <armbru@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
 "mreitz@redhat.com" <mreitz@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--_000_AM6PR08MB407077857517F552E121D413F48A0AM6PR08MB4070eurp_
Content-Type: text/plain; charset="us-ascii"

PINGING...

Please

________________________________
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Sent: Wednesday, May 13, 2020 12:50 PM
To: qemu-block@nongnu.org <qemu-block@nongnu.org>
Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; kwolf@redhat.com <kwolf@redhat.com>; mreitz@redhat.com <mreitz@redhat.com>; armbru@redhat.com <armbru@redhat.com>; fam@euphon.net <fam@euphon.net>; jsnow@redhat.com <jsnow@redhat.com>; stefanha@redhat.com <stefanha@redhat.com>; eblake@redhat.com <eblake@redhat.com>; Denis Lunev <den@virtuozzo.com>; Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>; Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Subject: [PATCH v5 00/15] Apply COR-filter to the block-stream permanently

With this series, all the block-stream COR operations pass through
the COR-filter. The patches 01-08/15 are taken from the series
"block: Deal with filters" by Max Reitz, the full version of that
can be found in the branches:

      https://git.xanclic.moe/XanClic/qemu child-access-functions-v6
      https://github.com/XanClic/qemu child-access-functions-v6

      When running iotests, apply "char-socket: Fix race condition"
      to avoid sporadic segmentation faults.

v5:
  01: Included forgotten file block/copy-on-read.h

v4:
  01: Initialization of the COR-filter BDRVStateCOR member.

v3:
  01: The COR filter insert/remove functions moved to block/copy-on-read.c
      to be a part of API.
  02: block/stream.c code refactoring.
  03: The separate call to block_job_add_bdrv() is used to block operations
      on the active node after the filter inserted and the job created.
  04: The iotests case 030::test_overlapping_4 was modified to unbound
      the block-stream job from the base node.
  05: The COR driver functions preadv/pwritev replaced with their analogous
      preadv/pwritev_part.

v2:
  01: No more skipping filters while checking for operation blockers.
      However, we exclude filters between the bottom node and base
      because we do not set the operation blockers for filters anymore.
  02: As stated above, we do not set the operation blockers for filters
      anymore. So, skip filters when we block operations for the target
      node.
  03: The comment added for the patch 4/7.
  04: The QAPI target version changed to 5.1.
  05: The 'filter-node-name' now excluded from using in the test #030.
      If we need it no more in a final version of the series, the patch
      5/7 may be removed.
  06: The COR-filter included into the frozen chain of a block-stream job.
      The 'above_base' node pointer is left because it is essential for
      finding the base node in case of filters above.


Andrey Shinkevich (7):
  block: prepare block-stream for using COR-filter
  copy-on-read: Support change filename functions
  copy-on-read: Support preadv/pwritev_part functions
  copy-on-read: add filter append/drop functions
  qapi: add filter-node-name to block-stream
  iotests: prepare 245 for using filter in block-stream
  block: apply COR-filter to block-stream jobs

Max Reitz (8):
  block: Mark commit and mirror as filter drivers
  copy-on-read: Support compressed writes
  block: Add child access functions
  block: Add chain helper functions
  block: Include filters when freezing backing chain
  block: Use CAFs in block status functions
  commit: Deal with filters when blocking intermediate nodes
  block: Use CAFs when working with backing chains

 block.c                        | 275 ++++++++++++++++++++++++++++++++++-------
 block/commit.c                 |  85 ++++++++++---
 block/copy-on-read.c           | 159 ++++++++++++++++++++++--
 block/copy-on-read.h           |  36 ++++++
 block/io.c                     |  19 +--
 block/mirror.c                 |   6 +-
 block/monitor/block-hmp-cmds.c |   4 +-
 block/stream.c                 |  89 +++++++++----
 blockdev.c                     |  19 ++-
 include/block/block.h          |   6 +-
 include/block/block_int.h      |  67 +++++++++-
 qapi/block-core.json           |   6 +
 tests/qemu-iotests/030         |  17 +--
 tests/qemu-iotests/141.out     |   2 +-
 tests/qemu-iotests/245         |  10 +-
 15 files changed, 661 insertions(+), 139 deletions(-)
 create mode 100644 block/copy-on-read.h

--
1.8.3.1


--_000_AM6PR08MB407077857517F552E121D413F48A0AM6PR08MB4070eurp_
Content-Type: text/html; charset="us-ascii"

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=us-ascii">
</head>
<body>
<div>PINGING...</div>
<div><br>
</div>
<div>Please&nbsp;</div>
<div><br>
</div>
<hr style="display:inline-block;width:98%" tabindex="-1">
<div id="divRplyFwdMsg" dir="ltr"><font face="Calibri, sans-serif" style="font-size:11pt" color="#000000"><b>From:</b> Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Sent:</b> Wednesday, May 13, 2020 12:50 PM<br>
<b>To:</b> qemu-block@nongnu.org &lt;qemu-block@nongnu.org&gt;<br>
<b>Cc:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;; kwolf@redhat.com &lt;kwolf@redhat.com&gt;; mreitz@redhat.com &lt;mreitz@redhat.com&gt;; armbru@redhat.com &lt;armbru@redhat.com&gt;; fam@euphon.net &lt;fam@euphon.net&gt;; jsnow@redhat.com &lt;jsnow@redhat.com&gt;; stefanha@redhat.com
 &lt;stefanha@redhat.com&gt;; eblake@redhat.com &lt;eblake@redhat.com&gt;; Denis Lunev &lt;den@virtuozzo.com&gt;; Vladimir Sementsov-Ogievskiy &lt;vsementsov@virtuozzo.com&gt;; Andrey Shinkevich &lt;andrey.shinkevich@virtuozzo.com&gt;<br>
<b>Subject:</b> [PATCH v5 00/15] Apply COR-filter to the block-stream permanently</font>
<div>&nbsp;</div>
</div>
<div class="BodyFragment"><font size="2"><span style="font-size:11pt;">
<div class="PlainText">With this series, all the block-stream COR operations pass through<br>
the COR-filter. The patches 01-08/15 are taken from the series<br>
&quot;block: Deal with filters&quot; by Max Reitz, the full version of that<br>
can be found in the branches:<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="https://git.xanclic.moe/XanClic/qemu">https://git.xanclic.moe/XanClic/qemu</a> child-access-functions-v6<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <a href="https://github.com/XanClic/qemu">https://github.com/XanClic/qemu</a> child-access-functions-v6<br>
<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; When running iotests, apply &quot;char-socket: Fix race condition&quot;<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to avoid sporadic segmentation faults.<br>
<br>
v5:<br>
&nbsp; 01: Included forgotten file block/copy-on-read.h<br>
<br>
v4:<br>
&nbsp; 01: Initialization of the COR-filter BDRVStateCOR member.<br>
<br>
v3:<br>
&nbsp; 01: The COR filter insert/remove functions moved to block/copy-on-read.c<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; to be a part of API.<br>
&nbsp; 02: block/stream.c code refactoring.<br>
&nbsp; 03: The separate call to block_job_add_bdrv() is used to block operations<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; on the active node after the filter inserted and the job created.<br>
&nbsp; 04: The iotests case 030::test_overlapping_4 was modified to unbound<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; the block-stream job from the base node.<br>
&nbsp; 05: The COR driver functions preadv/pwritev replaced with their analogous<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; preadv/pwritev_part.<br>
<br>
v2:<br>
&nbsp; 01: No more skipping filters while checking for operation blockers.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; However, we exclude filters between the bottom node and base<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; because we do not set the operation blockers for filters anymore.<br>
&nbsp; 02: As stated above, we do not set the operation blockers for filters<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; anymore. So, skip filters when we block operations for the target<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; node.<br>
&nbsp; 03: The comment added for the patch 4/7.<br>
&nbsp; 04: The QAPI target version changed to 5.1.<br>
&nbsp; 05: The 'filter-node-name' now excluded from using in the test #030.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; If we need it no more in a final version of the series, the patch<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 5/7 may be removed.<br>
&nbsp; 06: The COR-filter included into the frozen chain of a block-stream job.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The 'above_base' node pointer is left because it is essential for<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; finding the base node in case of filters above.<br>
<br>
<br>
Andrey Shinkevich (7):<br>
&nbsp; block: prepare block-stream for using COR-filter<br>
&nbsp; copy-on-read: Support change filename functions<br>
&nbsp; copy-on-read: Support preadv/pwritev_part functions<br>
&nbsp; copy-on-read: add filter append/drop functions<br>
&nbsp; qapi: add filter-node-name to block-stream<br>
&nbsp; iotests: prepare 245 for using filter in block-stream<br>
&nbsp; block: apply COR-filter to block-stream jobs<br>
<br>
Max Reitz (8):<br>
&nbsp; block: Mark commit and mirror as filter drivers<br>
&nbsp; copy-on-read: Support compressed writes<br>
&nbsp; block: Add child access functions<br>
&nbsp; block: Add chain helper functions<br>
&nbsp; block: Include filters when freezing backing chain<br>
&nbsp; block: Use CAFs in block status functions<br>
&nbsp; commit: Deal with filters when blocking intermediate nodes<br>
&nbsp; block: Use CAFs when working with backing chains<br>
<br>
&nbsp;block.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 275 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-------<br>
&nbsp;block/commit.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 85 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;---<br>
&nbsp;block/copy-on-read.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; | 159 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;--<br>
&nbsp;block/copy-on-read.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 36 &#43;&#43;&#43;&#43;&#43;&#43;<br>
&nbsp;block/io.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 &#43;--<br>
&nbsp;block/mirror.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 &#43;-<br>
&nbsp;block/monitor/block-hmp-cmds.c |&nbsp;&nbsp; 4 &#43;-<br>
&nbsp;block/stream.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 89 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;----<br>
&nbsp;blockdev.c&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 19 &#43;&#43;-<br>
&nbsp;include/block/block.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 &#43;-<br>
&nbsp;include/block/block_int.h&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 67 &#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;&#43;-<br>
&nbsp;qapi/block-core.json&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 6 &#43;<br>
&nbsp;tests/qemu-iotests/030&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 17 &#43;--<br>
&nbsp;tests/qemu-iotests/141.out&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 &#43;-<br>
&nbsp;tests/qemu-iotests/245&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp; 10 &#43;-<br>
&nbsp;15 files changed, 661 insertions(&#43;), 139 deletions(-)<br>
&nbsp;create mode 100644 block/copy-on-read.h<br>
<br>
-- <br>
1.8.3.1<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_AM6PR08MB407077857517F552E121D413F48A0AM6PR08MB4070eurp_--

