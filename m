Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7923C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 04:50:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 732032065F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 04:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="X4yCDCTH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 732032065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juqQD-00053Y-MS
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 00:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59830)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juqPT-0004bu-9z; Mon, 13 Jul 2020 00:49:47 -0400
Received: from mail-eopbgr70118.outbound.protection.outlook.com
 ([40.107.7.118]:10531 helo=EUR04-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1juqPP-0004oF-Vk; Mon, 13 Jul 2020 00:49:46 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZFyTmYhe9NAsbFaVS4fcEb4mujbtdLWP6Doq5R8hNDnFLB+f6YVKJTlG8PPIRHlqUEVbSerACNEk1IdqZX3KmgcSzTBDNY30uJOr/aEzhQLBGwiU9V0MpNeHdWETPPbxbTB4XUpff5yxDlwWcWwCKAFez6fz4c57g4nXO1xEESIAxsYDS0zMWWq+rQre9cv+3N4XYE5FGL6yMHGbeJ9kiZLprjtRF3jbNFSI9sytdnEJ+8ns10754Z5jbcQlkB4hTH5TlJQZzxnnmvNqCpterXhC3UBHkt9/uEo4fvy3OlccuWA1NhwmfWB857B2uApi2S7DOc3rLMGXQ8rGjliDJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDBu6TyhMAB5W+6grM75Y2H5ZMHm5PYMBkrLiMwWkGE=;
 b=OXTdrcYhMFp/Zi8n3B/e+G+T0eYw9g454/ZsosQbhLrHhfLvKVR+7M2/9iZkp4win17FgCe/44HCTGHLAPMfli53I0V8dQ6viSX6DB2DYtA4RNLfasLPuyzCnTEb/Gz2DfrhqH413PAseJew/6lLJP14d7z4RHkJbfFdDW7wucIICMJ0vmYqK8RP+e3yYTudK1ibxyJ2TduYz18P3IzP1LZkl1HncitTnwupIhD95AV3P6jHzSb3qcrbrWLRfH89hVyW/w9BPJVYlp09NQ3rqFgxJpkRq292BBuZ6pTLbXvWLp+88l9fRQ7+87egNy+a1r+OGFAuSBzQrW8SyyGS8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qDBu6TyhMAB5W+6grM75Y2H5ZMHm5PYMBkrLiMwWkGE=;
 b=X4yCDCTHWtCAjsj1YQTt9qHQqY3QfcEspLePDG1I/gcF7p6sCO6b6E/dTmkYjsn0RqX94OqzlHFPcdmDUqsg5KEqQnFxu/6A1ERhil6VlEpQRvNogyva5E1p4VNY0awF6fwwlNNqgIWYWnRquNryRAKJu2JnOi3K1lAFLY3Wuys=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4214.eurprd08.prod.outlook.com (2603:10a6:20b:8d::30)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20; Mon, 13 Jul
 2020 04:49:39 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3174.025; Mon, 13 Jul 2020
 04:49:39 +0000
Subject: Re: [PATCH v8 03/10] qcow2_format.py: change Qcow2BitmapExt
 initialization method
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-4-git-send-email-andrey.shinkevich@virtuozzo.com>
 <e10319ea-0a60-3585-8b36-92783dba3862@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <8f214a44-f8af-b79a-4a62-e5803ccc81bd@virtuozzo.com>
Date: Mon, 13 Jul 2020 07:49:35 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <e10319ea-0a60-3585-8b36-92783dba3862@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM0PR05CA0075.eurprd05.prod.outlook.com
 (2603:10a6:208:136::15) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM0PR05CA0075.eurprd05.prod.outlook.com (2603:10a6:208:136::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.21 via Frontend
 Transport; Mon, 13 Jul 2020 04:49:37 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 71b90272-0ecd-4783-4457-08d826e82686
X-MS-TrafficTypeDiagnostic: AM6PR08MB4214:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42141F12A4D49AB37320414DF4600@AM6PR08MB4214.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VUdsNse1L/50ps24R0AoC9tqUOypdOCkFpQOXJbqDkmywWb+H3eUVpcgiQPqSCL47IrSnPw/QMKHsSXyjQc+ImEfJMoPsthXFkX504tbGxOGsZonYEqsBrUU9NtEcWqimibukzJplrmsAgnNXyW2wPq7PROMtiI3M2RRV/jpEU7lB14p/dI5Jmc7UJxAuZnkeJYq6JE2ER00SKsEFrmqEriUIveXWbIIyarZsOCAStYhsjV2cnIm0l8VsiFQmYs2YKx+XZN8rGwS+kMk9kWlLm+VcUSxiPLTH8wXYK++NrmJ9FO0LFpF5xboDA+qkjTBagPV8tXj7bS648vlR6KeZZvUNo+DqDusPb8GRkbTk87bmomcRjvWd6ABGkX6RGqF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(366004)(376002)(346002)(136003)(53546011)(6506007)(5660300002)(2906002)(26005)(44832011)(186003)(16526019)(31696002)(4326008)(8936002)(66556008)(66946007)(66476007)(31686004)(8676002)(6486002)(956004)(2616005)(107886003)(36756003)(316002)(478600001)(52116002)(86362001)(83380400001)(6512007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: 8M6DN1P3STPEbzbsXhJexTmsUAMQj50//1zAjLK0DhweolaR0xQ50tO2ynw7iUapDvQD7vahoKCs+Erm7s51bkz9ITtsAUmQSMk+7yJaL/X8aNIRt0lp0sigz0NY95gGEMIcRCQc2FDFIAMBvN/kHndvnjmmFlVIecmJ/SX504FHcCV95In1emw2um43uEbySdGoz8caOcAVPjZx33kZh4XTKhM9TefTKXNDYIQxUsKSVY+prUqWngWl/rTtAKwmJtLqhAViAyDvys69WdRhgGXG/7H/yC7VqxCIm4NrnmCuxnNO4l9Dyp545P80DU9Aih1XvgRJFr3+oVd62CsE427LlGbc2AwrPmW8nXH2xymYKRm2W/y4KEHIuYIL6cqojv5OF6wooBWvSkMw3fzvi/uZdWdqtqEt9GniJ8TkQvaosjdkl7LuJauDHbuh8uHdtNZNXKpg0Ey6HKvAF2TGiozrtzta5KxpwASLrjRAxVgjk3uI8xNpvrJpox5TgCMz
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71b90272-0ecd-4783-4457-08d826e82686
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2020 04:49:39.5175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Xxx3pCpbp8Ol8XcwlJ294h51s0xRxxLDNjSJHjLF6a9e2ypuy0LKFVw3J0BRwv7LXTHAEkLzyoWx9Ns5KASGxDul2yqDR90l76ljOXwLEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4214
Received-SPF: pass client-ip=40.107.7.118;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/13 00:49:41
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

On 11.07.2020 19:34, Vladimir Sementsov-Ogievskiy wrote:
> 03.07.2020 16:13, Andrey Shinkevich wrote:
>> There are two ways to initialize a class derived from Qcow2Struct:
>> 1. Pass a block of binary data to the constructor.
>> 2. Pass the file descriptor to allow reading the file from constructor.
>> Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
>> support a scattered reading in the initialization chain.
>> The implementation comes with the patch that follows.
>>
>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 14 ++++++++++++--
>>   1 file changed, 12 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index 2f3681b..1435e34 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -63,7 +63,8 @@ class Qcow2StructMeta(type):
>>     class Qcow2Struct(metaclass=Qcow2StructMeta):
>>   -    """Qcow2Struct: base class for qcow2 data structures
>> +    """
>> +    Qcow2Struct: base class for qcow2 data structures
>
> Unrelated chunk. And why?


To conform to the common style for comments in the file as it is at

class QcowHeaderExtension::__init__()


>
>>         Successors should define fields class variable, which is: 
>> list of tuples,
>>       each of three elements:
>> @@ -113,6 +114,9 @@ class Qcow2BitmapExt(Qcow2Struct):
>>           ('u64', '{:#x}', 'bitmap_directory_offset')
>>       )
>>   +    def __init__(self, fd):
>> +        super().__init__(fd=fd)
>
> this does nothing. We inherit the __init__ of super class, no need to 
> define it just to call same __init__.
>
>> +
>>     QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>>   @@ -173,7 +177,13 @@ class QcowHeaderExtension(Qcow2Struct):
>>           self.data_str = data_str
>>             if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
>> -            self.obj = Qcow2BitmapExt(data=self.data)
>> +            assert fd is not None
>> +            position = fd.tell()
>> +            # Step back to reread data
>
> This definitely shows that we are doing something wrong


For Qcow2BitmapExt, we need both fd and data and they are mutualy exclusive

in the constructor of the class Qcow2Struct. Rereading the bitmap extension

is a solution without changing the Qcow2Struct. Any other suggestion?

Andrey


>
>> +            padded = (self.length + 7) & ~7
>> +            fd.seek(-padded, 1)
>> +            self.obj = Qcow2BitmapExt(fd=fd)
>> +            fd.seek(position)
>>           else:
>>               self.obj = None
>>
>
>

