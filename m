Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8263BC2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:33:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 93B50208C7
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 15:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="GjDgqSNa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93B50208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54638 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb3jx-0002Tc-L1
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 10:33:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39286)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb3ic-0001Uz-0n; Fri, 06 Nov 2020 10:32:02 -0500
Received: from mail-eopbgr80139.outbound.protection.outlook.com
 ([40.107.8.139]:31761 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kb3iZ-0002jP-3v; Fri, 06 Nov 2020 10:32:01 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RO95oVq7yxe+ukXEUvP+nRMBtRMd3Uh6L73jT95h+rEzN+GKjhGISQ0m7FQZj5iOQYWbDTSihCE+8GuMBr2q+v28BtGLAQPGA6X0+gqni+Vn1QeL3Tw/y6FRDQvA0GBXiStRSHvZy0B4iD7dgIFfRBUEYBvWW62xaPc9lB7u0E3kmsIBm2miLEVzx6Dk4rNzvUnIqZnpfI6rTsDkFYzHp3sRX8LrTZF0vIeSmwNvMEtB18yZeynLctG+MGIx6o5ZzeHCOK6scB7/bqWQuuGVWL03rxTcQP7QWXLe+gRKGMDU2ugX5/XanIY+GsEjrxW7cyHk3hkOXMRPT0FeGh3cLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aerPxHYRm0dyE9+SxKUJ+HLsF8nfA6ZkHBVYRSRjmX8=;
 b=JzYInZN6tXO/Bsj+y9YNzp+tjGTFhv3DRB0qFXPxOjIzAbZk9SIcLrahLKxAVhL7GYHQc5ubA8ZEgxOE4h5Xoj1o0vfum1NCS3TueuslbRCUW/Y75jYsZAUiDAnq42vsPl59Pop4uKrUoxmuGPmMCy7Cckt0LBJx1SBCMUjBgL3qZgaCOoivS8F9f3k6seybFyk8u0L/tfc7YKiKA8U+FooEYVDTWigroL0AlCsSUcFrDlbxpQiQkTAU1xC1qZL4mum14Hg2bx9NSjF6X36b8C/BFKefsZNos0qAqPw+yPU0OA9owR84geQD1dFe9Mw1pjioWnAT2Q/Zvl20LitxCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aerPxHYRm0dyE9+SxKUJ+HLsF8nfA6ZkHBVYRSRjmX8=;
 b=GjDgqSNaTunT8qMdKMcoNf8Pmxvb7ZCGfPM9stgb/56zXEYVywLTQ2UFjATXC9JALv1BufxgHEvcqR9R9N5chRNG1XBfPecDfnpxHakZCikUBW6+4hGNspiQdBcz8z7qlS0yCEW3wnKemZg/2/v0wQ3OBWNviMar6vDKdjklVkI=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0801MB2009.eurprd08.prod.outlook.com (2603:10a6:3:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.19; Fri, 6 Nov
 2020 15:31:54 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3541.021; Fri, 6 Nov 2020
 15:31:54 +0000
Subject: Re: [PATCH 0/2] Increase amount of data for monitor to read
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, jcody@redhat.com, kwolf@redhat.com,
 mreitz@redhat.com, armbru@redhat.com, dgilbert@redhat.com,
 pbonzini@redhat.com, eblake@redhat.com, marcandre.lureau@redhat.com,
 den@openvz.org, vsementsov@virtuozzo.com
References: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <ae2bf3bb-db82-8c4a-481d-b31a33de93f9@virtuozzo.com>
Date: Fri, 6 Nov 2020 18:31:51 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1604666522-545580-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM4PR0501CA0061.eurprd05.prod.outlook.com
 (2603:10a6:200:68::29) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM4PR0501CA0061.eurprd05.prod.outlook.com (2603:10a6:200:68::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3541.21 via Frontend
 Transport; Fri, 6 Nov 2020 15:31:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 418ede85-d706-4b94-b151-08d8826916f6
X-MS-TrafficTypeDiagnostic: HE1PR0801MB2009:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0801MB2009F1AD211C03F9352FEBABF4ED0@HE1PR0801MB2009.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sQVwKuwXS0DgojKlQwSo5VWdF5FxL49Rq4pc/A8urcg8s4eOs/RYV+htxTTPCII5NTmBs/RUH3ZTi1QAjiWkXX+1ci4QEEP4jhQEEruX3U5Mshep6bjRhjik0B9cg6U5p4fepgYsOC3EblpROMEVA3bTqGN2CnJg+tA1Tx9CMp5dxZEemLvc4a7QfTdNpGCFua9TTZnvOodsw1DqfDpeL8+wrrMY5AsBTqLpuZrfMqRrQ37dKL0FeCVv/O/obVRvG5sbHosQdy82wUzzbDeOn6/L3CK0+5EMHpBIawzHpGB4pAP5zG0TITARZbfYco/Uv6GbIiVXrKNdE3FRzk3bE7dVb4aC2D7DRRrc+twpJ7h/pthOTIOgVgUOLr/jrv6ofREB0w3QW/QQWcraDzuRxo3wVAV/bBp7SnTZxJG0x/A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(376002)(346002)(186003)(7416002)(66476007)(6486002)(31686004)(2906002)(19618925003)(107886003)(4326008)(956004)(6512007)(66946007)(4270600006)(2616005)(5660300002)(6916009)(26005)(508600001)(8936002)(6506007)(36756003)(31696002)(8676002)(52116002)(16526019)(558084003)(44832011)(34490700003)(86362001)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: S1Vn6GGy6Bvasy5c09rozRzR6LLqVqjdHTawy1tTOlWNluhaQJOWiExpMYiYCsLs/xi6pIyAsdZSkjZjAvrZwr1qjJKfYct6b1hLhhQ9YXvyF2yS8u4gjg4BmhMy3NsOlVe5Qzd3W8LHm1Z6ZRjPpeDKGbFDZKV02LSFakfh369Y+HNVowIvY8j3Yiby8p3M2J4fwa3J/NDyzXot8XUcG0e0o7PXXmVD0nuPtl0ANJyUv2ZRZXAo80dymlYQhVR5JlYyvTMRMmBLWzvlNh2uWZ7BnUm6g7KEA+yWe9VpbzuzjIHd4L3ph/XTAuwxtBgNNUpIbUgMgA4GHCZ1VOlpjSM+sPnrmrkGf3L08rA8e0QOUMvcilSd/Ti/gO6g3lS/BEmuknTSkl2KPtp/FegAbyIdpNR4ktnH5vW+lfzDjsnXCnz8I2Bf1cg5eNOtzAZlRxV6CDSrq8MYNODG1EYTb2t8Gx7F0NE9bakihbBb+qjsojMkx5k6XKTscbanMV8Aabs/59lJRnj/NPRAmb98Idk8NrlPbNwhNAO+5vkN6eM/ij/ZY0qTzOaXgYErxMsVfGdkICSBh7Xt0nYnhGwMldsXRssA/50o72W+4LYrQ2Bh9ZEM2rUgFSUmzXgAR8vJbo2LqiBX5THYkS20OBo2Lw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 418ede85-d706-4b94-b151-08d8826916f6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 15:31:54.3167 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sY/8s9SZLlr93fZ2k874MuH7EAQfTvxlfMPVq7oqgvC8PcOvhxCHbPW+XDDde8QO9zuJeVteo21n7wEXR/a8LsPGzaDrRh7DNLxazNH5FGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0801MB2009
Received-SPF: pass client-ip=40.107.8.139;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/06 10:31:56
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Please exclude this address when reply:

jcody@redhat.com

Andrey

