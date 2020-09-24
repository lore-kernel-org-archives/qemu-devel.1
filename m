Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31574C4346E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:22:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9394220936
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 07:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="m57z5qoG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9394220936
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLLaK-0006f5-Lc
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 03:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38424)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLYV-0005SC-Id; Thu, 24 Sep 2020 03:20:40 -0400
Received: from mail-eopbgr00135.outbound.protection.outlook.com
 ([40.107.0.135]:61715 helo=EUR02-AM5-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1kLLYP-0007Mc-Q0; Thu, 24 Sep 2020 03:20:38 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dVxvFULcchcTSYjx1x2Z2yrmdvS9FQUu+4zjMEOmqDtxc8qiSko41l7X6Rj/WevkNsMX0alxIhJ2+ozHcim/k58jq4VACdn9/M4mX3Ap3mBo97weSFn1zBskdstZDJCoPDuX0+UyhaSNHITtl3Djbtw96phW7FMIwQu43vRD4s9Ojx/LPgBO58L1q9cFo5KUcN+2VbwNaNZWA0l1mQAyFswVi16akeO8jLP1Xnmq4+G3CcghoGiawLCS4eJ5WSDOg0UEIN6HiQuPv8qZZz3YMJatB8PUrX1LduKsPbp8W81FlKxCCzM3pD9Qsmqdw/EqsY4vapaLGXfFTMWlZkM2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c9QMrlnwGJIZCl4VeO7RONqKuB5bsH5nV/gnTCsNl0=;
 b=gdEVFKLtE1hNw0GQs33c9PNZGrCNQgTiFNgL9f9oV7NHhSTVJzA5xclQDl+E+VSjCfIK0RWK+CDqJJ6WYJu6qm5XuOLuqs39FH+sPkFb7mc5Zon74Pj46OKcLMFwD4Ueeq1vypx+w5otIhiS91ZfECsEthgL3ADitq/LPHPoQf2BMA2J9Gp4i3q/bi1YeqqBM/ich/FNIl6aDnaxO4lYTwGdoXTS2ZfQWnmPr5S2K7DAxJAoiN+5fFtodHYz5FpNhDZrGtuU0/ZYxoK7EaAbtcsAmv9ZEASGsljo+Jjq0w8/d1FA5xdtjt0TPJOr0swRgU7j/krWXhvYX3DQUxCQpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9c9QMrlnwGJIZCl4VeO7RONqKuB5bsH5nV/gnTCsNl0=;
 b=m57z5qoGzivSPfTwN3ab3g5eimM9SEbdhJAGXCrM4ZDhpL7pZBlz+T6UFuePLDF5qAAvuyE0NJGUxJTZfAs48agbeShwCx9QAI0yrifNEBdJrAwY/yLjU05OKuMiEIhRoB0yjWqdbMC2vgb7pU7KMHAbDW2rE4H2jkOZaLFHTEU=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM5PR0801MB1652.eurprd08.prod.outlook.com (2603:10a6:203:3c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.15; Thu, 24 Sep
 2020 07:20:27 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::b179:9641:7589:d692%8]) with mapi id 15.20.3370.033; Thu, 24 Sep 2020
 07:20:27 +0000
Subject: Re: [PATCH v8 7/7] block/io: refactor save/load vmstate
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, crosa@redhat.com, ehabkost@redhat.com,
 fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com,
 den@openvz.org
References: <20200915164411.20590-1-vsementsov@virtuozzo.com>
 <20200915164411.20590-8-vsementsov@virtuozzo.com>
 <7fd65dfd-6264-8510-5995-b712d5c4cfa7@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <94ed93ae-0fe4-cba1-50d4-16606e2595a8@virtuozzo.com>
