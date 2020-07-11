Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E66EC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:35:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2382420786
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 16:35:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="RzvrEIdS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2382420786
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53964 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juITL-0003D3-D0
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 12:35:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57002)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juISj-0002hf-Gf; Sat, 11 Jul 2020 12:34:53 -0400
Received: from mail-eopbgr10114.outbound.protection.outlook.com
 ([40.107.1.114]:51749 helo=EUR02-HE1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1juISg-00033r-SV; Sat, 11 Jul 2020 12:34:53 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AHNvXyV/6hIWXj0loHRfOHQnpmv/kTLeK+3UANV4oIYnGlhpkiCK7PqBrmgjkcY58KIKunQl7/Dv1/WhLyXeOGCdrdxREQRcYHxew4V4wkfrU5UyVnOBhmAXEz88KRM6dJ0sVgZ7AHrCkwFJGs7sMRbSpwl0Z3AvwkG6f3rATE/2ndp0kDv3BQfkb1Y/g9klebG8dl4HopuQTrIPqlbP50paxsb1f2WK9ljBH8YW2nm82TfyUAngYotQSZoL0URts6HEuSVCpxmIyrci2TF1HBjf+khjnS6QaEsKkmOdy4FgXZQg/tWfAaUtj7e2yZNQ+ZIoha1vqjay0Ab7guIc0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nphI/bOxZX9e614T9ELhuTPHx4/UnZa4u51t+fy/ziM=;
 b=Ij7aqz3M+4HAXPozHfEiRre97VoEGfjv0vlELPivuwa8rxTdt1vP/ARuPEoyGooWTOIssSIMcXd8yI3pOHf3gIP5YN5cTHs+hGmB8LA6ojYt47zxCaD9fAvRMYQ5Na3hJbnemFnsSGUgKaZ5grEZh/O9Xkh2/L16qUMdQFKEWaByvB0Mj7a3LwQ4CWlFloIoHZzngp4iETiXMahM24OmDG/GrwkO9kIj/EdNPTdSpRTIVGcir1TbaeJ3wScTLo1IA+w1rhJzjvU8P8B+lgSZpXRz+Xh65PI0x4qiwgO73zHKKxWunqqZ4FGdOG43osON0gJtzeCvUq3tPRV6xBeLww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nphI/bOxZX9e614T9ELhuTPHx4/UnZa4u51t+fy/ziM=;
 b=RzvrEIdS3XDDUsG3GaNB6+rNHVhrBFHWTveimmkqL+KL96m0g6pnoUzfPZBWnV3GJXRr4/LgC5KlbMBIdQBRvrOxvxnb/DtPO5Nd14oOcgumAtuqIBSq+17UyXLQ0W7JRuCaujpLqIJW4rQjh5AOZYR4jqI7S+L+wYHHoq+rC/0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1716.eurprd08.prod.outlook.com (2603:10a6:203:39::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.23; Sat, 11 Jul
 2020 16:34:45 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::a408:2f0f:bc6c:d312%3]) with mapi id 15.20.3174.024; Sat, 11 Jul 2020
 16:34:45 +0000
