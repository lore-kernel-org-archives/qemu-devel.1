Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BBA1C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:47:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44A12208B3
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:47:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=mysuse.onmicrosoft.com header.i=@mysuse.onmicrosoft.com header.b="hMuYChFD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44A12208B3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59740 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVbK-0004SI-I9
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:47:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59098)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVZt-0003r5-DC
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:45:59 -0400
Received: from mail-am6eur05on2073.outbound.protection.outlook.com
 ([40.107.22.73]:6168 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <LMa@suse.com>) id 1jlVZr-0002P8-Gn
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 06:45:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J1w5BDugRapG47HAjmUqXGWxHDY9VuglEULK2B9owx5Ew+Y3UudHFxR/n/qGDp2RpSb3BMeIeez0jpQT+GoeVlFNocnw7o52e2+FrJcXfx7kC6WT6cPlQ2Q7pu1WkN3WZfmGUz1aYPn6X4h7DpV/N09w4fd4RQnDTANxwdKhtx+YUuczwnYXwSHGHb439+8X2SDMLags8TfbdN8TvmQSdRT5FgTyueUEaLMGC+EB8le1hsno8ErdaGE4InBBCJSeYwv//Ay6NrB7QTgJZt5H5nJcNU5q1I76aLxGoHv7K0KELcIprqIjr5PnbCkBGwPcKLhow8KvfujGrb9r9TwBTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmzbo8jhYhKPclHozRdra7INsokKICcPMve+ooZA5ME=;
 b=INDNw/jbEN5xFmGNXVd3GJSfTAZ9+bnaHHFd2auKonSk3wEORNHWPPYo3+ZM0ZZPC4iQuBBDDLDVUnvbxMX0leJNSgBgdIf+jscpFgtXs7pUTTpV4mVgIMsVUfdOrshQrNhCzYgJROXAni/KQtNUfUGzp1N52jbY8xvawFKfOe6DxgcXw1eWZmE2qD4wyodQmsOjLAh9uP1tLZg45kZ3r9R0eCFbnXs+q2Kr/jduwjg0GbbhzqTUggJHQ9K1NFJz3sdXHmBreFmVxcDR1qGOoTRQ6Zq/uvEcwXvZ2AA2tuplt4mzOtSuqS7UWjF6kBdshpcptnWvNMtOz6/XZTYTFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mysuse.onmicrosoft.com; s=selector1-mysuse-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gmzbo8jhYhKPclHozRdra7INsokKICcPMve+ooZA5ME=;
 b=hMuYChFDAn5vAbznRMEbMJoelPURTKFvmKFdQ/1CprD4F0tdzeGPDXt/SOf5Y/l6h/fOYhxSYkFFF+7om1AT6f88f6CNhPioTK2qfF47gn7+CUnOpSgLo8IhtwPSSzwZ8zAqspUHt29NS8SdM/qQCxUrIvfO3AF6L7dTLkQuMfEqGfXFMk441FMv+bmDG6t8vixceJdlYeyQ+qha+L5q14/u0UAjvaDWLql3Ww6pR7D1M47gYg6rlU8Lf7AqBa+q/BoLk7u0xtRL6YJfyKP/H+qI4eAH30Cx7Dk5WaFZ0ywX5MQt/QtWRt8vr9jorQ6HbwSobz6LRfSIl1hdAKFt4g==
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com (2603:10a6:20b:aa::17)
 by AM6PR04MB5815.eurprd04.prod.outlook.com (2603:10a6:20b:b0::29)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Wed, 17 Jun
 2020 10:30:44 +0000
Received: from AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55]) by AM6PR04MB5782.eurprd04.prod.outlook.com
 ([fe80::d848:9dea:7742:a55%4]) with mapi id 15.20.3088.029; Wed, 17 Jun 2020
 10:30:44 +0000
From: Lin Ma <lma@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] Add Support for GET LBA STATUS 16 command in scsi
 emulation
