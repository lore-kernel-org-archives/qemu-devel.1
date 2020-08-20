Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 930E6C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:12:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F81220724
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 14:12:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hi5Vyk14"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F81220724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8lIs-0006bP-Mu
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 10:12:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8lIB-000636-45; Thu, 20 Aug 2020 10:11:47 -0400
Received: from mail-eopbgr140114.outbound.protection.outlook.com
 ([40.107.14.114]:33024 helo=EUR01-VE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1k8lI8-0007ax-FV; Thu, 20 Aug 2020 10:11:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkLFKpYB0SdhMmMqkbsJkES0HOkZgEFYzD3DsL0iViadgDni9CGWfGmV5z6gMjEKUGScs3Fnl/eZinDiIy6SVjb2jmb5W729PxX6eqYqyoqYVQTkNYtsdZd29H5ciRvQ8UnfFSfciprlvb3R1fn6erNh33+P2fy1Wbi6BcpTY1bBn194B3vyE6EP0L6OvegbW9dNSFZQKjpdGMxSUajBvuU7RMR9k/3dDnBPwb55MUlZ9sCxOy2HlADT0LgL+9YN0CmWXwVUoMpoZeX9jKAGIvcgTetFtVLH1znRXbDHKcaLCs4WYui6o7M8uCx5YSGAxr26T5ZsPl6ImndgNDg7hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmcRLkITdEcUQTRBcvSBnz/nkBN4GmFtCstXXnU3F38=;
 b=Ig+gg0XV+JcnuUDDQb+iVP8lPIrXyHJUUvlrF/Jq8jkwXi57TvchzpMoogT+u6UsQJDv+dlPWT10is83Ub1s67nzJhBxBXtWgddqs8Wwv+ZmYBu3+UBYHgjoiDPXzDjgssWSR4Zz7NDn97j3AN7iGsqJaZvw2lJYaO+QSa7oxUgNQctwH4CHTKi+ulC06P0ZRY/arUtzKl7h/7MoVDnhmGoj7qOVfh99vKZz11ICdnjlE82UDuJ0GY8UQHLCVdIa4iI7OGm+mX2WPMzAFeUskBtSua8XYS0FAbZ6G4BqbXk2A2DkgLrBD/XyaRvZTD/TGIHYu0pEPERqy5fSVZNoxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmcRLkITdEcUQTRBcvSBnz/nkBN4GmFtCstXXnU3F38=;
 b=hi5Vyk14rxxSdmonrcKyiGKfE9PjAmOgiQaQHQB2OzSLpmK4kUhblRpCBUki7VK4jb8U7NaivXBIQcPLApc5lDh12kXsjVfkkeuj9wx8LCxB7bJb8o+CJzkTbl+QKwNsE5SxIv9imAFfSLTNktVQaATkdFQrlrNCYZmohJzU7os=
Authentication-Results: virtuozzo.com; dkim=none (message not signed)
 header.d=none;virtuozzo.com; dmarc=none action=none
 header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR08MB2857.eurprd08.prod.outlook.com (2603:10a6:7:2e::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3283.18; Thu, 20 Aug
 2020 14:11:33 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::b5e5:e4d:ed88:5a3a%9]) with mapi id 15.20.3283.028; Thu, 20 Aug 2020
 14:11:32 +0000
Subject: Re: [PATCH v13 00/11] iotests: Dump QCOW2 dirty bitmaps metadata
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <1596742557-320265-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <8c84c4ca-f0e5-b973-d508-e13dd0ebaa74@virtuozzo.com>
 <1e6c7531-79a2-5ccc-daf2-a4a60f69468e@redhat.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <1394993f-77b7-ef69-17f4-cf5014999d18@virtuozzo.com>
Date: Thu, 20 Aug 2020 17:11:29 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <1e6c7531-79a2-5ccc-daf2-a4a60f69468e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR10CA0109.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::26) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (176.59.52.207) by
 AM0PR10CA0109.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Thu, 20 Aug 2020 14:11:31 +0000
