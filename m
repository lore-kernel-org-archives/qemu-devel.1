Return-Path: <SRS0=H2wg=6F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57236C2BA19
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:34:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCCE2098B
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Apr 2020 08:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Tvxpl8hT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCCE2098B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53684 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQoM3-0008At-9T
	for qemu-devel@archiver.kernel.org; Tue, 21 Apr 2020 04:34:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52320)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoLK-0007h6-T3
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:33:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1jQoLJ-0001Jt-2c
 for qemu-devel@nongnu.org; Tue, 21 Apr 2020 04:33:21 -0400
Received: from mail-vi1eur05on2104.outbound.protection.outlook.com
 ([40.107.21.104]:62944 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jQoLI-0001IE-AW; Tue, 21 Apr 2020 04:33:20 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oK+vd1D0UT/HJS2MaZIvqYlN0TOmtjEc3zzdCFee22rIhbQatWkNLmQgBtJvlSLsEpuTk6jkCp/2/l4bfpCJAckFMM0pqbRhjFtPiyX9zP83Zszb8fTZIArEsTC+tWWUkoSsZrB2cTDz+K47lx7UfxT1NpCnYv8a0sUf6Ogi3QWpxw9COGA9PcTUHH4JEeCs+DAmg4lWH8tyhoQddQqTXbjMN7mDsr2m2B1aPYxsAPBYGsLLV/RxbCqiNvIDDxOMsXw9ZAk5j8+nkKGk/i3/XSJWQLoGBZ3brZBfNGLEGdnWCwk6GTApBIy+HXd+HEbZP5cx4aGaPiSfM92FHpYqVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTWtLrEj3TjxpqDcZ1VnOB8DU6nLs6hF0zqiDHbOOos=;
 b=AVVSBylCe+Dr9wG61rCqOmidB9A8VRbOvNmhD8XE5/FN+dkUOVh4lMWhMo/1lM5sdgx+94tMYnn8dS8FDrbNZRmHoITi14diEYy9In2Lp6rH8p9IhJZe9xKbX9L0aSEZTO0BEatkQcDfpC+q+3UXiVwy02xc3eG+hnCrDDrswHWqmy5fsJ4SokEjzvyUXFB7lptxKvjmdOcyM6p7u95xqp+GNJxNloZbJZ3EPf5GBCOQy3vKzT8o0eu+qBoBjCRewfTxPuEBcv3AQlK3/fS3p9p3yiwKRiUzM6VmgHaQzDyN4h6eGiXnaThWAEPyLSBpwl0PGNjo2lzs7asGqMjb5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jTWtLrEj3TjxpqDcZ1VnOB8DU6nLs6hF0zqiDHbOOos=;
 b=Tvxpl8hT/N5LqofPbZqa5nIyBitohdUtVEhIK1B6cam1yKTnpa3FwVJrDO1ltai29iq78iU/0i8dWaGmJpU2U2ANXcHMS0E+0Hmt/ijihfCUZ9P8aG1zv1hEIUn3sQfHg0DnGazwoaYwQZK0LzRayK4flriDuf+w+wiwPhURy6U=
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=vsementsov@virtuozzo.com; 
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5352.eurprd08.prod.outlook.com (2603:10a6:20b:10e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Tue, 21 Apr
 2020 08:33:15 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2921.027; Tue, 21 Apr 2020
 08:33:16 +0000
Subject: Re: [PATCH v4 3/9] block-backend: Add flags to blk_truncate()
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
References: <20200420133214.28921-1-kwolf@redhat.com>
 <20200420133214.28921-4-kwolf@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200421113314242
Message-ID: <9298bf40-c4f0-12f1-e766-c32f63cd3d04@virtuozzo.com>
Date: Tue, 21 Apr 2020 11:33:14 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <20200420133214.28921-4-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::27) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.142) by
 AM0PR10CA0047.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.25 via Frontend
 Transport; Tue, 21 Apr 2020 08:33:15 +0000
X-Tagtoolbar-Keys: D20200421113314242
X-Originating-IP: [185.215.60.142]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df461f1e-1800-439d-f6b5-08d7e5cea303
X-MS-TrafficTypeDiagnostic: AM7PR08MB5352:
X-Microsoft-Antispam-PRVS: <AM7PR08MB535244EB689DCF466C67447AC1D50@AM7PR08MB5352.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1284;
X-Forefront-PRVS: 038002787A
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(10019020)(4636009)(136003)(396003)(39840400004)(376002)(346002)(366004)(478600001)(66946007)(66556008)(66476007)(81156014)(2906002)(8936002)(36756003)(4744005)(52116002)(2616005)(86362001)(26005)(8676002)(956004)(16526019)(186003)(6486002)(31686004)(4326008)(16576012)(31696002)(316002)(5660300002);
 DIR:OUT; SFP:1102; 
Received-SPF: None (protection.outlook.com: virtuozzo.com does not designate
 permitted sender hosts)
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YX0ca2JclbJKyT5EBzq6rdqvywwpQlcKq/HIV0lFw1bYM54Crfose8dfcFFg82CejRTzQ5kyys/h1di6tCmvWoiRW81f2arZdylURuwWySHXIz98Z3EoYMS6DgIMTOhS50MwQtgN9aBn8vt3PLi9ohrRisyFOS+Gp6J6FqF6iClNvV1hJ5eO1iXJ6eTv6BsfWJ4Ui6TzRjDqkkV+/LrE6D7FYrW+AGCWFnhoZDlQnzg8VU2dkNBvAz7PNxOeKgXYmHY8lCXKj5mvFRFWDvamWvhMdbPRRILUNL8JRZvSHBwMC+l5ZRNC7rGZaWjbcBtsf33fZ9IaioiznX8dnEJXkX3knWN1oBYK72dHKmgnEhiP8uJgf+gTWnTpvPH+3xzF8B2dbkXkniGVsPwZ2AhhoyR2KFNCWCdsZ2Oz1U4E0IOPAcRIb1QtCuXZdGf8Lnk1
X-MS-Exchange-AntiSpam-MessageData: lSfE8xZzo8PLyMw3VymBeUBRU3xKE+taMfH4EhpQB5K39DDJHDkXJqj/OrIiv2JKxnarFuaK3vTrEeVO4yNT4x9bkmlK8W8cOHnHLAh6jBu5qcOvWgJ1D026I0wow+mBgS0oqOAEwSb5L29oUD9J8Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df461f1e-1800-439d-f6b5-08d7e5cea303
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Apr 2020 08:33:15.8926 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vj3K57o1SWsqr3yazhNtuEIxW/OSL6g3PxpiYmZsl53PxBVijh2CHlj+XckU37OWHXryr5UNyUeb1H8wzBofbYRikKh6+wimtBhluQy7uck=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5352
Received-SPF: pass client-ip=40.107.21.104;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/21 04:33:17
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Received-From: 40.107.21.104
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
Cc: berto@igalia.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

20.04.2020 16:32, Kevin Wolf wrote:
> Now that node level interface bdrv_truncate() supports passing request
> flags to the block driver, expose this on the BlockBackend level, too.
> 
> Signed-off-by: Kevin Wolf<kwolf@redhat.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

