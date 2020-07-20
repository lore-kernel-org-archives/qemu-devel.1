Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F065DC433EC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9F962073A
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 16:48:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="Vs0iJWKd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9F962073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35690 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxYxc-0003rG-3O
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 12:48:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40684)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxYwL-0002fR-P6; Mon, 20 Jul 2020 12:46:57 -0400
Received: from mail-eopbgr50138.outbound.protection.outlook.com
 ([40.107.5.138]:13124 helo=EUR03-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jxYwI-0007eb-Jf; Mon, 20 Jul 2020 12:46:57 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gqfra0qmt1Nl+u7w2gEnV3eteh4rAw8jDeO0/DkAXnZ+hcV4wmUNxtquS5ncge7qf3k6gHWZuExvzeurWFusRadPWmudNLOnghxqkP1LwObuVNfaSFjtkY+HA8C/qO4IMWCpoX0F2n214UZ/gUYjsHGm6TdQZDQg57kt5uBW6rWtvQjOzJm8Td77du38DA0S0NMe5GrlD+b8wUnUOiWFoMs80q+R3iR9VApijJkWzbgcoF7zMvXcMzGT6CGwfjxj0gA8MqsXIcWCmZOTCNmG/YgPfMdMRyWu8h3W2rY2I/Lx/wRnWgO8cpsVmDv1O9BYC5+WZ2wQznPfQfDecMSGlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UCSAroXleYSOJ9D+fIFind4FW7y8dGodEh7HLi+onY=;
 b=XrPmk3sI3CtcSsw7dTCcvYYiZWz26JOUWm++WfRx5t2SgV3RqebnYvTuL6JM/r037vJoo76t0713nVIJ/Yh/ovzVPlqMWTEzSTtHOsseC/CGOeSnnOv5DXZvjf84UOq7Am9c0JswLqimzOMyBrr8BEjeyOOx1I0LG4ex5EfjtjjcUU3QRk1BBY9bSx5bO/iej9zRWaTqfg361mTnwNmRJkjrV/OeC0RAvnhaOv/1YfuakAojpluGFkH842b0zMXpyXVlq0h49hvc8CXLdO85sGhb7uvVB7Da9cY7Xvjyzz36zl9veAF+nELwvSlIwYhfGHAwxx11dFK7pNnGSU8DZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1UCSAroXleYSOJ9D+fIFind4FW7y8dGodEh7HLi+onY=;
 b=Vs0iJWKdUt2P++5h2lMtKFDu6R4aBWbFJstI1sh5auymygS86HKBuVw8VHz4Lnkfv5mWz8Z+6bGvN8nYxTGAAJqYIbFY3oDIr+mn+SY5N8xvvBX8+Mw2FbMySe9+I3I14yY86ay2vQ4K+60ZbXR7SyGlEtGD1O3+op+q4/1HS5s=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.23; Mon, 20 Jul
 2020 16:46:50 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3195.025; Mon, 20 Jul 2020
 16:46:50 +0000
Subject: Re: [PATCH v2 2/3] iotests.py: Add wait_for_runstate()
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200716135303.319502-1-mreitz@redhat.com>
 <20200716135303.319502-3-mreitz@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e018b44e-2597-5cca-79af-272df950e1d7@virtuozzo.com>
Date: Mon, 20 Jul 2020 19:46:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <20200716135303.319502-3-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0032.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::45) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.171) by
 AM0PR07CA0032.eurprd07.prod.outlook.com (2603:10a6:208:ac::45) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.17 via Frontend Transport; Mon, 20 Jul 2020 16:46:49 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9284b5c2-f4d0-4d03-8029-08d82ccc7fc8
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-Microsoft-Antispam-PRVS: <AM5PR0801MB16527960D8668AFB8BED1850C17B0@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:281;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUsH08FuLN1uHP9DdaXsBlE6hV21AnEY/cJovc/hJZYCDIBKshcXkJtUs8tqva7MJqTnePpSJ64ZdwwwvqKyYbAHlJ1jktQIwMmmruDiObPC1fTvPsiee8DterXGGrup5D6dMs+VaP3bbSQH2mCwCyQkqpaifgn2trMI7+g5uKgGGStNbEwGytyemUHpqmmkmcGxO6rp7Ti8Xoh/xBQcRUs15id75Y+ckQlVuzVOz3F+X8iljnMOrnZsamDK1mrC3C2pmv5VEX6F4na8XZJSYVT2MyRFOPd6A/rhpHDWbgBNNlgL4wMtF8jyG97kBe0qh1LBXKaaLMIBoK0yi4qZC8TNGTWDSZJlOMeI8nqApMd9dcmdYfv3QgBPLAJQ7Ysm
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(396003)(376002)(346002)(366004)(39840400004)(86362001)(478600001)(54906003)(186003)(16526019)(2906002)(16576012)(66556008)(66476007)(8676002)(66946007)(4744005)(52116002)(316002)(8936002)(4326008)(6486002)(26005)(5660300002)(31686004)(31696002)(956004)(2616005)(36756003)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8sY/dTa5+Mc1ZqoiSdvGtqkd2uQrHZklmSxf2GNjHGjlhH2CMMqzilULd/1AyVa03EP98N6HdDI5XYB/SrAgIETZxsKgL6ox9GptEqrq5RPnjayQsXm31SKZt6GShY7gr4RSiqKe02oeAyobYU0ElUq3dZ6AO4RcZCCE5BqpGkZLURLpk6MdySnPsnAgtfnu9Pn7OnSdTC7YgUx0J68wNXYD9l9l9ln6fo28SrHZ/l8wQ+IaW+2kbSwftvWSJNYMOiKcsqrWOziyyRh8WllnsgEN6ijba56wR74Hi77xtHIpbXjKC1qQ5B156Ud3UUxLH4QADi4LY4/EPu5PT/4i8L3W+5c501GTTrbElwT80CtG6nlZM7zNFhUvezDc7PeURv2m2j0Jnwjc/uZVlhsWr436eR4T1VEUd//g0CZutk89AMSr5yH00MzfFOUvLxvqlnCQ5xvqaSbIybPoudwMNLejABgh6pR7CZNn3mUY5rh8OajyvXSEOFJSD9cd/Ft0
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9284b5c2-f4d0-4d03-8029-08d82ccc7fc8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2020 16:46:50.3165 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1tXymhE7S7Lt/rtOI5GM22LkolTWE+jxZc1iCYhSaeSJPFMxtmtQd32AcAYn46jK4KIJ4WeIg28TrNRKxcSIebpktvumOWYwOjHP1+1+VnY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.5.138;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/20 12:46:51
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

16.07.2020 16:53, Max Reitz wrote:
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>   tests/qemu-iotests/iotests.py | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.py
> index 3590ed78a0..fb240a334c 100644
> --- a/tests/qemu-iotests/iotests.py
> +++ b/tests/qemu-iotests/iotests.py
> @@ -803,6 +803,10 @@ class VM(qtest.QEMUQtestMachine):
>                      'Found node %s under %s (but expected %s)' % \
>                      (node['name'], path, expected_node)
>   
> +    def wait_for_runstate(self, runstate: str) -> None:
> +        while self.qmp('query-status')['return']['status'] != runstate:
> +            pass

don't we need something like time.sleep(0.5) instead of just pass?

Anyway:
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

> +
>   index_re = re.compile(r'([^\[]+)\[([^\]]+)\]')
>   
>   class QMPTestCase(unittest.TestCase):
> 


-- 
Best regards,
Vladimir

