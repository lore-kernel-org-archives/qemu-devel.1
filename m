Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16526C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38FC72076D
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 18:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qrf4bK/c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38FC72076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXTH3-00011g-3g
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 14:00:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46988)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXT5Z-0005YT-Tx; Tue, 27 Oct 2020 13:48:54 -0400
Received: from mail-am6eur05on2126.outbound.protection.outlook.com
 ([40.107.22.126]:63745 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kXT5V-0005NR-EB; Tue, 27 Oct 2020 13:48:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=igv1Ve4kYUSOZiwnhEhVYDLzb7rAVUgHIrwCzkdMnGtJxhTlM7iOcuJWq13L6j9xtAp/nnvA0s2a0GykbwAxW4Gkk6rxmRsUx0nHqmELUVlAUKFT0bvfDyb1yadOqo6LeubHWVib1jqTGqNqJ4A8WCt1ZtpeNVyx0X8sq+QPbbXToCBnXAIc9EwpJFgJoNGvtaLARE5iguPUGMkcQWLMqTYROeoeIestacl54A00MWWk6+CkQQwPf6T7jMs6KXLiKubN3iyw4PN+dzieHVJ3buHSGkDr5m/YOP+XuWBUjdfcQPAASLMKCeRsamOIc4esJvuWLsGkXb6rlluVrL5pmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42bTdzQ3zWqab0l87t3r1odpedkpb3JiZ28nG9TmvAo=;
 b=hPXdGEuWjTkzxGS3G2M2LB3qKmsbZG3N3ytcLLvMDZglwolzVg7q+vRhza/91LqsaZdqEMWA+ihvCnhCS/0iqD6umAtCn4ZbNE1EVT+GPiR47Pq1FM44uSqivZiVASkjbarP/HsIOoo/zs/hRIYs/IJqTKQLiXeTotxrXR37wto543bfRbb9BfC5Gg7kzujNdQrurzMZsxJWOeOXoKlg2tKmS4wa6I6gilIgM6UovrO9I4P5+ISx9alvNV2Dn2q1cFtKS8AdWCa9KVaQ9JUV4SwJOOOVsRdYXfpkBddgfEJQKUW1UoGfU54C8NtczVU4BXilLxqjk0S4LUCj3dualg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=42bTdzQ3zWqab0l87t3r1odpedkpb3JiZ28nG9TmvAo=;
 b=qrf4bK/c/+5gjF2cex8Ycyo4z75/malo4j1yKF31J5XC/3x/ADJKOzy9BW3So8fWYFpx5Y016ePTHYSiRwNXDq/Qy4VgoKPlV45T2AlZOQlRsrC3q88pkEowG5jH+2ZyfBazYh6jTyEBpyIvadC1FF5Mjd6RPb31dJg0E3MqVu0=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com (2603:10a6:3:89::22)
 by HE1PR0802MB2316.eurprd08.prod.outlook.com (2603:10a6:3:cb::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3477.23; Tue, 27 Oct
 2020 17:48:43 +0000
Received: from HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036]) by HE1PR0801MB2124.eurprd08.prod.outlook.com
 ([fe80::fd10:fc33:1bb0:1036%6]) with mapi id 15.20.3477.028; Tue, 27 Oct 2020
 17:48:43 +0000
Subject: Re: [PATCH v12 14/14] block: apply COR-filter to block-stream jobs
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
 <1603390423-980205-15-git-send-email-andrey.shinkevich@virtuozzo.com>
 <a8405ebc-8dc3-4520-1e35-2bae6a962f79@virtuozzo.com>
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-ID: <467434b5-abaa-fdac-bfcb-844626e1d5f4@virtuozzo.com>
Date: Tue, 27 Oct 2020 20:48:40 +0300
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.9.0
In-Reply-To: <a8405ebc-8dc3-4520-1e35-2bae6a962f79@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Originating-IP: [109.252.114.22]
X-ClientProxiedBy: AM0PR10CA0113.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:208:e6::30) To HE1PR0801MB2124.eurprd08.prod.outlook.com
 (2603:10a6:3:89::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from Admins-MacBook-Pro.local (109.252.114.22) by
 AM0PR10CA0113.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:e6::30) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3477.22 via Frontend Transport; Tue, 27 Oct 2020 17:48:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c6d331b0-1968-46c6-eaa8-08d87aa08bbd
