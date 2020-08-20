Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3813C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91B9E20658
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 10:32:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="ujr2JWgA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91B9E20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41692 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8hri-00070J-TC
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 06:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48994)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8hqz-0006VY-3s; Thu, 20 Aug 2020 06:31:29 -0400
Received: from mail-am6eur05on2121.outbound.protection.outlook.com
 ([40.107.22.121]:55265 helo=EUR05-AM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@virtuozzo.com>)
 id 1k8hqw-0003pz-Cc; Thu, 20 Aug 2020 06:31:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PV4wMWwQWSBNI9BRYm78haUr4KLgtHqkbRVM8H9tY08fkkEEPw0HSiySm7R8xOshQvRuKekBGDou39WONZc58Mv91074TnINVOGeDe/uMPwyy09z7GRDVbX+s14e0auMP3KfcAbqkdmbBBw7jW66yDv0G44cPsIBAduP3z0+ZxLQPNmG89WCyCucLbVLrvXhUE9hVbyhvK1AToEzz+0pMAsddi+rHUaw4oIlrUpcBGYQfj1qgiA2ou3sMEmG68UJLo1ymrPzvQ8ObQz+mwrkDMV7uPPHzS7h8BFVm+PSqZ0vbRyrG/DzEX2qKx3R9A+KTgsaGeD4kaDscE4NfTzlGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9v+dUDdVcpJEhYfE/cT6dOIJD2GwASdngYT/Y0tndk=;
 b=JE21Ban+ahfGVhr2UmsZdcn6dFJP/+lC1bJLLT46dRD7SWaTRVqFmR01sUctjHHML56Tx0o+oJ8Rl7RyEIeOFNqfvvA53bpRQRaZWvTqyun0yC/aVawr4H2JYRDk+y7cHlIJUOjMRc+xDIKnHHPgwjEzdNx+YwkSt8Z3xb5vLZOgKsHYWGgW8fTcwQah0fdAvhx/ik9ZbbYtHKuAy0Ub/FxYuBsfnswIMDCP0mcZmASgLThR5upza5yCMcg2GOZLpVLASX/MjpcwkCwuwRGxcHmcQQoRA/NJtU+D6hfYIz4QNVgWO04Qx6rUnCbLiGXRT2cPT89ywTGxvLlnOn9OVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T9v+dUDdVcpJEhYfE/cT6dOIJD2GwASdngYT/Y0tndk=;
 b=ujr2JWgAc3uRMGf3BduDxqVICUY1UMHMPqJBjhgH33TqPxWpzNI0g2aq0C4hAYNt0UJEG3ITT+qTXUPRWZFG1KJZbbcybhc7VVoui/Mj1+AoaYa1/m3a2q4uKVhlylQqXa/lLpap8BOYjwmVFKd9PqvGQbV8tjmBs/IqxRRY1kY=
Authentication-Results: openvz.org; dkim=none (message not signed)
 header.d=none;openvz.org; dmarc=none action=none header.from=virtuozzo.com;
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com (2603:10a6:20b:dc::15)
 by AM6PR08MB4280.eurprd08.prod.outlook.com (2603:10a6:20b:b6::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24; Thu, 20 Aug
 2020 10:31:23 +0000
Received: from AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a]) by AM7PR08MB5494.eurprd08.prod.outlook.com
 ([fe80::8c0c:c056:97a5:484a%3]) with mapi id 15.20.3283.027; Thu, 20 Aug 2020
 10:31:23 +0000
Subject: Re: [PATCH v3] block/nbd: use non-blocking connect: fix vm hang on
 connect()
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
References: <20200812145237.4396-1-vsementsov@virtuozzo.com>
 <8e5f317f-e9f5-10a1-839f-27e2a083c933@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <0c4fc05d-7d29-88c1-36c4-7c2687d3b666@virtuozzo.com>
Date: Thu, 20 Aug 2020 13:31:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
In-Reply-To: <8e5f317f-e9f5-10a1-839f-27e2a083c933@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:150::21) To AM7PR08MB5494.eurprd08.prod.outlook.com
 (2603:10a6:20b:dc::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.100.5] (185.215.60.171) by
 AM0PR10CA0041.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:150::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.24 via Frontend
 Transport; Thu, 20 Aug 2020 10:31:23 +0000
