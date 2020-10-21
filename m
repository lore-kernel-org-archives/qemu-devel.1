Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF32BC388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:31:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8E9E22249
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 14:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="MdORn/9u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8E9E22249
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVF8r-0002ms-Jo
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 10:31:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVF7D-0001Xd-H3; Wed, 21 Oct 2020 10:29:23 -0400
Received: from mail-vi1eur05on2131.outbound.protection.outlook.com
 ([40.107.21.131]:21572 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kVF79-0004Au-8G; Wed, 21 Oct 2020 10:29:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jgazGy/vbx7RklLR895KIG6T5+GKMF0+LBhQLoKIMsNIb/WFP0DQUW0pFZ52/ARWs9idw/+LejKAA0D/0oFb7BeNtmWlQZ237NkqjkuZWmnnYudLSp737bdDX2Im+jwIOE8npOQ2PYGEa6vpbWqyYGeOCSfJgdDRQ7FRnIXRu17+eVQbxNMamai3yf/DMOF1nJkNCBxDqzOQaOwBWQetGkRxgDDFjSamHhj65DsvdGIz/F0xhfIsDLR2g1AHQc0EbPOql7+bGxry2eggJSf7Shm2nE9RnHlLDFecb5TSaRAKARlJ/tDVsqky6zfXIhe0XRNbYZbb4BYWsDe8zre33w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSxMy0QQkruicsq0F46AKmQ93jiB23Lm58iI+UNuwHA=;
 b=I800dkfODIjArmj/oMi0wLT6Z8RjS5DI3M6MDcy/YYBI/pL8qawSNUEhi0u2tpBS3NW9tObiCEIoH/YtOVj12lqa+wn8R3TXMVZ/Z5vMw6HFkkpMXqZiZ/mB/tcLhtaDO1ejgtCZDro1hT4G41ly9YZYcya4Gw3MlMGFZTIYc6IQpDdoVQXR7wddPi9btrnP5OhMyqxJPTjrYJg/tRvG/9g2Dt1HoJCAhzq1zTOxbIwRSH9f+HOCC+st9f3U8WEkOFSH8Xgp4b5JC/x6xP+Rccm+VZ+71mKH+7LQ50l56jMhT1gk3Fc1ryJpfdXUdoUqIbiJBUMti3X60nR9GXc1GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSxMy0QQkruicsq0F46AKmQ93jiB23Lm58iI+UNuwHA=;
 b=MdORn/9ue9phRZygJkdYHEuCLh/JHiMoGhDDOmQxpJ48XZAuQTIQzr7342CKREwucrL1mZYgVE7z1SQfZhFjFf6FCD4H08qpq4qyii6NIzYS+T1Jk4dFrl8yFe+d4RlTtAcGjwSAZ6yXjJvmMm+JNYU4LxwFXRukJnr3edwgg+E=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB5256.eurprd08.prod.outlook.com (2603:10a6:20b:e7::32)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.22; Wed, 21 Oct
 2020 14:29:11 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::fd02:1330:f620:1243%9]) with mapi id 15.20.3499.018; Wed, 21 Oct 2020
 14:29:11 +0000
Subject: Re: [PATCH 1/5] pc-dimm: Drop @errp argument of pc_dimm_plug()
To: Greg Kurz <groug@kaod.org>, David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <160309727218.2739814.14722724927730985344.stgit@bahia.lan>
 <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <8c6888df-5169-16a1-bfe0-102e8aa57e12@virtuozzo.com>
