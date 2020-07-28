Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3173EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00132065C
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 11:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="TGAYM0Ts"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00132065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43714 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0NVD-0004UT-4L
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 07:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33888)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0NUX-0003zg-RK; Tue, 28 Jul 2020 07:09:53 -0400
Received: from mail-db8eur05on2118.outbound.protection.outlook.com
 ([40.107.20.118]:19041 helo=EUR05-DB8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k0NUS-000770-Rn; Tue, 28 Jul 2020 07:09:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h8vls6RDlXcuKrE8b5tXdIvfkAjfG257rf8GCH69KCndjmkX26nrwxjH+Z7OCYEUn8fU7qZQ2qiZppOITaR+gBeQVjF75GG7f5fRUBylqPys20YWPFbv678wQojL8pPlMUja4kVkal6BhYnO3gTa6pm6oWej+DJXzcnUwOgokhj+If4OJm1Rn9NXWymBLHRntsx7ANvDrC2OeLDPkx3PcGHghfrpchzRRjLOy7ZBnWEvfrsaSvh2pvt5XFMRBUQDQlEa5lTO10/9ZI9qfjxT5Zizx4BrTwDrnv9QLvzMlH0Va7OFCSsujg4kKFUB2aHG9IDUCp6L3EXtiokIJQIl0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dhDF2iYXtsjTUxLxReajASNd75SjJpjg4S1nbU9l+k=;
 b=fAS2iKHY0SfZZqubHHu2jQ4WVix3xNPV5AZhpZEuRlJ9lm/Fu3/L8s7j3aU7/i1RpDhNHkBPnOWUeksjgUDmKalZxGeukPkV/YS3dSzsXSrI82lr1VaPDwltQ8nF+s8Ze1ezsKHdrcDsNar9Bo/xU6tDK9Pqyfwr6oZQA7DYHnl6AODj80xyieU8UygM/DzstDjE0FTrhTYo6FJxcdGiWMhRtzlCcqNoUgXDssFbn5rbkRtYz7OXbz81ni8yHPnF2UCK/xKYpBqfXH9on6r5SAOU+7p1bEY03Pz5kp6gUphxf0ChvHfSOfiYuqkVgNH4dGOVzZMlYfgLiB7yRGrJ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dhDF2iYXtsjTUxLxReajASNd75SjJpjg4S1nbU9l+k=;
 b=TGAYM0TsNBWLbE5YxQD3abp0U6rT7jcmT5GPevdzr/BNYuoGzL2gAEYTu1hT6iCuf2cew9ecZmw3nGpxkc03mi6rVDwF/zOiDDtfjh4/q2YsPjoiFZ6dxeNVGzFF/guYRHGxdjU7mUp70oGa3nEY2ZLUwXtog2aX6sXrRGkLo/w=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4916.eurprd08.prod.outlook.com (2603:10a6:20b:ca::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.22; Tue, 28 Jul
 2020 11:09:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 11:09:45 +0000
Subject: Re: [PATCH v11 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <73a45f07-eefa-3489-fb7f-ed888dc559b0@virtuozzo.com>
Date: Tue, 28 Jul 2020 14:09:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1594973699-781898-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR07CA0013.eurprd07.prod.outlook.com
 (2603:10a6:205:1::26) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.158) by
 AM4PR07CA0013.eurprd07.prod.outlook.com (2603:10a6:205:1::26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.9 via Frontend Transport; Tue, 28 Jul 2020 11:09:44 +0000
X-Originating-IP: [185.215.60.158]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fa4e9e48-fb81-4bdc-5f19-08d832e6bbd1
X-MS-TrafficTypeDiagnostic: AM6PR08MB4916:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB49166C00BAC6546F445EF217C1730@AM6PR08MB4916.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LbqjFw8spsijO5E/vgTGM5CkDytLmZFyKC+pTjaFLsNZeyKssa4PAKL9YLJ57NaDmS0f3l1YOgV6Z3Hfa5twkwPTduti4V4gju5mtD4kbCCsSATii74GmYljAje28zh4+/0HfCs5XKG0ASrPUPY6/tdm9RQVy4r93FmqptCY8pKuWFmMgmxT5fvFFeDzEqrBQPK+I136NL/QWPZ6b/NmZSNGZdGjQmrPZMZlxX+m5B/9CKdbm4AH78MPvr/NbDOHUt+7VSlsZOZVBxBNE2r+0mWKPogcjkln0a6pymwpABYWZybY6z2IYNT5WphVWIiKeesodaT3i1xN3dEuvEgJUi+p4SzAcQ9zSiTo/6b9alxsruTE9B276mHUHZrSl4gh
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(366004)(396003)(31686004)(16576012)(4326008)(316002)(107886003)(86362001)(478600001)(31696002)(66476007)(2906002)(66556008)(66946007)(5660300002)(83380400001)(186003)(52116002)(16526019)(36756003)(8676002)(956004)(2616005)(26005)(8936002)(6486002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: rKNGzuVdAkyxLbhjynov/1X8Oh2TSXz72KrcG5FH73aE2486cEUSFIVDZDPEuXH1g9gvxBozzee87u9tSLWuFHA0mocAfZDSTMiCAivDe7IobLGnF0xCD7JNN/mVs+4sLyzhA7IUKqAFL4a26OylqGRHjfR03x4VZTug6JG2xlZEjEI7PvkUQXRqd0p1iZ9kEVrex0nd9oeeOSxZQrNsz1rovBiLo/lzDs8u/4iAeiD83lv5MnJm/QsZA3/TS6doACFYthYIRZKwKrSvzWILNod9cTMRn2nhGjmg5+Vz5KCDAa77XIotDHuoG7bi2hJzi8RiBhS692BoL7m9OZVKFTHe4SXu9pKoA0NUuER8p+S6u9GeLaeTFNw40LTOyR2MZT69jVXGJdKdf+judLZoEaxhUDp9TPvf6bTLk7CcP/DeRZlaTbZOqab9zAYCOwSOHErxkgMedZLIUBpbwygOj/Gy30av7eEVw5crEW1ql9FlemdA+qEIvE37AvTcTQkk
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa4e9e48-fb81-4bdc-5f19-08d832e6bbd1
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2020 11:09:44.8778 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vAFFOKA+uuDdh/6cNuw08mKB8S1WZfMOPDgdGOvu/ok3n3EiKpr7akJ1/N4IJkO3BVM8d8QwBTuz/lQo+SZJvqxwMfDHmsqZz0PLDYZWXSY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4916
Received-SPF: pass client-ip=40.107.20.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-DB8-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/28 07:09:45
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

17.07.2020 11:14, Andrey Shinkevich wrote:
> As __dict__ is being extended with class members we do not want to
> print, add the to_dict() method to classes that returns a dictionary
> with desired fields and their values. Extend it in subclass when
> necessary to print the final dictionary in the JSON output which
> follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 38 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 38 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 2921a27..19d29b8 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>   
>               print('{:<25} {}'.format(f[2], value_str))
>   
> +    def to_dict(self):
> +        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)

good!

> +
>   
>   class Qcow2BitmapExt(Qcow2Struct):
>   
> @@ -152,6 +155,11 @@ class Qcow2BitmapExt(Qcow2Struct):
>               print()
>               entry.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        fields_dict.update(bitmap_directory=self.bitmap_directory)

No reason to use .update. Let's use usual notation:
            fields_dict['bitmap_directory'] = self.bitmap_directory

> +        return fields_dict
> +
>   
>   class Qcow2BitmapDirEntry(Qcow2Struct):
>   
> @@ -190,6 +198,13 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           super(Qcow2BitmapDirEntry, self).dump()
>           self.bitmap_table.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        fields_dict.update(bitmap_table=self.bitmap_table)
> +        bmp_name = dict(name=self.name)
> +        bme_dict = {**bmp_name, **fields_dict}

hmmm... I don't follow, why not simply

            fields_dict = super().to_dict()
            fields_dict['name'] = self.name
            fields_dict['bitmap_table'] = self.bitmap_table
            
?

> +        return bme_dict
> +
>   
>   class Qcow2BitmapTableEntry:
>   
> @@ -205,6 +220,9 @@ class Qcow2BitmapTableEntry:
>           else:
>               self.type = 'all-zeroes'
>   
> +    def to_dict(self):
> +        return dict(type=self.type, offset=self.offset)
> +
>   
>   class Qcow2BitmapTable:
>   
> @@ -226,6 +244,9 @@ class Qcow2BitmapTable:
>           for i, entry in bitmap_table:
>               print(f'{i:<14} {entry.type:<15} {entry.offset:<24} {size}')
>   
> +    def to_dict(self):
> +        return dict(entries=self.entries)

Probably, this could be just list of entries, not creating interleaving dict.. and then, the method should be to_json (returning something json-serializable), and return just list here.. But it may be refactored later.

> +
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
> @@ -241,6 +262,9 @@ class QcowHeaderExtension(Qcow2Struct):
>               0x44415441: 'Data file'
>           }
>   
> +        def to_dict(self):
> +            return self.mapping.get(self.value, "<unknown>")
> +
>       fields = (
>           ('u32', Magic, 'magic'),
>           ('u32', '{}', 'length')
> @@ -303,6 +327,17 @@ class QcowHeaderExtension(Qcow2Struct):
>           else:
>               self.obj.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        ext_name = dict(name=self.Magic(self.magic))
> +        he_dict = {**ext_name, **fields_dict}

again, why not just add a field to fields_dict ?

> +        if self.obj is not None:
> +            he_dict.update(data=self.obj)
> +        else:
> +            he_dict.update(data_str=self.data_str)
> +
> +        return he_dict
> +
>       @classmethod
>       def create(cls, magic, data):
>           return QcowHeaderExtension(magic, len(data), data)
> @@ -405,3 +440,6 @@ class QcowHeader(Qcow2Struct):
>               print('Header extension:')
>               ex.dump()
>               print()
> +
> +    def to_dict(self):
> +        return super().to_dict()

this is useless. You have to_dict of super class automatically.
  


-- 
Best regards,
Vladimir