Date: Thu, 24 Sep 2020 10:20:25 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
In-Reply-To: <7fd65dfd-6264-8510-5995-b712d5c4cfa7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR01CA0096.eurprd01.prod.exchangelabs.com
 (2603:10a6:208:10e::37) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.94) by
 AM0PR01CA0096.eurprd01.prod.exchangelabs.com (2603:10a6:208:10e::37) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.21 via Frontend
 Transport; Thu, 24 Sep 2020 07:20:26 +0000
X-Originating-IP: [185.215.60.94]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd200331-ed79-4111-3c1a-08d8605a4fa8
X-MS-TrafficTypeDiagnostic: AM5PR0801MB1652:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0801MB1652CDC85E3DB4279E57A13DC1390@AM5PR0801MB1652.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ypMT48uJeSgp+75AURiSot+uXWGTGQo+HsWmOZC76LaqQr7Om9rZX+cccW2wJCRu/PjbIMu/EH5148UMrRz1byaYfv5PviX+vLydsqoS3C62eGGB68OLgi2LyiI3iMR+jINRhrL2uhSyAD3otBMsljVFX7RlHzcXmwFbQdpVhZ4Di+jMBWOQgvvfG2X9WMqDruuEUGX0bcOBQ51eLlU6ej8KZdEg4S3I38aHT8PLft+Q6EqpFRTkoUzHCTMM2j49iYDOeTfe2TiMXzp4xk+GuqqnEnomDdpwOnqP+foPRWDW0ebNAic3agMd5evp1Ziv53xs+Hi315b7pdNlh8baPNhUdcbqffwSm7hE9WviStMx0BxOvKSFKEjQp6BCjFFCc3pxKlS8sCM1tsoG7zu4LokFHvEXRKhctiqwDPXjXTLVpLJujRUgAdqHtWBWryYJ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(396003)(376002)(39840400004)(136003)(107886003)(4326008)(31696002)(2906002)(478600001)(66556008)(66946007)(66476007)(8676002)(8936002)(2616005)(31686004)(83380400001)(316002)(6486002)(956004)(186003)(26005)(16526019)(36756003)(5660300002)(16576012)(86362001)(53546011)(52116002)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: sV7YXy+1Acbrt563W0ysGmm2qw7BtBmuQSEgtL5nxYpkMnwSJmh2env9C/9LDNtGma0u5wkOirgfV4jpNcL1tQmMbhn3vNZPNw3Ehjqr4YvjrwqhQloKbZRSrCvlVhQ48wh2TmmuAnfMv7ILLqdZd4g51oLfcztaqOH+df8oPi7BFpaPVDI4pSSvylAHM0k/w7qbl6hXcGYxmDRmfNnQrbtmJqtT4KtsIaVobmUDbdZSQseo6PNl+Vvs1pWGvLQgaHc7D00rRWsGpUytqCeIykShBRtrzpXTwriU99g5OQ56vyvm5vL+wvgcOKwA0Vh0Ldr6yAv5ZmFWtiEQ9T+H84JEt2e9uPOGqRSrF1o2VtpPacFRyszbbTBlaUXbEMLELkhIwnsOEyR3zHVo11773nldZpps3ZaGRgPEiNiRXJtdNm/ipLpgOUbL5cQ1Aj1Rhr5KiGbGqtBq6HTM4til4P2iUT4X6bPRO0ZdtvPeXwZUY3Ytrw10SMYl2GLUR8dcEztf2bem68I7P4TDxSv/EZUvptpJ5rbiR82BU1053/0NEDwhysMnMrDghllmBS0oQoL9fJhQgS04p7eUOiFR8eEAtFEnziWNHduls+h77gkyDJMM0rpJhzmoVlx9IBqJQ0TKcSXCC34pwjfSzchNdw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd200331-ed79-4111-3c1a-08d8605a4fa8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2020 07:20:27.4177 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 41VkQ+WPpL7oObV/CfXN+JkRGHwmMXi+CF5Oa09S0tybdKpNsfsncL8fmZktmdJycRX2LlVl8M2IDH1sHjn6AkbZj27nCOUY6A7qAoSc5Xc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0801MB1652
Received-SPF: pass client-ip=40.107.0.135;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR02-AM5-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/24 03:20:29
X-ACL-Warn: Detected OS   = Windows NT kernel [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 MSGID_FROM_MTA_HEADER=0.001, NICE_REPLY_A=-0.001, RCVD_IN_DNSWL_NONE=-0.0001,
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

23.09.2020 23:10, Eric Blake wrote:
> On 9/15/20 11:44 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Like for read/write in a previous commit, drop extra indirection layer,
>> generate directly bdrv_readv_vmstate() and bdrv_writev_vmstate().
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> ---
>>   block/coroutines.h    | 10 +++----
>>   include/block/block.h |  6 ++--
>>   block/io.c            | 67 ++++++++++++++++++++++---------------------
>>   3 files changed, 42 insertions(+), 41 deletions(-)
>>
>> diff --git a/block/coroutines.h b/block/coroutines.h
> 
>>   int coroutine_fn
>> -bdrv_co_rw_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos,
>> -                   bool is_read)
>> +bdrv_co_readv_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>>   {
>>       BlockDriver *drv = bs->drv;
>>       int ret = -ENOTSUP;
>> +    if (!drv) {
>> +        return -ENOMEDIUM;
>> +    }
>> +
>>       bdrv_inc_in_flight(bs);
>> -    if (!drv) {
>> -        ret = -ENOMEDIUM;
>> -    } else if (drv->bdrv_load_vmstate) {
>> -        if (is_read) {
>> -            ret = drv->bdrv_load_vmstate(bs, qiov, pos);
>> -        } else {
>> -            ret = drv->bdrv_save_vmstate(bs, qiov, pos);
>> -        }
>> +    if (drv->bdrv_load_vmstate) {
>> +        ret = drv->bdrv_load_vmstate(bs, qiov, pos);
> 
> This one makes sense;
> 
>>       } else if (bs->file) {
>> -        ret = bdrv_co_rw_vmstate(bs->file->bs, qiov, pos, is_read);
>> +        ret = bdrv_co_readv_vmstate(bs->file->bs, qiov, pos);
>>       }
>>       bdrv_dec_in_flight(bs);
>> +
>>       return ret;
>>   }
>> -int bdrv_save_vmstate(BlockDriverState *bs, const uint8_t *buf,
>> -                      int64_t pos, int size)
>> +int coroutine_fn
>> +bdrv_co_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>>   {
>> -    QEMUIOVector qiov = QEMU_IOVEC_INIT_BUF(qiov, buf, size);
>> -    int ret;
>> +    BlockDriver *drv = bs->drv;
>> +    int ret = -ENOTSUP;
>> -    ret = bdrv_writev_vmstate(bs, &qiov, pos);
>> -    if (ret < 0) {
>> -        return ret;
>> +    if (!drv) {
>> +        return -ENOMEDIUM;
>>       }
>> -    return size;
>> -}
>> +    bdrv_inc_in_flight(bs);
>> -int bdrv_writev_vmstate(BlockDriverState *bs, QEMUIOVector *qiov, int64_t pos)
>> -{
>> -    return bdrv_rw_vmstate(bs, qiov, pos, false);
>> +    if (drv->bdrv_load_vmstate) {
>> +        ret = drv->bdrv_save_vmstate(bs, qiov, pos);
> 
> but this one looks awkward. It represents the pre-patch logic, but it would be nicer to check for bdrv_save_vmstate.  With that tweak, my R-b still stands.

Agree.

> 
> I had an interesting time applying this patch due to merge conflicts with the new bdrv_primary_bs() changes that landed in the meantime.
> 

Thanks a lot!

To clarify: did you finally staged the series to send a pull request? Or Stefan should do it? Should I make a v9?

-- 
Best regards,
Vladimir

