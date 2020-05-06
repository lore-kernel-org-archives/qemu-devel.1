Return-Path: <SRS0=CRBd=6U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B62BC4724C
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:32:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AFCF20714
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2020 08:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="n3IIjN7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AFCF20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWFTM-0006QT-JK
	for qemu-devel@archiver.kernel.org; Wed, 06 May 2020 04:32:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWFRp-0005EK-7T; Wed, 06 May 2020 04:30:33 -0400
Received: from mail-eopbgr40118.outbound.protection.outlook.com
 ([40.107.4.118]:56229 helo=EUR03-DB5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jWFRm-0005Az-CD; Wed, 06 May 2020 04:30:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkSPfMmrIBrtj/bZO4Ns+3iwXcBDHr1tcq+6C3i+8yiWzntK8izRI3WSxQwPbTl+TZi2HyYf6e8YAcX5rEZ9Mg4N7J6sHjlYPCxD3Mxau9Rqt7TfqrNQxqHiKPQHR5gDp8vg8GhgOFqPS2xxHE1M/FXjC4wrQcnbKjiFheoRnbLiV7HvWFzwkeBfZn2L6bwDtOqtfJagaKyVvp3GPFgZkDtXaSI0y5VfcAfeKdxGxNtXNG43rAQbWnt6TgC+WqvWJttFBosieHdZamJuQlF7XmYaV8PHEzSMiqgQJipJD9cBYQF5GHoVYEsjTmvF6dwjcV1dGbL8fACNxft1t9vMxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mek5wvFvZV2YRAxXsRMd91xzbs8n8OU2nv9aCBwAjr8=;
 b=LDXhTBytsmYX6bcL1qcCow9Yz0YAhSH+7DyAzdPFJbejVMZdfSG4TEipvcPpuolET2dJszy2kZJv8eLImRRf1y6lCAaeScpt9EDkQbTw0rCqJ/nXC3q5B+XFwNM9QCP9Xz6Qr3Mb9yVFbLtv9gz0rdlWH9d/TGgLHRIU0cOEcXYBv6js3Xh679Qg3hto4YOtRXIzv65TnS/9PXcKSbCbVc8xhkiz2kPpio4TTjaiSOeBpcphybVUT3HyH2XoLvmZeWK04zwp3HerD27qCCq5MQJdElwy/W2lQuS5XzgabZo+BkilrbYiAnZNARWcN1Thw3tFss5l/SjPyz5rPvuusg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mek5wvFvZV2YRAxXsRMd91xzbs8n8OU2nv9aCBwAjr8=;
 b=n3IIjN7Q91TFQkQNmqj1fDvVWwFoFiKuHwOSWu81UcX+Iea27shoPnx5XsbqVzaPMAjoo4XUaLY8DFYF5rk+sdDjAGynfX9vMtIpkLAaRaSE5vQGfYcM71RTXFzTPMmCt/lJJHRW5ECpulvsxC45qvkopjSxbDWur5k4ZHTaESw=
Authentication-Results: igalia.com; dkim=none (message not signed)
 header.d=none;igalia.com; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM7PR08MB5398.eurprd08.prod.outlook.com (2603:10a6:20b:103::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28; Wed, 6 May
 2020 08:30:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::acfa:5:88c8:b7b9%3]) with mapi id 15.20.2958.030; Wed, 6 May 2020
 08:30:26 +0000
Subject: Re: [PATCH v23 0/4] implement zstd cluster compression method
To: Denis Plotnikov <dplotnikov@virtuozzo.com>, Max Reitz
 <mreitz@redhat.com>, qemu-devel@nongnu.org
References: <20200430101918.30351-1-dplotnikov@virtuozzo.com>
 <8f4de4c5-f88d-5693-2327-309ccfc325ff@redhat.com>
 <ebc9d7e5-af1b-fee8-b76f-fb6bc75dc987@redhat.com>
 <e839211c-ae2b-4227-8e69-a9174eb13ffe@virtuozzo.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
