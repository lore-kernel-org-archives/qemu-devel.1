Return-Path: <SRS0=/TnL=AT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F29EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:21:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A6DC206E9
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2020 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="PBq5x3Lm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A6DC206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtDlY-0002of-D5
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 13:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDkP-0001Fq-GN; Wed, 08 Jul 2020 13:20:41 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com
 ([40.107.22.126]:24768 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jtDkM-0004Vd-1g; Wed, 08 Jul 2020 13:20:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hZCkhwI3DzXsRUvLL9/PF9fUrdhK6emeRFBzIza6MJhKJulSe9ZhuvmNPJp7LCUNoboiiE1XqLR2eJqjciT7mYjLjs8agk0a5ltQEW1ffTpZXI1aSAbB8nCe5NNoFr16XNnttm2cpJnQ+HQXxoisT1VXZHJ59beHf8JhJasTwPfp0acjlvCX/V7ccBuWW22C+k1Zeeu1vaenbucvwCw0NpR9PqBww1ph9Ejxe98I1oKuqZUQiwpVPocESVO5XWWtEOQD2r4Bhk7v+ErslBqmYbU19JZclhMtoVksSBYEPeetJbuyrIZsVz2dErlmVDIndkaV9JxAjFKnETTp35uLtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj0ndY2Alr3KuWONawU4xQviLgazx1jB7pnPTLpGD4U=;
 b=FkOyxI59Ord/khXwcJxLW+Z6D1TAkT91T0H+jlxcBpWD5ypTpc4sv1wZ9y6uAcgqdqk/3TkTjmV0kzjfobAmjamn0EWc38xUSb7N823vbTTGFEqOlK5obxALIwjy1uSmomyoBOOimhRB5cASzptSfLQ4x6dfjzDjEmkO2zwGhhMIEF6EWy/twoOCP/T0lPVoRboNqBjnzhYCP4ATeZWuumwbYraIFRdKh9z4DGFuyb0W7sm4gqSVvLu040UWaFrIBg7j5Q9eE2x0VNbtAKHlkHl++kRHWko1uS9mUnT80xdlAvccftT9GfRWThjs1NBY847iWG16iNR+JW4tfyoynQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jj0ndY2Alr3KuWONawU4xQviLgazx1jB7pnPTLpGD4U=;
 b=PBq5x3LmTOmoIFFCjmKha13zxKp4pQ9vyOJo3Ux78KD22lvOXGo2CJQEMt9tF4nGegdFEoyRmEtYJTLkZ0oBSnsMOkOptveHI8NZ3+XKMoxs5/wexoLAFUle6n/l5EK7CR+Jko+V8p/XnBNPkIEsC1OXWqstzPVovCb1hySC6yo=
Authentication-Results: nongnu.org; dkim=none (message not signed)
 header.d=none;nongnu.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4215.eurprd08.prod.outlook.com (2603:10a6:20b:90::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3153.23; Wed, 8 Jul
 2020 17:20:32 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.021; Wed, 8 Jul 2020
 17:20:32 +0000
Subject: Re: [PATCH v7 00/47] block: Deal with filters
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
References: <20200625152215.941773-1-mreitz@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <4d7fa326-ef87-5753-cc2a-bb26fc555864@virtuozzo.com>
Date: Wed, 8 Jul 2020 20:20:28 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <20200625152215.941773-1-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR04CA0041.eurprd04.prod.outlook.com
 (2603:10a6:208:1::18) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR04CA0041.eurprd04.prod.outlook.com (2603:10a6:208:1::18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3174.20 via Frontend Transport; Wed, 8 Jul 2020 17:20:31 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 11f3ab27-a80f-478f-cca4-08d823633830
X-MS-TrafficTypeDiagnostic: AM6PR08MB4215:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42150CE0A2A8BEEF7710943FF4670@AM6PR08MB4215.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:186;
X-Forefront-PRVS: 04583CED1A
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7PcqiU1HOkrZf5abcrYjpzCo6+aXM6+NKHzoD9+Uq8p9aasFmM6q+FXocS3nDjqYn+X0RgXIQmVo2zy0CQEr9m0/RMFv00Fxx7QXfudMaSGJgdCfrBVagTFBkKjmwc2pTx6tdg30xxhbLdcw5bw5VIHimUOwzoaIBNMIpIYGR9ryEGxCyj4qNS+YGs7520IK8BonLOT2t9Oj9Td7p8vTkEQACI2qxkb25EkI47YDgd3t3Yo4e/gjgZY+Ad7J9PJwvd1sso3elmnhMm6iV0mlUTNwGsNeOzMILGCVJP+A2PCXnPJMcSolaBTy9GONFZ/AmS093KE6XwNVywbbSrrfqfGIj9HqOjQsQnV6y6h8y2FdTAPe6FSa0nsuDDukJoPaOLkpa3/kTQAAMbhiI2yCHrijDJD+Gieu6y4gDM0OXLqzoy73jPI3s0HmDmx2pmIcf7kzIC+8UOtUEkAOmM+cIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(136003)(346002)(366004)(39840400004)(376002)(478600001)(53546011)(966005)(6506007)(83380400001)(5660300002)(186003)(8676002)(16526019)(2906002)(31686004)(8936002)(4744005)(26005)(36756003)(31696002)(86362001)(44832011)(6486002)(2616005)(956004)(6666004)(52116002)(54906003)(66476007)(4326008)(66556008)(316002)(6512007)(66946007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: L9XDi7sHGEEkCMFReCz+jrZRuyykpEv95Kp2kPdbhI5/Y+dSyfJ66GifFzi0Dxu6wGJLKj8bgPEOK3M2BCxnsVvCtYxo1YztUW8Q3cJcBnHEBXtmOb+fjAKku+khDJsKUskwbBJmIG2HUsHx+mkXs4K3APcfdYTboanjSBAgisdLPW3qvoCl61b0m3B8UqnVCX4Mzg6g/GpcDyU0hJ9ahbfrlSb2suR0I8Wqzb2wkvz2Lrg9wsffaEP65bDqIvW/+rs/3OUzwcgGrCttAOl1mWU5Hztqjsr5m+AfSXfcXoGh6+g7uNM+F2THNV0THdcYtfWaztRsTV70GIPA00Jv4u8n0cO5Zt4dCucf3JP1PhxcfguDW1epWOqHeq7Y9JerTIT7EkeYk3ORu0TOrQJakNr54e2uZFD79FOIKU5/yqdAN5IdPr5PYEC6GYDZEg+/bqV5kv5HuR451loho+lzsbuPgzNyWuC+yGx5i5AJM3ghviuXjMMBIKZ6CG7z3eP3
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11f3ab27-a80f-478f-cca4-08d823633830
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2020 17:20:32.6260 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fOLLyZHN87+AFPlZiuvYEnljh9yyqYq2rCABd/CKUtv2EEw8pmXe8wXFsT/a2dtqnyDvZ3/o1DkUQjIBPKqQBQQiEEYXOQJ9H9Ge7LQPC80=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4215
Received-SPF: pass client-ip=40.107.22.126;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/08 13:20:34
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 25.06.2020 18:21, Max Reitz wrote:
> v6: https://lists.nongnu.org/archive/html/qemu-devel/2019-08/msg01715.html
>
> Branch: https://github.com/XanClic/qemu.git child-access-functions-v7
> Branch: https://git.xanclic.moe/XanClic/qemu.git child-access-functions-v7
>
>
I cloned the branch from the github and built successfully.

Running the iotests reports multiple errors of such a kind:

128: readarray -td '' formatting_line < <(sed -e 's/, fmt=/\x0/')

"./common.filter: line 128: readarray: -d: invalid option"

introduced with the commit

a7399eb iotests: Make _filter_img_create more active


Andrey


