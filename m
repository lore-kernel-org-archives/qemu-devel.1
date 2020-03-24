Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73366C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 402722073E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 15:39:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="pBVPGYzw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 402722073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGleI-0006NH-Dt
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 11:39:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39653)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbt-0000iJ-DD
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jGlbs-0005kV-9b
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 11:36:57 -0400
Received: from mail-eopbgr70127.outbound.protection.outlook.com
 ([40.107.7.127]:12801 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jGlbs-0005iH-1N; Tue, 24 Mar 2020 11:36:56 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IRB4VdmEGTfK/BfLIap+H8n9e8lnkg3TcvusOHLF91WigOIRQdb/X42oEXYVuwxzTFmVgC2Aiab/s+FHe5Q0AyvlU4285JaRnmdoRMd9d/3RHzgetuk7PIZaJYDQkSZ/Z5xKCcVx/zeivkVRYNDLD7qeadcE6MFGhjI0NXLThbJ/eRo8gMGKagZlkvDC4HPneE3TOVgAdR7xyw0zmLCuY05gBrQ02jp4mLg0BEzE/mm8yKMK+Wc29kkk6DjXzfx0b3EtX3GzqOPm0rt/nLHc8FrCV4R7WHdJkIEz089g+lh3Mca7ZDVEgIy/cmOCLNbhnRcmnh4HrXR+6DotGOFTuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC8lq9+Zh1HMxH0rGLH6/fnwLrDvmfThUJgMeq3kQCE=;
 b=UzpFPuwRh0Mb9BmORfv61edYYYkS9j3fnR4FSiXC7Clwx5u0ClC6VqDILpkSLlhteHKoX6qkpiecu11NUQQaqV9hMjSympjpi714DKFa82tPanTXrIFO38jXE4j1OWbPgLO6Yzp8xtL2h7hR82y5M8nxoiYuhaY+MsJu+HlB3owmVA52HgMZ4M/MfSHBf6IDHJIVth0JbX+qJr+35aVE364nXUhXow/kwqgq+r3gLqKty8SqST6UE1wnTqyy5iT37foNFBcBtOHk1EO7/De8+0o/aoVIa3A9MBjTo5oGrgThMOieX4NfcDhCYmvQ6dE6JIA4ZsjT1BepHKjnklL3Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IC8lq9+Zh1HMxH0rGLH6/fnwLrDvmfThUJgMeq3kQCE=;
 b=pBVPGYzwZAN1PG/X45AGVjBzWDRv/44LKI+mhQ0IB83R6m3oJj8TFI6rplBHE9z/Mo1V+I+2tHGn7KLjS1S6d4SW2PWmSKbklMhUDVUaa3tuejFejS7Pe2dJ3oesW/OW7AZU6798GSU8WoYEiElPuMESfEBtDpJt+g10pSwp7M0=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (10.141.175.15) by
 AM7PR08MB5336.eurprd08.prod.outlook.com (10.141.172.73) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20; Tue, 24 Mar 2020 15:36:54 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::9057:6f5a:378c:7533%6]) with mapi id 15.20.2835.021; Tue, 24 Mar 2020
 15:36:54 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] qga/commands-posix: fix use after free of local_err