Date: Wed, 21 Oct 2020 17:29:09 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.3
In-Reply-To: <160309728447.2739814.12831204841251148202.stgit@bahia.lan>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [185.215.60.82]
X-ClientProxiedBy: AM3PR03CA0070.eurprd03.prod.outlook.com
 (2603:10a6:207:5::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.82) by
 AM3PR03CA0070.eurprd03.prod.outlook.com (2603:10a6:207:5::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.18 via Frontend Transport; Wed, 21 Oct 2020 14:29:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6acd8e55-1608-435a-764d-08d875cdad3b
X-MS-TrafficTypeDiagnostic: AM6PR08MB5256:
X-Microsoft-Antispam-PRVS: <AM6PR08MB5256183EEFF2BE3B14789782C11C0@AM6PR08MB5256.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:849;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fay5CTqDRwkOfkirsdJ7FU2n1c9uLvo2DNfjBwfCWXvbtzsA7PTHHuVaJMulYfrmIcTX2CcGQqZdC8tz6jnN0fRqm8qgtlXlZo22tFx9pva3dIGz5mV1a89Ei05PZxvPnBIW/5L74zhSL4JPAi7DJp7WJbVrqXNohBDMZPEauROw7CTg8Iaec7NAeZ57w6zqHFDvylgF/MM2Gao6Wxk16gSfBkDkZ6Ned9LwUoZCVz6NZfm77Dyie1Bf/07bAS1yKRbBhvdwfMQNNqx3gH+HfWNx1SNSF1NkN4V7zu+7xc9nxASzGQOUvd6WLLM7astdV6O+te5tJixM0p/P/x7Ln5mCUEd2BvEtbTejePhLtH3FLHyIb8QDHLb25TJ4VTwj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(136003)(346002)(376002)(396003)(39840400004)(86362001)(186003)(52116002)(66946007)(8676002)(66556008)(54906003)(558084003)(26005)(31686004)(66476007)(36756003)(16526019)(478600001)(16576012)(8936002)(7416002)(2616005)(31696002)(6486002)(110136005)(316002)(2906002)(956004)(5660300002)(4326008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: UpVcs+D1bacKo9wE8zKgXSMLTlUZGlsMRK7rC/SrNUoQ8PalKu9ggR+nffrZMzfPJLtsf7zi2jLiwoET/zrKQ3FBwyMz48dajLGoNrgMX0xZC7DAQqfl1SVoTPcix+ENs9SR93JiFc2Ap7Ml2IOLLqekmwt6rdFJ+a7XgR7FpOuVPKb52bYg2nb8vyY+qHu+UHK0xrc/cb5GmrbbPPAJcxyX4B/KfrAlTL/E8UuttrfYmQaUEhW3pCn9BkaG6B9aj80sgHvvi03v/yJklxWy6mUhgTIgutGTIyjEZhHT1H8aVSYkxCd13qNZDGwBPKveHTR8VsqIQIOmz49V1897FHFER7FHA4YhMaMtE2sA0Gd4G39wzDBfoD7wWE806V9vyCfo7SntZuj5QjK+4fKOpKYpET7xhh259QLLKzE1Plyof5LzdFBM09t6VrEjvcR/mKbb8SlF0UsxOClZv21aaR8w9v7diXHISUb3hvxrYt5+Oxi2X/CjzlY1mJFMWxHo4dH9H4XY8Fc6c4NYqhs28lkPH2hQ4aYsdeQ/H6h8Zd+zqyuo9Knf9z8ECfJZLxONcS7WiRemsLLhKVF5br6bszIbH/onGT7IkUY5NxKQN3MJ9K/nc6S/vPQoxnH8D6EY6ebmo0gBeO8CAmEEIBMbGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acd8e55-1608-435a-764d-08d875cdad3b
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2020 14:29:11.6429 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xi6nSaAs8GHFq5f2sX4P9m/qU0vP4TOPFJsExMcYGC8PnfAYkBJsq26j0B33yNgqw6L7vstFJgyo1BeHWSuDx14zh3Zye9GKw6gvwZ3J5Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB5256
Received-SPF: pass client-ip=40.107.21.131;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 10:29:13
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

19.10.2020 11:48, Greg Kurz wrote:
> pc_dimm_plug() doesn't use it. It only aborts on error.
> 
> Drop @errp and adapt the callers accordingly.
> 
> Signed-off-by: Greg Kurz<groug@kaod.org>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

-- 
Best regards,
Vladimir

