Return-Path: <SRS0=2cnN=BD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3310C433E4
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:04:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B98B20663
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2020 10:04:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="hjXot31j"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B98B20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyuZU-0003Ai-Ny
	for qemu-devel@archiver.kernel.org; Fri, 24 Jul 2020 06:04:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40280)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuYq-0002fq-Q6; Fri, 24 Jul 2020 06:04:16 -0400
Received: from mail-am6eur05on2122.outbound.protection.outlook.com
 ([40.107.22.122]:25991 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1jyuYn-0005EZ-Gv; Fri, 24 Jul 2020 06:04:15 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WvKsbeVbhe+nLlYMzw0ai2asSfBFu4aUBgcKqg4IUwQXVj1Lm1cag4U0VQY3d140BYwQ3Zdq8ba0uE3TX0ze2rOU/IEi78B0bQopcKP0XwdNZHQzYBv062o/pGfFfUeck4lJmXLHnItgS8PaERbVWXbkRnpqSkPXGgQNIz+gtZNwBYCSP2BPV9vnG7U37mDTyjNqcCF6zFi3sO5OgrCghAdWBFmJpU9pCJLeiV9QdOli3r1pbNQ5AAzi2sQg6lvDJ4p0aaeBUWG3ZXKJszIHZWSolfP/Rmmd0Wc9gEwmsAXz1MwwTLa3Y5KYt32VPa3TDstd9AEckXYasH3wX6rrDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooTUuqD8cNRfBoa/lsakroKYanpkuF2LYQpJ5VfNe4E=;
 b=Lto5LUMyiMGWEXfc6bil/hNcZ6GnfVm0HQ8VjU02eHP5PfWTdUw8eENcHLvFddg0r+iR6vx5+dp3XybJzoiu0la2sYrWjeSSgEaku3lD+4JQHPKA902wjbmCM2szPiBJoz8RzSWvw6AMmXT7/6oyhEN2NMcx1xOt1OyRGLTv8QwpyOOKbb04UDH8Mo7JSCbxs3T/+PB/vqUq1xpME1TQWCzzSLoocjMClcP+N/PSRUxlBloX5ywM+50DJkKxC2qGNP1c2sY7ypcGDsEKCEUwUpHd3VR/O/U78vBpi4+3si/iH4bqQb1z9peKqZO1v2/JxLxMf1WymodzrswXR1JpGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ooTUuqD8cNRfBoa/lsakroKYanpkuF2LYQpJ5VfNe4E=;
 b=hjXot31jCwL768W91OFimjZCLczUYB2cY6tzfj4vwfM8L/RtiztjZfJQJ9y4gcvf9Z2jxhknjRJhVFfZ6JIYuJbI0vLBeE3WL8Dj4knzvqyC7K7z/u5YAhi7DsMZXiqcrTS1p5x+ZV7xIKeitf28J/W880MIHLRY8T5qNCm/veA=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4849.eurprd08.prod.outlook.com (2603:10a6:20b:c3::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.24; Fri, 24 Jul
 2020 10:04:10 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%4]) with mapi id 15.20.3216.024; Fri, 24 Jul 2020
 10:04:10 +0000
Subject: Re: [PATCH 1/3] block/nbd: allow drain during reconnect attempt
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200720090024.18186-1-vsementsov@virtuozzo.com>
 <20200720090024.18186-2-vsementsov@virtuozzo.com>
 <7211b25e-94b8-de52-a2da-66f480af9a2a@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <12651aec-d179-3e56-51e1-7dae6dbe8681@virtuozzo.com>
Date: Fri, 24 Jul 2020 13:04:08 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <7211b25e-94b8-de52-a2da-66f480af9a2a@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0P190CA0011.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.2] (185.215.60.156) by
 AM0P190CA0011.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:190::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3216.21 via Frontend Transport; Fri, 24 Jul 2020 10:04:09 +0000
