Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E4DC433E2
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:35:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F5792063A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 15:35:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kW/RNi0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F5792063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jw5uv-0007x0-I7
	for qemu-devel@archiver.kernel.org; Thu, 16 Jul 2020 11:35:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw5uH-0007S8-He; Thu, 16 Jul 2020 11:34:46 -0400
Received: from mail-eopbgr40121.outbound.protection.outlook.com
 ([40.107.4.121]:55582 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jw5uD-0005KB-1Z; Thu, 16 Jul 2020 11:34:44 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jdaA90cbr4Qn5BPnlvL7Zl8JwUHjMDup2H4nRlH2dnDx3EZcjflUCcFUgmZt7ClGRF2OYmmWoGpg2Hs6urwRmvFndRG9s/BGQQoQ0ztyQGwwn60tteASzD6SanX+svmf4KeyEY7qyfEvVOeyTlSweKcjlShbk3IfKoStyqwXxQ00xhFnijFtZs3+nChSSjP+HIRBU5HFzbNGAw4rC5TANskb+Gef9H3vUIfqLZYIJyGDyS6vJvY1Y2eC2qHKmUfQbf3UzFkBwHSqCWPONf1SC/cB5svVZwbJRJEkdmgziFAONakpL+ZkIYGksrQkRXYlyJkt6N8S6cIQeQ0X9mr/Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxACOOhPV3MtqVXOsFur56lONU3k8MHUU16rQRK+nd4=;
 b=P+sTd28+1/qRX5grFRvcwHvoQ6s8pVlfNvY4PyztRqqyxJsjP/P1y46ywyrCrwc7HqvfFBMb1E5GdFEfXMMBTYquHP4jNkS/aWmkAxdIpMP5in9kXxUw12CNcH8jpTA+/Dni0UtRTFZs5ZqWl/igEVyRpUfjql0K7dZbaQ9pQxAvAq3kROHakSJPRfdR5N5pfVwl1GUXs+/76Z+lQ/zBDW/c98Yne5QGspqomQHRMg2bM8uL6JQWi2kfoBVA0u/kGafs8i7aTzVwK0mAIsSdxp4r9rSlYBhKkbCYy7IzHYGVfOsty8wEh1nwGz9ESn+ttNRlNR68ST7J+UILwg9eYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QxACOOhPV3MtqVXOsFur56lONU3k8MHUU16rQRK+nd4=;
 b=kW/RNi0F+/IJ/gu2KG1A6S+BZh3Vp1uNBd4FGGZlz8RvDLGGOSoI5nL/ga/mXxoMbBkB/w8rJ6SQItYYJEIaPgxBrHV+lccXLRDgqRx+4roq0JfHIsjOq1DK8G0JXXt9K4U4/RP47Ex3Gs7H9vsdyw8KXbZoOeHs6Su9COysWAM=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB4344.eurprd08.prod.outlook.com (2603:10a6:20b:74::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Thu, 16 Jul
 2020 15:34:37 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.018; Thu, 16 Jul 2020
 15:34:37 +0000
Subject: Re: [PATCH v10 09/10] qcow2_format.py: collect fields to dump in JSON
 format
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <3e22fb08-2fd1-c0bc-8b83-2ded1a090720@virtuozzo.com>
Date: Thu, 16 Jul 2020 18:34:32 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <7397fb42-13a3-b86b-83fd-3df62114f4f6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0902CA0013.eurprd09.prod.outlook.com
 (2603:10a6:200:9b::23) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0902CA0013.eurprd09.prod.outlook.com (2603:10a6:200:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Thu, 16 Jul 2020 15:34:35 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b092e21f-7801-45ea-c4a7-08d8299dbf78
X-MS-TrafficTypeDiagnostic: AM6PR08MB4344:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4344EF0170839149DAB75941F47F0@AM6PR08MB4344.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4125;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ip9jv9og6sqLwpJpvig3zVcfLTaazd3x0T9ffkZiFOn+sTm0yrKoCXm49Gpy7SC0h/v1DRKgxJVDgrhzJ8bHarxiC1uf2uxqum2Y0UOKKIS6KBAUvBNcYDHTdjWdWtDHhluCw4vi0bg+nv94RhCnvIsOK+3nQAq4O+6t0IVJv4AT1ffJXVoLOLSom6HpNSf/npwYhicbfMznblHfrql3Aq5VJyf8oBHdJo/xtbHURBfwpeFffgoR6gmImYMX1RhkQBcHwP389WKIlO8tKda8wDPmAtNTAVzDGcGHMMuNzS2LTCxdUXS6WGxay88uXu/NV3K/pOCYFlvjhWb6PQGPsWX0KnmQ/8/+la8zaleHekCM2snZutsF/Ap50ivvabNi
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(136003)(396003)(39840400004)(346002)(376002)(316002)(44832011)(66556008)(26005)(6666004)(66476007)(66946007)(53546011)(6512007)(36756003)(31696002)(107886003)(31686004)(6486002)(478600001)(83380400001)(956004)(2616005)(4326008)(52116002)(8676002)(16526019)(2906002)(86362001)(8936002)(186003)(5660300002)(6506007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: hbdGns+n+eBK7j6/Ya+NjBpvKcFFMfT950Z3bbXFYylm9/kHPp3zsDd91E+vVpnlUn1lvX0IT6zQF5yx0yDMzKS+QcdF5SSSbL8LyIghwRTP6O0yAdDZnZcpl/LCYTG2nCmk2LBlXrcu80YRHQ5S/QZnlSRNI7FVucjqB4y+biE1BiYXYzflkbtuW0NJf4ghuaPVdCC/N3hcJyG5k509wXd557t4dz45uWwhLsuwLdCZrz5NvQIX8vEJA+QPSGCaOtqjB6VOthX0gg2p/KiU9Ln2e17cFoR0Zi6VgYpZ5qhs7qLplqFMraVMaUxKC8Afscu9i4JzTl/f/6omsLM7f968cyfNojH98TavNG83Vbj8ax6FQvAG7k9ZXZWxT3d0Vr2J3iB0UG/vmvoxY+FLCYt1Jx5u34I/ZC6WRzQ9IAGVLUKftfy1T9zXQCCXgeldrXYzFCS3ZokcOs/bS72nWvsJyEcOQkhSryRqvhQ8oAexoLbxwqS3H4KBkvhMX3RF
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b092e21f-7801-45ea-c4a7-08d8299dbf78
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2020 15:34:37.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEWROkOpgPaLSRyfxoY8UNSsXIwVrzQ2S6K8+rxX0plIf09C30mxNK5F0zSVnaFNy5Ju6H5QXEq2gAuuoUuym5gGp41ndXTQG21IFUgbtW4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4344
Received-SPF: pass client-ip=40.107.4.121;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/16 11:34:38
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

On 16.07.2020 13:24, Vladimir Sementsov-Ogievskiy wrote:
> 14.07.2020 00:36, Andrey Shinkevich wrote:
>> As __dict__ is being extended with class members we do not want to
>> print, make a light copy of the initial __dict__ and extend the copy
>> by adding lists we have to print in the JSON output.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>> index e0e14b5..83c3482 100644
>> --- a/tests/qemu-iotests/qcow2_format.py
>> +++ b/tests/qemu-iotests/qcow2_format.py
>> @@ -109,6 +109,8 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>>           self.__dict__ = dict((field[2], values[i])
>>                                for i, field in enumerate(self.fields))
>>   +        self.fields_dict = self.__dict__.copy()
>
> No, I don't like that. Keeping two copies of all the data is bad idea. 
> If you want to select some fields, add a method (dump_json() ?) Which 
> will collect the fields you want in a dict and return that new dict. 
> But don't store object attributes twice.
>

Not really. It makes a light copy that stores only references to the 
desired fields.

Andrey


>> +
>>       def dump(self, dump_json=None):
>>           for f in self.fields:
>>               value = self.__dict__[f[2]]
>> @@ -144,6 +146,7 @@ class Qcow2BitmapExt(Qcow2Struct):
>>           self.bitmap_directory = \
>>               [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>>                for _ in range(self.nb_bitmaps)]
>> + self.fields_dict.update(bitmap_directory=self.bitmap_directory)
>>         def dump(self, dump_json=None):
>>           super().dump(dump_json)
>> @@ -189,6 +192,7 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>           table = [e[0] for e in struct.iter_unpack('>Q', 
>> fd.read(table_size))]
>>           self.bitmap_table = Qcow2BitmapTable(raw_table=table,
>> cluster_size=self.cluster_size)
>> +        self.fields_dict.update(bitmap_table=self.bitmap_table)
>>         def dump(self, dump_json=None):
>>           print(f'{"Bitmap name":<25} {self.name}')
>>
>
>

