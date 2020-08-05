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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56A7DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21F5021744
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2020 07:50:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="vr6h8JjC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F5021744
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k3EBb-00059O-Dd
	for qemu-devel@archiver.kernel.org; Wed, 05 Aug 2020 03:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39506)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3EAv-0004hJ-2b; Wed, 05 Aug 2020 03:49:25 -0400
Received: from mail-eopbgr150139.outbound.protection.outlook.com
 ([40.107.15.139]:25385 helo=EUR01-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k3EAr-0001rE-6L; Wed, 05 Aug 2020 03:49:24 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I8wt8L/tr65RtVyZxAO1bMyt7K/xnieibJ5htp7CZmksZKZzGGn4ApFNSj96nM3CBixsB2OE2XPrLhZmm3aycfOKLDTkdeoh5rFleKju8OFT0DoVWVl/oJ0YBADu5zswcTzVnCsCSLVF6IFlApV+CiU3o3fE6o2OUinka7ty8/MkShqKIQtCxCQeJuNwqtiCiqPip1vxgOQ39m+1UVwFFfG3llL+0A5hyYwhmMmTK8aTdRvAZ347KVZR2aWpxWZJJaZqpNCuFbBM6d8RQgrHwlsCO2uxUxKV/Z5ge25spTj98Vmnv8cDZ+TJhNf2Bzt4z1/qFpmu8P52IVkh8ajTZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEs5H8ob1HdxeMx/yKlz4EKUdGPolqmGZq9WKBJu3XU=;
 b=N0ndoDOXfc4bCe59e1r9eXrB6xgWxMmw8ajG12xR6BZvb465Al8S3TpqNZTGD+9O+ByEflTWlelMgUFnMfNCzKrG0M5R8uvqq0jgelvGHX64oY98m7MqEg49pu61MOmFI9Fyg4Kk4QJW7wpTwS1mf2lCBR5vNW49RZsmUsFO8IfJxC/1WVXZcdfRTmtvHAP2B02vpTjvkJS7GNE6DVzlNGoP+hRHod31lLiWau8SUaAkhMbZzP1Frs/iz4HqJdwJtL4ojXPtVfy4fJEUsXUPNGmIicyNFf9RW51N3eC4+WOwn2K8Px7CBqmChM/q2l3tUjtgx+vGpitGNl8osTTyEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sEs5H8ob1HdxeMx/yKlz4EKUdGPolqmGZq9WKBJu3XU=;
 b=vr6h8JjCdY3lAcgDd5TEWBDtjqJoo1VnFMZtiATNySdeOSQy5a82Cv5qD3Cw7k+eOjbkDFvP9jG7sWEi7i1MAkSKToppOvJCOc4Ualqa5hLxAZbPAUBfEMre7KrY5F3og8oDL7l1ObQcQCdnV9shNJcWcOxxStdbT2GKntqVW00=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB3384.eurprd08.prod.outlook.com (2603:10a6:20b:4a::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3239.20; Wed, 5 Aug
 2020 07:49:13 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3261.016; Wed, 5 Aug 2020
 07:49:13 +0000
Subject: Re: [PATCH v11 09/11] qcow2_format.py: collect fields to dump in JSON
 format
To: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>, qemu-block@nongnu.org
References: <1594973699-781898-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1594973699-781898-10-git-send-email-andrey.shinkevich@virtuozzo.com>
 <73a45f07-eefa-3489-fb7f-ed888dc559b0@virtuozzo.com>
 <77aaf45a-de06-8bea-f283-49249ad3a5ff@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <7be0a912-6f86-6fb8-5512-666f3b986948@virtuozzo.com>
Date: Wed, 5 Aug 2020 10:49:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <77aaf45a-de06-8bea-f283-49249ad3a5ff@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0086.eurprd05.prod.outlook.com
 (2603:10a6:207:1::12) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.157) by
 AM3PR05CA0086.eurprd05.prod.outlook.com (2603:10a6:207:1::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3239.18 via Frontend Transport; Wed, 5 Aug 2020 07:49:12 +0000
X-Originating-IP: [185.215.60.157]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc206064-be8f-47bc-b488-08d839140bda
X-MS-TrafficTypeDiagnostic: AM6PR08MB3384:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB338464C44B0E7B7837AF13A8C14B0@AM6PR08MB3384.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: d1CvdFl2BELbxKwtWdvT5Rz5FJdxqxvwXbfqVT7Ex99ExB4I5afpLqYNyE9xdpjt/17Hbfiz7dc0Ea9fi4ZAYoeBdsSeKg7yKTYqpKVOXCJUNvCNi9CFFY9z7oTicZd0iZZlSL6YFcWYs13CTOQfgrRhNSVQrZE1GyJUWBLmpGSdIdBRwOGoLClaShE3nf+f6jZ7/CptMcMoFqvEvgMPGUW6Xe8Aln71YarZDfk4x8mb9+aUtRxIp401lpTC/LxVBJ1mqNLtsIFEeKYluCebXKQq3DP6/ujl+arJ01sNOsi49KbBU2PVS4MB7/Q4gqrKeGNIb7gcnCgBwRkQfHdpcbil3RGEMTOzCkJ3CxPAkbbtGtpBSWLGVBE5UZl33ABM2Hs3Ckkq8kQXfs6xlM7FpIcNnhtlB95/CRtkkFcGWDs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(366004)(39840400004)(376002)(346002)(136003)(396003)(52116002)(31696002)(478600001)(66556008)(956004)(83380400001)(36756003)(8936002)(66476007)(2616005)(4326008)(6486002)(66946007)(53546011)(107886003)(26005)(2906002)(31686004)(16576012)(16526019)(186003)(86362001)(316002)(8676002)(5660300002)(369524004)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dkmC8fxGiQJHVLvxy4+UBNplufvCSGOXoPKvuS/mY33EexxI/Bvr/vfXUerjO+ayJ7t1UuUojtquAFrkP+luyrAcXN4/+Z2/pjoJ7Eg9P6KBM9qGIaCnIrLymDbZRWrcnJ+4cCg73slDM8Fc+ZDXodj9ItCsI3TqAlr2W4MJd1psUXoa+57HGNYeGzBNCM+EoydS7vWjeFK/4HOPEYZzfKqXIN19FNOik6h5dyFn8vLFDGOE5S89Tb67hyRZnYW5jOs/Ck3s3ptASkwNCN5DI086yXfxx7irXHk7hImYHvMaguGOdAoel2/IzkH2GFWB6muF+RdkE36HA6RDC7Oqb32Mvj7IEjuJqJJLtiV/h3fCilGEM4PZ3Ui85n+a+q5bA67Q6v0ILi05xM4tKNZ7NPDOU3pkjuN36vDITVbu5Zlx0RUiCAQzzCWixeamAStCMS+4gyfPnfkElSJ/pzkDYhB4GafyKmnrKWYwrGNNkVFboTT1xPPOP2w8MluXMd43I+PhZWZe4MFl9Y520hsEuMHthy0uAd8It2vksBQGMRD4aEhZCzNkRnb67emXsibX0LxSQtM5oWRJVOfvZA1QVjXl6Bdo/KsxeBCHtPA6+9GlLZBbAaetrRBLBjPHbiu6gla4kByfEH7xuWfc7gLT8Q==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc206064-be8f-47bc-b488-08d839140bda
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2020 07:49:13.5639 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oX2Z16NIdHeeKSWp0VFvbHbuXifbciGiwqwhWjgZ926LwbT+9Z3B/r9r5xHtDs3QjiqiYmfwn2pKLrwrPxVANCUpPp+Kjc1SGIHM0TMyNYA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3384
Received-SPF: pass client-ip=40.107.15.139;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR01-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/05 03:49:18
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

29.07.2020 08:56, Andrey Shinkevich wrote:
> On 28.07.2020 14:09, Vladimir Sementsov-Ogievskiy wrote:
>> 17.07.2020 11:14, Andrey Shinkevich wrote:
>>> As __dict__ is being extended with class members we do not want to
>>> print, add the to_dict() method to classes that returns a dictionary
>>> with desired fields and their values. Extend it in subclass when
>>> necessary to print the final dictionary in the JSON output which
>>> follows.
>>>
>>> Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>>> ---
>>>   tests/qemu-iotests/qcow2_format.py | 38 ++++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 38 insertions(+)
>>>
>>> diff --git a/tests/qemu-iotests/qcow2_format.py b/tests/qemu-iotests/qcow2_format.py
>>> index 2921a27..19d29b8 100644
>>> --- a/tests/qemu-iotests/qcow2_format.py
>>> +++ b/tests/qemu-iotests/qcow2_format.py
> ...
>>>     class Qcow2BitmapDirEntry(Qcow2Struct):
>>>   @@ -190,6 +198,13 @@ class Qcow2BitmapDirEntry(Qcow2Struct):
>>>           super(Qcow2BitmapDirEntry, self).dump()
>>>           self.bitmap_table.dump()
>>>   +    def to_dict(self):
>>> +        fields_dict = super().to_dict()
>>> +        fields_dict.update(bitmap_table=self.bitmap_table)
>>> +        bmp_name = dict(name=self.name)
>>> +        bme_dict = {**bmp_name, **fields_dict}
>>
>> hmmm... I don't follow, why not simply
>>
>>            fields_dict = super().to_dict()
>>            fields_dict['name'] = self.name
>>            fields_dict['bitmap_table'] = self.bitmap_table
>>            ?
> 
> 
> The idea is to put the name ahead of the dict. It is the same to QcowHeaderExtension::to_dict(). The relevant comment will be supplied in the code.

Not worth doing. Json is not human output, it's mostly for parsing, so using so hard magic in the code to sort fields as you want is not worth doing. And I'm not sure how much is it guaranteed to keep some ordering of dict fields, why can't it change from version to version?

> 
> The .update() will be replaced with the assignment operator.
> 
> Andrey
> 
> 
>>
>>> +        return bme_dict
>>> +
> ...
>>> @@ -303,6 +327,17 @@ class QcowHeaderExtension(Qcow2Struct):
>>>           else:
>>>               self.obj.dump()
>>>   +    def to_dict(self):
>>> +        fields_dict = super().to_dict()
>>> +        ext_name = dict(name=self.Magic(self.magic))
>>> +        he_dict = {**ext_name, **fields_dict}
>>
>> again, why not just add a field to fields_dict ?
>>
>>> +        if self.obj is not None:
>>> +            he_dict.update(data=self.obj)
>>> +        else:
>>> +            he_dict.update(data_str=self.data_str)
>>> +
>>> +        return he_dict
>>> +
> ...


-- 
Best regards,
Vladimir