X-Tagtoolbar-Keys: D20200506113025086
Message-ID: <ad001ea9-36ba-d314-5428-7e0dbcebed1e@virtuozzo.com>
Date: Wed, 6 May 2020 11:30:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
In-Reply-To: <e839211c-ae2b-4227-8e69-a9174eb13ffe@virtuozzo.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM4PR0101CA0083.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::51) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.178) by
 AM4PR0101CA0083.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::51) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.28 via Frontend
 Transport; Wed, 6 May 2020 08:30:26 +0000
X-Tagtoolbar-Keys: D20200506113025086
X-Originating-IP: [185.215.60.178]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09f1d60e-b718-4f95-b638-08d7f197ba66
X-MS-TrafficTypeDiagnostic: AM7PR08MB5398:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM7PR08MB539872BB554F4F8B8486BAFDC1A40@AM7PR08MB5398.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-Forefront-PRVS: 03950F25EC
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6TgyxyN1OIk0wOJgbpUy5g3Bh2cY4Ytjxtyst7uJ+6mNBz09gulN69l7Nwl8E/sBpdUGBU7CEAMOAbFPR4opzQXMhEW7kjJO55mFzrXdHwvufVQtS4+wl9wl4CNt/h/74F4yEuqlgvrWiPwzJehDfx2jQbpa1FnsE9t4gqL6SVS5Lza8fAiwZiau866eGQC0PUfKX1Y0kOwe62E8Tuhj5tA9vWCLl6nSVbgAzz89PdIVWhc5TzImFG8BVqYNYDuNfYGfhPI+gX9e5mS0maV6gqZcW/WJH/rBxysl+3xfPbnNm1EVQg7KxkxN5FbJ6YGdKZ+TAgSDt8MH/ee5pHrAgij868S9uFOSZfjzjrchPKYFA3P3i6Jdx7Rb4QREaLCMEucIPoOjcLwf0JcdeAEFpiMPRpByzBa87EnSOMyQKHJW6995yQi3MjBpGZkJz1Jfq+d+NOdrKRquIjFjQ8FF02rsaXX3nrHcTgFn8mfcOUr+sIkvJDU47TiWf1KfOqn9QVg57lR1Z7KjVkn+2iw6bT9vDZeTmscg5OfMfR3qkxkSTSDaqhxiBB4p5fNRrvD/
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(136003)(39840400004)(396003)(376002)(366004)(346002)(33430700001)(66946007)(66556008)(6486002)(66476007)(36756003)(956004)(2616005)(478600001)(8936002)(53546011)(16526019)(186003)(8676002)(26005)(52116002)(31686004)(2906002)(5660300002)(110136005)(16576012)(4326008)(316002)(33440700001)(86362001)(31696002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: dOHcIHrRUYT7Pv1QtcWGQ9Z83HA8bafJIG2jlXtyRRAWN+v4ZS4/uEf6F/NVOfT+CPVAsu7TMI4Fbw/0NKUPzwuqTvtnTUf6LFR8Q7PjTtqvHmfXXbR1Q4RshWjk79sLcfucPEwSgS34NrvWIHgXYTJyXb6GFyJZdJ64qaFMDaXNqrRwxYKTp56VYIqeoJn2uhHIupKjhc1jrshSN6RliQEIFmyoQQLcdNmtblVEjxhlU7EWqtFRxkYapAOu/rEOErUnMpx3wMwaGRgfEPhcIuN4ae0lVExOd1Loldfp3tATvxx6jW51qmJX10UzsgP/f7bXvqntUFnijxbesKt9Mg6U6YdCoZrx+y7qbqwIxr8r6W2TkO3GW3g4BNP2S5R01G3+32JxQmvF3XNjCFoGSLlsZFH1Y0copA1WFWE3+4m5vOb82fHWgHtueykhpz/ga+3Xq17CNeRs9lcu/KwT741exOku/OcbkHj/ipxkSyfMKGksfeC9cGW2qs1CyP1a7zwzFK3kgFj7pIgjOSLANNrgo9Ju2Tk8XqMRopidVJftt2SBv+985YhVbxegbr9Vajajdx9rUocTcfz/qBvz49/JAyRQDGAiI8BbsOulzZvUkWzVJR0WZPbaXRszg7uPhWPc82Q/XzJ7+V30uTlyfeWYFsPSmeLIBR1AVqgRHuIqt5lax43fVQDcP+PZ1BLRVGJBL//K5pfJrn4dGjFa0DDhNLh604DXLEujEZFx13sx0/vi2nkTukmrc2XBATRFKUSLm1gqNnH43CT1XVaaL9aSeWZcvmfvw12Z6DsasLE=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09f1d60e-b718-4f95-b638-08d7f197ba66
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2020 08:30:26.6719 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QRUcjoyAQbZIrySNFHGDsAX8MeahEExAEHOP5AtXwlCi2fNoxx1wagFdc2Ao38/qistokQ8lYPrCYPC6PND1j0jsNPuyK5gy0O+YffRBvOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR08MB5398
Received-SPF: pass client-ip=40.107.4.118;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR03-DB5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/06 04:30:27
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
Cc: kwolf@redhat.com, berto@igalia.com, qemu-block@nongnu.org,
 armbru@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

06.05.2020 11:01, Denis Plotnikov wrote:
> 
> 
> On 05.05.2020 15:03, Max Reitz wrote:
>> On 05.05.20 12:26, Max Reitz wrote:
>>> On 30.04.20 12:19, Denis Plotnikov wrote:
>>>> v23:
>>>>     Undecided: whether to add zstd(zlib) compression
>>>>                details to the qcow2 spec
>>>>     03: tighten assertion on zstd decompression [Eric]
>>>>     04: use _rm_test_img appropriately [Max]
>>> Thanks, applied to my block branch:
>> I’m afraid I have to unqueue this series again, because it makes many
>> iotests fail due to an additional “compression_type=zlib” output when
>> images are created, an additional “compression type” line in
>> qemu-img info output where format-specific information is not
>> suppressed, and an additional line in qemu-img create -f qcow2 -o help.
>>
>> Max
>>
> 
> Hmm, this is strange. I made some modifications for the tests
> in 0001 of the series (qcow2: introduce compression type feature).
> 
> Among the other test related changes, the patch contains the hunk:
> 
> +++ b/tests/qemu-iotests/common.filter
> @@ -152,7 +152,8 @@ _filter_img_create()
>           -e "s# refcount_bits=[0-9]\\+##g" \
>           -e "s# key-secret=[a-zA-Z0-9]\\+##g" \
>           -e "s# iter-time=[0-9]\\+##g" \
> -        -e "s# force_size=\\(on\\|off\\)##g"
> +        -e "s# force_size=\\(on\\|off\\)##g" \
> +        -e "s# compression_type=[a-zA-Z0-9]\\+##g"
>   }
> 
> which has to filter out "compression_type" on image creation.
> 
> But you say that you can see the "compression_type" on the image creation.
> May be the patch wasn't fully applied? Or the test related modification were omitted?
> 
> I've just re-based the series on top of:
> 
> 681b07f4e76dbb700c16918d (vanilla/master, mainstream)
> Merge: a2261b2754 714eb0dbc5
> Author: Peter Maydell <peter.maydell@linaro.org>
> Date:   Tue May 5 15:47:44 2020 +0100
> 
> and run the tests with 'make check-block'
> 
> and got the following:
> 
> Not run: 071 099 184 220 259 267
> Some cases not run in: 030 040 041
> Passed all 113 iotests
> 

Hmm, we definitely have a lot more iotests. So, I assume make check-block doesn't run all of them.

To run all:

cd tests/qemu-iotests
./check -qcow2
./check -raw
... and so for any format you want to test

I also recommend to do
   export TEST_DIR=/something
before running tests, where something is tmpfs or ssd, which will decrease testing time a lot. Still, some (very small subset) of tests doesn't run on tmpfs, you can rerun them with TEST_DIR=/normal/hdd/directory

-- 
Best regards,
Vladimir

