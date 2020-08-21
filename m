Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45672C433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:43:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAC5820724
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 11:43:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="s21ggCi5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAC5820724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40620 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k95SM-0006GH-1a
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 07:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46140)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k95M7-0003XW-Pf; Fri, 21 Aug 2020 07:37:11 -0400
Received: from mail-vi1eur05on2130.outbound.protection.outlook.com
 ([40.107.21.130]:30071 helo=EUR05-VI1-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k95M3-0001vv-8k; Fri, 21 Aug 2020 07:37:10 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pccpsj78NhnN9Ug+mIuHZuQ1/ehyWScIjLfV2anDlUVgDPhQxLHMjFhSFaCgsAE+3ruBJGRuxxLLd/CtBL/pJiIH0ggT6afL5nB/lRcMa4BvwRk5tlsj58hCAcSqF1pyr9vuGXgC8g2Ww8t+0oHLx+r8+0BqLiQ/8+iGI3d0ZBoI4FYcr+XU279StUDugOt9/sC+U4m35+6ljaKykLNGKmiq2nGOmNSwluUN8Q681lWRU3pbaIf/xgaZ6DAIoPpQONOomqAsjWaht7uXkzMftAGwd7idlrSzsYOyMRtqPcooajE00cl9yCux3JJANNDSUZsV4Jmy14J3N+W+rYTIFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpdM8wJ8fcFMbJTNORYMnZR1//giCGOTk4yGom46qFk=;
 b=WUI6+Ke1IU8CS2pldc0Ev+s4WsuLgApqh0iqe51f70k0uHFvfeK90WL0rvkCRkn8RidS38stqJThlRNv+QbkojS4S/AK9QdUP1BY3DUiHq0sfMOD/JO3VVO0XYoosvi9nXnXXlrymVyae0qHasrVj6G7Xsrj7/LcuwwhJAx41i2ZxwgE38eb8g2jzhMeBMp1FoyO5UqJtx+DrmG0jzIGyWKwC3TABlifeMHav7B06RBlFrw/4z63UEN/aM9/IlG3QWjTT7AFbsRZLQ2YKbtWb8qTg1V4vxNYrpCJUoN3hEm4PcdgttD9kBu35SKNKai1XTwtJaizATs+NMuGfj4pDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dpdM8wJ8fcFMbJTNORYMnZR1//giCGOTk4yGom46qFk=;
 b=s21ggCi5ryVeEc0V3Q99CqzM/t0yhud+X0jkq8ECAjSCg4PTG476Iu3Duqo/lFLyxUZr/wUhHBY+kmyztKC76F0zdu5TO89Asv92tsn1wX9pDk26JtbBPkF9CwcwcKkDgVjAUp4ZfWo0MEIy5QHz3LHfGmgFKYf0DNwOzwe/jYg=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Fri, 21 Aug
 2020 11:36:59 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Fri, 21 Aug 2020
 11:36:59 +0000
Subject: Re: [PATCH v4 4/4] iotests: Test node/bitmap aliases during migration
To: Eric Blake <eblake@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20200818133240.195840-1-mreitz@redhat.com>
 <20200818133240.195840-5-mreitz@redhat.com>
 <b1ab8e28-f5ad-1cde-a706-02e4b32e1a0a@virtuozzo.com>
 <d5800911-0068-8810-f7e0-ab2b10f949b2@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b3d1c4ca-66ee-d79d-1079-91838f3f814d@virtuozzo.com>
Date: Fri, 21 Aug 2020 14:36:57 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <d5800911-0068-8810-f7e0-ab2b10f949b2@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM3PR05CA0126.eurprd05.prod.outlook.com
 (2603:10a6:207:2::28) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM3PR05CA0126.eurprd05.prod.outlook.com (2603:10a6:207:2::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3305.24 via Frontend Transport; Fri, 21 Aug 2020 11:36:58 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8df21eb5-4a26-477f-2647-08d845c683a5
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-Microsoft-Antispam-PRVS: <AM6PR08MB48497F0F31F9F762A8DAAF94C15B0@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4+csnJFdNiJCwu37AfMXaa2QnpaztvHKSngk8HX3f6OxHr3mKPB8lfAun7DeddvvPc+pS09xzj001rvFMIsGakUq6zOnsgwQJqNANNuqWqNthCnRKZzYCv+nHRJZ7BmK5xmKq0ozPYdeAvYZZ2A4NPILknszemSchVe3Lcwcl28zwpguMsbup3+urG/WPdZ1Xpke8MI5URllCUf5Iyle5Y7UtKIjZaCmGDjsqDRsOkArrzB3nwAKMJpYZUwaWhNxy0h3BlqCVoG3Zet5YBtOyxDaKMGnDQ/10yg6g3uE4LtKUbepnFBLNsce1JvasBhLlbPRtz9Sc9LrzgcA8t/tcsOE4z8jxSKkOH8tehIUysB803o/ez1PSLYKg3Wnve0N
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(396003)(376002)(39840400004)(366004)(136003)(53546011)(6486002)(5660300002)(66946007)(8936002)(66556008)(66476007)(16526019)(36756003)(83380400001)(8676002)(956004)(26005)(186003)(2616005)(2906002)(52116002)(478600001)(31696002)(54906003)(31686004)(110136005)(4326008)(16576012)(86362001)(316002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: eZBtTuTPT5pn1qg/tYo0KPg1LPBvFoU9UCnP0tKNlrMFKLjolPbOTvNMX6kSTX6OBQGjaN7cDHLoDxtq1hvQ3FxzSToH15WviH/xewWlD/KWmFYZEDPtvc1dJ+zv35wti5nMCuw1WrsXgVEaf7ClbKVERQo64r2yP7i2aXmBIDqcjTlr6bL4jT9uY1SB/la2l0e42ExMLaAAA3RBk/odlFqLW2lpd3h5Gm9nPZBUmfTXtIaN0tqAC4bfdAmp2/p5DpQEOjGKYFtBgsKoy1x89T59uKgEiBdmpr1txYi8zY/PeATlMXHniWEiYNxobXyeP3gRneuiztWjMqeowgG4qV7gT4I/tOPSWAF84r9okLQJbu+4/i2lhGCGi++2PtCQzuiu0AkGe2igwsR0PlrVP7z3BJU2f3+WHzdnsa/T3XkehTgps8Irh+flWC5I5fbBMv/sasnYF6EdjRbzCrl5mMoIg/KVt1sCnz1Oyu5t4BkdRyXbFTrbsKVQCf9FO+OxCiUrKoxnB5EeRbM0Q3/ig5OeKCx1BCIptwULBgCOmSV9YBVIOKg6WSsG0b6CFQAHCfBG+oZVzBOviD6jVAnR+/QbWC+7puuN6dwHj2HjGp4iJ//RURE1SZ/Hx+1hwhBFBZHQ0u2+2r8tG3kDn9n8XQ==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df21eb5-4a26-477f-2647-08d845c683a5
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2020 11:36:59.0192 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G/+8kynbLIWHzmZi7Rgya+Q4W2K7n9akdLQDU9ag+7KxDBwRhm6tB4Trg2C5U5ZvTh4nedb4Wf05JU6le3cTxAt8HTubu45k0q3BTVA+244=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.21.130;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-VI1-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/21 07:37:00
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

21.08.2020 03:44, Eric Blake wrote:
> On 8/20/20 10:49 AM, Vladimir Sementsov-Ogievskiy wrote:
>> # MYPYPATH=../../python/ mypy 300
>> 300:154: error: Item "None" of "Optional[Match[Any]]" has no attribute "group"
>> Found 1 error in 1 file (checked 1 source file)
>>
>> - the only complain. Suggest a fix:
>>
>> diff --git a/tests/qemu-iotests/300 b/tests/qemu-iotests/300
>> index c6d86b1dbc..0241903743 100755
>> --- a/tests/qemu-iotests/300
>> +++ b/tests/qemu-iotests/300
>> @@ -148,11 +148,11 @@ class TestDirtyBitmapMigration(iotests.QMPTestCase):
>>               result = vm.qmp('human-monitor-command',
>>                               command_line='info migrate_parameters')
>>
>> -            hmp_mapping = re.search(r'^block-bitmap-mapping:\r?(\n .*)*\n',
>> -                                    result['return'], flags=re.MULTILINE)
>> +            m = re.search(r'^block-bitmap-mapping:\r?(\n  .*)*\n',
>> +                          result['return'], flags=re.MULTILINE)
>> +            hmp_mapping = m.group(0).replace('\r', '') if m else None
>>
>> -            self.assertEqual(hmp_mapping.group(0).replace('\r', ''),
>> -                             self.to_hmp_mapping(mapping))
>> +            self.assertEqual(hmp_mapping, self.to_hmp_mapping(mapping))
>>           else:
>>               self.assert_qmp(result, 'error/desc', error)
> 
> Thanks; I'll fold that in to v5.
> 
>>
>> ===
>>
>> # flake8 300
>> 300:24:1: F401 'time' imported but unused
>> 300:34:1: E302 expected 2 blank lines, found 1
>> 300:42:67: E502 the backslash is redundant between brackets
>> 300:47:67: E502 the backslash is redundant between brackets
>> 300:67:53: E502 the backslash is redundant between brackets
>> 300:122:9: E125 continuation line with same indent as next logical line
>> 300:134:9: E125 continuation line with same indent as next logical line
>> 300:185:52: E502 the backslash is redundant between brackets
>> 300:186:72: E502 the backslash is redundant between brackets
>> 300:285:77: E502 the backslash is redundant between brackets
>> 300:305:77: E502 the backslash is redundant between brackets
>> 300:306:78: E502 the backslash is redundant between brackets
>> 300:330:77: E502 the backslash is redundant between brackets
>> 300:350:77: E502 the backslash is redundant between brackets
>> 300:385:57: E502 the backslash is redundant between brackets
>> 300:386:59: E502 the backslash is redundant between brackets
>> 300:387:67: E502 the backslash is redundant between brackets
>> 300:412:78: E502 the backslash is redundant between brackets
>> 300:425:78: E502 the backslash is redundant between brackets
>> 300:435:78: E502 the backslash is redundant between brackets
>> 300:436:76: E502 the backslash is redundant between brackets
>> 300:451:66: E502 the backslash is redundant between brackets
>> 300:473:78: E502 the backslash is redundant between brackets
>> 300:474:79: E502 the backslash is redundant between brackets
>> 300:488:78: E502 the backslash is redundant between brackets
>> 300:489:77: E502 the backslash is redundant between brackets
>>
>> - I post it just because ALE plugin in vim highlights all these things for me. Up to you, I don't ask you to fix it.
> 
> Seems like an easy enough touchup to make.
> 
> 
>>> +    def test_alias_on_both_migration(self) -> None:
>>> +        src_map = self.mapping(self.src_node_name, 'node-alias',
>>> +                               self.src_bmap_name, 'bmap-alias')
>>> +
>>> +        dst_map = self.mapping(self.dst_node_name, 'node-alias',
>>> +                               self.dst_bmap_name, 'bmap-alias')
>>> +
>>> +        self.set_mapping(self.vm_a, src_map)
>>> +        self.set_mapping(self.vm_b, dst_map)
>>> +        self.migrate()
>>> +        self.verify_dest_error(None)
>>
>> Hmm, probably verify_dest_error() should be called from migrate(), as you call it (almost) always after migrate()
> 
> This one I did not touch; it can be a followup patch if desired.
> 
>>
>>> +
>>> +
>>
>> [..]
>>
>>> +    def test_unused_mapping_on_dst(self) -> None:
>>> +        # Let the source not send any bitmaps
>>> +        self.set_mapping(self.vm_a, [])
>>> +
>>> +        # Establish some mapping on the destination
>>> +        self.set_mapping(self.vm_b, [])
>>
>> Seems, you wanted to specify non-empty mapping for vm_b, yes?
>> With any non-empty mapping here, just to better correspond to the comments:
>> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> (or keep this case with both mappings empty, and add one similar with empty mapping only on src)
> 
> Adding another case will now have to be a separate patch.  At any rate, I've taken the liberty of including your R-b in my staging tree for the pending pull request, let me know if I should drop it.
> 

OK, thanks, no objections.

-- 
Best regards,
Vladimir