X-Originating-IP: [176.59.52.207]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc89ff77-95f4-49ce-2d12-08d84512f0c6
X-MS-TrafficTypeDiagnostic: HE1PR08MB2857:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR08MB2857FEF7CE37A8EFD8C92E08F45A0@HE1PR08MB2857.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6I7YsCmWDnolfCjFHw8QceaYSVDh/yMHFR1KLyMipHLXEuownMA3VVLsD1YssXpLnx/8o3fbE61+sanhzfsz8huJItAt2mNwf/9GCqkeFqoLXe7ZzxhTnFVzgezMMmtR/H2SkaDXOmHPh3hv74WeWDYsEOlSAMfZeUnqMIgnAl7m8uKowanXw3EMJvyUgBK3shjWXQv6zJjnoa2EY7bAY+cxtefU+sK6r958w5HFyyPe+2+7wWvpP3AQfdmFqZWChPOAQv7v+gTClcXeaed6yyn26HZQWDWP+IGV0fVYkY9qL1C91pV52oVFk+aXehMWW8APiJ8eEr0uEWyL4SlYOYsMilDK6XG5jR6wsFwmWWQZq0Z+rwDhsqNOPLPZF0drsmeaZGOBv83mXOJb3z6X4w==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(366004)(376002)(396003)(39840400004)(136003)(186003)(31686004)(66946007)(8676002)(5660300002)(66476007)(4744005)(2906002)(66556008)(16526019)(316002)(44832011)(8936002)(53546011)(6512007)(6506007)(31696002)(26005)(478600001)(6486002)(2616005)(956004)(83380400001)(52116002)(36756003)(86362001)(4326008)(107886003)(14143004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 1xonlQVL1cEiydJ6qV5+tpjjD4Eewbin3nuWP3p7ez4dBok41zeEb0ogc3zK+XZ8JOMxxbgSK9ZXRx0rBYw4AcD1DEz30IPETQgSyrAzhdlpg87xSMayZ99Y5bFT+0B4ui0ezOEdS47pUOcWhNVDKe1+ZjzDIWTBz4cRk+hB1M80JAoPN7fdU+oQVoDsxM9Yg+fPtj6u51rWzAAed5puzKOlwF0tBUDS6FD8HIrJz2nz08eCavLf3pDq6U/4uJ7PSEVL1Azvq1I4l6NOxeMvwoD40Idp3LSAoovviqN2BrE4LKnYGanAhvpSkWELxnuPm8MDbzyO+NyxuTieI1XIYGC1Lp7yJzTtsOFedx5RAVXj3BS55/sL35dKYNYcBszZ0dKoHzqc+hhEVpLcakWWkuDLT8ZMUoBf2SYTs+j9IiEgcEMfMCfinEN9K+di/iTzsjmUHmRNJWPF0eEH5JDhp7pY4bqv1dFy+pPRYYnto02aARAh+eACk/nbH/2LaR+dVG491b4xfRcOpHbHzolDkgCkULprhdLBAsuN2RaPeN/uhzECEJCb37Ow2gju2aV8MXtd2wbUxAlsR1dspN6KKBXhVqgbU77N6eLk87FcNe2biSFoMqCUE1pvQB44CijydqtiK1x2mFKYu6r2Gf6B/Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc89ff77-95f4-49ce-2d12-08d84512f0c6
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 14:11:32.6801 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JoXhEduiuI7UIl1h3sD64Ad9/iVRzxp4th1Ahhmm3cRV3EkEIafsR58inpGSY4cg32p3Yn7964qAPN+vFcODaBQ8mesc4BD0JdrWh85uk8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR08MB2857
Received-SPF: pass client-ip=40.107.14.114;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR01-VE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 10:11:40
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
Cc: kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 20.08.2020 03:49, Eric Blake wrote:
> On 8/14/20 6:56 AM, Andrey Shinkevich wrote:
>> Dear Eric!
>>
>> Vladimir has compeated reviewing this series. I have not received any 
>> other responses to it so far.
>>
>> So, is it good for pull request now? Would you please consider taking 
>> this series as you did it with the Vladimir's related one?
>
> I've spent some time playing with this; I have now queued it on my 
> bitmaps tree, and will be posting a pull request as soon as Paolo's 
> meson changes settle.  I also made the tweaks suggested on 9/11.
>

Sounds good, thank you so much, Eric. I appreciate.

Andrey


