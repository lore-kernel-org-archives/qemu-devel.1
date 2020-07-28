Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DB03C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:06:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2550E2065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 14:06:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="QRNiZNAd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2550E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56206 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0QF1-0001mu-9J
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 10:06:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52322)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0QEG-0001Bd-4P; Tue, 28 Jul 2020 10:05:16 -0400
Received: from mail-eopbgr80107.outbound.protection.outlook.com
 ([40.107.8.107]:34183 helo=EUR04-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0QED-000623-5h; Tue, 28 Jul 2020 10:05:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i9WE0EWfzb0ta5YIHN6thYXCuvLzFgzVpwUTKw89NCnB5XltDCukIX2gP4WPFPOb5UGApaAtkf5vxY36R19OzJ2ryLEEZU6tBzFu+PfDw8vNlyT5gaVpQRR3/KT1I6TX+MUOfaAN0mUxQz2jumEc8mIlYSkoq107CWRzfLl66GcfBo7/dE8pIDNsay+O/n3TQFQngcqTHPGsZ7SqiasnIjENRBr96pcOYxGhIJ6IoNakjfH7wCsmNPctQj/c1LGPFekClh2SqBv+EQGtd6PbP1o9A/llPZ6DXFujFzEmJ9o2O9oSblJkcakRedoXmnpesh1TugKO5qPdwtj/+V+zQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQXQD+UC1UHHZQS6dUrTljqE53m11OchRfdJCxQfI0w=;
 b=adcKrgq0hbthe657Inbnn57a1fUvHVQwBJUZpnzFvojaFxlBLWDH+nmHX9XMyqMSUeE8YRwYFRLKVjAQTZHgrYv8Vb9vQUvwKq6B5jXA1DHLuEQl6xFV070J2+ByWiTg72X/UafrlkAHaviWL3KyK5uXql70l8l/e8YLwnEfTtEFwl2jbLOphn1ZT/ogD2ZdKtnTURO/GSbaMtg1lH09LvIwdG60BO3epK/jm4ly3BLfqHI4Gn/WCiByzs2FliZHIlHxwDgsXslKtjcws10mPOwShxnPhd/TUH61nOn1kBWXOqxGFEMAFERiEjEGixNT5r0rO0yBEdgqczahuzJ9PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dQXQD+UC1UHHZQS6dUrTljqE53m11OchRfdJCxQfI0w=;
 b=QRNiZNAdF3lDIhGGADyd86qRoUbZKlDm5TjSwQWamjsd7462lF6zUtmbfAV1jQx3laXRM398twHQ6CyXdCOkk/5M1fQKCaF7hPMurBao65bGY4Mal/7mGGgT/K3dsMxsJ0PUIGRNAXP5LWov6NXj/bpxwtuveIb4IWfhyTrAs1U=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3381.eurprd08.prod.outlook.com (2603:10a6:20b:43::26)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.23; Tue, 28 Jul
 2020 14:05:09 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 14:05:09 +0000
Subject: Re: [PATCH v11 10/11] qcow2_format.py: introduce
 Qcow2HeaderExtensionsDoc class
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-11-git-send-email-andrey.shinkevich@virtuozzo.com>
 <db73d013-832d-234c-7828-80d8b1ed962e@virtuozzo.com>
 <d2752450-0c26-a40e-3dc8-e095e7009919@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1f85fa4c-97d3-8514-cbe5-f1cab1438eb5@virtuozzo.com>
Date: Tue, 28 Jul 2020 17:05:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <d2752450-0c26-a40e-3dc8-e095e7009919@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR07CA0113.eurprd07.prod.outlook.com
 (2603:10a6:207:7::23) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM3PR07CA0113.eurprd07.prod.outlook.com (2603:10a6:207:7::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.10 via Frontend Transport; Tue, 28 Jul 2020 14:05:08 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74a45056-7954-4797-2b1c-08d832ff3cee
X-MS-TrafficTypeDiagnostic: AM6PR08MB3381:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB33816C391004DD3C9E14FEE5C1730@AM6PR08MB3381.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OwjnTGSyZKAN8iDHX/vmIQc8I1AOsCi6JL0EWUCDJvQv+R3vndsRNpRRblz8jSjh+aHQTWZwVZhvprw0PmGmDKhroJNfMZnMQPBSY7WlFX6Dbj4AStNonSYu0Jy6MjAi+3SQnrIFOw84cKDL4F6Si8rdki29wzeR6bDM9cTL5MHpoKu8AbF6W/eoqmxuETpjlWpuxWrLoRlj+6SZZNyOroU3i5+q838x7p7zYqx2Izs/asC0/RyeqncKpddd2Ejl5Da633X+QWYm2+Fmm8CF4Xj8A1JTih98rz5lnmuqUlTGel2afh1FmD0Zk08sA/FLNvPNgyXRuNup3ZkqllLKWm5Dlj5Ne0rpQfrBTTOf8xxBAekB6xCRpsK7NMDaREr9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39850400004)(366004)(376002)(346002)(136003)(396003)(53546011)(66556008)(86362001)(5660300002)(16576012)(66476007)(478600001)(31686004)(52116002)(956004)(36756003)(2616005)(4326008)(6486002)(19627235002)(26005)(316002)(66946007)(16526019)(8936002)(107886003)(186003)(31696002)(2906002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: qmVDfRa+TuBhDddWRllI8dXEbqBr0g5WtG5s5Vo8HlObcO4+Ved+ugixP+sXlQ0GAhGLip/Cc0hIxbBq+LFsUxRS2FMZ2sfDtz2TY4HZtWBxR62LDZ15NQCH82VZ7LfOYxHoeqMYOj3tY7H1HkVC4df2g4qTgkeEt98Kt9TeUMrJlPl4+37/a+wyHSL4lP3gU97fvQEIKtB555TnUe04/ONyIq6h1OFu6j8G7uKKdqIJSk51qNX1DZfJW1V/19X0emll5jkXug/M/r5H5GSQdEK0QexQSrN5EQtcViH0XeARVq1L9fFNr3dg5Tn+/CNt9hhx9Rt+m9m3Zg+4dOSxpbB9b0ZtmbzPF4Ti75JDsPCdbrDaRlc6X6ka3T4v0FmtKU5C8AIca6IXE8GSEGb+7eje7tsHRldSOzOrMZBJsvU8lykI+pdtvSehyx3Af3BlXxlfNlbj9MYze8MttYXjGuFt4rJrPs+Zi681Vr/FfttIrjwZTxhfCkz1s7Rsn9HH
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74a45056-7954-4797-2b1c-08d832ff3cee
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 14:05:09.5127 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9WMKRiqF5l351rWwnDS397/K9ricu3yRfIXkix48wYB9v0F4Hy1k+aSpD/PTv+eYR7a12+BrmzEfnIte09guawphchqQ/pHCp7gAF4/WOe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3381
Received-SPF: pass client-ip=40.107.8.107;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR04-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 10:05:10
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

28.07.2020 16:27, Andrey Shinkevich wrote:
> On 28.07.2020 14:36, Vladimir Sementsov-Ogievskiy wrote:
>> 17.07.2020 11:14, Andrey Shinkevich wrote:
>>> Per original script design, QcowHeader class may dump the QCOW2 header
>>> info separately from the QCOW2 extensions info. To implement the
>>> to_dict() method for dumping extensions, let us introduce the class
>>> Qcow2HeaderExtensionsDoc.
>>
>> I think, when dumping to qcow2, no needs to omit extensions, let's just always dump them.
>>
> 
> Do you like to eliminate the command 'dump-header-exts' and the relevant handler 'cmd_dump_header_exts' from the script qcow2.py ?
> 

No, what already works should work of course. But we can not support -j for them. Still, not problem to support it. I just don't like this patch with an extra class. See my later comment, we can easily support json without this class.

> 
> 
>>>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2_format.py | 9 +++++++++
>>>   1 file changed, 9 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index 19d29b8..d2a8659 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
>>> @@ -248,6 +248,15 @@ class Qcow2BitmapTable:
>>>           return dict(entries=self.entries)
>>>     +class Qcow2HeaderExtensionsDoc:
>>> +
>>> +    def __init__(self, extensions):
>>> +        self.extensions = extensions
>>> +
>>> +    def to_dict(self):
>>> +        return dict(Header_extensions=self.extensions)
>>
>> s/H/h/
>>
>>> +
>>> +
>>>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>>
>>
>>
>>


-- 
Best regards,
Vladimir