X-Originating-IP: [185.215.60.171]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e51681e8-46b5-4ff9-252f-08d844f42fcc
X-MS-TrafficTypeDiagnostic: AM6PR08MB4280:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB42802AB980CB321D4768F4ABC15A0@AM6PR08MB4280.eurprd08.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8gcJaPuZjTCMvYhAbwVyPSu7O+uH37BoVi0XPUMt7fq5RkUlWUlaLaOG0SlOEKhnbbJKy8/3ZvSRNXz1DRU68F2FMBmICziKSrtWMmf9TO04TYQxeo+fed0VcMlQuotZxlmAT/mBj6dewOoONBYVXuJhXRSKQPooRu7Ijd+y3kGhnh+ibov4ip2EN7FLk2EUWf+hF5YGZQcpKxPKfS51Ccoa/syne8X5xY7dwy9BIfwcxRkVQkPiKdtRp2pHgcxNiEcWebRrTpoGG6hAcOvz/Ip3g19vuSoYpPBn2QAKBXCHzxUPW2JRMZCHCVtZAsdPQ+AvRLXfSj5muZ351Kk1UWb9Zor7LblGTS1/KheQiI4mAH8z3qClIi0699b8BARH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM7PR08MB5494.eurprd08.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39840400004)(136003)(346002)(376002)(396003)(366004)(478600001)(31696002)(53546011)(316002)(36756003)(83380400001)(52116002)(2616005)(956004)(5660300002)(86362001)(2906002)(8676002)(8936002)(31686004)(186003)(107886003)(4326008)(16576012)(66476007)(16526019)(6486002)(26005)(66946007)(66556008)(43740500002);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData: EnX8ZFBZGyo+kdHKyPcxAhH01bkczwKIx+bYbqyiOX/7I1M+dQdJWuGa6N0TKZ7HJpDR/+7G3pZU5ljs9FKBxwJ5zCNxsjxujUBq45vhfWmtylNTcoE1wu8F076VAnmeZj8yDlHgrLoV17LwA9SesgXbpI2TK9bhJxvn6OzKNbWni2JNi3LMB3sQigjoo44R1bNuXEyY2LMUORNsSOv4mTaGqu8Qt1F7Ct5JBUnCPwPcMNkUiHQAQsZHCslEOilcBc+Cs+CHWVhy5kgot8R5mWepi3sV9bgYxzY7+2jtqudfQixne5leFGxUXXcQenczfCkGkCKfOTlCTOoA9uvytaefOMeJ/96Zk+bz5b4sPSWe7aYIf/+2Xk2khYNp/aw5B47/rZR12IIRdK3rMZhbTzneG4Dl88lzMRp4TcJCyNQgaLmvVujGs9exKaw4BDtDPOY7XPpL6e8y0xDwWs+yhgIcJQSC5Yw2JtzwEsP9v0l03n3qB8+5/+Jf4+ESTorPqVsGhcvlbRDbIl8n3fF5RKW8+heiCfDcn23aqlb8QeYjCRZZoHcun9S2Qq8Sp33wgPyqa5sBqQOMUXVwHhXfUXzQPVsu6TBldIfodVXwV5YWXyyzBnVIYNK/lVegIc85x/0OFVibMxrJaMvGMGVRvw==
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e51681e8-46b5-4ff9-252f-08d844f42fcc
X-MS-Exchange-CrossTenant-AuthSource: AM7PR08MB5494.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2020 10:31:23.8507 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ev1N2XfJh3xtLsYwF/rLp5vuWtepScqs/4uSPsDCWS/J6zCNMYj2jDYHZ6ycRV+85Mrtvk9+TTJNzGfscrIVKKS1Y5WdHa8/86Zrtmdixlg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4280
Received-SPF: pass client-ip=40.107.22.121;
 envelope-from=vsementsov@virtuozzo.com;
 helo=EUR05-AM6-obe.outbound.protection.outlook.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 06:31:24
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

19.08.2020 20:52, Eric Blake wrote:
> On 8/12/20 9:52 AM, Vladimir Sementsov-Ogievskiy wrote:
>> This make nbd connection_co to yield during reconnects, so that
>> reconnect doesn't hang up the main thread. This is very important in
>> case of unavailable nbd server host: connect() call may take a long
>> time, blocking the main thread (and due to reconnect, it will hang
>> again and again with small gaps of working time during pauses between
>> connection attempts).
>>
> 
>> How to reproduce the bug, fixed with this commit:
>>
>> 1. Create an image on node1:
>>     qemu-img create -f qcow2 xx 100M
>>
>> 2. Start NBD server on node1:
>>     qemu-nbd xx
>>
>> 3. Start vm with second nbd disk on node2, like this:
>>
>>    ./x86_64-softmmu/qemu-system-x86_64 -nodefaults -drive \
>>      file=/work/images/cent7.qcow2 -drive file=nbd+tcp://192.168.100.2 \
>>      -vnc :0 -qmp stdio -m 2G -enable-kvm -vga std
> 
> Where is the configuration to set up retry on the nbd connection?  I wonder if you have a non-upstream patch that turns it on by default in your builds; for upstream, I would have expected something more along the lines of -blockdev driver=nbd,reconnect-delay=20,server.type=inet,server.data.hostname=192.168.100.2,server.data.port=10809 (typing off the top of my head, rather than actually tested).

No, it's not necessary: reconnect is enabled always. reconnect-delay just says what to do with guest requests when connection is down. By default, they just fails immediately. But even with reconnect-delay=0 reconnect code works and tries to reestablish the connection.

> 
>>
>> 4. Access the vm through vnc (or some other way?), and check that NBD
>>     drive works:
>>
>>     dd if=/dev/sdb of=/dev/null bs=1M count=10
>>
>>     - the command should succeed.
>>
>> 5. Now, let's trigger nbd-reconnect loop in Qemu process. For this:
>>
>> 5.1 Kill NBD server on node1
>>
>> 5.2 run "dd if=/dev/sdb of=/dev/null bs=1M count=10" in the guest
>>      again. The command should fail and a lot of error messages about
>>      failing disk may appear as well.
> 
> Why does the guest access fail when the server goes away?  Shouldn't the pending guest requests merely be queued for retry (where the guest has not seen a failure yet, but may do so if timeouts are reached), rather than being instant errors?

And that's exactly how it should work when reconnect-delay is 0. If you set reconnect-delay to be >0, then in this period of time after detection of connection failure all the requests will be queued.

> 
>>
>>      Now NBD client driver in Qemu tries to reconnect.
>>      Still, VM works well.
>>
>> 6. Make node1 unavailable on NBD port, so connect() from node2 will
>>     last for a long time:
>>
>>     On node1 (Note, that 10809 is just a default NBD port):
>>
>>     sudo iptables -A INPUT -p tcp --dport 10809 -j DROP
>>
>>     After some time the guest hangs, and you may check in gdb that Qemu
>>     hangs in connect() call, issued from the main thread. This is the
>>     BUG.
>>
>> 7. Don't forget to drop iptables rule from your node1:
>>
>>     sudo iptables -D INPUT -p tcp --dport 10809 -j DROP
>>
> 


-- 
Best regards,
Vladimir

