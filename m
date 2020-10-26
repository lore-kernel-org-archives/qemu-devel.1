Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8DF9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F83621D42
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 17:36:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="nzCMPQP0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F83621D42
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50586 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX6Pw-0003zc-C5
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 13:36:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68y-0007dd-KZ; Mon, 26 Oct 2020 13:18:52 -0400
Received: from mail-vi1eur05on2123.outbound.protection.outlook.com
 ([40.107.21.123]:17409 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kX68w-0008Ou-VN; Mon, 26 Oct 2020 13:18:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=USat5E/x4ezWMFw5hyQ2MZipnbgTHG3N3FlyG7QbYcnrtB911XbCylKCg/a8p1I1GSRJ8C7csUXLdnI5tWciNq0t7asoC0yuT0sbT4RJb7gK/bKsyxr37MdYTyXn++ricPddGrdw32iLompyCgFDpb5kMQKj9n8NaECUuINyrYpfc0LW4SMs7hNAwjbt6HRGBXb9GUuGbW2obV6b67YwHACKaBiLtnICWav4XfB3J32bdf0F68plR8VG1CH3RkDYsZprE4Ck+TPJxA/oAqSd2DJncEEOV/B0hZokAjYuTyS6SNBGpGLs5JVg11IeJshPQ9FoxL9lvcMu6ZvHWpB8iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ansT+phiWPeXuxSyFhONZCEuW6rwZbbGm4887je7Fnc=;
 b=Ll+UFUJXyIc1FaSSuYQyZbwW73WhAQIzLPhGYqdL87f4KRWOwy82rbnnhi9Kq+Q5rZSwD6GYyHVsuZ8i79/SvkE4FDy+kPfYqnxBorjwtPxriHVM5FF1cqPeBImHCQnNGL17iFzkJBQ8QJHdGQRxm8T/4zSCXkleT9W0Spi1nWew9OUUo82KXi0k6HsvfX5ES17+iOzHy7Kavzhd7Ain4J/bC6eh4+lArZAzRj/IRudyGMg4PEa0RukgDs8aLFfBQoO1l8xe/nygJkv9Bfh2yWJR8iodg/sMiRBpWh/EWkB+2kp5fVWX90n9rbm/PAAMQzNXJjYach/5CMAz9zACRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ansT+phiWPeXuxSyFhONZCEuW6rwZbbGm4887je7Fnc=;
 b=nzCMPQP0GQ4/qz1nz6hi1WPTMLIs8AIQPTxFSGFBtPac908HS7+VTDOEOkOMrT07gMmPK+RdftnLEiLAr29VKvhdMsYCwTmAVmdKv4ZBK8A4L9xbrIHG9W7AHxtbUASjwGGNM4atOoSDCls6+SY5arDuSfgQYNArN5OWIyap++0=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3032.eurprd08.prod.outlook.com (2603:10a6:209:43::31)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Mon, 26 Oct
 2020 17:18:38 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Mon, 26 Oct 2020
 17:18:38 +0000
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, vsementsov@virtuozzo.com, eblake@redhat.com,
 armbru@redhat.com, xiechanglong.d@gmail.com, wencongyang2@huawei.com,
 jsnow@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org
Subject: [PATCH v3 10/25] job: call job_enter from job_user_pause
Date: Mon, 26 Oct 2020 20:18:00 +0300
Message-Id: <20201026171815.13233-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20201026171815.13233-1-vsementsov@virtuozzo.com>
References: <20201026171815.13233-1-vsementsov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [185.215.60.99]
X-ClientProxiedBy: AM0PR02CA0101.eurprd02.prod.outlook.com
 (2603:10a6:208:154::42) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from kvm.sw.ru (185.215.60.99) by
 AM0PR02CA0101.eurprd02.prod.outlook.com (2603:10a6:208:154::42) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Mon, 26 Oct 2020 17:18:38 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3b0f3e80-1f3e-4807-391d-08d879d32dc8
X-MS-TrafficTypeDiagnostic: AM6PR08MB3032:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3032563BEC2A3CE5E18CEA96C1190@AM6PR08MB3032.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMk7wgRGiOXqCg+RHXrHqTbAMs77iT1GfFT0npr99s4f+YZ75ymov8Fd8ZfWxXSTkGAIU4RAANr7+bnfagl3gvkZ0GWzDEDKI/dtp5gOAKZF/XHBMCUarFIBnh5oLYpsHB4YHnsBy5j283N7IFAS72HYEE7IREscTvpwH6Uzm+tpK/3sUUZ5tvrMS+hp2puqmiBMQIT7Mue/GW32fzvgkhIeXtUtzOVu2coJHpdiOwVmNaIUFId/ipzttt+SLjToDHiHkocPNHLkpoRCdwrt4LShSaP6dQiCkjEFV5ltIKdcWhVfWUQcKQTS9UGSxQK6
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(366004)(376002)(346002)(396003)(39840400004)(66476007)(8936002)(5660300002)(316002)(6506007)(6512007)(2616005)(66946007)(956004)(66556008)(6666004)(26005)(4326008)(36756003)(478600001)(52116002)(1076003)(16526019)(83380400001)(2906002)(186003)(6916009)(8676002)(107886003)(86362001)(6486002)(4744005);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: Z80BG318nqe2uXjUJPkvk5SjCPE4VEoYF2IVDAqspGYLkxHB7Ga+J5SyinmwV8M6xyE/pA7xB6hG8WKbG7SV4kEnNfqZUkKgMY2KpQqEMQCPM2UYKte6QxGFWjJWsfaRAn5uyoPZ4jCf3ylgEQH3CjnHmUIivmNfvarUm+sxm9wnvarHq2O1PjlJqxeoarrwGZmDr/h2IXrVdkDNVA1OdP8QxvprNa+REgXnl8cbBqloDT/LegSu0fB1nYtF0ZMakPe9L2w+bZmh5/6Njc6M3kmLvRWX67KqCiVmKnwk+/KuxXq3pHcd7UkLEmT2Vevgq4JqlKa0W8+hT9iU8Ro4ZeeD1ZuGFOwpNhiwdtZHWOLwe3q2neKJ0jMJtHOePNsabe5+85PVrgW5Qowev7tEgAXkJHe/vP+gv1YKlcdWWequ6SvnODvQ2n3g4aElTF56e1RmAapZbs74STfBYlcPbIDhi5sFTp6q5g0wvKG6oehISEFkTEvp3o9UOvvis0O1bjtuaJYwvLg3mJ5QQZoJgKG+4qNEAaJn0n1InAgiH9bTuWrz2ylX30ol+dh3aiqlPin5yudEwgvz3HIcAT/Z6TYHabJFP46Eyj6xNllDzO73WRbo5pQjdZ6NP5+srBF6mFmBYSR8O8yTyNELbWaZrA==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b0f3e80-1f3e-4807-391d-08d879d32dc8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2020 17:18:38.7197 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MZ+3b6eB7jiXhW9iuSrhUqoaKn8BsK+Msz2y7KUG/wQ7oXyugEAvJuferY5Tjn04RtAAdTZ42DXFuSAw633vovSI7XVYt4mK4MV/zM6U/nc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3032
Received-SPF: pass client-ip=40.107.21.123;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 13:18:43
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If main job coroutine called job_yield (while some background process
is in progress), we should give it a chance to call job_pause_point().
It will be used in backup, when moved on async block-copy.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 job.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/job.c b/job.c
index 8fecf38960..50070ae6b1 100644
--- a/job.c
+++ b/job.c
@@ -578,6 +578,7 @@ void job_user_pause(Job *job, Error **errp)
     }
     job->user_paused = true;
     job_pause(job);
+    job_enter(job);
 }
 
 bool job_user_paused(Job *job)
-- 
2.21.3


