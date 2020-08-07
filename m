Return-Path: <SRS0=Waq1=BR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A33C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:31:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E727F221E5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2020 06:31:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cMyB5D6k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E727F221E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3vui-00013V-3d
	for qemu-devel@archiver.kernel.org; Fri, 07 Aug 2020 02:31:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53030)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3vto-0000UL-6w; Fri, 07 Aug 2020 02:30:40 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:22770 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3vtl-00064H-6G; Fri, 07 Aug 2020 02:30:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQVX3G0NbhDNk4Cnvu9NVDR64fSucnmnHsYTMcKexXr0Sh6zFXT2bHWcUul31SrkmJ3ti9T4HfpDX5pO5+oURnVvQc3TsTDeVhjShwyRVmvKN1NXSU8+5Nm7y94hLveWe3923sQDBBB8f4tdfO7RjF+DtpnEcztBt4jCso6MDjWY9Z4upzKj0eFDz4X3l9GbcMmHDGJ33UO5AyqKOxSzKBnG+uJGp3F3W3usrDxb3wUYJdk63W3/UnKFulSXsDQAPHFnjiblOuZyHxm9UWkYQtkgYcOD2kDCO7DP+h8/mf77Ez7S5hz2J/m3dLnKzYhp2wASah9u9BQiPtEZTc973w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CrmKHJEg+NnLJne0IjBRnxWuz+ZeZWFQu5Mc4C/2rk=;
 b=mOhK458MEjnQqlYUDVrrc+8BcqmgYPYJjuC15f6dZy8/2Fi7H5BRqaomgS/ZLMf8TCgNiF+mkFSDNurvCkuW4C3HEHoNziRu1aONk949GA0hiKutSWn8k4ze+beULVhzfDlwRskEzAoFRqlVbtZqyZuQGwQncieKn0TSw+toDc3IdDx4yU93FIws6mv4p4+sysE7es7U/BcYv8RXnak+JJTA8JYPFxdOdI0imw8h7J5OFJONROgOOnvniDS3GuEX2CiIPICZPoixA0FqzAI6rV9xca+eSdi8GVbzwWLKhDFdpJiKsaIuRghupiNP8g98G3JRjgfRmrWnnV1CPBvTQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/CrmKHJEg+NnLJne0IjBRnxWuz+ZeZWFQu5Mc4C/2rk=;
 b=cMyB5D6ktSgTvVRDErMxVR0EiH0BRbFdEBcTAoVudw3RIQIiaqvZnfNBUzTW/AjSo17x889jpxPB5Lz8kRUOu/lFwQMjKSdHOCGfGaKUIJPPKgz9wYHHz0kN4AijHnibl7UVnygaC2kcxgdMTd7poJKaqV3Om5xlcc8Jrr3gr5s=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3861.eurprd08.prod.outlook.com (2603:10a6:20b:80::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Fri, 7 Aug
 2020 06:30:31 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.020; Fri, 7 Aug 2020
 06:30:31 +0000
Subject: Re: [PATCH v13 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596742557-320265-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <552171df-3015-4f88-48c9-0862bb0b8396@virtuozzo.com>
Date: Fri, 7 Aug 2020 09:30:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <1596742557-320265-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.177) by
 AM0PR07CA0008.eurprd07.prod.outlook.com (2603:10a6:208:ac::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3283.7 via Frontend Transport; Fri, 7 Aug 2020 06:30:30 +0000
X-Originating-IP: [185.215.60.177]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 608c8f1c-2e1f-4c49-7035-08d83a9b61b6
X-MS-TrafficTypeDiagnostic: AM6PR08MB3861:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB38615CFC9671E41805F30ADAC1490@AM6PR08MB3861.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XYw7LdCeXRwlKhx4V1vblx8P81O9f4+jgp2yVgCcl6KqxuyPwwrcgWAOAbCj8jriow0SQV/ZdWdO6NWtk59BIwlkjtxQqJUoj3GNmytM16uEq4WaPEcJAFGyXEU83VQoImXzhUAeYLF276jZ330qFEbGHCU8eQRrYV7tpVTSQAehIibjZ6q+EdDXgbiYkm1EskGCO/9Y2xyhS7IKAkv8XQdQXW6z7C+dSrPq9IKca0o69USsE4PURz1WVhSnj0+X8CuqwZ2v06o7IqSM5rWyDMsC+Goh2Sh+C98RxcSB96XZiEX3lRFF9UXUAtIOGHzA8YeoWy3a5K9ImoAAHCpSmKyZPLfs6VL2rSA/FV/t//Zo44x9FUqISgzOB8vZc7mH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(136003)(376002)(346002)(396003)(186003)(316002)(16576012)(8936002)(956004)(2616005)(2906002)(5660300002)(31686004)(16526019)(31696002)(4326008)(66556008)(86362001)(66476007)(66946007)(8676002)(4744005)(107886003)(478600001)(52116002)(36756003)(26005)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: V6/k469OWuQIQORzz+g9HYheTmXLEvtmykOgg1gGo5uOPveX7W0z8itvQZ61g806J9SCnEwqskQtVMYSgEM41Zehp4MDQvffJItAThuUI8QlRuDNURbaS7D2dfb6zuhZOiScm+4HhTlRTtstoKt3jU9gM66OqrMZhZ3eQP2nndodKBfnB+357TVEScdaMXk1dWVmnMi31HQK2H6L/DbeQEGRYozxmEO0OFWuFred+yxuNY9WOuTuY6lPsum4pvZ6ZIhYVRD6GzvxepyXcr6xwi0rOrBNF8P2Hpl8sRx8Yx8RZ23e3epyVzJbuOhGNvEeugq81Ym3dD31yLAV1P+nLuEqJZofdXHrBQuT8hNzZ0jFmSjhkiHD8lrdk+RT6e59NMYpwV+P2Ye2p6rKTnoa749lY9877Bw9PfDlRJZSyqekgwzwevSwkEh8VBMfGo6zUIC1m+5nUJfWshw5d9qinsET242nRwpC0B/ifrBPvh2AjQXogcCGkPZsV345yX9lDRvq1mYGPigtKuW7++8xfya8RBcZ6nztis/XPw6jIVLX2u/Mg3XYYA+c167pDL66emxjT8r2BTGeyj4Th5hPjbixfGmuh4mehHIDOliqq93VJEIP/83xrtVeqysvJ+YTYbW1qmDsdeyyxmgrfkBlGQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 608c8f1c-2e1f-4c49-7035-08d83a9b61b6
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2020 06:30:30.9630 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 60TJeUB6NMRGqzh7oVHLGF/0T+LMPsgqaN5sdpGAc02EEAF3mRX8OwxkWoEOm45l9kDRo4cC5HAy2+SPhDkOCKfevePwFLLdHVjpkrlh4g4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3861
Received-SPF: pass client-ip=40.107.20.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/07 02:30:33
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
Cc: kwolf@redhat.com, den@openvz.org, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.08.2020 22:35, Andrey Shinkevich wrote:
> As __dict__ is being extended with class members we do not want to
> print, add the to_dict() method to classes that returns a dictionary

to_json() ... that returns a json-dumpable object

> with desired fields and their values. Extend it in subclass when
> necessary to print the final dictionary in the JSON output which
> follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>

Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>


-- 
Best regards,
Vladimir