X-Originating-IP: [185.215.60.156]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9a7068f6-e6a2-43b9-ca42-08d82fb8e8f8
X-MS-TrafficTypeDiagnostic: AM6PR08MB4849:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB4849F7335615EB58C7270E62C1770@AM6PR08MB4849.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:224;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Iwtk3vEl5ccL8utJQKN3qYBAZuVBvm59rLUIWpTTJddp6zuWA+OoF/yYCFCZ5MvV8cQDEPmFsRAuCdA8dMp0BkkEghDnlxCjOMChKLGPLxjY1ZCfUdE3qf7ZNyzN1hcM5meCVu0poha+1pVuRP2oRHe1r3iFOjupdf9GyVIrOwNyzNqr4H49NpI+dRSjyTEbQCzOh8Zsayg2ON1wmIOWJNeykGVKzgi2nQmIOsr5qyAmlGIKxpIu5IHo55KmcHDEm6wV86Z0nk/tkmoIAhgczLK+22zvX2ipHqX08YCrRDEgsMPPUFuxUe9q2ojRrgfjIA9+K3Kws08nE8rhlhc2ZFpnskNLudRPWmYP7yi5ZnD5vG/Z1cvtnI9VhYGEIe+a
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFTY:;
 SFS:(4636009)(346002)(376002)(366004)(396003)(39840400004)(136003)(8936002)(31686004)(36756003)(5660300002)(66556008)(66476007)(8676002)(66946007)(2906002)(107886003)(52116002)(2616005)(478600001)(186003)(4326008)(53546011)(316002)(26005)(16576012)(6486002)(86362001)(16526019)(956004)(31696002)(83380400001)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: NWkNKTxSWeP+C27WTj2bhjOLpCPJP8zXMjpSGHKOYS8Q3M5xoSayVpysdpDQukQqwE91mLDtMabN8WXKKkZaJyBAEPjY+SdQNHOARWq+S8Lh8rp9+lcIxu7cQUBSQX9CkysATcM36wDCJBrhuTg4E6PW5pYBx7Sud5yXLRYN2gdnG8vKwRkhpTu62PSLhJ808Dg989KuBF5trN7i89Xya7wQ/20WMBXPCKVoyVoiPEeh6uRdvWptw1esi4lsRik6NvVTvkxVzSaTm3DHH2mk9F23xXlProwyZV45dJdOVY0Z7pH4QaPIzJozA4DiAlHCvQk6cUR+gRq3Fhs5NJfNO/rDwV4WB8lhKSj+mPfVVkWq+H7PTgzNWO1ZdbNjXe0tBt8x/eMkhi/pUUJmStWC5fulQaeIB49yl5S6bvLnp64sZk9mf7Png3fdAz1+bHI++5pJfARoBy0sNbEiTVaasI8wTNUinXmSknGW0+iddEH24uxcr5jo541wGP6XCZO8
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a7068f6-e6a2-43b9-ca42-08d82fb8e8f8
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2020 10:04:10.2898 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Na5TrUFY9L+b3fjUCFtsmp6yqxbv+VkH9s5G90ZldI56VAEaIgUqLkxa5EgdxP/cfKQHe/L6EB+CmhM/Wex5jtt/oDi/Tteica9BSdZIBkY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4849
Received-SPF: pass client-ip=40.107.22.122;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/24 06:04:10
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

23.07.2020 21:47, Eric Blake wrote:
> On 7/20/20 4:00 AM, Vladimir Sementsov-Ogievskiy wrote:
>> It should be to reenter qio_channel_yield() on io/channel read/write
>> path, so it's safe to reduce in_flight and allow attaching new aio
>> context. And no problem to allow drain itself: connection attempt is
>> not a guest request. Moreover, if remote server is down, we can hang
>> in negotiation, blocking drain section and provoking a dead lock.
>>
>> How to reproduce the dead lock:
>>
> 
> I tried to reproduce this; but in the several minutes it has taken me to write this email, it still has not hung.  Still, your stack trace is fairly good evidence of the problem, where adding a temporary sleep or running it under gdb with a breakpoint can probably make reproduction easier.
> 
>> 1. Create nbd-fault-injector.conf with the following contents:
>>
>> [inject-error "mega1"]
>> event=data
>> io=readwrite
>> when=before
>>
>> 2. In one terminal run nbd-fault-injector in a loop, like this:
>>
>> n=1; while true; do
>>      echo $n; ((n++));
> 
> Bashism, but not a problem for the commit message.
> 
>>      ./nbd-fault-injector.py 127.0.0.1:10000 nbd-fault-injector.conf;
>> done
>>
>> 3. In another terminal run qemu-io in a loop, like this:
>>
>> n=1; while true; do
>>      echo $n; ((n++));
>>      ./qemu-io -c 'read 0 512' nbd+tcp://127.0.0.1:10000;
> 
> I prefer the spelling nbd:// for TCP connections, but also inconsequential.
> 
>> Note, that the hang may be
>> triggered by another bug, so the whole case is fixed only together with
>> commit "block/nbd: on shutdown terminate connection attempt".
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   block/nbd.c | 11 +++++++++++
>>   1 file changed, 11 insertions(+)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 65a4f56924..49254f1c3c 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -280,7 +280,18 @@ static coroutine_fn void nbd_reconnect_attempt(BDRVNBDState *s)
>>           s->ioc = NULL;
>>       }
>> +    bdrv_dec_in_flight(s->bs);
>>       s->connect_status = nbd_client_connect(s->bs, &local_err);
>> +    s->wait_drained_end = true;
>> +    while (s->drained) {
>> +        /*
>> +         * We may be entered once from nbd_client_attach_aio_context_bh
>> +         * and then from nbd_client_co_drain_end. So here is a loop.
>> +         */
>> +        qemu_coroutine_yield();
>> +    }
>> +    bdrv_inc_in_flight(s->bs);
>> +
> 
> This is very similar to the code in nbd_co_reconnect_loop.  Does that function still need to wait on drained, since it calls nbd_reconnect_attempt which is now doing the same loop?  But off-hand, I'm not seeing a problem with keeping both places.

I want to reduce in_fligth around one operation. And I'm afraid of continuing while drained. So, here is the pattern:

  - allow drain (by decreasing in_flight)
  - do some operation, safe for drained section
  - we afraid that some further operations are unsafe for drained sections, so
    - disallow new drain (by increasing in_fligth)
    - wait for current drain to finish, if any

And, I'm not sure that nbd_read_eof is not buggy: it just do dec/inc in_flight around qio_channel_yield(), so nothing prevents us of continuing some other operations being in drained section. The code in nbd_read_eof was introduced by d3bd5b90890f6715bce..
Is it safe?

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 
> As a bug fix, I'll be including this in my NBD pull request for the next -rc build.
> 


-- 
Best regards,
Vladimir