Date: Wed, 17 Jun 2020 18:30:15 +0800
Message-Id: <20200617103018.18026-1-lma@suse.com>
X-Mailer: git-send-email 2.26.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HK0PR03CA0107.apcprd03.prod.outlook.com
 (2603:1096:203:b0::23) To AM6PR04MB5782.eurprd04.prod.outlook.com
 (2603:10a6:20b:aa::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (114.255.249.163) by
 HK0PR03CA0107.apcprd03.prod.outlook.com (2603:1096:203:b0::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3109.21 via Frontend Transport; Wed, 17 Jun 2020 10:30:41 +0000
X-Mailer: git-send-email 2.26.0
X-Originating-IP: [114.255.249.163]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 266733d2-8794-441a-13f8-08d812a97d83
X-MS-TrafficTypeDiagnostic: AM6PR04MB5815:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB581587F61D6975B0A56CE275C59A0@AM6PR04MB5815.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-Forefront-PRVS: 04371797A5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dga4A+UoBf66WoXIceW4KxsHlLjczlsNZTv/aCI2ZPKgcEZdGmNhc53ka95M0cHOlejgZdHNsPbIY5dpLAx6Vv4yUdcOY7tWk9tyWdFyv/YaSMPcDpm5Ph7EoI8OjOQgcw9jSZ3EaEAzrrBN15ZKwcVu+Z5D0nrCXPgPq5klcMxyFGQOQi5nw/lLs2652vLsuhNsDyMAU3tiD5iR2le8HC6xBrtSejX5EBwLDGXmUnTl4lnZfBQoGmszTPKsq1BYbQcqMAHbkeAMt5A5eTC1yUTy1XvT7TanQAYGtqWHgCVRhfImVkKyu7589HVJTnjeFSowG+kAjKKj8zFehrwa3eMBnwJfMTgblZR+r6ybXxVN4dnsRdTGsGbWZGtCSUWe
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR04MB5782.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(136003)(376002)(366004)(346002)(396003)(39860400002)(5660300002)(52116002)(6916009)(66556008)(478600001)(6486002)(8936002)(26005)(8676002)(2906002)(66476007)(66946007)(6506007)(4326008)(316002)(36756003)(6666004)(6512007)(86362001)(107886003)(2616005)(956004)(186003)(1076003)(16526019)(83380400001)(69590400007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData: I9t/uVjtrUT3TqoFldG8zuREefMT62YipNuFQ3EYF57zlluzTzEBvKHipGoPxqNiuf00IxE53ANt8u5Zgc3ndTci9bHi96cobIi2DTR2UP9IVGp9Hx/LjJgMFeYxvN8XDw3AFyZEA3lm7BNtkkIA5Z6xz84JFan+9X3Qc3N+/v7jzqe1gvZ78/RCb3vQ5QoNb6O5IZjAMq1gA4Fdv3xkaHodHCbHGI9bjCtzvvyM9aCb6kObR8sADV6FhNOEpGERVvEykSX7ARbu/JDdJ28FtoDWbcaAJoMoMofmEeWjgSaTPBcuLO3r12872zYiDD9jQduutJUp65S3f1eyNDVug+PBR+iB4fCoVmOK9/3jbv75lZ7GvQbUzzX/+sM3aIjrG0Cr8ZY95d8021DwMaR/Pl/nJ0Psr6WQI5fFf0UOtdfzEkr2a8uJUgvzvoVsu4WjmAeCmrbSBkISISvuk8VhQIvkr8u1E+J6C6Fbu83FAA9oOJvqu0Oy+lepGzE8uxgj
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 266733d2-8794-441a-13f8-08d812a97d83
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2020 10:30:44.0878 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bniUpfkoRwZPlsptoP7otfEu6YE1dv9pyAR+2ynwghEqn73Z/Icc10esAZaQWECv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5815
Received-SPF: pass client-ip=40.107.22.73; envelope-from=LMa@suse.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:45:48
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, stefanha@redhat.com,
 Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

v2->v1:
Follow Claudio's suggestions and the docker test result, Fix the dereferencing
'void *' pointer issues and the coding style issues.


In this current design, The GET LBA STATUS parameter data only contains
an eight-byte header + one LBA status descriptor.

How to test:
host:~ # qemu-system-x86_64 \
...
-drive file=/vm0/disk0.raw,format=raw,if=none,id=drive0,discard=unmap \
-device scsi-hd,id=scsi0,drive=drive0 \
...


guest:~ # dd if=/dev/zero of=/dev/sda bs=512 seek=1024 count=256

guest:~ # sg_unmap -l 1024 -n 32 /dev/sda

guest:~ # sg_get_lba_status /dev/sda -l 1024
No indication of the completion condition
RTP=0
descriptor LBA: 0x0000000000000400  blocks: 32  deallocated

Lin Ma (3):
  block: Add bdrv_co_get_lba_status
  block: Add GET LBA STATUS support
  scsi-disk: Add support for the GET LBA STATUS 16 command

 block/block-backend.c          | 38 ++++++++++++++
 block/io.c                     | 43 ++++++++++++++++
 hw/scsi/scsi-disk.c            | 90 ++++++++++++++++++++++++++++++++++
 include/block/accounting.h     |  1 +
 include/block/block_int.h      |  5 ++
 include/scsi/constants.h       |  1 +
 include/sysemu/block-backend.h |  2 +
 7 files changed, 180 insertions(+)

-- 
2.26.0


