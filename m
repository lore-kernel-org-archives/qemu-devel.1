Return-Path: <SRS0=Uy1J=BP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83AE5C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E8CF22D2B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 16:59:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="kCJln7Iz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E8CF22D2B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3MlE-0003fH-ID
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 12:59:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3Mkc-0003Af-5H; Wed, 05 Aug 2020 12:58:50 -0400
Received: from mail-am6eur05on2090.outbound.protection.outlook.com
 ([40.107.22.90]:50209 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3MkZ-0005TX-FM; Wed, 05 Aug 2020 12:58:49 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMi4STUEdRRlnTnr+nyUBECxVL/NXPwY+248kq3B910hWi8F6Zo9dVik8y+TZ4YPmZdfaLb5KOcpd3VN3s7gby4pbWgsNbxdpCuRujZGIz905cIkXcRfNFdJQThsa46B6HG5VX3/eDL5Lgbm2WxGawgIRF5FPkpFOkSYDCq5WWckJhxeSbZRgqip1VW8il/7lk/Sc5isWQ+gBYwpck8gbFwbl5rcoqlAQNoLHpkn9LL4p6VzHW57hLKB8a0hzx7Wi9MOYgQjDDc9NK+BYSAhdHGgSa3maoLVHfgXZAfyJwMcsjvsPPl/GWrt28cHaHKHEEVHgTiVbD6IrOp4N9y/ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNf9kue071OqpkJpSxl/WUbq+a69428cBCI9a6m4RL8=;
 b=hxWeizvJVcq6IRalTAlghmoQxAbvkfzf+DRLCnZBv8o3YfBJxxw23jqGxfBlieWef4Gu5fHu4sg/eWJRq5yzuKUtWlk81J7Qpo21JARnRdpV1d6eLovZQq28xobrPmUthhFBx17+p9Gf3rOkk7udEI9VLxEz4Prx8rpxUhtiu804bvoQ//hoZjWCxglXqHLXy9Pj3g6NZfFsv2qdepfhfGlhIIi0Axgzas4hLX3CN1sn7G2xvwYdaZycyN9w8qDqUv5PuvUYwb8Ofbsa/FCJCsRdga+yhzTwCnlIBvpOIMmBnSQBG5XsyXn6LsQoGcIdJdlHdE387rmaiqybTMbf/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cNf9kue071OqpkJpSxl/WUbq+a69428cBCI9a6m4RL8=;
 b=kCJln7Izcl4Sm9+z2zcOZ/yCPKw5uxMH0DXpTU8RQ3dqcwwpWY0Uh4msTVYK+Ojv0Py+hxt/9vnLg1pVVJFdv0pn/NjS8QFLoQ+6lIAJS8+2f7Ci/S4L43LHdM3mN0dF4gBSXz44qClyrwWO1OwYyVbHLK3WRqDiHJ88YW+8Hm0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0802MB2609.eurprd08.prod.outlook.com (2603:10a6:203:98::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3261.15; Wed, 5 Aug
 2020 16:58:43 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 16:58:43 +0000
Subject: Re: [PATCH v12 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1596118512-424960-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1596118512-424960-10-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <4aff9a66-89e2-2a66-e9d5-46a7e9d650fc@virtuozzo.com>
Date: Wed, 5 Aug 2020 19:58:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1596118512-424960-10-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR02CA0015.eurprd02.prod.outlook.com
 (2603:10a6:208:3e::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM0PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:208:3e::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.17 via Frontend Transport; Wed, 5 Aug 2020 16:58:42 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0b16b40b-afcf-40fe-c26b-08d83960cf6d
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2609:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2609996BA0EEF230212392E7C14B0@AM5PR0802MB2609.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Kqv/i9ZscOZZocMYjeV/DOy51OHmq2AgMm2VlyrHLA9RVudnvcJTbQRbv9H2HR/e+TtIuQwxalm4bWF/YUuq4a/8mu5CGfqtusmwoDPWjny4hiVpZ2Ks8BOcSUVx0fR2z8EhpZxEyjq2N1uTECo55Bfteh6HE1VK3j2A7g710eQyKV/+RXOgX+S25baYAh5eqbxUNfKw8qGAzz+qTHroeio+wdgfUIUaRKh1PN5pYDnBlcZ5FIRzLwFILjqpZByRRldGmCgQl2brDzh/mMFwBc5A0+yctZli9IfStDMThQJslHu01z9Q3Ks6XlrJcqEeYFRz4S4G+1AJt/xoSXY7RXQ+M4j2M+ojW//vYW1GTg65XLz/RXwywpfT34FpE5kd
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(66476007)(26005)(2616005)(956004)(186003)(66946007)(66556008)(16526019)(36756003)(4326008)(5660300002)(52116002)(498600001)(8936002)(2906002)(86362001)(107886003)(83380400001)(16576012)(31696002)(31686004)(6486002)(8676002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: ELRwALZuA/GjafHyJYJP4nYmilroJyLWnCSC/BhFuZx6xz/uc6MfMQq5Tl1Hs6DOHz62CcWJ+4rojwzJTeMGV04Fwn78i0RFSzD5EP/nIz18bYFsej3m9xtKpp8/rrbPx5eMMHKCE1DEG44QC98O0D3khvepNSrRxSy9cHpPf7ENJcVvObaKDnbAV3CCXmNzm3jWxluoT1vcvuXNOuU49kxSzDdM0gm6yTfaZwFLhAka0LTp7rF5yjDcC0ABDUbRk2eNbjaad9pbSS/Nevib+gS9C6NQtv4slai74eKRPbjnPweyxKkvuWNtRWZsz1LfQk1Ux3GtM6Us1BEu77FDZvrXBFTC21QHWhqjgGpOdSdiyYO5cPHCyMQYi+TU9MTZsHWL6xD/2BeCgPz6IW7DS7g8ZJ17L6xlH097/JaHfc9HYEaBfJDbXQQ4kBoUEb+gK7cDCC1e7u6LSvhRjyGOBJ2yjs0XcKxPRn3+sH7eSa7K1nx8fFRgL7BHLQg2wqUFEhyWmuXeb2Af869bsYvc76By5berUJmBN0KC/h1SMwRrow0pgAUBA40lfw7fLeXzIhp6Vo9fXcUVwGLBP2qSIRkVUMGmeMTaG3pQLItQuO5sgK7cuOWfozOhMY8+R1cwYOPIh95VDXEgd0t8wUnQlQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b16b40b-afcf-40fe-c26b-08d83960cf6d
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 16:58:43.5095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ZQVlMCL88zIbN+WgvWUFIj74EPeUon91+E0IOWoKG1+Jqu4oAFLvEzCATt05u07q/v2qjR/EXbeeGIdAn2ytX7omwzvaeTbZDYiaauKYes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2609
Received-SPF: pass client-ip=40.107.22.90;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 12:58:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1,
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

30.07.2020 17:15, Andrey Shinkevich wrote:
> As __dict__ is being extended with class members we do not want to
> print, add the to_dict() method to classes that returns a dictionary
> with desired fields and their values. Extend it in subclass when
> necessary to print the final dictionary in the JSON output which
> follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 34 ++++++++++++++++++++++++++++++++++
>   1 file changed, 34 insertions(+)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 2000de3..a4114cb 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -119,6 +119,9 @@ class Qcow2Struct(metaclass=Qcow2StructMeta):
>   
>               print('{:<25} {}'.format(f[2], value_str))
>   
> +    def to_dict(self):
> +        return dict((f[2], self.__dict__[f[2]]) for f in self.fields)
> +
>   
>   class Qcow2BitmapExt(Qcow2Struct):
>   
> @@ -151,6 +154,11 @@ class Qcow2BitmapExt(Qcow2Struct):
>               print()
>               entry.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        fields_dict['bitmap_directory'] = self.bitmap_directory
> +        return fields_dict
> +
>   
>   class Qcow2BitmapDirEntry(Qcow2Struct):
>   
> @@ -189,6 +197,14 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>           super(Qcow2BitmapDirEntry, self).dump()
>           self.bitmap_table.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        fields_dict['bitmap_table'] = self.bitmap_table.entries

the fact that we have to access internals of bitmap_table is not nice, but let's refactor it later.

> +        bmp_name = dict(name=self.name)
> +        # Put the name ahead of the dict

Aha. I don't think that ordering is necessary for json, but why not to order it a bit.

> +        bme_dict = {**bmp_name, **fields_dict}


strange to create bmp_name dict just to unpack it. You may as well do

bme_dict = {'name': self.name, **fields_dict}

> +        return bme_dict

bme_dict is extra variable: it's created just to return it, so, how about just

return {'name': self.name, **fields_dict}


or, maybe

return {
            'name': self.name,
            **super().to_dict(),
            'bitmap_table': self.bitmap_table.entries
        }

> +
>   
>   class Qcow2BitmapTableEntry(Qcow2Struct):
>   
> @@ -214,6 +230,9 @@ class Qcow2BitmapTableEntry(Qcow2Struct):
>           else:
>               self.type = 'all-zeroes'
>   
> +    def to_dict(self):
> +        return dict(type=self.type, offset=self.offset, reserved=self.reserved)
> +

Python has a special syntax for creating dicts :), let's use:

return {'type': self.type, 'offset': self.offset, 'reserved': self.reserved}


>   
>   class Qcow2BitmapTable:
>   
> @@ -246,6 +265,9 @@ class QcowHeaderExtension(Qcow2Struct):
>               0x44415441: 'Data file'
>           }
>   
> +        def to_dict(self):
> +            return self.mapping.get(self.value, "<unknown>")

aha, so, actually, to_dict() returns not dict, but string. So it should better be named to_json() (and return any json-dumpable object, like string or dict)

and then, we can add to_json() method to Qcow2BitmapTable as well, to return list.


> +
>       fields = (
>           ('u32', Magic, 'magic'),
>           ('u32', '{}', 'length')
> @@ -308,6 +330,18 @@ class QcowHeaderExtension(Qcow2Struct):
>           else:
>               self.obj.dump()
>   
> +    def to_dict(self):
> +        fields_dict = super().to_dict()
> +        ext_name = dict(name=self.Magic(self.magic))

strange that we have to create Magic object here... Ok, let's refactor it later

> +        # Put the name ahead of the dict
> +        he_dict = {**ext_name, **fields_dict}
> +        if self.obj is not None:
> +            he_dict['data'] = self.obj
> +        else:
> +            he_dict['data_str'] = self.data_str
> +
> +        return he_dict

again, let's avoid extra dict variables:

res = {'name': self.Magic(self.magic), **super().to_dict()}
if ...


> +
>       @classmethod
>       def create(cls, magic, data):
>           return QcowHeaderExtension(magic, len(data), data)
> 


-- 
Best regards,
Vladimir