Date: Tue, 24 Mar 2020 18:36:30 +0300
Message-ID: <20200324153630.11882-7-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200324153630.11882-1-vsementsov@virtuozzo.com>
References: <20200324153630.11882-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain
X-ClientProxiedBy: HE1PR0401CA0062.eurprd04.prod.outlook.com
 (2603:10a6:3:19::30) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.15) by
 HE1PR0401CA0062.eurprd04.prod.outlook.com (2603:10a6:3:19::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2835.20 via Frontend Transport; Tue, 24 Mar 2020 15:36:53 +0000
X-Mailer: git-send-email 2.21.0
X-Originating-IP: [185.215.60.15]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc7acb14-ef0d-4a2b-d3c8-08d7d0092e4c
X-MS-TrafficTypeDiagnostic: AM7PR08MB5336:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB5336B5E06DA8C0F4D58D784FC1F10@AM7PR08MB5336.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-Forefront-PRVS: 03524FBD26
X-Forefront-Antispam-Report: SFV:NSPM;
 SFS:(10019020)(4636009)(346002)(136003)(366004)(376002)(39850400004)(396003)(66946007)(81166006)(66556008)(5660300002)(4326008)(66476007)(2906002)(81156014)(8676002)(16526019)(6666004)(107886003)(26005)(8936002)(186003)(316002)(6512007)(6486002)(52116002)(36756003)(6506007)(1076003)(478600001)(956004)(86362001)(6916009)(2616005)(7416002);
 DIR:OUT; SFP:1102; SCL:1; SRVR:AM7PR08MB5336;
 H:AM7PR08MB5494.eurprd08.prod.outlook.com; FPR:; SPF:None; LANG:en;
 PTR:InfoNoRecords; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TzNDLaf+HH/XQjurnk+jQ6qBqzIZgSxcPGk6kasakbI4X2a20cZSaGmELLV8QJMlOcy/E1qsspC8EnnKOlC5eNFsdL1+DnPLNprB/P5v1mxreiSL9mKzCUJhW6Er8qIbOYMEHd1osB8HXX1Tlav1b7xf4lGydngRZkp/XKvalO+gJrbHghU9SJK8fTy+lfgn73OWFQOSEiWcaXSLnuLZmSlcfmL1QGvKuNSz/KlrjahERyQ3EYOnTy4jDgZ7IyEoa+n5d6QGWFCYdDN9XdahhB8Fq+BEdy3ex6QlaOIcbVgc2NJWMzvcubssz/ibTPqBDKrlFhGra6hvnDZWTtI3yKMb4ozA2IaZWAk5yCXBx+ek12aVwItwaA76hlQ43JxwG466SvPqh+gh126WgTfQhwX0NvF5HY4yVx+warqE/0LSclV6322/pN2I25q+6Brg
X-MS-Exchange-AntiSpam-MessageData: bpkTu95P2ruhXb1d4THnE8u10/Te9ROwGP2vgpye5/bSrH11KPTaIPmRAixN8MUcOvaU3w7S2MZDtv0AjvmXUU95Q85fwplJWx0TPnCkYcCabCNncPR17iwlENsupNL2pZncmQY/T3ds0c/A/OPmuQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc7acb14-ef0d-4a2b-d3c8-08d7d0092e4c
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2020 15:36:54.8335 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tPku4VizcRNx5F8/HBl415g5XNfVsoY9GWQcM/fXSGdjW590gMEmYgbZXpzmG9k8vvrIWDW/Cst8B8v+BIPFl7JnmemEpGRnOodBhfhrb/I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5336
X-detected-operating-system: by eggs.gnu.org: Windows 7 or 8 [fuzzy]
X-Received-From: 40.107.7.127
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, zhang.zhanghailiang@huawei.com,
 qemu-block@nongnu.org, quintela@redhat.com, armbru@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, den@openvz.org,
 marcandre.lureau@redhat.com, jsnow@redhat.com, mdroth@linux.vnet.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

local_err is used several times in guest_suspend(). Setting non-NULL
local_err will crash, so let's zero it after freeing. Also fix possible
leak of local_err in final if().

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 qga/commands-posix.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index 93474ff770..cc69b82704 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1773,6 +1773,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     error_free(local_err);
+    local_err =3D NULL;
=20
     if (pmutils_supports_mode(mode, &local_err)) {
         mode_supported =3D true;
@@ -1784,6 +1785,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     error_free(local_err);
+    local_err =3D NULL;
=20
     if (linux_sys_state_supports_mode(mode, &local_err)) {
         mode_supported =3D true;
@@ -1791,6 +1793,7 @@ static void guest_suspend(SuspendMode mode, Error **e=
rrp)
     }
=20
     if (!mode_supported) {
+        error_free(local_err);
         error_setg(errp,
                    "the requested suspend mode is not supported by the gue=
st");
     } else {
--=20
2.21.0