Subject: Re: [PATCH v8 03/10] qcow2_format.py: change Qcow2BitmapExt
 initialization method
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1593782030-521984-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1593782030-521984-4-git-send-email-andrey.shinkevich@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <e10319ea-0a60-3585-8b36-92783dba3862@virtuozzo.com>
Date: Sat, 11 Jul 2020 19:34:43 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <1593782030-521984-4-git-send-email-andrey.shinkevich@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM0PR01CA0119.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:168::24) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.157) by
 AM0PR01CA0119.eurprd01.prod.exchangelabs.com (2603:10a6:208:168::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.20 via Frontend
 Transport; Sat, 11 Jul 2020 16:34:45 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9200b91-8e03-4dbb-bb42-08d825b85223
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1716:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1716830978CC90F58E53F57FC1620@AM5PR0801MB1716.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /QlUBH5VDotPBNiK/1zHBv6dICdmACtkNlUs/P731J34Y5EYGk08y0iLd2/1UisTFufxRwcdv5hdZ+4V7+Th9ODPYdkPlV8DDYK74mlAjkzQp6vYhJ28MyLZy1YxdsOoeIyfIK7QKmDj7i+hlTcdCd/I8xwItj3lsUWrG2JKgPCIDrsYTYvYWSFhNYSYGImzWZbHoKI1VdugvPHTz14SpVJ30V9VzwAWqqRpR/vMShXS+wLgRqrVk1Mz9Jm0c4HUHHoWeLYuwg8Nn0c9S+mpt5SwMUVE1SxQ6fDJ4UKfeGbOr47TuFt6sQMggRY4l+oALsPsau4iBfLphRL/ztPrlMwmi+RTZfnMIBQHAB8WFotmmiNKFvc5PYfvgX9pSE1n
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(376002)(346002)(39840400004)(136003)(366004)(31686004)(478600001)(36756003)(8676002)(66476007)(6486002)(5660300002)(8936002)(2906002)(66946007)(31696002)(316002)(52116002)(16576012)(66556008)(16526019)(186003)(2616005)(86362001)(4326008)(107886003)(26005)(83380400001)(956004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: xnmJZ+rcpYNoHTM/Ib6PZHSqOGVC8C5lL+q1xG7pZZHQ6tkbHgY173tBw1jSghcl4dI4Hb8SvFC9kYIkQlXPc+8mHj6iiYcMptK9Pr0CW7bL1ebg9+eOtf2ZSaiOJRRg+us4ziodbd1S8G/9WosXTpLMvHGH3FG0FS/oS74VYx976Rapn+Twde+iKczT0qoo+QDGDIkTraEbaA1MuFPj+8UqsryruXLPN3ifUizSRiKPgrbteyQpiqZTdPyWRt/+c2ck0epogwVDTny2VWrMlkhFgvEWKPDcNoVLujZxNJPB/XBf6dORb3BpPiAuHKQwyMuZeSgD+7sqJCJlF66V5egZGGtqN+WhsPd0nWTZbLwHxTsmCQKhSl18dBqWizvkqvABLvfytb0I+7J0I2PJOGH/b8TiGrvVEdVpw9vi1vo77VR8YdWpzkt4P6iH0lwRaGRhcM33rqHNorY5WBVMpwlqi8zbijHLuBflGW7TEHm1XE4FGoW2kk29I5h08V6u
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9200b91-8e03-4dbb-bb42-08d825b85223
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2020 16:34:45.7209 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RncYbcytJf+Hh9Etbde/tNtlpfgCg9uhheX5VWpOfpx3LQqLtN07vObzXtgMRpxXfN+zNJORl9kg3muDLeemySBctQ1f0qXJmbKDgDLsloM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1716
Received-SPF: pass client-ip=40.107.1.114;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-HE1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/11 12:34:47
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

03.07.2020 16:13, Andrey Shinkevich wrote:
> There are two ways to initialize a class derived from Qcow2Struct:
> 1. Pass a block of binary data to the constructor.
> 2. Pass the file descriptor to allow reading the file from constructor.
> Let's change the Qcow2BitmapExt initialization method from 1 to 2 to
> support a scattered reading in the initialization chain.
> The implementation comes with the patch that follows.
> 
> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
> ---
>   tests/qemu-iotests/qcow2_format.py | 14 ++++++++++++--
>   1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
> index 2f3681b..1435e34 100644
> --- a/tests/qemu-iotests/qcow2_format.py
> +++ b/tests/qemu-iotests/qcow2_format.py
> @@ -63,7 +63,8 @@ class Qcow2StructMeta(type):
>   
>   class Qcow2Struct(metaclass=Qcow2StructMeta):
>   
> -    """Qcow2Struct: base class for qcow2 data structures
> +    """
> +    Qcow2Struct: base class for qcow2 data structures

Unrelated chunk. And why?

>   
>       Successors should define fields class variable, which is: list of tuples,
>       each of three elements:
> @@ -113,6 +114,9 @@ class Qcow2BitmapExt(Qcow2Struct):
>           ('u64', '{:#x}', 'bitmap_directory_offset')
>       )
>   
> +    def __init__(self, fd):
> +        super().__init__(fd=fd)

this does nothing. We inherit the __init__ of super class, no need to define it just to call same __init__.

> +
>   
>   QCOW2_EXT_MAGIC_BITMAPS = 0x23852875
>   
> @@ -173,7 +177,13 @@ class QcowHeaderExtension(Qcow2Struct):
>           self.data_str = data_str
>   
>           if self.magic == QCOW2_EXT_MAGIC_BITMAPS:
> -            self.obj = Qcow2BitmapExt(data=self.data)
> +            assert fd is not None
> +            position = fd.tell()
> +            # Step back to reread data

This definitely shows that we are doing something wrong

> +            padded = (self.length + 7) & ~7
> +            fd.seek(-padded, 1)
> +            self.obj = Qcow2BitmapExt(fd=fd)
> +            fd.seek(position)
>           else:
>               self.obj = None
>   
> 


-- 
Best regards,
Vladimir

