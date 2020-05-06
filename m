Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A630FC28CBC
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:03:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 766502075A
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:03:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hgqCGfHr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 766502075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWF1O-0000kj-K4
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:03:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34174)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jWF0E-0008B8-Ry; Wed, 06 May 2020 04:02:02 -0400
Received: from mail-am6eur05on2115.outbound.protection.outlook.com
 ([40.107.22.115]:34625 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dplotnikov@virtuozzo.com>)
 id 1jWF0A-0003Xs-Ht; Wed, 06 May 2020 04:02:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JplGCLFsbj0ZSp7CerPg/E/TbEEwJAjti66a6XRnyPFLDjJNqSWanU/PuvzeFh11gcKEETKjpNOQ54xQ1dQ8dr63vE+bC8YEbz5ud0gBELq8r6V52p6iRRh6Y6SkcpWGNbeWj/dBeiFcvrQEL3o4hAyh2PtzteBVesrb+PPngBtqQMelkO2GN8TOzzw97+3Jn+gZz3jXyl1hLR2vRSLas6zJmqOIFC50p74dthsMtfZ0w4T+c+ZuJlMN8Vxk1egTH/0lTvPRmMQYYBf8ZcQpIjjTgfzatbJS+uKp9CGN77ITZvUkojVurQLnKkfrrpTSuJIQbaRAdr9CD8NW0l7ZdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C22ZRWHBXIL50ZzE/IVHo4wa3tAr4EFzOGPq6rHO8zA=;
 b=WDFHrbbhbSoMM8bQRkPUO59ZvV/Ej5vaeNFAx4n8WQHO38AAsYPa3D0s0EU7hwtkkQi7MYZs1lfmXNr9tCZlesbWHa3HLI6pbLFWzVeQ55LmukmpQX2wbUAuW4xnFjQKlmyQ4m7UJyznla/1BA5hymeZ+R8MzB3S51BktqYBfLlEZG8yK9D6AgWSyKORpdv60c7kXrFDQA9JI2EGG7FFlzJlB6QBad+Y485c5xyajjPd117S8dK70fuMy6u8kPtqDhuqXiCEGY3xIbOOJ1D6QUm0DHHSPQgoMi4kXWV4eQBJXFgxuyvSbuTCDpA2j0StkU7cFwihpiUNLhJxlKw+tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C22ZRWHBXIL50ZzE/IVHo4wa3tAr4EFzOGPq6rHO8zA=;
 b=hgqCGfHryOZ++AzI/DHFAQaemViji5spI74tX3BsgFFgS+0FmDj1Ar7MF574rP/6ivQDwlu+D9O6N+5/XaT7lc2XtGG9ot0FwD3p8EQzvclDGWK5jTCKB7B+ULfjuMdkoBvktbtnV3nx5Xr5QY+/x3dp80ZQCylCN/wGqL9G6rg=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com (2603:10a6:803:c1::27)
 by VI1PR08MB4447.eurprd08.prod.outlook.com (2603:10a6:803:f3::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.27; Wed, 6 May
 2020 08:01:52 +0000
Received: from VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20]) by VI1PR08MB3760.eurprd08.prod.outlook.com
 ([fe80::acf5:3103:8e4d:af20%7]) with mapi id 15.20.2979.027; Wed, 6 May 2020
 08:01:52 +0000
