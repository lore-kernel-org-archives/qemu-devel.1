Return-Path: <SRS0=LOIU=A4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C750C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:19:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 508DC20704
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jul 2020 07:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="cEn69jwp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 508DC20704
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58912 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jwKeq-0007HC-H7
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 03:19:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46040)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jwKeG-0006mN-Jr; Fri, 17 Jul 2020 03:19:12 -0400
Received: from mail-eopbgr60113.outbound.protection.outlook.com
 ([40.107.6.113]:47426 helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jwKeD-0004Qv-9J; Fri, 17 Jul 2020 03:19:11 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBTPIvjqsUubUaFfwhvlU40SSy6JPIywgy3TfTXKBL1p+3yH+gdhZR/m8ntNC/f75Po6AYvNa1UXraQCxQsBD5cx7F7n31PORfRs+xc/dpoVailn4obg9YWz1QrVJSJmf94lkiGBKDxOv2ZLJKR6AYJM5QIn0daKFmu8SGQwONNVGh3MiPHj1GzvsDMLqM2V3pvi0Cy3mhigBk8LvqzSeiGZw0wCy4mRK+Q7ysDZInW0eTZd1BA3WQGN7b+RFirGz+V+dnwa6+WPC+onq+mvH3HuTks7VY5VHR6qLX9trrfi6jktoqluOteNTzS/B3/QyUaDAuIAwooZ5612bl1Ohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1lB0LG6CgeKz4G8LkH/DV9XIE3Zsjhv5dIE2ij/BWg=;
 b=Ox6v7vOlvOh8suTFZ/Vcyk1f9DcGc0yy6orepvOe3lhrL76jKe8sSzTf0l8I8+hFU5gCUNgE7vM8oWF3hBP80PVv2XvaOZiclWO3DQt74zSXexxjTFTLLA+DUbntXYSq0iMitu/fRf6NargpZjC/Ci2i3D8Cvvsakplyd7KoYFqW8Io0o8kTsEXv/g8p520VpnW9dNyo8/LjGJq/Kn60ZYobsmhQQxannx8t9+ngUyrqdIzRBVrFSOEb2vtziDv1rin0EBsj/elu+TnXEZfnV8JpcUfNELx+FKiEdPPPJiqyLSH44wGVa172ZszCX8dqdSwWqZt4wKJ48HQBDCnO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/1lB0LG6CgeKz4G8LkH/DV9XIE3Zsjhv5dIE2ij/BWg=;
 b=cEn69jwp1PdNBzHdxqLx4t+7WIdE79yN8rFaPQhHTvBsBfpnNkWGmFtmSP+4Xl1xEO6wPDexVu6K0L2aMIbff9sps0YhpFDWSzLuBIKqU1XnldjDFEk387dZLvTTUGBJ81Jea6i8yIMA7rZBjE1/tX6CTS+CylFFgM7b3g43ktI=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com (2603:10a6:20b:a3::25)
 by AM6PR08MB3959.eurprd08.prod.outlook.com (2603:10a6:20b:aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.17; Fri, 17 Jul
 2020 07:19:03 +0000
Received: from AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0]) by AM6PR08MB4070.eurprd08.prod.outlook.com
 ([fe80::78ec:8cb6:41f7:b2a0%5]) with mapi id 15.20.3195.022; Fri, 17 Jul 2020
 07:19:03 +0000
Subject: Re: [PATCH v10 06/10] qcow2_format.py: pass cluster size to
 substructures
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
References: <1594676203-436999-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594676203-436999-7-git-send-email-andrey.shinkevich@virtuozzo.com>
 <409ffb85-7282-6f83-8a30-a1fb1fc3d455@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <35dd0713-5985-70b3-3c81-e0f864956071@virtuozzo.com>