X-MS-TrafficTypeDiagnostic: HE1PR0802MB2316:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB231661BA767E5BAA78744CD6F4160@HE1PR0802MB2316.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:506;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lY9fp5N/AEHyPmzde3AxjbcoYySYu0KJkDnWuVmOY6ugJSLY2pS3oN33O8w/uhAVvVlDrkL0+15gRWb79QNaajmZYZRgnPnKSS9LvAKf02UTpzuUcuMskCZJLrFiW7klNm4mhUWeLGAdOqGRYmlnPHoLgJ6vyewbxu/6Dyso1qefHoUvfxY27UT3Ct9zPugTfHCVhVyjC9+kwGJek/nbqsHc3OsZkZf6PH3GzW2KO/sdGfzXk5ZjDImWk5eW0loErn92/p3UnANDP75lrbA9inr33vVjuW/1afNP0FyoS815ovl48DLbm2C9voXR4drmE+Zy/Kn634N8RWZqaOmt8tyGPWfNxLSMLESIbjPRyzMegtuUBDuPuXy6+R3jbIzY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:HE1PR0801MB2124.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(6506007)(107886003)(83380400001)(31686004)(16526019)(53546011)(26005)(498600001)(8936002)(186003)(6486002)(31696002)(6512007)(44832011)(52116002)(36756003)(2906002)(8676002)(86362001)(956004)(5660300002)(66946007)(66476007)(2616005)(4326008)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: PExX6YjULQt4Li56tJnK6B15JLVV1M3VWoMB6D4HVSe7LejF/HMqEhsaiHvBxKbJLi043iIZcI3Tv+zxyDoMZfUZXumOrJt8552y83oS2IkiQJUWMi4Kn4hCoF4MvLDapWirRm49Frw19GAqSOIpTRWpVscGi3W6vs/bt3rrpurZfMv8ywXf3OfHkj7d8y5pk87tfFSkjxB2CuIcyXFDWMgl1q9ou4O1UOZVAwoAGLqN7/6WZqpT9KeJDkd1fujWP8EHnaaZb54A9CVU059UHH2sux9t/PNvxCNvMu/08EFt79Pqu9Yf3Alqcdnh+amkrfYMSHDq6NKdpu82vzbaro8JjJqQmT+Gl24TzplBkZCDD8CQS3/0YpWy0YHjMGRMn1IDpvNGtFuFEEPQk7QLxSjZePWwDHAlVt+oco5d29h+aenxVFnMBbKC6zPOtOAc1i5yJd4IUZ3DGTbjybvUTeVy1g93SpIVk1EJ2yMtIzwbVIf+9vKfdvyhDE6yKUOurjVG1uFtCBxjSWYsgVNPr8NwlRIYlZN2p580JVBdsczwpIaBZgKPvXPpryfGHNOzg6At7qYHMQp4kMgy3Q/HXvMbyXKYyeb+axvf2M+rvrKtFi9tf+XEYVuxsm7pcaFIJwyxai/VL1BDcgJ4TUdC4A==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6d331b0-1968-46c6-eaa8-08d87aa08bbd
X-MS-Exchange-CrossTenant-AuthSource: HE1PR0801MB2124.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2020 17:48:43.2889 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gEAMpmLZAHfrB4WHUDkfOPlpV6xYqlLLY/V/rNBJ+PiM1Z9KUVxYIPJHiSks+HwWJnwxmuaOCfJwkuTxF4+4vY5NcoZH+oHFIdWYD/bMLO0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2316
Received-SPF: pass client-ip=40.107.22.126;
 envelope-from=andrey.shinkevich@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 13:48:45
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-2.167, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