Subject: Re: [PATCH v23 0/4] implement zstd cluster compression method
To: Max Reitz <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200430101918.30351-1-dplotnikov@virtuozzo.com>
 <8f4de4c5-f88d-5693-2327-309ccfc325ff@redhat.com>
 <ebc9d7e5-af1b-fee8-b76f-fb6bc75dc987@redhat.com>
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Message-ID: <e839211c-ae2b-4227-8e69-a9174eb13ffe@virtuozzo.com>
Date: Wed, 6 May 2020 11:01:48 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
In-Reply-To: <ebc9d7e5-af1b-fee8-b76f-fb6bc75dc987@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-ClientProxiedBy: AM0PR04CA0014.eurprd04.prod.outlook.com
 (2603:10a6:208:122::27) To VI1PR08MB3760.eurprd08.prod.outlook.com
 (2603:10a6:803:c1::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.1.64] (178.34.160.183) by
 AM0PR04CA0014.eurprd04.prod.outlook.com (2603:10a6:208:122::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2958.20 via Frontend
 Transport; Wed, 6 May 2020 08:01:50 +0000
X-Originating-IP: [178.34.160.183]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 17eb8fee-66b9-4524-0de0-08d7f193bc51
X-MS-TrafficTypeDiagnostic: VI1PR08MB4447:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR08MB4447F56996992278472B5400CFA40@VI1PR08MB4447.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2657;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ho5rpBu4QiJ0l3pg2KF6mtlycFWejhu/BQQO7z6DgJFKX2om72LvC5y5MAH1+kQILZ0DSSR520utgTvcSiGP1+mAuYXk4m1K1HlqkJqFHlNhmiNtILsbxVgXQC25hh6F3ERKgbFl2Tb/BKlzsTCwNVgTUTwog7JEOAwpkr1qsCJr/rVjoCFRDHlpSAshFwn6wxYKW4RZk7lYNWbroIq9akUGzHjaurCLWKSlg56eLKQSAgfq7QP409kie2ukh3swz6Nk9jH12Szv7MRXhCtjqAgMBHGreoCLW532pTyTJSpA5t3asN5VdgW9a4DHsYWbvIdSlKy2vcQo691jpzIApSn2eCvRiSZi8Ij8R1F6sQt5dpmHxRqtlyZxpDDtnf+hF7hlBo6FOyOUxDJZQcOXWcF1ivxOqKQRVfhUsMjkBhTj0GJA5asJOp3Ngz6lwblAJ9lvaTlGNjJ/nDh4+tOlqgDzoUICCExvmg2+ji95PwW/XstRe7e99yI/LvE6aiIRQnWLS76kVixBrHq10U1RA36XfEk6BUCn0t2u7PynWE1yiOTWHnPeb2RpLErwc8zE
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR08MB3760.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(396003)(39830400003)(136003)(366004)(346002)(376002)(33430700001)(6486002)(2616005)(956004)(36756003)(16576012)(5660300002)(4326008)(16526019)(33440700001)(186003)(8936002)(2906002)(52116002)(31696002)(8676002)(26005)(86362001)(66946007)(31686004)(316002)(66556008)(478600001)(53546011)(66476007)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: lpuZlfdLp5kWG6RDIFdhWh1RILdz71sUmpp00qAsez6Wy153vtoz51z4TB5eyyVqlkrhi+Si2nC2QCMGOlQDTX8HJIrBDdbstZiL2nBPjtL9D5i99J0aPZ+/AJn8mIffgL2BHGgFoZY95L6DAoKxNf0PNwKDfHXWMGhXXnZpsgKIlKbHup4LCcg4V1/eDImdyj4RbJfQ7ecK0pwDUuUz/5fIl05HrnRJYvMv9OffCZnpT7YmL/1D7HThp1WSpIEqNnCMCGrYMYIVbeYRYE24RDLxAdcbO/ka4uEsUQTK7VWpN+vzuRunSq/7A71o9Fqi2Ul1+vntAIzr74h0JPLxXqZTaAAMenXkLB69ktYkhDDYJPQtmxTSoLrTshPy7jX9FHEaz/pSHhT9R/kwx/ty2SssjVXHG7hI8XHu8SpPFAwn4VBM7tiGGue0rbMWml6izl8NOdbqLU6/bNnN29ZccwbipqAOTLhpySaFEGrOlmPGa0FHErKLdR+gyC++zfYCzh7kFWYJj5a7UshbzLCTNx/1pGH4Di4Lx6YS1b/jKWbcgwcLJTTOM+nTgQ71Il4HxdhYFvTRrOjKwLLqNadTACipIAipplAA181U6WY/ysYW1P3eufVcRKJcH9SDHvRNeEpq9WJPzdvxLDQbRpA6yAjjpgQKZ3EoQ5oVsVLoqhR5NJeFoYJOWd5mbnhDp2izSB7fwzDR1SVG3WoYYyMGKGxrzZsSsYGH4gjqBtaw8y2sGxQCQU0+bwDi6umgF6CEdMmhKfQ/v5x0F9WKkZM2Yls51ked62a2YDUN218AVz4=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eb8fee-66b9-4524-0de0-08d7f193bc51
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 08:01:52.0388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yzcz2utYT13BX5vajhGXbQF4EyO0/JLzqNmjASfTbD5DZknl1UK9j67DH6IJq0CLvvyiE5A1xrOH4G5vpcSQdJhHcT49kglbujo4M7NT0VM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB4447
Received-SPF: pass client-ip=40.107.22.115;
 envelope-from=dplotnikov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:01:53
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 MSGID_FROM_MTA_HEADER=0.001, RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, T_DKIM_INVALID=0.01,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 qemu-block@nongnu.org, armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 05.05.2020 15:03, Max Reitz wrote:
> On 05.05.20 12:26, Max Reitz wrote:
>> On 30.04.20 12:19, Denis Plotnikov wrote:
>>> v23:
>>>     Undecided: whether to add zstd(zlib) compression
>>>                details to the qcow2 spec
>>>     03: tighten assertion on zstd decompression [Eric]
>>>     04: use _rm_test_img appropriately [Max]
>> Thanks, applied to my block branch:
> I’m afraid I have to unqueue this series again, because it makes many
> iotests fail due to an additional “compression_type=zlib” output when
> images are created, an additional “compression type” line in
> qemu-img info output where format-specific information is not
> suppressed, and an additional line in qemu-img create -f qcow2 -o help.
>
> Max
>

Hmm, this is strange. I made some modifications for the tests
in 0001 of the series (qcow2: introduce compression type feature).

Among the other test related changes, the patch contains the hunk:

+++ b/tests/qemu-iotests/common.filter
@@ -152,7 +152,8 @@ _filter_img_create()
          -e "s# refcount_bits=[0-9]\\+##g" \
          -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
          -e "s# iter-time=[0-9]\\+##g" \
-        -e "s# force_size=\\(on\\|off\\)##g"
+        -e "s# force_size=\\(on\\|off\\)##g" \
+        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
  }

which has to filter out "compression_type" on image creation.

But you say that you can see the "compression_type" on the image creation.
May be the patch wasn't fully applied? Or the test related modification 
were omitted?

I've just re-based the series on top of:

681b07f4e76dbb700c16918d (vanilla/master, mainstream)
Merge: a2261b2754 714eb0dbc5
Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Tue May 5 15:47:44 2020 +0100

and run the tests with 'make check-block'

and got the following:

Not run: 071 099 184 220 259 267
Some cases not run in: 030 040 041
Passed all 113 iotests

May be I do something wrong?

Denis