Date: Fri, 17 Jul 2020 10:18:58 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <409ffb85-7282-6f83-8a30-a1fb1fc3d455@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
X-ClientProxiedBy: AM4PR0302CA0024.eurprd03.prod.outlook.com
 (2603:10a6:205:2::37) To AM6PR08MB4070.eurprd08.prod.outlook.com
 (2603:10a6:20b:a3::25)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.191) by
 AM4PR0302CA0024.eurprd03.prod.outlook.com (2603:10a6:205:2::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3195.18 via Frontend
 Transport; Fri, 17 Jul 2020 07:19:02 +0000
X-Originating-IP: [109.252.114.191]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 75dd19df-0267-4f21-b5df-08d82a21af37
X-MS-TrafficTypeDiagnostic: AM6PR08MB3959:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB3959769EE95C9205BFFFD1BAF47C0@AM6PR08MB3959.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9Sbzdv/Ko6BUn7kDKurOIvgUQ7QlHkW9Cksdi4HiVSVWwcbzF885J2LtJL19Gsdp6hPhiZHTF3qNC8qeqi8DImFz3xaqmS3FdHLeTinSP0CLH+9BHdkrGYWq7VXiO5LH8VxgcSMAsdJx0Q2nq6NXJLf/mBlj4AflFglZxk+HBMJs1trObW58uOkauIkEY7a69xZ31+dTv3PM/nAyodNpnzWBQxHcBh6CKmTPWYVv3Yt4m/oPvkoHaeqT73TKIh7huQi/t0K2L8XRjlsuyJE0FrSG/IZm4hp137cJOUN5LKkowL4ACTflkQ2BcTcQyPm5I5IBTvcQY1GuGGWu7aJw/3NWBYisOrA25U67SkPhv7CF6dNrdIty0de+DV6qh/6h
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM6PR08MB4070.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(366004)(396003)(136003)(346002)(376002)(66946007)(66476007)(66556008)(6512007)(6666004)(26005)(53546011)(6506007)(2616005)(86362001)(956004)(2906002)(16526019)(186003)(6486002)(107886003)(44832011)(5660300002)(31686004)(52116002)(4326008)(478600001)(8676002)(8936002)(36756003)(83380400001)(316002)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: leNuWDyi/6iMaBFNtAADUqjsZkFDffNGZJzwIQJlqVFIeCTl+9UAu+aGeOMTiKAqjo6htM+6k+oUUILlkeZbL6O+8bVGLvn634LLTJOgXyG5QOS7hzKHtUrMz4f1IDDQBrCWXE4sBqmMcPqyWtLAeC+U6gx6pxCtvfMskxcTUmS6jR5hZtCNSScieJisp38MtMMAhDCpIRTX1bMllTeGfx/H22i5dexerzcBLvqLhY96TgoX4pb61Ar8ZuDHIvwfsfSdggSAKwKKBR9wPcFMhNxetyjbciDrNkxkLpMBVNcIfkThlXD4xO8fwspWw/jYQplOr4glAw5gb6TA4WbBFO4Dc3XKN0Wkvn8VmH6KLUBFrWEyauUx38Y8Dts9F9tRNdX9VTh/hvJvxklYPa5KJDEOCPI+lD1cePI9TD32UNFcxOyxaai1jWkODoawLDfghMPvYBDu5wwXzniqKMs/9Yyg2VQVUO6zeIcy6geuDj1p4oB4KsuymOjAPK3e/LU8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75dd19df-0267-4f21-b5df-08d82a21af37
X-MS-Exchange-CrossTenant-AuthSource: AM6PR08MB4070.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2020 07:19:03.7065 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsVhNeHmbt1My0mvJkQ76sJ/KGtoliI9fDNTKserR/GJsTewdtmnwe4RbzZJUQYPyYnKh5A1e3xrdLrOWxZaxLcZS2g9Q5TSIZiCW6WRnaE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3959
Received-SPF: pass client-ip=40.107.6.113;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/17 03:19:04
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

On 16.07.2020 12:26, Vladimir Sementsov-Ogievskiy wrote:
> 14.07.2020 00:36, Andrey Shinkevich wrote:
>> The cluster size of an image is the QcowHeader class member and may be
>> obtained by dependent extension structures such as Qcow2BitmapExt for
>> further bitmap table details print.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   tests/qemu-iotests/qcow2_format.py | 18 +++++++++++-------
>>   1 file changed, 11 insertions(+), 7 deletions(-)
>>
>> diff --git a/tests/qemu-iotests/qcow2_format.py 
>> b/tests/qemu-iotests/qcow2_format.py
>>
...
>>         def read_bitmap_directory(self, fd):
>>           fd.seek(self.bitmap_directory_offset)
>>           self.bitmap_directory = \
>> -            [Qcow2BitmapDirEntry(fd) for _ in range(self.nb_bitmaps)]
>> +            [Qcow2BitmapDirEntry(fd, cluster_size=self.cluster_size)
>> +             for _ in range(self.nb_bitmaps)]
>
> Better to inline the bitmap directory loading code into __init__:
>
> Benefits:
>  1. Less code. read_bitmap_directory() is very small, used only in 
> __init__ and just not needed as a separate method. __init__ is very 
> small and simple too, so it's not a problem.
>  2. no need of extra self.cluster_size variable (you can use 
> cluster_size parameter directly)
>  3. keep all fd.seek logic in one method
>
> but it's not about this patch.
>

The idea behind the read_bitmap_directory() method was an encapsulation 
of reading the optional parameter. So, we can be flexible in future. 
Sure, there are prones and cons for that in the current implementation.


Andrey


>>         def dump(self):
>>           super().dump()
>> @@ -162,8 +164,9 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>
...
>> @@ -244,7 +249,6 @@ class QcowHeaderExtension(Qcow2Struct):
>>                       data_str = '<binary>'
>>                   self.data_str = data_str
>>   -
>
> Unrelated style-fixing chunk, please don't do so.
>
> with it dropped:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
>>       def dump(self):
>>           super().dump()
>>   @@ -316,7 +320,7 @@ class QcowHeader(Qcow2Struct):
>>               end = self.cluster_size
>>             while fd.tell() < end:
>> -            ext = QcowHeaderExtension(fd=fd)
>> +            ext = QcowHeaderExtension(fd=fd, 
>> cluster_size=self.cluster_size)
>>               if ext.magic == 0:
>>                   break
>>               else:
>>
>
>