On 27.10.2020 19:13, Vladimir Sementsov-Ogievskiy wrote:
> 22.10.2020 21:13, Andrey Shinkevich wrote:
>> This patch completes the series with the COR-filter insertion for
>> block-stream operations. Adding the filter makes it possible for copied
>> regions to be discarded in backing files during the block-stream job,
>> what will reduce the disk overuse.
>> The COR-filter insertion incurs changes in the iotests case
>> 245:test_block_stream_4 that reopens the backing chain during a
>> block-stream job. There are changes in the iotests #030 as well.
>> The iotests case 030:test_stream_parallel was deleted due to multiple
>> conflicts between the concurrent job operations over the same backing
>> chain. The base backing node for one job is the top node for another
>> job. It may change due to the filter node inserted into the backing
>> chain while both jobs are running. Another issue is that the parts of
>> the backing chain are being frozen by the running job and may not be
>> changed by the concurrent job when needed. The concept of the parallel
>> jobs with common nodes is considered vital no more.
>>
>> Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
>> ---
>>   block/stream.c             | 98 
>> ++++++++++++++++++++++++++++++----------------
>>   tests/qemu-iotests/030     | 51 +++---------------------
>>   tests/qemu-iotests/030.out |  4 +-
>>   tests/qemu-iotests/141.out |  2 +-
>>   tests/qemu-iotests/245     | 22 +++++++----
>>   5 files changed, 87 insertions(+), 90 deletions(-)
>>
>> diff --git a/block/stream.c b/block/stream.c


[...]

>> +    s = block_job_create(job_id, &stream_job_driver, NULL, 
>> cor_filter_bs,
>> +                         BLK_PERM_CONSISTENT_READ,
>> +                         basic_flags | BLK_PERM_WRITE | 
>> BLK_PERM_GRAPH_MOD,
> 
> I think that BLK_PERM_GRAPH_MOD is something outdated. We have 
> chain-feeze, what BLK_PERM_GRAPH_MOD adds to it? I don't know, and doubt 
> that somebody knows.
> 

That is true for the commit/mirror jobs also. If we agree to remove the 
flag BLK_PERM_GRAPH_MOD from all these jobs, it will be made in a 
separate series, won't it?

>>                            speed, creation_flags, NULL, NULL, errp);
>>       if (!s) {
>>           goto fail;
>>       }
>> +    /*
>> +     * Prevent concurrent jobs trying to modify the graph structure 
>> here, we
>> +     * already have our own plans. Also don't allow resize as the 
>> image size is
>> +     * queried only at the job start and then cached.
>> +     */
>> +    if (block_job_add_bdrv(&s->common, "active node", bs,
>> +                           basic_flags | BLK_PERM_GRAPH_MOD,
> 
> why not 0, like for other nodes? We don't use this BdrvChild at all, why 
> to requre permissions?
> 

Yes, '0' s right.

>> +                           basic_flags | BLK_PERM_WRITE, 
>> &error_abort)) {
>> +        goto fail;
>> +    }
>> +
>>       /* Block all intermediate nodes between bs and base, because 


[...]

>> diff --git a/tests/qemu-iotests/030 b/tests/qemu-iotests/030
>> index dcb4b5d..0064590 100755
>> --- a/tests/qemu-iotests/030
>> +++ b/tests/qemu-iotests/030
>> @@ -227,61 +227,20 @@ class TestParallelOps(iotests.QMPTestCase):
>>           for img in self.imgs:
>>               os.remove(img)
>> -    # Test that it's possible to run several block-stream operations
>> -    # in parallel in the same snapshot chain
>> -    @unittest.skipIf(os.environ.get('QEMU_CHECK_BLOCK_AUTO'), 
>> 'disabled in CI')
>> -    def test_stream_parallel(self):
> 
> Didn't we agree to add "bottom" paramter to qmp? Than this test-case can 
> be rewritten using
> node-names and new "bottom" stream argument.
> 

I guess it will not help for the whole test. Particularly, there is an 
issue with freezing the child link to COR-filter of the cuncurrent job, 
then it fails to finish first.

Andrey

